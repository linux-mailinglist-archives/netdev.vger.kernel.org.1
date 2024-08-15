Return-Path: <netdev+bounces-118852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9D8953183
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1831F20D47
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C219E7F6;
	Thu, 15 Aug 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJFUZX7s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAEF18D630
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730099; cv=none; b=Mm+WJ8S+3GBr3SK24Ya8RC7YcOGuvrwtJXGfU7Qj0nccuyvQzU3L5MIC7u8w1JI6HU4pJoA9FX7DO4BNUBO3mWfheUysg/WDDBLFA8BdW52qvJ0bsMPAcqxPAC85SXiQ7QLdRMnWprriCTNFZ8/fPGM8hpFmzjLdsAsxOPZbyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730099; c=relaxed/simple;
	bh=2nGwVmAuV5sBDAPQFOZ97VIZRihj1+2yle7vjGBl5TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ1qEc6D19mmZmKdj1RGlK9bNxIoRbgZFNOi6FkjkemDWNdHeDAC7Q0QmKIcXy6D1piqBvNdjLBpEprHKimtK6GwSribjFcAXCQWeDDeG6RBu2T48atXw+CMULAgbhR7L5aD7pM7kSaW7eQ32Qstk8u51ZOQNUhq7YjTgbKJ4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJFUZX7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F136C32786;
	Thu, 15 Aug 2024 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730099;
	bh=2nGwVmAuV5sBDAPQFOZ97VIZRihj1+2yle7vjGBl5TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJFUZX7sPfpLJZfQQE2w6SwEjnXKskl/pkmXGjCPr9K5X9beLxLOGTsarS6evRXNk
	 2D9feLdrahSqIwmNZ3XFcqW7PIZyfoqKgfxD7xHmdVuEEBy6Nh2PYRLoHcY/SW93mE
	 NyAeoVSIO4Y7K4hzoweTRnxzcRqXnaLfICdlTHA6i9Ep+MMI4p5bYwTZ8DXtBsvjcc
	 +4dqRPt2tOYPK1I6tgj0YsEF6i4gMuoBqHz6rx7KiKvt717m+4YQajFUkiEi9bx0Tz
	 4lIUH73kfeMGoUGMschzenE9uT7FVBU2vvZKlEW7sADE2Tre7EriUcpNHRveXMma6/
	 1g1zjv97MDkYQ==
Date: Thu, 15 Aug 2024 14:54:55 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
Message-ID: <20240815135455.GE632411@kernel.org>
References: <20240815125905.1667148-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815125905.1667148-1-vadfed@meta.com>

On Thu, Aug 15, 2024 at 05:59:04AM -0700, Vadim Fedorenko wrote:
> Starting v6.8 the serial port subsystem changed the hierarchy of devices
> and symlinks are not working anymore. Previous discussion made it clear
> that the idea of symlinks for tty devices was wrong by design. Implement
> additional attributes to expose the information. Fixes tag points to the
> commit which introduced the change.

Hi Vadim,

Would it be possible to provide a link to the discussion(s)?

> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

...

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c

...

> @@ -3346,6 +3352,54 @@ static EXT_ATTR_RO(freq, frequency, 1);
>  static EXT_ATTR_RO(freq, frequency, 2);
>  static EXT_ATTR_RO(freq, frequency, 3);
>  
> +static ssize_t
> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *ea = to_ext_attr(attr);
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +	struct ptp_ocp_serial_port *port;

nit: Port is unused in this function, it should be removed.

> +
> +	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
> +}

...

