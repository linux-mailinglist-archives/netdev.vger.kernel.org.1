Return-Path: <netdev+bounces-281743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC0KLph+8GmUUAEAu9opvQ
	(envelope-from <netdev+bounces-281743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:32:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49056481797
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08B11302F692
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F1535AC0E;
	Tue, 28 Apr 2026 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXdtRjob"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308432DF12F;
	Tue, 28 Apr 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368198; cv=none; b=TSMn6oEqcv++MNId+KpXsHLtAIpQad0v3jyNMnWDys/+TwaszmbzB7TKWAMD8iBBs5z78rEO8krKet+fYSvvt5YnZigCKiyMDNTHRxoOzlKUJItjSdBJJRJMAINpWtg+Q7IXmPdXFNLDczpg/r4hAAH7pR82Gtts3qwUy9B4bX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368198; c=relaxed/simple;
	bh=ASWifXhbZTozEOdrs+66Pjf8bwkBn3UUp/Y7mK5dhI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+TtxE6qyfRBTg0w5gzkM8TXFBfPJMcFsOb0Z0v8HC811WkFcxcpK4+/z+W2JUlRNyrExDDAuOsdgGoa2Ypte56r4TlSX8jFxBGLpcDQNLlxjGw3TgDZ+HEapSDbVQc8+6tY8yONIPYBoVqEKxR3m7y1uW7f5EIqTVUgLYQl8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXdtRjob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020B6C2BCAF;
	Tue, 28 Apr 2026 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777368197;
	bh=ASWifXhbZTozEOdrs+66Pjf8bwkBn3UUp/Y7mK5dhI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXdtRjobck1OUgzVvakqApcNDBubeoCDdPcbG6FLTJI/Dj2FjMVHAR5sb4eVZMLeh
	 VFNpM5IvVTlU4oPG4mCEmrdJOT5ysUQnBw0IohSxVyyfpMiTbLVwx3ASQm3A5RYNRQ
	 tQ3oD75ZjdDGNF9oQ8/EQl2BQh3SQDx8rfJMTCp/BGb8X/tdpLYKNWV8+o7nDvcKrx
	 sbtv5kW2Ya2BOF6dLxDKEtVlEcZLpZqVtUDW/LwamuxAUaWOyDgaJkcbQS/w6I1jw+
	 kSut/pr45nIFmOeHeWMevkt5ZFTiUe8VXHoJD+24MUbj/jnW5VKHkBZ7P/KGDEfz/l
	 OWYbjOogbzlPA==
Date: Tue, 28 Apr 2026 10:23:12 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, k-keiichi@bx.jp.nec.com,
	satyam@infradead.org, akpm@linux-foundation.org,
	thepacketgeek@gmail.com, asantostc@gmail.com, gustavold@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net 3/3] netconsole: propagate device name truncation in
 dev_name_store()
Message-ID: <20260428092312.GO900403@horms.kernel.org>
References: <20260423-netconsole_ai_fixes-v1-3-92b8b7de9a2c@debian.org>
 <20260426083904.1130399-2-horms@kernel.org>
 <ae85UEWf7dgJtmeS@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae85UEWf7dgJtmeS@gmail.com>
X-Rspamd-Queue-Id: 49056481797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281743-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,sashiko.dev:url]

On Mon, Apr 27, 2026 at 03:26:29AM -0700, Breno Leitao wrote:
> On Sun, Apr 26, 2026 at 09:39:05AM +0100, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > netconsole: propagate device name truncation in dev_name_store()
> > 
> > This commit rejects interface name writes that exceed the size of the
> > destination buffer to avoid silently truncating names and binding to
> > unintended devices.
> > 
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > index 4bef003d9df64..3914fb90f9afd 100644
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -816,6 +816,9 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
> > >  {
> > >  	struct netconsole_target *nt = to_target(item);
> > >  
> > > +	if (count >= IFNAMSIZ)
> > > +		return -ENAMETOOLONG;
> > > +
> > 
> > Does this check incorrectly reject valid maximum-length interface names when
> > written with a trailing newline?
> > 
> > Standard userspace tools like echo append a trailing newline when writing to
> > configfs attributes. If userspace writes a 15-character name, the count will
> > be exactly 16 bytes.
> > 
> > Since IFNAMSIZ is 16, the condition count >= IFNAMSIZ evaluates to true,
> > causing dev_name_store() to reject the valid input with -ENAMETOOLONG.
> > 
> > Prior to this patch, strscpy() safely truncated the trailing newline by
> > copying the 15 characters and a NUL terminator.
> 
> That is a valid issue, if someone is using a 16-byte ifname, it will fail, for
> instance:
> 
> echo eth0123456789012 (15 chars) writes 16 bytes including the trailing \n
> 
> With IFNAMSIZ=16, a valid 15-character interface name written via echo arrives
> as 16 bytes (15 chars + \n), and the count >= IFNAMSIZ check rejects it — a
> regression compared to the prior strscpy() + trim_newline() behavior, which
> silently dropped the newline.
> 
> I think a better approach would be:
> 
>   size_t len = count;
> 
>   if (len && buf[len - 1] == '\n')
>       len--;
>   if (len >= IFNAMSIZ)
>       return -ENAMETOOLONG;
> 
> That keeps the length check consistent with what trim_newline() does to the
> stored string.
> 
> I will send a v2.

Thanks. The approach above looks good to me.

