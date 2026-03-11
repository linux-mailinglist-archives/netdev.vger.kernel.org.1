Return-Path: <netdev+bounces-266457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKfGBQnssGmRogIAu9opvQ
	(envelope-from <netdev+bounces-266457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:14:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7E925BDEA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F0783026076
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3108B30B53C;
	Wed, 11 Mar 2026 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doa5jq9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11982652B0
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202436; cv=none; b=p2xrc/G7S/CsGIj65ZMBFI8VuitHuvXheQhYwsSVx3GuitM2mc9DqTRBnJam9xHqYFhM73K92GCaOqhAW2UCH/JsrO/aOyaa2UArssIePQrgRIbnWxTMKpY3QPX2dfo54mdKOgbA8ZZbyxzEi2qF3UvTpWXcw85LiIHgVxgoD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202436; c=relaxed/simple;
	bh=F1wccka4/IVjs47SRcYIQsS0rSIGyYYTeKgAA+X4nQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2j7Y8LoyuxZ//GvIA0fi4156cv//L/iSbU8nQ4NngQanFwwmZ+GG8hknEc5aO5bs1hl++wKqbl6oBuh+R2r6qOrHAcGB4jYph/Z99UXryXB8sCGHIcglh120Rc9hmmU+EOKbLOdA8lFjbxkKIVF4GFiUVMJPNKm54lJdfUgP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doa5jq9m; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82976220e97so3812869b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773202434; x=1773807234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M1rxu1eE+G3b8F5BmuYrI2Pybz0goGRW+iWcKyljidM=;
        b=doa5jq9mrC7UURl8vWmzgVDwxAAL9KBTKgaZhA1sbABA5G8P3E7EuJWf78v3q6R3tu
         tMrPUwx5fPYk/31XA1JksFtAz6cAtWR2GXjTafH2drB0Z1YJundkpoPsCzlAIwEfyAnL
         Thfg7iwxPRP5/auLFRnnpaWhXLfX7Cpv7zSOU1Yz4BifM1KMxN5bzZqML/lX7OGwB7gu
         yBEPIkOZWRF7X/2ombjrp/fD9Actwk4AFyQ3HiXGWHBrH/k0aNLgIkAM/2QYNqIG+euT
         dcOE2MITg31Gj7n0zXIsy2FNeEkIFLKKZc47l6i6SbhclJlhFycodePh2tqPW1FCBKm5
         fxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773202434; x=1773807234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1rxu1eE+G3b8F5BmuYrI2Pybz0goGRW+iWcKyljidM=;
        b=L64DXdpYXWaawkTRUvooLrwF+peFm8c54ndxpKVr4jI1Tn9AHVyPSokPSeyMeMAjFJ
         hApySM0j6yCXg/MYmTYZkUc7KRzj96t/wU10poCH+IC8s4Uqutnm0KOJix7zmzBk1czk
         OOUSWA/js/+IgWuOr6xzdBKxijrZlKjo2LHDqF9x/evIBhsqaQ8iblPU8FqTa1GR2Of8
         kLiDb87MYuFIETZxBsJvgqv0AmmC95SEiKjgyo3MMnDxgMOxJJofYnLVUzW31hWuIH8E
         dH0uuKsLpWpcyEX5buNsZqz2dXndzUQhrUPuthM54/zIeclBzlQcfuC2cJgeFnlDpQ9O
         4ZIA==
X-Forwarded-Encrypted: i=1; AJvYcCUYGruZd6SP8AbVOCoKiDq/Q+dbSFYtbtHH/MeVSukjn/LkTRXTrHdJMDttlZxv0PiuS+RhD8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXgGd7zxZso79Fbx1yFpWzpXp/LfK1v3bdzngeKAmqhgDwVcf
	SAWo0fLAEQm3v3mmAoIp7t9oqdi6lWy0djQvtt5F6J6PdtQsQpNp5rDA
X-Gm-Gg: ATEYQzxr2oK9waHnjN52Mvbl9j98e0+/4zdozBtL+9Wkjta9mGsUaR0n8peHrCXAHSu
	pItxA8RycMBRYGzc4yFpemSsqTpr0S3i5z1XVOCr5K5B5JGnkUHwCAOgGYmQ2QDHbS/11Pw/X6L
	MBiRo3K4rSeAoqlSEaVElzPIm7YYxQWS6JsAlceUWgCeO3DsqDhrn8p9r736+YzI8FvfjO+xb88
	KIMUFeQhxBpkUB+tYMqnjbVytfwRs9fGq43ePzaDxNnDppX2057G9ixhz1u9RE8CU0apeeHo1SQ
	Czd1+gk6PV/QcqIsghWZtt5VXU2uXwz7X6AhxaSKyFXPGePG032tLr5VnOf8HTdmShHQaiqmRrG
	aLR1ycr44ZAFFa/CgppJT/c9lSUKlAjScetA5fTaezR/YdTrD7yCKtKjricva19eKFmJBZFLi3+
	W/ynvcIwOAFEDSt0wnQ9Dfg40YKGuKZ8gFSZQP/30Jvw==
X-Received: by 2002:a05:6a20:729e:b0:392:e6c3:7426 with SMTP id adf61e73a8af0-398c6166d74mr999448637.62.1773202434015;
        Tue, 10 Mar 2026 21:13:54 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf24baasm673400a12.8.2026.03.10.21.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 21:13:53 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:13:45 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <abDr-fSP9EtP7uEQ@v4bel>
References: <aZgpkyTDU3aXe_V0@v4bel>
 <aZyMejqTbkI7o_VM@krikkit>
 <aaDATohaW62X_pxk@v4bel>
 <aaYY6UiXSppOig9Q@krikkit>
 <aaY-TbPsNxo6toSr@v4bel>
 <aaoTVMhnY5FKMrem@krikkit>
 <aaobmK6d_xd9ZXGj@v4bel>
 <aaqovyrmd5pJtZKq@krikkit>
 <aaq9TgFpsjn9XWAC@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaq9TgFpsjn9XWAC@v4bel>
X-Rspamd-Queue-Id: 1B7E925BDEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266457-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,inria.fr,treblig.org,garmin.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 08:41:02PM +0900, Hyunwoo Kim wrote:
> On Fri, Mar 06, 2026 at 11:13:19AM +0100, Sabrina Dubroca wrote:
> > 2026-03-06, 09:11:04 +0900, Hyunwoo Kim wrote:
> > > On Fri, Mar 06, 2026 at 12:35:48AM +0100, Sabrina Dubroca wrote:
> > > > Sorry for the delay, I wanted to think about the race condition a bit
> > > > more.
> > > > 
> > > > 2026-03-03, 10:50:05 +0900, Hyunwoo Kim wrote:
> > > > > On Tue, Mar 03, 2026 at 12:10:33AM +0100, Sabrina Dubroca wrote:
> > > > > > 2026-02-27, 06:51:10 +0900, Hyunwoo Kim wrote:
> > > > > > > On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> > > > > > > > 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > > > > > > > "strp stopped" is not really enough, I think we'd also need to reset
> > > > > > > > the CBs, and then grab bh_lock_sock to make sure a previously-running
> > > > > > > > ->sk_data_ready has completed. This is what kcm does, at least.
> > > > > > > 
> > > > > > > It seems that this is not something that should be handled inside strp itself, 
> > > > > > > but rather something that each caller of strp_stop() is expected to take care 
> > > > > > > of individually. Would that be the right direction?
> > > > > > 
> > > > > > Agree.
> > > > > > 
> > > > > > > It also appears that ovpn and kcm handle this by implementing their own callback 
> > > > > > > restoration logic.
> > > > > > 
> > > > > > Right. I tried to look at skmsg/psock (the other user of strp), but
> > > > > > didn't get far enough to verify if it's handling this correctly.
> > > > > > 
> > > > > > > > Without that, if strp_recv runs in parallel (not from strp->work) with
> > > > > > > > strp_done, cleaning up skb_head in strp_done seems problematic.
> > > > > > > 
> > > > > > > From the espintcp perspective, how about applying a patch along the following lines?
> > > > > > 
> > > > > > This is what I was thinking about, yes.
> > > > > 
> > > > > In my opinion, it might be cleaner to split the espintcp callback restoration work into 
> > > > > a separate patch, rather than merging it into the strparser v3 patch. What do you think?
> > > > 
> > > > Sure. But once espintcp is fixed in that way, can the original race
> > > > condition with strparser still occur? release_sock() will wait for any
> > > 
> > > If the espintcp callback restoration patch is applied, the strparser
> > > race should no longer occur in espintcp.
> > > 
> > > > espintcp_data_ready()/strp_data_ready() that's already running, and a
> > > > sk_data_ready that starts after we've changed the callbacks will not
> > > > end up in strp_data_ready() at all so it won't restart the works that
> > > > are being stopped by strp_done()?
> > > > 
> > > > It's quite reasonable to use disable*_work_sync in strp_done, but I'm
> > > > not sure there's a bug other than espintcp not terminating itself
> > > > correctly on the socket.
> > > 
> > > That said, the _cancel APIs in strparser still appear to carry some
> > > structural risk, so it might still make sense to switch to the _disable
> > > APIs for the benefit of other strp users or potential future callers.
> > 
> > Not really. Every user of strp that is open to the strp_recv vs
> > cancel_* race is also open to the strp_recv vs free race, so switching
> > from cancel_* to disable_* is only a partial fix.
> > 
> > But if we took and released the socket lock in strp_done, we would
> > solve the issue for all users even without resetting the callbacks?
> 
> Looks good to me. With this change, it seems the issue can be resolved
> not only for espintcp but for all strp users.
> 
> When strp_stop() runs first:
> ```
>                  cpu0                                cpu1
> 
> espintcp_close()
>   strp_stop()
>     strp->stopped = 1;
>                                          espintcp_data_ready()
>                                            strp_data_ready()
>                                              if (unlikely(strp->stopped)) return;
>   strp_done()
>     lock_sock();
>     release_sock();
>     cancel_delayed_work_sync(&strp->msg_timer_work);
>     kfree_skb(strp->skb_head);
> ```
> 
> When strp_data_ready() runs first:
> ```
>                  cpu0                                cpu1
> 
>                                          espintcp_data_ready()
>                                            strp_data_ready()
>                                              if (unlikely(strp->stopped)) return;
> espintcp_close()
>   strp_stop()
>     strp->stopped = 1;
>   strp_done()
>     lock_sock();
>                                              strp_read_sock()
>                                                tcp_read_sock()
>                                                  __tcp_read_sock()
>                                                    strp_recv()
>                                                      __strp_recv()
>                                                        head = strp->skb_head;
>                                                        strp_start_timer()
>                                                          mod_delayed_work(&strp->msg_timer_work);
>                                                        ...
>     release_sock();
>     cancel_delayed_work_sync(&strp->msg_timer_work);
>     kfree_skb(strp->skb_head);
> ```
> In both cases, the race does not appear to cause any problem.
> 
> > 
> > @@ -503,6 +503,10 @@ void strp_done(struct strparser *strp)
> >  {
> >  	WARN_ON(!strp->stopped);
> >  
> > +	lock_sock(strp->sk);
> > +	/* sync with other code */
> > +	release_sock(strp->sk);
> > +
> >  	cancel_delayed_work_sync(&strp->msg_timer_work);
> >  	cancel_work_sync(&strp->work);
> >  
> > 
> > 
> >  - strp->stopped so any new call into strp_data_ready will not do anything
> > 
> >  - lock/release need to take bh_lock_sock so any existing call to
> >    strp_data_ready will have to complete before we move on to cancel*_work
> > 
> > 
> > 
> > Or maybe the requirement should be that strp_stop has to be called
> 
> From my perspective, adding lock_sock() inside strp_done(), as in the
> patch above, looks cleaner.
> 
> > under lock_sock() (or even just bh_lock_sock), but again I can't
> > figure out if that's ok for sockmap.
> 
> sockmap/psock has a more complex call stack compared to other strp
> users, so I'm also not entirely certain about that part.

I looked into the sockmap/psock side. sk_psock_strp_data_ready() is protected 
by read_lock_bh(&sk->sk_callback_lock), and during teardown sk_psock_drop() 
performs callback restoration and strp_stop() under 
write_lock_bh(&sk->sk_callback_lock), so sockmap/psock doesn't have this race 
to begin with.

As for introducing this patch, in sockmap/psock strp_done() is only called 
from sk_psock_destroy(), which is scheduled via queue_rcu_work() and runs 
on system_percpu_wq after an RCU GP, so no locks including lock_sock are held 
at that point. And since lock_sock is released before cancel_work_sync, 
there's no circular dependency with do_strp_work/strp_msg_timeout either. 
So this patch shouldn't introduce any new issues for sockmap/psock.

> 
> > 
> > 
> > > With that in mind, perhaps the direct fix for this race could be handled
> > > in the espintcp callback restoration patch. For the strparser patch, I
> > > could instead adjust the commit message to reflect that it removes a
> > > potential hazard by replacing the _cancel APIs with the _disable
> > > variants, and resubmit it in that form.
> > 
> > I'm not going to nack a patch doing s/cancel_/disable_/ in strp_done,
> > but it doesn't fully solve the race condition if the caller isn't
> > doing the right thing, and it doesn't do anything if the strp user is
> > handling the teardown correctly.
> 
> I agree with your point there. Still, after the core patches addressing
> this race are applied, I plan to resubmit the _disable patch with an
> updated commit message. I think applying that change is still beneficial.
> 
> 
> Best regards,
> Hyunwoo Kim

