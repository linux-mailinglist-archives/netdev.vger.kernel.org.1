Return-Path: <netdev+bounces-276209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AfaJK+Gb1WkQ8AcAu9opvQ
	(envelope-from <netdev+bounces-276209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:05:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E85473B5978
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC15301E3DE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28D40DFD1;
	Wed,  8 Apr 2026 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Y8jTH80F"
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5410F1
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775606750; cv=none; b=MQGETnsxFWkw79BE7JmN77iIvhWA2pfZfL5e6xPSjAUPtjDYiC84G3HdbOoXUPzD7omeAROuKfKD+KhT8VIeuN8SdKCPeh88DZ9cbEskYAv9BMfw1ayAukBonXzRZqEmffDpo62VBGG9fQ4rpyDfp7bxGhecrS28rRiAtajabJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775606750; c=relaxed/simple;
	bh=7Gt9Y8XNc065uSsbT2LK+J836+z1K8fVnvtLgL7AOxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTz/qVVGpYcTQSC5zGoo14GcYRg2z8UE0mr84A285lB7eEDLLAYoIhozZ2khhhjpnb25Q2v6Kc1J489f+zMScGz47hFXCzosAIlsE4yQ+MUa+xMuBG/KGDFT8s/L2i/lYDW49qiHoCdqDhCzW6qCwCX9DyacQIq7YX9GRoD83xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Y8jTH80F; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 229F860177;
	Wed,  8 Apr 2026 02:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1775606739;
	bh=FE6fZ1RBkKhan6UIKFv6Pe5pW0AP/hQ/i4BDtZW71dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8jTH80FlDn2G9OPj33RNCx0mF/McwgOJLWs+oTxz5+tCCOKVBlk4vZ0da4hG6YKS
	 iFqkqCKtsgZATVqvasWXCK6WbBQPFBt1jidQOr60XSbUGRF2qjp61ghmZQtpE+fZU9
	 qbN3iTLyiSdwDbD9HgyjxiOG22sI/pn0u0m+EIvo2bf4Bj+KYvrqTnD3/qZ4bl0Io0
	 ZBrGc6S5YRTDZwgWNWiuUKIfIETBJ1PYDsFqIfst7HiG8KxK/JcH7j6JH92gDdoK2p
	 bolq16LkYsm8BQRf4+Gp23Kk7pKJRTrEXsZvznVeWvLUd9J9qyR4fUkiHQ2pMqXlD4
	 /WZS/HMNR96jw==
Date: Wed, 8 Apr 2026 02:05:37 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 13/13] netfilter: ctnetlink: restrict expectfn
 to helper
Message-ID: <adWb0aQFtjdJCLsr@chamomile>
References: <20260407141540.11549-1-fw@strlen.de>
 <20260407141540.11549-14-fw@strlen.de>
 <adUUTtWT8ITs83It@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adUUTtWT8ITs83It@strlen.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276209-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: E85473B5978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 04:27:26PM +0200, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
> >  	list_for_each_entry_rcu(cur, &nf_ct_helper_expectfn_list, head) {
> > -		if (!strcmp(cur->name, name)) {
> > +		if ((cur->helper && !strcmp(cur->helper, helper)) ||
> > +		    !strcmp(cur->name, name)) {
> 
> Sigh, I don't know why I did not see this earlier.  It looks wrong.
> 
> Should this be:
> 
> if ((cur->helper && strcmp(cur->helper, helper))
> 	continue; // skip, name doesn't match
> 
> if (!strcmp(cur->name, name)) {
>  ...
> 
> as is, this restriction has no effect in case the requested
> name matches?
> 
> AI suggests
> 
> if ((cur->helper && !strcmp(cur->helper, helper)) &&
>    !strcmp(cur->name, name)) {
> 
> ... but i think thats bogus too.  What to do?
> 
> Send v2 or do you want to followup later?

Keep it back, not urgent.

I should have withdraw this patch, I wanted to use an enum instead of
strings in v2.

Sorry.

