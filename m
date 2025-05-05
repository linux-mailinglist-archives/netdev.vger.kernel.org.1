Return-Path: <netdev+bounces-187840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84590AA9D7D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DD317F260
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5826F444;
	Mon,  5 May 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb1DnwbC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32126AEC
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477816; cv=none; b=lKuAmX/mYC+MCtbNAfSOBU2oxgoFfzF2GYRMYvnB9aZCd7Hi3MH69uT7atqiC4cDA1+cPQb8IxNoASj4qKWm4MvCbUpqQa8k46DJRxHxPA5sXX9JW1uvYuh6qtKufOkuuOxVDLNX+LvDmxqWT8CYSnIYOLJ6jip9MPWv0dbUmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477816; c=relaxed/simple;
	bh=yhqHKVhb+6pyTnLaUTOOhdY5230KNpLwstgjE3IDB44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E07UqInA6Hyd1UPeUEeljElDOWSABoefTkSM+OJaMAqs6YA3qkwLWlL5bsm93gtgRLHHih5zY5qCdMx+47F3Tht44aL6NQuNLYQuUnduLa7iklGx/BnbpQGBz6zu6KO6PxfeG1qo57oLpkdWinMlQcWYTCN+iKIb4Cmb9mpx9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb1DnwbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5FCC4CEE4;
	Mon,  5 May 2025 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746477816;
	bh=yhqHKVhb+6pyTnLaUTOOhdY5230KNpLwstgjE3IDB44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hb1DnwbCC+4kD2lOAveybwwRNssHiWsCy0KIn0aHUcwW7HWcIxQ/EKoy2mqR+crmf
	 wkoajcGcW3dFuQiiR0fQ5kUidIfNkKKzEQHuPMGYzoEgVqHiuR3kpHS/2hK0rWle6r
	 7+1kwExJyzLTOsrrsKvQYpzt8uayjPZqPsmHSMswCZGUUVBQbLhAX/ZDCAVT/E+7A9
	 ikVDCsWKY/+PKDSE7IXw+wTiBesBAJpXbu9PIJ4Lm4Kcqbo9Ewy5n1owwbE+acFiHf
	 SasPf7oewUdxCQ3viq2IIBc1xD3q1RkeGo0Dz2IscSUdkY7qgqxJfwXLZREAdYWyBH
	 o2OnjqiBBMikw==
Date: Mon, 5 May 2025 13:43:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Padovan <gus@collabora.com>, "Aurelien Aptel"
 <aaptel@nvidia.com>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>, "netdev"
 <netdev@vger.kernel.org>, "sagi" <sagi@grimberg.me>, "hch" <hch@lst.de>,
 "kbusch" <kbusch@kernel.org>, "axboe" <axboe@fb.com>, "chaitanyak"
 <chaitanyak@nvidia.com>, "davem" <davem@davemloft.net>, "aurelien.aptel"
 <aurelien.aptel@gmail.com>, "smalin" <smalin@nvidia.com>, "malin1024"
 <malin1024@gmail.com>, "ogerlitz" <ogerlitz@nvidia.com>, "yorayz"
 <yorayz@nvidia.com>, "borisp" <borisp@nvidia.com>, "galshalom"
 <galshalom@nvidia.com>, "mgurtovoy" <mgurtovoy@nvidia.com>, "tariqt"
 <tariqt@nvidia.com>, "edumazet" <edumazet@google.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
Message-ID: <20250505134334.28389275@kernel.org>
In-Reply-To: <19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
	<19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 09:52:38 -0300 Gustavo Padovan wrote:
>  > The next iteration of our nvme-tcp receive offload series, rebased on top of 
>  > yesterday net-next 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW Stats"). 
>  >  
>  > As requested, we now have CI for testing this feature. This has been 
>  > realized through the addition of a NIPA executor in 
>  > KernelCI[0]. KernelCI now has access to execute tests on the NVIDIA 
>  > hardware where we use this feature and then report the results for 
>  > NIPA collection. 
>  >  
>  > If you want, you can follow the test executions through the NIPA 
>  > contest page[1]. As expected, tests are failing right now as they need 
>  > this patchset applied to the netdev-testing hw branch, but they should 
>  > pass once the patches make their way in to that branch.   
> 
> When I go to patchwork to look for the CI results for this patchset:
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=958427&state=*
> 
> No tests ran. I wonder if this is because the patches were marked as "Not applicable". [1]
> I could figure out why it was marked as Not applicable right way. My guess is that
> NIPA believes the patches should be applied elsewhere and not in net-next?
> 
> Could you advise on what we need to do get this patchset through netdev-CI testing?

Looks like the tests passed? But we'll drop this from our PW, again.
Christoph Hellwig was pushing back on the v27. We can't do anything
with these until NVMe people are all happy.

The TCP changes obviously must go via the networking tree.

