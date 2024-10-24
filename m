Return-Path: <netdev+bounces-138706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C519AE993
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655DC281F6E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52691B4F02;
	Thu, 24 Oct 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvQSgpk1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB81CFEA9;
	Thu, 24 Oct 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782015; cv=none; b=LMBHG1OPb/wSF+KqNqHatG0UPxuaKql2LOsmHzwOfzygbsv5HyRzfgNDD7WOHzpreTEvltDXCQh2OSpu+UPnBXAvS9Eu8OYNuH3VJHUeavf25J2ElDiCTQO+S7GYJHMSFxwhRvNnZLQX+nWFEwnFI2PmrpktzMoN/wOzpNIBryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782015; c=relaxed/simple;
	bh=Zwqrm2mDJHvRPj1HoH1A/veXjKiBZQqnEDOkO3YvTSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLH4TLmS7agDJQhmRvUqV3i0YNiBuPWsIxe13SicRTQimfPjSAqDOVB+AjJjEA4Y6ycEldUi95mlYirFCu6YMNiV3u8e7/xBuDDl9OQ0j1WPMaDu6dNM+ETPkE2UJJjBOPsDjGOeuiPGf0dT4Ju+ccaoqFb3+yNOJBb8BC2lXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvQSgpk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268E2C4CEC7;
	Thu, 24 Oct 2024 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782015;
	bh=Zwqrm2mDJHvRPj1HoH1A/veXjKiBZQqnEDOkO3YvTSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvQSgpk1z5PQx11EpGx/ysHr8V7ox+IkKzs0RwxImRcT063HAu0XMb4AzvhCcuCJu
	 m3AUbPApNaU/e0gKA9IvmpteFM9Fmey+8+4UlEmFswjA8N+z3O+lSxGFfkG0DilrV4
	 qj2ULzBoAbPHPk8z2dhzHEKvNaNGzm0TBkc7JMpDVhf0Kj6jHtp7zurw2aPTsh6wbA
	 vdc6WsS/+O6rrOh0yOD/78vdaS6IOyeWp2aISvEFNdW968iIdscqVUZgSTfgTTpW8P
	 fXSDMwD3nBHvJ4NWpSScxWkmwhHO0+VakYAF1Mw4vdCdHjsv12AKB4j67XigPehg1b
	 hsvdeWeI29rGA==
Date: Thu, 24 Oct 2024 16:00:10 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, jiri@resnulli.us,
	edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH v4 4/4] octeontx2-pf: Move shared APIs to header
 file
Message-ID: <20241024150010.GS1202098@kernel.org>
References: <20241023161843.15543-1-gakula@marvell.com>
 <20241023161843.15543-5-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161843.15543-5-gakula@marvell.com>

On Wed, Oct 23, 2024 at 09:48:43PM +0530, Geetha sowjanya wrote:
> Move mbox, hw resources and interrupt configuration functions to common
> header file. So, that they can be used later by the RVU representor driver.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


