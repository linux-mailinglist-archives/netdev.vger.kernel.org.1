Return-Path: <netdev+bounces-258016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nEx4OOGSimlUMAAAu9opvQ
	(envelope-from <netdev+bounces-258016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:07:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 435C9116257
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0432C302B50F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5004F278161;
	Tue, 10 Feb 2026 02:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-3.us.a.mail.aliyun.com (out198-3.us.a.mail.aliyun.com [47.90.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579115624B;
	Tue, 10 Feb 2026 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689244; cv=none; b=WQH8jUgwWr4KCBTQeYlKMvXmLlGitukziF/KcPNUU/5457xx1ofPE4HDRG2PZF6lXJzTFpnyjqH2ohCYjAJxd6+2drLYW6U95ByayHs5d65iSYsVy8noEtUWySpRZH5Gj0ZIyQTyRKnqirDNd/5r0HC18vu3Uh7SuiY638YMY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689244; c=relaxed/simple;
	bh=d1va5f67LxQ4KETMLfVwDpV5Tk/SVUHyF9eb2TlH8bw=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=NItjmMz5S3TGETyCTqi4I2mmgqUe5U5xH6MynBcia+SQ+Twbk3CpXFtakkOMbCZhsm0Ncop1RYukxbR98SoGCHkLTnL+HQVIWcYtkN+f/LU/XXST4SUQkshoovmOw3vMz4gEtQtMMvn5pTu+8amdGvZ2qDW2du0shM6i5+uPAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.073901|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0277738-0.00636233-0.965864;FP=14661280663008586946|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=15;RT=15;SR=0;TI=W4_0.2.3_214495E4_1770688381328_o7001c876;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_214495E4_1770688381328_o7001c876] cluster:ay29) at Tue, 10 Feb 2026 10:07:01 +0800
Date: Tue, 10 Feb 2026 10:07:01 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Sam" <sam.chen@nebula-matrix.com>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "open list" <linux-kernel@vger.kernel.org>,
  "corbet" <corbet@lwn.net>,
  "lorenzo" <lorenzo@kernel.org>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "andrew+netdev" <andrew+netdev@lunn.ch>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "pabeni" <pabeni@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "horms" <horms@kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <8620f8c9-c7ff-427d-bad4-0ed860b998ea.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW3Y0LG5ldC1uZXh0LDExLzExXSBuZXQvbmVidWxhLW1hdHJpeDogYWRkIGNv?=
  =?UTF-8?B?bW1vbiBkZXYgc3RhcnQvc3RvcCBvcGVyYXRpb24=?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260206021608.85381-12-illusion.wang@nebula-matrix.com>,<20260207022504.4018024-1-kuba@kernel.org>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjEwLVJlbGVhc2UuMjYwMjAzMDA3KSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <20260207022504.4018024-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[Illusion.Wang@nebula-matrix.com];
	FROM_NEQ_ENVFROM(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258016-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 435C9116257
X-Rspamd-Action: no action

VGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrCkJ1dAplbnVtIG5ibF9tc2l4X3NlcnZfdHlwZSB7
CgkvKiB2aXJ0aW9fZGV2IGhhcyBhIGNvbmZpZyB2ZWN0b3JfaWQsIGFuZCB0aGUgdmVjdG9yX2lk
IG5lZWQgaXMgMCAqLwoJTkJMX01TSVhfVklSVElPX1RZUEUgPSAwLAoJTkJMX01TSVhfTkVUX1RZ
UEUsCglOQkxfTVNJWF9NQUlMQk9YX1RZUEUsCglOQkxfTVNJWF9UWVBFX01BWAp9OwpOQkxfTVNJ
WF9ORVRfVFlQRSBlcXVhbHMgMe+8jHNvIHRoaXMgZnVuY3Rpb24gaGFzIG5vIHByb2JsZW3vvJ8K
Ci0taWxsdXNpb24ud2FuZwoKPiArc3RhdGljIGludCBuYmxfZGV2X2NvbmZpZ3VyZV9tc2l4X21h
cChzdHJ1Y3QgbmJsX2Rldl9tZ3QgKmRldl9tZ3QpCj4gK3sKPiArIHN0cnVjdCBuYmxfZGlzcGF0
Y2hfb3BzICpkaXNwX29wcyA9IGRldl9tZ3QtPmRpc3Bfb3BzX3RibC0+b3BzOwo+ICsgc3RydWN0
IG5ibF9kZXZfY29tbW9uICpkZXZfY29tbW9uID0gZGV2X21ndC0+Y29tbW9uX2RldjsKPiArIHN0
cnVjdCBuYmxfbXNpeF9pbmZvICptc2l4X2luZm8gPSAmZGV2X2NvbW1vbi0+bXNpeF9pbmZvOwo+
ICsgYm9vbCBtYXNrX2VuID0gbXNpeF9pbmZvLT5zZXJ2X2luZm9bTkJMX01TSVhfTkVUX1RZUEVd
Lmh3X3NlbGZfbWFza19lbjsKPiArIHUxNiBtc2l4X25ldF9udW0gPSBtc2l4X2luZm8tPnNlcnZf
aW5mb1tOQkxfTVNJWF9ORVRfVFlQRV0ubnVtOwo+ICsgdTE2IG1zaXhfbm90X25ldF9udW0gPSAw
Owo+ICsgaW50IGVyciwgaTsKPiArCj4gKyBmb3IgKGkgPSBOQkxfTVNJWF9ORVRfVFlQRTsgaSA8
IE5CTF9NU0lYX1RZUEVfTUFYOyBpKyspCj4gK8KgIG1zaXhfaW5mby0+c2Vydl9pbmZvW2ldLmJh
c2VfdmVjdG9yX2lkID0KPiArIMKgIG1zaXhfaW5mby0+c2Vydl9pbmZvW2kgLSAxXS5iYXNlX3Zl
Y3Rvcl9pZCArCj4gKyDCoCBtc2l4X2luZm8tPnNlcnZfaW5mb1tpIC0gMV0ubnVtOwogwqAgwqAg
wqAgwqAgwqAgwqAgXl5eXl5eCgpEb2VzIHRoaXMgbG9vcCBjYXVzZSBhbiBhcnJheSB1bmRlcmZs
b3c/IE5CTF9NU0lYX05FVF9UWVBFIGVxdWFscyAwIChmcm9tCnRoZSBlbnVtIGluIG5ibF9kZXYu
aCksIHNvIG9uIHRoZSBmaXJzdCBpdGVyYXRpb24gaT0wIGFuZCB0aGUgY29kZSBhY2Nlc3Nlcwpz
ZXJ2X2luZm9bLTFdLgoKVGhlIHNlcnZfaW5mbyBhcnJheSBpcyBkZWNsYXJlZCB3aXRoIE5CTF9N
U0lYX1RZUEVfTUFYICgyKSBlbGVtZW50cyBpbgpzdHJ1Y3QgbmJsX21zaXhfaW5mbywgZ2l2aW5n
IHZhbGlkIGluZGljZXMgWzAsMV0uIEFjY2Vzc2luZyBpbmRleCAtMSByZWFkcwp1bmluaXRpYWxp
emVkIG1lbW9yeSBiZWZvcmUgdGhlIGFycmF5IHN0YXJ0LgoKQ2FsbCBjaGFpbjogbmJsX2NvcmVf
c3RhcnQoKS0+bmJsX2Rldl9zdGFydCgpLT5uYmxfZGV2X3N0YXJ0X2NvbW1vbl9kZXYoKQotPm5i
bF9kZXZfY29uZmlndXJlX21zaXhfbWFwKCkgZ3VhcmFudGVlcyB0aGlzIG9jY3VycyBkdXJpbmcg
ZGV2aWNlIHN0YXJ0LgoKU2hvdWxkIHRoZSBsb29wIHN0YXJ0IGF0IGk9MSAoTkJMX01TSVhfTUFJ
TEJPWF9UWVBFKSBpbnN0ZWFkLCBvciBzaG91bGQKc2Vydl9pbmZvWzBdLmJhc2VfdmVjdG9yX2lk
IGJlIGluaXRpYWxpemVkIGJlZm9yZSB0aGUgbG9vcD8KCj4gKwo+ICsgZm9yIChpID0gTkJMX01T
SVhfTUFJTEJPWF9UWVBFOyBpIDwgTkJMX01TSVhfVFlQRV9NQVg7IGkrKykgewoKWyAuLi4gXQoK
ClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhpcyBvdXQhIFVwb24gcmV2aWV3aW5nIHRoZSBjb2Rl
IGFnYWluLCBJIGJlbGlldmUKdGhlIHZhcmlhYmxlIGRlY2xhcmF0aW9ucyBpbiBuYmxfZGV2X3Jl
cXVlc3RfbWFpbGJveF9pcnEoKSBhbHJlYWR5IGZvbGxvdwp0aGUgcmV2ZXJzZSBDaHJpc3RtYXMg
dHJlZSBjb252ZW50aW9uOgoKZGV2X2NvbW1vbiAobG9uZ2VzdCBpZGVudGlmaWVyKSBpcyBkZWNs
YXJlZCBmaXJzdCwgYXMgaXQgaXMgcmVxdWlyZWQgZm9yCnN1YnNlcXVlbnQgZGVjbGFyYXRpb25z
LgoKVGhlIHJlbWFpbmluZyB2YXJpYWJsZXMgKG1zaXhfaW5mbyBhbmQgY29tbW9uKSBhcmUgb3Jk
ZXJlZCBieSBkZWNyZWFzaW5nIApkZW50aWZpZXIgbGVuZ3RoLCBhbGlnbmluZyB3aXRoIHRoZSBz
dHlsZSBndWlkZS4KSG93ZXZlciwgSSBhcHByZWNpYXRlIHRoZSBjbGFyaWZpY2F0aW9uIG9wcG9y
dHVuaXR54oCUaWYgdGhlcmXigJlzIGEgbnVhbmNlCknigJltIG1pc3NpbmcgKGUuZy4sIHN0cmlj
dGVyIGFkaGVyZW5jZSB0byBpZGVudGlmaWVyIGxlbmd0aCBvdmVyIGRlcGVuZGVuY3kKb3JkZXIp
LCBJ4oCZZCBiZSBoYXBweSB0byBhZGp1c3QgdGhlIGNvZGUgYWNjb3JkaW5nbHkuY3JlYXNpbmcg
aWRlbnRpZmllcgpsZW5ndGgsIGFsaWduaW5nIHdpdGggdGhlIHN0eWxlIGd1aWRlLgoKLS0taWxs
dXNpb24ud2FuZwoKCkFuZHJldyBMdW5uIGFsc28gbm90ZWQgaW4gdjMgdGhhdCB2YXJpYWJsZSBk
ZWNsYXJhdGlvbnMgc2hvdWxkIGZvbGxvdwpyZXZlcnNlIENocmlzdG1hcyB0cmVlIG9yZGVyaW5n
IChsb25nZXN0IGxpbmUgZmlyc3QpLiBMb29raW5nIGF0IGZ1bmN0aW9ucwppbiB0aGlzIGNvbW1p
dCBsaWtlIG5ibF9kZXZfcmVxdWVzdF9tYWlsYm94X2lycSgpOgoKIHN0cnVjdCBuYmxfZGV2X2Nv
bW1vbiAqZGV2X2NvbW1vbiA9IGRldl9tZ3QtPmNvbW1vbl9kZXY7CiBzdHJ1Y3QgbmJsX21zaXhf
aW5mbyAqbXNpeF9pbmZvID0gJmRldl9jb21tb24tPm1zaXhfaW5mbzsKIHN0cnVjdCBuYmxfY29t
bW9uX2luZm8gKmNvbW1vbiA9IGRldl9tZ3QtPmNvbW1vbjsKCnRoZSBkZWNsYXJhdGlvbnMgYXJl
IG5vdCBpbiByZXZlcnNlIENocmlzdG1hcyB0cmVlIG9yZGVyLgoKTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbmV0ZGV2L2M2ZDM3ZWNkLTdkYzYtNGY4My1iNzZjLTI3MzVhNWYxMTZmZEBs
dW5uLmNoLwoK

