Return-Path: <netdev+bounces-297403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VgJcBuPEKGpVJQMAu9opvQ
	(envelope-from <netdev+bounces-297403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:58:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B16655D4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:58:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AtRyIJlK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297403-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297403-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85EE030B1CA0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F491A6824;
	Wed, 10 Jun 2026 01:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2516132A
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:57:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056645; cv=none; b=o8Gx2fEhvRg7dVCHhZ7AjccpO3TREtip2lJG540+xp2h7orp+iBZXjiuNekuquzi1sEm5GzNQtidazfmM2HkN+9XwBo4rXpu9+JeIblu8ewkqYvHa5tOMLwquEskT48ZLRujT++yEt8gqUQ3pqCp1YfE/4UMDI8+LGY/Ga83Dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056645; c=relaxed/simple;
	bh=MaTkXT++CTdnHudW5OCYihbDjsp6eGjrtgf1c9O6Mvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vwx+5D2BDwNYjH3MaGGrn7bTPuRskmJNVvjia4ayb2wGQlBxzmEOKMI6zBnts3/pWW5Xd9PyjKtNPq1tZdobUvlssZ5HASS0EWrBINGwHlmJbRxel4Oi8S6PWyhvzh2XsaAdkGOQsLM7niyRkkoQmZT/Zi/Zesq1KfbnmLqtt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtRyIJlK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099151F00893;
	Wed, 10 Jun 2026 01:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056644;
	bh=9s/N5chzqR2WXetjj60ZVAYsngfF9X4zNDL5a12gh1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AtRyIJlKsJhMNaF7kkkkdudCDRibtarrW2Yqc9Gr9VoCNDzYiSypEIHmaaDNy/uUl
	 U0dtxR7aXC0jeXrIbcNVTYZ3iIczIP8G5t66qJADIHJZxhdGlWKRewPqiblu0fM/94
	 Ezc+S09JLpU21G6mXb+k/O7fuAwVAKK31a9WZorEphtU81Ksp1Kbzf/nNxLBYhHy1T
	 MxWCr1tnp0KAs8skDEw6LOq7sDsH7qnyJm/UwKitCCOE6/zACRxvDgNhesGyNffx1O
	 xHdyL+/19MbdI3zBm0r47DFRxyDrMgXAuiMm1GXblJKbymOfEp7kzPyqHiTT2m9aO4
	 79dGvKEgEK3Ig==
Date: Tue, 9 Jun 2026 18:57:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v2 net] bonding: no longer rely on RTNL in
 bond_fill_info()
Message-ID: <20260609185723.6c5352ac@kernel.org>
In-Reply-To: <20260608135051.637439-1-edumazet@google.com>
References: <20260608135051.637439-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com,jvosburgh.net,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A18B16655D4

On Mon,  8 Jun 2026 13:50:51 +0000 Eric Dumazet wrote:
> Subject: [PATCH v2 net] bonding: no longer rely on RTNL in bond_fill_info()

This one does not apply
-- 
pw-bot: cr

