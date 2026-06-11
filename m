Return-Path: <netdev+bounces-298402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lNWYLpJAK2qm5AMAu9opvQ
	(envelope-from <netdev+bounces-298402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:11:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51B675C67
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:11:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yx6XtJEB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298402-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298402-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3221532BF783
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FA38C40C;
	Thu, 11 Jun 2026 23:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E38382F26
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:10:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219421; cv=none; b=jA7CjX4uwdJYUSMJX1kWltOr5h1CFRSvoYpLQAwUc+w33O960NZtR4jPE237uPimqLplUvperd01duBCBLN7hGMt5BQOEwkZ7IRKT802kkiqZWp9TnQetlSUL3E007gvKxuLWqFWY0kTEYtzRoJNZlsTBeEC8MVhimCXkL29RjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219421; c=relaxed/simple;
	bh=i3Aq2PcwudkxP5r08quAA0h+qjzrsRSy/PdbSZaaPF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bAxkb8k5XxzKFXoqrNtCYgM1eqpxyVxB8/2pi2FmuJ2lmHrx/AjzHtNBoHvI9nluyveouD82/qTUohIS/xZHkUQ5p4sX/uEfdBK+feXCZQDt4iy+Z0g9OjNDnEAVXT8cwRP02XzY7XgUxvNF+cM9fFK1HNkUXIbZVpeQnZVC5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx6XtJEB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB461F000E9;
	Thu, 11 Jun 2026 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781219419;
	bh=lHWbvWBXo6R1Y5mCluv+7BrQuPrDe+GNhFCSz7RUlBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yx6XtJEB2cfqU8yXrv58PyS2qBlGNOiiLiXQ5bu7EFZqcVAhY94sadaBoG2iStm6I
	 SpntSxesJy9xNHt/0F+F2JZwJj/hQ3X1lNIqubk5VV5XulUykAkJaCtqSe5qVjVnTg
	 kNaeLsx1VhO6tw3o8vT5/ZQ08C6HSa6u8DpYusKo1yKRHacibXsbkYXyYY0r8wBe50
	 dLgW8K/+8WWkL8gYQZtra9KS9D29/j5F29rID07V5sYUOuQRnw0sSA2GjnABRR8Ahx
	 +YPy1B0lvTb7c3F/0/KFhQAFNev4yG9XtCnafFOyG1b7DaIpC1zmZ3JvKflYW4TIiq
	 YpLEBxPh1BXqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D03930FB3;
	Thu, 11 Jun 2026 23:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: simplify WAN device check in
 airoha_dev_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121941663.401113.5124460643582532071.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:10:16 +0000
References: 
 <20260610-airoha-eth-simplify-dev-init-v2-1-8f244e69b0d4@kernel.org>
In-Reply-To: 
 <20260610-airoha-eth-simplify-dev-init-v2-1-8f244e69b0d4@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298402-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E51B675C67

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 15:25:13 +0200 you wrote:
> airoha_register_gdm_devices() iterates eth->ports[] in order, so GDM2's
> netdev is always registered before GDM3/GDM4. This means the explicit
> check for eth->ports[1] && eth->ports[1]->devs[0] is a redundant
> special-case of what airoha_get_wan_gdm_dev() already covers, since
> GDM2 is always marked as WAN during its own ndo_init.
> Remove the redundant check and rely solely on airoha_get_wan_gdm_dev()
> which handles both the GDM2-present and GDM2-absent cases.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: simplify WAN device check in airoha_dev_init()
    https://git.kernel.org/netdev/net-next/c/9912dfa2d46a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



