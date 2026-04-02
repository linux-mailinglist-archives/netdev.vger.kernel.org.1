Return-Path: <netdev+bounces-274425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLD7JpkpzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:32:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1263860CA
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A57302F702
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30904396593;
	Thu,  2 Apr 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="tTpL/Nje";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="tTpL/Nje"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296F361DCA;
	Thu,  2 Apr 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118503; cv=none; b=UQA/qccY+DNM4xv+I5fLDC8E0MDZfpaBAAQOVSsYnCRBWeiJ0a22KLeTT0ciNk9VfQlHMRN3V4bxNfyHqC+a/+rD5vXE+2tWaJTzxZ8AP9O6jMJkuqaYvZ2iVehJiebByxOu7KwGpA0H/Iwy8yEciXCk8RAy1JV8dmiTpkx+10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118503; c=relaxed/simple;
	bh=zh9521kP7feP1XpJOKtwCPlqWkrTZYy77zHQLvSn/So=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k5KzTTgOlYIDB4VdfuMcFWTxWvPTilZ/gyYmieWl2wq5tAm6aYMqU53B7g43/vA4SQ3h+JRV5tw+JL7ke5ThjysL6hhK9JPS+F0wmBbZ6y9T9oL9qg19a4kSv6xx1KmplEWSHWhIPepvISzZ1N6S8uYRNRvKbGTh8q+jk4kcfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tTpL/Nje; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tTpL/Nje; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775118499;
	bh=zh9521kP7feP1XpJOKtwCPlqWkrTZYy77zHQLvSn/So=;
	h=From:Subject:Date:To:Cc:From;
	b=tTpL/NjeyJk081mx79jgWIExIoFa/XrmKiCNvyxEw6Ujj8oXO/jpiz3wX78KebYF7
	 IpfU/J3oqY4XyItKM8cFJmyi6iEBaQDZH02b6BxnT6fHUSNgByW564YzV17Tp4RrNQ
	 mf3ZHze3dbKaSe0yt2BZDu63ToCOdvadtZyPsqQj+EF/9HDBBmnPk5l4y07584BffM
	 H/jTlgLGjuwpy1KAlCa47xMQBGdI0j1GYVZa/HSdWZd8R9D2QQwqYKCMKlae5ZPtMT
	 vBVmwgA4MYMeGtlQ8+LZkS11uqN1TiZYd9CIsWEaz4GUbhRy3DXTgfOat0aOegtVQE
	 zwA0X45GtFEkg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id EFE07408D6; Thu,  2 Apr 2026 08:28:19 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775118499;
	bh=zh9521kP7feP1XpJOKtwCPlqWkrTZYy77zHQLvSn/So=;
	h=From:Subject:Date:To:Cc:From;
	b=tTpL/NjeyJk081mx79jgWIExIoFa/XrmKiCNvyxEw6Ujj8oXO/jpiz3wX78KebYF7
	 IpfU/J3oqY4XyItKM8cFJmyi6iEBaQDZH02b6BxnT6fHUSNgByW564YzV17Tp4RrNQ
	 mf3ZHze3dbKaSe0yt2BZDu63ToCOdvadtZyPsqQj+EF/9HDBBmnPk5l4y07584BffM
	 H/jTlgLGjuwpy1KAlCa47xMQBGdI0j1GYVZa/HSdWZd8R9D2QQwqYKCMKlae5ZPtMT
	 vBVmwgA4MYMeGtlQ8+LZkS11uqN1TiZYd9CIsWEaz4GUbhRy3DXTgfOat0aOegtVQE
	 zwA0X45GtFEkg==
Received: from DebianDesktop.lan (p200300c69f04eb0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C46A5408BC;
	Thu,  2 Apr 2026 08:28:18 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v6 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
Date: Thu, 02 Apr 2026 10:28:12 +0200
Message-Id: <20260402-rtl8157_next-v6-0-a9b77c0931ef@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwozmkC/3XPwWrDMAwG4FcpPs/DsuzY3WnvMcaQa7k1K8lwT
 OhW8u5zcwqhOf780id0FyOXzKN4O9xF4SmPeehb6F4O4nSh/swyx5aFVrpTCEaWevVg3VfPtyq
 JwXceOZhEoq38FE75tnAfoucqH1PiszWXPNah/C53Jlj65+QEUsljIOeC0Z5SfA+5nLnI7yFcc
 /17jbyAk14jboPohoBigkTG+wh7CK4QrTYIPhDixCdyKZLbQ8wa2b5jGqLQIOgAOrLdQ+wKQdg
 gtiGRA6qjTR69eobM8/wP1iFw4s4BAAA=
X-Change-ID: 20260314-rtl8157_next-ae18683eb4fa
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
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
	TAGGED_FROM(0.00)[bounces-274425-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 1A1263860CA
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
Changes in v6:
- Rebased to net-next
- Fixed typos: ocp_10bt -> ocp_10gbt
- Link to v5: https://lore.kernel.org/r/20260331-rtl8157_next-v5-0-deb3095f8380@birger-koblitz.de

Changes in v5:
- Filter advertising in rtl8152_set_speed() to prevent incorrect speeds
- Prevent double USB transfers in rtl8152_get_link_ksettings()
- Make sure OCP_EEE_ADV2 and OCP_EEE_LPABLE2 are read if a device
  supports 5GBit but not 2.5Gbit
- Fix rtl8157_runtime_enable() to follow the behavior of
  rtl8156_runtime_enable()
- Prevent call to r8153_u2p3en in rtl8156_up() for RTL8157
- Fix rtl8157_unload() to disable interrupt mitigation
- Link to v4: https://lore.kernel.org/r/20260324-rtl8157_next-v4-0-034312b12de5@birger-koblitz.de

Changes in v4:
- Fix return type of ocp_adv_read()
- In r8152_tx_csum() use tx_desc
- Use TCPHO_MAX_2 for RTL8157 in rtl8152_features_check()
- Include RTL_VER_12 in RTL8156B chip versions in rtl8156_init()
- Remove inline keyword from rx_agg_align and tx_agg_align
- Link to v3: https://lore.kernel.org/r/20260320-rtl8157_next-v3-0-1aefeca7fda7@birger-koblitz.de

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

 drivers/net/usb/r8152.c | 1029 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 827 insertions(+), 202 deletions(-)
---
base-commit: cee10a01e286e88e0949979e91231270ca9fdb8e
change-id: 20260314-rtl8157_next-ae18683eb4fa

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


