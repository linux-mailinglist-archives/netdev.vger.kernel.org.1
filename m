Return-Path: <netdev+bounces-305504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6xtWBnUSTWp1ugEAu9opvQ
	(envelope-from <netdev+bounces-305504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:51:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1871CDA6
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:51:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=aR4VJX9a;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305504-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305504-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2193300A495
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673A372049;
	Tue,  7 Jul 2026 14:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EF36F912;
	Tue,  7 Jul 2026 14:51:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435880; cv=none; b=jgGfyUj1HRpAiXZMdcwDWGwhglFuH+r2gLXcE8HiBRhxPdGPuNaHnI4g6C7UvTgCBg9o+gqFCczK7tP83JQH/hIMxJK8Wz9Jm4wpqzCBpQ4V6kGv+xDlm/irfGlGe3bErSLj05NCGddVBtUcxOsr77/jU+5P1AO06rfQpqTkIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435880; c=relaxed/simple;
	bh=L9pxNODWKGKAuUCsthtXuF8mIBH7L4Qzn2ryWaBeMOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1nq/Zw2T3iutwclBHnsEd0sv5f62gnsayjBAVojvkZiuRRyqPYYdO7B3kmyaY4XHNGmZ8PzsGiR58qoUCMGcVfns8qFjvJVa9ipJLNYt5Glp8D3OhWTj7J2AUBlkQLtHcmjQ6qgZA7NKPqc/z04kPM46lfamNSd3Y5S6cl4oic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=aR4VJX9a; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 9F22560581;
	Tue,  7 Jul 2026 16:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783435875;
	bh=gt9EUNIkxSF/HxvT4+/9rtfn5HBwdYBkGcy8bzzqMU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aR4VJX9a0lT4k9RgfZhExBrDXRGUzS7AoA51CHfEL2KNL1oAInOVY65NfNkS4a194
	 rxvdatytP7zN8L80/1RejAhfLRbXPpxDIFHiYXhM2p9ElKBlKezwe57ldSDeS5ITS5
	 pplEuB28dm/CYaFJ+S0kyhbSpfgsH2ZYdYsE8kKllun3Q79DvRKeL/4uz4UXINnbvv
	 cAZqvc59Utem2Chghcg+66CSJ2ITL3ZtMbSNOIkK2+iLh4uM6cjosMqV2g9cIXU8O7
	 pEnP53NxY082Zr3DnPGYV7GtiEcuHtimKPoG9sml53gan3rkih6RXfWwpu0o+mtArX
	 lhHIrCAybxR0w==
Date: Tue, 7 Jul 2026 16:51:12 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Simon Horman <horms@kernel.org>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, laforge@gnumonks.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next] gtp: annotate PDP lookups under RTNL
Message-ID: <ak0SYEOvw6K_8C_w@chamomile>
References: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
 <20260707142820.GG1364329@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707142820.GG1364329@horms.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:runyu.xiao@seu.edu.cn,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[netfilter.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305504-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashko.dev:url,netfilter.org:from_mime,netfilter.org:dkim,seu.edu.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1B1871CDA6

Hi Simon,

On Tue, Jul 07, 2026 at 03:28:20PM +0100, Simon Horman wrote:
> On Wed, Jul 01, 2026 at 08:39:25PM +0800, Runyu Xiao wrote:
> > The GTP PDP lookup helpers are shared by RCU-protected data and report
> > paths and RTNL-protected control paths such as gtp_genl_new_pdp(). The
> > helpers walk RCU hlists, but they do not currently pass the RTNL
> > condition for the control-path lookups.
> > 
> > Pass lockdep_rtnl_is_held() to the PDP hlist iterators. Existing
> > RCU-reader callers remain valid because the RCU-list macros also accept
> > an active RCU read-side section; the added condition only documents the
> > non-RCU protection already used by RTNL control paths.
> > 
> > This was found by our static analysis tool and then manually reviewed
> > against the current tree. The dynamic triage evidence is a
> > target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
> > to documenting the existing protection contract.
> > 
> > This is a lockdep annotation cleanup. It does not change PDP lifetime or
> > hash updates.
> > 
> > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> There is an AI-generated review of this patch available on sashko.dev.
> While I don't believe that the issues raised there should impede progress
> of this patch you may want to look into them as possible follow-up.

This patch refers to the rtnl_lock, but it is the genetlink mutex that
protects updates on the PDP context list.

Then, from packet path, rcu lookups are performed.

I think this patch is not correct.

