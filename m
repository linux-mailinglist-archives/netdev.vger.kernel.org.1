Return-Path: <netdev+bounces-111257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6D930702
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FC01C2117F
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2B713B7A6;
	Sat, 13 Jul 2024 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRV5cJXa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C984963F;
	Sat, 13 Jul 2024 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720895463; cv=none; b=M/0mnzX98gIieePT8P6LyvtCKXfjCIYPKUzlGRBoHLiDjaawL6Jj7dZOS/c+1iny+8sjVv/SoLWwkTV7ZjhJH0SXoxS7VaHU6fOzCj9LQQBPWp7aNooMkjskrHpDLuZ4mwUscPe9aKDYdEANFxEiZ9RzEhtBh6g08b6N/9cNmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720895463; c=relaxed/simple;
	bh=Gi1NloXRrD/mCnsiB5meA9JqI+TI4y0FpAIs7GO+//Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odgxCcBOJIYWTZNKpomby7bJIYVwRSoXIwKDWvVhRxoIJIFGttztoPzWdz7UAAZ7M7oecvzSsilj3FP6uIdhkWUVLYbdKWRYmsdH13kOJ2kGfyUjuevuLO/DRghN0+Xzhm1kVQIs3Vk21kZ8G+9qZXtVioo9oef6Xd0Ox+jKM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRV5cJXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F801C32781;
	Sat, 13 Jul 2024 18:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720895463;
	bh=Gi1NloXRrD/mCnsiB5meA9JqI+TI4y0FpAIs7GO+//Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRV5cJXagkbz//DxREimA1LC+S82LhxdfT6NnHOeXpA9swnEEs5IthKSJi8NignJs
	 WClSxqjXg2DIyvSXOdMxCZd5fc3POKZkrujRNTWDoFu2cA5R2L4bKNObQEyYSoMDb1
	 /PqnkjWVvhbNSQ4JP4zHv6kQCVTiUtxanaN34GmV0W3iEhsyxP2bUR5OomifCHRr/w
	 +72ZN6l53QXbs+VK0x9GkaOQ0tAaJV2pj33Pj9QOt2HrWt2mQKgLpUmc4pdkfWMaD1
	 kA8uhTebQINiDqh3HXpFgSEQmX5WA9J7kM7Dbt8x4QLPf3R3BsKZZfs70WoGYr4YkE
	 AzOVOji/DQLFg==
Date: Sat, 13 Jul 2024 19:29:28 +0100
From: Simon Horman <horms@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next] bnx2x: remove redundant NULL-pointer check
Message-ID: <20240713182928.GA8432@kernel.org>
References: <20240712185431.81805-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712185431.81805-1-kiryushin@ancud.ru>

On Fri, Jul 12, 2024 at 09:54:31PM +0300, Nikita Kiryushin wrote:
> bnx2x_get_vf_config() contains NULL-pointer checks for
> mac_obj and vlan_obj.
> 
> The fields checked are assigned to (after macro expansions):
> 
> mac_obj = &((vf)->vfqs[0].mac_obj);
> vlan_obj = &((vf)->vfqs[0].vlan_obj);
> 
> It is impossible to get NULL for those

Hi Nikita,

I agree with the above.

> (and (vf)->vfqs was
> checked earlier in bnx2x_vf_op_prep).

But, FWIIW, I don't think the test on the two lines above is relevant.

bnx2x_vf_op_prep does, conditionally, check that (vf)->vfqs is not NULL.
But if (vf)->vfqs was null in the code you are updating
(and I'm not saying it can be, just if it was),
then neither mac_obj nor vlan_obj would be NULL due to the
layout of struct bnx2x_vf_queue.

> Remove superfluous NULL-pointer check and associated
> unreachable code to improve readability.

I also agree with this.

> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>

...

