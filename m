Return-Path: <netdev+bounces-268703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIdAIbmZuWn5KwIAu9opvQ
	(envelope-from <netdev+bounces-268703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:13:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072432B0B5D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CC703165226
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5363CBE80;
	Tue, 17 Mar 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="u5b2iZQo";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="YyqIFcuu"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3DD37EFEA;
	Tue, 17 Mar 2026 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770851; cv=none; b=mQ7swWxTr2viJNwt9WJeiAXvK7/e73c+AlhiXk05xxFYYqu+Wr5N49koIgt4OkJ5wGZVmh/VDXDiocvUFRgCIH8r0egn2iDdva72GXpR/JLQA14AGHlBrk9ChDXSmD7lPgs5KqABrXUJtqRRHbpVDRnzskTfhfAmfAFhXmmfGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770851; c=relaxed/simple;
	bh=/8NsNfH+U0ic+gnfuK0JltAWFOTdlMBGBp3cV0V1agg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HzHz5CfPNHISYn2CKGj+reCSdk9TP5rWKfmNc2l9FsiMc9tfa1HGLv2NbE9idtlv3dygCoLO83aowFw22gAw3pqyIo5qr0CeqZ7syk6HNcPKleBVAfk9HYqhKhplYSLn97sFh7cYqBqUZ/inbkhnv0EAaykL7JKxByUtpndf3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=u5b2iZQo; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=YyqIFcuu; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773770844;
	bh=/8NsNfH+U0ic+gnfuK0JltAWFOTdlMBGBp3cV0V1agg=;
	h=From:Subject:Date:To:Cc:From;
	b=u5b2iZQo32D0b2do+faBBq7M8zX/AcThoKC4qTILa08zII7a7y+T2XtEYvc9A9Is2
	 9BbuSP71heJox8QHjcAHXLZxAUquWWi4G5fcHZuwoam01D9dtGXGhSvYDod9bDaRWG
	 jcIvPM2KJsHULpSEdwW6VxKoYDPemzkMZPzXZhTzUe3XARkgCXSxW+iWD35aJvcCiD
	 uT0aK6cERUN4QO8v8senRjcpyaD9zdHdSt9Nn4GGYKgU5OKLHTmYbv/4jkaYzFsS3n
	 OquXOKpaPfBfgm8riClUTA3SZUoDRCzCjk2LALOEIauRSa2HKWUTwQg1iknN7RL0iJ
	 J4hkGSyJs8TAw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2D7A93FDF1; Tue, 17 Mar 2026 18:07:24 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773770843;
	bh=/8NsNfH+U0ic+gnfuK0JltAWFOTdlMBGBp3cV0V1agg=;
	h=From:Subject:Date:To:Cc:From;
	b=YyqIFcuuMkYlqS3OlJ1/8HD9YD/DxExDXWEo3rtRsXtawYKSLO+5wKoYVnvyvcDu4
	 55yy9ECzOs1+9Z2SXPryZFZZJf6MHmuM+uJizqBQWNzJORXqDJgIGwukAM1mvwKlUH
	 Mljxe2nWF5OID2trrhcsPp6ajgOiK0uDpBx7Mx0D1IIZ/Bu5NWAgZgtzlC2bvQUIsr
	 YfXiSwqE/fJfRMULDl6ZkyzjsTLd8auV11kYBI6Wy7CG2EHhN9gzLFrx8+8ySm8hMD
	 9LteLcTTARImOT5RXB9T/pX9j0ElTOI+/E4aaNt1330h2hc9OccF9QHO/yMcmmpbuD
	 /YWkweOjnqIaQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 1FB5E3FDE5;
	Tue, 17 Mar 2026 18:07:23 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v2 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
Date: Tue, 17 Mar 2026 19:07:13 +0100
Message-Id: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFGYuWkC/22NwQ6CMBBEf4Xs2TW0IFRP/ochppUFNpJitg1BC
 f9u5exx8mberBBImAJcshWEZg48+RT0IYPHYH1PyG3KoHNd5YUqUeJo1Km+e1oiWlKmMgW5srO
 QJi+hjpdddwNPEX8taBIZOMRJ3vvPrHb+XzkrzPHsbF27UhvbtVfH0pPgc3Ijx8+xJWi2bfsCJ
 wjFuroAAAA=
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	TAGGED_FROM(0.00)[bounces-268703-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 072432B0B5D
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
Changes in v2:
- Fixed missing initialization of ret value in wait_cmd_ready()
- Combine all parts with RTL8157-specific code to avoid undefined functions
- Link to v1: https://lore.kernel.org/r/20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de

---
Birger Koblitz (2):
      r8152: Add support for 5Gbit Link Speeds and EEE
      r8152: Add support for the RTL8157 hardware

 drivers/net/usb/r8152.c | 1092 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 845 insertions(+), 247 deletions(-)
---
base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
change-id: 20260314-rtl8157_next-ae18683eb4fa

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


