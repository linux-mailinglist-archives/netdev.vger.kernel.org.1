Return-Path: <netdev+bounces-299454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1HYjKwP6L2qyKwUAu9opvQ
	(envelope-from <netdev+bounces-299454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:11:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F57686912
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:11:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kgyH3liL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299454-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299454-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7EB5301F5C8
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C23F1ACA;
	Mon, 15 Jun 2026 13:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4B3EDAAE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:09:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528949; cv=none; b=Je9fVClsgHRrSz2xnk6Zah/zRBTHNCTVb7X4Jtp/diB2/wfs1TolEZYmCLVKYz0gsDvM8SfbTXxnxJa4CwSUhUvbADqeWs5i/VW3sAFgitjl8fqS5+TvxcpV0c9Sc3nmPW913dG195hu8xBHbuC+Bcz9ciSPkSCRDPiSHx9Wne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528949; c=relaxed/simple;
	bh=6/QW0hwjYNDL0OQOwUFTecbMvVIwqVwpKtiwp5o1gzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BitPN6eSqVMfLlkSIIXGcq+cOq33q78eo8GP77mIWSLzxSGRKj+DRJj9sMRLSPQ99gKO2hyLRi/VhgUKwX5l8JhO7/ZBA3N+zynj9flDxSMxSL3W8xIScsLzlcG4UaYyJtjWhjqcg56qWn07x8sDCjZztfR0c/M3AT3xmcKynSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgyH3liL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ECB1F00A3A;
	Mon, 15 Jun 2026 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781528947;
	bh=R3UbtKcRGbxKuEsTo7j+fbGTaIsQmUUwsr5xJkcmjzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kgyH3liLuBxxZeP1VNOWThQBKzm9JdV6jiDw8FgJv0A86Fi+8FDR+dVubkoDxHRFF
	 nrqLgjKVGI49LZg8htZUZdFB5EFdKUWoQFYXhyf4ccfyVxOs8jC52EtirSMZXFjWFg
	 ACfhVb+Kn6jAvbdw9PvZDZmmc9Wzby5YJ3JSieM9gHiffH5tdN4hopyi5za1L4NVLH
	 hBLZ2dTjFNaVGkGKS1hpd47G1UZ4zxO5r8pny7iKKGFuaYiuuXhuzTy+gEhV/dh8Jw
	 T3kCEkmoNst/BuLMkRRwpmKYdXYILMez40Fa7HG88dx+zDRRFysGFD+RY+TwqKvdE8
	 381kPG9hrfisA==
Date: Mon, 15 Jun 2026 14:09:03 +0100
From: Simon Horman <horms@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	yotam.gi@gmail.com, edumazet@google.com, pabeni@redhat.com,
	bestswngs@gmail.com
Subject: Re: [PATCH net v2] psample: use nla_reserve() for PSAMPLE_ATTR_DATA
Message-ID: <20260615130903.GM712698@horms.kernel.org>
References: <20260614034919.918494-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614034919.918494-1-xmei5@asu.edu>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299454-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,gmail.com,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04F57686912

On Sat, Jun 13, 2026 at 08:49:19PM -0700, Xiang Mei wrote:
> psample_sample_packet() open-codes the PSAMPLE_ATTR_DATA attribute and
> reserves nla_total_size(data_len) bytes but only writes NLA_HDRLEN +
> data_len of them.  When data_len is not a multiple of 4 the trailing
> alignment padding is left uninitialised, leaking stale slab memory to
> every listener on the PSAMPLE_NL_MCGRP_SAMPLE multicast group.
> 
> Use nla_reserve(), which lays out the header and zeroes the padding, and
> copy the payload into the reserved area with skb_copy_bits().
> 
> Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: use nla_reserve to ensure no info leak

Reviewed-by: Simon Horman <horms@kernel.org>


