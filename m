Return-Path: <netdev+bounces-282516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFB6AN9/8mkMsAEAu9opvQ
	(envelope-from <netdev+bounces-282516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:02:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87849AC61
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B217300B538
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363583DA7CF;
	Wed, 29 Apr 2026 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="raqBXhiz"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F83D3D00
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500115; cv=none; b=qXW0LDV9Cbj9bbgwGRGdDYeVf9wRhnWt7TVFooUUjii2d2jXYwMvrBEYsJ0PjaSphSCOAXFS0Bzt79dTc7qzGUGaKTSGse6OEp4sv2eBC1edrQGzenAZWq6SKouRcECn827u3BSAGaHpPUdXqRVfdeIrN3KHjnCXUTqhXb/NFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500115; c=relaxed/simple;
	bh=II8ohc7sAflHsxrnYUmI1YeNTdEz7x/i9ebrFLATSzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPodnYT0ZR+OxnY1DxkUPEyQGtzjqhanBO6uvhxhtC8PVWesCKlpaakPkuYBnL7L1v4Z8YIm29F6M/cwYm/k9dvCH0zvj32qhx7qe1uIg7SoLQuZGg/KXCUX5msFceToDu/ET5X77sgvUlA1bE0TfJPXo0fMb7ZTJKXtjocmW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=raqBXhiz; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 13658 invoked from network); 30 Apr 2026 00:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1777500099; bh=gEC+cmPxfUXymzPv1HP4xx1muA0vheqZwmJZV7UsrwM=;
          h=Subject:To:Cc:From;
          b=raqBXhizveNI/ME2riBAjXoA78ASWuE2MNh2/eG6jDB5j8ST0etzpSamGqyXvPToP
           J+f+Ia5HeQkRZtuV8UT7q0XcLLa+/ch3zfEWwsvcgHW8x2nVrn4h8T+8zLvPL3BFzw
           NoKKnbw9xv6nj6erkko3zykJaK12yXl+jUj6GZhc8pDOHvMF/9mjruwt9+zTNQrL65
           RydGHTSHIBhfd8yF6djS+IciO9GAAEcfqMnk0rU029HLUkPWS9fvPfcLrWrsncfqlu
           XOrTBj0SisAU6FwJVO+igof1yKH8ivXZIMPJcs6kSQE+7RG8v/XBKApLyPDVd9khkS
           KVzEDUQm3GGbw==
Received: from 83.24.138.167.ipv4.supernova.orange.pl (HELO [192.168.3.203]) (olek2@wp.pl@[83.24.138.167])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <mail@birger-koblitz.de>; 30 Apr 2026 00:01:39 +0200
Message-ID: <998ace9a-9f27-4467-b4ab-8581cf37f81e@wp.pl>
Date: Thu, 30 Apr 2026 00:01:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/4] r8152: Add support for the RTL8159 10Gbit
 USB Ethernet chip
To: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>,
 Andrew Lunn <andrew@lunn.ch>
References: <20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: c125cb5f65505aed24f4d9e665418429
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [QeIc]                               
X-Rspamd-Queue-Id: 0C87849AC61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-282516-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[wp.pl:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[wp.pl];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,wp.pl:dkim,wp.pl:mid,birger-koblitz.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi Birger,
I ran a few tests on the RTL8157 and RTL8159. The 1/2.5/5/10G link
establishes correctly. The device also behaves normally under iperf load.
Everything is working fine so far.

On 29/04/2026 19:01, Birger Koblitz wrote:
> Add support for the RTL8159, which is a 10GBit USB-Ethernet adapter
> chip in the RTL815x family of chips.
>
> The RTL8159 re-uses the frame descriptor format and SRAM2 access introduced
> with the RTL8157 as well as most of the setup and PM logic of the RTL8157.
>
> The module was tested with a Lekuo DR59R11 USB-C 10GbE Ethernet Adapter:
> [ 2502.906947] usb 2-1: new SuperSpeed USB device number 3 using xhci_hcd
> [ 2502.927859] usb 2-1: New USB device found, idVendor=0bda, idProduct=815a, bcdDevice=30.00
> [ 2502.927867] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=7
> [ 2502.927871] usb 2-1: Product: USB 10/100/1G/2.5G/5G/10G LAN
> [ 2502.927873] usb 2-1: Manufacturer: Realtek
> [ 2502.927875] usb 2-1: SerialNumber: 000388C9B3B5XXXX
> [ 2503.063745] r8152-cfgselector 2-1: reset SuperSpeed USB device number 3 using xhci_hcd
> [ 2503.123876] r8152 2-1:1.0: Requesting firmware: rtl_nic/rtl8159-1.fw
> [ 2503.126267] r8152 2-1:1.0: PHY firmware installed 0 to be loaded: 20
> [ 2503.156265] r8152 2-1:1.0: load rtl8159-1 v1 2026/01/01 successfully
> [ 2503.270729] r8152 2-1:1.0 eth0: v1.12.13
> [ 2503.289349] r8152 2-1:1.0 enx88c9b3b5xxxx: renamed from eth0
> [ 2507.777055] r8152 2-1:1.0 enx88c9b3b5xxxx: carrier on
>
> The RTL8159 adapter was tested against an AQC107 PCIe-card supporting
> 10GBit/s and an RTL8157 5Gbit USB-Ethernet adapter supporting 5GBit/s for
> performance, link speed and EEE negotiation. Using USB3.2 Gen 2 (20GBit) with
> the RTL8159 USB adapter and running iperf3 against the AQC107 PCIe
> card resulted in 8.96 Gbits/sec transfer speed.
>
> The code is based on the out-of-tree r8152 driver published by Realtek under
> the GPL.
>
> The RTL8159 requires firmware for the PHY in order to achieve a 10GBit link
> speed. Without firmware, only 5GBit were achieved. The firmware can be
> extracted from the out-of-tree r8152 driver-code where it is stored in the
> ram17 u8-array. Code is added to use the existing firmware upload mechanism
> of the driver for the RTL8157/9 PHY firmware code. The firmware will be
> submitted separately to linux-firmware.
>
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
> Changes in v2:
> - Correct formatting of comments
> - Order case statement values correctly
> - Add error message when backup-restore fails
> - Correct commit message of support for firmware upload
> - Link to v1: https://lore.kernel.org/r/20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de
>
> ---
> Birger Koblitz (4):
>        r8152: Add support for 10Gbit Link Speeds and EEE
>        r8152: Add support for the RTL8159 chip
>        r8152: Add irq mitigation for RTL8157/9
>        r8152: Add firmware upload capability for RTL8157/RTL8159
>
>   drivers/net/usb/r8152.c | 336 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 324 insertions(+), 12 deletions(-)
> ---
> base-commit: 35c2c39832e569449b9192fa1afbbc4c66227af7
> change-id: 20260427-rtl8159_net_next-4f778a614fa7
>
> Best regards,

