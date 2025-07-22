Return-Path: <netdev+bounces-208775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E94B0D15B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B461540106
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 05:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53321CC43;
	Tue, 22 Jul 2025 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Uu9YoWEN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMfwrdP0"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957B2AE8B;
	Tue, 22 Jul 2025 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163202; cv=none; b=T4kp2XFAmx6Lm0ln6MGpSLktjrQivH9/5M3xJ1Mifj3aA1M2Zyz970fX2oHOTXc/SPdkqOvL7DryctN2ZjLFruQE7M2iTRnM2Xk7YrNtd0DvEg4c3xAIUrIb5lxqct1zKMjfuBLTY66ZMuydLYGWQ6xLvHzAakG48evArMlVFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163202; c=relaxed/simple;
	bh=7s/9THL+pva5ta7A1N4beUww8mQiHWpz9djvOtt5jY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WORiZunyF42GyV7jrgEIXPV5tEwgF3St5plSN9M5g1smRxPX8At+7f19tyvfeVeA2NwW2rNex+mpMc9ADCm4D6dXVvQHpgCOhsPZeQfYa5Rv0kR3984Qe602KNI9P8V4h97uJUtJKutsv1HspwBT9bC+LcLZ4U/DNDfiO6WoDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Uu9YoWEN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMfwrdP0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D52FEC022E;
	Tue, 22 Jul 2025 01:46:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 22 Jul 2025 01:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753163197; x=1753249597; bh=uR7w+rk1IP
	LBNFKRvuJDo+Irx9SQicd4yP1XI2gUdEQ=; b=Uu9YoWENxMVR+YibCwsQQ3UjbJ
	1e6c/m7U95AVvYqEGlrJo1J4GWHagd0ldVqMUXCC/swWxTl7Ffnbc6sA5iCtqOvN
	+TUGJo/A5/TCK/dvAabXx965gGiKA8xVBW+OQdO9yRdfHBxO2OiL+DEmFMTJXhnP
	kb4oGRZkbTbyCe905a3vSXT+ax8Ku17qKko9UoImb0uY0pnB3VgJ+XMhguPai74x
	eCadtPDVvZnEljznfm/cfT3bimQ6bvzNwn0XOppZGHHqEp2Z8RVo9PHjY7CncWmo
	1Sj3N6firLpKep5GFGxtTnKABpO+PLqmtUIQBjb3QojHJvo+6szI0LnlzSmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753163197; x=1753249597; bh=uR7w+rk1IPLBNFKRvuJDo+Irx9SQicd4yP1
	XI2gUdEQ=; b=EMfwrdP0Xj1koZRUFnM1svCC+UvZnhsgRmV//i4d9jCUvLtnbyd
	ExctFGoICY928wIenePyHxcFy/5g3bYEqksAxGoiE6auFCeMpWcVLHcjv46JdP52
	XcVWvyJ3Aq78sAUCD1RFFvXqoFSVrnjPMeG6I9li+8eSXybS7m5PJ5SHNCj2qlCs
	WGNdOF1S3ncPGrkbQ5hhX3F0MK+tRC9AY4focuebtr86qkSkO8BV3oLN/kWxrtES
	ggpQyyH3n1FY0Rn73DIFl29O5W9sHOqj3X5UaOKUEV2TG48E6mD/U32lYP9VdpZC
	5zRi/wp+cWx0eJHZ9L7oCgfqN/F9mVTKawQ==
X-ME-Sender: <xms:vCV_aBgTOhncGcTEjmJr_CWZGSHeqGZbPhAQMgX73zcEUW3Os0b9lw>
    <xme:vCV_aGJCvZd2318FohAYOqPsmLzt3YixHUHxCYFe-eicyKw9pUFIUWlGVN22gNT3r
    amg7HmmgLyFcQ>
X-ME-Received: <xmr:vCV_aIhkxloVCPMeI9g7jRERnDORDogKjpmAr2DjrrQGFjKWhxZhi5aNUxC4-vcY0EAFvKzTqp9ZJgPPXbL5ZXtACXSJN0FJ81ZNHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peihihgtohhnghhsrhhfhiesudeifedrtghomhdprhgtphhtthhopehonhgvuhhkuhhmse
    hsuhhsvgdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdr
    tghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihitghonh
    hgsehkhihlihhnohhsrdgtnh
X-ME-Proxy: <xmx:vCV_aM2d8S4sGNmcr8vbTa4Ds4Ri55JU3wDkWuuOlg4zPoqsiXiJ5g>
    <xmx:vCV_aGiCCWsE6n_LxY7JPsq1WjslZN474DXJG1CZ1D7m_HX83acxQA>
    <xmx:vCV_aF_7QBp7K7OYM7KhR0fniCqrBGaAkl6qMejV-9UQiuCjVay_CQ>
    <xmx:vCV_aKLUwOAoXU77gUI-8fPcJbG8EXLxzZu3Ce8Z2Oa6QWCteY3HUA>
    <xmx:vSV_aEgptUDHF3WR-tAgdWLJSQra_oLkHT875FNkvIuoOqS08Ko7vnRE>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 01:46:36 -0400 (EDT)
Date: Tue, 22 Jul 2025 07:46:34 +0200
From: Greg KH <greg@kroah.com>
To: yicongsrfy@163.com
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: Re: [PATCH] net: cdc_ncm: Fix spelling mistakes
Message-ID: <2025072210-spherical-grating-a779@gregkh>
References: <20250722023259.1228935-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722023259.1228935-1-yicongsrfy@163.com>

On Tue, Jul 22, 2025 at 10:32:59AM +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> According to the Universal Serial Bus Class Definitions for
> Communications Devices v1.2, in chapter 6.3.3 table-21:
> DLBitRate(downlink bit rate) seems like spelling error.
> 
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> ---
>  drivers/net/usb/cdc_ncm.c    | 2 +-
>  include/uapi/linux/usb/cdc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 34e82f1e37d9..057ad1cf0820 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -1847,7 +1847,7 @@ cdc_ncm_speed_change(struct usbnet *dev,
>  		     struct usb_cdc_speed_change *data)
>  {
>  	/* RTL8156 shipped before 2021 sends notification about every 32ms. */
> -	dev->rx_speed = le32_to_cpu(data->DLBitRRate);
> +	dev->rx_speed = le32_to_cpu(data->DLBitRate);
>  	dev->tx_speed = le32_to_cpu(data->ULBitRate);
>  }
>  
> diff --git a/include/uapi/linux/usb/cdc.h b/include/uapi/linux/usb/cdc.h
> index 1924cf665448..f528c8e0a04e 100644
> --- a/include/uapi/linux/usb/cdc.h
> +++ b/include/uapi/linux/usb/cdc.h
> @@ -316,7 +316,7 @@ struct usb_cdc_notification {
>  #define USB_CDC_SERIAL_STATE_OVERRUN		(1 << 6)
>  
>  struct usb_cdc_speed_change {
> -	__le32	DLBitRRate;	/* contains the downlink bit rate (IN pipe) */
> +	__le32	DLBitRate;	/* contains the downlink bit rate (IN pipe) */
>  	__le32	ULBitRate;	/* contains the uplink bit rate (OUT pipe) */
>  } __attribute__ ((packed));

You are changing a structure that userspace sees.  How did you verify
that this is not going to break any existing code out there?

thanks,

greg k-h

