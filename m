Return-Path: <netdev+bounces-238843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F6C60168
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 09:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDB6A35A485
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16B91DD9AD;
	Sat, 15 Nov 2025 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="vkza4/By"
X-Original-To: netdev@vger.kernel.org
Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B973C1F;
	Sat, 15 Nov 2025 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763193781; cv=none; b=ePA/2FkEVVFyJ/kAKhdNRMc1F7VahDy9YryYN5Tl7tyGWep3jYcGx5gm8E4z47jCY9NMt59v0YlX8H3sf2QIsI1TMAzy+Irif7PVCNsENg5tgqJecyzVpfmqGQSoc2hJBykjvAigULZzykACZiWj+W4XFZG0CYqIwGuUgRP1Dgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763193781; c=relaxed/simple;
	bh=ZYxCC1MLhxgo/w97YqVwens9+hm78HiCTOEwZbynlz4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OwbLoSKR7ttBjtU5nw3WRBKrJMY6L5ztA1W/VlqcI3ipw8h+Pk5CGGd7efsbhc9WDPKjL5EsAfG9BBTTh/Yis0VVui97oXwwKTMLAFCYaW9gPcwhmF7UJm9n3X4HuYNXTVMjmYtC0fce5rCz/hFHT+bZcwRxDGUtQg4OKL52/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=vkza4/By; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id BA64385570;
	Sat, 15 Nov 2025 10:56:03 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:86a2:0:640:3ad2:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 434FBC005D;
	Sat, 15 Nov 2025 10:55:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ptMswmTMqa60-dHpwjREg;
	Sat, 15 Nov 2025 10:55:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1763193353; bh=ZYxCC1MLhxgo/w97YqVwens9+hm78HiCTOEwZbynlz4=;
	h=Subject:From:To:Date:Message-ID;
	b=vkza4/ByT8JDCSbBeCx3yFpdVeZIkmUYz513Txtg9OMiXGHV02oVIQLE2L90h6nw6
	 E0I9Zvxk6krTRE7pQWNd8bLGqTn2bjH65upGo7bIpqBqWu95C+Uzke3agl1jIRvhdk
	 GwmFClPHWqs5a9q4h0+Bv+vY5rYtJdNKfS1CEY8A=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <834f63b7-2016-4036-b880-1f3a01dafaaa@ya.ru>
Date: Sat, 15 Nov 2025 10:55:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 freddy@asix.com.tw, jtornosm@redhat.com
From: WGH <da-wgh@ya.ru>
Subject: ax88179_178a spams "Link status is: 0" and doesn't work
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello.

I'm running Linux 6.17.7, and recently obtained a UGREEN 6 in 1 hub containing an AX88179B chip.

By default, it uses cdc_ncm driver, which mostly works, but has other issues (that would be another report).

I can switch the device to another mode with a udev rule so it would use the device-specific ax88179_178a driver:

ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0b95", ATTR{idProduct}=="1790", ATTR{bConfigurationValue}!="1", ATTR{bConfigurationValue}="1"

However, it doesn't work in this mode. The link never becomes up, and dmesg spams the following messages ad infinum:

Nov 13 22:15:49 sixty-four kernel: usb 4-1: new high-speed USB device number 7 using xhci_hcd
Nov 13 22:15:49 sixty-four kernel: usb 4-1: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=64.00
Nov 13 22:15:49 sixty-four kernel: usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 13 22:15:49 sixty-four kernel: usb 4-1: Product: USB2.1 Hub
Nov 13 22:15:49 sixty-four kernel: usb 4-1: Manufacturer: GenesysLogic
Nov 13 22:15:49 sixty-four kernel: hub 4-1:1.0: USB hub found
Nov 13 22:15:49 sixty-four kernel: hub 4-1:1.0: 4 ports detected
Nov 13 22:15:49 sixty-four kernel: usb 5-1: new SuperSpeed USB device number 8 using xhci_hcd
Nov 13 22:15:50 sixty-four kernel: usb 5-1: New USB device found, idVendor=05e3, idProduct=0625, bcdDevice=64.00
Nov 13 22:15:50 sixty-four kernel: usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 13 22:15:50 sixty-four kernel: usb 5-1: Product: USB3.2 Hub
Nov 13 22:15:50 sixty-four kernel: usb 5-1: Manufacturer: GenesysLogic
Nov 13 22:15:50 sixty-four kernel: hub 5-1:1.0: USB hub found
Nov 13 22:15:50 sixty-four kernel: hub 5-1:1.0: 4 ports detected
Nov 13 22:15:51 sixty-four kernel: usb 5-1.2: new SuperSpeed USB device number 9 using xhci_hcd
Nov 13 22:15:51 sixty-four kernel: usb 5-1.2: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 2.00
Nov 13 22:15:51 sixty-four kernel: usb 5-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Nov 13 22:15:51 sixty-four kernel: usb 5-1.2: Product: AX88179B
Nov 13 22:15:51 sixty-four kernel: usb 5-1.2: Manufacturer: ASIX
Nov 13 22:15:51 sixty-four kernel: usb 5-1.2: SerialNumber: 0000000000BE7F
Nov 13 22:15:51 sixty-four kernel: cdc_ncm 5-1.2:2.0: MAC-Address: XX:XX:XX:XX:XX:XX
Nov 13 22:15:51 sixty-four kernel: cdc_ncm 5-1.2:2.0: setting rx_max = 16384
Nov 13 22:15:51 sixty-four kernel: cdc_ncm 5-1.2:2.0: setting tx_max = 16384
Nov 13 22:15:51 sixty-four kernel: cdc_ncm 5-1.2:2.0 eth0: register 'cdc_ncm' at usb-0000:06:00.4-1.2, CDC NCM (NO ZLP), XX:XX:XX:XX:XX:XX
Nov 13 22:15:51 sixty-four kernel: cdc_ncm 5-1.2:2.0 eth0: unregister 'cdc_ncm' usb-0000:06:00.4-1.2, CDC NCM (NO ZLP)
Nov 13 22:15:52 sixty-four kernel: ax88179_178a 5-1.2:1.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x0040: -32
Nov 13 22:15:52 sixty-four kernel: ax88179_178a 5-1.2:1.0 eth0: register 'ax88179_178a' at usb-0000:06:00.4-1.2, ASIX AX88179 USB 3.0 Gigabit Ethernet, XX:XX:XX:XX:XX:XX
Nov 13 22:15:53 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: renamed from eth0
Nov 13 22:15:53 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: Failed to read reg index 0x0040: -32
Nov 13 22:15:56 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:57 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:57 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:57 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:57 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:57 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:57 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:57 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:57 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:58 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0
Nov 13 22:15:58 sixty-four kernel: ax88179_178a 5-1.2:1.0 enp6s0f4u1u2: ax88179 - Link status is: 0

Curiously, ethtool reports that the link is up, gives correct speed indication, some details about link partner, etc. ip link still says NO-CARRIER. ip link set dev down + up doesn't help.

There're some suggestions on the internet to either load cdc_mbim first, or add cdc_ncm prefer_mbim=Y option, but that doesn't help either.


