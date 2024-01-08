Return-Path: <netdev+bounces-62286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7736F826711
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 02:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A8D281000
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 01:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88687F0;
	Mon,  8 Jan 2024 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlC4oQSZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026B7F
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 01:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A66C433C8;
	Mon,  8 Jan 2024 01:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704676744;
	bh=ymplXcnWDI2BDGE0s339EcERAmblsHKcOJc3/jmCgeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlC4oQSZuJwM1GqApJvpF3cFalGLc+HHMCod2a+VAmCCP5btC6dwlxYGzb3Vtsm8f
	 RdEJkjLviyVDYKC/Mg/PZoISMJKoXt29syFj5gTUv/RCiBtOpUyRxrdlXiTgVVcjES
	 QAWvjIcoH7ASWGpaDzYl028H6fvGnCrVXWfz/7GN+WCuWDIabSjcze+lG6WKR5/ldo
	 eonnZpvqfl+2W4KeYHOuxeTwLCsQnPUWniVOpHuh4dRRuHETmj7vhtFX/2wYfGbTqZ
	 F8VMVWsKnMQu/2wMStr+6mcJawydXGSjtke4FZLiBB9YkzGKSjLpS9y9s/YtTJLlUv
	 TwNnA2fqGza1Q==
Date: Sun, 7 Jan 2024 17:19:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net-next 00/15] mlx5 updates 2023-12-20
Message-ID: <20240107171902.5f23ad0f@kernel.org>
In-Reply-To: <20240104144721.1eaff202@kernel.org>
References: <20231221005721.186607-1-saeed@kernel.org>
	<20240104144721.1eaff202@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 14:47:21 -0800 Jakub Kicinski wrote:
> On Wed, 20 Dec 2023 16:57:06 -0800 Saeed Mahameed wrote:
> > Support Socket-Direct multi-dev netdev  
> 
> There's no documentation for any of it?
> 
> $ git grep -i 'socket.direct' -- Documentation/
> $
> 
> it's a feature many people have talked about for ever.
> I'm pretty sure there are at least 2 vendors who have
> HW support to do the same thing. Without docs everyone
> will implement is slightly differently :(

No replies so far, and v6.8 merge window has just begun,
so let me drop this from -next for now.

