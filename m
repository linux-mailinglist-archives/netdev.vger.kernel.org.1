Return-Path: <netdev+bounces-257231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH+sK7S3hGnG4wMAu9opvQ
	(envelope-from <netdev+bounces-257231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:31:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF20F4A2C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3145D300D4E2
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B71D425CD6;
	Thu,  5 Feb 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrwnEq1k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ABF425CCC;
	Thu,  5 Feb 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305407; cv=none; b=VWNwtwiYZeiaD36TKmbWK32yDdX02hCdN3XdJJaAPXbNE61C8Ke/ongp62fZe7p0a/xyBqPBgPT7n/cIqWvc0tQL5gYpl7Q09H+Xo3XfITLeGK/kE5eWXHR0RzJeQCmLgXRtF7pWDvl4nqivE5EBfRm0tWXJHczqQmzwkiP43Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305407; c=relaxed/simple;
	bh=iiYNzwB9ZgVfBypaZfkHLlNCuzW36uTTaMQAL3MvruY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=An6rZ908KYPeMujJb/8wOGcrQiQNbrTbUhjLUiOgY8dTIx/nkfht4JXtEMN9KAIJf0t2RA6WRHLfDYew0WHOgK0d3JRy7e+de1x1zwlL1I/e83+cw+5gwATKdppVvItOYwBITON6NOKSmXLuw1UrXJF1thYPSGRxvZ8g3PKPrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrwnEq1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083C4C4CEF7;
	Thu,  5 Feb 2026 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770305407;
	bh=iiYNzwB9ZgVfBypaZfkHLlNCuzW36uTTaMQAL3MvruY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CrwnEq1kKA++x4iwDZQfjL6DSc9GRhQSV6kCskKf4dOg5Fv+Sali+YLUgnBAsZFam
	 UjH3hqpgQnUUoO0VeEzc3zxiTWp+Ps+bpWLE06TFGykx8ZMg9NRHITcimx9gMsVDwf
	 2L7A4VrUdwDSsQz5NP2defleHsJb2C8TKbxcQgIEB0vp1hpcAH30qV5WIQtlOyCUN9
	 l2Icpz3YUBkdc8jZDX+SvgAmMTNkAh5kXkdU6P/7RJBOvh47nrjUXjsLqhIFxIau+8
	 cNH4ql5d0nlqulHryHGkEV4z/7mmHvTkfFI4PXaF2tsH/Q5qK0ubwTYwfLTaeZrdn/
	 bhdULkx659/ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B04E3808200;
	Thu,  5 Feb 2026 15:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] flow_offload: add const qualifiers to function
 arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177030540483.454346.3120240767343514576.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 15:30:04 +0000
References: <20260204052839.198602-1-mmyangfl@gmail.com>
In-Reply-To: <20260204052839.198602-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-257231-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFF20F4A2C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  4 Feb 2026 13:28:35 +0800 you wrote:
> Some functions do not modify the pointed-to data, but lack const
> qualifiers. Add const qualifiers to the arguments of
> flow_rule_match_has_control_flags() and flow_cls_offload_flow_rule().
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  include/net/flow_offload.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] flow_offload: add const qualifiers to function arguments
    https://git.kernel.org/netdev/net-next/c/770e112634e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



