Return-Path: <netdev+bounces-226255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2FFB9E98B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE2B421D4F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB3270EBF;
	Thu, 25 Sep 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvYyUTtA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3E23C516
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795407; cv=none; b=a31BNLG6GXpyHFOTL26tU8eN95JwoNAzlXJqhL51odOZ7Q0fiItyUlkZ3WSajoG3ikJXyocX7e8DKX5AxdOmww6hfj15IAA2rq/H24rx46JslKYYtIqNaJqFCSkaIAfjXhNZcfgCjCVwnXPrPXrWNkaKJjxgfHBjWAyU+AwA248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795407; c=relaxed/simple;
	bh=KsjMC22tgL9BirWssCi7syk0gozFxMspZUFVtA7SYRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYBVVDshE692CSE04k/L+MpRAVOhu413JHoNEcJbzY+2tmIlvRc5Jz1YPS+ChyDrMF5R2q/eEm6c5V3R7XTP3q9GgfnWMp2JinfmW8+LJ8FqUCDmWRvCr7xtYnsCuLzaojd9MgUVBDbOUy+1atXTxTVABxlJjZTYhFdSQ9woH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvYyUTtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9114C4CEF0;
	Thu, 25 Sep 2025 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758795406;
	bh=KsjMC22tgL9BirWssCi7syk0gozFxMspZUFVtA7SYRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvYyUTtA7G0KRpdVIc+ieOLv31GjEZ/dNmxYcWmHqW1Ee7Aq2JAvFETPCG64l8nd3
	 s4e6TCg+5H86nXGCruAiNZo0Uh54aiBsAntI01CDhemogA7lRsKtkdFS15ZCwE9Eno
	 s0fLhZ3ACsoGxNzNH9yTvVhXECdzMoWbnHXuIpab0pLfM6P1lalV3Fk4uxhyMPHTgs
	 k0XLNLgh9gw4jWgTdTtVamJMBd1CTpKTbb5OSAOinc4CQZME/Pf6qKYqw1SExCQcZs
	 G60Wjl+sr4Iiwv34TySo9X9hl6zAqn6RP3+sPCjCbFK3HeX3C+atoQqFlP8ZeGkBnX
	 mOmwwgT9kN5Ww==
Date: Thu, 25 Sep 2025 11:16:42 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kernel-team@meta.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next] eth: fbnic: Add support to read lane count
Message-ID: <20250925101642.GD836419@horms.kernel.org>
References: <20250924184445.2293325-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924184445.2293325-1-mohsin.bashr@gmail.com>

On Wed, Sep 24, 2025 at 11:44:45AM -0700, Mohsin Bashir wrote:
> We are reporting the lane count in the link settings but the flag is not
> set to indicate that the driver supports lanes. Set the flag to report
> lane count.
> 
>  ~]# ethtool eth0 | grep Lanes
> 	Lanes: 2
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

It's not not entirely clear to me why Jakub's tag is here.

> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

I agree this i correct because linkmodes_prepare_data()
will zero the lanes value, after retrieving it from the driver,
unless cap_link_lanes_supported is set.

Reviewed-by: Simon Horman <horms@kernel.org>

...

