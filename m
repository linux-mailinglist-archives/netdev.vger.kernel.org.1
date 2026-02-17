Return-Path: <netdev+bounces-259139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBzXOmfFlGnCHgIAu9opvQ
	(envelope-from <netdev+bounces-259139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:45:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C614FB83
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4D0D3025E55
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F782C11E9;
	Tue, 17 Feb 2026 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czVXBt4y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258F1A9F91
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357539; cv=none; b=Moq1bz32l8PmEkpoLai2Y/tvSumm7f+GYjicF64UY3Wjv7u1ww92oQl8eIF64EDJrLQ5kQzyGhYo5o7aR1OH1iEGPyWJfQrRwqGEMnUYcJBN782FsQ0qGOxHsaMs/7Glu/LaGYHIJ+/nK48jaW2DMWTqXYx7b4ojHVtgnwxixIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357539; c=relaxed/simple;
	bh=liJupNO+hikrrPNm03EnWqNFJrC5bNB6Hsq9Tb6FQlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhfMcHiJDURD70jNzo8ftoMUFPLQu71+mMKwImTrmM2eZ+8VgQEeBB6hBpw7TSlZvhh3kacaNxfcMU0mTH0c2uXCMwMyYPmNSIodP/A08d5fublkitvNhPPLmbJ/hwkK3/Tp1XNaCSkPJ4zIsC8G0JagJyIzsVu6Yd4hKTgC9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czVXBt4y; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so44917735ad.2
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 11:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771357538; x=1771962338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4GDWAy1Lmnol9Zog/KPdX7ELbbChE9vh/MNN3icrXiQ=;
        b=czVXBt4ys/W3F+6+p2QdTvaxFUSrT+OGowBlh32KYwMX5guNZW/VtbqveysliOWnGU
         fjwwt8wpFr4JDzgChUh2w9v58YBec2HK5jve40fhT/DpZSamNYBPQp0vdzyqBbg0xq1P
         OEfPUIceFJMGJwdBiOgaukaY3e8cdJWLzB+dUaOU9dxkU5Incf0q/DCn8S/zS/Mf3t97
         W2M39w18XpZdoeOIs9/trLZEXavhVvupnA/izKfwOgaIZrbh1WgL9J5lA83E2ERaqZ9P
         j2kqxLTKl/x64Y1bYaTlKWB+bS/ChCN/bhenOTsZM6+6wc74GxvpyFfUP5Z3SQGJVPk2
         JN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357538; x=1771962338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GDWAy1Lmnol9Zog/KPdX7ELbbChE9vh/MNN3icrXiQ=;
        b=hNMFP3BSzdZs0gxUlQo5WWXv5Jhja3REW27x74Rw90dUb3ZLH9zJJPPuXtxE1sxJ2r
         MZRvvG5H4oOTQZrGxKI3bVouavDVpv0Oyj5/IiEXDEFvkTkzjpN0yZ6D0svN+HiuPhSN
         jHPo0yBPcFx4M3xkRKFw62NOSSIY27jrctQt0CYL7GE2lPjg2gWi5kUbOtSJwT7fCATm
         aH2BByD7KCwelOP98x1shEJWDpcahVS0fXewndoqcooTtzpQfgEV9Dw2L5AF69BvDWcC
         9LWAre/oJLjhKozm6fESP0mf4J9tzcnqr5SzpjAd0PUltPHBfgEFVbhoprUTgWQWAjI3
         /roQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/OzKzU5kJhnIl7pLJZc7w0HUnQnfPSLKcJj9/8CXinAlxBtIjEpIYor/ZbHo8Esf/NbfzIMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytstirblFHyuU2X6QYi5QwayFqaSAhYBMKmBrTRaGIaT8e8/wi
	Zc6hPMxsL7sJHTHni9PY79AKCb4Ma0Aeas5Mwe9z61x8F5vr4WQgU/i0
X-Gm-Gg: AZuq6aItw/Oy5aUL4a9v9vz52Nvf28A198RqTuNVSHKMaMEF5t+dFPeclL4bNLtDFTb
	ZdfZ00PYTZkHj8YXpeppXptWjDeY6TlbUwR7bBQLFtXTs3zzrJ0gUJyAjIForK2oar5miwPzEmK
	f6J37KrxcBTn+7DBxe3yCZqeM4LMeE6PnnYZ48Os9skH31USw+7WbMIiuKu0SC3Xi2m85SwNuWl
	VRwZyTr+llQpEBBJT+iTj5RbwJpPckhCCLMvrWXt+XqM+Xi/vZ6ghiJMhD0gJNUyXvgUbqRA2wO
	zJFge4DzXbDm8Gbk2slyA8y5IPJcXlD7BYjTrS4WKo1Wd1JpwbZre6/QSBB7HKaVUj+Z2+IwIvm
	3vnCvDTX6jzcQw2GHu7ViDdhrjKQtk/O3yPQMqieiwV8E+V8HltB8SD+ve0Ak6MoRercNUgDXpR
	M+9eOVtIjEmzDZU4RtwKHyYn/3Y7kIKYjZgGfzKnIiew==
X-Received: by 2002:a17:903:fb0:b0:295:9b73:b15c with SMTP id d9443c01a7336-2ab505c0d5fmr140661085ad.42.1771357537651;
        Tue, 17 Feb 2026 11:45:37 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad416ee045sm31727335ad.90.2026.02.17.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 11:45:37 -0800 (PST)
Date: Wed, 18 Feb 2026 04:45:33 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nate.karstens@garmin.com,
	linux@treblig.org, Julia.Lawall@inria.fr, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH] strparser: Use worker disable API instead of
 cancellation in strp_done()
Message-ID: <aZTFXZcPiu8GBAY7@v4bel>
References: <aZLn2Faeg1FB7XOf@v4bel>
 <aZSxxdNWGLGBj1lD@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZSxxdNWGLGBj1lD@krikkit>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259139-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,garmin.com,treblig.org,inria.fr,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A6C614FB83
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 07:21:57PM +0100, Sabrina Dubroca wrote:
> 2026-02-16, 18:48:08 +0900, Hyunwoo Kim wrote:
> > When strp_stop() and strp_done() are called without holding lock_sock(), 
> > they can race with worker-scheduling paths such as the Delayed ACK handler 
> > and ksoftirqd.
> > Specifically, after cancel_delayed_work_sync() and cancel_work_sync() are 
> > invoked from strp_done(), the workers may still be scheduled.
> > As a result, the workers may dereference freed objects.
> > 
> > To prevent these races, the cancellation APIs are replaced with 
> > worker-disabling APIs.
> > 
> > Fixes: 829385f08ae9 ("strparser: Use delayed work instead of timer for msg timeout")
> 
> That's the correct commit for msg_timer_work, but not for
> strp->work. No race was possible when msg timeout was using a timer?

Of course, the race could also occur when the message timeout was 
implemented using a timer.

> Your second scenario relies only on strp->work so I would think yes.

Using Fixes: bbb0302 ("strparser: Generalize strparser") should cover 
both cases.


> 
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/strparser/strparser.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> > index fe0e76fdd1f1..15cd9cadbd1a 100644
> > --- a/net/strparser/strparser.c
> > +++ b/net/strparser/strparser.c
> > @@ -503,8 +503,8 @@ void strp_done(struct strparser *strp)
> >  {
> >  	WARN_ON(!strp->stopped);
> >  
> > -	cancel_delayed_work_sync(&strp->msg_timer_work);
> > -	cancel_work_sync(&strp->work);
> > +	disable_delayed_work_sync(&strp->msg_timer_work);
> > +	disable_work_sync(&strp->work);
> 
> The change itself looks reasonable.
> 
> >  	if (strp->skb_head) {
> >  		kfree_skb(strp->skb_head);
> > -- 
> > 2.43.0
> > 
> > ---
> > Dear,
> > 
> > The following is a simplified scenario illustrating how each race can occur. Since espintcp_close() does not hold lock_sock(), the race is possible.
> > Although cancel_work_sync(&strp->work) does not appear to be easy to trigger in practice here, it still seems better to fix it as well.
> 
> What about the other users of strp? Only espintcp is racy?

Any subsystem that calls strp_stop() and strp_done() outside of 
lock_sock() is racy.

> 
> If strp_done can run concurrently with __strp_recv, it seems we could
> also end up leaking strp->skb_head, if __strp_recv stores a new one
> after we've cleared the old?

I am not fully sure about this part yet, so I think it should be 
discussed separately in another thread.

> 
> 
> > ```
> >                  cpu0                                cpu1
> > 
> > espintcp_close()
> >                                          espintcp_data_ready()
> >                                            if (unlikely(strp->stopped)) return;
> >   strp_stop()
> >     strp->stopped = 1;
> >   strp_done()
> >     cancel_delayed_work_sync(&strp->msg_timer_work);
> >                                            strp_data_ready()
> 
> In this order, strp_data_ready will see strp->stopped and return
> without doing anything.
> 
> (I'm confused by the "if (unlikely(strp->stopped))" above though,
> maybe you meant espintcp_data_ready -> strp_data_ready -> if (...))

Sorry for the confusion. I accidentally mixed up the call order in the 
strp_data_ready() path. 
More precisely, the scenario is that espintcp_data_ready() → strp_data_ready() 
runs first, passes the if (unlikely(strp->stopped)) check, and only after 
that strp->stopped = 1 is set.
```
                 cpu0                                cpu1

espintcp_close()
                                         espintcp_data_ready()
                                           strp_data_ready()
                                             if (unlikely(strp->stopped)) return;
  strp_stop()
    strp->stopped = 1;
  strp_done()
    cancel_delayed_work_sync(&strp->msg_timer_work);
                                             strp_read_sock()
                                               tcp_read_sock()
                                                 __tcp_read_sock()
                                                   strp_recv()
                                                     __strp_recv()
                                                       strp_start_timer()
                                                         mod_delayed_work(strp_wq, &strp->msg_timer_work, timeo);
```
```
                 cpu0                                cpu1

espintcp_close()
                                            espintcp_data_ready()
                                              strp_data_ready()
                                                if (unlikely(strp->stopped)) return;
  strp_stop()
    strp->stopped = 1;
  strp_done()
    cancel_work_sync(&strp->work);
                                                if (strp_read_sock(strp) == -ENOMEM)
                                                  queue_work()
```


> 
> >                                              strp_read_sock()
> >                                                tcp_read_sock()
> >                                                  __tcp_read_sock()
> >                                                    strp_recv()
> >                                                      __strp_recv()
> >                                                        strp_start_timer()
> >                                                          mod_delayed_work(strp_wq, &strp->msg_timer_work, timeo);  
> > ```
> > ```
> >                  cpu0                                cpu1
> > 
> > espintcp_close()
> >                                           sk->sk_data_ready()
> >                                             espintcp_data_ready()
> >                                               if (unlikely(strp->stopped)) return;
> >   strp_stop()
> >     strp->stopped = 1;
> >   strp_done()
> >     cancel_work_sync(&strp->work);
> >                                               if (strp_read_sock(strp) == -ENOMEM)
> >                                               queue_work()
> 
> Here the problem would be if we enter do_strp_work after all the
> socket data has already been freed? Otherwise again the test on
> strp->stopped will make do_strp_work return early. (this would be
> unexpected but should be safe)

If the worker is scheduled after the cancel call, then during 
espintcp_close() → tcp_close(), the sk will be freed and the ctx 
will be freed as well. 
As a result, the kworker will access the freed ctx->strp. 
This access to the freed ctx happens before the actual worker 
handler is called, so the problem occurs regardless of the 
condition checks in do_strp_work().
```
worker_thread()
  assign_work(work, &worker->scheduled)
    move_linked_works(work)    // work: ctx->strp->msg_timer_work or ctx->strp->work
```

> 
> > ```
> > 
> > Best regards,
> > Hyunwoo Kim
> 
> -- 
> Sabrina

