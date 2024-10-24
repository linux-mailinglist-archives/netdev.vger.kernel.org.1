Return-Path: <netdev+bounces-138707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D69AE995
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7679C1F21D77
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8F1E7C35;
	Thu, 24 Oct 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUZtHagy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874811E7642;
	Thu, 24 Oct 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782034; cv=none; b=mytHJ5bFP6NL/A2KNxioaA3g8Ka0QWWTmrDLTPwdahSgkmIf/RFwagyy/gB249xmkbWbBzvdWoitF25ZahfEuJP/X30pG/UVSPWAjcH96DboXYkxj5wxwJdRuXVpIegYN5bTvVG1BhWUmGOTK7mHc3fjYJbQFtTxAbdfVQ7+zQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782034; c=relaxed/simple;
	bh=4uhqDhzUbOMhICXwbC24VmVgIHatH/G+fqnaQGKjJHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9lgeM/t+oYwSYpZKiRmxnUzuTCQNKm+7NEyZLYQ77HMHZox0pCFdOUqwXkFEnvNJ/caY/O+H8L3DTiyMkRRCqaZ32dxWjDLMGBzvoxeF+ZGEBrwspC4qnf8vKc1s6G5ypjLL5qdLTDzAnGh9SdFHYJVFJ1VTgjbUybW247KKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUZtHagy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3465C4CEC7;
	Thu, 24 Oct 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782034;
	bh=4uhqDhzUbOMhICXwbC24VmVgIHatH/G+fqnaQGKjJHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUZtHagyY8/9MvlhySk/Mu2RzUTZwfxxk+Qc+TzvoVg7TnkZ0+JU6ynTfGV5UDXvA
	 3sKZz5y4/ARs2AGOl6LUkG/SGo1y/dSVuVQUS3YUl8xxu1waotqgG539W2q99I7TNF
	 dNmpJZquWkURU6/J8wtPnM48w/nZu8TvKTISUBYEthtLIHpD0fI7Lhuz+Yjo1SUcO2
	 0AZ8deU4lgZHT90XY5EycXrA/+Dy/7RfUSMhol5U84pyGNDYMSx7XGruoKBesLH1Nv
	 Mk0c+3kTftMwhp8dQHq1Wmjz4twuSqJu6Uhd/+MDHvt5BsWWN3TyWsq6AiCHjcgVX9
	 MK7l9SiUcUYBg==
Date: Thu, 24 Oct 2024 16:00:29 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, jiri@resnulli.us,
	edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH v4 3/4] octeontx2-pf: Reuse PF max mtu value
Message-ID: <20241024150029.GT1202098@kernel.org>
References: <20241023161843.15543-1-gakula@marvell.com>
 <20241023161843.15543-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161843.15543-4-gakula@marvell.com>

On Wed, Oct 23, 2024 at 09:48:42PM +0530, Geetha sowjanya wrote:
> Reuse the maximum support HW MTU value that is fetch during probe.
> Instead of fetching through mbox each time mtu is changed as the
> value is fixed for interface.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


