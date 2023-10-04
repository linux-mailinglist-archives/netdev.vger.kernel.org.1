Return-Path: <netdev+bounces-38088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3497B8E9D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 92AA82816EE
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395342375A;
	Wed,  4 Oct 2023 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4Dz0nCi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04F219EB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441B6C433C7;
	Wed,  4 Oct 2023 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696454474;
	bh=+mnPw2cgov2C697kC7dBfIcSrWXIS18s9CkSLWTJFzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g4Dz0nCiTVV25EjY4hEX57MOTtJjWHhUrSuqFmQil9U+FS5Zm7uOkasKgh17Tz/vY
	 2KQrMNIAGP0wDYXYNulB8TDNA2HqA5ouSTJbmoXBLZc2ogeFG0ITgzj998iXNbbMEX
	 +Ai/iOQNBwfUxTvSPMicE/9u8WS2rd6zkfmSvp2Amq6dtrL4hNIUj4tYXUd7jD9GEp
	 1NeZpQbpWzNHeQCLwfc7Tw0fel1sz2hw021b/LjruBBLwmjIpTsW1DQoZzBZT2HrDk
	 t51qVgTldNS4OrMbJV/iOv2+qqEbdqr6vJfBIuvBr1Tr2iVJtcmTGWEu1JVj1UmjAk
	 PeHDDmbPz1fYw==
Date: Wed, 4 Oct 2023 14:21:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: skbuff: fix kernel-doc typos
Message-ID: <20231004142113.71b19c16@kernel.org>
In-Reply-To: <ZRvwn8lTaFxJ83X/@kernel.org>
References: <20231001003846.29541-1-rdunlap@infradead.org>
	<20231001003846.29541-2-rdunlap@infradead.org>
	<ZRvwn8lTaFxJ83X/@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 12:44:47 +0200 Simon Horman wrote:
> > - * so we also check that this didnt happen.
> > + * so we also check that this didn't happen.  
> 
> At the risk of bikeshedding (let's not) perhaps "this" can be dropped
> from the line above?

+1, since we're touching the line we can as well..

