Return-Path: <netdev+bounces-238847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 646DDC601EE
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 10:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54E014E4C9C
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC2D246768;
	Sat, 15 Nov 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="IQ4N5Bry"
X-Original-To: netdev@vger.kernel.org
Received: from forward401d.mail.yandex.net (forward401d.mail.yandex.net [178.154.239.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3F1DF73C;
	Sat, 15 Nov 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763197516; cv=none; b=XMbk0q5Rx2TyK69PkQpLUy5FNzXAZGB20ul446Jkqk5e0l2T/N+YSsAHQjpUCMbodPGahy/N70SFfXlaEFzdKw2llm8fhCEUeLTukAsWHsYRP6BOqZbXNWgXa+KjitedMzPIGvmTQ81/FxNxcdBpdTSJOVDSWHCX7WV2vzyMb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763197516; c=relaxed/simple;
	bh=QHeVxLFgGBwm+NvWeQDGr/u9pd8nn5gstD/uSItVTCQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=C/MPeUYjQJAZosJjW3TjgGSai/I4vqhz05sBXEzo0qlwnSpnUqvRPX7lzBXFFGEWvUfMoHO+kvIO7bfYjmY+n3JWvkLlcjwzrtxkQsAk00Qo8KUp1c5dp618pfdbdJI5fcX2Y8L9mAwJ59mU7balcI7P5MBUyZ+kjg/vB6gbRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=IQ4N5Bry; arc=none smtp.client-ip=178.154.239.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8a9a:0:640:e327:0])
	by forward401d.mail.yandex.net (Yandex) with ESMTPS id 9B3DC811B4;
	Sat, 15 Nov 2025 11:58:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NwN8AvOLUKo0-01x6eePi;
	Sat, 15 Nov 2025 11:58:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1763197105; bh=QHeVxLFgGBwm+NvWeQDGr/u9pd8nn5gstD/uSItVTCQ=;
	h=Subject:From:To:Date:Message-ID;
	b=IQ4N5BryHODFyRhLRbOI0m5r0ux04C2KGJNPwQtQuNLOiHLd4oe/7smT4sFCrPSjK
	 Hfa5EA5csUPDKNvITTb25/uIrVRRwImCiYWCv3TeqtcQS+auCD5Aljxy17PPU52Ong
	 z8lF0M68xqUFZsyV0Iakz3JjJCCaokkteNW1sEIk=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <1c3f0582-4c92-41b3-a3db-5158661d4e1a@ya.ru>
Date: Sat, 15 Nov 2025 11:58:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: WGH <da-wgh@ya.ru>
Subject: cdc_ncm doesn't detect link unless ethtool is run (ASIX AX88179B)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

I'm running Linux 6.17.7, and recently obtained a UGREEN 6 in 1 hub containing an AX88179B chip.

By default, it uses the generic cdc_ncm driver, and it works mostly okay.

The annoying problem I have is that most of the time the kernel doesn't notice that the link is up. ip link reports NO-CARRIER, network management daemon doesn't configure the interface, and so on.

The workaround I found is to run ethtool enp6s0f4u1u2c2. As soon as I do that, NO-CARRIER disappears, and network connection configures normally.

There are no interesting dmesg messages. No link status reports, just a couple of messages just after driver initiialization.

Nov 14 12:51:47 sixty-four kernel: usb 5-1.2: new SuperSpeed USB device number 19 using xhci_hcd
Nov 14 12:51:47 sixty-four kernel: usb 5-1.2: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 2.00
Nov 14 12:51:47 sixty-four kernel: usb 5-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Nov 14 12:51:47 sixty-four kernel: usb 5-1.2: Product: AX88179B
Nov 14 12:51:47 sixty-four kernel: usb 5-1.2: Manufacturer: ASIX
Nov 14 12:51:47 sixty-four kernel: usb 5-1.2: SerialNumber: 0000000000BE7F
Nov 14 12:51:47 sixty-four kernel: cdc_ncm 5-1.2:2.0: MAC-Address: XX:XX:XX:XX:XX:XX
Nov 14 12:51:47 sixty-four kernel: cdc_ncm 5-1.2:2.0: setting rx_max = 16384
Nov 14 12:51:47 sixty-four kernel: cdc_ncm 5-1.2:2.0: setting tx_max = 16384
Nov 14 12:51:47 sixty-four kernel: cdc_ncm 5-1.2:2.0 eth0: register 'cdc_ncm' at usb-0000:06:00.4-1.2, CDC NCM (NO ZLP), XX:XX:XX:XX:XX:XX
Nov 14 12:51:47 sixty-four kernel: cdc_ncm 5-1.2:2.0 enp6s0f4u1u2c2: renamed from eth0


