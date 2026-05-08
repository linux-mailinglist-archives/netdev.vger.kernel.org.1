Return-Path: <netdev+bounces-285630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 47UxI3pt/Wk5eAAAu9opvQ
	(envelope-from <netdev+bounces-285630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:58:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD90E4F1CA3
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F148630177A0
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B5329367;
	Fri,  8 May 2026 04:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-5.us.a.mail.aliyun.com (out198-5.us.a.mail.aliyun.com [47.90.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389354739;
	Fri,  8 May 2026 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778216310; cv=none; b=Dva50mbjorDGRdbGTXe0urtf1wT65kusV9R55q7xD9xRAoSR9Bag3AXqXKW6WA3IVy+zr05Wt9pdOZlpEeflv7G3ayA3RT+XQHyoaEtjB0oqQNxRW1oayVfgBpeAdMo6QvaTcGVu3+NNrk4ic8BFPbNn+MtCTNfIsX0hMXlEbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778216310; c=relaxed/simple;
	bh=MIY4X6+eDl2vLj+cBbJdnYOABxvvH7P36flRuXUugRo=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=TWs6Y2eS0Rqy5CGsYolBQ08674J7gzseKlSkhPU+Gc7h0ecsrTYKKb735D3+ETsCgxRU2Sxdh6qiNXtVWCvA96xyYTJONmND6mcY/dttBqM47n4ippBfIii/8X56UNTDbMqj6civCo3I4vFR4irprORahD4kDklcI8pgRWYXUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06769155|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0788031-0.000895225-0.920302;FP=7154949378225501504|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=18;RT=18;SR=0;TI=W4_0.2.3_0B53043C_1778215666632_o7001c101k;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_0B53043C_1778215666632_o7001c101k] cluster:ay29) at Fri, 08 May 2026 12:52:39 +0800
Date: Fri, 08 May 2026 12:52:39 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Paolo Abeni" <pabeni@redhat.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>
Cc: "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "lorenzo" <lorenzo@kernel.org>,
  "horms" <horms@kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "enelsonmoore" <enelsonmoore@gmail.com>,
  "skhan" <skhan@linuxfoundation.org>,
  "hkallweit1" <hkallweit1@gmail.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <b240b971-81b8-4325-80b6-5352e1515f07.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYxMyBuZXQtbmV4dCAwMy8xMV0gbmV0L25lYnVsYS1tYXRyaXg6?=
  =?UTF-8?B?IGFkZCBjaGlwIHJlbGF0ZWQgZGVmaW5pdGlvbnM=?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260428114910.2616-1-illusion.wang@nebula-matrix.com> <20260428114910.2616-4-illusion.wang@nebula-matrix.com>,<e41adaad-8937-4b5d-bdbf-d57d3efe2855@redhat.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4zLjE1LVJlbGVhc2UuMjYwNDI0MDA0KSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <e41adaad-8937-4b5d-bdbf-d57d3efe2855@redhat.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: CD90E4F1CA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-285630-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[nebula-matrix.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:mid,nebula-matrix.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[Illusion.Wang@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,linux.dev,redhat.com,google.com,gmail.com,linuxfoundation.org];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Wy4uLl0KPj4gK3ZvaWQgbmJsX3dyaXRlX2FsbF9yZWdzKHN0cnVjdCBuYmxfaHdfbWd0ICpod19t
Z3QpCj4+ICt7Cj4+ICsgc3RydWN0IG5ibF9jb21tb25faW5mbyAqY29tbW9uID0gaHdfbWd0LT4+
Y29tbW9uOwo+PiArIHU4IGV0aF9tb2RlID0gY29tbW9uLT4+ZXRoX21vZGU7Cj4+ICsgY29uc3Qg
dTMyICpuYmxfc2VjMDQ2X2RhdGE7Cj4+ICsgY29uc3QgdTMyICpuYmxfc2VjMDcxX2RhdGE7Cj4+
ICsgdTMyIGk7Cj4+ICsKPj4gKyBzd2l0Y2ggKGV0aF9tb2RlKSB7Cj4+ICsgY2FzZSAxOgo+PiAr
wqAgbmJsX3NlYzA0Nl9kYXRhID0gbmJsX3NlYzA0Nl8xcF9kYXRhOwo+PiArwqAgbmJsX3NlYzA3
MV9kYXRhID0gbmJsX3NlYzA3MV8xcF9kYXRhOwo+PiArwqAgYnJlYWs7Cj4+ICsgY2FzZSAyOgo+
PiArwqAgbmJsX3NlYzA0Nl9kYXRhID0gbmJsX3NlYzA0Nl8ycF9kYXRhOwo+PiArwqAgbmJsX3Nl
YzA3MV9kYXRhID0gbmJsX3NlYzA3MV8ycF9kYXRhOwo+PiArwqAgYnJlYWs7Cj4+ICsgY2FzZSA0
Ogo+PiArwqAgbmJsX3NlYzA0Nl9kYXRhID0gbmJsX3NlYzA0Nl80cF9kYXRhOwo+PiArwqAgbmJs
X3NlYzA3MV9kYXRhID0gbmJsX3NlYzA3MV80cF9kYXRhOwo+PiArwqAgYnJlYWs7Cj4+ICsgZGVm
YXVsdDoKPj4gK8KgIG5ibF9zZWMwNDZfZGF0YSA9IG5ibF9zZWMwNDZfMnBfZGF0YTsKPj4gK8Kg
IG5ibF9zZWMwNzFfZGF0YSA9IG5ibF9zZWMwNzFfMnBfZGF0YTsKPj4gKyB9Cj4+ICsKPj4gKyBu
YmxfZmx1c2hfd3JpdGVzKGh3X21ndCk7Cj4+ICsgZm9yIChpID0gMDsgaSA8IE5CTF9TRUMwMDZf
U0laRTsgaSsrKSB7Cj4+ICvCoCBpZiAoKGkgKyAxKSAlIE5CTF9TRUNfQkxPQ0tfU0laRSA9PSAw
KQo+PiArIMKgIG5ibF9od19yZDMyKGh3X21ndCwgTkJMX0hXX0RVTU1ZX1JFRyk7Cj4+ICsKPj4g
K8KgIG5ibF9od193cjMyKGh3X21ndCwgTkJMX1NFQzAwNl9SRUdJKGkpLCBuYmxfc2VjMDA2X2Rh
dGFbaV0pOwo+PiArIH0KPj4gKwo+PiArIG5ibF9mbHVzaF93cml0ZXMoaHdfbWd0KTsKPj4gKyBm
b3IgKGkgPSAwOyBpIDwgTkJMX1NFQzAwN19TSVpFOyBpKyspCj4+ICvCoCBuYmxfaHdfd3IzMiho
d19tZ3QsIE5CTF9TRUMwMDdfUkVHSShpKSwgbmJsX3NlYzAwN19kYXRhW2ldKTsKPj4gKwo+PiAr
IG5ibF9mbHVzaF93cml0ZXMoaHdfbWd0KTsKPj4gKyBmb3IgKGkgPSAwOyBpIDwgTkJMX1NFQzAw
OF9TSVpFOyBpKyspIHsKPj4gK8KgIGlmICgoaSArIDEpICUgTkJMX1NFQ19CTE9DS19TSVpFID09
IDApCj4+ICsgwqAgbmJsX2h3X3JkMzIoaHdfbWd0LCBOQkxfSFdfRFVNTVlfUkVHKTsKPj4gKwo+
PiArwqAgbmJsX2h3X3dyMzIoaHdfbWd0LCBOQkxfU0VDMDA4X1JFR0koaSksIG5ibF9zZWMwMDhf
ZGF0YVtpXSk7Cj4+ICsgfQo+PiArCj4+ICsgbmJsX2ZsdXNoX3dyaXRlcyhod19tZ3QpOwo+PiAr
IGZvciAoaSA9IDA7IGkgPCBOQkxfU0VDMDA5X1NJWkU7IGkrKykgewo+PiArwqAgaWYgKChpICsg
MSkgJSBOQkxfU0VDX0JMT0NLX1NJWkUgPT0gMCkKPj4gKyDCoCBuYmxfaHdfcmQzMihod19tZ3Qs
IE5CTF9IV19EVU1NWV9SRUcpOwo+PiArCj4+ICvCoCBuYmxfaHdfd3IzMihod19tZ3QsIE5CTF9T
RUMwMDlfUkVHSShpKSwgbmJsX3NlYzAwOV9kYXRhW2ldKTsKPj4gKyB9Cj4+ICsKPj4gKyBuYmxf
Zmx1c2hfd3JpdGVzKGh3X21ndCk7Cj4+ICsgZm9yIChpID0gMDsgaSA8IE5CTF9TRUMwMTBfU0la
RTsgaSsrKQo+PiArwqAgbmJsX2h3X3dyMzIoaHdfbWd0LCBOQkxfU0VDMDEwX1JFR0koaSksIG5i
bF9zZWMwMTBfZGF0YVtpXSk7Cj4+ICsKPj4gKyBuYmxfZmx1c2hfd3JpdGVzKGh3X21ndCk7Cj4+
ICsgZm9yIChpID0gMDsgaSA8IE5CTF9TRUMwMTFfU0laRTsgaSsrKSB7Cj4+ICvCoCBpZiAoKGkg
KyAxKSAlIE5CTF9TRUNfQkxPQ0tfU0laRSA9PSAwKQo+PiArIMKgIG5ibF9od19yZDMyKGh3X21n
dCwgTkJMX0hXX0RVTU1ZX1JFRyk7Cj4+ICsKPj4gK8KgIG5ibF9od193cjMyKGh3X21ndCwgTkJM
X1NFQzAxMV9SRUdJKGkpLCBuYmxfc2VjMDExX2RhdGFbaV0pOwo+PiArIH0KPj4gKwo+PiArIG5i
bF9mbHVzaF93cml0ZXMoaHdfbWd0KTsKPj4gKyBmb3IgKGkgPSAwOyBpIDwgTkJMX1NFQzAxMl9T
SVpFOyBpKyspCj4+ICvCoCBuYmxfaHdfd3IzMihod19tZ3QsIE5CTF9TRUMwMTJfUkVHSShpKSwg
bmJsX3NlYzAxMl9kYXRhW2ldKTsKPj4gKwo+PiArIG5ibF9mbHVzaF93cml0ZXMoaHdfbWd0KTsK
Pj4gKyBmb3IgKGkgPSAwOyBpIDwgTkJMX1NFQzAxM19TSVpFOyBpKyspCj4+ICvCoCBuYmxfaHdf
d3IzMihod19tZ3QsIE5CTF9TRUMwMTNfUkVHSShpKSwgbmJsX3NlYzAxM19kYXRhW2ldKTsKPj4g
Kwo+PiArIG5ibF9mbHVzaF93cml0ZXMoaHdfbWd0KTsKPj4gKyBmb3IgKGkgPSAwOyBpIDwgTkJM
X1NFQzAxNF9TSVpFOyBpKyspCj4+ICvCoCBuYmxfaHdfd3IzMihod19tZ3QsIE5CTF9TRUMwMTRf
UkVHSShpKSwgbmJsX3NlYzAxNF9kYXRhW2ldKTsKPj4gKwo+PiArIG5ibF9mbHVzaF93cml0ZXMo
aHdfbWd0KTsKPj4gKyBmb3IgKGkgPSAwOyBpIDwgTkJMX1NFQzAyMl9TSVpFOyBpKyspCj4+ICvC
oCBuYmxfaHdfd3IzMihod19tZ3QsIE5CTF9TRUMwMjJfUkVHSShpKSwgbmJsX3NlYzAyMl9kYXRh
W2ldKTsKPj4gKwo+PiArIG5ibF9mbHVzaF93cml0ZXMoaHdfbWd0KTsKPj4gKyBmb3IgKGkgPSAw
OyBpIDwgTkJMX1NFQzAyM19TSVpFOyBpKyspCj4+ICvCoCBuYmxfaHdfd3IzMihod19tZ3QsIE5C
TF9TRUMwMjNfUkVHSShpKSwgbmJsX3NlYzAyM19kYXRhW2ldKTsKPj4gKwo+PiArIG5ibF9mbHVz
aF93cml0ZXMoaHdfbWd0KTsKPj4gKyBmb3IgKGkgPSAwOyBpIDwgTkJMX1NFQzAyNF9TSVpFOyBp
KyspIHsKPj4gK8KgIGlmICgoaSArIDEpICUgTkJMX1NFQ19CTE9DS19TSVpFID09IDApCj4+ICsg
wqAgbmJsX2h3X3JkMzIoaHdfbWd0LCBOQkxfSFdfRFVNTVlfUkVHKTsKPj4gKwo+PiArwqAgbmJs
X2h3X3dyMzIoaHdfbWd0LCBOQkxfU0VDMDI0X1JFR0koaSksIG5ibF9zZWMwMjRfZGF0YVtpXSk7
Cj4+ICsgfQo+PiArCj4+ICsgbmJsX2ZsdXNoX3dyaXRlcyhod19tZ3QpOwo+PiArIGZvciAoaSA9
IDA7IGkgPCBOQkxfU0VDMDI1X1NJWkU7IGkrKykgewo+PiArwqAgaWYgKChpICsgMSkgJSBOQkxf
U0VDX0JMT0NLX1NJWkUgPT0gMCkKPj4gKyDCoCBuYmxfaHdfcmQzMihod19tZ3QsIE5CTF9IV19E
VU1NWV9SRUcpOwo+PiArCj4+ICvCoCBuYmxfaHdfd3IzMihod19tZ3QsIE5CTF9TRUMwMjVfUkVH
SShpKSwgbmJsX3NlYzAyNV9kYXRhW2ldKTsKPj4gKyB9Cj4+ICsKPj4gKyBuYmxfZmx1c2hfd3Jp
dGVzKGh3X21ndCk7Cj4+ICsgZm9yIChpID0gMDsgaSA8IE5CTF9TRUMwMjZfU0laRTsgaSsrKQo+
PiArwqAgbmJsX2h3X3dyMzIoaHdfbWd0LCBOQkxfU0VDMDI2X1JFR0koaSksIG5ibF9zZWMwMjZf
ZGF0YVtpXSk7Cj4+ICsKPj4gKyBuYmxfZmx1c2hfd3JpdGVzKGh3X21ndCk7Cj4+ICsgZm9yIChp
ID0gMDsgaSA8IE5CTF9TRUMwMjdfU0laRTsgaSsrKSB7Cj4+ICvCoCBpZiAoKGkgKyAxKSAlIE5C
TF9TRUNfQkxPQ0tfU0laRSA9PSAwKQo+PiArIMKgIG5ibF9od19yZDMyKGh3X21ndCwgTkJMX0hX
X0RVTU1ZX1JFRyk7Cj4+ICsKPj4gK8KgIG5ibF9od193cjMyKGh3X21ndCwgTkJMX1NFQzAyN19S
RUdJKGkpLCBuYmxfc2VjMDI3X2RhdGFbaV0pOwoKPlNhc2hpa28gc2F5czoKCj5Db3VsZCB0aGlz
IGxvb3AgcmVhZCBwYXN0IHRoZSBlbmQgb2YgdGhlIG5ibF9zZWMwMDlfZGF0YSBhcnJheT8KPlRo
ZSBtYWNybyBOQkxfU0VDMDA5X1NJWkUgaXMgZGVmaW5lZCBhcyAyMDQ4LCBidXQgdGhlIG5ibF9z
ZWMwMDlfZGF0YSBhcnJheQo+Y29udGFpbnMgc2lnbmlmaWNhbnRseSBmZXdlciBlbGVtZW50cyAo
YXJvdW5kIDc1NCkuIFRoaXMgYXBwZWFycyB0byBjYXVzZQo+c2VxdWVudGlhbCBvdXQtb2YtYm91
bmRzIHJlYWRzIGludG8gdGhlIC5yb2RhdGEgc2VjdGlvbiwgd3JpdGluZyB1bnJlbGF0ZWQKPm1l
bW9yeSB0byB0aGUgZGV2aWNlIHJlZ2lzdGVycy4KPlNpbWlsYXIgc2l6ZSBtaXNtYXRjaGVzIGV4
aXN0IGZvciBuYmxfc2VjMDI1X2RhdGEgKDI2MiBlbGVtZW50cyB2cyBzaXplCj4xMDI0KQo+YW5k
IG5ibF9zZWMwMjJfZGF0YSAoNTA2IGVsZW1lbnRzIHZzIHNpemUgMjU2KS4KPldvdWxkIGl0IGJl
IHNhZmVyIHRvIHVzZSBBUlJBWV9TSVpFKCkgdG8gYm91bmQgdGhlc2UgaXRlcmF0aW9ucz8KCkJ1
dCBJIHByaW50ZWQgb3V0IHRoZSByZXN1bHRzOiAKQVJSQVlfU0laRShuYmxfc2VjMDA5X2RhdGEp
IGVxdWFscyBOQkxfU0VDMDA5X1NJWkUsCkFSUkFZX1NJWkUobmJsX3NlYzAyNV9kYXRhKSBlcXVh
bHMgTkJMX1NFQzAyNV9TSVpFLAphbmQgQVJSQVlfU0laRShuYmxfc2VjMDIyX2RhdGEpIGVxdWFs
cyBOQkxfU0VDMDIyX1NJWkUuCgpJcyB0aGUgQUkgbWFraW5nIGEgbWlzdGFrZSBoZXJlPwo=

