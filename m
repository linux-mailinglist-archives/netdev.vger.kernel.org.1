Return-Path: <netdev+bounces-58717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78292817E5A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EDD28598F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20652909;
	Tue, 19 Dec 2023 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsYyfx6M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81FC7F
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF8BC433C7;
	Tue, 19 Dec 2023 00:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702944198;
	bh=kqiQzezth3w+j/Tw9pCX4dmbABqHX9BteVYa+fixq2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SsYyfx6M5/g3V+mH+XAY8iabdCHYjCmKAYc97r7FoTj1xGBwsJk5KfFTZYXRzVzrJ
	 TKbo18EWR0lWonG5eNbdv67AnYtdAXl4LIrxp+60498HQSIvs/hIVrCUxuFNzRpRwk
	 pD9aiD3WPHQ4OgkhSvzayQ6BrYBqm7otxC8h+qy34kjnAu7x9q/oeLl2wrqyR80QNS
	 /kEYm9cdjavvfW6V+Re0U5IG/Ny9VPIwsRwcVBtjtUq2dphIqYLvgpwoPRrH+lGix4
	 DwvnpjUA4F0ZItfKNvsaM5eBX1/JFqc9uN/RayycorqX8d8LAAIs8XaUYrfPcI+ste
	 /ew+KdVLIcf2g==
Date: Mon, 18 Dec 2023 16:03:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net-next 00/11] mlx5 updates 2023-12-13
Message-ID: <20231218160316.70633146@kernel.org>
In-Reply-To: <20231214020832.50703-1-saeed@kernel.org>
References: <20231214020832.50703-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 18:08:21 -0800 Saeed Mahameed wrote:
> This series is in preparation for mlx5 netdev Socket Direct feature.
> For more information please see tag log below.

Applied, thanks! (on Friday night, apparently)

