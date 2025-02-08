Return-Path: <netdev+bounces-164258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620DFA2D26B
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786053ACD23
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964DF9DA;
	Sat,  8 Feb 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOgxAcLf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF2372
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738976439; cv=none; b=INQjdjGMsZzHA5+S4qaMsUZSfdgSqKb2Kd+gRveiDcrgR+bT9M5qm9XxZ9V8SyP/sagfwYapAuhCzuPhW0r1dX2LRangGdzPafj0ovW3yPyYltozS9hrEbqvvFKxNQRQ7lY9F50OK7cUTWvLaREqdQK9lqGYJ+0Pf/su0aJUXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738976439; c=relaxed/simple;
	bh=x1mUqnOkniDES3lkJdhTjBkR30wQXIi8uXOG0Q+GoBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ns5dEknLzTdbwcydAYZEMDK1Y2r+loPUIlX7VUo1gB/hTKVQyG6HRZ6qleyWTr4osrqqbjqGgqrjrgPG9xdNocLiukT4ctzBxzdpfxARNFic2qmYNoZUaJgN/i5jb5Ltw6pNAKaOIAEfCmMNn//Q5ei0jqSsGxhs2XnPoKx/0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOgxAcLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4CDC4CED1;
	Sat,  8 Feb 2025 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738976439;
	bh=x1mUqnOkniDES3lkJdhTjBkR30wQXIi8uXOG0Q+GoBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oOgxAcLfarHpRhyZg9x7sXBSLw4jMN6Q9gmBFd3AMvSBLIJivFVKLk4ZL/h3mc1Cj
	 ocOCK1bJS33GiTsewJ5yDBOz2zt2WOOX0U7yPgFp+KnHNIe4alGQff4uNS4jfjLfLX
	 7jiwk0ukW8MKSMknQj8eDDME0IiCA6lFOyNoLX/d3mHI2B3b6jRLbtQnKdwirh/F3G
	 PErrbr+1UwZ9aqPYNmoXX+oeaMMy6fw+Bxe1RWlhpJyVa+gp4s1UL7S+gCx7ConSLk
	 g5YObsD6cnY6qumLCkJsbyFMHBGyVn0PLLUrSNP9uyQ4sA64C+3LKnSdJtEzd/J8G0
	 KU6S8YOF6k4iQ==
Date: Fri, 7 Feb 2025 17:00:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Scherer <t.scherer@eckelmann.de>
Cc: netdev@vger.kernel.org, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 kernel@pengutronix.de
Subject: Re: [PATCH] net: dsa: microchip: KSZ8563 register regmap alignment
 to 32 bit boundaries
Message-ID: <20250207170037.06d853af@kernel.org>
In-Reply-To: <20250206122246.58115-1-t.scherer@eckelmann.de>
References: <20250206122246.58115-1-t.scherer@eckelmann.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 13:22:45 +0100 Thorsten Scherer wrote:
> -	regmap_reg_range(0x1122, 0x1127),
> -	regmap_reg_range(0x112a, 0x112b),
> -	regmap_reg_range(0x1136, 0x1139),
> -	regmap_reg_range(0x113e, 0x113f),
> +	regmap_reg_range(0x1120, 0x112b),
> +	regmap_reg_range(0x1134, 0x113b),
> +	regmap_reg_range(0x113c, 0x113f),

can these two not be merged?

>  	regmap_reg_range(0x1400, 0x1401),
>  	regmap_reg_range(0x1403, 0x1403),
>  	regmap_reg_range(0x1410, 0x1417),
> @@ -747,10 +746,9 @@ static const struct regmap_range ksz8563_valid_regs[] = {
>  	regmap_reg_range(0x2030, 0x2030),
>  	regmap_reg_range(0x2100, 0x2111),
>  	regmap_reg_range(0x211a, 0x211d),
> -	regmap_reg_range(0x2122, 0x2127),
> -	regmap_reg_range(0x212a, 0x212b),
> -	regmap_reg_range(0x2136, 0x2139),
> -	regmap_reg_range(0x213e, 0x213f),
> +	regmap_reg_range(0x2120, 0x212b),
> +	regmap_reg_range(0x2134, 0x213b),
> +	regmap_reg_range(0x213c, 0x213f),

and these?
-- 
pw-bot: cr

