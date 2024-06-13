Return-Path: <netdev+bounces-103417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A31907F0C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCCF1C2233F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8877E14C587;
	Thu, 13 Jun 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en2g38PW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0814BF8B
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318223; cv=none; b=hO2UFgk5YGOC/6xWnBcS17nziRKzBC2qsWMMkN2/IMHmGdnUpaMKLKTCqmONJ6shI+g3a2RPt19oNFmZldHOS8IUQjvQo6/A19qnAPIVk7f99RNZ7+g5dVyxOfZhILoP0OP6nJJE/Cl/3UABhIzjXOFZR7qwGi3cHZLNWrv7kN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318223; c=relaxed/simple;
	bh=GbEGtyR9TKxOgkkX5baAzysu8m0trasV66GoO10/ZW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdHP/TPfHCVEhIURUd3EQ4VuZGB0a+PCqMCMnusSQgmZmuSTG5pGnRYPoKK46O3ydpiF6uGScsF8UCZaxXfM2SYS7rqk3BBkaQhN4tSOatu24C8ZkKzoXVvGsYa4nRpiAH4EFiea/D+g4JN6tTVK3PC5Fm/paek3uuLA1JQtj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en2g38PW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993BBC2BBFC;
	Thu, 13 Jun 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718318223;
	bh=GbEGtyR9TKxOgkkX5baAzysu8m0trasV66GoO10/ZW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=en2g38PWdM8xDtzNnaNuwWwSJAJYLX18qfWje4GYdLa7kSsS0tCu+0fNc7Za2gKFO
	 xXWcxW8UrwijLa4LZhTOiDbo/CIoCi+ZcsCarAc9pIq4bCzyqNwcB7kFJlpUukpjcx
	 V46MgVsxDtY7CqCl33Wn4P+wyndEqeBfwFXjnf7j/7FeEES2ZWye4CJll9Dm/4hKvB
	 A5rxXf5PgZYLap6wKbUKgjz43pQnJHOGYm9+1elqxRR+zg1dxJarUu9Yi1N4YRZgcG
	 8jh/EPTrTqE7Sj7TWVFXIHZwXNBwlttHt+q2V+EiPn52rknd3GoBaysCJpQBmn6x3x
	 QZDyykM3pgGWQ==
Date: Thu, 13 Jun 2024 15:37:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 0/6] mlx5 misc patches 2023-06-13
Message-ID: <20240613153701.3316f61f@kernel.org>
In-Reply-To: <20240613150525.1e553d10@kernel.org>
References: <20240613210036.1125203-1-tariqt@nvidia.com>
	<20240613150525.1e553d10@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 15:05:25 -0700 Jakub Kicinski wrote:
> Looks small indeed, but fair warning - please prioritize helping Joe get
> the queue stats merged. After this one we will not be taking any mlx5
> -next material after qstats are in :(
                 ^^^^^
                     until*

