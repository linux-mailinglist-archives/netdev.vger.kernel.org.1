Return-Path: <netdev+bounces-289680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OONxHe8JDWrysQUAu9opvQ
	(envelope-from <netdev+bounces-289680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBDA586783
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C13302DE10
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A82BE056;
	Wed, 20 May 2026 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdhJTvQd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4D2652B0
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239405; cv=none; b=t04JDLvs1l45iuLhw60PhQ78ZxX/xuHn4pmKSPvR4jDlOB+Pk5s2sRmeJ2FbNWUPEdeTUuatBNvE3CQ5AhkBSL0Y2Hrj2ckbrWQGNDxGCglBh4SXLaAyyPnYLHKqt66EsJnGkaiozQzcuwfOUmOvRGpJnEkNciMp1gOsHpW0ihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239405; c=relaxed/simple;
	bh=IkOHEI/LpGRqt7ytXDefJVi/kYvH1kGoXHVYRvK9MLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qUCWUuWQoTUI1QUDZ1U6xoCSdITvoc2EViEd7iILqU7QNWWlNXo/Wq6dZ82diJlmcxj4nE5dBLBPqQium8PhItW43M+HQ+hit7JoM0octV2RowbVsCABVphnt6f3IwfTUJpwfBqhAhVFSiq2cygGm4bbZVEy+F72o4s+bEJr/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdhJTvQd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C269B1F000E9;
	Wed, 20 May 2026 01:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779239403;
	bh=lPevcs8ANW9QNTT7TztESFlNNWQ0zhFljOBqzEMdK3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PdhJTvQdF4jv8895zLEriI3gRB4aq3skzWYZMbl4U975eJ18d6LgCMp52PTuN3ND9
	 Oun8tqymPyNYkrNNqsAd/5lJj7uxjmeeXT2CHJ3XudHOJmtWQwE5LLyn8Ttz6Hdo6m
	 y5Zfo585Dn7/ATFliIGvuLkFS03StytHd9WTFhr9NEg40j6yL3WRJdP6zBOGCI4LTp
	 qqrpekltsujnShB3MPSf2lxZBNP+eRvq7TMHQTIuBDv4ISQGNUWz4uiyPCkAQdCHiH
	 SgnLs3F5+5nHYtaMQDZPAcKDlum8QfQhEB9D3KT1pIPV31Yt4SH1K/h4k7/icTbFh0
	 /ZZAifnTS/EYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B28383BF53;
	Wed, 20 May 2026 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2-next V4 0/6] netshaper: Extend netshaper support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177923941445.2939832.1656899666620970575.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 01:10:14 +0000
References: <20260518202353.390827-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260518202353.390827-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexander.duyck@gmail.com, dsahern@kernel.org,
 stephen@networkplumber.org, pabeni@redhat.com, kuba@kernel.org,
 ernis@linux.microsoft.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,networkplumber.org,redhat.com,linux.microsoft.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289680-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ECBDA586783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 18 May 2026 13:23:47 -0700 you wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> This series extends the netshaper CLI with missing parameter support
> and adds the group command for building scheduling hierarchies.
> 
> The existing netshaper tool only supports setting bw-max on individual
> shapers. This series adds the remaining shaper attributes (bw-min,
> weight) needed for TX scheduling, and introduces the group command
> which ties leaf shapers to a parent node in a single operation.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,V4,1/6] netshaper: Extract parse_scope() and parse_rate() helpers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fd9d12a1423e
  - [iproute2-next,V4,2/6] netshaper: Add bw-min and weight parameter support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=dc5f7db81442
  - [iproute2-next,V4,3/6] netshaper: Extend show output with parent, bw-min and weight
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=8c3177b174e7
  - [iproute2-next,V4,4/6] netshaper: Extract struct shaper_args and parse_shaper_arg() helper
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=00a40c697f9c
  - [iproute2-next,V4,5/6] netshaper: Add group command for creating scheduling hierarchies
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e14b336a31b4
  - [iproute2-next,V4,6/6] netshaper: Update man page for new parameters and group command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=2638fef148e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



