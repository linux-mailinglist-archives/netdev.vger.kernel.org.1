Return-Path: <netdev+bounces-296020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c1bML+F8I2oGugEAu9opvQ
	(envelope-from <netdev+bounces-296020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:50:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 743FA64C234
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:50:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A95t89yX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296020-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296020-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E21943030350
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B324677B;
	Sat,  6 Jun 2026 01:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E0175A9F
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 01:50:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780710623; cv=none; b=JSKre1yEYytu0jfrC4I4zozNzjHXLhYEtRJAOoccSLtMOuDD1rq7kG1wfNpieD3oRQoGDnBqCQqN3zeTnxAbJGXArIQ5NXHSPDcpfvdrWeeQ4AQ9WDBuSTSdUARVPz7g0cjkcKT6NMA3uz/9v7SoUNsLt0L4rvEwmPMJvRfR3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780710623; c=relaxed/simple;
	bh=9A//HkLxns69/2gKLXZ9LH8noEMQ5mwmhMtBaVTwDvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=scsq6ObYeepg2WSDCg3PkpG1fFP+KPFXLbj4kRPwlSxHor+QMIKUXqFUDKE75OZFCmJla+7k/sTFIG6uapSBhsNdVzRMT18+eL7FdJyYqY8LGgwdWUxEl8h+33js+4GgDbHbUsFABQNfLK1dkqTlIw3F+peDm/G5NLgNVdwf5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A95t89yX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BDD1F00893;
	Sat,  6 Jun 2026 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780710622;
	bh=5LW6S2oBmnPZd9KzEU51RzmswJSF4t6mCUZGNBLu2C8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A95t89yXuDbE6NzKHFPTm19OUDM1zm2CNxLsGQe7PCqfEuftLtMtGaXJY3ra7ndac
	 F5P0AE6iB8DBHUcspikE1dd8qOYlNGGBb2Ko4k6C4jJZIlPQnScdclARKZ3P8GGBWD
	 kyqbpLNV52b2kWFxurJ+3itZPmnAGA6mNxpLl6w3R5U6tHwgxF5BtW3OeigkWbtvsB
	 nEhu0QwXPxNfPR6BZ0UejLtR7vHAH8XYZQrj5LvwiXr5tbBqKCQqHxzcWAOpEj1NT3
	 nwJpUK9kbWlMGTIHx6t/8RAUbNzHvo6E0Uag8URHoinTNOsANT3NeV1BFLIJLmXRpa
	 iDoO8grISjgGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A293930A9C;
	Sat,  6 Jun 2026 01:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: mdio: realtek-rtl9300: Refactor
 initialization and port lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071062213.3989414.7977440712530638857.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:50:22 +0000
References: <20260603175924.123019-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260603175924.123019-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, mensi@mensi.ch
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	TAGGED_FROM(0.00)[bounces-296020-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 743FA64C234

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 19:59:17 +0200 you wrote:
> The Realtek Otto switch platform consists of four different series
> 
> - RTL838x aka maple   : 28 port 1G Switches
> - RTL839x aka cypress : 52 port 1G Switches
> - RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
> - RTL931x aka mango   : 56 port 1G/2.5G/10G Switches
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] net: mdio: realtek-rtl9300: Refactor otto_emdio_map_ports()
    https://git.kernel.org/netdev/net-next/c/f369dd8ccf2d
  - [net-next,v2,2/7] net: mdio: realtek-rtl9300: harden otto_emdio_map_ports()
    https://git.kernel.org/netdev/net-next/c/829ee0f8bc39
  - [net-next,v2,3/7] net: mdio: realtek-rtl9300: harden otto_emdio_probe_one()
    https://git.kernel.org/netdev/net-next/c/67885c0e3919
  - [net-next,v2,4/7] net: mdio: realtek-rtl9300: relocate topology setup
    https://git.kernel.org/netdev/net-next/c/94f05740ad16
  - [net-next,v2,5/7] net: mdio: realtek-rtl9300: relocate c22/c45 device tree readout
    https://git.kernel.org/netdev/net-next/c/439aba443a80
  - [net-next,v2,6/7] net: mdio: realtek-rtl9300: reorder controller setup
    https://git.kernel.org/netdev/net-next/c/56b486415097
  - [net-next,v2,7/7] net: mdio: realtek-rtl9300: Correctly handle ethernet-phy-package
    https://git.kernel.org/netdev/net-next/c/50b682a5aed7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



