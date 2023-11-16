Return-Path: <netdev+bounces-48243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C7E7EDB98
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 07:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D35280F74
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 06:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE218FC00;
	Thu, 16 Nov 2023 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfzDTwae"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32BDFBFA
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F419CC433C8;
	Thu, 16 Nov 2023 06:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700116543;
	bh=v69CuXVoE5R2qnzAizfMmufeV7uCr6kk8MAEC8MSm0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qfzDTwaezedcLRffdKZ89SpQ7W3A7uRR49ec/zgTuaH5H7ZQNRaZX0qVdyvwag6Lh
	 mjLtDmyolB1QoTXwbPMME3m898P4bU1Yg2kSPgjVJtCT7KM0IKXfuLpP/d2p01VnG2
	 Fr5xAKOuRngkM6bbtZHb7NkA3cB/MHoAi/wc+pfJH8ED76FUrGoWrDZJpoJGEL3NiK
	 UhhACqi1haL+3QZDV7V5/cvBfPeeTSph25JGZbqHOk3QoNKUhyYl8qabWlcqiIrau6
	 9MwL9+AR9c5DevM1O8gIv/CKlvfS4vaOXr6u/nemNFevl4oj70Hj3fN3i4KU/Z831L
	 2z2fW8G8TcnRw==
Date: Thu, 16 Nov 2023 01:35:40 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Dust Li <dust.li@linux.alibaba.com>, Cruz Zhao
 <cruzzhao@linux.alibaba.com>, Tianchen Ding <dtcccc@linux.alibaba.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [net V2 05/15] net/mlx5e: fix double free of encap_header
Message-ID: <20231116013540.3296775c@kernel.org>
In-Reply-To: <20231114215846.5902-6-saeed@kernel.org>
References: <20231114215846.5902-1-saeed@kernel.org>
	<20231114215846.5902-6-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 13:58:36 -0800 Saeed Mahameed wrote:
> Fixes: d589e785baf5e("net/mlx5e: Allow concurrent creation of encap entries")

Applied from the list 'cause I had to fix this tag.

