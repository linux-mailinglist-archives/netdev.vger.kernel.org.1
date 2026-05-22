Return-Path: <netdev+bounces-290910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEHLNcafEGpuawYAu9opvQ
	(envelope-from <netdev+bounces-290910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:26:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 993815B900B
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ABFF301D5AE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D037204A;
	Fri, 22 May 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvgo6fGN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E62F1FDE;
	Fri, 22 May 2026 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474321; cv=none; b=Jk3hEswcbYRbt2Jm04QohQitLPyE8Lgn3TQO1ECLpaaR7YysQzkSLwx4taalbX20uR0QxHaR8kcLZo5tJCNf4HUTwd/j+yibx++AlU2kmf0bMVrXSUi64DVctNOhLcE0skAkaXTpxCIhYI3Y8RBdI0/MSq7UuqadknZ4MIRw6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474321; c=relaxed/simple;
	bh=xewNZVxD7OiAQJMZ0eU3MQI9VUqRN32jLI24bdZwnmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A418hbyg1CrFYtDZN/LFOjuzwD3iTAAIhUXkLzVBE3V9mG6dMh/906A7zvnx8wF+Eu7lqEXviSJkkqY8auMsV88+GVjKibap4ZkuxOltetHKZ0C2eKzcuphKDsvK1z7WYe/fSfKRcU90ZY6ZGilWSDqarTfPYXTQx4Bg/CV46Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvgo6fGN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CCE1F000E9;
	Fri, 22 May 2026 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779474319;
	bh=CNx7Y5Epk1GGzfGDUsLjJG2duJ/Gc9CxD9svr1n6R00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qvgo6fGNniRU0zvysx2nUwIgVUXfjsFJNeoGmfAvBFMqAX0gDcgLUfRnjHXX5RQXq
	 GWZAwXVB/4fjKFUcod1DF6eOMwg8iT2KqhKAuECqfKMjLRtudw6rat+4IfsC45LwGH
	 iP+Y9iuJbf1iUPp9fnj/1iqBEBwpv7MDq8Z8lDVPOVFTpZvO1lAopOKBqJn3wBizlD
	 Bb+6dZvaCR45/n57blOlFTrje7useotgGvkyF0ptsAXOz88Ys6JaSSAXkPCXp6h3Yf
	 zqN4aRY4H1qGGLQeQPSxVFEynbvl5n3GxXNitCBu+us7dadOydDYvE0xwcdrEBQi/x
	 nmQcP/VLAQguA==
Date: Fri, 22 May 2026 11:25:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <20260522112514.1ad6e947@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <ag2t4eVe4DcfU2yZ@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-10-6bd70e329df6@kernel.org>
	<20260520085934.54AD01F00894@smtp.kernel.org>
	<ag2t4eVe4DcfU2yZ@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290910-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 993815B900B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 14:49:37 +0200 Lorenzo Bianconi wrote:
> > Does this strict OUI validation cause the driver probe to fail when MAC addresses
> > are randomly generated?
> > 
> > If a MAC address is not provided in the device tree, the driver generates a random
> > one via eth_hw_addr_random(). For multi-port configurations, each port receives an
> > independently generated random MAC address.
> > 
> > Since the upper 3 bytes of these random addresses will almost certainly differ,
> > when register_netdev() is called for the second port, its ndo_init callback
> > (airoha_dev_init) will invoke airoha_set_macaddr() and hit this check. Returning
> > -EINVAL will fail register_netdev() and abort the entire driver probe, leaving
> > the system without networking.
> > 
> > Does this also prevent users from changing the MAC address OUI?
> > 
> > When an administrator attempts to change the MAC address via standard userspace
> > tools, only one interface can be modified at a time. The driver will compare the
> > new MAC against the existing MAC of the other port.
> > 
> > If the MSBs differ, the change is rejected. This makes it impossible to atomically
> > change the OUI of both interfaces simultaneously, locking the MAC address OUI
> > to its initial probe-time value.  
> 
> As pointed out before, this is a hw design requirement when multiple
> net_devices are configured as LAN.

What about Clashiko report about the MAC address?

