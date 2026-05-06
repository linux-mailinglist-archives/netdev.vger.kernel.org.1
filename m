Return-Path: <netdev+bounces-284676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OcrDEmq+mmnRAMAu9opvQ
	(envelope-from <netdev+bounces-284676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:41:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E34D5BCB
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 566AF302614A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 02:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE302C375A;
	Wed,  6 May 2026 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN9ih2V1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5886F19DF6A;
	Wed,  6 May 2026 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778035270; cv=none; b=KoPqguy5ikA0AuMtibKQaZDgqZhw4ziKtOzPW2t00pCChM31xMB8JQTZQB84D94Yc/MojaCRA6W1NI0CyzFb+9IHweh5ZCh3Sk5CIfzq48HRv2ysF9BxCUGwoR9gBnK6QH20W7a19ks2Jw83CLiF9IXz9Nr5SoS90nj6Rb+FUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778035270; c=relaxed/simple;
	bh=IkxOXtRLYbotdLbeMtXS+vv1w5C3LFWIhoGMflXAMXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YXbH4PJy8IAQWTJ+Gv/l4ip7cql/osX6k2vYEbsx6B+110veDrR6WiTRjHFG9hevOqE6mdhB+Xocpr7SpCrj+0mqWP6B4mtEEtrn+L1nmPzEvnHl8+BrR0ApJOpcK6Q++X6/Cn24244OmlSXeanI3BnmKVvQNNu8+P/KV/53f48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN9ih2V1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F59C2BCB4;
	Wed,  6 May 2026 02:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778035270;
	bh=IkxOXtRLYbotdLbeMtXS+vv1w5C3LFWIhoGMflXAMXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tN9ih2V1KisYZw+RL+JTqGsvA3xx1v6HhRyx7tGxWqrdUgAtNw7yKBZapVohBLjWA
	 cxLlJanA8RGcdV4oqwKE4OCAbANg6wj7gMxOpCwFiHrIkbPESwGtfYiM2S7E2remsd
	 jtWiMbLT/ahXWXkxCeR1mSozr1IeyaU8hSXgFPqd9uPk32ZNy9u8SFrHeRavxswTA9
	 k+H9U9boIOMMefTjCFJ7G+hGVsEyFZ+OzO3QHv+FnHIpz8hhwjbcsrXE/dkcXzeXd1
	 /4WTTqUCics2YYK2yDB8ppkpDvt39yTjcb/5+3Qofq/+ngei7e5z8e4ax2OPJQI8qx
	 Xmbo2wecX/L6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEEC3930780;
	Wed,  6 May 2026 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/8] xsk: fix bugs around xsk skb allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177803522005.2360305.17775705141386636622.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 02:40:20 +0000
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kernelxing@tencent.com
X-Rspamd-Queue-Id: 951E34D5BCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284676-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 May 2026 23:07:14 +0300 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> There are rare issues around xsk_build_skb(). Some of them
> were founded by Sashiko[1][2].
> 
> [1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/
> [2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/
> 
> [...]

Here is the summary with links:
  - [net,v5,1/8] xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
    https://git.kernel.org/netdev/net/c/d73a9a63f9f7
  - [net,v5,2/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
    https://git.kernel.org/netdev/net/c/0bb7a9caf5c1
  - [net,v5,3/8] xsk: handle NULL dereference of the skb without frags issue
    https://git.kernel.org/netdev/net/c/8cd3c1c6e7d9
  - [net,v5,4/8] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
    https://git.kernel.org/netdev/net/c/0f3776583d28
  - [net,v5,5/8] xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
    https://git.kernel.org/netdev/net/c/3dec153ae484
  - [net,v5,6/8] xsk: avoid skb leak in XDP_TX_METADATA case
    https://git.kernel.org/netdev/net/c/8c2cff50afdd
  - [net,v5,7/8] xsk: fix xsk_addrs slab leak on multi-buffer error path
    https://git.kernel.org/netdev/net/c/e0f229025a8e
  - [net,v5,8/8] xsk: fix u64 descriptor address truncation on 32-bit architectures
    https://git.kernel.org/netdev/net/c/203cee647f55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



