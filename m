Return-Path: <netdev+bounces-95283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1398C1D00
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2508E1C21B45
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9CA148FF9;
	Fri, 10 May 2024 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvTXeUL0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A1142E66;
	Fri, 10 May 2024 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311690; cv=none; b=HBvIg9H20PKcN9i3h+o+RcK4lL5AaSRSRMMPTp/oo0SpQzcjOTwuenNu9Y3mORskPfV17X1WcQZBZ0+/D3TI6CSphMnDtQ16GHb4wRMuw3Ng/55ZmB0CJ6MUSHqwfRIvhBnNm5ODa1blP/8itNcKD77WTGhLZ7KMH7VmRbWRunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311690; c=relaxed/simple;
	bh=zv7wDs/nnXwMvb+49prRA6w+/tTmLN/Hqx57aSJhUj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnFL7baVLaM1IW3Fagcc3Z/S2rb46A0ejPNzHZ2+Um8wUKFzSHAIrmZwVH4W6k6uVZmiuwwtjatp21/PMmLOWrgH98TO6UEAOr/Ai8kPCaCQ9dbSCOGand9ekQvNuBqfepjt6Y2n45GXxNktDB7ASQNyuhUwJpuo5NmegVwDt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvTXeUL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEE0C116B1;
	Fri, 10 May 2024 03:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715311690;
	bh=zv7wDs/nnXwMvb+49prRA6w+/tTmLN/Hqx57aSJhUj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CvTXeUL0wgteyS/oezeQSAB5lrWBL5ObWRn9+YeeQwKOUMKmBFFJVQO3N1lLph73X
	 N6+t5hIPjlOYzOEIC9GKBLRRxhNpzOAZENK0u9TCnRcG+2BiggiOGo0hSE/Vy1ZA27
	 fOCX0XjMs7KNRYGPblMQv96dCKGZXKDhtCHKQ6T17kjSZM3l3kz+MhSWdD4JMAq2oy
	 Mkf05h9516GLZJsvn4yQRimb7NjonFWsHHVMWJ8d4vhJ2CXHJUdvjNa6y7DuWrnspj
	 AlG2OBs7hWStHI2b9VcCauQGnKQP9IIgrbk2JBPa744RRqguy8cFq/e9f0/JRefMjR
	 VsoJkPUbItZBw==
Date: Thu, 9 May 2024 20:28:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v4 03/10] octeontx2-pf: Create representor
 netdev
Message-ID: <20240509202808.26e960a7@kernel.org>
In-Reply-To: <20240507163921.29683-4-gakula@marvell.com>
References: <20240507163921.29683-1-gakula@marvell.com>
	<20240507163921.29683-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 22:09:14 +0530 Geetha sowjanya wrote:
> +	priv->reps = devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev *),
> +				  GFP_KERNEL);
> +	if (!priv->reps)
> +		return -ENOMEM;

using devm_ here is pointless, the objects are not tied to the lifetime
of the device (there can be created multiple times) and you have to
unregister the netdevs manually, anyway.

