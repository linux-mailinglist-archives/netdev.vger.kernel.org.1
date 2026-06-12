Return-Path: <netdev+bounces-298812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ccPjGFqSLGo8TAQAu9opvQ
	(envelope-from <netdev+bounces-298812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:12:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F9667D03F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:12:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=acGtyKdZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298812-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298812-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06F6E3112B68
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8193D25AF;
	Fri, 12 Jun 2026 23:12:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6153A3E76;
	Fri, 12 Jun 2026 23:12:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305942; cv=none; b=fvCNdcW2MCcwy20L1Rzp+XeAeVoW4ObQnUFa+yMfJ0CXBGsgicjebQ873FWaLRDOVlEMcEIgyhK8K1LjyhgoL14CedELUamyTQwNNiF7szm1ArkQidRrWlcT+gkq8yPoOUsj+w7fR41XzbXhzStDsrjv1BL9g6l59OVjuA9WT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305942; c=relaxed/simple;
	bh=MoEwvpdIZGKGyvFDEt1unue2cVnVVfQPz8rbJMRfetk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmU7IuNSPfuYX0TxHChJ+xSgkf4CY2nbIrQf0hohjy2aX7ldQ52E1fwd4/1p/QCw8ngtLFwrLCMXMV6R7Rutp9ilQ8gXY6C/vorkMIb4DvSpArQFRtTtX5lChdiDgAxs8bG/EPcoRAWqEixUPW8ZKV7vtVBWapolRBS3fFiBMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acGtyKdZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CA51F000E9;
	Fri, 12 Jun 2026 23:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781305941;
	bh=MoEwvpdIZGKGyvFDEt1unue2cVnVVfQPz8rbJMRfetk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=acGtyKdZN6XvGkhAG9vHM8ugVUS6OlHtIswHXnhb12dWXecih+znT6SxE3GAPbAWN
	 KH+5qHnkZBv4ECShHhCqo7HrOANnu2ylq5vhxdG2UjMRUCfGyEykPZDhW6xAcUj1by
	 INY++tgCXHPk1zCAtszPK/jXoC4cH+ETx9BOm2UO2C9CmPMjxOpaAyBANuWDUUwcnE
	 123z0ZEZ0KAReC8KK/y0a0fI1Mc0QTr+Ay2ZNvraB3QTKDCViHJKxSfeTLklo6pBdK
	 kz1K3XtDTNNnvJCUJkxEciORLgn91TaSn8z6hyv7blFtxD26NFyC2dHzW1U9v40MQN
	 TKnANzshDWfxw==
Date: Fri, 12 Jun 2026 16:12:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] atm: fix skb leak in sigd_send() on a closing listen
 socket
Message-ID: <20260612161219.49ac64d8@kernel.org>
In-Reply-To: <20260611163805.2151734-2-bestswngs@gmail.com>
References: <20260611163805.2151734-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0F9667D03F

On Fri, 12 Jun 2026 00:38:06 +0800 Weiming Shi wrote:
> In the as_indicate path, sigd_send() pins the listening socket with
> find_get_vcc() and queues the skb on its receive queue under lock_sock().
> It does not check whether the socket is being torn down. If the listener
> is closed concurrently, vcc_destroy_socket() purges the receive queue
> once under lock_sock() and removes the socket from vcc_hash; the final
> free goes __sk_destruct() -> vcc_sock_destruct(), which does not purge.
> A skb queued after that purge is therefore leaked.

same story here, nobody uses this, I'll delete it instead

