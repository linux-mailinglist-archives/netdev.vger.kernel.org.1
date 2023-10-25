Return-Path: <netdev+bounces-44117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF697D65CE
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77F728100F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282F1E511;
	Wed, 25 Oct 2023 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h59zK9JE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722E1172D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 08:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F42C433C7;
	Wed, 25 Oct 2023 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698223927;
	bh=+pscKbv5sQ/WEIaY8Vj/oBZtJi+plSDd9ODGGLCaoxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h59zK9JEVenFVSLGog+fE0R7ysocTpJfWg+g6p5Y4UQ6cdLzCL8+XDcSEzNUQIoO4
	 CoF4U32wCCx4K7BE53THdkSnhRvi+njTYvC1sq/dZUqoeuS6fa6Sn0dOU1BaBdRlIE
	 GPYySPnwtrqRuif5Y+0BqLlJUNKLlKBPVO/dqJtH/j/MIuXSrNTXySQDkhq9TkzOee
	 9jNsBDJAUPTfY5pr364K5fPu5IuP6joEuN74e3Yi/7MZh6JYZc0XLXxWUtDGLSTstL
	 MLXzfwI5omCN4IyISFGtUA/zFq2Eu5OV6uAST9Vroy7LLVSy83FyzmNx9BKuBsD/jA
	 CzK80lgMtyFVw==
Date: Wed, 25 Oct 2023 11:52:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <20231025085202.GC2950466@unreal>
References: <20231021064620.87397-1-saeed@kernel.org>
 <20231024180251.2cb78de4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024180251.2cb78de4@kernel.org>

On Tue, Oct 24, 2023 at 06:02:51PM -0700, Jakub Kicinski wrote:
> On Fri, 20 Oct 2023 23:46:05 -0700 Saeed Mahameed wrote:
> >   - Add missing Fixes tags
> 
> Fixes for bugs present in net need to go to net..
> We are pretty strict about that, is there any context I'm missing?

This patch won't fix much without following patch in that series.
https://lore.kernel.org/all/20231021064620.87397-8-saeed@kernel.org/

Yes, users will see their replay window correctly through "ip xfrm state"
command, so this is why it has Fixes line, but it won't change anything
in the actual behavior without patch 7 and this is the reason why it was
sent to net-next.

From patch 3:
 Users can configure IPsec replay window size, but mlx5 driver didn't
 honor their choice and set always 32bits.

From patch 7:
 After IPsec decryption it isn't enough to only check the IPsec syndrome
 but need to also check the ASO syndrome in order to verify that the
 operation was actually successful.

Thanks

