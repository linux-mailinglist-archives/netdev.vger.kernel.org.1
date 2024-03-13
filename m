Return-Path: <netdev+bounces-79618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72887A419
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA251F21E76
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80879AD5C;
	Wed, 13 Mar 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYQmjxKw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EB387
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318629; cv=none; b=bOUra0XFiWKcg/Si9+iQg+EHguJ7s7b5cA/N/S3ZpS5wZNFVJPlUZB/Jo50ptTtD+zOr7rDqbbcZNQ3YMMamSGNj95oi4ceg2PSicv1xEPK4QabSMjmfO89WZv9+2YzWSZ//xEClETO8puI+R2WfPgwyGnwIYKXQDlWr73Jk65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318629; c=relaxed/simple;
	bh=oRDfyltHl133djAXXMLAoljsgbOA93brInyqz8LiNg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aacbm5DCz5tNK+j9KU/KoxwJ3jnsuCXSDM0U+QpbsRJwwDPn2VfFWYDK2jsb5pR2X4Yi6b6MI4lxvKAU7iBDLUg5T4USelw/9K+N8t3iqV+bARuiT47HDykhf6KK5Drqh9aSU0eSiODEoWGe08xnf+ffrZBSZR5E3IdYY10A1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYQmjxKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBB7AC43390;
	Wed, 13 Mar 2024 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710318628;
	bh=oRDfyltHl133djAXXMLAoljsgbOA93brInyqz8LiNg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UYQmjxKwzT9mb9SvRhFuOW636NIPmtbDW3b7l3Hh5ObylAJuaxYOWmm6mhKyyQBrG
	 13eY0qvCtau+7lffdTnr/EwFmJq/bfLmY1LYtoIRKdxlgJa99I9gbt+/A7Pp/+DgIc
	 HT7gHc90VAbuquRgG+yf0KYEZN100srVAF5+rZ9KPwV9mIgkk036WdHlf7Qye+uF9a
	 wQGq+bMYeWyvgTzS/x5GJv8RsmoHkATPPbGLUk4L2tSXzwFQ8/L5NDvGW7MASuNU4G
	 WvT/ut+cWQXeHNUXAr931vH7ckhjV/V9STSXIB5UX7d/QJKTdpMaXse5uJFy/57Ddh
	 4pImYhSkzwk+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA798D95060;
	Wed, 13 Mar 2024 08:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: taprio: proper TCA_TAPRIO_TC_ENTRY_INDEX check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171031862869.2195.17842406623480961317.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 08:30:28 +0000
References: <20240311204628.43460-1-edumazet@google.com>
In-Reply-To: <20240311204628.43460-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+a340daa06412d6028918@syzkaller.appspotmail.com,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Mar 2024 20:46:28 +0000 you wrote:
> taprio_parse_tc_entry() is not correctly checking
> TCA_TAPRIO_TC_ENTRY_INDEX attribute:
> 
> 	int tc; // Signed value
> 
> 	tc = nla_get_u32(tb[TCA_TAPRIO_TC_ENTRY_INDEX]);
> 	if (tc >= TC_QOPT_MAX_QUEUE) {
> 		NL_SET_ERR_MSG_MOD(extack, "TC entry index out of range");
> 		return -ERANGE;
> 	}
> 
> [...]

Here is the summary with links:
  - [net] net/sched: taprio: proper TCA_TAPRIO_TC_ENTRY_INDEX check
    https://git.kernel.org/netdev/net/c/343041b59b78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



