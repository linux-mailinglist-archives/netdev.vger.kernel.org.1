Return-Path: <netdev+bounces-261602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGvsAFrAoGk1mQQAu9opvQ
	(envelope-from <netdev+bounces-261602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:51:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7428B1B0155
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 461503038FDF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2709038B7BB;
	Thu, 26 Feb 2026 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhamwgQs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC336212E
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142678; cv=none; b=mMQVxq5p7hYD8NHhfsQm9qyrv7XAyy5DLb1HH3KEetaq4WxVcqyoiXV/NyLkv7VjLySAVtk0IwMcvtPXCmlaMB2H0Jj9QgW8j4sDR1rXW2X3RMpq+Tb5UQfKkPibXjdhN4n4xI3Udcpuf7xD0zQHErdIZ0J2EfiQ0SnrA7lLF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142678; c=relaxed/simple;
	bh=JdedX8RBI39+Om71bCSAawZjJO99QKqIeGw79wIcmss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=davCewKu3OM7+ashrSaHD3XDA7P7cKiyJYIqF2dOCxfeTZ+iXKIqHRc4Q1CHGg9NyedMr5y0de/SOt6OoSXmc1EXJX9xswCaU0nuORIDJQwa6dnxNF2wQZhRR2cjdhtnTzVBpCQcNkCX6EYErr4tRPnRNwg9/wDQHZgeN8J3oNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhamwgQs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso672669b3a.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772142676; x=1772747476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNA4t6u2ornmsst5qMIfMDWpFHroy4/Cnc7yoEqS2h4=;
        b=WhamwgQsgTY0/6gOAC/gLzd2/u14EkcxhwExSZqyEc4A4mZTLEPzMaGdwaGx3xq12K
         wbov1QTcpJoSWh8IElTs2AZp2JhhYftJy4hYUZMoKwGT6x6jAsiM5gk2u7pDo8t2XPKt
         SrkSsFauA7Mh8PpvZ85DQYu1yY+hoY/fv/Xbto+087+0DiCZ0TZ07x9c4UL0MJkLATPn
         +vshQKaMtl6kwF5Rrc4clNEzUKebpLWzfqpk3kvobIeVmEZTHp3SSd/ZSBTd1REB8wf1
         VxpJS/IWpObqhzviyCsbZXhUsRDlHXYfbW/8JuH6FXv+vPfkjTE1hjS/5DlAgzISeBa4
         pBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772142676; x=1772747476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNA4t6u2ornmsst5qMIfMDWpFHroy4/Cnc7yoEqS2h4=;
        b=Z6b2wx5fM2LCPZT+31NPlaPKcmqeiJHiJ8lupSDyI+XBCCQK0cFziE4HaO1zReKRF1
         nBBgXLOS8vz7dAm/rBSxTuEWONqzL5Ojcqkv1EAjfXa+N1PrwE8YK97o3MHF+fZi0E34
         B2wA1tT8nXVR1B7R+GyaPqgYl9l0DpvvtRzb2cSSCeS8w5TFdlmYss3RbeSOMEv6sIS+
         3O7GI/0nNXJTTM2C4fwRvfexN/Oxzn8wkzcZriyEDpAeDTyOPuvXTGfg5qX1q5XazXD4
         vf4mrAqQUtIXO4/aFsQaZFRE8N6jFhwiQP8LguDKrrFrsRPKigguwboiemRqHtEL//fK
         d2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7X4gX88o0TsiKGs9j5ju8phE3rwNIKHYeQ0nqABuauRZxeZTyGpWGcWuB/FfuDnDTQfIEe6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6mtuA04YgoJsj6FsP04Ygf+GJ5XIFm4Q81nrKoMlceUVGi2w
	sovXwfhIq+kAgY6Qk3Xn5ssfr5UthCg0vH3mTx2wNkgMUx96MC4TbP3Il06/zw==
X-Gm-Gg: ATEYQzxOHKBQ9IxHFA9cD4EsAC/15e3JyXszv5OWbWAP4eapaaEjaUnMsHIbEnKqv6L
	C8zh3x+t8BRinKIY3YAlkG/ZRcvvCZVFl9z7dBR9I97IH3I0XyQAT4XHit6JZYwLm0xztVnmKff
	Ge1ClSw++q3Fpsojqq6lZmmgMFoT27abTBcxbCqpZbz20YR3K4bImhFdWdruqn0ZvC8ZZgakxOK
	ddpC/oFYyAu5ObLZU6MEDGPaybr4EmMGuM84V7XeHgsssdjGw0IrL1zL0izUFKk01m1HVIp5Lo2
	qo3Zli++H8U93x3Xw1onlEFDKStmAgcL8gW2SbLk8mPI70JQa0yh9xqzFFr5eKnIMlCnXyP0EK2
	QgRkgbnQABc1hLrTTs7+tHYfGu+lpg6nBW7j2UPNce3ZkM7eFJYbDjDDoffsH4viPReLdYLDylI
	TON8IE4oYag8NkhaW8kmEWX39hJkFFPw4ZvLnY00FRMA==
X-Received: by 2002:a05:6a20:db8e:b0:395:1869:f64a with SMTP id adf61e73a8af0-395c3b03ee0mr589386637.39.1772142676102;
        Thu, 26 Feb 2026 13:51:16 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa61fcdesm2509644a12.11.2026.02.26.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:51:15 -0800 (PST)
Date: Fri, 27 Feb 2026 06:51:10 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <aaDATohaW62X_pxk@v4bel>
References: <aZgpkyTDU3aXe_V0@v4bel>
 <aZyMejqTbkI7o_VM@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZyMejqTbkI7o_VM@krikkit>
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
	TAGGED_FROM(0.00)[bounces-261602-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,inria.fr,treblig.org,garmin.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7428B1B0155
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > This issue was discovered during a code audit.
> > 
> > When strp_stop() and strp_done() are called without holding lock_sock(), 
> > they can race with worker-scheduling paths such as the Delayed ACK handler 
> > and ksoftirqd.
> > Specifically, after cancel_delayed_work_sync() and cancel_work_sync() are 
> > invoked from strp_done(), the workers may still be scheduled.
> > As a result, the workers may dereference freed objects.
> > 
> > The following is a simple race scenario:
> > 
> >           cpu0                      cpu1
> > 
> > espintcp_close()
> >                            espintcp_data_ready()
> >                              strp_data_ready()
> >                                if (unlikely(strp->stopped)) return;
> >   strp_stop()
> >     strp->stopped = 1;
> >   strp_done()
> >     cancel_delayed_work_sync(&strp->msg_timer_work);
> >                                strp_read_sock()
> >                                  tcp_read_sock()
> >                                    __tcp_read_sock()
> >                                      strp_recv()
> >                                        __strp_recv()
> >                                          strp_start_timer()
> >                                            mod_delayed_work(&strp->msg_timer_work);
> > 
> > To prevent these races, the cancellation APIs are replaced with 
> > worker-disabling APIs.
> 
> I'm still not totally convinced by this patch. The comment for
> strp_done says the function expects to be called at a time when
> strp_recv cannot happen in parallel:
> 
>     strp must already be stopped so that strp_recv will no longer be called

OK, I understand.
More specifically, it seems that an issue could occur if strp->skb_head is 
accessed under the following scenario.
```
                 cpu0                                cpu1

espintcp_close()
                                         espintcp_data_ready()
                                           strp_data_ready()
                                             if (unlikely(strp->stopped)) return;
  strp_stop()
    strp->stopped = 1;
  strp_done()
    disable_delayed_work_sync(&strp->msg_timer_work);
    kfree_skb(strp->skb_head);
                                             strp_read_sock()
                                               tcp_read_sock()
                                                 __tcp_read_sock()
                                                   strp_recv()
                                                     __strp_recv()
                                                       head = strp->skb_head;
                                                       ...
```

> 
> "strp stopped" is not really enough, I think we'd also need to reset
> the CBs, and then grab bh_lock_sock to make sure a previously-running
> ->sk_data_ready has completed. This is what kcm does, at least.

It seems that this is not something that should be handled inside strp itself, 
but rather something that each caller of strp_stop() is expected to take care 
of individually. Would that be the right direction?

It also appears that ovpn and kcm handle this by implementing their own callback 
restoration logic.

> 
> Without that, if strp_recv runs in parallel (not from strp->work) with
> strp_done, cleaning up skb_head in strp_done seems problematic.

From the espintcp perspective, how about applying a patch along the following lines?
```
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index e1b11ab59f6e..989638fdc111 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -526,12 +526,28 @@ static void espintcp_release(struct sock *sk)
 	tcp_release_cb(sk);
 }

+static void espintcp_detach_sock(struct sock *sk)
+{
+	struct espintcp_ctx *ctx = espintcp_getctx(sk);
+
+	lock_sock(sk);
+
+	write_lock_bh(&sk->sk_callback_lock);
+	sk->sk_data_ready = ctx->saved_data_ready;
+	sk->sk_write_space = ctx->saved_write_space;
+	write_unlock_bh(&sk->sk_callback_lock);
+
+	strp_stop(&ctx->strp);
+
+	release_sock(sk);
+}
+
 static void espintcp_close(struct sock *sk, long timeout)
 {
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 	struct espintcp_msg *emsg = &ctx->partial;

-	strp_stop(&ctx->strp);
+	espintcp_detach_sock(sk);

 	sk->sk_prot = &tcp_prot;
 	barrier();
```

Best regards,
Hyunwoo Kim

