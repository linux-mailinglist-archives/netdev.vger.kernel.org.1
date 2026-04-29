Return-Path: <netdev+bounces-282468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ISmMx5S8mlGpgEAu9opvQ
	(envelope-from <netdev+bounces-282468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:46:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3A4994B1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5284D30022E2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D060633031C;
	Wed, 29 Apr 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEZD1QBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50237C14A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488410; cv=none; b=hDE/2f9DgODrBWintyQ+wVqfiC+QGYuzCQZ+CoJFaZ8erDBcpKX8ZEtJGXb/IXDLwWEcvDtsUJt6b719qK9GdOnaQ/eK6HgelOvgPe9WMlfG8EJz/qFQ7pNvFXPNYg/Eq2bdWeY+LurvMGBaiAHsEfoNJ39YfTqOhwXvM1YGNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488410; c=relaxed/simple;
	bh=YxaC4w6FTlCKs2WmcLJn5H0MVoMr9sL61ly2AepPPlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmMU0hD2XlGnIH6JRMcC30cOs/bBWMrS5V6Zz6kfNBug4A8tWf0Yx71I540ILgLM/M8tb7iwPdLKsksCaA604uFhZ0LBhhzNq0sY4QwyvVs/Gy2RxlzZlB+MeQwFcQYvLAJucr5kCjfSoSRxW336QkP94KrwW8aSRjcSlNP76Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEZD1QBx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so50555a91.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777488409; x=1778093209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbFC/WpUxSc+aDwFY31WGqtvojwgOPL4vm/ZT+3jh1U=;
        b=KEZD1QBxpcbMaUA4JOFIuuXSr/I+yovlPJEjmVMfuKWdCBzUkc2lbInHgu9XJ4azan
         eaMDpkgBoaY0JP1k4njBiEUkPcFQO9kXpbMgbC8loiMBicY7+6ArOWmsoiXSzrLEncts
         nhXo29mzHMwYA2rhqr8NrosWM29Uxhc7QQ9P5gAtkfZZ/lzJY1R/f7KjGH2nPi/GGCk6
         hVONL+RGdqVOKBZvMywWIqSZVwQ+wlOA5dsqU16lHYkASvnNP3A0vhk+rFgVp33u4SYM
         qs8igXmNnD27cQEt+SWrKcp7ZAdK9Oc5h7+BejPs9HN8m/x5ua4jRrYY0Uhpjch8iPpg
         nQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777488409; x=1778093209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbFC/WpUxSc+aDwFY31WGqtvojwgOPL4vm/ZT+3jh1U=;
        b=BT6xLBbotlwiahGToSbyD6TcNgsunM2aZbjKxsiF1w0S/Rxj7tofmAgY0S9unCZRSA
         q+o5iOxVUnVlqbw24AmSDhrL2FPNlBdjeQWY//lsyv1W0SeHpeCSzDvcxd5euIz6EGLl
         COU9OnIsYTcFzmaHeE9161qhhQWAkXkB84OnYFnAOEZEbgvu7TxmHTjTtUKQXukbfCVq
         zsx8FeJB7ClR/lOrhv0ADCJ1ReSbr5RuDUSPgDkpXprhx/A8LnZTrtF+DBg1iKRm4nT/
         Tkf7JpEkQ/x4qO3nimkdq1e7PWelensUtnIpGfQgRgc+jUQM9xBoHUM4nE8P/AWS5LhU
         65bw==
X-Forwarded-Encrypted: i=1; AFNElJ8HKwkLfGo/MKhgJDG1vdVQgeEYX+QJQHK2MR4rzPXiuEZgoeekcH+rvGkX6nxihozR7WrfSF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7fV9kA3NrV8Do2wsMnQituFirBmE57apdfueHj9SpbRnTZy0
	l3kj+SMuJRNYrVzjCVG7v/rfYenxy6jVOxBaKN7yJFrjToCI4z9kuuKJ
X-Gm-Gg: AeBDievHyqMmuAhKtmDexzY+C4R2UyI3ToVdqEx5W999CTKfAkIrd4anqwWMfenGGu7
	B+bTEQzkTkmQNYNOx+ekbxJX5Tw/QFQ4o/dlIVbUWDiNWtYUxXlUW6srMR+kwkgfOhlrghyBYL8
	P5Z0MQ00UIl4sjpwMJTyplMbxZfDvjB1T0FBQUUtN3RQBb2wRMZ0j/R6iOaHAy01+mC2qeYHCPH
	gn/2JgV0uZVM29OIFR1RB9AzqT9u9NsLcS/lpaMdzZzOWWuEd6D/pPJagA3bNAc3AzK5JTiEJUb
	iy+2PmZu2p//GdvWA4+JoVQallTy3sF2W6O73EWrpLhbDWwVmgfIqmfcU/DsvudYuj3jGs5Kc8o
	lKs0EXTKmYdp2Mae7QXHvFR2AV7VyTI9rfsXn6i9f8ugks/+iONi/mTDDR/8fO5VxoCyfv3piAR
	RHLzivRvFHDkWT+gu1TCBx09MwFs1v+Z6fAY+al5KEtDOSR8eN9VtrHw==
X-Received: by 2002:a17:903:b83:b0:2b7:ab8e:53b7 with SMTP id d9443c01a7336-2b9874078a2mr48952485ad.20.1777488408483;
        Wed, 29 Apr 2026 11:46:48 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988963ed0sm29612165ad.65.2026.04.29.11.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 11:46:47 -0700 (PDT)
Date: Thu, 30 Apr 2026 03:46:44 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <afJSFEU0SSlYCPxJ@v4bel>
References: <aZyMejqTbkI7o_VM@krikkit>
 <aaDATohaW62X_pxk@v4bel>
 <aaYY6UiXSppOig9Q@krikkit>
 <aaY-TbPsNxo6toSr@v4bel>
 <aaoTVMhnY5FKMrem@krikkit>
 <aaobmK6d_xd9ZXGj@v4bel>
 <aaqovyrmd5pJtZKq@krikkit>
 <aaq9TgFpsjn9XWAC@v4bel>
 <abDr-fSP9EtP7uEQ@v4bel>
 <ab2bA-g2qnwhdWbq@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2bA-g2qnwhdWbq@v4bel>
X-Rspamd-Queue-Id: 69E3A4994B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282468-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,inria.fr,treblig.org,garmin.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Sat, Mar 21, 2026 at 04:07:47AM +0900, Hyunwoo Kim wrote:
> On Wed, Mar 11, 2026 at 01:13:45PM +0900, Hyunwoo Kim wrote:
> > On Fri, Mar 06, 2026 at 08:41:02PM +0900, Hyunwoo Kim wrote:
> > > On Fri, Mar 06, 2026 at 11:13:19AM +0100, Sabrina Dubroca wrote:
> > > > 2026-03-06, 09:11:04 +0900, Hyunwoo Kim wrote:
> > > > > On Fri, Mar 06, 2026 at 12:35:48AM +0100, Sabrina Dubroca wrote:
> > > > > > Sorry for the delay, I wanted to think about the race condition a bit
> > > > > > more.
> > > > > > 
> > > > > > 2026-03-03, 10:50:05 +0900, Hyunwoo Kim wrote:
> > > > > > > On Tue, Mar 03, 2026 at 12:10:33AM +0100, Sabrina Dubroca wrote:
> > > > > > > > 2026-02-27, 06:51:10 +0900, Hyunwoo Kim wrote:
> > > > > > > > > On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> > > > > > > > > > 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > > > > > > > > > "strp stopped" is not really enough, I think we'd also need to reset
> > > > > > > > > > the CBs, and then grab bh_lock_sock to make sure a previously-running
> > > > > > > > > > ->sk_data_ready has completed. This is what kcm does, at least.
> > > > > > > > > 
> > > > > > > > > It seems that this is not something that should be handled inside strp itself, 
> > > > > > > > > but rather something that each caller of strp_stop() is expected to take care 
> > > > > > > > > of individually. Would that be the right direction?
> > > > > > > > 
> > > > > > > > Agree.
> > > > > > > > 
> > > > > > > > > It also appears that ovpn and kcm handle this by implementing their own callback 
> > > > > > > > > restoration logic.
> > > > > > > > 
> > > > > > > > Right. I tried to look at skmsg/psock (the other user of strp), but
> > > > > > > > didn't get far enough to verify if it's handling this correctly.
> > > > > > > > 
> > > > > > > > > > Without that, if strp_recv runs in parallel (not from strp->work) with
> > > > > > > > > > strp_done, cleaning up skb_head in strp_done seems problematic.
> > > > > > > > > 
> > > > > > > > > From the espintcp perspective, how about applying a patch along the following lines?
> > > > > > > > 
> > > > > > > > This is what I was thinking about, yes.
> > > > > > > 
> > > > > > > In my opinion, it might be cleaner to split the espintcp callback restoration work into 
> > > > > > > a separate patch, rather than merging it into the strparser v3 patch. What do you think?
> > > > > > 
> > > > > > Sure. But once espintcp is fixed in that way, can the original race
> > > > > > condition with strparser still occur? release_sock() will wait for any
> > > > > 
> > > > > If the espintcp callback restoration patch is applied, the strparser
> > > > > race should no longer occur in espintcp.
> > > > > 
> > > > > > espintcp_data_ready()/strp_data_ready() that's already running, and a
> > > > > > sk_data_ready that starts after we've changed the callbacks will not
> > > > > > end up in strp_data_ready() at all so it won't restart the works that
> > > > > > are being stopped by strp_done()?
> > > > > > 
> > > > > > It's quite reasonable to use disable*_work_sync in strp_done, but I'm
> > > > > > not sure there's a bug other than espintcp not terminating itself
> > > > > > correctly on the socket.
> > > > > 
> > > > > That said, the _cancel APIs in strparser still appear to carry some
> > > > > structural risk, so it might still make sense to switch to the _disable
> > > > > APIs for the benefit of other strp users or potential future callers.
> > > > 
> > > > Not really. Every user of strp that is open to the strp_recv vs
> > > > cancel_* race is also open to the strp_recv vs free race, so switching
> > > > from cancel_* to disable_* is only a partial fix.
> > > > 
> > > > But if we took and released the socket lock in strp_done, we would
> > > > solve the issue for all users even without resetting the callbacks?
> > > 
> > > Looks good to me. With this change, it seems the issue can be resolved
> > > not only for espintcp but for all strp users.
> > > 
> > > When strp_stop() runs first:
> > > ```
> > >                  cpu0                                cpu1
> > > 
> > > espintcp_close()
> > >   strp_stop()
> > >     strp->stopped = 1;
> > >                                          espintcp_data_ready()
> > >                                            strp_data_ready()
> > >                                              if (unlikely(strp->stopped)) return;
> > >   strp_done()
> > >     lock_sock();
> > >     release_sock();
> > >     cancel_delayed_work_sync(&strp->msg_timer_work);
> > >     kfree_skb(strp->skb_head);
> > > ```
> > > 
> > > When strp_data_ready() runs first:
> > > ```
> > >                  cpu0                                cpu1
> > > 
> > >                                          espintcp_data_ready()
> > >                                            strp_data_ready()
> > >                                              if (unlikely(strp->stopped)) return;
> > > espintcp_close()
> > >   strp_stop()
> > >     strp->stopped = 1;
> > >   strp_done()
> > >     lock_sock();
> > >                                              strp_read_sock()
> > >                                                tcp_read_sock()
> > >                                                  __tcp_read_sock()
> > >                                                    strp_recv()
> > >                                                      __strp_recv()
> > >                                                        head = strp->skb_head;
> > >                                                        strp_start_timer()
> > >                                                          mod_delayed_work(&strp->msg_timer_work);
> > >                                                        ...
> > >     release_sock();
> > >     cancel_delayed_work_sync(&strp->msg_timer_work);
> > >     kfree_skb(strp->skb_head);
> > > ```
> > > In both cases, the race does not appear to cause any problem.
> > > 
> > > > 
> > > > @@ -503,6 +503,10 @@ void strp_done(struct strparser *strp)
> > > >  {
> > > >  	WARN_ON(!strp->stopped);
> > > >  
> > > > +	lock_sock(strp->sk);
> > > > +	/* sync with other code */
> > > > +	release_sock(strp->sk);
> > > > +
> > > >  	cancel_delayed_work_sync(&strp->msg_timer_work);
> > > >  	cancel_work_sync(&strp->work);
> > > >  
> > > > 
> > > > 
> > > >  - strp->stopped so any new call into strp_data_ready will not do anything
> > > > 
> > > >  - lock/release need to take bh_lock_sock so any existing call to
> > > >    strp_data_ready will have to complete before we move on to cancel*_work
> > > > 
> > > > 
> > > > 
> > > > Or maybe the requirement should be that strp_stop has to be called
> > > 
> > > From my perspective, adding lock_sock() inside strp_done(), as in the
> > > patch above, looks cleaner.
> > > 
> > > > under lock_sock() (or even just bh_lock_sock), but again I can't
> > > > figure out if that's ok for sockmap.
> > > 
> > > sockmap/psock has a more complex call stack compared to other strp
> > > users, so I'm also not entirely certain about that part.
> > 
> > I looked into the sockmap/psock side. sk_psock_strp_data_ready() is protected 
> > by read_lock_bh(&sk->sk_callback_lock), and during teardown sk_psock_drop() 
> > performs callback restoration and strp_stop() under 
> > write_lock_bh(&sk->sk_callback_lock), so sockmap/psock doesn't have this race 
> > to begin with.
> > 
> > As for introducing this patch, in sockmap/psock strp_done() is only called 
> > from sk_psock_destroy(), which is scheduled via queue_rcu_work() and runs 
> > on system_percpu_wq after an RCU GP, so no locks including lock_sock are held 
> > at that point. And since lock_sock is released before cancel_work_sync, 
> > there's no circular dependency with do_strp_work/strp_msg_timeout either. 
> > So this patch shouldn't introduce any new issues for sockmap/psock.
> 
> Hi Sabrina,
> 
> Could you please provide an update on the status of this patch?
> 
> 
> Best regards,
> Hyunwoo Kim

Dear Sabrina,

This issue has been public for some time and seems to be gradually 
fading from attention.

Could you please let me know the current status of the work on this?


Best regards,
Hyunwoo Kim

> 
> > 
> > > 
> > > > 
> > > > 
> > > > > With that in mind, perhaps the direct fix for this race could be handled
> > > > > in the espintcp callback restoration patch. For the strparser patch, I
> > > > > could instead adjust the commit message to reflect that it removes a
> > > > > potential hazard by replacing the _cancel APIs with the _disable
> > > > > variants, and resubmit it in that form.
> > > > 
> > > > I'm not going to nack a patch doing s/cancel_/disable_/ in strp_done,
> > > > but it doesn't fully solve the race condition if the caller isn't
> > > > doing the right thing, and it doesn't do anything if the strp user is
> > > > handling the teardown correctly.
> > > 
> > > I agree with your point there. Still, after the core patches addressing
> > > this race are applied, I plan to resubmit the _disable patch with an
> > > updated commit message. I think applying that change is still beneficial.
> > > 
> > > 
> > > Best regards,
> > > Hyunwoo Kim

