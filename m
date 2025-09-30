Return-Path: <netdev+bounces-227299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E341BAC145
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E827A8411
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AD2D24B1;
	Tue, 30 Sep 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cyM7yJcF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6C257458;
	Tue, 30 Sep 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221486; cv=none; b=CvMhcjgB5yePLKnKp1lzavT95Q+SHTFdOgE0nSZ8q2Wrdk9H/VuKyg41TlK0abqi/PH9H6DQsUFsV+8qN+G76UVn6wukKZKeY+ZHo0lXHkEr02DFsRAnFY4TA28scxCqgnTEAYMzuXAtsa0UijEZWQ94S6ulz0k+x6TrR4jQJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221486; c=relaxed/simple;
	bh=gsbL75hNEAEaA5dqfpbojQwUG4F+Ojiq2CPj27wn8Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aePikoZUWSgh9Peidz5LBPtQEdtnEJKhpUGcM90o9Xk2lb2pxKsiSg7/huEGufsXO29NFQzqPfbgKpHedGx4CFMIDrqTZAfKhFJmIMpEKW2fLK1tN8VnvUgi1vcMGnJr3qsNcUmwducQB/Ltiq3tVLRhlEHlf96VHVXvBFLshZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cyM7yJcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFABC113D0;
	Tue, 30 Sep 2025 08:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759221486;
	bh=gsbL75hNEAEaA5dqfpbojQwUG4F+Ojiq2CPj27wn8Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyM7yJcF8zpCOOfVPqWWQx4Hk3oNBPxfavEcTKBX2vPb7mUkbqm6H/uN1ZRVWbndj
	 Uo/S8dIXlk6ifPRDLkY8FLMmlsIlN2lnMP1FtWkn8DW4Oj2wayd50IOfDK+2y2qtj5
	 2ULloOpoYEnlLL3KPw5HbfM/wOphRdfMk5En3mEw=
Date: Tue, 30 Sep 2025 10:38:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yicongsrfy@163.com
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	marcan@marcan.st, netdev@vger.kernel.org, pabeni@redhat.com,
	yicong@kylinos.cn
Subject: Re: [PATCH v4 2/3] net: usb: support quirks in cdc_ncm
Message-ID: <2025093035-unwoven-humiliate-a315@gregkh>
References: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
 <20250930080709.3408463-1-yicongsrfy@163.com>
 <20250930080709.3408463-2-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250930080709.3408463-2-yicongsrfy@163.com>

On Tue, Sep 30, 2025 at 04:07:08PM +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> Some vendors' USB network interface controllers (NICs) may be compatible
> with multiple drivers.
> 
> I consulted with relevant vendors. Taking the AX88179 chip as an example,
> NICs based on this chip may be used across various OS—for instance,
> cdc_ncm is used on macOS, while ax88179_178a.ko is the intended driver
> on Linux (despite a previous patch having disabled it).
> Therefore, the firmware must support multiple protocols.
> 
> Currently, both cdc_ncm and ax88179_178a coexist in the Linux kernel.
> Supporting both drivers simultaneously leads to the following issues:
> 
> 1. Inconsistent driver loading order during reboot stress testing:
>    The order in which drivers are loaded can vary across reboots,
>    potentially resulting in the unintended driver being loaded. For
>    example:
> [    4.239893] cdc_ncm 2-1:2.0: MAC-Address: c8:a3:62:ef:99:8e
> [    4.239897] cdc_ncm 2-1:2.0: setting rx_max = 16384
> [    4.240149] cdc_ncm 2-1:2.0: setting tx_max = 16384
> [    4.240583] cdc_ncm 2-1:2.0 usb0: register 'cdc_ncm' at usb-
> xxxxx:00-1, CDC NCM, c8:a3:62:ef:99:8e
> [    4.240627] usbcore: registered new interface driver cdc_ncm
> [    4.240908] usbcore: registered new interface driver ax88179_178a
> 
> In this case, network connectivity functions, but the cdc_ncm driver is
> loaded instead of the expected ax88179_178a.
> 
> 2. Similar issues during cable plug/unplug testing:
>    The same race condition can occur when reconnecting the USB device:
> [   79.879922] usb 4-1: new SuperSpeed USB device number 3 using xhci_hcd
> [   79.905168] usb 4-1: New USB device found, idVendor=0b95, idProduct=
> 1790, bcdDevice= 2.00
> [   79.905185] usb 4-1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [   79.905191] usb 4-1: Product: AX88179B
> [   79.905198] usb 4-1: Manufacturer: ASIX
> [   79.905201] usb 4-1: SerialNumber: 00EF998E
> [   79.915215] ax88179_probe, bConfigurationValue:2
> [   79.952638] cdc_ncm 4-1:2.0: MAC-Address: c8:a3:62:ef:99:8e
> [   79.952654] cdc_ncm 4-1:2.0: setting rx_max = 16384
> [   79.952919] cdc_ncm 4-1:2.0: setting tx_max = 16384
> [   79.953598] cdc_ncm 4-1:2.0 eth0: register 'cdc_ncm' at usb-0000:04:
> 00.2-1, CDC NCM (NO ZLP), c8:a3:62:ef:99:8e
> [   79.954029] cdc_ncm 4-1:2.0 eth0: unregister 'cdc_ncm' usb-0000:04:
> 00.2-1, CDC NCM (NO ZLP)
> 
> At this point, the network becomes unusable.
> 
> To resolve these issues, introduce a *quirks* mechanism into the usbnet
> module. By adding chip-specific identification within the generic usbnet
> framework, we can skip the usbnet probe process for devices that require a
> dedicated driver.
> 
> v2: Correct the description of usbnet_quirks.h and modify the code style
> v3: Add checking whether the CONFIG_USB_NET_AX88179_178A is enabled
> v4: Move quirks from usbnet.ko to cdc_ncm.ko
> 
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> ---
>  drivers/net/usb/cdc_ncm.c        | 15 +++++++++++-
>  drivers/net/usb/cdc_ncm_quirks.h | 41 ++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/usb/cdc_ncm_quirks.h
> 
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 5d123df0a866..fc8416af3f11 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -54,6 +54,8 @@
>  #include <linux/usb/cdc.h>
>  #include <linux/usb/cdc_ncm.h>
>  
> +#include "cdc_ncm_quirks.h"
> +
>  #if IS_ENABLED(CONFIG_USB_NET_CDC_MBIM)
>  static bool prefer_mbim = true;
>  #else
> @@ -2114,10 +2116,21 @@ static const struct usb_device_id cdc_devs[] = {
>  };
>  MODULE_DEVICE_TABLE(usb, cdc_devs);
>  
> +static int cdc_ncm_probe(struct usb_interface *intf, const struct usb_device_id *prod)
> +{
> +	/* Should it be ignored? */
> +	if (unlikely(cdc_ncm_ignore(intf))) {

There is no performance issue here, so please do not use unlikely/likely
unless you can prove with a benchmark that it is needed.

thanks,

greg k-h

