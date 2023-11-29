Return-Path: <netdev+bounces-51986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD47FCD7F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABAE281E21
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC324414;
	Wed, 29 Nov 2023 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127219A4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:29:33 -0800 (PST)
X-UUID: 5627e9db9a7c467f84aea61f1d9a765c-20231129
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:1e06157a-06d6-4635-bd02-a6a0a02fdef5,IP:15,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-25
X-CID-INFO: VERSION:1.1.33,REQID:1e06157a-06d6-4635-bd02-a6a0a02fdef5,IP:15,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:fb6eee95-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:231129112926RMDIQ198,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:0,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 5627e9db9a7c467f84aea61f1d9a765c-20231129
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 52688265; Wed, 29 Nov 2023 11:29:23 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 19B5A16001CC8;
	Wed, 29 Nov 2023 11:29:23 +0800 (CST)
Received: by node4.com.cn (NSMail, from userid 0)
	id 0EFF416001CC8; Wed, 29 Nov 2023 11:29:23 +0800 (CST)
From: =?UTF-8?B?5L2V5pWP57qi?= <heminhong@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTog5Zue5aSNOiBSZTogW1BBVENIXSBpcHJvdXRlMjogcHJldmVudCBtZW1vcnkgbGVhayBvbiBlcnJvciByZXR1cm4=?=
To: 	=?UTF-8?B?U3RlcGhlbiBIZW1taW5nZXI=?= <stephen@networkplumber.org>,
Cc: 	=?UTF-8?B?UGV0ciBNYWNoYXRh?= <petrm@nvidia.com>,
	=?UTF-8?B?bmV0ZGV2?= <netdev@vger.kernel.org>,
Date: Wed, 29 Nov 2023 11:29:22 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <1nkdhqz7po5-1nkg1mm1tbq@nsmail7.0.0--kylin--1>
References: 20231128184733.6fc8247e@hermes.local
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Wed, 29 Nov 2023 11:29:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-1ujg29zg7g8-1ujim5mab3t
X-ns-mid: webmail-6566b012-1ubolk0w
X-ope-from: <heminhong@kylinos.cn>

This message is in MIME format.

--nsmail-1ujg29zg7g8-1ujim5mab3t
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+VGhpcyBpcyBhbm90aGVyIHBhdGNoLCZuYnNwOyBpcGxpbmsuYyBoYXMg
YmVlbiBtb2RpZmllZC48L3A+CjxwPiZuYnNwOzwvcD4KPHA+RnJvbSAyYTUz
MmRlODIxNjVmZTAxMzIzYWVmNDAyYWYzNDMxNWFjZTI5Y2FhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMTwvcD4KPHA+RnJvbTogaGVtaW5ob25nICZsdDto
ZW1pbmhvbmdAa3lsaW5vcy5jbiZndDs8L3A+CjxwPkRhdGU6IFR1ZSwgMTQg
Tm92IDIwMjMgMTU6NTE6MTcgKzA4MDA8L3A+CjxwPlN1YmplY3Q6IFtQQVRD
SF0gaXByb3V0ZTI6IHByZXZlbnQgbWVtb3J5IGxlYWsgb24gZXJyb3IgcmV0
dXJuPC9wPgo8cD4mbmJzcDs8L3A+CjxwPldoZW4gcnRubF9zdGF0c2R1bXBf
cmVxX2ZpbHRlcigpIG9yIHJ0bmxfZHVtcF9maWx0ZXIoKSBmYWlsZWQgdG8g
cHJvY2Vzcyw8L3A+CjxwPmp1c3QgcmV0dXJuIHdpbGwgY2F1c2UgbWVtb3J5
IGxlYWsuPC9wPgo8cD4mbmJzcDs8L3A+CjxwPlNpZ25lZC1vZmYtYnk6IGhl
bWluaG9uZyAmbHQ7aGVtaW5ob25nQGt5bGlub3MuY24mZ3Q7PC9wPgo8cD4t
LS08L3A+CjxwPiZuYnNwO2lwL2lwbGluay5jIHwgMiArKzwvcD4KPHA+Jm5i
c3A7MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKTwvcD4KPHA+Jm5i
c3A7PC9wPgo8cD5kaWZmIC0tZ2l0IGEvaXAvaXBsaW5rLmMgYi9pcC9pcGxp
bmsuYzwvcD4KPHA+aW5kZXggOWE1NDhkZDMuLmM3ZTUwMjFjIDEwMDY0NDwv
cD4KPHA+LS0tIGEvaXAvaXBsaW5rLmM8L3A+CjxwPisrKyBiL2lwL2lwbGlu
ay5jPC9wPgo8cD5AQCAtMTcyMiwxMSArMTcyMiwxMyBAQCBzdGF0aWMgaW50
IGlwbGlua19hZnN0YXRzKGludCBhcmdjLCBjaGFyICoqYXJndik8L3A+Cjxw
PiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTogcHJlOyI+IDwvc3Bh
bj5pZiAocnRubF9zdGF0c2R1bXBfcmVxX2ZpbHRlcigmYW1wO3J0aCwgQUZf
VU5TUEVDLCBmaWx0X21hc2ssPC9wPgo8cD4mbmJzcDs8c3BhbiBzdHlsZT0i
d2hpdGUtc3BhY2U6IHByZTsiPiA8L3NwYW4+Jm5ic3A7ICZuYnNwOyAmbmJz
cDsgTlVMTCwgTlVMTCkgJmx0OyAwKSB7PC9wPgo8cD4mbmJzcDs8c3BhbiBz
dHlsZT0id2hpdGUtc3BhY2U6IHByZTsiPiA8L3NwYW4+cGVycm9yKCJDYW5u
b250IHNlbmQgZHVtcCByZXF1ZXN0Iik7PC9wPgo8cD4rPHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOiBwcmU7Ij4gPC9zcGFuPmRlbGV0ZV9qc29uX29iaigp
OzwvcD4KPHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOiBwcmU7
Ij4gPC9zcGFuPnJldHVybiAxOzwvcD4KPHA+Jm5ic3A7PHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOiBwcmU7Ij4gPC9zcGFuPn08L3A+CjxwPiZuYnNwOzwv
cD4KPHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOiBwcmU7Ij4g
PC9zcGFuPmlmIChydG5sX2R1bXBfZmlsdGVyKCZhbXA7cnRoLCBwcmludF9h
Zl9zdGF0cywgJmFtcDtjdHgpICZsdDsgMCkgezwvcD4KPHA+Jm5ic3A7PHNw
YW4gc3R5bGU9IndoaXRlLXNwYWNlOiBwcmU7Ij4gPC9zcGFuPmZwcmludGYo
c3RkZXJyLCAiRHVtcCB0ZXJtaW5hdGVkXG4iKTs8L3A+CjxwPis8c3BhbiBz
dHlsZT0id2hpdGUtc3BhY2U6IHByZTsiPiA8L3NwYW4+ZGVsZXRlX2pzb25f
b2JqKCk7PC9wPgo8cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6
IHByZTsiPiA8L3NwYW4+cmV0dXJuIDE7PC9wPgo8cD4mbmJzcDs8c3BhbiBz
dHlsZT0id2hpdGUtc3BhY2U6IHByZTsiPiA8L3NwYW4+fTwvcD4KPHA+Jm5i
c3A7PC9wPgo8cD4tLSZuYnNwOzwvcD4KPHA+Mi4yNS4xPC9wPgo8cD4mbmJz
cDs8L3A+CjxwPjxicj48YnI+PGJyPi0tLS08L3A+CjxkaXYgaWQ9ImNzMmNf
bWFpbF9zaWdhdHVyZSI+PC9kaXY+CjxwPiZuYnNwOzwvcD4KPGRpdiBpZD0i
cmUiIHN0eWxlPSJtYXJnaW4tbGVmdDogMC41ZW07IHBhZGRpbmctbGVmdDog
MC41ZW07IGJvcmRlci1sZWZ0OiAxcHggc29saWQgZ3JlZW47Ij48YnI+PGJy
Pjxicj4KPGRpdiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogI2Y1ZjdmYTsi
PjxzdHJvbmc+5Li744CA6aKY77yaPC9zdHJvbmc+PHNwYW4gaWQ9InN1Ympl
Y3QiPlJlOiDlm57lpI06IFJlOiBbUEFUQ0hdIGlwcm91dGUyOiBwcmV2ZW50
IG1lbW9yeSBsZWFrIG9uIGVycm9yIHJldHVybjwvc3Bhbj4gPGJyPjxzdHJv
bmc+5pel44CA5pyf77yaPC9zdHJvbmc+PHNwYW4gaWQ9ImRhdGUiPjIwMjMt
MTEtMjkgMTA6NDc8L3NwYW4+IDxicj48c3Ryb25nPuWPkeS7tuS6uu+8mjwv
c3Ryb25nPjxzcGFuIGlkPSJmcm9tIj5TdGVwaGVuIEhlbW1pbmdlcjwvc3Bh
bj4gPGJyPjxzdHJvbmc+5pS25Lu25Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9
InRvIiBzdHlsZT0id29yZC1icmVhazogYnJlYWstYWxsOyI+5L2V5pWP57qi
Ozwvc3Bhbj48L2Rpdj4KPGJyPgo8ZGl2IGlkPSJjb250ZW50Ij4KPGRpdiBj
bGFzcz0idmlld2VyX3BhcnQiIHN0eWxlPSJwb3NpdGlvbjogcmVsYXRpdmU7
Ij4KPGRpdj5PbiBXZWQsIDI5IE5vdiAyMDIzIDEwOjI2OjM3ICswODAwPGJy
PuS9leaVj+e6oiB3cm90ZTo8YnI+PGJyPiZndDsgRnJpZW5kbHkgcGluZy4g
SSB0aGluayB0aGlzIHBhdGNoIHdhcyBmb3Jnb3R0ZW4uPGJyPiZndDsgPGJy
PiZndDsgPGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgPGJy
PiZndDsgLS0tLTxicj4mZ3Q7IDxicj4mZ3Q7ICZuYnNwOzxicj4mZ3Q7IDxi
cj4mZ3Q7IDxicj4mZ3Q7IDxicj4mZ3Q7IOS4u+OAgOmimO+8mlJlOiBbUEFU
Q0hdIGlwcm91dGUyOiBwcmV2ZW50IG1lbW9yeSBsZWFrIG9uIGVycm9yIHJl
dHVybjxicj4mZ3Q7IOaXpeOAgOacn++8mjIwMjMtMTEtMTUgMTg6Mzc8YnI+
Jmd0OyDlj5Hku7bkurrvvJpQZXRyIE1hY2hhdGE8YnI+Jmd0OyDmlLbku7bk
urrvvJrkvZXmlY/nuqI7PGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgaGVt
aW5ob25nIHdyaXRlczo8YnI+Jmd0OyA8YnI+Jmd0OyAmZ3Q7IOOAgjxicj4m
Z3Q7ICZndDs8YnI+Jmd0OyAmZ3Q7IFNpZ25lZC1vZmYtYnk6IGhlbWluaG9u
Zzxicj4mZ3Q7IDxicj4mZ3Q7IFJldmlld2VkLWJ5OiBQZXRyIE1hY2hhdGE8
YnI+Jmd0OyA8YnI+PGJyPlBsZWFzZSBjaGVjayB5b3VyIHJlcG8/PGJyPjxi
cj5odHRwczovL2dpdGh1Yi5jb20vaXByb3V0ZTIvaXByb3V0ZTIvY29tbWl0
LzJjM2ViYjJhZTA4YTYzNDYxNWU1NjMwM2Q3ODRkZGIzNjZlNDdmMDQ8L2Rp
dj4KPC9kaXY+CjwvZGl2Pgo8L2Rpdj4=

--nsmail-1ujg29zg7g8-1ujim5mab3t--

