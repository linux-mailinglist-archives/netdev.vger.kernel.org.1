Return-Path: <netdev+bounces-268017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDE6GNRqt2kYRAEAu9opvQ
	(envelope-from <netdev+bounces-268017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:28:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6329407C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A4E300A108
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFFF30C619;
	Mon, 16 Mar 2026 02:28:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E230C615;
	Mon, 16 Mar 2026 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773628113; cv=none; b=X02tnxlx0uKs+s16fVBkBEbfjQas2tytRP6vaT6nPX0L/fWVqD8gm9+ne5/JOhR0vaa66rcFxjGIxeRT5EjJMo4vY8b+Y8wFNaPio18KEE0ciLj0qsaA4aMe0V8Pu2RwU09Q51VPUJHH7kfAH2w4sFZ+nfoZPTAzTR/hXV+Nijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773628113; c=relaxed/simple;
	bh=wopb9QsPa7P/JWgcvtaaSnzChT3xfQhigeHBlGhYFyk=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=LBeBioacdYu8vVh7WYJiRt4FGRHWD+2JWAM8h8/W8fCJ5EsQKichniZ0hAUejobE0Btwog+sbwCMOpmSy9NjHfsFTFtosyTuJvHfW2xqL3kDc/978GpszxYo3fRBcGMoFXbaV4IaynJCqnoMFhZbY8SJhSgt+6wksnJQgCemGLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c9977c5220df11f1a21c59e7364eecb8-20260316
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:25a04ee6-3e07-45f9-b141-2e1828f85d6f,IP:0,U
	RL:0,TC:43,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:38
X-CID-META: VersionHash:89c9d04,CLOUDID:0fd506deb41839d2e23affda9be81709,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102|898,TC:4,Content:0|14|51,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: 61436DE720E982EA81CA0428C1F5C8F5
X-UUID: c9977c5220df11f1a21c59e7364eecb8-20260316
Received: from node3 [(10.44.17.99)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1392464827; Mon, 16 Mar 2026 10:28:15 +0800
Received: from node3 (localhost [127.0.0.1])
	by node3 (NSMail) with SMTP id 98E93B046F79;
	Mon, 16 Mar 2026 10:28:15 +0800 (CST)
Received: by node3 (NSMail, from userid 10001)
	id 906C2B046F79; Mon, 16 Mar 2026 10:28:15 +0800 (CST)
From: =?UTF-8?B?5L2V5pWP57qi?= <heminhong@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIIG5ldCB2Ml0gaXB2Njogc3I6IEFkZCBOVUxMIGNoZWNrIGZvciBpZGV2IGluIHNlZzZfaG1hY192YWxpZGF0ZV9za2I=?=
To: =?UTF-8?B?QW5kcmVhIE1heWVy?= <andrea.mayer@uniroma2.it>
Cc: =?UTF-8?B?ZWR1bWF6ZXQ=?= <edumazet@google.com>,
	=?UTF-8?B?ZGF2ZW0=?= <davem@davemloft.net>,
	=?UTF-8?B?ZGF2aWQubGVicnVu?= <david.lebrun@uclouvain.be>,
	=?UTF-8?B?ZHNhaGVybg==?= <dsahern@kernel.org>,
	=?UTF-8?B?aG9ybXM=?= <horms@kernel.org>,
	=?UTF-8?B?a3ViYQ==?= <kuba@kernel.org>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?bmV0ZGV2?= <netdev@vger.kernel.org>,
	=?UTF-8?B?cGFiZW5p?= <pabeni@redhat.com>,
	=?UTF-8?B?c3RlZmFuby5zYWxzYW5v?= <stefano.salsano@uniroma2.it>,
	=?UTF-8?B?QW5kcmVhIE1heWVy?= <andrea.mayer@uniroma2.it>
Date: Mon, 16 Mar 2026 10:28:15 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <45nke5g9cnlj-45nppkcu29o8@nsmail8.2--kylin--1>
References: 20260314234940.5dd74e5e508bc915eb0b4cb8@uniroma2.it
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Mon, 16 Mar 2026 10:28:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-47wjk2w7ypa2-47wlon991qwr
X-ns-mid: webmail-69b76abf-46d5ntkh
X-ope-from: <heminhong@kylinos.cn>
X-receipt: 0
X-Spamd-Result: default: False [2.84 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_HTML_ONLY(0.20)[];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268017-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heminhong@kylinos.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.527];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,nsmail8.2--kylin--1:mid]
X-Rspamd-Queue-Id: 94F6329407C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This message is in MIME format.

--nsmail-47wjk2w7ypa2-47wlon991qwr
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+Jm5ic3A7PC9wPgo8cD5Tb3JyeSwgSSBkb24ndCBoYXZlIG9u
ZSBhdCB0aGUgbW9tZW50OyBJIGp1c3QgaWRlbnRpZmllZCB0aGlzIGRlZmVj
dCB3aGlsZSBhbmFseXppbmcgdGhlIGNvZGUuPC9wPgo8ZGl2IGlkPSJzaWdu
YXR1cmVUb3AiPjwvZGl2Pgo8ZGl2IGlkPSJjczJjX3JlIiBzdHlsZT0ibWFy
Z2luLWxlZnQ6IDAuNWVtOyBwYWRkaW5nLWxlZnQ6IDAuNWVtOyBib3JkZXIt
bGVmdDogMXB4IHNvbGlkICNjYWNhY2E7IC13ZWJraXQtdXNlci1tb2RpZnk6
IHJlYWQtb25seTsgLW1vei11c2VyLW1vZGlmeTogcmVhZC1vbmx5OyAtbXMt
dXNlci1tb2RpZnk6IHJlYWQtb25seTsgLW8tdXNlci1tb2RpZnk6IHJlYWQt
b25seTsiPjxicj48YnI+PGJyPgo8ZGl2IHN0eWxlPSJiYWNrZ3JvdW5kLWNv
bG9yOiAjZjhmOGY4OyBwYWRkaW5nOiA4cHggMTBweDsgZm9udC1mYW1pbHk6
IE1pY3Jvc29mdCBZYUhlaTsgZm9udC1zaXplOiAxNHB4OyBjb2xvcjogIzAw
MDsiPjxzdHJvbmc+5Li7Jm5ic3A7Jm5ic3A7Jm5ic3A76aKY77yaPC9zdHJv
bmc+PHNwYW4gaWQ9ImNzMmNfc3ViamVjdCI+UmU6IFtQQVRDSCBuZXQgdjJd
IGlwdjY6IHNyOiBBZGQgTlVMTCBjaGVjayBmb3IgaWRldiBpbiBzZWc2X2ht
YWNfdmFsaWRhdGVfc2tiPC9zcGFuPiA8YnI+PHN0cm9uZz7ml6UmbmJzcDsm
bmJzcDsmbmJzcDvmnJ/vvJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY19kYXRl
Ij4yMDI25bm0MDPmnIgxNeaXpTA2OjQ5PC9zcGFuPiA8YnI+PHN0cm9uZz7l
j5Hku7bkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY19mcm9tIj5BbmRy
ZWEgTWF5ZXI8L3NwYW4+IDxicj48c3Ryb25nPuaUtuS7tuS6uu+8mjwvc3Ry
b25nPjxzcGFuIGlkPSJjczJjX3RvIiBzdHlsZT0id29yZC1icmVhazogYnJl
YWstYWxsOyI+QW5kcmVhIE1heWVyPC9zcGFuPiA8YnI+PHN0cm9uZz7mioTp
gIHkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY190byIgc3R5bGU9Indv
cmQtYnJlYWs6IGJyZWFrLWFsbDsiPmVkdW1hemV0LGRhdmVtLGRhdmlkLmxl
YnJ1bixkc2FoZXJuLGhvcm1zLGt1YmEsbGludXgta2VybmVsLG5ldGRldixw
YWJlbmksc3RlZmFuby5zYWxzYW5vLEFuZHJlYSBNYXllcjwvc3Bhbj48L2Rp
dj4KPGJyPgo8ZGl2IGlkPSJjczJjX2NvbnRlbnQiPk9uIEZyaSwgMTMgTWFy
IDIwMjYgMTA6MjY6MzQgKzA4MDAgTWluaG9uZyBIZSAmbHQ7aGVtaW5ob25n
QGt5bGlub3MuY24mZ3Q7IHdyb3RlOiAmZ3Q7IEluIHNlZzZfaG1hY192YWxp
ZGF0ZV9za2IoKSwgdGhlIHBvaW50ZXIgcmV0dXJuZWQgYnkgX19pbjZfZGV2
X2dldCgpICZndDsgY2FuIGJlIE5VTEwgaWYgdGhlIG5ldHdvcmsgZGV2aWNl
IGxhY2tzIHByb3BlciBJUHY2IGluaXRpYWxpemF0aW9uICZndDsgb3IgaXMg
YmVpbmcgdG9ybiBkb3duLiBBZGQgYSBOVUxMIGNoZWNrIHRvIGF2b2lkIHBv
dGVudGlhbCBOVUxMIHBvaW50ZXIgJmd0OyBkZXJlZmVyZW5jZSBpbiBzdWJz
ZXF1ZW50IGNvZGUuICZndDsgJmd0OyBGaXhlczogYmYzNTViOGQyYzMwICgi
aXB2Njogc3I6IGFkZCBjb3JlIGZpbGVzIGZvciBTUiBITUFDIHN1cHBvcnQi
KSAmZ3Q7IFNpZ25lZC1vZmYtYnk6IE1pbmhvbmcgSGUgJmx0O2hlbWluaG9u
Z0BreWxpbm9zLmNuJmd0OyAmZ3Q7IC0tLSAmZ3Q7IG5ldC9pcHY2L3NlZzZf
aG1hYy5jIHwgMiArKyAmZ3Q7IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykgJmd0OyBIaSBNaW5ob25nLCBEbyB5b3UgaGF2ZSBhIGNyYXNoIGxv
ZyBvciBhIHdheSB0byByZXByb2R1Y2UgdGhpcz8gVGhhbmtzLCBBbmRyZWEg
Jmd0OyBkaWZmIC0tZ2l0IGEvbmV0L2lwdjYvc2VnNl9obWFjLmMgYi9uZXQv
aXB2Ni9zZWc2X2htYWMuYyAmZ3Q7IGluZGV4IGVlNmJhYzAxNjBhYy4uZTY5
NjRjNmIwZDM4IDEwMDY0NCAmZ3Q7IC0tLSBhL25ldC9pcHY2L3NlZzZfaG1h
Yy5jICZndDsgKysrIGIvbmV0L2lwdjYvc2VnNl9obWFjLmMgJmd0OyBAQCAt
MTg0LDYgKzE4NCw4IEBAIGJvb2wgc2VnNl9obWFjX3ZhbGlkYXRlX3NrYihz
dHJ1Y3Qgc2tfYnVmZiAqc2tiKSAmZ3Q7IGludCByZXF1aXJlX2htYWM7ICZn
dDsgJmd0OyBpZGV2ID0gX19pbjZfZGV2X2dldChza2ItJmd0O2Rldik7ICZn
dDsgKyBpZiAoIWlkZXYpICZndDsgKyByZXR1cm4gZmFsc2U7ICZndDsgJmd0
OyBzcmggPSAoc3RydWN0IGlwdjZfc3JfaGRyICopc2tiX3RyYW5zcG9ydF9o
ZWFkZXIoc2tiKTsgJmd0OyAmZ3Q7IC0tICZndDsgMi4yNS4xICZndDsgJmx0
Oy9oZW1pbmhvbmdAa3lsaW5vcy5jbiZndDsmbHQ7L2hlbWluaG9uZ0BreWxp
bm9zLmNuJmd0OzwvZGl2Pgo8L2Rpdj4KPHA+Jm5ic3A7PC9wPgo8cD4mbmJz
cDs8L3A+CjxkaXYgaWQ9InNpZ25hdHVyZUJvbSI+CjxkaXY+CjxwPiZuYnNw
OzwvcD4KPGJyPgo8cCBzdHlsZT0iY29sb3I6ICMwMDA7IGZvbnQtc2l6ZTog
MTZweDsiPi0tLTwvcD4KPGRpdiBpZD0iY3MyY19tYWlsX3NpZ2F0dXJlIiBz
dHlsZT0iY29sb3I6ICMwMDA7IGZvbnQtc2l6ZTogMTZweDsgZm9udC1mYW1p
bHk6IE1pY3Jvc29mdCBZYUhlaTsiPjwvZGl2Pgo8cD4mbmJzcDs8L3A+Cjwv
ZGl2Pgo8L2Rpdj48L2Rpdj4=

--nsmail-47wjk2w7ypa2-47wlon991qwr--

