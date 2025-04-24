Return-Path: <netdev+bounces-185404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F0A9A2F0
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E40C7A6B70
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 07:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB61B392B;
	Thu, 24 Apr 2025 07:09:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8910F9;
	Thu, 24 Apr 2025 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478577; cv=none; b=p6S3VEod8VTXncZc27nnfOv1k3z42ACBXShXYi44ZjTV1A7v2nJL9C8rxECeQVGIBt147+vQGWvWy/bgD4r/Hv443kXIwnQWfy8wil9XykgpVOqnLMeAj6e7F6JUKMwqDFDzy/Vfsyv4N4wBDX1ZDObkgnzlzljLtjJdlIs2vLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478577; c=relaxed/simple;
	bh=sLp3VTmXFwFdL/QtxIAmgPlUiMfX9n7GBJMrj4i3iU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7CC46yuftte70G/orSHYHc5YZqYKLkxkq4ulR9Klpy9dzLcQRnx/Sqzky5xTf52/TCY+usD/Be8f7dOK/LGdhHWpcvRqQRj4bmAxY0T43TTkffp2E19Pa5zp2Rf9yOPXhwfbFlOEOnC73c+VTu4xtaNIG9ZFi0xB4QVdSsGIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (unknown [95.90.241.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E266B61E64788;
	Thu, 24 Apr 2025 09:09:10 +0200 (CEST)
Message-ID: <990a6a3c-bc1e-4b42-b3ae-1ec849d48f5e@molgen.mpg.de>
Date: Thu, 24 Apr 2025 09:09:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: MAC address programmed by coreboot to onboard RTL8111F
 does not persist
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com,
 LKML <linux-kernel@vger.kernel.org>, Keith Hui <buurin@gmail.com>
References: <49df3c73-f253-4b48-b86d-fa8ec3a20d2c@molgen.mpg.de>
 <065dabff-dfcc-4a86-ba0e-e3d6de2d21fc@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <065dabff-dfcc-4a86-ba0e-e3d6de2d21fc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Heiner,


Thank you for your reply.

Am 22.03.25 um 14:04 schrieb Heiner Kallweit:
> On 22.03.2025 09:50, Paul Menzel wrote:

>> Keith Hui reported the issue *MAC address programmed by coreboot
>> to onboard RTL8111F does not persist* [1] below when using
>> coreboot:
>
> Why do you consider this a bug? IOW: Where is it specified otherwise?

Good question. I do not have the documentation or specification. On 
other boards the current coreboot – a FLOSS firmware – implementation 
worked. coreboot’s driver name is r8168 though, but I guess that is due 
to historical reasons.

>>> I am producing a coreboot port on Asus P8Z77-V LE PLUS on which this
>>> issue is observed. It has a RTL8111F ethernet controller without
>>> EEPROM for vital product data.
>>>
>>> I enabled the rtl8168 driver in coreboot so I can configure the LEDs
>>> and MAC address. Lights work great, but the MAC address always
>>> revert to 00:00:00:00:00:05 by the Linux r8169 kernel module. I
>>> would then have to reassign its proper MAC address using ip link
>>> change eno0 address <mac>.
>
> r8169 in a first place reads the factory-programmed MAC from the chip.
> If this is 00:00:00:00:00:05, then this seems to be an issue with your
> board.
> 
>>> The device appears to be taking the address I programmed, but r8169
>>> reverts it both on init and teardown, insisting that
>>> 00:00:00:00:00:05 is its permanent MAC address.
>>>
>>> Survival of coreboot programmed MAC address before r8169 driver is
>>> confirmed by a debug read back I inserted in the coreboot rtl81xx
>>> driver, as well as by temporarily blacklisting r8169.
>>>
>>> Vendor firmware is unaffected.
>>
> What do you mean with this? What vendor firmware are you referring to?

“vendor firmware” was meant to be the firmware shipped by Asus, that 
comes with the board. coreboot (and the payload) replaces this firmware, 
by flashing the coreboot image to the flash ROM chip.

>> Do you have an idea, where in the Linux driver that happens?
>
> See rtl_init_mac_address() in r8169, and rtl8168_get_mac_address()
> in Realtek's r8168 driver.

Thank you. Keith found a fix for the issue [2]:

> On mainboard/asus/p8z77-v_le_plus, programmed MAC address is being
> reverted with controller resets done at loading and unloading of Linux
> r8169 kernel module.
> 
> Ghidra examination of vendor BIOS reveals an additional sequence to
> program the MAC address into its ERI register block. This patch
> adds code to replicate that sequence, gated by a Kconfig so it's
> only included where necessary.

As stated in the beginning, I do not have have the datasheet, so cannot 
say, if this solution is how it’s supposed to work. (Why program it in 
too places?)

Thank you for you time again, and the pointers.


Kind regards,

Paul


>> [1]: https://ticket.coreboot.org/issues/579#change-2029
[2]: https://review.coreboot.org/c/coreboot/+/87436

