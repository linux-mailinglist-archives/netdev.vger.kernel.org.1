Return-Path: <netdev+bounces-82817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C688FDE6
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DEA1C228F8
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968A7CF30;
	Thu, 28 Mar 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpfEeUCL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF359B73
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624680; cv=none; b=ot7qY9w7+9a9V/zvY75zuY1aJEzJcXdtx+tXsW5YhG0C7eFGq4w8H7r84mwyt1E5QU41TnOQSdibZKigYxCvwpfFFA16KRoiNHyOPjsJhVWssMmQgjk2YzgGncvY5x4ZM3TOJGZYpmSrhcLEQkTHiZ7EtWHiAdYVD3aSVn0DWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624680; c=relaxed/simple;
	bh=/m+rCdcgXhgUAIB05VdUnrd1g5RvGCXh6J3WumB6cYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru/gQKBRaXZnKx55OXaz8yC+FhcPJNEPSbFg4sYE7Hy0VsAJbv4YTp02V2YwFd7Spfh1CCYyLZovWLid08uAiJt4y7Uo5MRvtGuIx3JFH4bXPhl0RzeTG0NtrfAuO7BD6ZWOqdDJ23QuA9XK8/VocrwKFBA+/UYx0B9jM7Qr6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpfEeUCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EEEC433C7;
	Thu, 28 Mar 2024 11:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624679;
	bh=/m+rCdcgXhgUAIB05VdUnrd1g5RvGCXh6J3WumB6cYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpfEeUCLsEV1/Md9viOkrVs5mnQ1qwhzEOEZ0O9/0XOG7vLHHFo4jZsn9tfOQLH2i
	 d5xqHg6SVeNRbGZ8UXGRbZWWbDru9Vj8EWQfksYvgHpQttkNd7R9jqfnRTbU5TG4QV
	 U2tgpj9Iu08OChqo0xowlNmt1SnDd2EK0kbjrgmmKZoNS2sFefS2Eu3649CcAfFhzk
	 xOnBOZavfpmmLfmwlEstrg6Pwi6FrnoWMxMYCgjjJqFAMh1ifiG9N25o/0qcCLAC34
	 81EjGmLWZ8NNm5ySf2rzAcrcrA9Izet2QMbIoBwoJu8PUH7rf8e1RlX5pwoB+MWlUj
	 QH5jSPZI7O9cw==
Date: Thu, 28 Mar 2024 11:17:55 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 7/8] net/mlx5e: XDP, Fix an inconsistent comment
Message-ID: <20240328111755.GZ403975@kernel.org>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-8-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222022.27926-8-tariqt@nvidia.com>

On Wed, Mar 27, 2024 at 12:20:21AM +0200, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Since sinfo is no longer passed as an argument to
> mlx5e_xmit_xdp_frame(), the comment is inconsistent.
> 
> check_result must be zero when the packet is fragmented.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Hi Carolina and Tariq,

This looks good to me, but if there is a need to repost for some
other reason perhaps it would be worth mentioning that the commit
where the sinfo parameter was removed from mlx5e_xmit_xdp_frame()
was:

eb9b9fdcafe2 ("net/mlx5e: Introduce extended version for mlx5e_xmit_data")

That notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>


