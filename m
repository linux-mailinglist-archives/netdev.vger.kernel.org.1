Return-Path: <netdev+bounces-297717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VONbNn5/KWrWXwMAu9opvQ
	(envelope-from <netdev+bounces-297717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:15:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A366A9AA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:15:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Zm8/SNaX";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297717-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297717-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E09373017074
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB714192E0;
	Wed, 10 Jun 2026 15:09:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8153403AE0;
	Wed, 10 Jun 2026 15:09:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104159; cv=none; b=gSIPy1RtF2eJoMPhZ6xZMuzJ0W/mlJTcLaMDr3/ToNsoy6M+p85Qkh55+++MKCoDDkbCk7nDjpuvTYrFF7YxH79l11oivaaEeQtPvBI40Y7ihz7k+U/FWfX+S9Ume9yWIJaW6NRWo3XE0//Cp/Rp15MZ2eG4tzkaGX+bWAZpxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104159; c=relaxed/simple;
	bh=tA/untSj+tG9lh2v33r52Qa+XsXymVWnkc/1XyFydK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHux8lsAHdrlrkgh7UdBYtCHif13XSIGlSpzYxsJYSGqzuNyyplM30lXkdMsr6cWWuNaPoNA7q69Y+8bStJFPGIHVOJfgkMhNDe3HSA7XCOSNSP+dyC7M/Sc1Qk8n1Jnxv/+L0C/ck4LDcev9SnRw1X0t7FVpyC/KjccWn0Hog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm8/SNaX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA3D1F00893;
	Wed, 10 Jun 2026 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104158;
	bh=2riMH4v7nCtM5EEVBOarO8veqFiO7ntvGyqzsKAqWeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zm8/SNaXaxCusjb4qlDFNpCGen9YFklQkXWpYet1o8XCsSMib5Je9x8JF6qAIRvGz
	 ZN/+sTh8R4VQqqyMdCWPfcXotZduIjxeHKMybZFP0H9RWP2pzyHRmbzbJcaV0oka2I
	 AaW9SIABBO7qa9BkIM5L+xGN1Pb9gM02i5anMRg1V7zDpab6Ahe+bmb3ozSRbQS/kC
	 7aC5h5JgY4mwWbRtZdi3jo8ZW2bFmUl4IV734AbEGFwi0/vClNpxy38WCa/wrK7qit
	 TFd7X+qPKxGoalpMoixIW1Z2sBUzSOC3x4ecylrgS2BhKWehfRfWSTMQlabv6P+5Um
	 z8lgam4G/f7kA==
Date: Wed, 10 Jun 2026 08:09:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org (open list:TC subsystem),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] net/sched: act_csum: skip malformed IPv4 headers
Message-ID: <20260610080917.52135297@kernel.org>
In-Reply-To: <20260605152916.2125473-1-sam.moelius@trailofbits.com>
References: <20260605152916.2125473-1-sam.moelius@trailofbits.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297717-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C7A366A9AA

On Fri,  5 Jun 2026 15:29:15 +0000 Samuel Moelius wrote:
> act_csum trusts the IPv4 IHL field before using it to locate transport
> header fields.  Packets with an invalid short IHL can make the action
> write checksum data into the IPv4 header instead of the intended L4
> header.
> 
> The action should not repair or modify packets whose IPv4 header length
> is invalid.  Treat those packets as not eligible for checksum repair and
> leave the configured action result unchanged.

I could be wrong but I think we were trying to prevent such packets
from getting in rather than fix all the places that call ip_hdr()?
Someone please correct me if I'm wrong, or ack this, otherwise I'll
toss this patch..
-- 
pw-bot: reject

