Return-Path: <netdev+bounces-299362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cp4sB724L2prFAUAu9opvQ
	(envelope-from <netdev+bounces-299362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:33:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 644396848E1
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:33:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FPpIFACX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299362-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299362-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 377EF3017C21
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1A383C85;
	Mon, 15 Jun 2026 08:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7593C98BF
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:32:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512377; cv=none; b=pR6KL4UlCFnYhE/dyB1BmoWI7jsQqT9LnbCbMVDdpf48Mp4nnSv55d71e6j7CM/YKo/Wq6+DWeSzLxfDAltHD93ORGZ0WUrV8MFLxgyPuNuHaXmmSM8wsSlxBjiH5fwKJf4/eWD8MrQxMbVEqT4upXmB0EF5sUoEpeliPAm7yNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512377; c=relaxed/simple;
	bh=l8kZOmjRF3nm/M3yU+1H+7o0l++3zGQDbGNNK8pg1Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfGyp1E1GUCIWxxgXpBpNqjcLqwta//7pSz+kp4eFsfn6kbaqHQnweR+WdIDrkW2ifxLp06yTECSH+HFcm1Ytr/Sq54xfUAqRTCKx8gJEu8R9nKxJJalqo0HUH/+auRGhg3sLoup+JyoH9Qc4nZpLWHtA+CfKobglLrISW047Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPpIFACX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F4E1F000E9;
	Mon, 15 Jun 2026 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781512369;
	bh=l8kZOmjRF3nm/M3yU+1H+7o0l++3zGQDbGNNK8pg1Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FPpIFACXQZ95iX1KnmBpaNLqT5r/cZJk6jgXTOvwNIMIeDlzLyD98yeR966OLWcYZ
	 j/O+mhnP9AtkvHFfq3ZaQzdwjDn/aNMCxdtUsrfZJztDJuO/FgZsdLqx5pMKAUDg+c
	 Px/w3SqoUlmUX0VppMm2U5xAfWZ1uchnqZaCQsRuqRhaWAYJlyLFsbJdVcSVUHXNRv
	 1wGjHabsRhJ/ztgedUGARlNZoIYsXIAFQ8hHGrOcb1fJqK2LNl8VNlb7G/LqZwEI4C
	 j2M8ZlzR2jZxK6oZjNWvLjB4YUgvHZ3Qihje/QEy0vJCDSVkGr2PdG7UZx603nmcZ+
	 XWJygWyNHgPXw==
Date: Mon, 15 Jun 2026 09:32:45 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v5 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Message-ID: <20260615083245.GD712698@horms.kernel.org>
References: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299362-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:aleksander.lobakin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 644396848E1

On Thu, Jun 11, 2026 at 11:55:50PM +0200, Lorenzo Bianconi wrote:
> Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
> offload is created or destroyed.
> Make dev->qdma an RCU pointer so the TX path can safely dereference it
> without holding RTNL.
> Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


