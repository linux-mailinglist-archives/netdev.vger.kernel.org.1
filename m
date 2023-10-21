Return-Path: <netdev+bounces-43178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0B7D1A5B
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 03:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C8D1C20F9C
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 01:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168347EF;
	Sat, 21 Oct 2023 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVxeFcXz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3627EA
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 01:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27850C433C7;
	Sat, 21 Oct 2023 01:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697852900;
	bh=TnyBx1rAZe3WcULtPcFsC1wEJBqW735X0JzzA8Rr/ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iVxeFcXz9mRF8BxjzZA5q180OQMr/R6g04SkRNHFPk0I8kF1+2RpjrxJ2YOCT+EfD
	 fRAeJgJxkOpzKKGT3vA6l9DStohPdC8n3N3xl6EwAUfqDmMZBsFk1iqm2jzOYoE/mJ
	 YZ3spX5vPZeVeRLGUjD2tPG7XXeGoaGhIP+7kkcMUZVxlv+o1XzQ87/ft0WxZx2KhJ
	 RjIldelIlcaQJW4Pd+wAyyz4RfcnTZcLdorslQb6F3QasIBQPLB8jdcBkoYWbIoJK9
	 AqaKV5yJMfFfmM53/echp7HiiKK260oL9KFsnaFxE1VmchDOjI2tKJDOID+H/X91mv
	 A+PVpgWH1wsUA==
Date: Fri, 20 Oct 2023 18:48:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Patrisious Haddad
 <phaddad@nvidia.com>
Subject: Re: [net-next 03/15] net/mlx5e: Honor user choice of IPsec replay
 window size
Message-ID: <20231020184819.73bddc4a@kernel.org>
In-Reply-To: <20231020030422.67049-4-saeed@kernel.org>
References: <20231020030422.67049-1-saeed@kernel.org>
	<20231020030422.67049-4-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 20:04:10 -0700 Saeed Mahameed wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Users can configure IPsec replay window size, but mlx5 driver didn't
> honor their choice and set always 32bits. Fix assignment logic to
> configure right size from the beginning.

Fixes need Fixes tags (or explanation why users can't trigger the
problem which seems unlikely given the first word is "Users"?)
-- 
pw-bot: cr

