Return-Path: <netdev+bounces-251726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNj2LSk+cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:47:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5877450005
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06954BC6855
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FFD356A01;
	Wed, 21 Jan 2026 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axGd7qRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCFF34FF55;
	Wed, 21 Jan 2026 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963245; cv=none; b=VzsGqJhICuuysXTQ69UF4kn7nlbkB4aoc7Er2u5E+5iHuAIsZ47rXuhKObVHktqnXkE1/NRFd/TMCDKfJ/Vm2xf9XWqCNtm/RhKhjFcc8AfkOk75hWwN9am+B8IfhMQ7V4BG6ENa2mkTvNtpNY5DlYP/b9p7CenZnUOMuVZkIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963245; c=relaxed/simple;
	bh=FPP02XjL6O2QS3tsv8C6iZjCRI86pryi6vZMY35icRg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fq5OeimZcGNNctOImU3WJmLDHgCRYqT+9Wb//yxGf5bxixNmAtN8djCw1M3Gm4gkRDsEQl+1tMo/Dk6euJjybXHfBqy6rxyJG1+FHv9L3lzDtjAzRE+eksd+5poghrTlorwkXthi7phCA1wbtw5kZ6dSsXtyfZC2d6b3OWKCVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axGd7qRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC88C16AAE;
	Wed, 21 Jan 2026 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963244;
	bh=FPP02XjL6O2QS3tsv8C6iZjCRI86pryi6vZMY35icRg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=axGd7qRMwKSe5XuKDnrJr2WZhay8OoEz39xhPBklOLhGUn9sluX+4Z7uF/NovEQnj
	 0e/refpeofQ9aoyCFEJ5vcqg59VwpdfGydLRUI8XgHRGOuR41z8FiOdEqjZwV4NdOX
	 a9IrCGzeiAMaDufhkiVft2gS9WLMDdubVwENTrxyotuVTX1tThbDwNMEYBSWt1T5gc
	 Weawh0dQpGamQ73yV6Gozb9xIKJzRtXaOFvwo339bG/Pf60QxulcHSWG6NI2xTZG6H
	 ervXQrqaiZE09xvqTNfLMT8OXGQpjkXRNQhAPr2CEHkoqgPO3/hgtSW3aUrQKJ0B/5
	 knv6FDFF1YwCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11BAF380820D;
	Wed, 21 Jan 2026 02:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: fix missing include in
 ncdevmem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896324160.699622.3349922970809925961.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:41 +0000
References: <20260120180319.1673271-1-kuba@kernel.org>
In-Reply-To: <20260120180319.1673271-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 sdf@fomichev.me, almasrymina@google.com, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251726-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5877450005
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 10:03:19 -0800 you wrote:
> Commit ca9d74eb5f6a ("uapi: add INT_MAX and INT_MIN constants")
> recently removed some includes of limits.h in uAPI headers.
> ncdevmem.c was depending on them:
> 
>   ncdevmem.c: In function ‘ethtool_add_flow’:
>   ncdevmem.c:369:60: error: ‘INT_MAX’ undeclared (first use in this function)
>   369 |         if (endptr == id_start || flow_id < 0 || flow_id > INT_MAX)
>       |                                                            ^~~~~~~
>   ncdevmem.c:77:1: note: ‘INT_MAX’ is defined in header ‘<limits.h>’; did you forget to ‘#include <limits.h>’?
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: fix missing include in ncdevmem
    https://git.kernel.org/netdev/net-next/c/1802e9079f65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



