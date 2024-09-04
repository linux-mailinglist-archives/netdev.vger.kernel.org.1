Return-Path: <netdev+bounces-125278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F496C9AB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72FDB228AA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 21:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A65155A4F;
	Wed,  4 Sep 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ed/ELgUQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DB1F19A;
	Wed,  4 Sep 2024 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486221; cv=none; b=s8qQ3fl7xqL1W/JdeGg23sPmZQbhEVMsaEJCHndrOoZPQxh5ybMfJoshjhGvI7wXNk3Cjw8GtTTn3ewiHxoXCbJ5cqjviy5+jmQufw0j3fGsGGOUQIjNrWV9blu9UNiaEPn2uOvQ/H3VJk6T9wRymdkvnKYKiKjIxImTnB0lhkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486221; c=relaxed/simple;
	bh=EvoOZDmwcu2IZebLqvhgBG+wbzbgyzKmshpMx2ozOak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duGDJHLbO1CXtP3Sgh2935+g6fbT1bQbsSo+AdOJ11aFbAjfo7wlw4LqwGgvjHU5GzM/77OMqvOlUUmXT+S/HtFwoXbxyIjm1xWA+0ev7YuBEwWhRD8sR+xQf1J3qY/tViF/ZQcQZvdzkFZDaaOmdhtskShSl7/Mqq44IPuSshI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ed/ELgUQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xIb12h43+ZnCbCytKS56iF45btKkKH1XNeV+vbKGbqc=; b=ed/ELgUQptAOn3N0cxk74/72G4
	7xLPThuJh01HC+pvJSeCPzwg9ZoWqsjlixQxh++L5+0uIz9WBTIWX83xOl+1tNCeoloUz3k94fVjh
	fVSJeWES5EaFQyd9+DHECVFt3tVMIjIU2InIcoyjvHwGy6GS0KFok9dtsUoK9pYGBH1w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slxmi-006bcT-5a; Wed, 04 Sep 2024 23:43:28 +0200
Date: Wed, 4 Sep 2024 23:43:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, ansuelsmth@gmail.com
Subject: Re: [PATCH] net: phy: qca83xx: use PHY_ID_MATCH_EXACT
Message-ID: <adcde43a-aaa4-4f2f-a415-e15d77ec7c41@lunn.ch>
References: <20240904205659.7470-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904205659.7470-1-rosenp@gmail.com>

On Wed, Sep 04, 2024 at 01:56:59PM -0700, Rosen Penev wrote:
> No need for the mask when there's already a macro for this.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

The Subject should be [PATCH net-next]. Yes, we all keep forgetting
it, but it is important to the CI.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

