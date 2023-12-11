Return-Path: <netdev+bounces-55791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DFF80C56D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831FC280F69
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434221A1E;
	Mon, 11 Dec 2023 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlCu5CYP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887D21A1B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 486C5C433CA;
	Mon, 11 Dec 2023 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702288826;
	bh=BCEelaBsjizNZjSye/AqPbArucH4NPqcJRWK8LN1W2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SlCu5CYPG/C3ePD0jspg9jqOnmFXuq/UkoI+RGQdIF7/6aI/dyxl/mEI39iR5/vf1
	 WPU0wiysdWiV8ZUdbqyGNTaT4e9JjvE1QkvlGPuufQ/QMNi9iTXH6a+Tc5+sK6KjSL
	 4T1ociuqWD7JuN47cM7XCZ7kT1S0L7dmWppjApxSyG9RWNhcCQ4S2OGM6sVbDy7T8e
	 O2Rr7wgVUyJVSXGgC2P6QdB/I0FwID8xibFtDUlH1RQcCIEWMLzC1WFv0vC7JJ9aqX
	 1RoIt1MV+u797iSnulryPECsJK88H7FifFEfPrNCWEIbDbBJrIfmX0Nnd2jiaOqbrh
	 0Wdiwv21tv3GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E976DFC906;
	Mon, 11 Dec 2023 10:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_ct: Take per-cb reference to
 tcf_ct_flow_table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170228882618.18308.4924858815697877556.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 10:00:26 +0000
References: <20231205172554.3570602-1-vladbu@nvidia.com>
In-Reply-To: <20231205172554.3570602-1-vladbu@nvidia.com>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, louis.peens@corigine.com,
 yinjun.zhang@corigine.com, simon.horman@corigine.com, jhs@mojatatu.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, pablo@netfilter.org,
 paulb@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 5 Dec 2023 18:25:54 +0100 you wrote:
> The referenced change added custom cleanup code to act_ct to delete any
> callbacks registered on the parent block when deleting the
> tcf_ct_flow_table instance. However, the underlying issue is that the
> drivers don't obtain the reference to the tcf_ct_flow_table instance when
> registering callbacks which means that not only driver callbacks may still
> be on the table when deleting it but also that the driver can still have
> pointers to its internal nf_flowtable and can use it concurrently which
> results either warning in netfilter[0] or use-after-free.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_ct: Take per-cb reference to tcf_ct_flow_table
    https://git.kernel.org/netdev/net/c/125f1c7f26ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



