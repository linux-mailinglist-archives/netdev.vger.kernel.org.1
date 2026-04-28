Return-Path: <netdev+bounces-281616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7MTwJ9st8GkHPgEAu9opvQ
	(envelope-from <netdev+bounces-281616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:47:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E967547D258
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2446C30277F4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5D62E6CA6;
	Tue, 28 Apr 2026 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kL2TAuqb";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="djoFcJ63"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADBF283C82;
	Tue, 28 Apr 2026 03:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348056; cv=none; b=aIt8mVIbfpmdHCsxfJJrG8UyMj/k2QuZZetrGCeAhKPqirNSCs2FXp9QgAHdTAI/JZ1hls+eXfSAHhV5HzZwFSVdAbt1D/gq9snhLYZZWz4Tb6ePTfsgahiHY/xbPzhQhirkSJdZVzqf+INl1EThHnsW4ohGR3Ij6nhCsiK67PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348056; c=relaxed/simple;
	bh=GPwSIwQ1oCbp+npXZ00eumj05zMY3J5xkl0R4CrtXSo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eFHKHFzd3BLOGUmO9zL2yP6JxJeLb4S/SYo28EU5eLsQmGLSJIqh3UBAlNXJpkoZV+s5w5NVMF55Kx7b/QVbPO9CWEqGYacOgQKI778Vti8BQ/WRDH5lwPme15EK5o7Bg5Wx4SWYwMoyKQUUO4hMCJGw6LySL62LIz+39Na3n2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kL2TAuqb; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=djoFcJ63; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777348053;
	bh=GPwSIwQ1oCbp+npXZ00eumj05zMY3J5xkl0R4CrtXSo=;
	h=From:Subject:Date:To:Cc:From;
	b=kL2TAuqbFi1F4eUyYHdFGCdg/kq3t529EQdZh2WJCtwrZDzJHWmISxtXBlE3ue8RB
	 bswy479kad1RpgGJppPfZWVUB9XWCTUonNoyz1s926mh0zPumYP3HLN8UFgrqgr56V
	 uwp1Mj00OyiEYMkD0xG2qIQ/HdKiYJxUG9MZfqFM2ifF2sBmnVBz9CzEauVMQMzAjn
	 Z9aPkleKIB3KVOEoJ5BLLYV+KGuuiyE1ZRrhqT9uw/ylH8Jc/J693o7UOyuD7ncHnM
	 qdIK/PwuD5QliUFhwvV03QY1Vq33ch1Ks46l6RakZe7huwXsSdurBMwLG/81yad/4b
	 2/C7vtl24aOHg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 59E1247DB2; Tue, 28 Apr 2026 03:47:33 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777348052;
	bh=GPwSIwQ1oCbp+npXZ00eumj05zMY3J5xkl0R4CrtXSo=;
	h=From:Subject:Date:To:Cc:From;
	b=djoFcJ63SUq3bmWW1rSSQVNU5aSVdOkjJLy6GSvBMUAOSTA6/MbUJffa8zZRVgo+/
	 xYEYGYMiFHFa2zhAae4gXbYfJL13pjezymLpQoKAf9ySXLEFsXv0+FRKHLdSXkfA3G
	 LwpzG3ayeiIquYffgAQxx0ZOz6upBqGhUVr4V3O2+VMHR2+gTgEpvxxnr4++D0lkNl
	 ZvXx8xcLUHXtNukEPQLSTsPQ/jzKRXL1WKqe/htNRIhiGXCAVIgFtq0Wo1EHZ4h/eT
	 +TiazWAiIyFh5olNCi3K9S3CIjVvVaLhuy1IEfRXmbD6KDchapF2mmZquFK765IQA9
	 0Rd58xPxrTTfQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 2C1E8475CE;
	Tue, 28 Apr 2026 03:47:32 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next 0/4] r8152: Add support for the RTL8159 10Gbit USB
 Ethernet chip
Date: Tue, 28 Apr 2026 05:47:20 +0200
Message-Id: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMgt8GkC/x2MUQqAIBAFrxL7nZBiWV0lIqTWWggLlRCiu7f18
 T4GZt4NEQNhhL64IeBFkQ7PIMsC5s36FQUtzKAq1VRaGRHS3sq6mzwmXk5CO2Na20jtrAHOzoC
 O8n85AFvis2B8nhdqz1OhbAAAAA==
X-Change-ID: 20260427-rtl8159_net_next-4f778a614fa7
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: E967547D258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-281616-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
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
Birger Koblitz (4):
      r8152: Add support for 10Gbit Link Speeds and EEE
      r8152: Add support for the RTL8159 chip
      r8152: Add irq mitigation for RTL8157/9
      r8152: Add firmware upload capability for RTL8157/RTL8159

 drivers/net/usb/r8152.c | 328 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 316 insertions(+), 12 deletions(-)
---
base-commit: 35c2c39832e569449b9192fa1afbbc4c66227af7
change-id: 20260427-rtl8159_net_next-4f778a614fa7

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


