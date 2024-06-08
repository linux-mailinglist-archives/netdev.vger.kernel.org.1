Return-Path: <netdev+bounces-101995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA8A90109D
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 11:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E001F21EE6
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 09:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB377433AD;
	Sat,  8 Jun 2024 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1ix1OyK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724E14286
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837259; cv=none; b=HtUdqAsn5DUm6vQKV6KtSQf28koa4Tr+bIVN46Se622Y+DLMQjvFzV31euIzef67CmLo8SECfEGpZ0r6AdLkb81pnkXiEuPBKsBTgHGbrIW2MYflOuQNgGIpsQSNIdBbBW6yjeeEEzQ6WYWkzeSzEzmi2DxBIYYJ8Oq3mLWA9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837259; c=relaxed/simple;
	bh=V+mkovaYZBI1Ers2TASOdXYlYuw04PirP1ufn1p4ttc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFNBEni6lYUBsWsVWC1CIPRZQ/MbZpnuOoP22zdFESjctwMZXbZILUaPd9gn1FZNqa8pcxZSQyk9j0VAiSHJKFchhHmG0I1fsNuVRiedquIjksgA9ZSX0YGUj4fqB6nJmGqp5et3YyI3YNKE1VJNVee6AqQ4xb5TzPrXj8CsMh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1ix1OyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243B1C2BD11;
	Sat,  8 Jun 2024 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837259;
	bh=V+mkovaYZBI1Ers2TASOdXYlYuw04PirP1ufn1p4ttc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1ix1OyKoOBMtkuysyK/MF6KrTk7JcaaZIXS1BCJ0uRT877q0h1oeJ/kXoczoZh/I
	 AtNcgImrSPJ1uaNomMBjqOa/vSczYqqCle7zNc54i3ciytkBVGVE/zD6aBNFLeSwH3
	 OmaslnhcsDfMZQnzEQ2Gdl8kQ+bA4BXxLbqqXtGKbpdn3l0BktD5QpthjThA9s8c1Y
	 nd3DWLKqraKzoO6fSZo1WCpekZA7mL8sMw0XHJsR70WuXGBMoaDeXO3q3cRFo5BsJv
	 7U/VZIAj14K4w7pEgLQCTc8b5pZNR9+pSZFxqC/XCibdOlJdHZ+GOsKqzMRi/ocT2Y
	 mkowRDNgYn1Lw==
Date: Sat, 8 Jun 2024 10:00:55 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Alexander Zubkov <green@qrator.net>, mlxsw@nvidia.com
Subject: Re: [PATCH net 2/6] lib: test_objagg: Fix spelling
Message-ID: <20240608090055.GN27689@kernel.org>
References: <cover.1717684365.git.petrm@nvidia.com>
 <9615fdd350c154c2c15101906e3e9f961703e5a2.1717684365.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9615fdd350c154c2c15101906e3e9f961703e5a2.1717684365.git.petrm@nvidia.com>

On Thu, Jun 06, 2024 at 04:49:39PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Fixes: 0a020d416d0a ("lib: introduce initial implementation of object aggregation manager")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


