Return-Path: <netdev+bounces-182308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B89A8875C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74C4188CC7E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446BB27A134;
	Mon, 14 Apr 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="maMGq3ye"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89427A111;
	Mon, 14 Apr 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644426; cv=none; b=ABK68NiU7rBaLhb1NXaEZ/q30JFypyPdLgcUolLa897R2e9jG3xBVEPCrevR8VOZSH8Vi0GNYpr5oHyuZ4RGZQbwivSq5mQ9qGKuHBFdaO404RrL50SLgLcbOP4WelMvhvwMFyrRiB7jZ+m5zNbjtoGoMZYR8MUEETC2tvEw/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644426; c=relaxed/simple;
	bh=rZvHJrIwJz7NQmb5THdH9cX3LUXpNIok5gWtBcArh/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acUfVWjpr3l92zwcochefZ8+OXkuSLPkBhHH5+a5+l56RInvk7Qh3R5qEHtfiBKfneTi7S7P8RErwh2i4iwh+mH1pmJ4lAXiHSz47Hf3eGuNRt3WoHlg9FJTnuNkQ7zyCdIi3IyBgE5URCdSVoyK9wvhVk1kbiQRnzQOapWRH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=maMGq3ye; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744644407; x=1745249207; i=fiona.klute@gmx.de;
	bh=rZvHJrIwJz7NQmb5THdH9cX3LUXpNIok5gWtBcArh/o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=maMGq3yeDJYE6YVHxnKZNhqf7GrxMof5O/AzQQ0vsUQ4+rMjtb/iYVnak9m//uvQ
	 tmU1+G4zvr+JImCMhRz3QC8uoSlS4zihGozDYxVCoO61jaBjPe18LSXhER/Z56C4x
	 e46242K0nS4iXxx5eRkG/jzdlt8wB3dT23oTHGFl8p6PdFaPQOVFKCv+7V46WX0T+
	 lBwpUdIBwsoYcFq5kJHWuf3bSw52OzmuN6fWzUWo1PTb5ZcQEwY3L/KJ6wLloIJby
	 +SqKTaSivmwoiRQfXPCxlxI5hc0kaM8fnvu17WFjAZz3vVg4w0rUoXqlOWKL+Lj10
	 Eq3RAdXAX1kUx/ZenQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.home.arpa ([85.22.122.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1thLCl2S84-00Tvpo; Mon, 14
 Apr 2025 17:26:47 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-list@raspberrypi.com,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH net] net: phy: microchip: force IRQ polling mode for lan88xx
Date: Mon, 14 Apr 2025 17:26:33 +0200
Message-ID: <20250414152634.2786447-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:fQISuGsE84gb9tJCLkCkO/Mr1OEt+VwdckZX4vn2g6nRJr9qfV2
 XFXA5hN8qUCg7Uo3lWax82mXATulmmp3btqvx1w4VJ81U7bBLgM3P4XNqrl27JLD7YVsRT2
 1V5G3JE/qERxCZiwQNUFdqSXx1FDSRODP+3zMn1cAK43D9vKwEprLDyKU/Kdh1WMWhlBm6j
 1q7Leab/kGBEZfo8ugD0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dpJC4PaD+dY=;X9vXcRxFnoJzXghKFD6BZKcLZaw
 K1ubuCV0EmOCMCWujG1Y5NV6rEcjxdP4I3Za75rU2PaGSLfZqPOedOtAI46ArtTeiglGi3kPm
 G4stvDoIbgS9a996Sen55Vymmo0j0L22NerOg/5lKjBV8zpIgkMU70LSS4ezg4ABPknEJJrQt
 k6LlYMsWIlPwRjpr+8ku+QZQd3eppa4d68fbTdSmNdFbFWgTnzljzWKYUQwqOSIpSF6d1gi7u
 mgR6VIlborTIHrzaqnY27CwobF2cfEXUGg2fYMptHF8grPJEzoEdMRX6V3JKi2meRYz/bISpP
 NGeXBh/F3lf+jRimIvuAukXWZISyJXAVI5cULfCSRhpjA0+Qta+RKqYG7FLH3x1iZuzOObtq6
 13Z9x4X063xXFAfmy0xVUmSnlYPzHzY7ZIKZOt36YFgHnlxKbwuMw0qZ4tzXY46FHHFkV6x/c
 1BO0VT5dM/r0lmvexYj6Zty/FJvESiZwuK+xhWMFw85XOzoUzijWa90WR2bMR56/bAceOg9bJ
 mWl0NhKrzLDUqH0Uwr4636nmk1BDb7gQmmjjdAtx4gX4RBgJnfJR3pP4HzG9qa4yerXDlIo/t
 Fg8iKZmt+ClyWAX4sKMK88xVFYQ2WcWVYE5ygenXG2pT4TdzkkpjnQZpEmfFCzv1YZ6jxyJJz
 cylFI6HYqJ/UKDABCR6TP1FIPxoY73wv+vu+HO79wwxN6N28x5XPvqhxbRPZ6M6m4twH+lW2w
 1BoB2S5HfINUEHrDCihzXWvC1iBpMganRp4QDfXUFptQROj+ikXifTOca9QdORlHGc1OrWxgU
 PGLpOy5SKYTbXwzpYcq3XIVl2rKDOmI+tWOlqrg1UBfKrwC+9FMPJg8QQaFU+jW3R1jaFPh7n
 /9718vMiIHyGIQPQQ/0QcHYJbxNfXtYmdrLg+CDYyjdOEWSsSUKLZaaSc5DjnqRL2AxCTZceD
 +gEBgjDY30vaoeqCWjDmeDrur66C1cWuWanZD67NwCNN7+imd/Bt+VSqGNR+1shypx01LqnBJ
 G83yEXe0r50ovExTl7H8DlnEo0LVzJE1mlEP/3DvPDax9ztt349hK7FigjFreauomXsuLNxDA
 7KEGkP6R9fBv9eKmIAcaev9wK6R/4vweNdMNCaoIsat0ATD00/llpFZyL8ox4DyR3uJFHzT2C
 mEpo4EM4Sn7BqEKq+2yh1KjR5OGcy7NC6hCTRT5QZ2ng53TijjebxZUcJyEK3poMBCjkrk7hl
 WcVD8V7RZVYZ1VW1rnboB16NtrowaU94S4ZfChmrJm48yuF2leoJ2wlvUHBe6IbbcEgeYniGh
 ezCuhuavhmMIJGUHwf43swcmZjYryf144g8c0I9ZFoSAZ2I+QEr8CLYezBSz6aqT81xOiCAMj
 YXE83bQYgRsGU31zy6Hvgo20bo9G7KfYk6qNVqzs9oZCRMctjNk6xz0sDvGOUg7vV9e9+XgIo
 5BZiz7XJBkg9GTD/6SEOPgL7bzJF5v7eDLuTNWs2J/Lvjsb/p230HLEfpgx3HoWPEdHidtba+
 dktz9RFq2gZFfPchq0s=

V2l0aCBsYW44OHh4IGJhc2VkIGRldmljZXMgdGhlIGxhbjc4eHggZHJpdmVyIGNhbiBnZXQgc3R1
Y2sgaW4gYW4KaW50ZXJydXB0IGxvb3Agd2hpbGUgYnJpbmdpbmcgdGhlIGRldmljZSB1cCwgZmxv
b2RpbmcgdGhlIGtlcm5lbCBsb2cKd2l0aCBtZXNzYWdlcyBsaWtlIHRoZSBmb2xsb3dpbmc6Cgps
YW43OHh4IDItMzoxLjAgZW5wMXMwdTM6IGtldmVudCA0IG1heSBoYXZlIGJlZW4gZHJvcHBlZAoK
UmVtb3ZpbmcgaW50ZXJydXB0IHN1cHBvcnQgZnJvbSB0aGUgbGFuODh4eCBQSFkgZHJpdmVyIGZv
cmNlcyB0aGUKZHJpdmVyIHRvIHVzZSBwb2xsaW5nIGluc3RlYWQsIHdoaWNoIGF2b2lkcyB0aGUg
cHJvYmxlbS4KClRoZSBpc3N1ZSBoYXMgYmVlbiBvYnNlcnZlZCB3aXRoIFJhc3BiZXJyeSBQaSBk
ZXZpY2VzIGF0IGxlYXN0IHNpbmNlCjQuMTQgKHNlZSBbMV0sIGJ1ZyByZXBvcnQgZm9yIHRoZWly
IGRvd25zdHJlYW0ga2VybmVsKSwgYXMgd2VsbCBhcwp3aXRoIE52aWRpYSBkZXZpY2VzIFsyXSBp
biAyMDIwLCB3aGVyZSBkaXNhYmxpbmcgcG9sbGluZyB3YXMgdGhlCnZlbmRvci1zdWdnZXN0ZWQg
d29ya2Fyb3VuZCAodG9nZXRoZXIgd2l0aCB0aGUgY2xhaW0gdGhhdCBwaHlsaWIKY2hhbmdlcyBp
biA0LjkgbWFkZSB0aGUgaW50ZXJydXB0IGhhbmRsaW5nIGluIGxhbjc4eHggaW5jb21wYXRpYmxl
KS4KCklwZXJmIHJlcG9ydHMgd2VsbCBvdmVyIDkwME1iaXRzL3NlYyBwZXIgZGlyZWN0aW9uIHdp
dGggY2xpZW50IGluCi0tZHVhbHRlc3QgbW9kZSwgc28gdGhlcmUgZG9lcyBub3Qgc2VlbSB0byBi
ZSBhIHNpZ25pZmljYW50IGltcGFjdCBvbgp0aHJvdWdocHV0IChsYW44OHh4IGRldmljZSBjb25u
ZWN0ZWQgdmlhIHN3aXRjaCB0byB0aGUgcGVlcikuCgpbMV0gaHR0cHM6Ly9naXRodWIuY29tL3Jh
c3BiZXJyeXBpL2xpbnV4L2lzc3Vlcy8yNDQ3ClsyXSBodHRwczovL2ZvcnVtcy5kZXZlbG9wZXIu
bnZpZGlhLmNvbS90L2pldHNvbi14YXZpZXItYW5kLWxhbjc4MDAtcHJvYmxlbS8xNDIxMzQvMTEK
Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnLzA5MDFkOTBkLTNmMjAtNGExMC1iNjgwLTlj
OTc4ZTA0ZGRkYUBsdW5uLmNoClNpZ25lZC1vZmYtYnk6IEZpb25hIEtsdXRlIDxmaW9uYS5rbHV0
ZUBnbXguZGU+CkNjOiBrZXJuZWwtbGlzdEByYXNwYmVycnlwaS5jb20KQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKLS0tCiBkcml2ZXJzL25ldC9waHkvbWljcm9jaGlwLmMgfCA0NCAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcC5jIGIvZHJpdmVy
cy9uZXQvcGh5L21pY3JvY2hpcC5jCmluZGV4IDBlMTdjYzQ1OGVmZC4uMDZlMjg2Mzg3ZmE5IDEw
MDY0NAotLS0gYS9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlwLmMKKysrIGIvZHJpdmVycy9uZXQv
cGh5L21pY3JvY2hpcC5jCkBAIC0zNyw0NyArMzcsNiBAQCBzdGF0aWMgaW50IGxhbjg4eHhfd3Jp
dGVfcGFnZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCBpbnQgcGFnZSkKIAlyZXR1cm4gX19w
aHlfd3JpdGUocGh5ZGV2LCBMQU44OFhYX0VYVF9QQUdFX0FDQ0VTUywgcGFnZSk7CiB9CiAKLXN0
YXRpYyBpbnQgbGFuODh4eF9waHlfY29uZmlnX2ludHIoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRl
dikKLXsKLQlpbnQgcmM7Ci0KLQlpZiAocGh5ZGV2LT5pbnRlcnJ1cHRzID09IFBIWV9JTlRFUlJV
UFRfRU5BQkxFRCkgewotCQkvKiB1bm1hc2sgYWxsIHNvdXJjZSBhbmQgY2xlYXIgdGhlbSBiZWZv
cmUgZW5hYmxlICovCi0JCXJjID0gcGh5X3dyaXRlKHBoeWRldiwgTEFOODhYWF9JTlRfTUFTSywg
MHg3RkZGKTsKLQkJcmMgPSBwaHlfcmVhZChwaHlkZXYsIExBTjg4WFhfSU5UX1NUUyk7Ci0JCXJj
ID0gcGh5X3dyaXRlKHBoeWRldiwgTEFOODhYWF9JTlRfTUFTSywKLQkJCSAgICAgICBMQU44OFhY
X0lOVF9NQVNLX01ESU5UUElOX0VOXyB8Ci0JCQkgICAgICAgTEFOODhYWF9JTlRfTUFTS19MSU5L
X0NIQU5HRV8pOwotCX0gZWxzZSB7Ci0JCXJjID0gcGh5X3dyaXRlKHBoeWRldiwgTEFOODhYWF9J
TlRfTUFTSywgMCk7Ci0JCWlmIChyYykKLQkJCXJldHVybiByYzsKLQotCQkvKiBBY2sgaW50ZXJy
dXB0cyBhZnRlciB0aGV5IGhhdmUgYmVlbiBkaXNhYmxlZCAqLwotCQlyYyA9IHBoeV9yZWFkKHBo
eWRldiwgTEFOODhYWF9JTlRfU1RTKTsKLQl9Ci0KLQlyZXR1cm4gcmMgPCAwID8gcmMgOiAwOwot
fQotCi1zdGF0aWMgaXJxcmV0dXJuX3QgbGFuODh4eF9oYW5kbGVfaW50ZXJydXB0KHN0cnVjdCBw
aHlfZGV2aWNlICpwaHlkZXYpCi17Ci0JaW50IGlycV9zdGF0dXM7Ci0KLQlpcnFfc3RhdHVzID0g
cGh5X3JlYWQocGh5ZGV2LCBMQU44OFhYX0lOVF9TVFMpOwotCWlmIChpcnFfc3RhdHVzIDwgMCkg
ewotCQlwaHlfZXJyb3IocGh5ZGV2KTsKLQkJcmV0dXJuIElSUV9OT05FOwotCX0KLQotCWlmICgh
KGlycV9zdGF0dXMgJiBMQU44OFhYX0lOVF9TVFNfTElOS19DSEFOR0VfKSkKLQkJcmV0dXJuIElS
UV9OT05FOwotCi0JcGh5X3RyaWdnZXJfbWFjaGluZShwaHlkZXYpOwotCi0JcmV0dXJuIElSUV9I
QU5ETEVEOwotfQotCiBzdGF0aWMgaW50IGxhbjg4eHhfc3VzcGVuZChzdHJ1Y3QgcGh5X2Rldmlj
ZSAqcGh5ZGV2KQogewogCXN0cnVjdCBsYW44OHh4X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7
CkBAIC01MjgsOSArNDg3LDYgQEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIG1pY3JvY2hpcF9w
aHlfZHJpdmVyW10gPSB7CiAJLmNvbmZpZ19hbmVnCT0gbGFuODh4eF9jb25maWdfYW5lZywKIAku
bGlua19jaGFuZ2Vfbm90aWZ5ID0gbGFuODh4eF9saW5rX2NoYW5nZV9ub3RpZnksCiAKLQkuY29u
ZmlnX2ludHIJPSBsYW44OHh4X3BoeV9jb25maWdfaW50ciwKLQkuaGFuZGxlX2ludGVycnVwdCA9
IGxhbjg4eHhfaGFuZGxlX2ludGVycnVwdCwKLQogCS5zdXNwZW5kCT0gbGFuODh4eF9zdXNwZW5k
LAogCS5yZXN1bWUJCT0gZ2VucGh5X3Jlc3VtZSwKIAkuc2V0X3dvbAk9IGxhbjg4eHhfc2V0X3dv
bCwKLS0gCjIuNDkuMAoK

