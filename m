Return-Path: <netdev+bounces-283368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PIXkB7aC9WkHMAIAu9opvQ
	(envelope-from <netdev+bounces-283368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A384B0F17
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCF7D3017C23
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 04:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039E27E1DC;
	Sat,  2 May 2026 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fkkGwCkI";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="way8hlnH"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE01FE471;
	Sat,  2 May 2026 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777697459; cv=none; b=m3yDDa1dY3AXiF1/DeIGxOFM9lEaH14JwVvXznVOiY6kflAUkXKnpqu+x5BfigMVCwwWiGx5SU/sPKwjim7s7uabXlEv0tgFGiDduhxner2p5Vzt1SL+0SnBrxNJIC62NB8jjt9ireKWkMpOSkdsowYG6Vudv6lvOuhx/1aQZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777697459; c=relaxed/simple;
	bh=BuGxYPS6zncPzYH+nFShBQNWBb9wnbPtNA2jyIidU00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xg2AwQiODF6UCnEEhFr4BxLcpcZZqTm5jZB7JSyrfWNsR6m+fyBEsvuCo9Rex233cT7vtveZa2lV/CwzUT3Y6FaTChPqRjFKsxY2O+CmerijVaYY2zU67wGfIyKwnGZhuHoOIMqlePBSIPf8wVqjq4z0BZSozlXjGvgWobC5TyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fkkGwCkI; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=way8hlnH; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777697455;
	bh=BuGxYPS6zncPzYH+nFShBQNWBb9wnbPtNA2jyIidU00=;
	h=From:Subject:Date:To:Cc:From;
	b=fkkGwCkIhOHQK1TqNET5eymmmGYlWuPev8n4sznpL+w64dhEcGG1Cg9+oIBG1gPpI
	 jsd8RhjCrqYOByaUVuzJbOSvV/eEQXS+9nj/EjNhpAGto32QQIY7Y24bXrMYXyyGDt
	 DqqwYFfvvNeS/oN233NaQZxSU729G2j0odHv6OwJuTfrxXTM5CWZ1efS2wrbfxhAuS
	 9ucgw3+kqroW/sCwuF1xnuMuaERRvoIBsSdtIc1cuQQEQJyD2UCPuoYTmGqkvMO8L2
	 5KRQTcgaTYM3AC1N1fc9v4LlenY06zdsf9hbVw+wX8JNkiHrBDE6qE8N/lyxQoGYyS
	 r5QNZq2cSok6g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E91C5482BC; Sat,  2 May 2026 04:50:55 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777697454;
	bh=BuGxYPS6zncPzYH+nFShBQNWBb9wnbPtNA2jyIidU00=;
	h=From:Subject:Date:To:Cc:From;
	b=way8hlnHpQpm2k3lvxbQD7cxGmSbi5FpZhkfMk1bwVj2T1kBs++fHZIdyJhIZo7U9
	 X9Kf5BAxWge4FRInjW41lCaYG2TAERJA2VgPr4Mu2rgkOW2yx6wuv2NcZtEzYDsy48
	 7segLVkhOF6eWvIMvBY7uNqOhFOEWEaekwUso7LWkhf/Od99LkXEk0uLuIAfzXeKef
	 MzleNtlDpMHPXbeWHn5X8LX7L/MPD3r4eUXRCVySvw4Lf9H8Q0GCbg4Oqq7EnWfSDI
	 h/Xjjaw7Ozr8ohcllwl0nXFeGHsIAY+tBKB4HYePRAhGvJRbiFNwk8OZ/CdUuvHjJt
	 jQoKKCL7oPSDA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3C5A4412CF;
	Sat,  2 May 2026 04:50:54 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v3 0/3] r8152: Add support for the RTL8159 10Gbit
 USB Ethernet chip
Date: Sat, 02 May 2026 06:50:35 +0200
Message-Id: <20260502-rtl8159_net_next-v3-0-12c895d46cd6@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJuC9WkC/23NQQ7CIBAF0Ks0rMVQSqF15T2MMVCGlti0BgipN
 r27SFyY2MUsfubPmxV5cBY8OhUrchCtt/OUQnUoUDfIqQdsdcqIEsoJowK7MDZl3d4mCGmWgJk
 RopG8ZEYKlM4eDoxdMnlBqYU/LXRNm8H6MLtn/hXLvP+yzT8bS0xwTTWpWioU4+asrOvB4fusR
 hteRw0ZjfQXancgmiAlVdVpBqzjfA/atu0Neo1BogsBAAA=
X-Change-ID: 20260427-rtl8159_net_next-4f778a614fa7
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Andrew Lunn <andrew@lunn.ch>, 
 Aleksander Jan Bajkowski <olek2@wp.pl>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 73A384B0F17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283368-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,realtek.com,birger-koblitz.de,lunn.ch,wp.pl];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
Changes in v3:
- Various references to RTL8157 in the commit description changed
  to RTL8159
- Fix incorrect use of OCP_EEE_ADV2 register for 10GBit 
- Fix various instances where a gate on RTL_VER_16 was not extended
  to RTL_VER_17, although RTL8159 needs the same code-path as RTL8157
- Explain use of 0x815a device-ID for RTL8159 in commit message
- Extend poll-timeout for backup-restore to 20ms
- Drop patch for IRQ mitigation 
- Link to v2: https://lore.kernel.org/r/20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de

Changes in v2:
- Correct formatting of comments
- Order case statement values correctly
- Add error message when backup-restore fails
- Correct commit message of support for firmware upload
- Link to v1: https://lore.kernel.org/r/20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de

---
Birger Koblitz (3):
      r8152: Add support for 10Gbit Link Speeds and EEE
      r8152: Add support for the RTL8159 chip
      r8152: Add firmware upload capability for RTL8157/RTL8159

 drivers/net/usb/r8152.c | 340 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 321 insertions(+), 19 deletions(-)
---
base-commit: 0f19519fdd22bc0f5429377da3a52327c5eee166
change-id: 20260427-rtl8159_net_next-4f778a614fa7

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


