Return-Path: <netdev+bounces-45157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A17DB352
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 07:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D522B20C1A
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA98817;
	Mon, 30 Oct 2023 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHBZST+e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D0523A
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 06:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F2BC433C7;
	Mon, 30 Oct 2023 06:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698647498;
	bh=S+J9AFzCYDttSzWzh3dYnJ8v0XGwbEHrLfzqiN6g2do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lHBZST+etSdxkMupLwrfNXyif5kXXXh869Z6m/I59g+1qdgl4VIC1lSfURDOaGAZ0
	 ifsN4TMSnw6Qjno/RFwpIk0iZB9eBzbotrQB4riCYR20VWFnD/kH95lcma/Be9xshk
	 DCBcsKsu4/paJUMUbFIBmCfmR3dX1/ntTukjQcaV9OqfE7jpX5QFUDAxEhesIN2S/D
	 kmhtE2KfhowOqIC5yTs++h82cANNfOnadY2o+9ujCo4w3UbW6xOjlmOCrnmLD/Jk2V
	 jFfp964sdJf6qWmhZxBjxCRV82j6LQL5vKGZOVq48sGe9IoTtXM9DGT90In29kgG+z
	 eL5Fb58SLkErA==
Date: Sun, 29 Oct 2023 23:31:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net-next 00/11] mlx5 updates 2023-10-27
Message-ID: <20231029233136.595c488a@kernel.org>
In-Reply-To: <20231027222006.115999-1-saeed@kernel.org>
References: <20231027222006.115999-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 15:19:55 -0700 Saeed Mahameed wrote:
> This series provides few cleanups to mlx5 prior to merge window.
> For more information please see tag log below.

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

