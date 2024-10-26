Return-Path: <netdev+bounces-139343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FA39B18F7
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EB31C20E42
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300881F951;
	Sat, 26 Oct 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNsNsQYu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5AD171D2;
	Sat, 26 Oct 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955557; cv=none; b=L7RtKVX/XxI74ZYyMScj637VGord8cDqHaZuIOODrqw7s3zMl8p6P5ru58miLNwzQbSdReWBcPAJYegLGSL6fzEBjAzciuaqG+PdkypkPHnaWxMRJm/25XXp5q4LRHNm5KKQ+IyLQsk/CWSiDH34iyuC/cq20nFzQFob+L9+l/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955557; c=relaxed/simple;
	bh=h1t/ImbmIC+Mm2/yutzWZ8n1ugWCvOYNxjLpHTrPdMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpqPMaxR6VrMTU8Ol9NmBIUmj+AjEb1tpf8cg5Z3upxc0P0MmpkWkXD3p1yZTkhh7mAgSe6Cxdzq6e8GgZRKK+jCRiQYXZDM41uT5uKSWEOTACFFxm685nz+u0J+j4xqHJC/f4CnA1lJGj355QKlXMfe4HQ3+/3fpvMOff+UO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNsNsQYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D507C4CEC6;
	Sat, 26 Oct 2024 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729955554;
	bh=h1t/ImbmIC+Mm2/yutzWZ8n1ugWCvOYNxjLpHTrPdMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNsNsQYue2vlBt/vf3DIQQy0mN7RxRGx+zSliHV5RSvG4Eq40m5Yd1+54HFxZnEml
	 1O1EXRfk5W80Y5w6t3/EDZ6oiNkR7Ll3EBgJ0wA5teikZuSUPuL4yx9BzMlDBTsdKj
	 wC85QQqdfqc2lrAT27eCUEeYbVUqj6plnAJfRDTbQrUwbqxQmhioN6F48wYxcHz4MK
	 TJBJwp+iC8Bf+p7gZTCg221CSF3FAPp4mZnK/hIxc/tsoDoiLruy1dIfHP3DDSSkhr
	 TJi/EzT1XuCxd1y7IXvRt/kWw5Tb+p5J/zpsrwD5fbD+Q1N5Mswk4qfXEgv6rrYx5Z
	 dnpbT9uV8U6Ew==
Date: Sat, 26 Oct 2024 16:12:29 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] eth: fbnic: Add devlink dev flash support
Message-ID: <20241026151229.GG1507976@kernel.org>
References: <20241012023646.3124717-1-lee@trager.us>
 <20241022014319.3791797-1-lee@trager.us>
 <20241024091032.GI402847@kernel.org>
 <13229808-dde5-4805-b908-ce65c8b342b4@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13229808-dde5-4805-b908-ce65c8b342b4@trager.us>

On Fri, Oct 25, 2024 at 03:32:32PM -0700, Lee Trager wrote:
> 
> On 10/24/24 2:10 AM, Simon Horman wrote:
> > On Mon, Oct 21, 2024 at 06:42:24PM -0700, Lee Trager wrote:
> > > fbnic supports updating firmware using a PLDM image signed and distributed
> > > by Meta. PLDM images are written into stored flashed. Flashing does not
> > > interrupt operation.
> > > 
> > > On host reboot the newly flashed UEFI driver will be used. To run new
> > > control or cmrt firmware the NIC must be power cycled.
> > > 
> > > Signed-off-by: Lee Trager <lee@trager.us>
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> > ...
> > 
> > > @@ -109,8 +110,274 @@ static int fbnic_devlink_info_get(struct devlink *devlink,
> > >   	return 0;
> > >   }
> > > 
> > > +/**
> > > + * fbnic_send_package_data - Send record package data to firmware
> > > + * @context: PLDM FW update structure
> > > + * @data: pointer to the package data
> > > + * @length: length of the package data
> > > + *
> > > + * Send a copy of the package data associated with the PLDM record matching
> > > + * this device to the firmware.
> > > + *
> > > + * Return: zero on success
> > > + *	    negative error code on failure
> > > + */
> > > +static int fbnic_send_package_data(struct pldmfw *context, const u8 *data,
> > > +				   u16 length)
> > > +{
> > > +	struct device *dev = context->dev;
> > > +
> > > +	/* Temp placeholder required by devlink */
> > > +	dev_info(dev,
> > > +		 "Sending %u bytes of PLDM record package data to firmware\n",
> > > +		 length);
> > Could you clarify what is meant by "Temp placeholder" here and in
> > fbnic_send_component_table(). And what plans there might be for
> > a non-temporary solution.
> 
> Temp placeholder may not have been the best wording here. pldmfw requires
> all ops to be defined as they are always called[1] when updating. fbnic has
> an info message here so its doing something but we have no current plans to
> expand on fbnic_send_package_data nor fbnic_finalize_update.
> 
> [1]
> https://elixir.bootlin.com/linux/v6.12-rc4/source/lib/pldmfw/pldmfw.c#L723

Thanks for the clarification. Perhaps the wording could be improved,
but I don't think that needs to block progress.

Reviewed-by: Simon Horman <horms@kernel.org>


