Return-Path: <netdev+bounces-269883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAOMCkcsvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:15:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4BC2D95FB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D82B30420B0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28939DBD0;
	Fri, 20 Mar 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="mZmgCHkw";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="gVFvbjEC"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781C38A70C;
	Fri, 20 Mar 2026 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005282; cv=none; b=HfL+8EHloHpXbqGJfkeK91X+dUkunR3BdsdkUTucrMndWwvTMQyAAVgsMf5vuqOX5jiFS5UXB0VHxNfNW/4NUZlvKu4h3QuiCJV4n5GUkIBCc40+IVr/SQhbu4PHDbhhw+eLNWBnRXqE5R3G5rSqSIwZi3nDSn+F0Pxeo/ccGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005282; c=relaxed/simple;
	bh=eSzA+1WMRobTeZgW+P86t77w/eFfcYvBlgBetZ68xuU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e+0hprDfo5lsR7VlzjoAy06sZDAzoZWAoFt5OKefjhoCB/ujQ0GqRx4iSH5h+wfTjD2V47ZP4xFOP+TT6OLKJzJIBw3/Bn+V6Ur+Camrip8sSGGAO6+h/JlVaHieQPfPYlOt/rE/o4EA0/cCVMiALHlKxPb7ZPL+xmtS8DwOeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=mZmgCHkw; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=gVFvbjEC; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774005279;
	bh=eSzA+1WMRobTeZgW+P86t77w/eFfcYvBlgBetZ68xuU=;
	h=From:Subject:Date:To:Cc:From;
	b=mZmgCHkwl/Qtsex0rZP84Xtflq2Qwo3jE7WJxAM2Frli3qbmZOW7+qHNLQTlgXCyW
	 VQCD0/R5jePtNDjlDLHCVrNr+JZKHmyrejxkBcCeKOcK2b94RLKzcUVACgFefF9Vkr
	 GV8kWZqTo+h+8YecwmXm7IGMMF2qLENWUDBrjQzB6rnQlucXLD4brxxYSRM9a4Rxve
	 pnGQLmVwkdVHZA3vtfIM8Uc10U5kFWLls4hEfSSeIvOUOlsg3GmIObgpi67VUhGzfP
	 Oasjd0IMKnBkOPUCSyHeoil4B7C8UwmpaXskJZA/5FUVJWDxbLH7jj/G5EuPpDY7q4
	 YZWcyKG6W61sg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 6F0CB3FF13; Fri, 20 Mar 2026 11:14:39 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774005278;
	bh=eSzA+1WMRobTeZgW+P86t77w/eFfcYvBlgBetZ68xuU=;
	h=From:Subject:Date:To:Cc:From;
	b=gVFvbjECG/lJkk9kLBrLHdaamrODCe2d6hOGr504SYYncCdRPrPublg970WajQyKc
	 6enQ1sUYd8o3x43fRYq3BRTp2AaCqQogS9xwcI9w6HSZ01Znh0xEKbfNpHvjS2wV46
	 iqvfZSkmyDJmJM7TZ3KIMxdzCpTU03Zv9A/WYI27s6WMhP4zZOyr8Ocf+IvJyKhcTC
	 eDH9M5VxSouditaxmWy4IWM67wagKeCWK/1OWxJFOqoYv9iOYGRuDzwH9hewA3ovlb
	 ov5Q9sxi0LDNA4J495JsXw/Zc+t33eL8ZPqYz776GqYO8YvF3skFWqp7tvnV83SBtf
	 cnglOwJQCVZUQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 294473FEEE;
	Fri, 20 Mar 2026 11:14:38 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v3 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
Date: Fri, 20 Mar 2026 12:14:36 +0100
Message-Id: <20260320-rtl8157_next-v3-0-1aefeca7fda7@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwsvWkC/23NQQ7CIBAF0Ks0rMUAxYKuvIcxBmRoiQ01QEi16
 d1FVsZ0+fPnv1lQhOAgolOzoADZRTf5Etpdg+6D8j1gZ0pGjLCOtJTjkEZJD+LmYU5YAZWdbEF
 zq1CZPANYN1fugjwk/L1C19IMLqYpvOqfTGu/TWaKCT5qJYTmTCprztqFHgJ+THp06b03UMHMf
 hHxh7CCUAKKWsWlNHQLWdf1A78qNGj/AAAA
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-269883-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F4BC2D95FB
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
Changes in v3:
- Apply reverse Christmas tree order for declarations
- Use poll_timeout_us for register polling
- In rtl8156_enable(), fix version comparison: tp->version >= RTL_VER_16
- Correct error handling of r8153_phy_status in r8157_hw_phy_cfg()
- Fix use of ocp_word_clr_bits for PLA_MCU_SPDWN_EN register
- Link to v2: https://lore.kernel.org/r/20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de

Changes in v2:
- Fixed missing initialization of ret value in wait_cmd_ready()
- Combine all parts with RTL8157-specific code to avoid undefined functions
- Link to v1: https://lore.kernel.org/r/20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de

---
Birger Koblitz (2):
      r8152: Add support for 5Gbit Link Speeds and EEE
      r8152: Add support for the RTL8157 hardware

 drivers/net/usb/r8152.c | 1076 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 830 insertions(+), 246 deletions(-)
---
base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
change-id: 20260314-rtl8157_next-ae18683eb4fa

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


