Return-Path: <netdev+bounces-187573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10781AA7DF0
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 03:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9847B5A4C36
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC31D60DCF;
	Sat,  3 May 2025 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pohUkJEt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB35A8479;
	Sat,  3 May 2025 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746236389; cv=none; b=hJcJrLBE3kPg4Oj8rRDDakfRecwJiLSlRtMHp/BCNt1AuAWl9dR9kypE3TttpyLKEWRxNCiFk6jTV1zym8AtI7W1SCSLPxUcdc/s6bCpWdlzHTWRJwhPXkSlJwVJ8xZpvX/4lRt+NQqEx5b780Y1hbDIpQEEgCz2pT1GQcpR+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746236389; c=relaxed/simple;
	bh=kUE9dfyTbL7WgDurwx5nxsrda/CGqMTgTvgU00qO40A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VpdilceLPIT/fvpQidG/eh32r+ZvURupZHZshk9hfTFJY4IQVtp+/+6rDXqB+fe6oN4WeYXDH/hQtExlNsnNc38y0mN9QujlDRKZBH5uClGAm7h/iqFTW+akmm7nlUwaSYZYuLuijs177cyKGBJ21HktU/OQIy4dY3KFACIH/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pohUkJEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC65C4CEE4;
	Sat,  3 May 2025 01:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746236389;
	bh=kUE9dfyTbL7WgDurwx5nxsrda/CGqMTgTvgU00qO40A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pohUkJEtKq4oaxjLkVvbromWc6Qsxg0mgVs05CFqC4AeqTIQTIQXi4iFp1sy70SOH
	 ZueQIBVoqmYYAKFuNLvaOi88zj4hHydv8HJrNKI7eFPmdT2KjEZ2i4VFO6ubysJBn0
	 1XYhKspZA7+VIBYjF67QflkvyOlGcK8svRC5w84+C4XaVvrBMAaf3zNoZkUj135sVv
	 XHNXTeM3syJqDyv1l51fCNhWIORnGS15numXK+QWRd2jBtD36PPX130ueZ4nSWXObX
	 UZqUr/AMRdHN25cgZ0ma/3Xt0Oq/GHERX3F0Bq42BVv4tNmGu4GIjcF2o99OHXOG6N
	 9rfYc1+TK0k6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CEC380DBE9;
	Sat,  3 May 2025 01:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mptcp: Align mptcp_inet6_sk with other protocols
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174623642826.3774742.12489840490454605534.git-patchwork-notify@kernel.org>
Date: Sat, 03 May 2025 01:40:28 +0000
References: <20250430154541.1038561-1-pfalcato@suse.de>
In-Reply-To: <20250430154541.1038561-1-pfalcato@suse.de>
To: Pedro Falcato <pfalcato@suse.de>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 16:45:41 +0100 you wrote:
> Ever since commit f5f80e32de12 ("ipv6: remove hard coded limitation on
> ipv6_pinfo") that protocols stopped using the old "obj_size -
> sizeof(struct ipv6_pinfo)" way of grabbing ipv6_pinfo, that severely
> restricted struct layout and caused fun, hard to see issues.
> 
> However, mptcp_inet6_sk wasn't fixed (unlike tcp_inet6_sk). Do so.
> The non-cloned sockets already do the right thing using
> ipv6_pinfo_offset + the generic IPv6 code.
> 
> [...]

Here is the summary with links:
  - mptcp: Align mptcp_inet6_sk with other protocols
    https://git.kernel.org/netdev/net-next/c/a2f6476ed18a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



