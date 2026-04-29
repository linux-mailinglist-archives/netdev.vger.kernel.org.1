Return-Path: <netdev+bounces-282440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KXTAn858mlopAEAu9opvQ
	(envelope-from <netdev+bounces-282440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:01:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80592497E47
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC7B330048CD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495B389E13;
	Wed, 29 Apr 2026 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="G4Mim5Sj";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="MHDMYG5v"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BC3B18A;
	Wed, 29 Apr 2026 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482104; cv=none; b=lT3V40csvSmtd4JOhsVtwLvnNayQHjAoNCuFkmIXgSEI+G2am4qCeFoNPeDzcqv1uC6lAr6QhIcXiUkk5wnB9AKhoqn4IdbIQY8nr1g0dW5JJGDCv4f/vKxFyvLHK0f24KF2mOeQLKL2zCBSX273QjfvwavWpSfRxhJ10qOazJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482104; c=relaxed/simple;
	bh=rSsH+iAR4iQujPrJlI8eyGQ5T9JPoMRul+5ObUzw8F4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VM99pXbvz26fW+s887MGOw5zMA0ZxUWHF4ezT/ia6qfpuLaDz168b+oyVOSLPEmYYC3+z5jEwA4n9f0eAewMyvKmXm94/pcumoG5vVfFUoT49DRf/LClrD181yJl31iso49nX+UUJ2c2FRLRunu1J2JXSHKoDxbnkQXn753AWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=G4Mim5Sj; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=MHDMYG5v; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777482101;
	bh=rSsH+iAR4iQujPrJlI8eyGQ5T9JPoMRul+5ObUzw8F4=;
	h=From:Subject:Date:To:Cc:From;
	b=G4Mim5Sj/jIQRXWYoAZ4bddO0PWgQNb2ce6M/2QMDU3eEc753829SLoDgDN36cUaF
	 OMY/ZnBKVgKz+8W3AsxbSTHSB/bZYwxr05lYZSsW8ZRSqqTHUnRebyXszJEHZrKfOE
	 BQI882d2NOD+VqKo25hiv+QNtw/tI/qpvpbN3IP+3epv7jREb+0Gv6sEiGIfEFVEV6
	 svWECXYEWNSLSifroDcuICAit/JOyN97XvOdKzwFNwhqhTeevx3A3RLabu2DjZxGSZ
	 MWIuOahnlW2D+Sj3ztoN5Gjga3xBhUnbKe5lZfLmyPmX0u1HTl7MZUfYK3yJUZAtTP
	 F+3iZhOCpASaQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2E51F481AA; Wed, 29 Apr 2026 17:01:41 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777482098;
	bh=rSsH+iAR4iQujPrJlI8eyGQ5T9JPoMRul+5ObUzw8F4=;
	h=From:Subject:Date:To:Cc:From;
	b=MHDMYG5vwLG/ypmdw7DfTPjHoKR8HANlsVRDnNfkwhG09pfhe61S1k52OOUnibOr8
	 Quig04i7Rf9bkvlQuTGWhYyJE+9CkdxTw+UpTk/qlCyfaCtqnoxwdZuptc+3aU8wi1
	 OJDJUMu5sGfCOR9r5x+pIXDIUn51+adNIqZhmGEpRLBCptdKFYXBN77hFwj3J9CRbv
	 I6d9AcgUTF4eHnv/TfzUD7YUz+rPLLWMjJpFti1xfzCKXBh/LYAcKoL+bUpC+2dgH1
	 V8zJuNtAsxHDKBCIteDiHqnb1Uav+BJZfkWaSJZEOIkogL0BbnnDHBHedltiQUokyx
	 +FNtA/OJrjivQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7821D47E3B;
	Wed, 29 Apr 2026 17:01:38 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v2 0/4] r8152: Add support for the RTL8159 10Gbit
 USB Ethernet chip
Date: Wed, 29 Apr 2026 19:01:08 +0200
Message-Id: <20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQ58mkC/2WNwQ6CMBBEf4Xs2TVtLRQ8+R+GGJAtbCTUtA1BC
 f9uJd48zGEyM29WCOSZApyzFTzNHNhNyahDBvehmXpC7pIHJVQhtDLo41jKvLpNFJOWiNoaUza
 F1LYxkGZPT5aXHXmF1MJvC+qUDByi86/9a5Z7/sOW/9hZosBcdeJUKdPqwl5a9j15fLh25Pg+d
 gT1tm0fl8pP3MIAAAA=
X-Change-ID: 20260427-rtl8159_net_next-4f778a614fa7
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 80592497E47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-282440-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

Add support for the RTL8159, which is a 10GBit USB-Ethernet adapter
chip in the RTL815x family of chips.

The RTL8159 re-uses the frame descriptor format and SRAM2 access introduced
with the RTL8157 as well as most of the setup and PM logic of the RTL8157.

The module was tested with a Lekuo DR59R11 USB-C 10GbE Ethernet Adapter:
[ 2502.906947] usb 2-1: new SuperSpeed USB device number 3 using xhci_hcd
[ 2502.927859] usb 2-1: New USB device found, idVendor=0bda, idProduct=815a, bcdDevice=30.00
[ 2502.927867] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=7
[ 2502.927871] usb 2-1: Product: USB 10/100/1G/2.5G/5G/10G LAN
[ 2502.927873] usb 2-1: Manufacturer: Realtek
[ 2502.927875] usb 2-1: SerialNumber: 000388C9B3B5XXXX
[ 2503.063745] r8152-cfgselector 2-1: reset SuperSpeed USB device number 3 using xhci_hcd
[ 2503.123876] r8152 2-1:1.0: Requesting firmware: rtl_nic/rtl8159-1.fw
[ 2503.126267] r8152 2-1:1.0: PHY firmware installed 0 to be loaded: 20
[ 2503.156265] r8152 2-1:1.0: load rtl8159-1 v1 2026/01/01 successfully
[ 2503.270729] r8152 2-1:1.0 eth0: v1.12.13
[ 2503.289349] r8152 2-1:1.0 enx88c9b3b5xxxx: renamed from eth0
[ 2507.777055] r8152 2-1:1.0 enx88c9b3b5xxxx: carrier on

The RTL8159 adapter was tested against an AQC107 PCIe-card supporting
10GBit/s and an RTL8157 5Gbit USB-Ethernet adapter supporting 5GBit/s for
performance, link speed and EEE negotiation. Using USB3.2 Gen 2 (20GBit) with
the RTL8159 USB adapter and running iperf3 against the AQC107 PCIe
card resulted in 8.96 Gbits/sec transfer speed.

The code is based on the out-of-tree r8152 driver published by Realtek under
the GPL.

The RTL8159 requires firmware for the PHY in order to achieve a 10GBit link
speed. Without firmware, only 5GBit were achieved. The firmware can be
extracted from the out-of-tree r8152 driver-code where it is stored in the
ram17 u8-array. Code is added to use the existing firmware upload mechanism
of the driver for the RTL8157/9 PHY firmware code. The firmware will be
submitted separately to linux-firmware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
Changes in v2:
- Correct formatting of comments
- Order case statement values correctly
- Add error message when backup-restore fails
- Correct commit message of support for firmware upload
- Link to v1: https://lore.kernel.org/r/20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de

---
Birger Koblitz (4):
      r8152: Add support for 10Gbit Link Speeds and EEE
      r8152: Add support for the RTL8159 chip
      r8152: Add irq mitigation for RTL8157/9
      r8152: Add firmware upload capability for RTL8157/RTL8159

 drivers/net/usb/r8152.c | 336 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 324 insertions(+), 12 deletions(-)
---
base-commit: 35c2c39832e569449b9192fa1afbbc4c66227af7
change-id: 20260427-rtl8159_net_next-4f778a614fa7

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


