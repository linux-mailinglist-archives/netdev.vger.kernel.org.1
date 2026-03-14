Return-Path: <netdev+bounces-267695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCcALj4ttWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:41:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7328C6E3
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C19F300FEDF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046A933C192;
	Sat, 14 Mar 2026 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="F5lSuzgx";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="F5lSuzgx"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707831E859;
	Sat, 14 Mar 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481267; cv=none; b=Uh11CWrUBuxHGrZIDoEAiPR8C86ePjGRq8oGXC0//aprqnsb4IkuwRSD3aL1vqLrnh5mVyszqPIAu/w6RiqqK/A+0NaTnG7fzn4HpCQ2VfXz6aj4662f0TDoz0yaRxurFh0eYU6p78wibUxS0v3r05n8UuMOHjqMWJGCpp30Y/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481267; c=relaxed/simple;
	bh=H/kSyRr0L2VYaxHlrNL1/UDci7GYRLAyO6lHLHMf8O4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=am+B7fzTu+4jRcAQ5yyNxytR4BjSqgKOoxsQZSt77cf0EwmoJTsPKoHKySpG6fLnE/rDf35DoT+IlB9JYE0e/a5g6GvLG2Iq6uGlsukcElDay6YDLfEq+ChxGfzBhrRp89vKQ21F1kp7zalZQQxdKyBd+W1Lf3IfTwWyI7vosYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=F5lSuzgx; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=F5lSuzgx; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480702;
	bh=H/kSyRr0L2VYaxHlrNL1/UDci7GYRLAyO6lHLHMf8O4=;
	h=From:Subject:Date:To:Cc:From;
	b=F5lSuzgxG3Zr9R4tlPViYUykAJT7Zr5Yw2T8pUVswE4tP8y8EgsL295zmg1l1dpUL
	 YoLVA8GFHOwje7e6+GmqvO7lH6hwWBFE+7p7XNYRwdwAG9EydPDcLHAUEXEbsQD//Z
	 B19u5hotimACcg8JWbgjpTKC1J3OQ2oBesXSZo379ITh+OwSYRiu/jOgP99fJjzkBS
	 T/6kvmprMwXD3ONYOibMOVIWCnV391mi9sc8w+bAZmmQ4E0dWQHpCbbeHNn34iEkpL
	 3Ff2I4Jfz8dY51zRRnpdC0muUfigD1cBWUkIt84H0gdwx7Q7qea/oynFaxVjxhvaaX
	 NKWiKCUsZesIQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D31513FCB9; Sat, 14 Mar 2026 09:31:42 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480702;
	bh=H/kSyRr0L2VYaxHlrNL1/UDci7GYRLAyO6lHLHMf8O4=;
	h=From:Subject:Date:To:Cc:From;
	b=F5lSuzgxG3Zr9R4tlPViYUykAJT7Zr5Yw2T8pUVswE4tP8y8EgsL295zmg1l1dpUL
	 YoLVA8GFHOwje7e6+GmqvO7lH6hwWBFE+7p7XNYRwdwAG9EydPDcLHAUEXEbsQD//Z
	 B19u5hotimACcg8JWbgjpTKC1J3OQ2oBesXSZo379ITh+OwSYRiu/jOgP99fJjzkBS
	 T/6kvmprMwXD3ONYOibMOVIWCnV391mi9sc8w+bAZmmQ4E0dWQHpCbbeHNn34iEkpL
	 3Ff2I4Jfz8dY51zRRnpdC0muUfigD1cBWUkIt84H0gdwx7Q7qea/oynFaxVjxhvaaX
	 NKWiKCUsZesIQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 146673FC9A;
	Sat, 14 Mar 2026 09:31:42 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next 0/9] r8152: Add support for the RTL8157 5Gbit USB
 Ethernet chip
Date: Sat, 14 Mar 2026 10:31:36 +0100
Message-Id: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPgqtWkC/x2M7QpAMBhGb0XvbyszH8utSBoevKXRtqTk3o2fp
 845N3k4hqcmucnhZM+7jSDThMbV2AWCp8iUZ3mVKVkIFzYty7q3uIIwkLrSCkMxG4rJ4TDz9e9
 asgjis6h7nhdJU8YoaAAAAA==
X-Change-ID: 20260314-rtl8157_next-ae18683eb4fa
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-267695-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 17F7328C6E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the RTL8157, which is a 5GBit USB-Ethernet adapter
chip in the RTL815x family of chips.

The RTL8157 uses a different frame descriptor format, and different
SRAM/ADV access methods, plus offers 5GBit/s Ethernet, so support for these
features is added in addition to chip initialization and configuration.

The module was tested with an OEM RTL8157 USB adapter:
[25758.328238] usb 4-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[25758.345565] usb 4-1: New USB device found, idVendor=0bda, idProduct=8157, bcdDevice=30.00
[25758.345585] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=7
[25758.345593] usb 4-1: Product: USB 10/100/1G/2.5G/5G LAN
[25758.345599] usb 4-1: Manufacturer: Realtek
[25758.345605] usb 4-1: SerialNumber: 000300E04C68xxxx
[25758.534241] r8152-cfgselector 4-1: reset SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[25758.603511] r8152 4-1:1.0: skip request firmware
[25758.653351] r8152 4-1:1.0 eth0: v1.12.13
[25758.689271] r8152 4-1:1.0 enx00e04c68xxxx: renamed from eth0
[25763.271682] r8152 4-1:1.0 enx00e04c68xxxx: carrier on

The RTL8157 adapter was tested against an AQC107 PCIe-card supporting
10GBit/s and an RTL8126 5Gbit PCIe-card supporting 5GBit/s for
performance, link speed and EEE negotiation. Using USB3.2 Gen 1 with
the RTL8157 USB adapter and running iperf3 against the AQC107 PCIe
card resulted in 3.47 Gbits/sec, whereas using USB3.2 Gen2 resulted
in 4.70 Gbits/sec, speeds against the RTL8126-card were the same.

As the code integrates the RTL8157-specific code with existing RTL8156 code
in order to improve code maintainability (instead of adding RTL8157-specific
functions duplicaing most of the RTL8156 code), regression tests were done
with an Edimax EU-4307 V1.0 USB-Ethernet adapter with RTL8156.

The code is based on the out-of-tree r8152 driver published by Realtek under
the GPL.

This patch is on top of linux-next as the code re-uses the 2.5 Gbit EEE
recently added in r8152.c.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
Birger Koblitz (9):
      r8152: Add support for RTL8157 RX/TX descriptor format
      r8152: Add support for RTL8157 SRAM access and ADV indirect access
      r8152: Add support for configuring the PHY of the RTL8157
      r8152: Add RTL8157 initialization
      r8152: Add RTL8157 startup
      r8152: Add support for chip version RTL_VER_16
      r8152: Add support for 5Gbit Link Speeds
      r8152: Add support for 5GBit EEE
      r8152: Detect RTL8157 and setup

 drivers/net/usb/r8152.c | 1092 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 845 insertions(+), 247 deletions(-)
---
base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
change-id: 20260314-rtl8157_next-ae18683eb4fa

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


