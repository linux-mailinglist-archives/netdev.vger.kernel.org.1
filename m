Return-Path: <netdev+bounces-142334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E49BE50E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074F61F24FC2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD61DDC30;
	Wed,  6 Nov 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fluKaB32"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BB142E86;
	Wed,  6 Nov 2024 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890844; cv=none; b=jaJugPyCXZRzJK4MjDh+iuGF68+SNdZOJLOwPz7It/0ksXTseKuDmppc4KBdlYTqBlmkrdTP5mb3ufESoJGsquuJMNkNLvZn7Csl52TccF7Io7R/gkStWcp/STQ62BpUNFhp3usc3EbVk5NliQ7whr/ZsOCoDY0iiv9GBEgf4O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890844; c=relaxed/simple;
	bh=iIV7Yr0bdlyHCC81DwX4Zrc8Y06lx1+kkRFDjM5Xwto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ7YNlEPZQHk1XZIv1MoWD1jmD/rOmvxSobtMZCvXVSX1CXMQugkX4nRQdzCWjSQ1gTOPjLk6N7dHp5QtOlhvkdVuXTrA7P5C0ey5+2JK8TQAO1fkJNiQ/cSNyVtVpMxrwpf206U6lxNbzBJeWrOXBdVh+9SIcafoEURx50q04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fluKaB32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3542C4CED2;
	Wed,  6 Nov 2024 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730890843;
	bh=iIV7Yr0bdlyHCC81DwX4Zrc8Y06lx1+kkRFDjM5Xwto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fluKaB329vNJTNI9zO/jYxyQxleiQBtI3hKbWs0s2lRdk257564zui1vCDHtl7bRo
	 uB6DyslqXkzRJkh7Uh0+/5IENbwqceE3vizLfiBT8q+hE3kqvLcUFJVL+XILS0196J
	 g6R57UQ1g6u2rYpwp6KXjgGC4nRFip0fVAogwjC1acxNaYODBKLotQp1JpvPXAKwRE
	 eMggPtQL0BehPSCWpReY1vNYEvjsUWGnO8q24WUBs949ASDp7FHhlPf0Mh1278yW7r
	 UkjHp3qRTvUJ+Ayunm7ExLAsKwD1LujV35so92bkZAG+x+p0a52oaY/6xcwHo7XuRS
	 grAVdrY8SNwXw==
Date: Wed, 6 Nov 2024 11:00:39 +0000
From: Simon Horman <horms@kernel.org>
To: Gan Jie <ganjie182@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, trivial@kernel.org,
	ganjie163@hust.edu.cn
Subject: Re: [PATCH] Driver:net:fddi: Fix typo 'adderss'
Message-ID: <20241106110039.GO4507@kernel.org>
References: <20241101074551.943-1-ganjie182@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101074551.943-1-ganjie182@gmail.com>

On Fri, Nov 01, 2024 at 03:45:51PM +0800, Gan Jie wrote:
> Fix typo 'adderss' to 'address'.
> 
> Signed-off-by: Gan Jie <ganjie182@gmail.com>

Hi Gan Jie,

While you are addressing spelling in this file, could you
also look into the following which are flagged by codespell.

drivers/net/fddi/skfp/h/supern_2.h:55: impementor ==> implementer
drivers/net/fddi/skfp/h/supern_2.h:587: Implementor ==> Implementer
drivers/net/fddi/skfp/h/supern_2.h:598: Implementor ==> Implementer
drivers/net/fddi/skfp/h/supern_2.h:885: activ ==> active
drivers/net/fddi/skfp/h/supern_2.h:927: activ ==> active
drivers/net/fddi/skfp/h/supern_2.h:956: ACTIV ==> ACTIVE
drivers/net/fddi/skfp/h/supern_2.h:959: ACTIV ==> ACTIVE
drivers/net/fddi/skfp/h/supern_2.h:1028: recources ==> resources

Thanks!

