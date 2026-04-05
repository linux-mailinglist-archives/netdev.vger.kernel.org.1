Return-Path: <netdev+bounces-275471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zK/QHjac0mnGZAcAu9opvQ
	(envelope-from <netdev+bounces-275471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 19:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B54D739F2E4
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71DA13005676
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F001A6820;
	Sun,  5 Apr 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9UmnzPK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C828E0
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775410226; cv=none; b=lQhRdC9Hiqz70KMdCqpQSnHs97MvxDVY6brXHk8KvJpJ0VcJi+7T+O74V7aOXOhZfs4Qyc1JX6BZU7PEIb9xSHZMIcVRiQ883b/DYj2hlKeFz8gOctwHMNt2QbTm0JbRLPyYgsvHrSljmAB4pmASFcKsNqGa+oA+xDMW9lCr1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775410226; c=relaxed/simple;
	bh=oGX8zI4hsebQkhaHqFyLO/l7T0imWZXOM6cVBFNryks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jeFhrd7vr0yrjbSXpkIi3CJcEg5y4yssTOW+LhadQgqoui+45g/GxTBEuKpb8vVv+O6hXcu2r3fiJKz1Pa7dIDo+5J9DEcdm8TaWk3MiJmegdsYZh9yxGZatrSdLGNUyW7KeWaSMPeyb7z1NsLHgf06tBNlmwzH9XJUhNjF8Q50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9UmnzPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B4AC116C6;
	Sun,  5 Apr 2026 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775410225;
	bh=oGX8zI4hsebQkhaHqFyLO/l7T0imWZXOM6cVBFNryks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r9UmnzPKKFVm5JRbzQIMSHXB3yB5tf4l0ip0FBnFCB78m2j6R7t5kHIxZ02fXJnY6
	 aAxhRE8kV3MtyrEIaclE1876PKc0iptv2oVE7U0I0tZW9xFREaEyc0LlP6M1MwCnAM
	 exU5fNWGEKGzpAyfSa9d1jGbU0c69zHwT4PzCD9pOr6qE8oDsotxzXa0HAWtwykqIi
	 suxBAyeV5DwnJlbOYPz452NVqOkCXjZJmry577S2DUqfpI21Np1ub00zYVjwvMC6GH
	 VWzyT2wF2z5jXyg6Yr5rtlFuk7gUK5HM3wBpkxMBE/7U1dlCz/r3z+qatimssXC/kP
	 IlwKyFTht70TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E0D3809A22;
	Sun,  5 Apr 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] dpll: Send object per event in JSON
 monitor mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177541020529.2002766.11711932063195027157.git-patchwork-notify@kernel.org>
Date: Sun, 05 Apr 2026 17:30:05 +0000
References: <20260329-dpll-mon-j-v2-1-c8170a80e6d8@redhat.com>
In-Reply-To: <20260329-dpll-mon-j-v2-1-c8170a80e6d8@redhat.com>
To: Vitaly Grinberg <vgrinber@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275471-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B54D739F2E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun, 29 Mar 2026 10:51:01 +0300 you wrote:
> Previously, monitor mode wrapped all events in a single JSON array
> inside a top-level object, which made piping the output to external
> tools (such as `jq`) impossible.
> Send a separate JSON object for each event in monitor mode,
> making the output suitable for line-by-line consumers. Skip the
> global JSON wrapper for monitor mode.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] dpll: Send object per event in JSON monitor mode
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=52204702bde3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



