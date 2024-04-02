Return-Path: <netdev+bounces-83874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8B7894A82
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E71B21DBE
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3CA12E5D;
	Tue,  2 Apr 2024 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdZuyYoo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2872581
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032309; cv=none; b=Ce5eeWBNtQLEs48VbQFtDuNzpnzyQtHb7GI7VKRXX8eCruj/d0Wgnu991HFZ/TaMsNAg32Kov2Impz4H6utcrlzjOT0TvHsvXRZa9yLSNirkfjaYhHM+M3ssB0xE5ZqxXxK5JwxPww35lQcfTNxW8SeJkb+9GtXPdSdRscMCtjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032309; c=relaxed/simple;
	bh=kt+PrVyUJf8flMxUP2dGhTf6b11Bu+z/KK+MhxQZP2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZw6juULYiT1Y52gv8qk2lzcfIGDVI6mRh8/jf/Bi/KIkmY3RUXYTXO6211ebm1KKZbd52d6VJ+2B39Yx3txSps7higFs+aSfIzkkOmKiprw0rFzE5jIxdeB4yJS7yeVRYqMt2qYGYZJk3IUtCW0XNpJ9HwXQRM17zrQrBzNV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdZuyYoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F38C433C7;
	Tue,  2 Apr 2024 04:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712032309;
	bh=kt+PrVyUJf8flMxUP2dGhTf6b11Bu+z/KK+MhxQZP2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jdZuyYooAg5ngT+4++lf+kYTmlodaw4DYc2wYpI9NumuOuGy4/i0MeMGBVtJ00Ykl
	 1rCnxRDXJGBQH4MpLq5MBCQ//LUHSMnOnQdJaRp4Q0UUgPVejiDnkhTBdC4xcMD0UI
	 ntbe1ddt3ywOW9QFwnXjz9qBamObSQD+0QshVsaoh0Q/aBjbVdbTF7ApPELSM/sKTg
	 bbV7DRTvCgGc5sq4BxqOMZGePH8zSlucMJ4wQb5IxWYCcK4EZ3isQ4e481CS7QdlKe
	 qX7Ft1iWu4DbJhI78dhZTNOBwPxsnPKXp+NBmglSA7aBtCZ35y6Db3CAvHeYOTiGof
	 /teJOGeireRsg==
Date: Mon, 1 Apr 2024 21:31:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 0/8] net: rps: misc changes
Message-ID: <20240401213147.7f1faa5b@kernel.org>
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
References: <20240329154225.349288-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 15:42:17 +0000 Eric Dumazet wrote:
> Make RPS/RFS a bit more efficient with better cache locality
> and heuristics.
> 
> Aso shrink include/linux/netdevice.h a bit.
> 
> v2: fixed a build issue in patch 6/8 with CONFIG_RPS=n
>     (Jakub and kernel build bots)

FTR already applied by DaveM last night.

