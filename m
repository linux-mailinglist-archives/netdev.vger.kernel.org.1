Return-Path: <netdev+bounces-297323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CmCsH92OKGoHGQMAu9opvQ
	(envelope-from <netdev+bounces-297323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:08:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E3F664732
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:08:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="T/mH8CIK";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297323-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297323-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62FC1303D335
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4263E5EC5;
	Tue,  9 Jun 2026 22:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33363EB0F6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:05:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042754; cv=none; b=K1L6crYR6q8QpYpokDpstx75KtG/Z3+AJ/NGW4Uc5bm9UUTizsIHXeOTMUT8Zi8PJEPaJemk1DeeKD9fvcq2qSYmL+RrUMsBHDug5f69RXflq/9HSEtBuyRUAEGu12EiScrPAcza5zfyZI1c3xmZ+FAJLCCZRm/epyCniXnQZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042754; c=relaxed/simple;
	bh=HoDSBKJjHVMPvX81IRFiiuGpxnHrJXtqODStpk0TR0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uu5BzM+MANZ19BOeZqCU1DueDSaT4INOjU6BrlnF7bprYsppngEmLfiy3TOcQRyvshnrO1zyzC6RLbeQj5H0RtuCO2tGZMbnJeyDrk+Xh0PpNkOVrq3b6IdaROsEiNsQ0AYCYokdjDmzexvv/7kgH3qVaRzNSgjPKeSY0OI9W3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/mH8CIK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2672E1F00893;
	Tue,  9 Jun 2026 22:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042753;
	bh=lsZr8NsT7I5W8zFPTZN43nG22GTSmPGdkPQAhmUqgBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T/mH8CIKbhCeGsEgqEE89PkBLqFcUqDkO4i7w6ZlDujoa2D3RMZovn0QkCwftFlEk
	 Fvn6UBBt8ZhYKrhjjrp1f9oiWXL0SEGyCFuju/frjqzi008soKGrKdZoudi/RoqXgU
	 /4IH8D+WcysYRNDirTXxT3PE+or4iaZ1GikstHMo0K20jNiwtbds3DcOKjV9GOhhiF
	 2sf7k/+2rxKvLkCaYJRL4MVOEPrlBYjISlpumrwRx+1ZL3+fHWgq+dsEfACfWYUY5g
	 PN+Shexic9RkqJucXqfq5XTDCku7KUMhvOI2Njqr7Bw2H2N1K517Ha9/FIEkwkPZwn
	 I7ASWzCCjY8vQ==
Date: Tue, 9 Jun 2026 15:05:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
 razor@blackwall.org, sdf@fomichev.me, dtatulea@nvidia.com,
 bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 1/4] netdev: check for nla_put_u32() failures
Message-ID: <20260609150552.2d962600@kernel.org>
In-Reply-To: <15c024cd-7ab1-47b4-94e5-90db0f74227f@iogearbox.net>
References: <20260609190804.1137085-1-kuba@kernel.org>
	<20260609190804.1137085-2-kuba@kernel.org>
	<15c024cd-7ab1-47b4-94e5-90db0f74227f@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297323-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7E3F664732

On Tue, 9 Jun 2026 21:52:25 +0200 Daniel Borkmann wrote:
> > -	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> > +	err = nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> > +	if (err)
> > +		goto err_unbind;
> > +  
> 
> Not sure about these three tbh... if the skbs are guaranteed to be
> large enough, would a more straight forward ...
> 
>    WARN_ON_ONCE(err);
> 
> ... suffice?

Sure, I guess it's subjective whether it's better to add a WARN
and have to explain why it can never happen or just call the
undo function since it's already available :)

> Unwinding at this point feels a bit excessive. Is there
> any other way we could assert this earlier before we do all the ops
> that need to be unwound?

It's dead code. We keep getting patches for "nla_* return value not
checked" tho, so if decided to squash these while at it..

I'll respin with WARN

