Return-Path: <netdev+bounces-201249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A21AE89B9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636021BC7056
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5FE2D1907;
	Wed, 25 Jun 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeChOfL1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE278F2F;
	Wed, 25 Jun 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868662; cv=none; b=Ag1wpODWTOzR9KuQ6WsE9Frt7ylEFnAiTsIwnk6ft4LrXL7xD5kfg30AWiPpHOgjROilMUCcBQZVhhPwpzi0Lm3Gp/CDdPIOk9rEUGBzh2i1JMMFS2Fk+l3iJQSyBhXnjbSZQszk86TmxHnl/nHZ0H238uSNXpbkgXqf8WiB5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868662; c=relaxed/simple;
	bh=frd84xHX/CYfYMhX1MgzLR/wHvSZsaLe8WjaQSC5fDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzZWVNhYe5KBg5HrHmL8SQnpOotrD8dpgq8VQx3OMtCWCS6PWK4t6YXA/NQ/Gu2iNYIGBphBqh8J0txVsfaNj007onvxNoLm/9/8pGjD13MxY6Iiy0OQsYtQnAWFcEm8ilXSMaVnsknVSiMAs2E2mnwvz3CdW2prpm5YjJ4rrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeChOfL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA64C4CEEA;
	Wed, 25 Jun 2025 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750868662;
	bh=frd84xHX/CYfYMhX1MgzLR/wHvSZsaLe8WjaQSC5fDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aeChOfL14QbCgN05N1MiFdp4YxHPC67VO017Uo02nPa00c6s+uqI7Zt1eubZHbQ3x
	 VVy2FkPt0FgGaK8QO0fuGACH5zy+b/ygFPdzpPJJfvKUII3csz9cJSd3xCDot8LVqr
	 3GkK1ZPCn4bmuQMgPknKCyIjc6pw4W5gCr1+GsXA18kmvs6X7iRIYO8ESCYy534/y9
	 YORFzwpb1W5WuRCBo4qsblD6W6KtP40G+oAkA3PflrKTU0iadRBsL0m4gOea1k80/D
	 yRtgQMDrEvSMrOBA0lifzYvYjQb0dg6cipFVoummdNGDFnT+jBXdkwO7airtD+ZN8+
	 JVaED7AKw8jzg==
Date: Wed, 25 Jun 2025 17:24:17 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 1/3] net: enetc: change the statistics of
 ring to unsigned long type
Message-ID: <20250625162417.GA152961@horms.kernel.org>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
 <20250624101548.2669522-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624101548.2669522-2-wei.fang@nxp.com>

On Tue, Jun 24, 2025 at 06:15:46PM +0800, Wei Fang wrote:
> The statistics of the ring are all unsigned int type, so the statistics
> will overflow quickly under heavy traffic. In addition, the statistics
> of struct net_device_stats are obtained from struct enetc_ring_stats,
> but the statistics of net_device_stats are unsigned long type. So it is
> better to keep the statistics types consistent in these two structures.
> Considering these two factors, and the fact that both LS1028A and i.MX95
> are arm64 architecture, the statistics of enetc_ring_stats are changed
> to unsigned long type. Note that unsigned int and unsigned long are the
> same thing on some systems, and on such systems there is no overflow
> advantage of one over the other.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


