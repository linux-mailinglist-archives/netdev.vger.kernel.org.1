Return-Path: <netdev+bounces-298805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YNrsNR+MLGq2SQQAu9opvQ
	(envelope-from <netdev+bounces-298805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:45:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3EB67CDD6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:45:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="NDD/DmxW";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298805-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298805-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E0233E8C36
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F10440312F;
	Fri, 12 Jun 2026 22:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5A3D9DD3;
	Fri, 12 Jun 2026 22:40:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304016; cv=none; b=fn1XoKTezb/yMYwjHPCmteh/j/9Vb9iePs2bd7G/pjkC0ql3UIXsOAxVz1dnIG4ggtikaD32QQNx811jpdA/P/KVhqqewLlEoFuXHC/wQgLOWU3e5T/nr1DyH3jGiL4Tpd/hBHdxguy083FCsKVLvs8KVr1c/lOkWgFpCzadU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304016; c=relaxed/simple;
	bh=O34CWYNB4JNCHuFinuFFQmZbHDr3G62djOQlHcUnWlk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BJZNvpn/kvlXxW+T8FMXuEhjCPvwno/E3+it4T9YDGLt51D3SKpRltxwZn+4yxKzX4FAaF5BqTe15v8PnZaZTtDy0mOocsmkMmGDkylwmg3B4zlDMEKfMALxcRk8iY5Qg5/BqKX8YFT31FKmh57/ZEJWclGh3HS0AJtq9vnlkdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDD/DmxW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FE71F00A3A;
	Fri, 12 Jun 2026 22:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304014;
	bh=u30FmF1ZvAzhrJKphZvci1P+EsZosvD8EEfcSGzZ/is=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NDD/DmxWjHhSgBtz9jrtuCa+eJZelGvRY8O9im70Pu2qDbwJPiDCm+hcTACuIX/Qa
	 a+ikRUGzGx/nKBMcRcnQe9yZ8yjeLEcE7wfUa0XF67eBVW54hmJBsHlV123Sa7uV8+
	 jvMTTo1t5G+aRKonmofEDkSR1LiqoSxs9xw3OQS77DXshJ9EFAm/T4H4yrFjka09eI
	 H1b10IPZBRdMMBRZgc61neVM+qfF/n3qMkbp3u4BfnFCp+WshgTdWK1VGheNxMZS5h
	 P5o32d46biisyVyvZg1ONgnY0dtGY8uom3sdhB6a7QEa1iAuz/fa2p7t1MjAlEorIu
	 V3Ve8H501S1yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5687E39E4DB9;
	Fri, 12 Jun 2026 22:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: simplify UMEM setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130401114.1275309.12520760927935385997.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 22:40:11 +0000
References: <20260608130938.958793-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260608130938.958793-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298805-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A3EB67CDD6

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 18:39:33 +0530 you wrote:
> This series simplifies UMEM handling in selftests/xsk.
> 
> It centralizes UMEM property setup through helpers, moves UMEM ownership
> from ifobject to socket-owned state, and normalizes umem_size/mmap_size
> usage across the touched paths.
> 
> v1 -> v2:
> - Applied helper usage consistently across the touched test paths.
> - Moved UMEM ownership to socket-owned state and switched to one
>   heap-backed umem_real object at xsk_arr[0] with explicit reset/cleanup.
> - Kept shared-UMEM TX behavior unchanged via TX-local UMEM state
>   copy/reset during TX configuration.
> - Folded pkt_generate() umem parameter removal into the ownership
>   refactor patch (no standalone cleanup patch). [Maciej]
> - Updated mmap_size teardown handling to join the RX worker thread in
>   single-thread mode before cleanup to synchronize UMEM mapping state.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] selftests/xsk: Introduce helpers for setting UMEM properties
    https://git.kernel.org/netdev/net-next/c/19ff5c545750
  - [net-next,v3,2/4] selftests/xsk: Move UMEM state from ifobject to xsk_socket_info
    https://git.kernel.org/netdev/net-next/c/b17631032769
  - [net-next,v3,3/4] selftests/xsk: Use umem_size() helper consistently
    https://git.kernel.org/netdev/net-next/c/1a24fe421739
  - [net-next,v3,4/4] selftests/xsk: Introduce mmap_size in umem struct
    https://git.kernel.org/netdev/net-next/c/0fe61052acb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



