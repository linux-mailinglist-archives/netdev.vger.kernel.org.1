Return-Path: <netdev+bounces-299674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D1pQAMKWMGokUwUAu9opvQ
	(envelope-from <netdev+bounces-299674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:20:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880568AE3D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:20:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QpkVhquY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299674-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299674-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5027730028CE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB50D217F27;
	Tue, 16 Jun 2026 00:20:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117D20E702
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 00:20:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569211; cv=none; b=jqFKaPjPMKmXmYoX28a/ZBUqFRXGZmX1mOJV7NBCEgEkR4o30feE+2V0bm3Sx8C9zR2WxHkcJNFlULewOhpQwbdCHy56cIZewaacfeHVBejYN5iRWpuXhyv6QkFA4+mHUhlA8UKn1xFVuKzOrbC1GwLAw55TFrl6w/oMl0lNg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569211; c=relaxed/simple;
	bh=UUx20JhzvphTtxfkh6MZdHPFlT7Ifs8HRI6w5pKu3zI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pBYzMSDMrZJW3WRzyldNmR0OZ3QWe010KP+u+IDgsu0XGbiXlh8ldl8v7kO0A7BmrdHes9l/QsJ8QxuhjJR6bMXSKLiNUIO5RPGQMLPvg9ZjG468wKYCwlAnJfQ/KldGG7UBfO9quoWndMy0+QAD10C+SYO9v/NrrzhtkWdKP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpkVhquY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6090B1F000E9;
	Tue, 16 Jun 2026 00:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569210;
	bh=+6/QjuRGJWhzJiYsFb4zArvnhQy+cy8hHzkFU94yP8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QpkVhquYuDU2AX4DYVJsJvF6u5sRTbsEiNMGAPWWaJlG6UCnS38hoYtGUc7dBOTm0
	 +52AzvGyBxtG66MFnTX9vWRSENnoQ53lz9F2NUBxrlTn6cz6Qz/QCz6nEcgeVQtAvd
	 bvujSVfV8LO49vGBDdv0/DTlxt0PC4g2jAJB8bPLxK/squoKGyObe256Fj/0ZkeafG
	 x14YY2Nq+3rYNDldt2Fg09yqia1Ez62Ot8qqyk9FA7Twnr6ELYLEmjt1nWF6BN4kqx
	 fSQfy9XcxqKW9M4wN6d6rJ7ho3oZbwThFHbPOKnScXVcVJfRcFy9EY8lsOiawOBI7u
	 C9LVxzg/IRMmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A003839A26;
	Tue, 16 Jun 2026 00:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156920539.351484.2629045688985264535.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 00:20:05 +0000
References: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
In-Reply-To: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 madhur.agrawal@airoha.com, aleksander.lobakin@intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299674-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:aleksander.lobakin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1880568AE3D

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 23:55:50 +0200 you wrote:
> Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
> offload is created or destroyed.
> Make dev->qdma an RCU pointer so the TX path can safely dereference it
> without holding RTNL.
> Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.
> 
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: airoha: use int instead of atomic_t for qdma users counter
    https://git.kernel.org/netdev/net-next/c/a459b560e58b
  - [net-next,v5,2/3] net: airoha: refactor QDMA start/stop into reusable helpers
    (no matching commit)
  - [net-next,v5,3/3] net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



