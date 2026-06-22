Return-Path: <netdev+bounces-301217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NWxjNPa4OWrJwgcAu9opvQ
	(envelope-from <netdev+bounces-301217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:36:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBDD6B2AED
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:36:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g53CH0g8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301217-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301217-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34EA13018D5A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E294135836B;
	Mon, 22 Jun 2026 22:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422E27B32C;
	Mon, 22 Jun 2026 22:36:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167784; cv=none; b=WMXsDIYKrsPCEsOs9o/y4gobDNXNw0nvgD0LHJ+xY1mJLhGY1I5FSfIAYRX/GdM+PNuLcBmJ5BEdGu0MwhZpbEZ1mqT6+6O4ad7UM8MyPLevxy1jhLfp1Mqm5W2qZOUwZcsh55Bt16XBtdDDNojzCv6XSJd/252kDzXKu7rray0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167784; c=relaxed/simple;
	bh=RLGF1yeAWSeVmieduDBbFcSnR4ndTRbl1hoZPbe9SbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhofnHXJKBJoITYRvj6gZbErMS/cocOSP+jaMVLM6IvQW/ECjCHLaR7ubCLxILx0uaXAd8loPH+utdelbmFhiB0fP5k/oQdJEMM6oTKjL97enp2bCjxaZ9kwV5isC1tth8rUTebud/6n73VQv/SlX5OwA/EKbBAKrsrWEisqGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g53CH0g8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317C91F000E9;
	Mon, 22 Jun 2026 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782167783;
	bh=4wAb8ZCFUVH/IHXTidrcFkcBUFz0IgRXgy2Dtd5BR8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g53CH0g8XcytwkIlpD35uURDRdYxK7SXIY8yTdI7azR9Bx/4zXxYKTqkYr5csjmAX
	 lHZAn7fQipoHLAyTZ/fOfS++XTeidE3GpeY15VTeDqNycwuijBj0oVak0zQwLj1uYX
	 V5tQ44iol89Ijrw2zEH0u8C6gk2pb2WphOgGtcUlnVYeIHuaRHQ1g+7UcUWBA7C0KU
	 S9MsjXzUWNVfViVXaQ+3bciKSLC+lguJmkVrs3s/cT3znrEqqA3nuHUqWrIpu4gCKe
	 RUGb1sFS0HPvrEmCWfi3JZqIigseDD9MK1LNAEt0zFQ+U/lqtZjB8OINRkkADBTDRl
	 TRx+a1iuNizsg==
Date: Mon, 22 Jun 2026 15:36:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Wells Lu <wellslutw@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net v2 2/2] net: ethernet: sunplus: spl2sw: fix multiple
 of_node refcount leaks in probe
Message-ID: <20260622153622.6f9d4891@kernel.org>
In-Reply-To: <fe9cbe90adf4bb6fe5f2f7b7f267075e603d84cb.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
References: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
	<fe9cbe90adf4bb6fe5f2f7b7f267075e603d84cb.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301217-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,cambiumnetworks.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:shital.gandhi45@gmail.com,m:wellslutw@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,m:shitalgandhi45@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FBDD6B2AED

On Tue, 16 Jun 2026 01:20:32 +0530 Shitalkumar Gandhi wrote:
> +	struct device_node *eth_ports_np __free(device_node) = NULL;

Please don't use __free() in networking code
-- 
pw-bot: cr

