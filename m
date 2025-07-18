Return-Path: <netdev+bounces-208102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A33B09DD9
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 10:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA7A176969
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455012222B6;
	Fri, 18 Jul 2025 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro/KtmsA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E820B7F4;
	Fri, 18 Jul 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827186; cv=none; b=KmWgBjBmGEJsriH4FDL2dI1L7zJ+QdX12Xs96LXp4RDxytj7fTnCjYM5cjxTj5A55TzOH4xhOnp6gvoXg5FQdJkamNUhEYuDGrP62cDNQdcNCwqkerop9Sd6Fa4yzwieoHQl7DxlMM9Wd1m6KPxKdi9jlDoE4UzgZPYEtRbKpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827186; c=relaxed/simple;
	bh=JpnYc7uV3AIPXd+sOIKY0UtAVN0bRV+soVESNbhHoaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O40vYlSdILdBdGKZ6bcICSNyx654or5o9hUAJ42MMJ+6T1qFhFGBBcUrEDxY1xqrYxSFiHdfMn/dOfzkxzzhNN4x3LewxmcwgqAxhjf7qLBfExfN1NkNxTbH39bdm/AH1IyOcEr6/i/3KMtdw+TeVHZ4j5jHKlpDVbZL2jkHILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro/KtmsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F115CC4CEED;
	Fri, 18 Jul 2025 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752827185;
	bh=JpnYc7uV3AIPXd+sOIKY0UtAVN0bRV+soVESNbhHoaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ro/KtmsA3WgqsTsECSmfsOAbjr1R2UpST50ZudDNsAvUWfGWspd8EdFCiIRUHXSZ4
	 XlOxcqBhjrP0z9DP4H315K8/F5JjHtN9c+G0jPVMjZbeaDG3EaFQUiGH92DYKBVL7S
	 vsF2KD+Ax3cJ/iSFW/suqVyLgXpmgZHjoziLFlfh9SaAaH8rnFSzVO0v6URpBg/853
	 t0F1zI2c0HFJOR5VLgcNtw/bcuy7N9YPtOpwtavnjgFuQme6GMDWJ9a/7QxmknONU6
	 akAPT8CYuTF4VbENhFgjGCd1f5VebJvmvZxlqpQI/U4SLBxi/BiRbXLZAdteiW9ehY
	 Kmdifcx8Z81Xw==
Date: Fri, 18 Jul 2025 09:26:20 +0100
From: Simon Horman <horms@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, razor@blackwall.org,
	idosch@nvidia.com, petrm@nvidia.com, menglong8.dong@gmail.com,
	daniel@iogearbox.net, martin.lau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: geneve: enable binding geneve
 sockets to local addresses
Message-ID: <20250718082620.GI27043@horms.kernel.org>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
 <20250717115412.11424-5-richardbgobert@gmail.com>
 <20250718073141.GG27043@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718073141.GG27043@horms.kernel.org>

On Fri, Jul 18, 2025 at 08:31:41AM +0100, Simon Horman wrote:
> On Thu, Jul 17, 2025 at 01:54:12PM +0200, Richard Gobert wrote:
> 
> ...
> 
> > diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> 
> ...
> 
> >  static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
> >  					    sa_family_t family,
> > -					    __be16 dst_port)
> > +					    __be16 dst_port,
> > +						union geneve_addr *saddr)

Sorry, one more minor thing: the indentatoin on the line above looks off.

...

