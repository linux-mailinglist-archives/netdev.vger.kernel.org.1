Return-Path: <netdev+bounces-122569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC89C961C1C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 04:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792761F244C5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 02:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB7487BE;
	Wed, 28 Aug 2024 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0RNunuW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870111CBD
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812082; cv=none; b=oLs30HIczcYd5hza5L+N0P7mupUm/hD2qqGUUpiOMMj0SvreH5ny2DGIOeactL2a57WEwnUzh9ZujOFDxDp3/8SIg2rh2kRG1uCW/9K/+vCHjnkvhNMooL8jJXKA2bga33EHJRJTSTcET9bOok8xiRdgb3la3u1YfZ3dNHm8PWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812082; c=relaxed/simple;
	bh=62hJEAf8diwsuVJbtFhmrKymEVz2YyRzgnk6iW146Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZOS/w1rH6aCBTIExtJDblyIHQIBTdYQ8Wu1SXBi2Cc5+sk6M4AXgzOp/2mqob+nlDCUT+TS4sCSCX1i605A9AGhCRhm9YpW3t7WyoobHnM/nXLLfi9kVHa8L59d1jMnrBbyxsYv+Xl6wAso762CrzqnSKrKn77B27wr2KIJzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0RNunuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E32C4DE14;
	Wed, 28 Aug 2024 02:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724812082;
	bh=62hJEAf8diwsuVJbtFhmrKymEVz2YyRzgnk6iW146Nc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X0RNunuWNPPAkscwfPdGuamWtZIwq3v6NeoH+yKBxcPUScEaEaQ3z09MM+m094+vH
	 MCjNK4bnCFixhRFF5PysOYTuzuxM+FQk/3JLYgMeqLzbDgANB8C2dGun8nesv6S20C
	 lSaE+mB3+ReCYEFxQGGTcbWMkHd37dEbKmvOkn2omTiTcoSnCgy6HlR3aXNM3+LtZ6
	 KbyA5vI+KyRo4tedli9ylOiJv1W3YIJGNldhoVPAVFeg5xrTPWj+sgfxYShpsY1JuK
	 rmxXhQhIxaNGslnkxv546/GxLH2sA6jVoaoY9AuBt3LR9XzIJh53b17oh08onx827m
	 945DvkIol0mAw==
Date: Tue, 27 Aug 2024 19:28:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, Steffen
 Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv4 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <20240827192801.42b91fff@kernel.org>
In-Reply-To: <Zs55_Yhu-UXkeihX@Laptop-X1>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
	<20240821105003.547460-2-liuhangbin@gmail.com>
	<20240827130619.1a1cd34f@kernel.org>
	<Zs55_Yhu-UXkeihX@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 09:14:37 +0800 Hangbin Liu wrote:
> On Tue, Aug 27, 2024 at 01:06:19PM -0700, Jakub Kicinski wrote:
> > On Wed, 21 Aug 2024 18:50:01 +0800 Hangbin Liu wrote:  
> > > +/**
> > > + * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
> > > + *                  caller must hold rcu_read_lock.
> > > + * @xs: pointer to transformer state struct
> > > + **/  
> > 
> > in addition to the feedback on v3, nit: document the return value in
> > kdoc for non-void functions  
> 
> I already document the return value. Do you want me to change the format like:
> 
> /**
>  * bond_ipsec_dev - Get active device for IPsec offload,
>  *                  caller must hold rcu_read_lock.
>  * @xs: pointer to transformer state struct
>  *
>  * Return the device for ipsec offload, or NULL if not exist.
>  **/

Yes, but still a bit too much info in the "short description"
how about:

/**
 * bond_ipsec_dev - Get active device for IPsec offload
 * @xs: pointer to transformer state struct
 *
 * Context: caller must hold rcu_read_lock.
 *
 * Return the device for ipsec offload, or NULL if not exist.
 **/

> BTW, The patch now has conflicts with latest net-next, I can do a rebase if
> you want.

net or net-next? the patches from nvidia went into net.
If it conflicts with net-next please rebase.
If it conflicts with net -- could you wait with repost
until after the net PR to Linus? And then rebase & post?

