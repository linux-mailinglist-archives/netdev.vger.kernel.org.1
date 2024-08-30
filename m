Return-Path: <netdev+bounces-123744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9819665FA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1BE1C23C3D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF31B3B32;
	Fri, 30 Aug 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtjNusWr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D7EEC9;
	Fri, 30 Aug 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032738; cv=none; b=l5rhhDcIX7Nzws7EvJtyN/uvmyrQq1OMLPyFCZCRsTMnpg7dyMaDA7teiKGhAqzMmGdWGmxNx5e1ZoyU3g+7TwVRoYvoNhXODSx9R4fr9L+VziUZ8DrHvpy/jsdxozEW0lE/Id5x2vCJYxMxoKz59fWbLxvKn6vSe0g7PE5hcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032738; c=relaxed/simple;
	bh=lBe5YwOMGAapvH5Vy/9MKyS/MuX+OGrqM8N/nchVUHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrDPgTW5W5fSrl3zjtS/8W8bsEUprNQNpTTfq60QJIaYTutfVYeUy+Vpu3s1p9iU6qScpKjOyLO4cVkt24DrgWatsnnis+ydoUBcfnTjLjq7YFS7Lt0CSHYuimUi/67grcT2ypum4d009kQftPHOrUfSz0yLM077xhZPIi6vYXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtjNusWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B26C4CEC2;
	Fri, 30 Aug 2024 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725032738;
	bh=lBe5YwOMGAapvH5Vy/9MKyS/MuX+OGrqM8N/nchVUHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtjNusWruA7ALGMmCNZTw44l9O31jlABHZFa/DbIYoMLTVJTdi1US3Na7ZrDTm8le
	 VSZ71kqzPehEl5rVE+ifyg+/FDulm3Gt8mYkZWfzXt7ECbbWLqmn96Tc2EolHLZCu1
	 SQcvj301v+lp+AWqwYnZ/ltRN5MYDDGQLsOp+yJ1mu0PEuq4tGmXwiE1nLDinsMBFu
	 zltxLG5jZ5bCI8KaRsG9VCWpvjPF4+SeJrZpzrfOIOUEgNXobxsvDVCLGPAjyl5vgz
	 nRYDHfk2GOuQQx9bui/CCEdH8GcOKSVCIp0qP5PV0xmZJcYyBsltlCxKk0YMcj4ku8
	 vu+KjfGh8IxKQ==
Date: Fri, 30 Aug 2024 16:45:33 +0100
From: Simon Horman <horms@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: marcin.s.wojtas@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v3] net: mvneta: Use min macro
Message-ID: <20240830154533.GS1368797@kernel.org>
References: <20240830010423.3454810-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830010423.3454810-1-yanzhen@vivo.com>

On Fri, Aug 30, 2024 at 09:04:23AM +0800, Yan Zhen wrote:
> Using the real macro is usually more intuitive and readable,
> When the original file is guaranteed to contain the minmax.h header file
> and compile correctly.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
> 
> Changes in v3:
> - Rewrite the subject.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


