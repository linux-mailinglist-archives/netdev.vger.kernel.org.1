Return-Path: <netdev+bounces-256334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIpGE/8Pgmm9OwMAu9opvQ
	(envelope-from <netdev+bounces-256334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:10:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F2DB1C0
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0421B3099884
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3DD3002A0;
	Tue,  3 Feb 2026 15:04:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17E2FB612;
	Tue,  3 Feb 2026 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131043; cv=none; b=ZO5IjxXSGR7dZh4FxRcngAh8pTyFut834Qep4Gd14E4ognt9wPE49ry5DFHBHn3cb3bC3SDibr+/SyDW77iqRj8WcZ3kp/oGNi8z7ac6JOke0nPWXSbdgUVwSlJShqwmD0/4tbmX6uDYSiumLZB8RtBzsqtC2wEUkECNxTKOm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131043; c=relaxed/simple;
	bh=najQtQrVjuFmTk+wdSsh/0gRiVydvigfoZIUvEw3NEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiYYfLrMQlOR9hZh5TuPqLt2TwAkr8hCh2kcIFXNYw0+mcfll6H59RbBTglRSghORiIu62Ld650HBa++KqLSGDGcssYFxcqhDNCXe3mW7DciTEYn7QBfJICKwJEBjXoHDEPlVUDkq0eNoA5EHK7bkVKz7UfMWWIJogrhid7/8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2399360242; Tue, 03 Feb 2026 16:03:59 +0100 (CET)
Date: Tue, 3 Feb 2026 16:03:58 +0100
From: Florian Westphal <fw@strlen.de>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: amanda: fix RCU pointer typing for
 nf_nat_amanda_hook
Message-ID: <aYIOXk55_DRFKCqo@strlen.de>
References: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
 <20260203145511.164485-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203145511.164485-1-sun.jian.kdev@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256334-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D85F2DB1C0
X-Rspamd-Action: no action

Sun Jian <sun.jian.kdev@gmail.com> wrote:
>  enum amanda_strings {
> @@ -98,7 +98,12 @@ static int amanda_help(struct sk_buff *skb,
>  	u_int16_t len;
>  	__be16 port;
>  	int ret = NF_ACCEPT;
> -	typeof(nf_nat_amanda_hook) nf_nat_amanda;
> +	unsigned int (*nf_nat_amanda)(struct sk_buff *skb,
> +				      enum ip_conntrack_info ctinfo,
> +				      unsigned int protoff,
> +				      unsigned int matchoff,
> +				      unsigned int matchlen,
> +				      struct nf_conntrack_expect *exp);

Why is that needed?

