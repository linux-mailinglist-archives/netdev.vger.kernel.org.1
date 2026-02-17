Return-Path: <netdev+bounces-259102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIRyOFCblGmcFwIAu9opvQ
	(envelope-from <netdev+bounces-259102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:46:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8314E613
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C95403009F85
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EED36CDF5;
	Tue, 17 Feb 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7h3e4qf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CA28641E
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346766; cv=none; b=FgaqfrGKTY61aBtWswF1Gy7ecG3l6K4GcUQDvmXrQQjID2ItwQiswrhEUxoE4bDvta/rPKz68Am50OO80aBUoRM6VVj/5HclJcDCamnf2vcO/JA54wBXGebHPXygi9FLeZNFc8aKEMJ2Cmv6sUII5xafCSbN5sQpv8NRPSsHlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346766; c=relaxed/simple;
	bh=v4gB6lc6deEYfpIeGFrVruWWO0C/x1Nf3DUOnv/lrMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byok69XjiSXJ2qUeTUqDqPmts/P6IcG/X2xhm8YE61R3OaWQnmyCVatirjMCwOl7sVkkAh2j8JBbUzTSUYMripT5s59aeWrYBrBW8GSEwdtuGWib77kf6abQDEM2sAuNufyroJG7/9eyCb2DBGkYAvkBWgx1SC153xzmqiDou+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7h3e4qf; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c6c444e89bcso1444184a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771346764; x=1771951564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9F5w7PR9UkiGGomxd2i+vz94pJcHRr8WzyNuGNMq8c=;
        b=d7h3e4qf9/tycg4TVnDmefcLbpF9xyOWm5D2lKH/d2p7bN4CITuL5LPmQi94U9UuBV
         v5Z8aFrhZPzFeQVxB0FZoKrauMw3wSSEsvnAKLGkomx8AYQndNB7Gl3N1MJRlZqThBcH
         BU+zAp8ve9+vB91MlOmezbqmqd9cZGKkjmI09h4xVI4rz8mgozfCI1c2B9b8DyGLlQ5F
         ExfZmvor+VbHtI2SeKRQtalyKNGcRg8Qn0ECpjUFKm0ckKkdjBNtVvb0VZNlv0jV9U26
         GY3N+oVxneRsm4xbPaX/KAxQAXF9ecEcP1dDP18ysNdh9akPMU3BVR+yUDTe8HEi2sQ1
         Xjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346764; x=1771951564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9F5w7PR9UkiGGomxd2i+vz94pJcHRr8WzyNuGNMq8c=;
        b=YBspJaiaafmxfJn63IVFsJZQPWRGe7NXWU7IqfmxDpFVI3v25weF0NVJfVtyN32kUR
         MVy8YIhitU5/M8hbOb7I3mRmLidhdXSoddEy3OtQkde0d2lsN4TxZccdganoz3VO4aHE
         D1ywWWsHIuRbSyQFK6ScYe3rAq6Pb/V+fs/2VgIshkgbRGo9+DH6B6Ogl6cg5ZnonFOA
         NWFl7vxFfvIqbkdsFryzKIRV5duFfLBYOcfi6g+2c+FWfngAvwXtNo7aeATKGzU8GP4w
         oosOGrI0/dJ4FQs0hzqQkCmWl3vAdf8C/w1DwgzPgTg2AD/D4VjExMaJaT7WN9KguV6H
         AmPw==
X-Forwarded-Encrypted: i=1; AJvYcCXPULgcvYb3NirOoHUrUXMLqfTsfj0yRl3P/Bk8CSjs/G2j+tOp6lTJvz9JS4MY40w9VkDDsu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5E398i8oHLwQu6HdMb4uaS0BJAXTkU0AGZ3hY9t7AytQUHTc
	SFiDvp7ToBlFVip9HYK72iA4wlBdRX7IeNDA0tpfOeFjrjJf4NVqf9hF
X-Gm-Gg: AZuq6aK7ZxTVnA5/d9QLhGB78yf8R1oi3BI3biOgZMbJFBBpeydT81lLIECSKFVk0QW
	PsH+wzWYdIF9VQ+aN+yumFnoWiYTnhQkkKQrXPJpV5hXJyr5JffxlRgBdiADdQrWUYYXt5itJ7q
	L0+Qd3PJo6z2mJ+7jXenFRf20C7T0/nsd8ou9v+Lq/gMAyc3NthoucQq6b2kzfSmJF1/5gw3BDk
	Ha7PKpRqEpMYofsTOsH4epgUoRnQrrELTrKxYF4NT92JO4qj295m+opKihHSHouqLYUusY68T1Z
	q882kn7V0F6NfYGgBAV/jnHvtEOVtPR9rztYWLKOudk1g92p0GVx4+YhFkaFS6ATpWy410lHL/c
	dS0GsboLoUx1iztdeIJvVl3/7Hcb3WoWjJXl0DbNvD57fuNOz1kcTHvKftxICytgy0qHeyj9XuE
	qNi7bJZWQ8S8KJjnykBkuNJyBiHjNDG8h4uwi5HdvN+Q==
X-Received: by 2002:a17:90b:3d12:b0:356:5cf2:eb77 with SMTP id 98e67ed59e1d1-356aaa98c65mr11130190a91.2.1771346764309;
        Tue, 17 Feb 2026 08:46:04 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a84970bfsm9662178a91.3.2026.02.17.08.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 08:46:03 -0800 (PST)
Date: Wed, 18 Feb 2026 01:46:00 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] net: tls: Use disable_delayed_work_sync() instead of
 cancel_delayed_work_sync() in tls_sw_cancel_work_tx()
Message-ID: <aZSbSOVuRgkjeezg@v4bel>
References: <aZLotq3aZY0b-dI8@v4bel>
 <aZSLHaFj7k8DPmLG@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZSLHaFj7k8DPmLG@horms.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259102-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46E8314E613
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 03:37:01PM +0000, Simon Horman wrote:
> On Mon, Feb 16, 2026 at 06:51:50PM +0900, Hyunwoo Kim wrote:
> > After cancel_delayed_work_sync() is called from tls_sk_proto_close(), 
> > tx_work_handler() can still be scheduled from paths such as the 
> > Delayed ACK handler or ksoftirqd.
> > As a result, the tx_work_handler() worker may dereference a freed 
> > TLS object.
> > 
> > To prevent this race condition, cancel_delayed_work_sync() is 
> > replaced with disable_delayed_work_sync().
> > 
> > Fixes: f87e62d45e51 ("net/tls: remove close callback sock unlock/lock around TX work flush")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> 
> Hi Hyunwoo,
> 
> Thanks for your patch(es).
> 
> Some feedback on process from my side.
> You can read more about that at
> https://docs.kernel.org/process/maintainer-netdev.html
> 
> * I think it would be good to mention how this problem was found.

Hi Simon,

Thank you for the feedback.

This issue was found during a manual code audit. I will add this 
information to the commit message.


> 
> * As a bug fix for code present in the net tree, it should be targeted
>   at that tree like this.
> 
>   Subject: [PATCH net]: ...
> 
> * Looking over git history, it seems that an appropriate prefix
>   for patches for this code is 'tls: '
> 
>   Subject [PATCH net]: tls: ...
> 
> * Also, please try to make the subject a bit more succinct
> 
> > ---
> >  net/tls/tls_sw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 9937d4c810f2..b1fa62de9dab 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -2533,7 +2533,7 @@ void tls_sw_cancel_work_tx(struct tls_context *tls_ctx)
> >  
> >  	set_bit(BIT_TX_CLOSING, &ctx->tx_bitmask);
> >  	set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
> > -	cancel_delayed_work_sync(&ctx->tx_work.work);
> > +	disable_delayed_work_sync(&ctx->tx_work.work);
> >  }
> >  
> >  void tls_sw_release_resources_tx(struct sock *sk)
> > -- 
> > 2.43.0
> > ---
> > 
> > Dear,
> > 
> > The following is a simplified scenario illustrating how each race can occur. Since tls_sw_cancel_work_tx() does not hold lock_sock(), it can race with tls_write_space().
> > ```
> >           cpu0                                             cpu1
> > 
> > tls_sk_proto_close()
> >   tls_sw_cancel_work_tx()
> >                                                     tls_write_space()
> >                                                       tls_sw_write_space()
> >                                                       if (!test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
> >     set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
> >     cancel_delayed_work_sync(&ctx->tx_work.work);
> >                                                       schedule_delayed_work(&tx_ctx->tx_work.work, 0);
> > ```
> 
> I think that the text above would be best included in the patch description.
> At least for me it is fundamental to understanding the problem.

Understood. I will add the race scenario description to the patch.

> 
> > 
> > Best regards,
> > Hyunwoo Kim
> > 
> 
> I see three similar patches on the mailing list.
> The comments above go for them too.
> And It would probably be useful to just handle one at a time,
> to allow for proper feedback. Or bundle them in a patchset.

Since the core of this bug pattern is espintcp, I will submit a revised 
espintcp v2 patch shortly. 
I would appreciate it if you could review the espintcp v2 patch. 
Once the espintcp review is done, I will apply the feedback to the 
remaining strparser and tls patches as well.

Best regards,
Hyunwoo Kim

> 
> -- 
> pw-bot: changes-requested

