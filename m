Return-Path: <netdev+bounces-96218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C918C4A9B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF291F22B81
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C8CA34;
	Tue, 14 May 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szZFwZk8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E715A8
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647830; cv=none; b=laZmf/t4WiCutH2HLXizYI0AXOFUqyjVnDWpmfXshUz8pnJGDGWITbWkRvFyDnTeWuVkkhm4CCdjRYZzs0cWfAwEYBRG4F79CkrolbTm+M05yJThlPug5Rbp/hgaR6/v78Z5vG2ZiqSKWm4+4NJfw1aW8QY0fyIpCJYGvGlrimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647830; c=relaxed/simple;
	bh=qL0LzMiOWB+bKnsAU5KAat/TCuPAb+BebOpoU2jQ2ag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DfQdb3gcU6dohs/IXavpGPu/nTATALHaPhxUCSXYod4eHfLIaWvEfwURooS4WeMeiFvOWnTN6Z8+1/U+QCY2q12oX4jzFCLo6lExtRUfRIZ6SrwWEWIgL5ibVCdO//q5/sWCmjuS/3wzhMrMYTuZDbEJiWX9DcsrFEdtlfEBB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szZFwZk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1A85C32781;
	Tue, 14 May 2024 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715647829;
	bh=qL0LzMiOWB+bKnsAU5KAat/TCuPAb+BebOpoU2jQ2ag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=szZFwZk82sgetUwlMyVBAaf/5Lcb47xj4hENZ17wJR07nvhBivDM9tfS+pKupClxY
	 prkuOvMef0cfjM9d53JXIaycgQxVF9FR6SQVB5PG7d/jf/3/Ie+bX6ZHiLwn4yNgLb
	 8OOBT2a6cbB3lRmZ0qxBnvTJKbvNcXhYE4mzmDYn+BLVpq6LqPeXHAjtQk+DjeIOQy
	 z9ANGdAoxbSPWLldR3hJUuwi2jEUHRDsbiGU9L3XeUwOOqwbPJtSoJ3uWXNU08brAE
	 g7J7+R2/U/HMijiTA5R5G97j9AqsXI+ye4PCFOY3rq/OCqC2gLtuzPbsgFKo+ldOLy
	 8OUgoQbVya9lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C153CC43443;
	Tue, 14 May 2024 00:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] tcp: support rstreasons in the passive logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564782978.31092.5667568179787514249.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 00:50:29 +0000
References: <20240510122502.27850-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240510122502.27850-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 20:24:57 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In this series, I split all kinds of reasons into five part which, I
> think, can be easily reviewed. I respectively implement corresponding
> rstreasons in those functions. After this, we can trace the whole tcp
> passive reset with clear reasons.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] tcp: rstreason: fully support in tcp_rcv_synsent_state_process()
    https://git.kernel.org/netdev/net-next/c/2b9669d63400
  - [net-next,v2,2/5] tcp: rstreason: fully support in tcp_ack()
    https://git.kernel.org/netdev/net-next/c/459a2b37a41c
  - [net-next,v2,3/5] tcp: rstreason: fully support in tcp_rcv_state_process()
    https://git.kernel.org/netdev/net-next/c/f6d5e2cc291f
  - [net-next,v2,4/5] tcp: rstreason: handle timewait cases in the receive path
    https://git.kernel.org/netdev/net-next/c/22a32557758a
  - [net-next,v2,5/5] tcp: rstreason: fully support in tcp_check_req()
    https://git.kernel.org/netdev/net-next/c/11f46ea9814d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



