Return-Path: <netdev+bounces-298332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2a7cLv8YK2qD2gMAu9opvQ
	(envelope-from <netdev+bounces-298332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522F67519F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:22:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="PxKIDkX/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298332-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298332-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ADAB3076F3B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1DD366DA4;
	Thu, 11 Jun 2026 20:18:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A352DA74C;
	Thu, 11 Jun 2026 20:18:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209131; cv=none; b=ZZscX8IwCQ/KJJIQEPcmANGfaohsN6tp2AlGZksuOPMmxbh8OLthWlwzkvlrNzIMNVgR1GJNGRdhkGdm0TqkBN6WFP6DxrdNMxtViWVwitr+J4cFMOoDw8949XZiBSJu6VTTT0tQ7770232txg3SeL1j6ZGu68TUPb9FZhtGzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209131; c=relaxed/simple;
	bh=Dq2Ox2wnsAmZHVyt3pD94kGXzxsQXCuhRbSU9JesZe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP7ewhkcxqAam6yoDpAeKnOBAwR4gcvj24PiG+gBRLIPS7Pdole8fYr/WyqzhtvlXU1mu9k3iycr69eVFmsPkQKYKMH139kfIY1BuH6qZELH9WV2CFM/WrgAWgMR5ilwvAtfzcZDXA90dNNXELTdcjWCVnTaSZJCZqD0Tkk3SUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxKIDkX/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D210F1F000E9;
	Thu, 11 Jun 2026 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781209130;
	bh=DX/8LA1EduAKxuqywHsX5/yxuag/XH71gJLKzaNjNwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PxKIDkX/Ekpff4361dEIEgDKeXN4QHqjZ/yUwEGX5q7A99r10RpzmlVT8KZ41Ky9T
	 yvhVs0s44s0Xo3gMhYyVyaBpRBYEVoB/yij9OLfcYFBa9lkfMqTAgEA3ei56S959IO
	 MXqe+G+cfMAAm2rfSkI2nGsdDXF2Q4EeZ4IExUJGseFn2aZ6HSxFSbOH7GiQeRv6vR
	 dXtJRMmrEdq8AZspE5oAHBckdnwKVd2IVGrXYVIl4E4nAt7zHTbGFTI8C2EvBS7zab
	 IaOZwsyBQJ+oaHHJFRzWrxVRnEPS6TtX7VgLoP8Uzn1kr3TTqitIAEmQWEsZdM9Je4
	 OvLaXuKBxnzkQ==
Date: Thu, 11 Jun 2026 13:18:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Yael Chemla <ychemla@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] netdev: expose page pool order via netlink
Message-ID: <20260611131849.43870ac5@kernel.org>
In-Reply-To: <20260611161235.3807332-1-dtatulea@nvidia.com>
References: <20260611161235.3807332-1-dtatulea@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dtatulea@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:donald.hunter@gmail.com,m:andrew+netdev@lunn.ch,m:ychemla@nvidia.com,m:tariqt@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lunn.ch,nvidia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3522F67519F

On Thu, 11 Jun 2026 19:12:32 +0300 Dragos Tatulea wrote:
> Add a new 'order' attribute to the page-pool netlink interface to expose
> the page pool's allocation order (power of 2 page count).
> 
> This adds observability for the latest io_uring rx-buf-len configuration
> for high order pages for zerocopy rx.
> 
> The order is added to the queue attribute instead of the nested io_uring
> attribute as it can be useful to see high order page_pools for other
> cases as well.

Memory providers have a callback to populate their own attributes
(nl_fill). Sounds like we should expose rx_buf_len over that thing
instead of exposing the order which is more of a kernel internal?

Also please add checking the new attr to some selftest.

