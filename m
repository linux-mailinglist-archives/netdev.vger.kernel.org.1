Return-Path: <netdev+bounces-99236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30FD8D42D3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FBC283A59
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F60011CA9;
	Thu, 30 May 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMOyljjJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC8FC18
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032130; cv=none; b=Ogz3uVyOIk+zEYTVr3m0kohqwfyYwYmHSHDmUPURFfU4IGT00ckI42Tel+Y/m/4IaI3L3xthFAfvtdY1vNCi9t9A3O49xieFGtyZKGTmFa8JMvZ1g2/2RTn4O3uprZ9TpxdtxSeXc2KDxa1yr3xy/lqnQURnu/BJM9red6WQBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032130; c=relaxed/simple;
	bh=B3KxHCuK55bfIFIjRDtOEvnJZslfj+gHwFmArHYum1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAdNyRi0deH5Z6bDAn7zXY+WZ6wJtErfqdsFcNe5PfTp6CJITsLC+wQ1mCB53y8eNjpSep7pUHzJECxBxMpG3XXHgLdUx/HQqHo5jHfyzOV4iwUVV3EvhUQB7HKa9SWerfm4U34FE0f/3dDHUtRHtSkPL9D5II48d46eWdRFGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMOyljjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282CEC113CC;
	Thu, 30 May 2024 01:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717032129;
	bh=B3KxHCuK55bfIFIjRDtOEvnJZslfj+gHwFmArHYum1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BMOyljjJzoSM5uZ7HTU3qCFaNp8iE/C1DnLESxJxNB7cmT4RoQ9tIxjSWhcS+j2xO
	 pDL/dwFXG4tIGibKgdC+4WSa2gGmh7Gs0v046ifzBlC3BbT36PIKhNILVEN7KaxT4h
	 8TmGR4CZhRlnE0B+uiK2iLtucbZbjSWB0fsi33hYXSvi0qzcE0p44ID8V5PIDzXVzV
	 nN8z1jBxi+lVfiTjEi0yr4FTAwm1FXqg8aA5QNfN7O0Qqrwa3c/GKUMANwWyHWha7f
	 1QVtdM0jkq3otb/azFVXafwn8JDgRsPuN6MXVietTzXmggnDDlG26v5BNOdfgtctj5
	 G5AiVajCDiK5w==
Date: Wed, 29 May 2024 18:22:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 11/15] net/mlx5e: SHAMPO, Add no-split ethtool
 counters for header/data split
Message-ID: <20240529182208.401b1ecf@kernel.org>
In-Reply-To: <20240528142807.903965-12-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
	<20240528142807.903965-12-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 17:28:03 +0300 Tariq Toukan wrote:
> +   * - `rx[i]_hds_nosplit_packets`
> +     - Number of packets that were not split in modes that do header/data split
> +       [#accel]_.
> +     - Informative
> +
> +   * - `rx[i]_hds_nosplit_bytes`
> +     - Number of bytes that were not split in modes that do header/data split
> +       [#accel]_.
> +     - Informative

This is too vague. The ethtool HDS feature is for TCP only.
What does this count? Non-TCP packets basically?

Given this is a HW-GRO series, are HDS packets == HW-GRO eligible
packets?

