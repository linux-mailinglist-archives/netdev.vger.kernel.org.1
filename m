Return-Path: <netdev+bounces-264752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKYAHr69qmmGWQEAu9opvQ
	(envelope-from <netdev+bounces-264752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:42:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ABC21FC90
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E370930692FE
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA9828505E;
	Fri,  6 Mar 2026 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llEj+Pv/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2C21576E
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797269; cv=none; b=OE0vc5z+5nNfFjL8RG6EHc8yCDU79DGbj0vOm8zf7RbA4x3lwtMYmKJac/irWhErxyFmP2Nvsv0FiDRt7L+zYlhUfQZe90F2Cp2dC9cJfTIr9gvryLS/KmLsksJxM6FoCThzPuaBuBt8eARkkUMZaqIeyMEzKTygRENiMNVqRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797269; c=relaxed/simple;
	bh=3PD5ErdhNijk1xfS60mUdJEBwDu9jsCpqyiHZmnFQYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibhFZD8fqmtBS7LJ/3p/6QYmWv8WvEW/w2YrVN2ymUfL+fIg2wg4Tw3b1ZBYn6hKjjZRr+Bd+V618lvkZVwJFTMm86vSaXeyTJMnJYqEVBCGqniDYRpUEroAjvuaysd3au0omjvh7LAnus5uNfULJhMZ1RGNkQo8Sck2HpcAlQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llEj+Pv/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7382731edfso1652336a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 03:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772797267; x=1773402067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yA4v/OvLnn3aAd/tqxXzpUyQuayltT+FVyBu9yb8xaQ=;
        b=llEj+Pv/ZhY8WHpZOId2dFOkOxPoW/v8nigy4gPPkKhiKNavAXAyyN9qMQM3zJzxU3
         s+HVv60B2tUB9LkPOUPrNM/+l/E50JX6j3TMlfmUsO4nMxtfID2Fd1ffgcTrMorxq4FS
         cZXcIp1CS3o+fUnIdVwwKndIuTWxLD3mZ5vy+t4+gBjkiryBeUYS3mSRmNu0a97t7Ad/
         twqhhBNSRfDqdpwkBJ1JgZc/qYUI5CiJowp+pdq/EnPfWH72Y9f/7qQ42u55werz9QML
         NKgwKgMv7i1r0mRXZGQaR7VV3D25IMIjNWiQqkblrfgwbNLdomwyPYWlqtXcwT6UlRX1
         foQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772797267; x=1773402067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA4v/OvLnn3aAd/tqxXzpUyQuayltT+FVyBu9yb8xaQ=;
        b=KlDcx1IQViyWJ4T3qfFfM+r4Yiyg2tajQmIemZ9JEiFRBwrHxRGzJWDuR2PY8wuhOG
         q+TYv2dV/S9p2hZ9ifBktuiedRm+LJG8jZUSpi1vt2kDNS8Ysvlc56i65eVWs7gXcoub
         3VyE11Q78v5jXaZPLXpM8SRjT1K/R7VXTdXUYLp97bNS7DNqv1IYfTSABcHr1GRnG1q3
         uhdt2pONeXYTiyyvQ4LUpv6MzXlId11vxbg+MPepEMuGUvKo9hcG80p8XetY63yJbuQs
         h4C6t840BNDhR7o6pMAuitFUkJo4hgaXC51fwoZ9pGPkNf0qqaqRGa4DZa7XrZMOpSt1
         v4oA==
X-Forwarded-Encrypted: i=1; AJvYcCX3pwDfsz29PtNMLwHXTwLtlZYPCNw7d3x2ZcE1NwaH0Whzir1q+vEWzXICEI43a/g7+MeUDWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmlgDoKr/smAvVhriYSbBwqmbbACEFcmrE7QeDqrH7zxQvuwW2
	n7N2G8pMDv3E7K7fdKkxQoBP0fAvkWsadD2vvuRpwCuUSjqz/LgdnAOy
X-Gm-Gg: ATEYQzxzL99+KJtfN6ybD4RHFQPyNnpQTbEQASri1WmDP0AGKB3BZFLfuwQDzyebo5B
	pCr1f6bcpSDV+Gy0n+TPmcW9S41H8g2k/tUvVkBnlxaHO3ej7cDFhgaVKnAO91IXDOM8LQxHUpm
	pxPGWi11PxpZ7+WGMl4d6p/gXDWkRcv5vYg8NR6Rg0nuNQ9dz9FaXb0bLyK3txK1xve04x5BW3c
	ldpIGuHboFjq62eNUXS97jpIchNgUyxiokW9A9VTFgL0hrY9EH7YtOBuNwuQ6oOjV2ghs1+rE5o
	5lgJKPJsrSgWOm8FVE37tMz08sc40vTkprFsC1UOfBVMpVf0soNnUH9YtQpHwx17OcpwPtXJSHU
	huznLG01EuuVn8Y8utEAA+ctOqXpbLSHyyQd2bAoHhbJP42iau7tsBdfEQ2A1tSE+WbnuJ89pQH
	IXH0W7IeetkQs97i37LmByhIJrODkOwRYXSAPlcHr+wE5rSpYpPqvj
X-Received: by 2002:a17:902:f70a:b0:2ae:8253:1a77 with SMTP id d9443c01a7336-2ae82531ae3mr21314275ad.16.1772797266953;
        Fri, 06 Mar 2026 03:41:06 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f752bfsm24907725ad.60.2026.03.06.03.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:41:06 -0800 (PST)
Date: Fri, 6 Mar 2026 20:41:02 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <aaq9TgFpsjn9XWAC@v4bel>
References: <aZgpkyTDU3aXe_V0@v4bel>
 <aZyMejqTbkI7o_VM@krikkit>
 <aaDATohaW62X_pxk@v4bel>
 <aaYY6UiXSppOig9Q@krikkit>
 <aaY-TbPsNxo6toSr@v4bel>
 <aaoTVMhnY5FKMrem@krikkit>
 <aaobmK6d_xd9ZXGj@v4bel>
 <aaqovyrmd5pJtZKq@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaqovyrmd5pJtZKq@krikkit>
X-Rspamd-Queue-Id: E2ABC21FC90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264752-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,inria.fr,treblig.org,garmin.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 11:13:19AM +0100, Sabrina Dubroca wrote:
> 2026-03-06, 09:11:04 +0900, Hyunwoo Kim wrote:
> > On Fri, Mar 06, 2026 at 12:35:48AM +0100, Sabrina Dubroca wrote:
> > > Sorry for the delay, I wanted to think about the race condition a bit
> > > more.
> > > 
> > > 2026-03-03, 10:50:05 +0900, Hyunwoo Kim wrote:
> > > > On Tue, Mar 03, 2026 at 12:10:33AM +0100, Sabrina Dubroca wrote:
> > > > > 2026-02-27, 06:51:10 +0900, Hyunwoo Kim wrote:
> > > > > > On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> > > > > > > 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > > > > > > "strp stopped" is not really enough, I think we'd also need to reset
> > > > > > > the CBs, and then grab bh_lock_sock to make sure a previously-running
> > > > > > > ->sk_data_ready has completed. This is what kcm does, at least.
> > > > > > 
> > > > > > It seems that this is not something that should be handled inside strp itself, 
> > > > > > but rather something that each caller of strp_stop() is expected to take care 
> > > > > > of individually. Would that be the right direction?
> > > > > 
> > > > > Agree.
> > > > > 
> > > > > > It also appears that ovpn and kcm handle this by implementing their own callback 
> > > > > > restoration logic.
> > > > > 
> > > > > Right. I tried to look at skmsg/psock (the other user of strp), but
> > > > > didn't get far enough to verify if it's handling this correctly.
> > > > > 
> > > > > > > Without that, if strp_recv runs in parallel (not from strp->work) with
> > > > > > > strp_done, cleaning up skb_head in strp_done seems problematic.
> > > > > > 
> > > > > > From the espintcp perspective, how about applying a patch along the following lines?
> > > > > 
> > > > > This is what I was thinking about, yes.
> > > > 
> > > > In my opinion, it might be cleaner to split the espintcp callback restoration work into 
> > > > a separate patch, rather than merging it into the strparser v3 patch. What do you think?
> > > 
> > > Sure. But once espintcp is fixed in that way, can the original race
> > > condition with strparser still occur? release_sock() will wait for any
> > 
> > If the espintcp callback restoration patch is applied, the strparser
> > race should no longer occur in espintcp.
> > 
> > > espintcp_data_ready()/strp_data_ready() that's already running, and a
> > > sk_data_ready that starts after we've changed the callbacks will not
> > > end up in strp_data_ready() at all so it won't restart the works that
> > > are being stopped by strp_done()?
> > > 
> > > It's quite reasonable to use disable*_work_sync in strp_done, but I'm
> > > not sure there's a bug other than espintcp not terminating itself
> > > correctly on the socket.
> > 
> > That said, the _cancel APIs in strparser still appear to carry some
> > structural risk, so it might still make sense to switch to the _disable
> > APIs for the benefit of other strp users or potential future callers.
> 
> Not really. Every user of strp that is open to the strp_recv vs
> cancel_* race is also open to the strp_recv vs free race, so switching
> from cancel_* to disable_* is only a partial fix.
> 
> But if we took and released the socket lock in strp_done, we would
> solve the issue for all users even without resetting the callbacks?

Looks good to me. With this change, it seems the issue can be resolved
not only for espintcp but for all strp users.

When strp_stop() runs first:
```
                 cpu0                                cpu1

espintcp_close()
  strp_stop()
    strp->stopped = 1;
                                         espintcp_data_ready()
                                           strp_data_ready()
                                             if (unlikely(strp->stopped)) return;
  strp_done()
    lock_sock();
    release_sock();
    cancel_delayed_work_sync(&strp->msg_timer_work);
    kfree_skb(strp->skb_head);
```

When strp_data_ready() runs first:
```
                 cpu0                                cpu1

                                         espintcp_data_ready()
                                           strp_data_ready()
                                             if (unlikely(strp->stopped)) return;
espintcp_close()
  strp_stop()
    strp->stopped = 1;
  strp_done()
    lock_sock();
                                             strp_read_sock()
                                               tcp_read_sock()
                                                 __tcp_read_sock()
                                                   strp_recv()
                                                     __strp_recv()
                                                       head = strp->skb_head;
                                                       strp_start_timer()
                                                         mod_delayed_work(&strp->msg_timer_work);
                                                       ...
    release_sock();
    cancel_delayed_work_sync(&strp->msg_timer_work);
    kfree_skb(strp->skb_head);
```
In both cases, the race does not appear to cause any problem.

> 
> @@ -503,6 +503,10 @@ void strp_done(struct strparser *strp)
>  {
>  	WARN_ON(!strp->stopped);
>  
> +	lock_sock(strp->sk);
> +	/* sync with other code */
> +	release_sock(strp->sk);
> +
>  	cancel_delayed_work_sync(&strp->msg_timer_work);
>  	cancel_work_sync(&strp->work);
>  
> 
> 
>  - strp->stopped so any new call into strp_data_ready will not do anything
> 
>  - lock/release need to take bh_lock_sock so any existing call to
>    strp_data_ready will have to complete before we move on to cancel*_work
> 
> 
> 
> Or maybe the requirement should be that strp_stop has to be called

From my perspective, adding lock_sock() inside strp_done(), as in the
patch above, looks cleaner.

> under lock_sock() (or even just bh_lock_sock), but again I can't
> figure out if that's ok for sockmap.

sockmap/psock has a more complex call stack compared to other strp
users, so I'm also not entirely certain about that part.

> 
> 
> > With that in mind, perhaps the direct fix for this race could be handled
> > in the espintcp callback restoration patch. For the strparser patch, I
> > could instead adjust the commit message to reflect that it removes a
> > potential hazard by replacing the _cancel APIs with the _disable
> > variants, and resubmit it in that form.
> 
> I'm not going to nack a patch doing s/cancel_/disable_/ in strp_done,
> but it doesn't fully solve the race condition if the caller isn't
> doing the right thing, and it doesn't do anything if the strp user is
> handling the teardown correctly.

I agree with your point there. Still, after the core patches addressing
this race are applied, I plan to resubmit the _disable patch with an
updated commit message. I think applying that change is still beneficial.


Best regards,
Hyunwoo Kim

