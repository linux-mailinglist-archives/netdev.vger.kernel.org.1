Return-Path: <netdev+bounces-305419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fwrbGpDkTGqZrgEAu9opvQ
	(envelope-from <netdev+bounces-305419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:35:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A82471AFD4
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:35:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jbxpbKjw;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305419-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305419-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD20430825C8
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB1B3F8239;
	Tue,  7 Jul 2026 11:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454053F58E6;
	Tue,  7 Jul 2026 11:20:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423227; cv=none; b=nBgC0Suw75kgJsu0N1sjiE4cwojsQBx9KwK1XCek+7JKaeSMav85xWFaJzn5A4OceTuis/GTg5oV8q//X9HI74/a8C3PkS4ANlAQBqgKCYmlgsf4Q/i9+6jbcTvzRcFqS+WI4A6CVnXAb6gEVs0Dkw9DJhPxfOAUfwDaaCZoEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423227; c=relaxed/simple;
	bh=xcb/lYqIKXK1vUGxwYDaeE3NG/6v6Sfe2CEeH3RLIuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PlD574hZqdurK8j08rz/dqBDZRsNl3EgWQoQDSWSZabBZ8cDkHarNWoNHmK94o9nuf4BSlfTtspUaQJrBcNlOIkss8MeoiCWcpHg+Adsz83QmtmFbSfWziA8uXenX5lc/YpD7uza0OwbQyhRtwQOgcMh/1vaqm8WsH3kYMlMYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbxpbKjw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3631F000E9;
	Tue,  7 Jul 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783423226;
	bh=HC1CiGl3Dfh6Ra3ZH1WZbs+vEPwTQRbaXlOvtAdG00E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jbxpbKjwm/4fYDVHIMVXGz86C+O6obKIKX17WRhr8yli0nqgSaZWqWQd/9mmadAmP
	 CiW2W8l392A215x9Cm7fsZBCTr15Qgm8MhWUxhOR3SUCyuxuacYBfQ9bp/6MljLHWa
	 EIBQI/sGCXf2lgYUs30T9gXkmZeXc3yYEiVGZKfyKcjpQTbgTdnvqj8Nhb3fqk1j7y
	 e3Zon3s8QHfgmYLlaPRTC+5b3WT/rIFN05i4b1PnN8YHxtoZVurckgn8vKU8fljqwJ
	 MOEPWFlM6Z7jU6sjJoH+mAyrtfUt3M4ZU7nONQHWlPRfHotgV4nvEDHwyP5BkS2sYX
	 U1++OQdjOjLIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691C3925479;
	Tue,  7 Jul 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: usb: lan78xx: disable VLAN filter in
 promiscuous mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178342320589.1506559.9026475494202161606.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 11:20:05 +0000
References: <20260701-lan78xx-vlan-promisc-v3-1-232266d32743@dissecto.com>
In-Reply-To: <20260701-lan78xx-vlan-promisc-v3-1-232266d32743@dissecto.com>
To: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Woojung.Huh@microchip.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305419-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:enrico.pozzobon@dissecto.com,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Woojung.Huh@microchip.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dissecto.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A82471AFD4

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 01 Jul 2026 16:47:23 +0200 you wrote:
> From: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
> 
> The hardware VLAN filter (RFE_CTL_VLAN_FILTER_) drops VLAN-tagged frames
> whose VID has not been registered via lan78xx_vlan_rx_add_vid(). It is
> left enabled in promiscuous mode, so packet capture (e.g. tcpdump or
> Wireshark) does not see tagged frames for unregistered VIDs.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: usb: lan78xx: disable VLAN filter in promiscuous mode
    https://git.kernel.org/netdev/net/c/60444706aa17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



