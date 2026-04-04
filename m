Return-Path: <netdev+bounces-275329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOw9Mo7E0GmV/wYAu9opvQ
	(envelope-from <netdev+bounces-275329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 09:58:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305A39A4BA
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 09:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C7A630156D1
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4D3932E8;
	Sat,  4 Apr 2026 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="QWFdPKNU";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0Qxo/aXI"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E491391E77;
	Sat,  4 Apr 2026 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775289475; cv=none; b=OcvtPPIWM2C1jE1zLwpqZGYQTgXU0Ovw2U2wVGZ9+kN5cOUyCsakPYKukcRenkpc1QTJFpSozcbsoixX3ls0HUXjdBod6zOeeBIz2Gntz2bqwbFHYSbebNO/6HK1wApCVN3AN5MZW6GOk02Klmzsj/eF0X2M5uFzLzkvZaEVg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775289475; c=relaxed/simple;
	bh=HSA4XXlFe/7R4lYayCn9qoPsvOqGd7lInoL17bV4kPY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Elbk+8aYVDuzezRqokQ/8Ic3xfrF6JXyWpdR0dP3VdtRtehMWOv/kYnDx1sX8qzkaqEmTxTNNczjCCTsxnPyk/KOlKwkBNHqPJm2tRtTXCNjvF977t5HXx/BOdSBeiDg9QXE6oFdocYBVDYlMalAS/R4Izs4lak3d8YPX9/Mrq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QWFdPKNU; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0Qxo/aXI; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775289464;
	bh=HSA4XXlFe/7R4lYayCn9qoPsvOqGd7lInoL17bV4kPY=;
	h=From:Subject:Date:To:Cc:From;
	b=QWFdPKNUtEDSha+yupCzIt69OI5QXWrx1s36drS49Es7A2p5BpmDotSEiJKOYdbvU
	 Ioc7NzU6/hosw3uuxHDEDzJiTh9RGdefusAE44BPENioMSMgW2t1lGHpt7ComAlBpr
	 mISp/djE5044INeZmCdTvmuQFvKKFx3CTdbRn+CWmmhb102b7zvaVBgPWsVRFW2Y9j
	 COl+Hk2VEZFWiFjDZf/sS0PcQyzR4a9cZFCBR5ybpkmEv7J7ggzkwHdRtGEjU7qzyE
	 dWJk7oZ86EcOfDr8Z0Mt9iKVt2FkdP+5rG1oyuoxC2mj4PqO/wKM3ezDeRndDajDZr
	 K3O9JzQctEi2Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 39FE14090D; Sat,  4 Apr 2026 07:57:44 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775289463;
	bh=HSA4XXlFe/7R4lYayCn9qoPsvOqGd7lInoL17bV4kPY=;
	h=From:Subject:Date:To:Cc:From;
	b=0Qxo/aXIVp+VecORA56QL6XnuPc8+JaIn6/QiKem514Kniby5v/LgHYgMTuS1/OFA
	 13JKStmWt+VQ16vBTW62gBWvnCemaHsWEGPviUSLzqv66jMS5pNRs5Gf6xfRkLIJqc
	 q38J1FNwkkXfY8gNuX1kRpAo5uQ3aQEw+qGeUfauHviPuTF0eKEPjQSgtRzJh0Y31d
	 qEs5PJq9PIX80SVQpKnBqbrsJ1Nad4x2gJcJVVijdNsXDI/lbjN0YqqvG5gwLIL//Y
	 z9/RKobBYq1dHOooU/C+46GYleaKuY6sCXznih21p7IFwbj1qZqxCP0xfeKWYF5MZ0
	 acbg24FB7PSFA==
Received: from DebianDesktop.lan (p200300c69f04eb0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4D90040902;
	Sat,  4 Apr 2026 07:57:43 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v7 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
Date: Sat, 04 Apr 2026 09:57:41 +0200
Message-Id: <20260404-rtl8157_next-v7-0-039121318f23@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHXE0GkC/3XPy2rDMBAF0F8JWldFo4clZ9X/KKWMrFEiGuwiG
 5MH/vcq3tSIeHm5M2eYBxspJxrZ8fBgmeY0pqEvwb4dWHfG/kQ8hZKZFLIRCjTP08WBsd89XSe
 OBK5xiryOyMrKb6aYriv3yXqa+HOKfZXmnMZpyLf1zgxr/5qcgQveerTWa+kwhg+f8oky/xn8J
 U3390ArOMstYitEFgQEIUTUzgXYQ9QGkaJC1BNBitShjQHtHqK3SP2OLohQWoH0IAOZPcRsEAU
 VYgoSyCvRmuiUE3tI849oISukKQi23tpOtAoovkKWZfkD1vueAxMCAAA=
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-275329-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 4305A39A4BA
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
Changes in v7:
- Rebased to latest net-next
- Link to v6: https://lore.kernel.org/r/20260402-rtl8157_next-v6-0-a9b77c0931ef@birger-koblitz.de

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

 drivers/net/usb/r8152.c | 1013 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 811 insertions(+), 202 deletions(-)
---
base-commit: 3741f8fa004bf598cd5032b0ff240984332d6f05
change-id: 20260314-rtl8157_next-ae18683eb4fa

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


