Return-Path: <netdev+bounces-295310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b+oYFDOgIWrcKAEAu9opvQ
	(envelope-from <netdev+bounces-295310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:56:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E02641A15
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:56:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=oFYbqu9O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295310-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295310-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0536F30166E7
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FBA37703A;
	Thu,  4 Jun 2026 15:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5299357D1F;
	Thu,  4 Jun 2026 15:40:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587617; cv=none; b=JG7hZMGXpIIDNCGRymE+CKYnoefm5ti8PUeE6XhEIFqYbKUlePx2HfbNWEFOSRJBOAcya70KCynwORXEarVsx61HwGgT8UVUMN7ae6FcakfvdY7K3MRNldE9iMU+dx65B3z+KAuxwXd923jvRRsixKfYdgAzM+alIo+UlolrWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587617; c=relaxed/simple;
	bh=Y29J3CM/NgyBWRmdT8fSZrixgqR+RCJlBJylUuZGTFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y1wLPS0RGB9D3DK5r4a2gaVOBmHlkTKBChCoZk9U++th/jfxX6V61o5VyQERwyUCzWdPM4VUrhXAIfD8pvNKEnyivUco/j0rwfQ1QFfc5BfnZ0GNt/leitR3D7UliQjsZ8d/nPSkO4Xw4Gw8/AstAAqr730aPoAUimhtujgmBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFYbqu9O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CA51F00899;
	Thu,  4 Jun 2026 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587613;
	bh=twkHNmCdBtYwS5KleaIPnD1i9GOetO9OyZBu3THSxsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oFYbqu9OQ0gdpJ4lCwqGabN9eh/iP/p5mb6/lfmfmOlshPUEgsZaCsBe79Hv6aZk5
	 jk/hJwA7l+u2giJsSfz+vLRcf6wWxwlnbe1+APHpD/3jU7LTO4+5jUDMSIQ6Ql6KTs
	 VVb6W4BsFB0VpO7B9nntPbloSCH6V5QR41ybDO4qTY6M0mpNCQymjtYYJ3Eu5R65Hh
	 BTRiN3xDobJwPglI468gaFAiOQFryXhskjl2qDcjvlvazVUORxmBFi7QT4EYFK0nid
	 EV0cYG1K2AIUv7yQiZRHdmYlUy5PFlzzYiEYs7JnN22STgGIBaxgo4XLb0xuoeGZfG
	 ztmnCgh+baV3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BB039309B7;
	Thu,  4 Jun 2026 15:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] dt-bindings: ethernet: eswin: fix hsp-sp-csr
 backward
 compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058761414.2484354.2447643113431387684.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:40:14 +0000
References: <20260602014528.2076-1-lizhi2@eswincomputing.com>
In-Reply-To: <20260602014528.2076-1-lizhi2@eswincomputing.com>
To: =?utf-8?b?5p2O5b+XIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPg==?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
 sashiko-bot@kernel.org, krzysztof.kozlowski@oss.qualcomm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:=?utf-8?b?5p2O5b+XIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPg==?=@codeaurora.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:sashiko-bot@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:=?utf-8?b?5p2O5b@codeaurora.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295310-lists,netdev=lfdr.de,netdevbpf];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,XIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPg==?=,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,eswincomputing.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97E02641A15

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 09:45:28 +0800 you wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Commit c36069c6f46c ("dt-bindings: ethernet: eswin: add optional TXD and
> RXD delay register offsets") added two optional cells to eswin,hsp-sp-csr
> but omitted minItems: 4.
> 
> As a result, dt-schema implicitly required all 6 cells, which broke
> backward compatibility with existing 4-cell device trees.
> 
> [...]

Here is the summary with links:
  - [net,v3] dt-bindings: ethernet: eswin: fix hsp-sp-csr backward compatibility
    https://git.kernel.org/netdev/net/c/1232b3104b4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



