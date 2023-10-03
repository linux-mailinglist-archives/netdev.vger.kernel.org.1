Return-Path: <netdev+bounces-37593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8AA7B6301
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 012522815AC
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EC7D512;
	Tue,  3 Oct 2023 08:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC9D50F
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 08:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73092C433CC;
	Tue,  3 Oct 2023 08:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696320024;
	bh=E0jQM8BhH2LaM0xbaK0cMDCk7fz6afRN3SBgIT/MWb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QSMr3GRSqmxe5UmQtAuouUyB593eq81NTZj+WGBXmflBZVC4p7Sywvj3EyBxju9Pv
	 Fe/Y6jHOQ0jqWFPOfl7XrYZLUcNqRcV1Etxayh4ut9vSIzTG2Z981jjuIY8zps/P/U
	 L/3q4q1DiqPcnHa3iR0a55b0SAAH/aO0T48t7KN+I+ElKj+eMqlSUJvb7EQAGaM2no
	 AF6DKXnuID3hV1A81TXYi5A/zjD95pLMl/HRYhyzHwZb1h/d8PhVckJ9B8ODIltg36
	 dJkUs/3qg4PUzaTKBASIy4i0m+Jxv6oPBFw01NPw6l2vAzW36vVpjB4DumBSh+bKWM
	 yS0blIP9xr5jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5869EE632D8;
	Tue,  3 Oct 2023 08:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169632002435.14594.164514284857184031.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 08:00:24 +0000
References: <20230922210530.2045146-1-i.maximets@ovn.org>
In-Reply-To: <20230922210530.2045146-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 dsahern@kernel.org, fw@strlen.de, madhu.koriginja@nxp.com,
 frode.nordahl@canonical.com, steffen.klassert@secunet.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Sep 2023 23:04:58 +0200 you wrote:
> Commit b0e214d21203 ("netfilter: keep conntrack reference until
> IPsecv6 policy checks are done") is a direct copy of the old
> commit b59c270104f0 ("[NETFILTER]: Keep conntrack reference until
> IPsec policy checks are done") but for IPv6.  However, it also
> copies a bug that this old commit had.  That is: when the third
> packet of 3WHS connection establishment contains payload, it is
> added into socket receive queue without the XFRM check and the
> drop of connection tracking context.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling
    https://git.kernel.org/netdev/net/c/9593c7cb6cf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



