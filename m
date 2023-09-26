Return-Path: <netdev+bounces-36255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF1D7AEAB9
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 12:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 14A771C20364
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7361A290;
	Tue, 26 Sep 2023 10:48:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A763AE
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 10:48:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2679AFB
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695725326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sHcgD4kemONl5JU5GOk/UuGUPB1vRm8GkP8no1Mkr8=;
	b=gkRMW3EfaoELspinS61nCvMJ5oIsMSY+TolK6sk4ue1inpwJ6AQcffWlaF8UqGD8oAER5N
	rB3jM8qceVah9m3ua6XEhtls9yeHbKJfPjdlWGWbxi3m5ejtdi6fNFuDQizdiftnpHSqzW
	+obM6Ud/jlG6EI+yLudSkgJnUGo3iOA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-FIc_srrLMIi7VuFOGXovSQ-1; Tue, 26 Sep 2023 06:48:44 -0400
X-MC-Unique: FIc_srrLMIi7VuFOGXovSQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4063f0af359so1561685e9.1
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 03:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725323; x=1696330123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sHcgD4kemONl5JU5GOk/UuGUPB1vRm8GkP8no1Mkr8=;
        b=MljxjticvMtkQS7Ci+1HLu2+0W9MtBYtyX0s9dTmKgcFtUgyv4WQpsNUYjK5NW3NKn
         FOgSQIEY7fASvyf/9YXeFYHxTUgHCjmJTNMJdmgfLU2chUOBWnE9gJfwAhCNOWN3XPlR
         68QC6b62rQkf4HDrM05ZbeKA+51NnKEAYKlZcpOVONoHxsFodZG4MAiARc+3kae87Wmu
         SN9gdkRYeQX8D2CnL6YrgU2fNGG0AGJaE6CfBP5vWwH8zovjqoOkVYV551Jcgzzy8b5J
         78BfR1G+wF1g4q7jgqSOWGLtLBFNMGAy6+KqP6cuVkBsMjrBv/2JlOhiNRg7qTklDwcH
         6CIw==
X-Gm-Message-State: AOJu0YyDIf25/LUgXCVgKkdoQpsGqFiq/9WV8XW8HdpkW5ZSOFL+muXK
	sYk30RwKHERYzvPQOTPGUl/XS2BdGYgjhsbHEtuaUYLt+wySl0Nbfpip1A8U2rBNU1vlVLCSfsL
	GOYOereFdWj989aK2
X-Received: by 2002:a05:600c:1913:b0:405:95ae:4a94 with SMTP id j19-20020a05600c191300b0040595ae4a94mr3664162wmq.5.1695725323714;
        Tue, 26 Sep 2023 03:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyJH8+cWNoiVujSTYMg+4KZ1ksHCByJF4Nn+CUcSvOx83M1SYA3N86W1QO/aXYnOL8G0sULQ==
X-Received: by 2002:a05:600c:1913:b0:405:95ae:4a94 with SMTP id j19-20020a05600c191300b0040595ae4a94mr3664145wmq.5.1695725323421;
        Tue, 26 Sep 2023 03:48:43 -0700 (PDT)
Received: from debian (2a01cb058d23d60082e2b64b0d4827f6.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:82e2:b64b:d48:27f6])
        by smtp.gmail.com with ESMTPSA id f11-20020adff98b000000b0030fd03e3d25sm14298698wrr.75.2023.09.26.03.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:48:42 -0700 (PDT)
Date: Tue, 26 Sep 2023 12:48:41 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <ZRK3CYKn4dDJFj+t@debian>
References: <099adf0eac09ba8227e18183a9fae6c046399e46.1695401891.git.gnault@redhat.com>
 <20230922174718.42473-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922174718.42473-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 10:47:18AM -0700, Kuniyuki Iwashima wrote:
> From: Guillaume Nault <gnault@redhat.com>
> Date: Fri, 22 Sep 2023 18:59:57 +0200
> > Walk the hashinfo->bhash table so that inet_diag can dump TCP sockets
> 
> I think we should use bhash2 as bhash could be long enough for reuseport
> listeners.  That's why bhash2 is introduced.

Okay, I'll try that.

> > that are bound but haven't yet called connect() or listen().
> > 
> > This allows ss to dump bound-only TCP sockets, together with listening
> > sockets (as there's no specific state for bound-only sockets). This is
> > similar to the UDP behaviour for which bound-only sockets are already
> > dumped by ss -lu.
> > 
> > The code is inspired by the ->lhash2 loop. However there's no manual
> > test of the source port, since this kind of filtering is already
> > handled by inet_diag_bc_sk().
> > 
> > No change is needed for ss. With an IPv4, an IPv6 and an IPv6-only
> > socket, bound respectively to 40000, 64000, 60000, the result is:
> > 
> >   $ ss -lt
> >   State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
> >   UNCONN 0      0            0.0.0.0:40000      0.0.0.0:*
> >   UNCONN 0      0               [::]:60000         [::]:*
> >   UNCONN 0      0                  *:64000            *:*
> > 
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > ---
> >  net/ipv4/inet_diag.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> > index e13a84433413..de9c0c8cf42b 100644
> > --- a/net/ipv4/inet_diag.c
> > +++ b/net/ipv4/inet_diag.c
> > @@ -1077,6 +1077,60 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
> >  		s_i = num = s_num = 0;
> >  	}
> >  
> > +	/* Dump bound-only sockets */
> > +	if (cb->args[0] == 1) {
> > +		if (!(idiag_states & TCPF_CLOSE))
> > +			goto skip_bind_ht;
> > +
> > +		for (i = s_i; i <= hashinfo->bhash_size; i++) {
> > +			struct inet_bind_hashbucket *ibb;
> > +			struct inet_bind_bucket *tb;
> > +
> > +			num = 0;
> > +			ibb = &hashinfo->bhash[i];
> > +
> > +			spin_lock_bh(&ibb->lock);
> > +			inet_bind_bucket_for_each(tb, &ibb->chain) {
> > +				if (!net_eq(ib_net(tb), net))
> > +					continue;
> > +
> > +				sk_for_each_bound(sk, &tb->owners) {
> > +					struct inet_sock *inet = inet_sk(sk);
> > +
> > +					if (num < s_num)
> > +						goto next_bind;
> > +
> > +					if (sk->sk_state != TCP_CLOSE ||
> > +					    !inet->inet_num)
> > +						goto next_bind;
> > +
> > +					if (r->sdiag_family != AF_UNSPEC &&
> > +					    r->sdiag_family != sk->sk_family)
> > +						goto next_bind;
> > +
> > +					if (!inet_diag_bc_sk(bc, sk))
> > +						goto next_bind;
> > +
> > +					if (inet_sk_diag_fill(sk, NULL, skb,
> > +							      cb, r,
> > +							      NLM_F_MULTI,
> > +							      net_admin) < 0) {
> > +						spin_unlock_bh(&ibb->lock);
> > +						goto done;
> > +					}
> > +next_bind:
> > +					num++;
> > +				}
> > +			}
> > +			spin_unlock_bh(&ibb->lock);
> 
> Here we should add cond_resched(), otherwise syzbot could abuse this
> and report hung task.

I'll look into that too. Thanks.

> > +
> > +			s_num = 0;
> > +		}
> > +skip_bind_ht:
> > +		cb->args[0] = 2;
> > +		s_i = num = s_num = 0;
> > +	}
> > +
> >  	if (!(idiag_states & ~TCPF_LISTEN))
> >  		goto out;
> >  
> > -- 
> > 2.39.2
> 


