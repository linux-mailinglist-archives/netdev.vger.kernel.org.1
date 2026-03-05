Return-Path: <netdev+bounces-264477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +INRMherqWlSBwEAu9opvQ
	(envelope-from <netdev+bounces-264477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:11:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB952152E6
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0253026C37
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4503C6A57;
	Thu,  5 Mar 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJfHnw1P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAEF282F27;
	Thu,  5 Mar 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727028; cv=none; b=WHUAnXmfRDUx78N4Pc5OmK0TsU4Z9FaeNstckGC2GlHx//6GRbHJ0vR11DHTA1mW+vunRYzvf0xAkuqRJRcf2+KWBREU+6uxNDJdS7L56qyDqLYez3H6j7AKBhYdSHSgVU8z+0wb3ld/ZN3cvDtz65mOkQXBCLGtJ1USbfwPcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727028; c=relaxed/simple;
	bh=XkVTGgjybgKXZp1qt304mUns/GTshs03+4QI6M7emKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PkJNO9sqZA4bd8l48rMVTVhoQVexvWrekmCLarlQ+1jUnHjDHb5oqvH06iPQq3svBLvw/JHw1O0BjRO6YfeYkn2Legi61HHS34Jhi7BtN9JXyh0TZUcn+v4bzy16AoaMKQViY/rrJX0aPKW+ATrP50Ew6kqGsPlBto6fpawZz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJfHnw1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B15C116C6;
	Thu,  5 Mar 2026 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772727028;
	bh=XkVTGgjybgKXZp1qt304mUns/GTshs03+4QI6M7emKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pJfHnw1PbGoVjYrwIafL+sqM5ACrKoPeYeM+WMHXQSNVzQkeLJdwDbcj1a5uBNNdJ
	 BuvVGHLKoKDiG8WQVhoBATOs+JGvFpBk/FKjbhK6SEiykJYMR1bOlci0Iva/GwZj5E
	 rHIWv4INmohx5G6E6T5ZRgKasDjDm+oyIbs00bFGtY0bg3IMG+3iQUGH12oQG3Fi0o
	 Q+Ec5yC4V+59xLXVyIdoLCNtst33sLrQEdy2k+LR9+x3tld3vYSUsCkPmdroW1eQTp
	 BI9/O0QCIXBz6comfzwNag2tq7+1nv+JuI9kyTWxsW+s/qS20r1YYF81VOoMGoe8Fo
	 6wy8AMu24AZsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE653808200;
	Thu,  5 Mar 2026 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 1/9] xdp: use modulo operation to calculate XDP
 frag
 tailroom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177272702805.3188128.16309701518912320444.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 16:10:28 +0000
References: <20260305111253.2317394-2-larysa.zaremba@intel.com>
In-Reply-To: <20260305111253.2317394-2-larysa.zaremba@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, horms@kernel.org, shuah@kernel.org,
 aleksander.lobakin@intel.com, maciej.fijalkowski@intel.com,
 bastien.curutchet@bootlin.com, tushar.vyavahare@intel.com,
 kernelxing@tencent.com, rbm@suse.com, echaudro@redhat.com,
 lorenzo@kernel.org, toke@redhat.com, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org, aleksandr.loktionov@intel.com,
 dtatulea@nvidia.com, magnus.karlsson@intel.com
X-Rspamd-Queue-Id: 6AB952152E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264477-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org,nvidia.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 12:12:42 +0100 you wrote:
> The current formula for calculating XDP tailroom in mbuf packets works only
> if each frag has its own page (if rxq->frag_size is PAGE_SIZE), this
> defeats the purpose of the parameter overall and without any indication
> leads to negative calculated tailroom on at least half of frags, if shared
> pages are used.
> 
> There are not many drivers that set rxq->frag_size. Among them:
> * i40e and enetc always split page uniformly between frags, use shared
>   pages
> * ice uses page_pool frags via libeth, those are power-of-2 and uniformly
>   distributed across page
> * idpf has variable frag_size with XDP on, so current API is not applicable
> * mlx5, mtk and mvneta use PAGE_SIZE or 0 as frag_size for page_pool
> 
> [...]

Here is the summary with links:
  - [net,v5,1/9] xdp: use modulo operation to calculate XDP frag tailroom
    https://git.kernel.org/netdev/net/c/88b6b7f7b216
  - [net,v5,2/9] xsk: introduce helper to determine rxq->frag_size
    https://git.kernel.org/netdev/net/c/16394d805399
  - [net,v5,3/9] ice: fix rxq info registering in mbuf packets
    https://git.kernel.org/netdev/net/c/02852b47c706
  - [net,v5,4/9] ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz
    https://git.kernel.org/netdev/net/c/e142dc4ef0f4
  - [net,v5,5/9] i40e: fix registering XDP RxQ info
    https://git.kernel.org/netdev/net/c/8f497dc8a614
  - [net,v5,6/9] i40e: use xdp.frame_sz as XDP RxQ info frag_size
    https://git.kernel.org/netdev/net/c/c69d22c6c46a
  - [net,v5,7/9] libeth, idpf: use truesize as XDP RxQ info frag_size
    https://git.kernel.org/netdev/net/c/75d9228982f2
  - [net,v5,8/9] net: enetc: use truesize as XDP RxQ info frag_size
    https://git.kernel.org/netdev/net/c/f8e18abf183d
  - [net,v5,9/9] xdp: produce a warning when calculated tailroom is negative
    https://git.kernel.org/netdev/net/c/8821e857759b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



