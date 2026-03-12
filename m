Return-Path: <netdev+bounces-266821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGFrFpcSsml0IQAAu9opvQ
	(envelope-from <netdev+bounces-266821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:10:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51A26BDB4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB27C30F67B6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CAD347BDB;
	Thu, 12 Mar 2026 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aasaijiz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D9347510;
	Thu, 12 Mar 2026 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277818; cv=none; b=qTZkwoUNlPVLSEneAjp4a1/hjQPfec+e9SJBr9cwYSNVbrIQx4QMcwIrI29DZtJ+Bv6Ols8YKNnmkqaWt6q8F1Q/wdGMXeggBfUyulrXTqHQoOulfIsiPWzEuTxWReRLtMQaIpxB+s56di1Wif67gCTess+64SnK5890aaaCAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277818; c=relaxed/simple;
	bh=TKeJT/xjc5Pdb24yNwte/PfYRiwvbPDzgq9rKudiD1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ghVxPdzkJsbC3DN8WePAiMffXxIMzNiCYaAbCA0wE49nGs8p5OdQHlRFmwxLl/ZHJWpeZXj+WhikR3gDm3fBoXJilLUgwr6oeCM9zWK0Kfb3mLakizRljPKNCgMrgv8Dc5EflfedAepnrOhfJV3b4e7W5SBSHV3hddwVg66wtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aasaijiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B69BC19421;
	Thu, 12 Mar 2026 01:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773277818;
	bh=TKeJT/xjc5Pdb24yNwte/PfYRiwvbPDzgq9rKudiD1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aasaijizLxUCax4qDJUxQG9vhHuby2UQJLj42UMGam6gHMDGV015yhzw32NPrGxZQ
	 Mirsyq3wIM7PXGJQ8DoT82JDKtjMke4QjHWgWUyhyRfPCAdrTIbKyjyJoFp/oRxDga
	 5jGAKlrKsECnK5Em1rYUabVs+9BZtkT+6gpTwqigQRT4c5pJSLRjTJF+M6GKHXmrJb
	 vxfL/B4/UNMTDc5rDBmdoOyKe1OvHGNKyPXuIBGfNr1lVXNc1VxMn0DtqNM5jI1T7S
	 vtOy3wBjNNs8Pioh8Pk3GG+IuGHVjlL3zIhzLVjsV4D/7FHYROGATyOpGiKUgRJvDP
	 B5pH7WjFVePyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE523808200;
	Thu, 12 Mar 2026 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/4] {net,bpf}: nd_tbl fixes for when
 ipv6.disable=1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177327781404.3893274.18137587721158211759.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 01:10:14 +0000
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4=?=@codeaurora.org
Cc: martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 toke@redhat.com, dsahern@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 liuhangbin@gmail.com, fmancera@suse.de, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,suse.de,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:-];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266821-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	NEURAL_HAM(-0.00)[-0.960];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD51A26BDB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 07 Mar 2026 17:50:52 -0300 you wrote:
> Hi,
> 
> Please consider merging these four patches to fix three crashes that were
> found after this report:
> 
> https://lore.kernel.org/all/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com
> 
> [...]

Here is the summary with links:
  - [net,v4,1/4] ipv6: move the disable_ipv6_mod knob to core code
    https://git.kernel.org/netdev/net/c/94a4b1f95998
  - [net,v4,2/4] net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled
    https://git.kernel.org/netdev/net/c/30021e969d48
  - [net,v4,3/4] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
    https://git.kernel.org/netdev/net/c/dcb4e2231469
  - [net,v4,4/4] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled
    https://git.kernel.org/netdev/net/c/d56b5d163458

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



