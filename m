Return-Path: <netdev+bounces-292033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF+nKulEFmqUkAcAu9opvQ
	(envelope-from <netdev+bounces-292033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:12:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD85DE2A3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A731830760A2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2565314B9A;
	Wed, 27 May 2026 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXEBOiUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C612311C11;
	Wed, 27 May 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844210; cv=none; b=qnmMp6xa64r1jfsv74ORFtC2lga2UI2uhiUY/dKYM8wiiYhyMf77U6sQvIUsP7E6IyOAJfn39ijgFY9aGTztJHI1V9K4EA13liw4UeOwSkeeoU1evbFb9P27r7IM0JF1uKCNSMPUICb+NWpafuEl98RusLmzYfms+lQ2dJmFBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844210; c=relaxed/simple;
	bh=/SsqL1CZrTkdQdhZKShzHWVTuLOtxyBGNnVfDOI26Yo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jf/nE733+2b+vr0OWO7Q8LgURsUUVjZrOoZQI26iO6VstwjnKWuQNghTeEDFwfDfu3bJjXh4DHttqV4y7LXUvWdMB/2aB9Guz+1eLgEahCVe9rnyZqSCab43xGwJV6oc0SawXtM0Eb0dUy3/c6HmBUmzA0qvXEdr5aMx8Z5YlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXEBOiUN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632F41F00A3A;
	Wed, 27 May 2026 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779844209;
	bh=ZXWym+IdVzpgpthpsaxuqt8Zroaons6u2bbtXPkkOSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WXEBOiUNZN7R4pjHxMgeRAgkHL7lK9EMQ5m5vVgdMXLFxB2c1Wt9Us4eTAde2qzdC
	 XWKXWsERWOoISxh1oDVm1H6B+aM8ofjpSPTyFHZhWkmIgb+l691OEgZrgP2NuoUu26
	 s05PyPIo9BbhslGAKHxs/cpxPF6dl1EXIIqyXBajG6G5sGlNWPwj8IMhRnx0PJdek/
	 vCwmK7l65B8c3LYDWJ7/O3TdpahlYZ4JOALil87O2TB6HNRV/86CjY5uaaI8vyZHQz
	 q9S6HHOYbVi21WBR8UV8spujDUz31pAZmt5l2P8hCCwhLqmsEhRfpNlz1YMYsmDdQ8
	 RPuNjrrvDCWHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A8B380CEED;
	Wed, 27 May 2026 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: spectrum_fid: use a dedicated list head
 pointer for sorted insert
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984421489.4036929.13174546525262070161.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:10:14 +0000
References: <20260525071759.1517576-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260525071759.1517576-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: idosch@nvidia.com, petrm@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292033-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 23AD85DE2A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 15:17:59 +0800 you wrote:
> mlxsw_sp_fid_port_vid_list_add() inserts into a list sorted by
> local_port. It walks the list to find the first entry with a
> larger local_port, then inserts the new entry before it:
> 
>     list_add_tail(&port_vid->list, &tmp_port_vid->list);
> 
> If the loop falls through (the new local_port is the largest),
> tmp_port_vid runs off the end of the list. &tmp_port_vid->list
> then ends up at the list head itself (container_of() offsets
> cancel), and list_add_tail() inserts at the tail. So the code
> works today.
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: spectrum_fid: use a dedicated list head pointer for sorted insert
    https://git.kernel.org/netdev/net-next/c/6373d6fbc242

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



