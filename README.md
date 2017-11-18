# Deep Multitask Metric Learning for Offline Signature Verification</p>
<p>This is the MATLAB code for "Deep Multitask Metric Learning for Offline Signature Verification", a paper published in Pattern Recognition Letters</p>
<p>To become familiar with the structure of the code, you should look at the paper:<br /><a href="http://www.sciencedirect.com/science/article/pii/S0167865516301076">A Soleimani, Amir, Babak N. Araabi, and Kazim Fouladi. "Deep multitask metric learning for offline signature verification." Pattern Recognition Letters, 2016</a></p>
<p style="text-align: center;"><strong><img src="https://aa52ab98-a-62cb3a1a-s-sites.googlegroups.com/site/amirsoleimanibajestani/research/Capture.PNG?attachauth=ANoY7cpvZa9TLrPdfSyx7Ksg2JJO7G7Ycm3nJKQE0W02lzkKaG--kS4r1kaQ3aFJEtFGJZ6e5RItW68hTgKOHXm0jsJufkhyHX82ahjTJ7saT01geBjO4rPIzmUnPITADbawjWIJoRnyVABuc5vVktK-5REts6J8Nj26h2pHLp_5iBu48OXEDUkNV39QDEFfg1v4xIEbcUK4E62V0S954fMaLZune7b0unLY8wK3uwrkKMfk2rm8jmA%3D&amp;attredirects=0" alt="" width="855" height="339" /></strong></p>
<p><strong>Abstract:&nbsp;</strong></p>
<p>&nbsp;This paper presents a novel classification method, Deep Multitask Metric Learning (DMML), for offline signature verification. Unlike existing methods that to verify questioned signatures of an individual merely consider the training samples of that class, DMML uses the knowledge from the similarities and dissimilarities between the genuine and forged samples of other classes too. To this end, using the idea of multitask and transfer learning, DMML train a distance metric for each class together with other classes simultaneously. DMML has a structure with a shared layer acting as a writer-independent approach, that is followed by separated layers which learn writer-dependent factors. We compare the proposed method against SVM, writer-dependent and writer-independent Discriminative Deep Metric Learning method on four offline signature datasets (UTSig, MCYT-75, GPDSsynthetic, and GPDS960GraySignatures) using Histogram of Oriented Gradients (HOG) and Discrete Radon Transform (DRT) features. Results of our experiments show that DMML achieves better performance compared to other methods in verifying genuine signatures, skilled and random forgeries.</p>
<p><strong>Dataset:&nbsp;</strong><strong>UTSig (University of Tehran Offline Signature Dataset)</strong></p>
<p><strong><img src="http://mlcm.ut.ac.ir/Images/SignatureLogo.png" alt="" width="746" height="172" /></strong></p>
<p>UTSig has 115 classes containing: 27 genuine signatures; 3 opposite-hand signed samples and 42 simple forgeries. Each class belongs to one specific authentic person. UTSig totally has 8280 images collected from undergraduate and graduate students of University of Tehran and Sharif University of Technology. Signatures were scanned with 600 dpi resolution and stored as 8-bit Tiff files.</p>
<p><a href="http://ieeexplore.ieee.org/document/7791523/">Dataset Paper</a></p>
<p>To download the dataset go to:&nbsp;https://sites.google.com/site/amirsoleimanibajestani/publication</p>
<p><strong>Code</strong></p>
<p>This code mainly runs DMML on Feature Extracted Version of UTSig, Histogram of Gradient (HOG) which is uploaded in github as well.</p>
<p>Main.m is the main file to run. It trains and tests on UTSig.</p>

<p>Before running download the feature vector and put it in the folder: https://drive.google.com/open?id=14UfQg3nyDwig6aojtDhQCDqyOc5PSszk
</p>

<p>Read comments for further information.<br />Feel free to email me for the questions: a.soleimani.b@gmail.com</p>
