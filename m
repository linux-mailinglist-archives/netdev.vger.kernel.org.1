Return-Path: <netdev+bounces-137037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6D39A410A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A1FB21B5A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B091D2B0E;
	Fri, 18 Oct 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBJzg/dj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B285913C8E2;
	Fri, 18 Oct 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261406; cv=none; b=NO4/P/bO7Y8NQv+Hk4Ox9eR5PRpeFay/xBDh1bSWH/tGL8CJpVuo7NizrgK1SEAi9gL9NdqJmV2XT1UF4BPTLQpLQl0GuhHs2B/y/3xeJ1JxEhum4Q28GB4G2j0nTMVF55nrBSm+FiwOUgI7YmXps1aJbzfL05Xhb66AEpg3Ios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261406; c=relaxed/simple;
	bh=O54aNSriI9o9likNhhaxvYoS8qDdxequujrf9co9Wuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoAlEicIN1tUHgcRJBpw7NENyAgl7FGWNbTjXqOCZrpt26OCmNmetRU+vjYivIzbzLEF+wIlNCCR9f63RySbgd8Din6rRXfjCVX4qAVybHAZGu0XVbT6LquRhbehC4GAkxui6VlH7OPMh3jdHQQ/9Sf4RlwXiHFR3YtdnydGF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBJzg/dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E39C4CEC3;
	Fri, 18 Oct 2024 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729261406;
	bh=O54aNSriI9o9likNhhaxvYoS8qDdxequujrf9co9Wuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBJzg/djToULhduXSinA3gPXpnx38Wk/iJ+k7glLU+EWXVemzCDlQSyOTmgZtfM1g
	 vcqskygXyQDMfucHD20TO5AwD5m3H+np01jDALQJGl4GDnk/CdKnUR1Lw0Hj2fEP1b
	 sLJjCsGcTpJOCqNqSdzFrjZS8l/88khm94BxAVq3wmXWl4FGFBiZUZ1mexqO3pDd/q
	 alhyd/HcKHzcmP9wLQdhNtzYkEmkeMrxlkzYij9XAsLq7RBNNNJkZQOpFNJZKhQzBU
	 CBXc+m71zkCFBQul9EUD0aC4gFCKopRBYdCp+zApcxPcgUGAd/BibEJWX9eqtDKKgj
	 Q0G8JG/Vp6iOw==
Date: Fri, 18 Oct 2024 15:23:21 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Pedro Tammela <pctammela@mojatatu.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: act_api: unexport tcf_action_dump_1()
Message-ID: <20241018142321.GQ1697@kernel.org>
References: <20241017161934.3599046-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017161934.3599046-1-vladimir.oltean@nxp.com>

On Thu, Oct 17, 2024 at 07:19:34PM +0300, Vladimir Oltean wrote:
> This isn't used outside act_api.c, but is called by tcf_dump_walker()
> prior to its definition. So move it upwards and make it static.
> 
> Simultaneously, reorder the variable declarations so that they follow
> the networking "reverse Christmas tree" coding style.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Christmas has come early this year :)

Reviewed-by: Simon Horman <horms@kernel.org>


