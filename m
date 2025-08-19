Return-Path: <netdev+bounces-215056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40493B2CF25
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02303BE2FB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF5F353371;
	Tue, 19 Aug 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vb7YpClR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C54353347
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641620; cv=none; b=UpQDjkRZ6tHaXTHwlInQ7R3wKOTV6KsVeV8ZwEatI7pH/zjdvzcO81d8Rg4l/q2ZSAvocK7kvL03hj+YtNaHHFqSopOBaP/KtynizcgtrfZimwTMUPerP1WtWDzmPk0VIOpK+4j8aKZLmY2KLBAhwl9k2EvXB7Yl88qA1ejMS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641620; c=relaxed/simple;
	bh=JdTQTHXLY7Buj9M2df1e+v13uj8j4VNFOuiTELHRd6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GScl07cmzVGofPbqDYQZuLh+HGJlu2zhKl003SsvYGS0D2L3eXjCf/z3+O/9GPgysoI9PKBUQTF+4MMPdUnHMfDkTYjrYWBF0YYpQngOb8ZVUC+nwFrODi/UPxuT7Pu/z3htBYo71B8YiWcL6Ob/u02NS+W8qKejOCaxvJ50s60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Vb7YpClR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5ArRDWxijJwEfa54JxIkP6oK2yGMB5YGAPJxOKIT670=; b=Vb7YpClRcthH4qP6gYHMb50PXT
	fdcJprc6O6HJDm/goAwJ3sInSbRn1wLXU7brZbioPNmFQcF6CHG5n18Og3taR3CKrlRkHmhFE/HLu
	oKmmFTBHWAIIsBQeRNCWA4Na7SxfgPYEclS/ZqcD0a06W1/a6KHny0x/5P3O+2q4equg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoUaG-005EzV-A2; Wed, 20 Aug 2025 00:13:36 +0200
Date: Wed, 20 Aug 2025 00:13:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Ilya A. Evenbach" <ievenbach@aurora.tech>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] [88q2xxx] Add support for handling master/slave in
 forced mode
Message-ID: <57412198-d385-43ef-85ed-4f4edd7b318a@lunn.ch>
References: <20250819212901.1559962-1-ievenbach@aurora.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819212901.1559962-1-ievenbach@aurora.tech>

On Tue, Aug 19, 2025 at 02:29:01PM -0700, Ilya A. Evenbach wrote:
> 88q2xxx PHYs have non-standard way of setting master/slave in
> forced mode.
> This change adds support for changing and reporting this setting
> correctly through ethtool.

Please could you Cc: Dimitri Fedrau <dima.fedrau@gmail.com>. He has
done most of the work on this driver.

> Signed-off-by: Ilya A. Evenbach <ievenbach@aurora.tech>
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 107 ++++++++++++++++++++++++++++--
>  1 file changed, 102 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index f3d83b04c953..1ab450056e86 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -9,6 +9,7 @@
>  #include <linux/ethtool_netlink.h>
>  #include <linux/hwmon.h>
>  #include <linux/marvell_phy.h>
> +#include <linux/mdio.h>

I'm curious. What is needed from this?

	Andrew

