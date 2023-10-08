Return-Path: <netdev+bounces-38893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D345A7BCE68
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 15:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CACB281875
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8399C153;
	Sun,  8 Oct 2023 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghPM3dBY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111BBE7E
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 13:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A371C433CA;
	Sun,  8 Oct 2023 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696770105;
	bh=HMuod/sQIBw25FNhGwfbVXfGLURFP8W2BfMfTcjpq+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ghPM3dBYNFZaBw/WGu7afyySXeE3nhQ5KkfF75BcjKKPfsrBM2k0/zW1NuquFgLFL
	 v75QORsaFHH3flxcllDSImgy65GbqqZAxLJTGEKbx5hLi6yGy2FDwOtByGbMq3L7jq
	 j5UqSoqiQ9irS7aCcHPp7j7pU0svn2iF8vXHal4c2tUO07ZNhZ3PtQdCqKCLqi/l4M
	 gC4N1DqVVWk4xiCZeyj83kHOZFM010K2Viwc+oyzveM2J6r4S4RPYgsvsLIsBpmnSo
	 6c1PFvHCWpehkWN9z3wgzNeR+/7XgcuXEBedUOR/tvuazSBK/gu6IKcRGV95svNdzm
	 9JNax29I1DoGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FEBDC395E0;
	Sun,  8 Oct 2023 13:01:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169677010525.31796.12660644499166832802.git-patchwork-notify@kernel.org>
Date: Sun, 08 Oct 2023 13:01:45 +0000
References: <6b2eb847-1d23-4b72-a1da-204df03f69d3@moroto.mountain>
In-Reply-To: <6b2eb847-1d23-4b72-a1da-204df03f69d3@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: idosch@mellanox.com, idosch@nvidia.com, petrm@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 5 Oct 2023 17:00:12 +0300 you wrote:
> The mlxsw_sp2_nve_vxlan_learning_set() function is supposed to return
> zero on success or negative error codes.  So it needs to be type int
> instead of bool.
> 
> Fixes: 4ee70efab68d ("mlxsw: spectrum_nve: Add support for VXLAN on Spectrum-2")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type
    https://git.kernel.org/netdev/net/c/1e0b72a2a643

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



