Return-Path: <netdev+bounces-269348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIv1AB2vu2k8mgIAu9opvQ
	(envelope-from <netdev+bounces-269348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:09:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 557562C7A9A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F883304CCEE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAF03A6EFD;
	Thu, 19 Mar 2026 08:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA030F7F3;
	Thu, 19 Mar 2026 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907500; cv=none; b=JtoaXHjBZP+2ki/Oq4xfkHSuNmksvN4gT613UrL6Ng93tkGez4FTJTixPdCxoXHyHfCv9/9fGFR59HL9l9YXUgB+MBzIV+2XzV0c0WUVgp9+sgfwHYwKZ/8FQQZt9ibAVvkQ43a3DYUGNRM8R7LrDzSdJgTcfTMkDcyw2yj0cvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907500; c=relaxed/simple;
	bh=yakZKk05f+i8hX5TLEr04Cl5Dvjv6Wi2grnlOJUbXGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsPnxIi5GJd3o5LRn0NNihTQT/t9lzKV+dcXpsmSKq2Y/uKcAVAkVzTrxHCmfjUT4ORuuuuejHFBc6EITjiKwe5ysAurFbWH+jpvpTqXfSeqJzeqFI+0FMc34FgSZItK6AGmE2hRQMs8mU+R5cDo06usnvZTXBWJcolHqWmJCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 18CFE606E1; Thu, 19 Mar 2026 09:04:56 +0100 (CET)
Date: Thu, 19 Mar 2026 09:04:56 +0100
From: Florian Westphal <fw@strlen.de>
To: bestswngs@gmail.com
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH net] nfnetlink_osf: validate individual option lengths in
 fingerprints
Message-ID: <abuuKHbFhnwZ4vwM@strlen.de>
References: <20260319073243.1176330-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319073243.1176330-2-bestswngs@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269348-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.425];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 557562C7A9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bestswngs@gmail.com <bestswngs@gmail.com> wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> nfnl_osf_add_callback() validates opt_num bounds and string
> NUL-termination but does not check individual option length fields.
> A zero-length option causes nf_osf_match_one() to enter the option
> matching loop even when foptsize sums to zero, which matches packets
> with no TCP options where ctx->optp is NULL:

Would you mind if i squash:

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -302,6 +302,7 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
 {
        struct nf_osf_user_finger *f;
        struct nf_osf_finger *kf = NULL, *sf;
+       unsigned int tot_opt_len = 0;
        int err = 0;
        int i;

@@ -320,10 +321,14 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
                return -EINVAL;

        for (i = 0; i < f->opt_num; i++) {
-               if (!f->opt[i].length)
+               if (!f->opt[i].length || f->opt[i].length > MAX_IPOPTLEN)
                        return -EINVAL;
                if (f->opt[i].kind == OSFOPT_MSS && f->opt[i].length < 4)
                        return -EINVAL;
+
+               tot_opt_len += f->opt[i].length;
+               if (tot_opt_len > MAX_IPOPTLEN)
+                       return -EINVAL;
        }

        if (!memchr(f->genre, 0, MAXGENRELEN) ||

There is a runtime check (WTF) for this already, but arguably it
better belongs here.

