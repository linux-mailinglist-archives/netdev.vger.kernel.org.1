Return-Path: <netdev+bounces-101994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31C90109C
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 11:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA05D282B2A
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3924C8D7;
	Sat,  8 Jun 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovJI48JL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE8ED9
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837240; cv=none; b=kRWGMsk0CjRBeXnxmrfLwC5FfZ6H7E+VZa2aBHGSlTx471cIdiht8775iyYLX9S7VFs3mH4GvNYrYfO42nsXLgmCCXbvmT284r20dNYXu4yfpdRSmN8VJkdLox6ZuZcDn2a1Lnc+rop5mWScHQpnI7kZamCyeu/DAwJnpwDJLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837240; c=relaxed/simple;
	bh=C5aZQmZKNqHeFVbymSVKZJMGyoziUuPzdI5hTzHOJQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGnSnaxc+T9WChJ8XnN0yz62hfQltRGAWD/RHHVv+gINzgP7M4vqFOkrchBdrQPxqYGFDCMji+8/eyG4DZVczc+Mb1xFI2leXPIDkAiAi5N0De72+Y8SEagI3B+8bzFcfP01vwCuvaUK4tynBzi0HMm8azcIrQfjibJ/Mes86gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovJI48JL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF6CC2BD11;
	Sat,  8 Jun 2024 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837240;
	bh=C5aZQmZKNqHeFVbymSVKZJMGyoziUuPzdI5hTzHOJQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovJI48JL9/NtM+1klREP56g8TUr3W9t8llfEm6exYwMKtfjQblzNkk926JtSrJ/+A
	 7ZD3ebB9Z2vAhOKLp58TdYNEmS+mrw44siHAkpeNBiwr2Nw1yzDPe8bTPi3SnI848c
	 u57bNP2GqehtpPnUo470z7vvMbFeZJkl+ZyLYrI4EdosLmzT7RVp8l7GXZw+HNuDae
	 Itjq9/DLiTdyejWnu+t7h0HDSTbC+F9BbJaL1vLWu/9l4+Oh3aWlebV3dGYYevIF0S
	 xOI7JFM6r0sNC1oRmvJ3oRkaeYt42YIOlqlP/FiIL2OTgOMv7IJyI3nCPuKVfmV10h
	 KLRa/xqdWgzww==
Date: Sat, 8 Jun 2024 10:00:35 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Alexander Zubkov <green@qrator.net>, mlxsw@nvidia.com
Subject: Re: [PATCH net 1/6] lib: objagg: Fix spelling
Message-ID: <20240608090035.GM27689@kernel.org>
References: <cover.1717684365.git.petrm@nvidia.com>
 <0176885fccfffe7aaad6fcae774ff336bdf75c94.1717684365.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0176885fccfffe7aaad6fcae774ff336bdf75c94.1717684365.git.petrm@nvidia.com>

On Thu, Jun 06, 2024 at 04:49:38PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Fixes: 0a020d416d0a ("lib: introduce initial implementation of object aggregation manager")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


