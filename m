Return-Path: <netdev+bounces-75848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B964A86B556
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F68E2849E9
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3A6200A8;
	Wed, 28 Feb 2024 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zyh4wDiv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5E6EEE4
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139328; cv=none; b=iKnPHprutLsIc+cmDJiKT+W9nU1yk2t8wwObHl3KR+qI6bfiB7BiWWAzm2UudbUJ/pjj/fxSF1TpjVzGxY+1vlusS/UOIcmh3DqOrIAwmvMCFWIHp+FHX/flF3wQsUY/FVdFry3P+BzHo0sa4UZ6gQBPzntRt1cQFNvxJELzUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139328; c=relaxed/simple;
	bh=k0H54fBdoUkhglwiCym9+MKNUt0fUQ5xaeqZoS9S/aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdtOXmdq0Ho1f1AEdpX5tcCcITTO9woj0SSlgAPearWQBQ3Bfy6P7fz4AUB07Zaq2p75i1ROvXAIVJ1vdQDZk15g/klVpOwdz+BO2AiiHmOfrODSW870i+O5Grsbpa0A+PglTajYSpSyHbBN26hR0pIiWv33euUSZ95OmsxdUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zyh4wDiv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ehI42BjlaSM6CR2Es80BK1Xx3zkmGJPnkbuGwV1x2wE=; b=Zyh4wDiv/3BviQaMgoj+HueyJA
	6+HJ6LgAI27CpAlFn8hajI2VH0MiOz8YuIpKm1zwH4NpFTxO3bbvumrefOtmGSREmqWG6g9eHpbau
	G9TAxrE9jbIuIDF/Bqtu31hjfh5IxkpHeYPcMpUIfINob3kR2EzkgfZznh15IWXJbqrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfNDV-008y5j-Gn; Wed, 28 Feb 2024 17:55:37 +0100
Date: Wed, 28 Feb 2024 17:55:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Patryk <pbiel7@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Question regarding handling PHY
Message-ID: <4b8413d0-272f-4e43-a699-5b3134cfbeab@lunn.ch>
References: <CA+DkFDZPdS+r0vdFp0EU_xh=05gu5VuqOrT7G_Nj5gdjM8OOcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DkFDZPdS+r0vdFp0EU_xh=05gu5VuqOrT7G_Nj5gdjM8OOcg@mail.gmail.com>

On Wed, Feb 28, 2024 at 05:29:00PM +0100, Patryk wrote:
> Hi, I've got a question regarding phy drivers. Supposed that I want to
> use an ethernet phy device - in general - do I need a specific driver
> to handle this, or is it handled by some generic eth phy layer that
> can configure (through MDIO) and exchange data (through XMII) in a
> generic, vendor-agnostic way?

phylib has a collection of PHY drivers for specific phys. If the board
you have uses one of those PHYs there is nothing you need to
do. phylib also has a basic generic fall back driver based on what PHY
registers are defined in 802.3. For simple PHY devices, that might be
sufficient to get a working link, but not much more. If you want to
use all the features of the PHY, or it has non-standard registers, a
PHY driver will be needed.

The interface to the MAC is PHY vendor-agnostic. The MAC it just told
how to configure its side of the MII interface. It has no idea what
the PHY on the other end of the MII interface is, or even if there is
a PHY at the other end, since you can connect a MAC to another MAC,
e.g. an Ethernet switch.

    Andrew


