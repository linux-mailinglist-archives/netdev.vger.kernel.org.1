Return-Path: <netdev+bounces-252236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB3TK2LacWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:05:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2246762D61
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A97F85011D6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE8324B2A;
	Thu, 22 Jan 2026 07:57:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from hrbeu.edu.cn (mx1.hrbeu.edu.cn [202.118.176.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAF53469E3;
	Thu, 22 Jan 2026 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.118.176.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068659; cv=none; b=UAhJ9ybcfQd4s/NXamITHX0OB+hLUh1AuOp3yAUmus/LSH0IEouJ3twiSm4/SgHlrDmN9ZZEzN2C6VrRX477YlSZgB3UDkqUCg3ll9AUZK5DGnxKsRwSo52Jk9vVZSayivI4V3IgNfZOuSyANLyAmxj+KKBi9pxu3FOYcktksiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068659; c=relaxed/simple;
	bh=QiW6ianH0X+a0Xgzua8SAD0qO4W3OumN2xnk8zkR1Fg=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=uBD9NahFxn3hEpzBmeXQ7xPev47SKTWiHBFHUu+xRjeFLRyLxfrbfitNW8/WlRTxqtHkDlUEGJqf6luHd0A73I4gUNMKx1XiX3Lz4GsFIO54aH7Mer6oKaucOmvwTgZebfzmF7eVs8AaeYxGuQuQvchRksZntndo9VEStiDYTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hrbeu.edu.cn; spf=pass smtp.mailfrom=hrbeu.edu.cn; arc=none smtp.client-ip=202.118.176.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hrbeu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hrbeu.edu.cn
Received: from baishuoran$hrbeu.edu.cn ( [118.74.28.54] ) by
 ajax-webmail-Front (Coremail) ; Thu, 22 Jan 2026 15:56:43 +0800 (GMT+08:00)
Date: Thu, 22 Jan 2026 15:56:43 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>
To: "David S. Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>
Cc: "Kun Hu" <huk23@m.fudan.edu.cn>, "Jiaji Qin" <jjtan24@m.fudan.edu.cn>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Subject: hung task in rtnl_newlink
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT5 build
 20250609(354f7833) Copyright (c) 2002-2026 www.mailtech.cn hrbeu.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <39db9ec8.c5b0.19be4b4a8d5.Coremail.baishuoran@hrbeu.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:CbB2ygCnMso72HFpFRcNAQ--.28728W
X-CM-SenderInfo: pedl2xpxrut0w6kuuvvxohv3gofq/1tbiAQIPCmlxgDsC-gAAsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252236-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[hrbeu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baishuoran@hrbeu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hrbeu.edu.cn:mid,hrbeu.edu.cn:email,fudan.edu.cn:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 2246762D61
X-Rspamd-Action: no action

RGVhciBNYWludGFpbmVycywKCgpXaGVuIHVzaW5nIG91ciBjdXN0b21pemVkIFN5emthbGxlciB0
byBmdXp6IHRoZSBsYXRlc3QgTGludXgga2VybmVsLCB0aGUgZm9sbG93aW5nIGNyYXNoIHdhcyB0
cmlnZ2VyZWQuCgoKSEVBRCBjb21taXQ6IDY1MzdjZmIzOTVmMzUyNzgyOTE4ZDhlZTdiN2YxMGJh
MmNjM2NiZjIKZ2l0IHRyZWU6IHVwc3RyZWFtCk91dHB1dDpodHRwczpodHRwczovL2dpdGh1Yi5j
b20vcGdoazEzL0tlcm5lbC1CdWcvYmxvYi9tYWluLzA3MDJfNi4xNC85JTIwaHVuZyUyMHRhc2sl
MjBpbiUyMHJ0bmxfbmV3bGluay9yZXBvcnQ5LnR4dApLZXJuZWwgY29uZmlnOiBodHRwczovL2dp
dGh1Yi5jb20vcGdoazEzL0tlcm5lbC1CdWcvYmxvYi9tYWluLzAyMTlfNi4xM3JjN190b2RvL2Nv
bmZpZy50eHQgCkMgcmVwcm9kdWNlcjpodHRwczovL2dpdGh1Yi5jb20vcGdoazEzL0tlcm5lbC1C
dWcvYmxvYi9tYWluLzA3MDJfNi4xNC85JTIwaHVuZyUyMHRhc2slMjBpbiUyMHJ0bmxfbmV3bGlu
ay85cmVwcm8udHh0ClN5emxhbmcgcmVwcm9kdWNlcjogaHR0cHM6Ly9naXRodWIuY29tL3BnaGsx
My9LZXJuZWwtQnVnL2Jsb2IvbWFpbi8wNzAyXzYuMTQvOSUyMGh1bmclMjB0YXNrJTIwaW4lMjBy
dG5sX25ld2xpbmsvOXJlcHJvLmMKClRoZSBodW5nLXRhc2sgaXMgcHJpbWFyaWx5IGFzc29jaWF0
ZWQgd2l0aCB0aGUgbGlua3dhdGNoIHdvcmtxdWV1ZSBjYWxsYmFjay4gU3BlY2lmaWNhbGx5LCBs
aW5rd2F0Y2hfZXZlbnQoKSBwcm9jZXNzZXMgYmF0Y2hlcyBvZiBkZXZpY2VzIHdoaWxlIGhvbGRp
bmcgUlROTCAocnRubF9sb2NrKCkpLCBkdXJpbmcgd2hpY2ggaXQgcmVwZWF0ZWRseSBpbnZva2Vz
IGxpbmt3YXRjaF9kb19kZXYoKSBhbmQgZnVydGhlciBjYWxscyBwYXRocyBzdWNoIGFzIGRldl9h
Y3RpdmF0ZSgpLCBkZXZfZGVhY3RpdmF0ZSgpLCBhbmQgbmV0ZGV2X3N0YXRlX2NoYW5nZSgpLCB3
aGljaCBtYXkgaW52b2x2ZSByZWxhdGl2ZWx5IHRpbWUtY29uc3VtaW5nIG9yIGJsb2NraW5nIG9w
ZXJhdGlvbnMgKGxpbmtfd2F0Y2guYzoyODXigJMyODcsIDE5NOKAkzI1NCwgMTY24oCTMTg3KS4g
QXQgdGhlIHNhbWUgdGltZSwgbWVzc2FnZXMgc2VudCBmcm9tIHVzZXJzcGFjZSB2aWEgc2VuZG1z
ZyBlbnRlciB0aGUga2VybmVsIHN5bmNocm9ub3VzbHkgdGhyb3VnaCBuZXRsaW5rX3VuaWNhc3Rf
a2VybmVsKCkgaW4gYWZfbmV0bGluay5jIChhZl9uZXRsaW5rLmM6MTMxMikgYW5kIGFyZSBoYW5k
bGVkIGluIHRoZSBwcm90b2NvbCBjYWxsYmFjayBpbnZva2VkIGZyb20gbmV0bGlua19yY3Zfc2ti
KCkgKGFmX25ldGxpbmsuYzoyNTMzKS4gQXMgYSByZXN1bHQsIHdoZW4gUlROTCBpcyBoZWxkIGJ5
IGxpbmt3YXRjaCBmb3IgYW4gZXh0ZW5kZWQgcGVyaW9kLCBhIGxhcmdlIG51bWJlciBvZiBydG5l
dGxpbmsgcmVxdWVzdHMgbWF5IGJsb2NrIHdoaWxlIGF0dGVtcHRpbmcgdG8gYWNxdWlyZSBSVE5M
LCBlbnRlciB0aGUgRCBzdGF0ZSwgYW5kIGV2ZW50dWFsbHkgdHJpZ2dlciBodW5nLXRhc2sgcmVw
b3J0cy4KV2UgaGF2ZSByZXByb2R1Y2VkIHRoaXMgaXNzdWUgc2V2ZXJhbCB0aW1lcyBvbiA2LjE5
LXJjNCBhZ2Fpbi4KCgpJZiB5b3UgZml4IHRoaXMgaXNzdWUsIHBsZWFzZSBhZGQgdGhlIGZvbGxv
d2luZyB0YWcgdG8gdGhlIGNvbW1pdDoKUmVwb3J0ZWQtYnk6IEt1biBIdSA8aHVrMjNAbS5mdWRh
bi5lZHUuY24+LCBKaWFqaSBRaW4gPGpqdGFuMjRAbS5mdWRhbi5lZHUuY24+LCBTaHVvcmFuIEJh
aSA8YmFpc2h1b3JhbkBocmJldS5lZHUuY24+CgoKClsgIDU3OS4yNDAxNTldWyAgIFQ0Nl0gIDwv
VEFTSz4KWyAgNTc5LjI0MTEzM11bICAgVDQ2XSBJTkZPOiB0YXNrIHN5ei1leGVjdXRvcjoxMDY5
MCBibG9ja2VkIGZvciBtb3JlIHRoYW4gMTgzIHNlY29uZHMuClsgIDU3OS4yNDM0ODZdWyAgIFQ0
Nl0gICAgICAgTm90IHRhaW50ZWQgNi4xOS4wLXJjNCAjMQpbICA1NzkuMjQ1MDQ1XVsgICBUNDZd
ICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2Fi
bGVzIHRoaXMgbWVzc2FnZS4KWyAgNTc5LjI0Nzc3Nl1bICAgVDQ2XSB0YXNrOnN5ei1leGVjdXRv
ciAgICBzdGF0ZTpEIHN0YWNrOjExMjk2IHBpZDoxMDY5MCB0Z2lkOjEwNjkwIHBwaWQ6MSAgICAg
IHRhc2tfZmxhZ3M6MHg0MDAxNDAgZmxhZ3M6MHgwMDA4MDAwMgpbICA1NzkuMjUxMzk0XVsgICBU
NDZdIENhbGwgVHJhY2U6ClsgIDU3OS4yNTI0NDNdWyAgIFQ0Nl0gIDxUQVNLPgpbICA1NzkuMjUz
MzcxXVsgICBUNDZdICBfX3NjaGVkdWxlKzB4ZTYyLzB4MWZhMApbICA1NzkuMjU0NzkxXVsgICBU
NDZdICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1ClsgIDU3OS4yNTY2NjZd
WyAgIFQ0Nl0gID8gc2NoZWR1bGUrMHhiNi8weGUwClsgIDU3OS4yNTgwNjNdWyAgIFQ0Nl0gIHNj
aGVkdWxlKzB4MzQvMHhlMApbICA1NzkuMjU5MzY4XVsgICBUNDZdICBzY2hlZHVsZV9wcmVlbXB0
X2Rpc2FibGVkKzB4Zi8weDIwClsgIDU3OS4yNjExMDFdWyAgIFQ0Nl0gIF9fbXV0ZXhfbG9jaysw
eDgxMC8weDEyNDAKWyAgNTc5LjI2MjYwM11bICAgVDQ2XSAgPyBfX3Nhbml0aXplcl9jb3ZfdHJh
Y2VfcGMrMHgxYy8weDUwClsgIDU3OS4yNjQzNDFdWyAgIFQ0Nl0gID8gc3Jzb19hbGlhc19yZXR1
cm5fdGh1bmsrMHg1LzB4ZmJlZjUKWyAgNTc5LjI2NjE1M11bICAgVDQ2XSAgPyBydG5sX25ld2xp
bmsrMHg0Y2IvMHg3NjAKWyAgNTc5LjI2NzYzOV1bICAgVDQ2XSAgPyBzcnNvX2FsaWFzX3JldHVy
bl90aHVuaysweDUvMHhmYmVmNQpbICA1NzkuMjY5NTkwXVsgICBUNDZdICA/IHJ0bmxfbmV3bGlu
aysweDRjYi8weDc2MApbICA1NzkuMjcxMDcwXVsgICBUNDZdICBydG5sX25ld2xpbmsrMHg0Y2Iv
MHg3NjAKWyAgNTc5LjI3MjUxNl1bICAgVDQ2XSAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysw
eDUvMHhmYmVmNQpbICA1NzkuMjc0MjgwXVsgICBUNDZdICA/IHNyc29fYWxpYXNfcmV0dXJuX3Ro
dW5rKzB4NS8weGZiZWY1ClsgIDU3OS4yNzYxNzhdWyAgIFQ0Nl0gID8gc3Jzb19hbGlhc19yZXR1
cm5fdGh1bmsrMHg1LzB4ZmJlZjUKWyAgNTc5LjI3NzkxOV1bICAgVDQ2XSAgPyBfX3BmeF9ydG5s
X25ld2xpbmsrMHgxMC8weDEwClsgIDU3OS4yNzk0ODhdWyAgIFQ0Nl0gIHJ0bmV0bGlua19yY3Zf
bXNnKzB4NmFmLzB4YWUwClsgIDU3OS4yODEwMjNdWyAgIFQ0Nl0gID8gc3Jzb19hbGlhc19yZXR1
cm5fdGh1bmsrMHg1LzB4ZmJlZjUKWyAgNTc5LjI4Mjc1NF1bICAgVDQ2XSAgPyBfX3Nhbml0aXpl
cl9jb3ZfdHJhY2VfcGMrMHgxYy8weDUwClsgIDU3OS4yODQ1MDZdWyAgIFQ0Nl0gID8gc3Jzb19h
bGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUKWyAgNTc5LjI4NjM0Nl1bICAgVDQ2XSAgPyBy
ZWZfdHJhY2tlcl9mcmVlKzB4MTU3LzB4MmUwClsgIDU3OS4yODc5NThdWyAgIFQ0Nl0gID8gc3Jz
b19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUKWyAgNTc5LjI4OTc3N11bICAgVDQ2XSAg
bmV0bGlua19yY3Zfc2tiKzB4N2QvMHgxYzAKWyAgNTc5LjI5MTI3MF1bICAgVDQ2XSAgPyBfX3Bm
eF9ydG5ldGxpbmtfcmN2X21zZysweDEwLzB4MTAKWyAgNTc5LjI5MzAwM11bICAgVDQ2XSAgbmV0
bGlua191bmljYXN0KzB4MmJjLzB4M2QwClsgIDU3OS4yOTQ1NTVdWyAgIFQ0Nl0gID8gc3Jzb19h
bGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUKWyAgNTc5LjI5NjQyNV1bICAgVDQ2XSAgbmV0
bGlua19zZW5kbXNnKzB4MzQwLzB4NjkwClsgIDU3OS4yOTgwMTBdWyAgIFQ0Nl0gIF9fc29ja19z
ZW5kbXNnKzB4MTFiLzB4MTMwClsgIDU3OS4yOTk1MDVdWyAgIFQ0Nl0gIF9fc3lzX3NlbmR0bysw
eDE4ZC8weDIxMApbICA1NzkuMzAxMDQ1XVsgICBUNDZdICA/IHNyc29fYWxpYXNfcmV0dXJuX3Ro
dW5rKzB4NS8weGZiZWY1ClsgIDU3OS4zMDI3NzddWyAgIFQ0Nl0gID8geGZkX3ZhbGlkYXRlX3N0
YXRlKzB4M2IvMHhlMApbICA1NzkuMzA0MzkyXVsgICBUNDZdICA/IHNyc29fYWxpYXNfcmV0dXJu
X3RodW5rKzB4NS8weGZiZWY1ClsgIDU3OS4zMDYyMjVdWyAgIFQ0Nl0gID8gX19zYW5pdGl6ZXJf
Y292X3RyYWNlX3BjKzB4MWMvMHg1MApbICA1NzkuMzA3OTc5XVsgICBUNDZdICA/IHNyc29fYWxp
YXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1ClsgIDU3OS4zMDk3MjBdWyAgIFQ0Nl0gID8gd3Jp
dGVfY29tcF9kYXRhKzB4MjkvMHg4MApbICA1NzkuMzExMjI4XVsgICBUNDZdICBfX3g2NF9zeXNf
c2VuZHRvKzB4MjYvMHgzMApbICA1NzkuMzEyNzI2XVsgICBUNDZdICBkb19zeXNjYWxsXzY0KzB4
YzMvMHgxMWUwClsgIDU3OS4zMTQyMzNdWyAgIFQ0Nl0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDc3LzB4N2YKWyAgNTc5LjMxNjE3Nl1bICAgVDQ2XSBSSVA6IDAwMzM6MHg3Zjk0
N2JkMWVlMDQKWyAgNTc5LjMxNzU2MV1bICAgVDQ2XSBSU1A6IDAwMmI6MDAwMDdmZmNhMjgzZDA2
MCBFRkxBR1M6IDAwMDAwMjkzIE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDJjClsgIDU3OS4zMjAx
MjddWyAgIFQ0Nl0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDdmOTQ3Y2FkNDYyMCBS
Q1g6IDAwMDA3Zjk0N2JkMWVlMDQKWyAgNTc5LjMyMjUwM11bICAgVDQ2XSBSRFg6IDAwMDAwMDAw
MDAwMDAwMmMgUlNJOiAwMDAwN2Y5NDdjYWQ0NjcwIFJESTogMDAwMDAwMDAwMDAwMDAwMwpbICA1
NzkuMzI0OTI1XVsgICBUNDZdIFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDA3ZmZjYTI4
M2QwYmMgUjA5OiAwMDAwMDAwMDAwMDAwMDBjClsgIDU3OS4zMjc0MTBdWyAgIFQ0Nl0gUjEwOiAw
MDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDI5MyBSMTI6IDAwMDAwMDAwMDAwMDAw
Cgp0aGFua3MsCkt1biBIdQo=

