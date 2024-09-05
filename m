Return-Path: <netdev+bounces-125502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A271996D682
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0761F25602
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF861990BC;
	Thu,  5 Sep 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3Guya4C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD78198E77
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533856; cv=none; b=I4umeBLnD0nFZqfInpwFmJrCdyDhd23yIfaI/hgWTODLvfh3dFg8AhwrfoUcywJwXcWhmcU3DnBiZmUUOKPbry8b5z39VKhe2nOrr+FB1OJMvyoj781LSiqtIHXxOPjqfOIqlbG/7EtUEwt88APFYNLN1Tik06Pv3Wiz0Xcg+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533856; c=relaxed/simple;
	bh=7D3pIFtwFn9h95Lvx10kvglUmb8s4vRpiEtjRAPeVvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JahcmbSxWdJgzVRwzeMgNBUwmR+1ae8GPNLg3fI9bPpAJZKnJRt7lafyoFbfjKaqsJwC5LNWl4SGxSo6y7F5aiAel232RrSk1vyejPcgfQfRjw1kG+t12q0RNaC1MaT6dwAh7M6j58I2o1xXolxDmyA8eX5zQSlSG0Ie2NoOKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3Guya4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEA6C4CEC3;
	Thu,  5 Sep 2024 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725533855;
	bh=7D3pIFtwFn9h95Lvx10kvglUmb8s4vRpiEtjRAPeVvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3Guya4CdlZurT15BChf1qC4UoTOQOGB1X5IQgOb70WOivK4zwq6CHYqVVRC9Vsen
	 NFkeZQU1YZl65WCC5ozwMlM0KNe8oAZ33NemH7odgk4ZzYewx9PVur1hJPQyWWkM3A
	 zpLM730Vt7mn0Z+wYBZo06Rb4xmesoGS3Wh2aMFXjx5P1jJYl+uls+Rv8xonYSslK8
	 K8GLtvwTNZBlZE1Ck+zDwZPy92WNzso6SqYhdgmNyto6irP/S/GHr4/sh7v1EaLNBy
	 NIHLR7ej8A2gi7FRaxRYzVWhKSDhtterbyr6GW/gUZpg+IgTT5QKp4uPViTWfp0F/K
	 BjI/093SZkX9A==
Date: Thu, 5 Sep 2024 11:57:32 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: fix ptp ocp driver maintainers address
Message-ID: <20240905105732.GH1722938@kernel.org>
References: <20240904131855.559078-1-vadim.fedorenko@linux.dev>
 <20240904201724.GE1722938@kernel.org>
 <e76530ba-b191-4d64-8692-70a319e57f99@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e76530ba-b191-4d64-8692-70a319e57f99@linux.dev>

On Wed, Sep 04, 2024 at 11:47:07PM +0100, Vadim Fedorenko wrote:
> On 04/09/2024 21:17, Simon Horman wrote:
> > On Wed, Sep 04, 2024 at 01:18:55PM +0000, Vadim Fedorenko wrote:
> > > While checking the latest series for ptp_ocp driver I realised that
> > > MAINTAINERS file has wrong item about email on linux.dev domain.
> > > 
> > > Fixes: 795fd9342c62 ("ptp_ocp: adjust MAINTAINERS and mailmap")
> > > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > 
> > Hi Vadim,
> > 
> > Should an entry also be added to .mailmap ?
> > 
> > ...
> 
> I don't think so. The vadfed@linux.dev items has never been a real address,
> I haven't seen any one complaining about bouncing emails from this address.
> It's just a mistake done within the patch mentioned in
> Fixes tag.

Thanks Vadim,

that sounds reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>


