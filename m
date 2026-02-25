Return-Path: <netdev+bounces-260696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHFtA05OnmlIUgQAu9opvQ
	(envelope-from <netdev+bounces-260696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:20:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 953AF18E96E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD76E304C059
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40D24E4C6;
	Wed, 25 Feb 2026 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YupJoEpV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA051D5ABA;
	Wed, 25 Feb 2026 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982402; cv=none; b=KwLQ5YTdEb+3Y3YdqTRm45h8w8trog9QYlCFUQsrEKZ4QK/ack2fvre6hcz/wmWNx5FgvxoGjIbPSvOR9nrcyZZEAE7SDriRcj9i5bAM88Yrxp8Ey4VVpmplE6kmfh0Q2Wje3Km6uUpQ0FiL5qh7j5egmTm5EN8nKqDWLKMgBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982402; c=relaxed/simple;
	bh=gG9t7sMKz1Xx1xxYB/va7YeUm993mzNBpwwUvSFMlec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g4Fnhc8KGZ0vcVNoC69PiqtdO3xVgG3e0N46rRu4dwZvb0lIuP2ChVLibXlzrxLAsiMUfzFlKHbU3RPgv/1vSecygVUEdEydnJQozU8/052B0VkxiXsUxoD1befVlrd7Xs6hCgAX02dnqWn5vndcG1tsPgQg67hGLxcKNIkx83M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YupJoEpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44488C116D0;
	Wed, 25 Feb 2026 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771982402;
	bh=gG9t7sMKz1Xx1xxYB/va7YeUm993mzNBpwwUvSFMlec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YupJoEpVN9aTm2Et3Z5D78YQ1u9IyZNDlzFJurR1SOEKzBGcHPd+qo1CvmdjM40EZ
	 jVhSaO4zPYPRGQ9S+tRpvDuvFopUcpgGWYKR+j2HdFDn96XRNj0C36LTCXhXzfskOE
	 eImbnUUkkdaIb5mSNxz92FOwn0Bm+EIdMkFq2XZVwm/OHuqODciJcmGQcG2xTGmscx
	 GS5QISwovFCUdbCf8XsOz/+0qBc325MonPBjTrlrsPcM4QLAahtUVx/nIO4r2N8VqU
	 IzINwGoG9aR4Lo3b8CYr7S5aXI2diElNEBXjsyHFoh7ifgNUlV7fygsVIbORkA3kbR
	 qT6S93B1TLsNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1033808203;
	Wed, 25 Feb 2026 01:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: avoid double checking against rx queue
 being
 full
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198240755.23068.1508558961337534625.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 01:20:07 +0000
References: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260696-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 953AF18E96E
X-Rspamd-Action: no action

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Feb 2026 16:00:00 +0100 you wrote:
> Currently non-zc xsk rx path for multi-buffer case checks twice if xsk
> rx queue has enough space for producing descriptors:
> 1.
> 	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> 		xs->rx_queue_full++;
> 		return -ENOBUFS;
> 	}
> 2.
> 	__xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0);
> 	-> err = xskq_prod_reserve_desc(xs->rx, addr, len, flags);
> 	  -> if (xskq_prod_is_full(q))
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: avoid double checking against rx queue being full
    https://git.kernel.org/bpf/bpf-next/c/f620af11c27b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



