Return-Path: <netdev+bounces-136647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16689A292A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F25281376
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B821DF72C;
	Thu, 17 Oct 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBE6ED0f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7351DF727;
	Thu, 17 Oct 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183186; cv=none; b=dslF09LE8/zh/0pF/iMSKSszti7Npyl+2Mb9MoWfRZHVVtXIPPP3G3NU7OEnEfFs1gBzF9Z6BPLRFnMsYEXFIMzRr6hJmOiFNbScvT6/Ajt2Ut9OM4Ag4rM56soRxwFwnwRqVfmGR/z7w4bfSsRnh2JMJIIzPsT1uu6dTZTjCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183186; c=relaxed/simple;
	bh=o4qSJBepvvbVGnVs0fleFT15etsdqBjCksHaXu9qaSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhL/L8aGTpSh4WuAyXz8P17GkDd3/Cmkr52R/ZNIzDPH2lfbPaoyKL3PCAC6fus1BbVaNnfBBPFFi4PVEhSJeda0fCnUONkngE/QMLWoVCkQYWZHtNNPEMiBZP41akoKiE9jM/R19R2yczfDXDCYKpOWgnuXqCWWveKjq3v8fLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBE6ED0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B72C4CEC3;
	Thu, 17 Oct 2024 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183186;
	bh=o4qSJBepvvbVGnVs0fleFT15etsdqBjCksHaXu9qaSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBE6ED0fkBlDe4tsyo3V8d7kEHPVZicGEcPQkSSCQ4uzjw2OFQb52AyaoxaS37wGb
	 c4PJlFrk71LMU9LjI0iFd9FgJMpidLH+cwwu0+jS3pfA1zusS+FrWGlMXpwK68c0Qf
	 qid1l9FMT9raCWhB3UodxR86fYBCoOGG9jyRgyz/6JgvkvmP7LzhZx/7NcjhqTiHNn
	 Nw/PdymrPJKpSp1r4hmS06Ff8+0sZiV0VdFBrLhhseOYiz+jEHBmmljoOaXwJ775eX
	 JQ1kJA0zywgYVAGO6afyMtrsMO6cpwiPiNi4ZVB0+7i27ISdzAXSfZWio6DuQvYuFj
	 GFt9MVMQhqBEg==
Date: Thu, 17 Oct 2024 17:39:42 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	linux-kernel@vger.kernel.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: add samples/pktgen to NETWORKING
 [GENERAL]
Message-ID: <20241017163942.GA1697@kernel.org>
References: <20241017111601.9292-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017111601.9292-1-liuhangbin@gmail.com>

On Thu, Oct 17, 2024 at 11:16:01AM +0000, Hangbin Liu wrote:
> samples/pktgen is missing in the MAINTAINERS file.
> 
> Suggested-by: Antoine Tenart <atenart@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44d599651690..3b11a2aa2861 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16202,6 +16202,7 @@ F:	lib/random32.c
>  F:	net/
>  F:	tools/net/
>  F:	tools/testing/selftests/net/
> +F:	samples/pktgen/
>  X:	Documentation/networking/mac80211-injection.rst
>  X:	Documentation/networking/mac80211_hwsim/
>  X:	Documentation/networking/regulatory.rst

Hi Hangbin,

Nice find.
But lets preserve alphabetical order.

With that fixed feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

Also, I think this can be for net.
That is the usual target for MAINTAINERS changes AFAIK.

-- 
pw-bot: cr

