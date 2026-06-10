Return-Path: <netdev+bounces-297410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x+NiN5/MKGrAJgMAu9opvQ
	(envelope-from <netdev+bounces-297410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:31:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B38665736
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:31:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mrrjybhu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297410-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297410-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41154308CA55
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58972278161;
	Wed, 10 Jun 2026 02:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A027FD4B;
	Wed, 10 Jun 2026 02:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058610; cv=none; b=Qw3trnhGmDaYZz6dZct/Ti0qyYKmBd+zT4H3R5jAkCBJymYwXtYDjjVcK5aPmhJxTVYGMQyPOXOifZJDLxSKjfT8AQGE2uPTNA2KR+nDhkSuweOHMD4xF2wEVTyb0jwH+T1kTqjCKsbVYQuE9Jt1TMxdVq8lyHgaQmrdKttVV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058610; c=relaxed/simple;
	bh=Cl0Yw24+JnYENiMvJKdJq3a73HcfLt5QPvi2HAeay/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BRLzr+wueu2n8Px8jTckUMEgRZ6MujX45yc8uAIvhd6F2coob/hGenvGkTEI2g9TpcXJghY1w8wsduuanUw/4RL/rFZ3svH2MfE/jvi2s7n5b3yvYk/LCfp7seD6l50ch1LExRT5pzL6+2G/hQU8AxgWBx0UjyAGOcXSaWH+1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mrrjybhu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74621F00893;
	Wed, 10 Jun 2026 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781058608;
	bh=AkjbPNJOOQcXYpV91PWjTYmuXBqesqJApQu5jGEYqLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MrrjybhuN7VNbc2JQwLNuny/9bcmcEA4pmP8qR2DGD0FM5j+ZB36ATHU/NojfOXhB
	 EzTdzD6BuG1YJgKA4g0fa55Lb2j++elzhPTfx44yANUxvmP9E8iggYO2hnILQOqmH3
	 0+1msz24DWTRSjsLUFQ2s0i9hQ5cjYsvBVVlGMx0tDeqftqc03xiXl11g75uXh7gw9
	 D9tHVq0QclpRhrFKZzuYmZ8gvd7YkrrqGF98cP2kbkPCe/aKCgpXlWoVrm2OAlmmZy
	 ToKN1adb9WxzcOvkL+hP6xc0jixiaDM9IuJwY2obObbLHFAAjxigU++zfpmwTrH6ff
	 M0gjy1LsAx57g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198443930A20;
	Wed, 10 Jun 2026 02:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd:
 microchip,pd692x0:
 add port disable GPIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105860664.2800834.1034333038308969425.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 02:30:06 +0000
References: <20260607165600.1260210-1-robert.marko@sartura.hr>
In-Reply-To: <20260607165600.1260210-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel.machon@microchip.com,
 luka.perkov@sartura.hr
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297410-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:robert.marko@sartura.hr,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel.machon@microchip.com,m:luka.perkov@sartura.hr,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75B38665736

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Jun 2026 18:55:35 +0200 you wrote:
> Microchip PSE controllers have a dedicated port disable input that like it
> name suggest, will disable PoE on all ports.
> 
> So, lets document that GPIO.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: pse-pd: microchip,pd692x0: add port disable GPIO
    https://git.kernel.org/netdev/net-next/c/a1c4fa71bbbd
  - [net-next,v3,2/2] net: pse-pd: pd692x0: support disabling disable ports GPIO
    https://git.kernel.org/netdev/net-next/c/90e63d535495

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



