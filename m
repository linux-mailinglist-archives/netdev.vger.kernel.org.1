Return-Path: <netdev+bounces-284490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM7QDCgU+mlRJAMAu9opvQ
	(envelope-from <netdev+bounces-284490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:00:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 672CC4D0CBD
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B7530ADC15
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92248A2B5;
	Tue,  5 May 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="uGPLqxWH";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ylmwI8p5"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111CA365A1A;
	Tue,  5 May 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996601; cv=none; b=kqb5VsUbYrSNreXl6wT7241Sp7jSXQSk2VdhjaFV7dofkFnrZuJw4GH7mA0cSLjF3yxKLZ/0Ff7IEx3cv89jAIreRTTfrbt2qFg3s0Q6xIbbSA+RDZF7hPaAzpcljWFylrlzfFLNx5ECcAjBKPA/7hraxt7CuzC29d+E5YxvQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996601; c=relaxed/simple;
	bh=alsWWFsozKxA87f3+rU3VZeze2WtHL7ooX75HoJQIM0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KutGhB0NyauBwipG2LUlUF1qBJAo5HCVde4Umnf6vdQiWxh1xyJ+dVSdLP17Vvcq57X3TPVqVCO6Zh8akc/VRIld5Rml6uzdr8yI2dF2yJgtgqiuZKN6kfaF7eRgdIDLVy9iNldA1toXObB8PNn8a0bCvpRoewMt9OUxo6MApuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=uGPLqxWH; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ylmwI8p5; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777996598;
	bh=alsWWFsozKxA87f3+rU3VZeze2WtHL7ooX75HoJQIM0=;
	h=From:Subject:Date:To:Cc:From;
	b=uGPLqxWHsbdP8PNN9hvOz/MphCaZXruJh4YSor2+onAB+t2JaGUqiIWR2cgQMumQ/
	 ONh3LTdSbKUR1X6ln5tWO/k5eW957bzwzkALJx/RDy6DdrG9sAOwkLA0GRYd4lV5fj
	 N9SQ6cFVWPtSfmooLkm3r4KTLMRaqQLUQwUJEHaVJeMy5aRknyKQG9BhT3TNNsGfzt
	 2wrNcPcTnneWP7XpuusoeVaGFj/k4B2QmxfVYxEnEBOmjolVyHaVDcKiQryQhXT7gp
	 KwKMCI95m0XovKEOVQM1nUh4QCqjR4sR2dy5NQSEl96CKhx/ZVXmckfb/2qg9zuUb9
	 EIMUzkODUPJIw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 51F6A42541; Tue,  5 May 2026 15:56:38 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777996597;
	bh=alsWWFsozKxA87f3+rU3VZeze2WtHL7ooX75HoJQIM0=;
	h=From:Subject:Date:To:Cc:From;
	b=ylmwI8p5Qi+9kY63t07VBAu+FuAw4wvxy2bataYNVbi9oixK+FaacFkcpifAzhyai
	 5Z+UGIc1bzrxmoMavQMHTIyoINrD91q5QvCkSyKjSLlCbFoPByPEDAKEvZ4O/ea7qM
	 XrasXe/Gmf6ddqJjQH7gzJXBrhxlAkaroTjAIxZkO2F0wnqC1CwzmNRQizaZHrNNpI
	 IqHv3v+NJeler1Yf2oKwTTLrXVLzT7AcB8L8B1Tvx9Q1nAsyzTiSRfdE2Yfkt8XktP
	 6DbnlOfZTNw+HYRwwskWkWgNfTGCMcW6woWd1NsG9eGMM03fhH8S13R6NzSaejz/wA
	 mNYxXmB9Ypq6g==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E909542464;
	Tue,  5 May 2026 15:56:36 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v4 0/3] r8152: Add support for the RTL8159 10Gbit
 USB Ethernet chip
Date: Tue, 05 May 2026 17:56:32 +0200
Message-Id: <20260505-rtl8159_net_next-v4-0-1a648a9c4d8d@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADAT+mkC/3XN0QqCMBQG4FeRXbfYjnPTrnqPiHDbUUeiMYdY4
 ru3JCjILs7Fz/nPd2YyoHc4kEMyE4+jG1zfxSB2CTFN2dVInY2ZAAPJBCjqQ5vzrLh0GOJMgYp
 KqbyUXFSlIvHs5rFy00qeSGzRV4uc46ZxQ+j9ff018nX/ZvNfduSU0QwsSwtQWsjqqJ2v0dNrr
 1sXHnuLKzrCN1RsQBAhXerUWIHCSPkPSj9QxmADSiPEweRFZoU0dhNaluUJjNR4XFQBAAA=
X-Change-ID: 20260427-rtl8159_net_next-4f778a614fa7
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Andrew Lunn <andrew@lunn.ch>, 
 Aleksander Jan Bajkowski <olek2@wp.pl>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 672CC4D0CBD
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
	TAGGED_FROM(0.00)[bounces-284490-lists,netdev=lfdr.de];
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
Changes in v4:
- Fix formatting and spelling in r8157_hw_phy_cfg()
- Set RTL8152_INACCESSIBLE when r8159_wait_backup_restore() times out
- More documentation on RX aggregation/descriptor settings
- Link to v3: https://lore.kernel.org/r/20260502-rtl8159_net_next-v3-0-12c895d46cd6@birger-koblitz.de

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

 drivers/net/usb/r8152.c | 345 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 325 insertions(+), 20 deletions(-)
---
base-commit: 0f19519fdd22bc0f5429377da3a52327c5eee166
change-id: 20260427-rtl8159_net_next-4f778a614fa7

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


