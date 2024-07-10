Return-Path: <netdev+bounces-110463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC1F92C81F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D95A1C2173E
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEB463D5;
	Wed, 10 Jul 2024 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVOmkdAJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5F847B
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576486; cv=none; b=NCo4WUh8435a41LFp0NvV0FAf2BkRUvvaN9RpBXJdYwBi60SD85epx27blYzkX9xg/ekLzZZ8+Dwb8PuIPhgpKBA7uJMYZ/AGCsLcci0zXk7fnLcrReiehwjHU8bH1msZdV6WDbFKgPp77wBufIuRI2fcz6aJ35ZMHq4VsjXGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576486; c=relaxed/simple;
	bh=UGnVGxZQ8nYQY1oFLxyjAceG1xm1icohkQgVn2LQKgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgOC+I1QE/tWnwmBwAUKZ5TzYZ3xAKy5nPPi54M2L7REUNqsukTHKYK8Ih+H+Uf0VhGNnHD24u0tWlZBSvJEoeFt0aVEa9UeXBAvAOqsUpjyghmfgVA586BKTcpssKDg9ZC59xcajhaI4gjdT5h52n0jtPXGPFJd3rkK7B12us8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVOmkdAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6617C3277B;
	Wed, 10 Jul 2024 01:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720576486;
	bh=UGnVGxZQ8nYQY1oFLxyjAceG1xm1icohkQgVn2LQKgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UVOmkdAJrH3BKBtVr4sA1yP040Jdgt6mzOu6D0cHh8WLd7wawHELsj2BmaLcwgwVZ
	 8CfeyOjfxWpHTd2xKFJ7KVSHsI+tfwiKjJS73XQ9tUssPGg1QWXIOreU3G9xLUDpDC
	 Rxt+88xmjCefSjxC7THxOZcXQBbGmIfuwm6GHfKLvAWSmG2IuLCDmHh0a8qgsIb3R2
	 Tty1QE58DwVNsPhd/sIzsthx9ACqIdwddgXv1DH5fJu+ZB4gdFncwsYtrPdpDf3yWo
	 CrKHWNcsIWPn9kp3sl4Tcfov0yvzk7xtB7DEHlz51URjakg8m+fGtQlb7JLqJIX7+G
	 wIoyY21i/amGg==
Date: Tue, 9 Jul 2024 18:54:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
 <danielj@nvidia.com>, William Tu <witu@nvidia.com>
Subject: Re: [PATCH net-next V2 01/10] net/mlx5: IFC updates for SF max IO
 EQs
Message-ID: <20240709185444.6ac9f178@kernel.org>
In-Reply-To: <20240708080025.1593555-2-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
	<20240708080025.1593555-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 11:00:16 +0300 Tariq Toukan wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> Expose a new cap sf_eq_usage. The vhca_resource_manager can write this
> cap, indicating the SF driver should use max_num_eqs_24b to determine
> how many EQs to use.

How does vhca_resource_manager write this cap?

