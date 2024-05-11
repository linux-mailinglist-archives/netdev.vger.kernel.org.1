Return-Path: <netdev+bounces-95651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BBE8C2ED7
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9521F22F8E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E712E5B;
	Sat, 11 May 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqn2FRzm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76FEEA9
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393429; cv=none; b=RoJxlwqZhYV2vDQkMbOs60GXl58DM8BUTnFknNdIBnHIdwAF59oziXzTl6JM2MqMdFE3TcT6xXq2ST49rvEF3seHRLiBQM4/ljcF7qxhj/K3LRS39csfGLJA4T8awsH6GXrKH2EmzwlXDi5l14bDFKSrjrX/rimjbAdHIoHM2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393429; c=relaxed/simple;
	bh=2P8ly0j7PStT83TI85/Tvab+YzkPbzWSJQsJvd4RM9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k5omNh4Q8KtlXjzmBoCuoY6hdGmLTh4+t3BpD+uQZs9/MdpD8jem8SfXfXheNpMYG9BBBHX7+IjBaIRVXkyut6+mK3qwvfr23JvyE57YBhKMDepSYsr8LgHzAMudMEmKFK8FYF/BvLsiSKMmXO7Xky/95e5sxVDgNstTXJXdYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqn2FRzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94C9BC32781;
	Sat, 11 May 2024 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715393428;
	bh=2P8ly0j7PStT83TI85/Tvab+YzkPbzWSJQsJvd4RM9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tqn2FRzmVQZjWEA0HuRAZb0RNWT6lA4eKlK6/sl+w7zG9SYu+fK5+am6qdpBwRU+k
	 RW0utSRqeMlC8rbf4iassidurQ/SgdUX+QE3DrO37e9c+M2PiyjFRQ7RtPTBcw17Tc
	 C4SNnUUER5dxhdqeLeZS1U6bdJTg+o0VsPmBGiDl/qr7vhA44z1OGN7ugqqf6sKZYS
	 0CeLPOREMMarmxWwvM/3fbHQSPDXXfZS39LLklvxK88AgJnxsNR6t68XGE6M82WnEO
	 PK6c4XBFfJNNJsztd8i2axFSRYPsR1iCBDixs1v/6cVFgofMs0aXCrCt18c1vb4Ho9
	 yhzUSKPl3H83w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8545BE7C112;
	Sat, 11 May 2024 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] af_unix: Add dead flag to struct scm_fp_list.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539342854.19094.2843739418134181791.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:10:28 +0000
References: <20240508171150.50601-1-kuniyu@amazon.com>
In-Reply-To: <20240508171150.50601-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 8 May 2024 10:11:50 -0700 you wrote:
> Commit 1af2dface5d2 ("af_unix: Don't access successor in unix_del_edges()
> during GC.") fixed use-after-free by avoid accessing edge->successor while
> GC is in progress.
> 
> However, there could be a small race window where another process could
> call unix_del_edges() while gc_in_progress is true and __skb_queue_purge()
> is on the way.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] af_unix: Add dead flag to struct scm_fp_list.
    https://git.kernel.org/netdev/net-next/c/7172dc93d621

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



