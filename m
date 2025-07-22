Return-Path: <netdev+bounces-208790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E356B0D246
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A85A3B5B30
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D361F2D321F;
	Tue, 22 Jul 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OOkC2QXm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ww7uH3OR"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0B288531;
	Tue, 22 Jul 2025 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167398; cv=none; b=AqTS00lP+lbRVvVN6QJ8vxWiz02PEC1VloRieeUs328fz+b3d+gnutnPpn3RSY+Q7eMeA+rZfXVXmghOHifF60wAE4lu61p6/nZms3J70vYiKO4qE9bXpnvG88raIlfmPTCe1/FQvxsdRZqABB3UoaWkD9OqQwF2HEWVhCP5ifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167398; c=relaxed/simple;
	bh=hFs7T04GEFGyITmeVPHN+VfTjB0+neCcUNoRHF/j2dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtoERtbwjhDQMEePIxiDZ/hDCMud3LMtYGyCvXeskM6mmRLaUoPFd6gDHa0WOhiree+7Vf8gZsu7LC2k8pEEkWjPsg8kgRhEdmZiKqiglTcaUI5fpyOjpElnnfsaU90vlJEfgFIsi3uGWGhGs+kFWDBP4/HhU2sAOObGNHavuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OOkC2QXm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ww7uH3OR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B4431D0025A;
	Tue, 22 Jul 2025 02:56:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 22 Jul 2025 02:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753167394; x=1753253794; bh=uGY9BsEeIL
	KTrH/0zTBWPPYxfOItM7EoqFgUX4QR+vU=; b=OOkC2QXmSdiicQajDmYA/yo/y+
	pJ26TfFIWa4OuTMr14EhG93wRzzplTZbypFFp/HN1T8wJJwgm8aNmX5lfWPI77BI
	mUobAM+xq3yZqEC2bmGQjjWC6jgVWAE39lKmxpda8nU2CmfKDtklky9z02Q2sVzQ
	eolG8VvCi/K79Iw9KTa4qaFQORtI++iY8r9RA4EH8vlvEkPkUlal5kMGOt9c+pBy
	A4k0RDJs2iq3FpOzlk79Ee08xI0qK86pOwESRct/Pj7JUj3yJ12niiVXJqHmRdbe
	bFINSya2KFNK5EGnstqV+fB9mOJaM1ULVCZwBC09gFLjHQrFKKso1pKjyexg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753167394; x=1753253794; bh=uGY9BsEeILKTrH/0zTBWPPYxfOItM7EoqFg
	UX4QR+vU=; b=Ww7uH3OR2njUXo131ozux7laVC8TL6L9TRRLUN9T4CvYbKTOPm9
	1lJfZD7wFaDJRqfSgl3VBFlXazH+zWcA7z011Uq/WELnUgKmjSlkAOLPxhtz46Su
	GfGB9AYRXns0oUs6Pz85QGx6Xs2k1kZO9ZeCQZ9X/Ab+il4eEY2Hj6BgDi6n6MHc
	ZJq3xUxWAL9YPDy5Ww2KemxdpMiFTnln6a6ymaxceXdL7y1ng0ImK1nYFATjCEMM
	lxTu8IqJcdPKqDIaYcWdmDyjTteUiN3hfZqaePmYc3ev+EFczVio30+CBetKvx6S
	nuCxefy/xSxulM8o2h3l5h7bgZDDW4YpaGA==
X-ME-Sender: <xms:ITZ_aIhJSBN057YNdh7MoLh3GwSmM6wbt6LFWIVTUr_0tYwwZRks5g>
    <xme:ITZ_aBIQ8yNF42Fkp77xf1J0HusOLoGQwhppYUwttkW11xexO_RXr6wkiOI_yqKdj
    IHvnZlWQrturw>
X-ME-Received: <xmr:ITZ_aHgYu6KowRxuICXLVmTKAuuY7pBefDioRZdDhV_aBEK_7EOXUdUTwy87-vOdyVNr5mAqrH92K-zbbR6lH-i8UKsKLKghyWD9Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecu
    ggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtd
    eufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedugedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohephihitghonhhgshhrfhihseduieefrdgtohhm
    pdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtth
    hopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhinhhugidq
    uhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehonhgvuhhkuhhmsehsuhhsvgdr
    tghomhdprhgtphhtthhopeihihgtohhngheskhihlhhinhhoshdrtghn
X-ME-Proxy: <xmx:ITZ_aP3aC60cyfiH5BO-nMWCdQhauL0TVv73hlmKo4bp96mMRwk6qg>
    <xmx:ITZ_aNivbrdePE1yK46yePf4vrnAyF0VzdWFTXyM0CJ0zWxrf6A6Iw>
    <xmx:ITZ_aA_0Z4uBTyoW4_MMbyyTF37JO-eJUaJGPTC3VfTrFlYeMQX-0A>
    <xmx:ITZ_aJLXBvSlZYERDg1vuIPmM7OgIHoZkvtenaaRM7fel1WOw0dqCw>
    <xmx:IjZ_aB9EbzJ18qKb2aD9Q7x4cT3KAlO7PjctL8Xb_F0EJAetUYbzGLJH>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 02:56:33 -0400 (EDT)
Date: Tue, 22 Jul 2025 08:56:31 +0200
From: Greg KH <greg@kroah.com>
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oneukum@suse.com, yicong@kylinos.cn
Subject: Re: [PATCH] net: cdc_ncm: Fix spelling mistakes
Message-ID: <2025072223-frugally-dish-fcdf@gregkh>
References: <2025072210-spherical-grating-a779@gregkh>
 <20250722065143.1272366-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722065143.1272366-1-yicongsrfy@163.com>

On Tue, Jul 22, 2025 at 02:51:43PM +0800, yicongsrfy@163.com wrote:
> On Tue, 22 Jul 2025 07:46:34 +0200	[thread overview] Greg <greg@kroah.com> wrote:
> >
> > On Tue, Jul 22, 2025 at 10:32:59AM +0800, yicongsrfy@163.com wrote:
> > > From: Yi Cong <yicong@kylinos.cn>
> > >
> > > According to the Universal Serial Bus Class Definitions for
> > > Communications Devices v1.2, in chapter 6.3.3 table-21:
> > > DLBitRate(downlink bit rate) seems like spelling error.
> > >
> > > Signed-off-by: Yi Cong <yicong@kylinos.cn>
> > > ---
> > >  drivers/net/usb/cdc_ncm.c    | 2 +-
> > >  include/uapi/linux/usb/cdc.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> > > index 34e82f1e37d9..057ad1cf0820 100644
> > > --- a/drivers/net/usb/cdc_ncm.c
> > > +++ b/drivers/net/usb/cdc_ncm.c
> > > @@ -1847,7 +1847,7 @@ cdc_ncm_speed_change(struct usbnet *dev,
> > >  		     struct usb_cdc_speed_change *data)
> > >  {
> > >  	/* RTL8156 shipped before 2021 sends notification about every 32ms. */
> > > -	dev->rx_speed = le32_to_cpu(data->DLBitRRate);
> > > +	dev->rx_speed = le32_to_cpu(data->DLBitRate);
> > >  	dev->tx_speed = le32_to_cpu(data->ULBitRate);
> > >  }
> > >
> > > diff --git a/include/uapi/linux/usb/cdc.h b/include/uapi/linux/usb/cdc.h
> > > index 1924cf665448..f528c8e0a04e 100644
> > > --- a/include/uapi/linux/usb/cdc.h
> > > +++ b/include/uapi/linux/usb/cdc.h
> > > @@ -316,7 +316,7 @@ struct usb_cdc_notification {
> > >  #define USB_CDC_SERIAL_STATE_OVERRUN		(1 << 6)
> > >
> > >  struct usb_cdc_speed_change {
> > > -	__le32	DLBitRRate;	/* contains the downlink bit rate (IN pipe) */
> > > +	__le32	DLBitRate;	/* contains the downlink bit rate (IN pipe) */
> > >  	__le32	ULBitRate;	/* contains the uplink bit rate (OUT pipe) */
> > >  } __attribute__ ((packed));
> >
> > You are changing a structure that userspace sees.  How did you verify
> > that this is not going to break any existing code out there?
> 
> Your question is very valid. I can only guarantee that the devices
> in my possession do not involve references to the relevant structures,
> but I'm not sure the behavior of other vendors' implementations,
> which may vary.
> 
> So, perhaps it would be better to keep things as they are?

Yes please.

