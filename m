Return-Path: <netdev+bounces-296561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kBrRD6vCJmqOkAIAu9opvQ
	(envelope-from <netdev+bounces-296561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:24:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8672D6569AD
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:24:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ag1rsv5M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296561-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296561-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23AD0302617C
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E80296BCF;
	Mon,  8 Jun 2026 13:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015425B08C;
	Mon,  8 Jun 2026 13:13:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924401; cv=none; b=H6diwVXj0mIZoTuHMxZLYcLZqSmd3fO2qcp7yqnpRruceVqFL6Nd39xMRYGh12uE2xXc91mKaftfMHPlXbnW9zgCnIQ7cpLMycWuTvtmLIKo4dL+ZeIu+GwYmeVBon5eJKcOTyuAScxISa66UMejLy9o6sBmfFgLXJTbhu+M+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924401; c=relaxed/simple;
	bh=/TKSnWQ6JOX97fQkq9jKJbWkkeg9o0n6yejRgK+u2QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJBfqaLHCHLqaSon7hMZYgxL10bsW+SU5uVJ91dC2f3+Du5K8ezrTnoDutp9eg7yVyKrVQgOTLFwhWAUpl6Gjz2teIFunwghwfLedWAyPMkAFinKe+nAvRmy4xVKb7+MQitWMJzns8Sh0/91zEVFubNjJiL7PttHM+7KGO786QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag1rsv5M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CFA1F00898;
	Mon,  8 Jun 2026 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924400;
	bh=QpTs5UFOT2oMdb1p+VnugRrxkSjHSy3S7PAaG65mdm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ag1rsv5MB43EgzDtC+61vWH1qToXywKtUJ6SByLRduvfANMlHyYGu/VZ/5y6WZRFx
	 1oSR3RND8ySqr8wieS0AJ1jsa3v27e8trAtS61KHTbYFHQhoK2wod5bG4Ox5RRQnOJ
	 5ps6+NHTSxJ3jhPJUnQyEh4soK53eXLGMc+Ca0mKDEgYZ8fw5eoIrjZ8gTeDa1zH+s
	 e+ls+9/hatrftoXHxTGwLf0VSQGrUYK2XtQXlEUeM7+h8GNd/f5qb7Kmen0Q6sraYV
	 lX9FIL7YlXELOnnZWg4OcdIUMMOHz50hXpdLM1wC1SdpJSbqVCt08H+1zcGPtRBXAl
	 fPduAAEWBkipQ==
Date: Mon, 8 Jun 2026 14:13:15 +0100
From: Simon Horman <horms@kernel.org>
To: Santosh Kalluri <santosh.kalluri129@gmail.com>
Cc: netdev@vger.kernel.org, Remi Denis-Courmont <courmisch@gmail.com>,
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phonet: free phonet_device after RCU grace
 period
Message-ID: <20260608131315.GA122418@horms.kernel.org>
References: <20260604000843.4028467-1-santosh.kalluri129@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604000843.4028467-1-santosh.kalluri129@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296561-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,remlab.net,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:santosh.kalluri129@gmail.com,m:netdev@vger.kernel.org,m:courmisch@gmail.com,m:remi@remlab.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:santoshkalluri129@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,horms.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8672D6569AD

On Wed, Jun 03, 2026 at 05:08:43PM -0700, Santosh Kalluri wrote:
> phonet_device_destroy() removes a phonet_device from the per-net device
> list with list_del_rcu(), but frees it immediately. RCU readers walking
> the same list can still hold a pointer to the object after it has been
> removed, leading to a slab-use-after-free.
> 
> Use kfree_rcu(), matching the lifetime rule already used by
> phonet_address_del() for the same object type.
> 
> Fixes: eeb74a9d45f7 ("Phonet: convert devices list to RCU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
> Acked-by: Rémi Denis-Courmont <remi@remlab.net>

Reviewed-by: Simon Horman <horms@kernel.org>


