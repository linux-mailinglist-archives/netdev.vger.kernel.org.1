Return-Path: <netdev+bounces-132538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F729920FB
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71254B20D23
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948218B467;
	Sun,  6 Oct 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="StLFW6X+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C518A928;
	Sun,  6 Oct 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244658; cv=none; b=YNEw/UWjw6kGnF3ao6jEYhhXKKHaNhAFEJux8enRL31CWX2zTid2WeqMIUrEVJlfcD0+a0lrC9OfoprsSrn9wElE+No2mGBBEDwRPMI7tXz5wTpMxK+ie9ykbvZcihmI7yi1EkGoK8j1AhCdNrdCXoPxdSk/QYlxSvJ0EDFhbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244658; c=relaxed/simple;
	bh=NaAeksuyumPPKGTEwplToq+blwjnMQFFuCBKS46rUpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0ddl2X9hDiSCPR5JPc/5bMKaaCXz22j0ZY4SOYITI81ffQvTG4DHVq/wOYEvvaSmFqEfHEU5JflFPYFpM8ESwH9hb85INEmyeZ8b3Hrs2ZYhxmYdnjQXXx1eF9xMkI+5ag7b7sG8KM6LxLBJgpRJ3FtPlFZirzTPWNmGetEBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=StLFW6X+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jN7z6AYwXqkGZiVhmRDIeH5XnKhJUF8QEaITG/CjezQ=; b=StLFW6X+cACRsgUZKXvpH50IVD
	sf8LKI4AwtnR0DmK9NuGjJfYw6lEPvJpykFLxw9gm6Lpj7TDlnC/GYxGb/IBJ42j6KuPQipKHpEYQ
	4P6o+TmCbmLIEXdjuY7btCMQVdDomcyiO+JCz5SOmqwuyciwFKPUB69Xt6daboQs5NSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxXNe-009Cgh-EA; Sun, 06 Oct 2024 21:57:26 +0200
Date: Sun, 6 Oct 2024 21:57:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk, netdev@vger.kernel.org, olteanv@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan
 configuration in dsa_user_set_wol
Message-ID: <32b408a4-8b2d-4425-9757-0f8cbfddf21c@lunn.ch>
References: <0d151801-f27c-4f53-9fb1-ce459a861b82@lunn.ch>
 <20241006161032.14393-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006161032.14393-1-pvmohammedanees2003@gmail.com>

On Sun, Oct 06, 2024 at 09:40:32PM +0530, Mohammed Anees wrote:
> Considering the insight you've provided, I've written the code below
> 
> static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
> {
> 	struct dsa_port *dp = dsa_user_to_port(dev);
> 	struct dsa_switch *ds = dp->ds;
> 	int ret;
> 
> 	ret = phylink_ethtool_set_wol(dp->pl, w);
> 
> 	if (ret != -EOPNOTSUPP)
> 		return ret;
> 
> 	if (ds->ops->set_wol)
> 		ret = ds->ops->set_wol(ds, dp->index, w);
> 		if (ret != -EOPNOTSUPP)
> 			return ret;

This can be simplified to just:

> 	if (ds->ops->set_wol)
> 		return ds->ops->set_wol(ds, dp->index, w);
> 
> 	return -EOPNOTSUPP;
> }

	Andrew

