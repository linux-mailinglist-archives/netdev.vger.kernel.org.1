Return-Path: <netdev+bounces-273019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sINOHhiYyWn8zgUAu9opvQ
	(envelope-from <netdev+bounces-273019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0401354223
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33627300BD91
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A24E2E0413;
	Sun, 29 Mar 2026 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjWe39Lu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF3238159;
	Sun, 29 Mar 2026 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774819228; cv=none; b=Cxitx5tJXCje0CwFk5aGk1sIWMsXscxIyNWb0czTRkNLngd2AF0ZdUF9bd2xNJ5jqDKbCOSX0iHp6bw4meLE9wwHCTCjnFnqzGeCmXEFPxwqjPybGkIcXe7kpVPB3HDjwKl+1ZYn8oWCdrwNGzn/Y6qQTqETWvQrXUevc4zAz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774819228; c=relaxed/simple;
	bh=n6fENrOsfUQGSxoAz2iQL/xfQPCbNOjVsTxATEdu3Z8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rwjL+blBPrLJZ3Ko3uMvonv+BFWk5ru9fdhuAodRMJNrmT+eZ8WtJHrfuoBJsjLJ+YB9LsWfGuT/SrPYagEwvhCxs+B5R4RKIFg07WWtvQBeKREksya0lPJuLo+YXpf72RuqH0GaS7GOMzU/8rDS2WTU8xOxdUdaiRl3EPhU7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjWe39Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34079C116C6;
	Sun, 29 Mar 2026 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774819228;
	bh=n6fENrOsfUQGSxoAz2iQL/xfQPCbNOjVsTxATEdu3Z8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UjWe39LuQbr7D14zmz/hjLarrWuipJM9gIu1FqFpFcE02g7VINVtrm1ygdVlR7oBQ
	 rgjZquPpPBevsx8RsvE2q2qpdhZQEsBqjqDDamImY8KSwCIytylZHxNQuDol//d6MZ
	 yuZRVnzpU7paOB+ongoSg+1XFRoZp6OBt9lrZUrO9Wn/QC/CDr/FhEU9xdRn7SF7i3
	 UUYN8O/Anm6bOpGEjl4IT+JYvDilb8/LzKJm0nTQaRbElrMg7Bwid1Ad98PAi9OXcf
	 P9oJs2rlK2JjPGvJ3zYu5/h9fhYxxCrCqansxd2Fb4BDC3X7LeQoj+yNJ//IBXlfPz
	 fZq17VNX3+3Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C983930012;
	Sun, 29 Mar 2026 21:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/6] bnxt_en: Add XDP RSS hash metadata
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177481921279.467966.1212370025662172663.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 21:20:12 +0000
References: <20260325201139.2501937-1-carges@cloudflare.com>
In-Reply-To: <20260325201139.2501937-1-carges@cloudflare.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, davem@davemloft.net, joe@dama.to,
 gospo@broadcom.com, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273019-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,davemloft.net,dama.to,kernel.org,redhat.com,google.com,lunn.ch,iogearbox.net,gmail.com,fomichev.me,cloudflare.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0401354223
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 15:09:46 -0500 you wrote:
> This series adds XDP RSS hash metadata extraction support for the bnxt_en
> driver and includes selftests to validate the functionality. I was able
> to test this on a BCM57414 NIC.
> 
> Patches 1-4 implement the driver support:
>   - Patch 1 adds bnxt_xdp_buff to wrap xdp_buff with
>     pointers to the hardware RX completion descriptors and the
>     completion type. This is similar to other driver implementations.
>   - Patch 2 adds xmo_rx_hash callback for CMP_TYPE_RX_L2_CMP completions.
>   - Patch 3 moves bnxt_rss_ext_op to bnxt.h
>   - Patch 4 adds handling for CMP_TYPE_RX_L2_V3_CMP completions
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] bnxt_en: use bnxt_xdp_buff for xdp context
    https://git.kernel.org/netdev/net-next/c/542d3ec4508f
  - [net-next,v5,2/6] bnxt_en: Implement XDP RSS hash metadata extraction
    https://git.kernel.org/netdev/net-next/c/e5648b08cbfc
  - [net-next,v5,3/6] bnxt_en: Move bnxt_rss_ext_op into header
    https://git.kernel.org/netdev/net-next/c/4a037aeb6bc8
  - [net-next,v5,4/6] bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
    https://git.kernel.org/netdev/net-next/c/5ec22d5f2afc
  - [net-next,v5,5/6] selftests: net: move common xdp.py functions into lib
    https://git.kernel.org/netdev/net-next/c/4ce06406958b
  - [net-next,v5,6/6] selftests: drv-net: xdp: Add rss_hash metadata tests
    https://git.kernel.org/netdev/net-next/c/e3cdf6cf5fc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



