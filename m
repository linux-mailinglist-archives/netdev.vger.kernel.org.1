Return-Path: <netdev+bounces-163747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA936A2B762
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99C51889591
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217D22EE5;
	Fri,  7 Feb 2025 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1so+Rwt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57517E4;
	Fri,  7 Feb 2025 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738889868; cv=none; b=GqoMcxz7tBsNz+FQJZXQjyN5mSa49jZ0SYzW5hUCWoAHVY18UFHNnWwa+095lLciuoNTYJ7ndvmBUuFXJk9jCjZ5E2f6faWxOzzj+s3r2D8BTDq/icnVSBH7quKDgW7YbB1ZQOom5hGzfyFIN5PktLSJgUcLrNE0cZJH3ZmY2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738889868; c=relaxed/simple;
	bh=QAalmYM0YQ3qy9L1JYNp+xrDRdLd6lsQdtK/3886IX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRq5L2SjWfDGMsCDZdLyEyAfkDzPGEiDw6Re5wf7gPFle4+2yoU3fJ9ujof6x1gNl2a+Tw/JacOe9bAb8XiIF4pF7Po20KiMqO/kgYubJmkgnMlQoq4hgSWC63yfZyoLkiF+ray/E9WGK47LxjJM1MB62Vn1nKh3eODwuk/twWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1so+Rwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5FAC4CEDD;
	Fri,  7 Feb 2025 00:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738889867;
	bh=QAalmYM0YQ3qy9L1JYNp+xrDRdLd6lsQdtK/3886IX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m1so+Rwt8RTW/f6hH2GzXrscIUf9rr2TqN09bRM/rnkHukNk2MQ7vp/FeF6lNsNz1
	 4Bt4h80VG5jN4MgqCPdH1eIcHS2OeoSSyYduqNPMXOuuTIGaRWjjjYQ1vZNxiW49Ap
	 s+4RSHCwMsLtimnvaS8i841rJSu0Gg9wc0yEIz0uHZFfbUlFVKsp6RgciqJzf2iZc4
	 9hyKgCWs2BW+OGcW7eevyLx0jo7o8FTTV168zKzCWVZBI3UcuWSLehVZ4J2R08buxu
	 EwAEdeuHRJKvAocAhOq+NeMRCN//hkfHpp5w007/M57Ftn2uIrTvW9znEqy55Es/QJ
	 SWhNjtnJuTOOw==
Date: Thu, 6 Feb 2025 16:57:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, Daniel
 Jurgens <danielj@nvidia.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v3 1/2] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <20250206165746.7cf392b6@kernel.org>
In-Reply-To: <20250204191108.161046-2-jdamato@fastly.com>
References: <20250204191108.161046-1-jdamato@fastly.com>
	<20250204191108.161046-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 19:10:47 +0000 Joe Damato wrote:
> +		if (rxq->pool) {
> +			nest = nla_nest_start(rsp, NETDEV_A_QUEUE_XSK);
> +			nla_nest_end(rsp, nest);
> +		}

nla_nest_start() can fail, you gotta nul-check the return value.
You could possibly add an nla_put_empty_nest() helper in netlink.h
to make this less awkward? I think the iouring guys had the same bug

