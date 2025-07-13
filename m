Return-Path: <netdev+bounces-206405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15BB02F23
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 09:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C941189BA8E
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 07:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF31E5714;
	Sun, 13 Jul 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuzcRewb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848581D90A5;
	Sun, 13 Jul 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391089; cv=none; b=XPPb9cpxW7QMrbe3cHKzxWO7c6LZuGIvQtGl8ngFoLvP01cMXl6Hn+zo2gyS7eayDlOjS5X1fAaZ4qkLOgV7uR1DlmeB+KR7/pcuXz1ZYQor7RQ8zW1swlmAAmXm9Brub8YQcSWelvmdL8RlR5IpIOu/f/u77hliQY03S6PZqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391089; c=relaxed/simple;
	bh=gcJjqF3qbC7i1vVACf44b37+35OlsCUHhvfFok65IqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lPeiyRrPmMVsDs5uQEx4usZ5BtrFmMLTEqC7gvzZYWu0KAXDfRpBO8r1KouC4VZNBHTied415kWmyxTRxbPOo2zwsPA+DBqzR8tYspjQOBBS2IfZYDXks14bDs+z+BOtRok+Da0NDt3llStEXJAI9vJtnR4PQ2dAPX0rqmJfheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuzcRewb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE61C4CEE3;
	Sun, 13 Jul 2025 07:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752391089;
	bh=gcJjqF3qbC7i1vVACf44b37+35OlsCUHhvfFok65IqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fuzcRewbfpCc5jec4IjZyZWv27mj42NZVlNymy/5VqdLVos4R2FikukM+gkW8bfZ6
	 pYsSBMRhl1f1/MMeqUBhyu33sYmE070J6/murxE3IvOREnJwRU+sBHSAHGbXqDFi3K
	 Pm3BulG7oO9N0NS2bFGmy6PDNwAQZnN76yHGYNkww2eQVoPkTSAutbYGG9FakhwfFY
	 soGV36l+p5cAUr2LlWgfkoqXVrWO74rw2FgVzP7qrcThQO/wFBs27br5KFeUrNKuSd
	 MFoWrAhSzBW8WfRUfDtGc6EQESvWx33kGcVif5G6BR6DX2GZWQUH0evxKTHKUIAF1c
	 0eib6ID0qB0hg==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1752064867-16874-1-git-send-email-tariqt@nvidia.com>
References: <1752064867-16874-1-git-send-email-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/2] mlx5-next updates 2025-07-09
Message-Id: <175239108438.74271.15085611737046903662.b4-ty@kernel.org>
Date: Sun, 13 Jul 2025 03:18:04 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 09 Jul 2025 15:41:05 +0300, Tariq Toukan wrote:
> This series contains mlx5 shared updates as preparation for upcoming
> features.
> 
> Regards,
> Tariq
> 
> Carolina Jubran (1):
>   net/mlx5: Expose disciplined_fr_counter through HCA capabilities in
>     mlx5_ifc
> 
> [...]

Applied, thanks!

[1/2] net/mlx5: Expose disciplined_fr_counter through HCA capabilities in mlx5_ifc
      https://git.kernel.org/rdma/rdma/c/cbe080f931f48b
[2/2] net/mlx5: IFC updates for disabled host PF
      https://git.kernel.org/rdma/rdma/c/cd1746cb6555a2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


