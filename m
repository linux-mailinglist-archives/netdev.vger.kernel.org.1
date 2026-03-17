Return-Path: <netdev+bounces-268397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIKFIhS/uGn0igEAu9opvQ
	(envelope-from <netdev+bounces-268397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:40:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 240952A2DE5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB45E301628D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C37834AB17;
	Tue, 17 Mar 2026 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw2gb9WN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461273491F1;
	Tue, 17 Mar 2026 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715214; cv=none; b=cL5po51XrHrqNeVOoJRHTCnIIQDxZcYm/cQu+I8V68QaFc3qzcpkw2T674yBcIeghC4jlRTSaLZgiKjCYKymI8WpP1KSoAkmN8UYhvj18xkabkwmLUj3YuvlGNa9cIAAm2sMIh6Id8a6+EUaUEJ9MT4xlQFPf57bP/HtghXz0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715214; c=relaxed/simple;
	bh=mdDI6k+DTqtdZ8vWoHEZG9zGbBbobLIA59WZVP7ayaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BmLfdvhnLJVMl7QcLf9d5YP2IJIusMZ3/jHnbRPsQxOx2FJcoRYLPK+5Rx72Y8Iiiip5nbYdKaibWxarqBeH/aDcjLK39cZtJM7tB/a/H/DoZmAbQdqiG6vUG9Rn2u+TDZCkgnk+S9qsmEQxawRCshb9kRepH2g1afAPEXnsqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw2gb9WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FD7C2BC87;
	Tue, 17 Mar 2026 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773715214;
	bh=mdDI6k+DTqtdZ8vWoHEZG9zGbBbobLIA59WZVP7ayaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iw2gb9WNDlHz8dcS09yg4ARJXypXAMlFlGt0ekgTd1jEzoRgXwXlVk9UxIqvz9zxA
	 mtzxsMEFuctnguj8WfthaxXmmOwDycusMNR1dW2fDyf34BAWJ5+vq+xwkZor1dX7VF
	 q75PukXfgnoEXyaFOVMXo8sj8TD4amDiMi4YfDxWLpzd0AgTwTSSiGMmUhrm40FY8O
	 K08X/JxEoQ/MDnI8I3mm4pVln2G8qwrEgX7qoRUeMaCjzWm3e9D8NQ51M+3j9/8aWl
	 +2EGf3az/YDmJUDfTnoapL/5EdVgCZC5h+qghi/c+27ZShv00gks6jVH6JFV/bwMSz
	 nvV45Q4nzY/2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030833808200;
	Tue, 17 Mar 2026 02:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] xsk: remove repeated defines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371520679.3399897.13209936627620788705.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 02:40:06 +0000
References: <20260313111931.438911-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260313111931.438911-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268397-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 240952A2DE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 12:19:31 +0100 you wrote:
> Seems we have been carrying around repeated defines for unaligned mode
> logic. Remove redundant ones.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v2: remove another repeated define (Stan, Paolo)
> 
> [...]

Here is the summary with links:
  - [v2,net-next] xsk: remove repeated defines
    https://git.kernel.org/netdev/net-next/c/cc6421acd97f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



