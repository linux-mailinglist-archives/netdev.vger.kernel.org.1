Return-Path: <netdev+bounces-103763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95089095AA
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45596B21210
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97E6AA7;
	Sat, 15 Jun 2024 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwbm0Uij"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43345256;
	Sat, 15 Jun 2024 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718418131; cv=none; b=dSZtW9N3tbw45zgY1yZWeBlvGqe+W77fOK9HFvyHlwIDILHwNa6pzEos/uaNwmZq65gilrlDDtPN11TFh/fqWby/CI8ertE/hX3S8GyVkEhUUalI+tw5HlLKrc0i+60W4tEnDbkzmPBSjNR4NaWoWtLoNc9dDFstkg9lNyCPpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718418131; c=relaxed/simple;
	bh=hb/b+BnE+J1YFiQ9Yjo8OckgxuBKzXVRW9fzSe1i8Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hj1AK8l+5cekmB4NjOpuWdgYvbp3a0vaVWVZXAnxAwb31zrMQ1gS5oPyIpE0pkK0g6pKDViIzJg8bBHyLqVQD19p55OMvWUUWQpQCpQXim5HGFCfxu8zRH6e00ah/YabfQ/f/ndd80QA6sjBk2mLNor72JFfYTn5wrsrOXl3xOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uwbm0Uij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FA4C2BD10;
	Sat, 15 Jun 2024 02:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718418131;
	bh=hb/b+BnE+J1YFiQ9Yjo8OckgxuBKzXVRW9fzSe1i8Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uwbm0UijCsMMF85JRAcwkAzXHISp59d1iRI/5v+vFY5z2bwZBV7SACfmviHOHdwz6
	 CJZ7EososhEIkvMaIAFtiL4xthw7wA+Hsz3XgBrScSYm08OLbDe3RcjTC9DB2RFUGu
	 PGlCLRw0VTmqwOjOOV/HJai1XLtdEEHShOdEdUlc/AKKYHmcEtNXMz5mIioub2iflP
	 PPOcP6ZxUAncc9JvDy5PN0YgqLJOjEAX7BLipcHUGNMJ/k4y0nRNQGVhSXhv72Jl8q
	 AgXDx6cXwRHaFhLszjbcAHKMaxSrNGmiXBsEMypiA/yIHW7DNBwscrUSRk/Ki+t8IL
	 sEm5OvJbjaPcw==
Date: Fri, 14 Jun 2024 19:22:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, hramamurthy@google.com,
 rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] gve: Add flow steering device option
Message-ID: <20240614192209.7c69df0b@kernel.org>
In-Reply-To: <20240613014744.1370943-4-ziweixiao@google.com>
References: <20240613014744.1370943-1-ziweixiao@google.com>
	<20240613014744.1370943-4-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 01:47:42 +0000 Ziwei Xiao wrote:
> +	if (dev_op_flow_steering &&
> +	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
> +		if (dev_op_flow_steering->max_flow_rules) {
> +			priv->max_flow_rules =
> +				be32_to_cpu(dev_op_flow_steering->max_flow_rules);
> +			dev_info(&priv->pdev->dev,
> +				 "FLOW STEERING device option enabled with max rule limit of %u.\n",
> +				 priv->max_flow_rules);

There's a print to the kernel logs every time driver loads to tell 
the user flow steering is available...

> -	/* DQO supports LRO. */
>  	if (!gve_is_gqi(priv))
> -		priv->dev->hw_features |= NETIF_F_LRO;
> +		priv->dev->hw_features |= NETIF_F_LRO | NETIF_F_NTUPLE;

Yet the uAPI feature which is supposed to let the user know its
supported appears to be set unconditionally.

