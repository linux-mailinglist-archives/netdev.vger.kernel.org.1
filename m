Return-Path: <netdev+bounces-301844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QilkCimVPGpwpggAu9opvQ
	(envelope-from <netdev+bounces-301844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:40:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CF6C26C7
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:40:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Fhh56fqT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301844-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301844-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 791143009804
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C63C39DBC9;
	Thu, 25 Jun 2026 02:40:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC96379EE7;
	Thu, 25 Jun 2026 02:40:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355233; cv=none; b=OZR1UFg89Ap2ZElCqW7w5+o2HK5kvdQgUnAJJgDOj7ChKO3QLVxmonwirCrfA1TyZnrSIgoYFom0pRVGmsriDT2GuAIj5jmYIJyygkW3/qgeXIyPHkBljXmqadNMcGbagw0hx6dt2gXKZlCnkf2tS28z4Ol2CswCKwQuHsWYhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355233; c=relaxed/simple;
	bh=uAQZzIfbwtFY5HNVfNjZueCqi/eEGnEJlGFf1d1vPhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=naEl6xxQPcwAl0u6CoCp+Z0/NX1D1Vk650WLVXQcj1ruBqBZF6BkdM+w0bBTKG2ltqKRcDiedl4OkBu2V3TcrUWE9/tFcw2FHXlamKuuD0NhVkEQVn5pS1v+7EhFYYS3/sHOL1M0+tDtDC2zG/Q2jQvygH2i2nB/BhZcr7DP0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhh56fqT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D851F000E9;
	Thu, 25 Jun 2026 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782355232;
	bh=xyAPI4p0/MTTG/aGrzMpxqG01cR4hkSNRrdo/rcgw0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Fhh56fqTKqidCRn6VypRYY7ASeRw1bn00oziepAsDsPYjoP1U1bUNogCxceT93+Gu
	 fSdPPT3ugovEM+OTuvIgwJU3P85hezj9YkYNjXN0P7uS7trovOdu4slUeKtA08rnfZ
	 nyKLSG1WBj44AvLvoS0sJHufJ5fsk00ogufZt6s9UHC9iKnEbPAyGX9HJUtXe7cLJm
	 bhiDfZsDUPf/20TFF0qGr7YXD8A66XTlNc3lutQa1dBNPD1nFWgrkwtF4e5Q2QCWtR
	 o5lxhdItAw2W0IU1UnLP+q/xZlbSo3QP+cvo4x1vEtUnvn3AplwHTR6s7+Uyje0SUi
	 h2N2bwEAf67xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09993AAA6DE;
	Thu, 25 Jun 2026 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: ethernet: sunplus: spl2sw: fix of_node
 refcount leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235522029.3091545.3009752981446571608.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:40:20 +0000
References: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
In-Reply-To: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: wellslutw@gmail.com, kuba@kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shitalkumar.gandhi@cambiumnetworks.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,cambiumnetworks.com];
	TAGGED_FROM(0.00)[bounces-301844-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:shital.gandhi45@gmail.com,m:wellslutw@gmail.com,m:kuba@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,m:shitalgandhi45@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B3CF6C26C7

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 12:11:41 +0530 you wrote:
> This series fixes of_node refcount leaks in the Sunplus SP7021 ethernet
> driver, found by inspection. Compile-tested only; no SP7021 hardware
> available here.
> 
> Patch 1/2 fixes the phy_node leak in the remove path.
> Patch 2/2 fixes multiple leaks in the probe path and depends on the
> cleanup contract from patch 1/2.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
    https://git.kernel.org/netdev/net/c/a9e29dcd8a84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



