Return-Path: <netdev+bounces-73895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41D285F229
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 08:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0537283E77
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 07:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56917998;
	Thu, 22 Feb 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wa+DyDzQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482ED179A8
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588300; cv=none; b=HpRafZ7Ff6GZoZE2Bs4HX64FGkZcUrOt8gh/JnNyagpxDniFoDtZFsvkpfxenBDK9ExDz6O4rnSOMxaHUz2hY/DypqMLGpPNugR9og4mt9cM4QuM3JTVaNAgkvjEx3Y8kADzXlGHRLx6FuCHbYBKc9cio9GNE1XEWFMzIk6Crv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588300; c=relaxed/simple;
	bh=Q0so5ndfFY7Gi2zVE26BMxMVaOGvf2BWHikTduPSUJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDtksicqOG/VFXaYYpBV73fzu6tOt2OJn/f91wAphqv5OF21M/ucsjePr9pqkhCbk0VcaIEfFHv45QvRsZJcUIAwvPhAqluB2pwkY5ODepGortdKZHnW1cn4c1q9TkQeOQ6UMg3rWSr1+kPPTL06NLqqYOU1t5DX05D2VD/ZMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wa+DyDzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D2BC433F1;
	Thu, 22 Feb 2024 07:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708588299;
	bh=Q0so5ndfFY7Gi2zVE26BMxMVaOGvf2BWHikTduPSUJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wa+DyDzQp++ecP/od6DnEgf0GAJeWr3gjld8Yt6tn2gn4b3z0kwpIzVDli6FdR1Ui
	 roTlFFBzEDDJz3upHkgM/nqKwGwjoEa3LPj1aCaVpJY6uauO9Q2wnQJWqw7V0WAtXx
	 yDjbDBJn/o+ooKtQ6/sWQ69tREQO9d9mDeHz7RTw=
Date: Thu, 22 Feb 2024 08:51:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>,
	Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <2024022214-alkalize-magnetize-dbbc@gregkh>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
 <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220173309.4abef5af@kernel.org>

On Tue, Feb 20, 2024 at 05:33:09PM -0800, Jakub Kicinski wrote:
> Greg, we have a feature here where a single device of class net has
> multiple "bus parents". We used to have one attr under class net
> (device) which is a link to the bus parent. Now we either need to add
> more or not bother with the linking of the whole device. Is there any
> precedent / preference for solving this from the device model
> perspective?

How, logically, can a netdevice be controlled properly from 2 parent
devices on two different busses?  How is that even possible from a
physical point-of-view?  What exact bus types are involved here?

This "shouldn't" be possible as in the end, it's usually a PCI device
handling this all, right?

thanks,

greg k-h

