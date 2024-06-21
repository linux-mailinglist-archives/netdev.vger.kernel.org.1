Return-Path: <netdev+bounces-105752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610F912A58
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7643E2810DC
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A77C09E;
	Fri, 21 Jun 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6zz2Whd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5FF17554;
	Fri, 21 Jun 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984222; cv=none; b=PFEVRnOYvSOgNo36cJp/zqPkF+2EES5/OvscEsfB3xtySBkS35cqsecBk1XUN2vJ6nKALgCP31nN28u0XC9R+FfLdRNKjOAmNGsMrM5FBDV827/08DqYcqiae06izJfxj3UQdbJWrnZKHzehA1rMO4GqyYdB5tmcsMJ/SOSt6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984222; c=relaxed/simple;
	bh=atpQZY8aOiTofjKL69fhtdxjNndjMkw9O1BEs9zt1pY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmBHxqAz3eKeZ7VckjbI5lqCz/niiCOUcZV8rVqpFXKOt/PR9frZcv9CPZIv1b8+Nec0xJiPPspVBgl270pc1mIqqm8jzNo5VoOgAekMJZCH/uI4afJbKtWab8x1COuyfYy5G7CI8yV2FSmrcOWxTZTCl6k9mB3nswUfBodQzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6zz2Whd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7796C2BBFC;
	Fri, 21 Jun 2024 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718984221;
	bh=atpQZY8aOiTofjKL69fhtdxjNndjMkw9O1BEs9zt1pY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q6zz2WhdwH7/OdlhSG29KjrnN2W6FKS1z8+FSjGm77tisG2nX9MESqEwnOVRKJ9kX
	 GrLtD84WaApIfsif2wKzcUZQELo4/13RnWt82T06Lx7wNfjS2cMafehpKm6MeRrSfU
	 dd2FO9vMdmKIJdd+v8xLYTS/KLYxazaDGf8lMlA14LajbRcvefaVN6GreDiyMVBPpg
	 4XvH1NX7g7ufBfOee23HiSDOEOaU/UkWCQMUjId250BS9fhuksnPMofEKFmdwUfewJ
	 sczFITfpKq0deS3RjkX1PadlFAlcw5XTJqFcIu7aix7sCUp0KaN/vSBJGZmJ6PgHa1
	 i8E8/jJtv8gSA==
Date: Fri, 21 Jun 2024 08:37:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cleanup arc emac
Message-ID: <20240621083700.4d3981b7@kernel.org>
In-Reply-To: <171896102978.12983.298145904993537431.git-patchwork-notify@kernel.org>
References: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
	<171896102978.12983.298145904993537431.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 09:10:29 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
>   - [v1,1/3] ARM: dts: rockchip: rk3xxx: fix emac node
>     (no matching commit)
>   - [v1,2/3] net: ethernet: arc: remove emac_arc driver
>     (no matching commit)
>   - [v1,3/3] dt-bindings: net: remove arc_emac.txt
>     https://git.kernel.org/netdev/net-next/c/8a3913c8e05b

FTR - all of the patches were applied.

