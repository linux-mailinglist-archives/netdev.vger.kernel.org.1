Return-Path: <netdev+bounces-269014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GODSKp2rumn9aQIAu9opvQ
	(envelope-from <netdev+bounces-269014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:41:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D02BC387
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B410930DD2BF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757983D88F4;
	Wed, 18 Mar 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="dHR7qY+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA983D88F0
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841273; cv=pass; b=nqnLG0VFjnCf3gWpggvKNbIFibb2BUor5QkhD9fDrQ7uYSC/PLco6nVzvHJlvaMz5Yv942MOoW/H45+hHlNCMdj6JmJ7hQn0TIX3R8ZM5hfDaY9Plx5B09/it0cbj0i6wcg8KhOMgHRPzF9iSr4f8PiVZNH846xcc7v82So28bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841273; c=relaxed/simple;
	bh=z/euYNrr2+BYwM4a/WfQWCBjyGxEkyKa2+Erlae4Q9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaE2Lj1dJY2ud5B5C4wqaApJGVylDAosskouONf/0Nt0vkZtVMwx3//BXcLkvK6RPJec8XXN8fgBAA9u/Jk1pBTdjhILtFtGt9+CSbL2lOvPkssIOkwiFOYbUps7Ln/oYtyc5zQeG4+O0WroPSfRwhcp7Hoq8myByXN+s3y4Bfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=dHR7qY+s; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64c9cabfe5dso1253898d50.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 06:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773841270; cv=none;
        d=google.com; s=arc-20240605;
        b=OpxhCxDMHnoG6KBGbWozXXolAx6ryBMX4IWF9RLpmXDYX6avfT4gQCfEvfKK4w7Mcj
         /GV7kZ5sNWKjQcjpTd1iWqKwy2MXX4t/rJuKTqvaT2/+ZZXAcLIru1UljUXAmMYRfTAH
         sZozxRFJxIyTalpz6YG85RxztwdKfdZ1RaRmxNO6Z1qNUW1eH6d23Fabr1iZoWYXy0z+
         lDEL6TWrvHbevybQ5TrHBuWZe7z4V2pH+bLHxaM2LS/TlRE2mBA7aCo54J2o/7QSovsT
         +US8ph3VhlgcPeVShd5hV6zyzXYAJh5l5NRClfKEjU+SCe8YoTG4CsEhuZORpBrr5zXY
         uvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wty4xQgtcbhRseyO6oF0j7oAkj0isukvCLYNA7lfurA=;
        fh=glpBCmFEZc5x0jw/7n4TMJ0l0MAdG5BalFwmDCWQqag=;
        b=hFVpO08eQlgzBMY4Zk+uEsrWSsgs4bjchmyktoFIBNdAMG7HKCkt3eJ+u8C9AYTlwv
         4O1XXHIrDe/CUp/QyVn0fKcrN1sop79eC+G0hYu2NWzf9dk7sXuMVis17aKHvgfzYhTK
         Aa0w2WKDCnTBMehsTpWdij/PZfOgABSu7d9cUjshgvpXUYwRbSjXQcoBpm95SMaDzxXd
         2IHkEU5mjRhiGayMoB9Hcb2uveHqOeBqfQtl74TwrMX4eCAcP32tsMhUOd2TW1FzfXpS
         BTlOj6GHrNFvmB5frk219wEqtO4JCIlxGIelx6Ik3p3tdKVhYiGGiRsf2/aA6IlTWI2Z
         wVVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773841270; x=1774446070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wty4xQgtcbhRseyO6oF0j7oAkj0isukvCLYNA7lfurA=;
        b=dHR7qY+sinjlf6f57N5bwU+OWVeO6VT/zMk8d5oKM2o0C3T8Sp3ZXtAZnObYRPtEuS
         WxeTpi4go96TnLWYkgmt0aOjP12Oom65Mqlj/ZXyeCiWwe9nUNYh0kjb1prG23oA2epx
         cn30OSbs08MsHXAF/CUKjs3yT+zkspQGYoKWXJNWn66iOVv2wPMZyxzLIcioiugwFxfg
         32vsERmsQU2CI9vR7x93m/U0LoXOJ4GmUg+0O2CF8uPdju5yiY98JkPblnudsOWA9czF
         fuHnXYn3/+TjbO+xnvUORLjB26mHpUBRG5VZnCpy91sjI0TevBprEamvrGjxg0V5lh6g
         zI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773841270; x=1774446070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wty4xQgtcbhRseyO6oF0j7oAkj0isukvCLYNA7lfurA=;
        b=VroRR0LYifg3uqEON1zd2v360/1IHVRYAb74IqaDyxxWjfpFIFd2Crs95PuaXhcT/U
         gMQd0uswgdnE2GFK5P5ciqBZMdSfdol8PUOsIdgkYHXJoxnOo00XSLoi7qDoidOiBiFF
         lD/2bcGh88l88jNJRV0XztlxlAR4BkClBgqh4CwQzBSaaK0M20q8JhBSfsOSngjD5dLU
         06eEFnShYhuzoEB9LFq04pMBWDIBoojpugPsMGRX7zcfR81GlHlWLMtqE+i5Cb6cuiUw
         da02YXQ66XXB3bpppPQ+Gnn6dr4pcVjvJ/norxHRR7H3slPS03Er+p75zC1hMU19D3PK
         OgAA==
X-Forwarded-Encrypted: i=1; AJvYcCULkMa311W0yAETdR6DClwPq/qHCYXFu1runkcYrdl9657v+9ZN8QiN4EyVR4LTk6b9fdXGGQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/4PuZsi390Ao0W8XtgVLg4GX+V75bnw7ubeqgAQ4CbkE/nfo
	EEMuwnUJI9XzvRHUenI4noW9p21AwHt7RLP0URRAmg4RNWN6kYY7LM2o3i0x4O1B+RvRlPZysgy
	iKZ9+XXfueD1mTDktCyXfxe4MgHd0MHAIfXM/z6gGwQ==
X-Gm-Gg: ATEYQzzijeWmlzLSmLIGv3t+t9Y3ZebEWMQrc5vFoEKxzWvkf+GlEgyN9XgMpEeSsL0
	ue5Y6/rtON11TCxFfdOFgwGxJ6h4kRVNokAvX+1JWG4VT5NjGWqAjoAapnpWSebZA03xf/gMRiU
	qQ43n+8pA39l4wOff8nENvHGU1iP8UccaDCe0TPka8M8rOWP/PXmQ/aBw3c7Uaj4GqQbf5OI2ro
	uoQaRV3FrYhwSi+BTCPzaK/D9ctrO8p4AkXtB/o8Y489Oj00RwmNYqj4E/nUH1ktxDynjnJDoYR
	xMoxEcSBsNjpE3uHcQ==
X-Received: by 2002:a05:690e:419b:b0:649:b234:3905 with SMTP id
 956f58d0204a3-64e88b4f88fmr5765244d50.41.1773841270022; Wed, 18 Mar 2026
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org> <f7to6ktnjxi.fsf@redhat.com>
In-Reply-To: <f7to6ktnjxi.fsf@redhat.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 09:40:58 -0400
X-Gm-Features: AaiRm51CXqWYj3bhPG1VWTfExv82dHZMJIVk-_egP6VLHUZcmabQcnoPToaB-4M
Message-ID: <CAO7JXPhfpUb1VM_=mwSUqHPQrLvBW=wurz_apWQkMXssPAQPJA@mail.gmail.com>
Subject: Re: [PATCH 04/15] net: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: Aaron Conole <aconole@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bitbyteword.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269014-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,infradead.org,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,ovn.org,vger.kernel.org,openvswitch.org,lists.sourceforge.net];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,bitbyteword.org:dkim,bitbyteword.org:email,mail.gmail.com:mid,goodmis.org:email]
X-Rspamd-Queue-Id: 237D02BC387
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:31=E2=80=AFAM Aaron Conole <aconole@redhat.com> =
wrote:
>
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> writes:
>
> > Replace trace_foo() with the new trace_invoke_foo() at sites already
> > guarded by trace_foo_enabled(), avoiding a redundant
> > static_branch_unlikely() re-evaluation inside the tracepoint.
> > trace_invoke_foo() calls the tracepoint callbacks directly without
> > utilizing the static branch again.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
> > ---
> >  net/core/dev.c             | 2 +-
> >  net/core/xdp.c             | 2 +-
> >  net/openvswitch/actions.c  | 2 +-
> >  net/openvswitch/datapath.c | 2 +-
> >  net/sctp/outqueue.c        | 2 +-
> >  net/tipc/node.c            | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 14a83f2035b93..a48fae2bbf57e 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *hea=
d)
> >               return;
> >       if (trace_netif_receive_skb_list_entry_enabled()) {
> >               list_for_each_entry(skb, head, list)
> > -                     trace_netif_receive_skb_list_entry(skb);
> > +                     trace_invoke_netif_receive_skb_list_entry(skb);
> >       }
> >       netif_receive_skb_list_internal(head);
> >       trace_netif_receive_skb_list_exit(0);
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 9890a30584ba7..53acc887c3434 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info =
*xdp_rxq,
> >               xsk_pool_set_rxq_info(allocator, xdp_rxq);
> >
> >       if (trace_mem_connect_enabled() && xdp_alloc)
> > -             trace_mem_connect(xdp_alloc, xdp_rxq);
> > +             trace_invoke_mem_connect(xdp_alloc, xdp_rxq);
> >       return 0;
> >  }
> >
> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > index 792ca44a461da..420eb19322e85 100644
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *dp=
, struct sk_buff *skb,
> >               int err =3D 0;
> >
> >               if (trace_ovs_do_execute_action_enabled())
> > -                     trace_ovs_do_execute_action(dp, skb, key, a, rem)=
;
> > +                     trace_invoke_ovs_do_execute_action(dp, skb, key, =
a, rem);
>
> Maybe we should just remove the guard here instead of calling the
> invoke.  That seems better to me.  It wouldn't need to belong to this
> series.
>
> >               /* Actions that rightfully have to consume the skb should=
 do it
> >                * and return directly.
> > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > index e209099218b41..02451629e888e 100644
> > --- a/net/openvswitch/datapath.c
> > +++ b/net/openvswitch/datapath.c
> > @@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_bu=
ff *skb,
> >       int err;
> >
> >       if (trace_ovs_dp_upcall_enabled())
> > -             trace_ovs_dp_upcall(dp, skb, key, upcall_info);
> > +             trace_invoke_ovs_dp_upcall(dp, skb, key, upcall_info);
>
> Same as above.  Seems OVS tracepoints are the only ones that include
> the guard without any real reason.
>

Makes sense. Its simple enough that I think I will include it as a
separate patch in v2 and remove these changes from this patch. Thanks
for pointing it out.

Thanks,
Vineeth

