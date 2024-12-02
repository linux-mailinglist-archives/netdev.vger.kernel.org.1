Return-Path: <netdev+bounces-147975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E689DF9B5
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 04:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC64C16277E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3D71E260D;
	Mon,  2 Dec 2024 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="NvaMaGS7"
X-Original-To: netdev@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142017C2
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733111834; cv=none; b=XhUnp6KlikjFVmh7xbyimvsTs5b5KlDf50DJvXh2lyfa31Y61vZxu3XrVjYldVThxBobVECRdqfKxell72Py+ZcOc8AU8VxP1ezc8h0M6m/5PwxazxnoAIL20di5wvaQoSULmU8QtNgCBrXTqDH9SY9T/S+/DQd68Zq05Fcqn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733111834; c=relaxed/simple;
	bh=lvRgxLkC9lDXJdMG2vSTeFG6EcXZW70sZ7LUOmHlaPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzJFirruSTygznaNJde6iuRtnVDhEdeIpoxheFi0vSHr2Z7WHsIbhByFBZOdNGdrPjFN186qFBUW5X/ioHY4hY7isTt0qIofDrSRgKpAXDOwMXvePt3o1maEEc+oxB12qwtA+WsgBnEpdjZ+E3cwZnvDLFzUHss1SH/mDWtopt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=NvaMaGS7; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=NvaMaGS7;
	dkim-atps=neutral
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id B044C540
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 12:50:29 +0900 (JST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee3aa6daaaso2870410a91.3
        for <netdev@vger.kernel.org>; Sun, 01 Dec 2024 19:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1733111429; x=1733716229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HQEXIyZsrJ4f5Rfkkqm9DWJBB35YS/0AB032iPU8C8=;
        b=NvaMaGS7Lhs6gOfneg6q/yuMW0oKGkzAIEDbu9Iari/2K3IaYGExy6Ew6a1HpQBVJh
         KFzrlrRh7N92+5iigaCtT+BWiFN0CHcRGOOA8rpQbJF2eOMAbwnjtydtzja5mjxwRtk7
         hu2uAkufheMT5jFv/l2eWxWs3A6NFSiFjstPO+CRubRDL8eRoeqQ2SvYi4fS35FK5Sx7
         ZK3DuLNqLU1LkuqTFnSQrtzQ9BGjQWsL2AswSMs6Dzv7+yx+P/8a++gJlHUdcM5WQz7M
         JkY3VcrG+6GfvqsucIy2CO9GW6lzcC2YflQvr4WuThooB0tFiWfO5ye01+0RLrz3F0Pt
         puvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733111429; x=1733716229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HQEXIyZsrJ4f5Rfkkqm9DWJBB35YS/0AB032iPU8C8=;
        b=wNAM2Poi4AfBTqXAxznMDBdyjRmvj3Mjg69/vSMmOymyoyd2gMXKqUxUI/sak6hRDm
         wYBG9Y0Yghy+ngtDNF/JSRxPd3vf15BS7+8xm1H+60M8dfO2HC+nDC8aTeGb8hjC0SAg
         yKc5I8HGCOD+rBWOEH7HibDud1GbdI9NWrpUBf2G0SfKd/TEKx9La1mhqSbbz1cjMZRq
         rYf4EPRiHuynArqK+c/PMIcss1V42QFwdTurxbxEhoQyHoAjfI5C4tP0AYX8DfiOcaXJ
         il7G7UEAb3xpZI2bFeMtXnX/zeolN/wkstSURIJhzNiLJS5+4yA7uMXQNNxhOztipnHb
         S/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWeJHlydnnMmIDc+vCJCL+tvh8kU8rS8Crf5sc4U0ZWf3zbT6wuz6Jy6o6UGO6cPNT9FiEUpuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytcDI7ya4Ay2z/XTX0A99Z4zoG3pzvU3QI3cF4S/Zh3ms/kZSg
	3TgSq2OFZOhItsm23ex5atUcnbu/F0v1HgWQlAqz3Ew+qWXvgbDObsCds7DWRHpsqFq6e9u8jIr
	yQD4Fy+Vbwd466GOLf5kL1rkD5xU9G8unvlfiugAeYSbQr9R8AbUmPCQ=
X-Gm-Gg: ASbGncv/JCzre+sNIfLYEuaaYyaFE1dZouVokMfOMt2JjtelaFXfODsSL0NHwjUqNdE
	gpqfsSuY4VHYQMJzt7w9ZjXEaCF2JfEbPGjaBc+HJ05x8lAkheMEUpQ3Z0t/oUJyQ2eCOlXDSC/
	k+ekn9umyAK9vAeIRGFeuu4FCC0TOOBIkmZd7EDZo2wM0MftaEFppEoppYOW03OWqsfi3Adq9JJ
	JpkXAP1GbeL4pgO2vbmx19fRIY/ghLD87pL4Y2iNc+E3r+dwO+PBcJDQNxhhyFsuwLauruOIyAw
	fdoocoB6dnjYsOhp0EZRaM7FrT7CIVLpZw==
X-Received: by 2002:a17:90b:4c0a:b0:2ee:9d57:243 with SMTP id 98e67ed59e1d1-2ee9d570daamr7510205a91.1.1733111428762;
        Sun, 01 Dec 2024 19:50:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGrUfdYidb3+4gC1zE+19HgdSQ327HlbWrWwlG5RjKT0brQPVbmrEquIDL+z2sNxk15FEVzg==
X-Received: by 2002:a17:90b:4c0a:b0:2ee:9d57:243 with SMTP id 98e67ed59e1d1-2ee9d570daamr7510191a91.1.1733111428381;
        Sun, 01 Dec 2024 19:50:28 -0800 (PST)
Received: from localhost (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eec5eabec6sm963644a91.34.2024.12.01.19.50.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Dec 2024 19:50:27 -0800 (PST)
Date: Mon, 2 Dec 2024 12:50:15 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <Z00udyMgW6XnAw6h@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017071849.389636-1-oneukum@suse.com>

Hi,

Oliver Neukum wrote on Thu, Oct 17, 2024 at 09:18:37AM +0200:
> The fix for MAC addresses broke detection of the naming convention
> because it gave network devices no random MAC before bind()
> was called. This means that the check for the local assignment bit
> was always negative as the address was zeroed from allocation,
> instead of from overwriting the MAC with a unique hardware address.

So we hit the exact inverse problem with this patch: our device ships an
LTE modem which exposes a cdc-ethernet interface that had always been
named usb0, and with this patch it started being named eth1, breaking
too many hardcoded things expecting the name to be usb0 and making our
devices unable to connect to the internet after updating the kernel.


Long term we'll probably add an udev rule or something to make the name
explicit in userspace and not risk this happening again, but perhaps
there's a better way to keep the old behavior?

(In particular this hit all stable kernels last month so I'm sure we
won't be the only ones getting annoyed with this... Perhaps reverting
both patches for stable branches might make sense if no better way
forward is found -- I've added stable@ in cc for heads up/opinions)


> +++ b/drivers/net/usb/usbnet.c
> @@ -1767,7 +1767,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  		// can rename the link if it knows better.
>  		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
>  		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
> -		     (net->dev_addr [0] & 0x02) == 0))
> +		     /* somebody touched it*/
> +		     !is_zero_ether_addr(net->dev_addr)))

... or actually now I'm looking at it again, perhaps is the check just
backwards, or am I getting this wrong?
previous check was rename if (mac[0] & 0x2 == 0), which reads to me as
"nobody set the 2nd bit"
new check now renames if !is_zero, so renames if it was set, which is
the opposite?...

>  			strscpy(net->name, "eth%d", sizeof(net->name));
>  		/* WLAN devices should always be named "wlan%d" */

Thanks,
-- 
Dominique Martinet

