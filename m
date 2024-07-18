Return-Path: <netdev+bounces-111976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B793453F
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 02:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668791F22330
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 00:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB0195;
	Thu, 18 Jul 2024 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5HViRcX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81717C
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260975; cv=none; b=Y88n4kpeuCmet4YLcewa8MV+1mJ4IxOVfbC2gfiVLuHMSkni2vtiDSlSm/pZpFFbh6PH5aeBlyFkGLfxu6xsAXfE8XbGBgHeEu5o5Zy6Pgy+2ystF6j6GyxqANTMJlIceIspeAIvsKj2i3+E69SqRLJRR6297DI1LmTSupLdk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260975; c=relaxed/simple;
	bh=oEopK7Z94DND/D6alS7Z7K3l3YOZGxAnp/t3OH+/mZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZH/ZSuWgAyh153pZeaNZ3HCZZPSiOWI8ck0IZWGuBhNtOkqddsWwFGvUhSqpV9THUbAorRT/kOsNbbHyQI2r3C6IN9lWeZmjYJq+Cf4aFGnTx+u8wKBloM9abmbhTM3RnMkCnZGn4pDmgvQRLqFli83prDPot81xXgBu4bS9/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5HViRcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FF3C2BD10;
	Thu, 18 Jul 2024 00:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721260975;
	bh=oEopK7Z94DND/D6alS7Z7K3l3YOZGxAnp/t3OH+/mZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t5HViRcXdLS1eZSRVx9RTZp2te2DvmrMeKAG1DuzfhtTwZ2OKiPO/GLbxMPd+gTlC
	 ICSrpc4ofUJJTT6MrZo8WviGDd8DgQwkk4gzMr0V5vg7Pkndw0H/TUvGuVDJUhi0pA
	 QyLV14ECYzfadl6Mts/WT7acA9ojNAEk71d/spUtYdYA4uK25tLLJBq9Nz7AzxiEE2
	 ESARRknebM5nwH5NHtA5bV3yGPQYE+x3Qeq6E/0/uzh3bcQhAFuJ0fFIaJkhiAtPrX
	 3wBPizhyJkpAdTF+mxx3rpHUmMEqOIKrM7DObldDV+CgnmKwy5W5HiokmDphJDwUk9
	 BtRVjMMlurbQA==
Date: Wed, 17 Jul 2024 17:02:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH net-next] driver core: auxiliary bus: Fix documentation
 of auxiliary_device
Message-ID: <20240717170254.39dc7180@kernel.org>
In-Reply-To: <20240717172916.595808-1-saeed@kernel.org>
References: <20240717172916.595808-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 10:29:16 -0700 Saeed Mahameed wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Fix the documentation of the below field of struct auxiliary_device
> 
> include/linux/auxiliary_bus.h:150: warning: Function parameter or struct member 'sysfs' not described in 'auxiliary_device'
> include/linux/auxiliary_bus.h:150: warning: Excess struct member 'irqs' description in 'auxiliary_device'
> include/linux/auxiliary_bus.h:150: warning: Excess struct member 'lock' description in 'auxiliary_device'
> include/linux/auxiliary_bus.h:150: warning: Excess struct member 'irq_dir_exists' description in 'auxiliary_device'
> 
> Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Thanks!

Greg, please let us know if you'd like to handle this yourself.
Otherwise we'll ship it to Linus tomorrow or Friday.

