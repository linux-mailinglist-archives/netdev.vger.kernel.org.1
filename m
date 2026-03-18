Return-Path: <netdev+bounces-269041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBJ4FzS0umlWawIAu9opvQ
	(envelope-from <netdev+bounces-269041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:18:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 000DE2BCECC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05B4E3047C5C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181BC3DA5A7;
	Wed, 18 Mar 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="iLv8Kcr6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED503D9DD9
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843217; cv=pass; b=KKyEpS9y5vIApytuAHl40yArpXCC2kwCQpnFGTsHUsu2Ligg7XGNsfOVjwFT0nYi9insmxat1lb2ncbtryFdAitPAKhnCJoJ7SgMGDKNtYjy55DCEFiFEOpsoDd2JIMKfK/jHmfVZL6Rb7wuzh8TcjBDa8ANTTwlFPc2PtQNKps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843217; c=relaxed/simple;
	bh=z/89pA0UO58ZBkQTFOgdhyZuqhcSfbmElffwmdziG+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWNgGcNRBIoYezMRNh7reb7DLjJQzrPV6zWGFpn+AnR8I2EbrdC6Csaj9ZzhRCXyN/VCvU7qXTJeP7WjpUr3yhjaT40z7crjvdiEpuRb3Y7/8/eIYIbh3IeMJ4839+sJUeXVTkb23wM44Qwm1KQllHfHjrCYlVqgjyQmV13PETQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=iLv8Kcr6; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89c6a711ce9so20790146d6.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773843213; cv=none;
        d=google.com; s=arc-20240605;
        b=EXzhSteO6b6iqs3r5ezckdedzLM3y9ktva231plFTHFDj+ZylxqrshsMKn2AWp4qus
         Ag5G+JJhf9nxvQk+OJOv35XI7ax/y4ucWGwsDQBEqAIID7R0DnPQ/oeZdgS9bYJl9APH
         DwmIXkBkzy+Ljv0sStIkWiPBngW3aaNaCcCDYY+mT0U2ElAtbxB89Kzp9WuoTo/0n0X0
         Da5ciE8bwwDZcS6t3+AgV47lBZRSvnDMdTEHBXsARNIUEqdOmHQrobY5HMDPyQB4ATVH
         qsEWg6Bz5eYEqTCchVMsaCSuh+0EeM9eUkcSGmsW+P28jQ5k+i7+6LC2C3w6if+j/0h+
         LSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=doH9jKyIV2pcWr9QqHgYapLUvNmJgzZV6s5pft4p5hM=;
        fh=AZNUq08iRVtNS9WhTCp6w8vNbwfoPMjtVlFhKhRFYKw=;
        b=kntyT73tEHo1Hi5xBmDrTX3dYYDBk+BWpEnSDF8xwpnnN/jNpyXwWUSeZSTvXzZ9mS
         qi4MbEa/CYszD9zOQOdK2lcyX7s4qePlhrZYrhIM1xslacJYU6MaVdBqejBmHaa9l6Rm
         apRhd8oJGLYp+KyCDhES29P4ZXDBHKdfhipEXH90UuJhplMwqBrLLKjRDVSOkGQGm2YP
         yGI/LcUtdbvZrp/Ya5jxE9/aFEP4RV75Mm4KSu6MH0Z9Ses2tJybuxXJ0CdQ80+xE4DR
         ZNMqDe/nQc+m0GJfLq7MtJmSNI3lkYWUA9/clNDtAVo/HKl4CV+xGc8j6hLKyYjQBoUL
         awtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773843213; x=1774448013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doH9jKyIV2pcWr9QqHgYapLUvNmJgzZV6s5pft4p5hM=;
        b=iLv8Kcr6ga2PE/qEE7gatlTbBuKuabs1y16ZU02HWWuD2F8/SlRbYD+MiJWlt2c2k2
         dduToabSVGSFcR3YzXAZivojolCfyFq8mmgx+i8+nMzfCVMkvmzgOhaHyHJ+GW5PKCux
         y4LrDFzCZ9GUaBfw7b/v/VPzts3OrrzNDJm5Orsva+cV3IuaLj8awNAPzB3LEy1AStu7
         M3P6XzAaHLQ1uullDaiNWw/xpwfx7tRGkwpdMmNeujw02McXPZfPeKTvafM8x9Ig1crv
         CyUXQV1PUOOqeUP+J6++WbBD6wJO0ngS50NoDJCoCVThx5tVRIS65X5U7WMQ0ChpvW8n
         TqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843213; x=1774448013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=doH9jKyIV2pcWr9QqHgYapLUvNmJgzZV6s5pft4p5hM=;
        b=RTgQKVjxuXxpPk0MClx3EY706wbJ1hrQlWduQqvmiBVBa1g/ndTRO3Wn1aBeLjkcPs
         JBtuMZZAurNAY76WMR35snCJx0IFhzhni/rl4LIQVkE0rIFmRIANPRL42g+YbvQducnI
         ALkeo+JyoYKMGGXpMBFyzqFS4ZB6Jx9hljLvFqoVK17jcQfTIg+CtFFxhrXJfY+d+yAB
         /rAHAZFjnpgowWwcYOBSDfi1g3zNjxKw7h4s/VnC72MNCvDAMyTIesg9BXq17iSupuow
         iHWWdlWDH2SkikNeDrZsizg+zzZfACyZdCuhrVQhmFQ60DliwQ/9G08hieLKlK2g4VN2
         YIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9EGpvn/7WogkpnTWP9FVpUchEhbutY9+fnTcowA8Ixbhj6qLRJSQofyCAj8zyRS9fCxk53is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK9cGaxs9wSd7NIUgk3hKfqf1KemPVYLRv39lLFgvnYzh5RmHf
	nuvji38lKUggFA85N8wzcWqXX4NYc7ZQk3R1Yir0xzp4PC7eqTtiPtGtF2RGFG8HythEev2BJ9W
	RCBQg+CBeEgYIBJvNsLR5gj7dq2VbKGWwEDvZg1HAcw==
X-Gm-Gg: ATEYQzx1kr97OgpURmTW4hIcceX7BB7eTbA2BV12gFJcA6I/Gg1rpzrcOrKAc23Z4hO
	Q1tzzmM4cVBiVUjtJ4q0iyTA8w9FzRgeu0Gq5ctePrVFdbUOOMjSlDj3zVYA2fmk1QnswBqoUhb
	TCFwt+yCAh1K7LsFU9TavhjpZ4sN1B73yQPA2P5T0YSKJfJYy+jUj9yl933K2KdZGQr5MkGkFS3
	URV5GafOtLsulet4vjms9oQLtfYlFtMdAb2Xoh9ALL8Q04wo7aV6m3vC7kSVq37EwFtnsMqvbdU
	UAt4Vfw=
X-Received: by 2002:a05:6214:2466:b0:89c:4cb3:4ea1 with SMTP id
 6a1803df08f44-89c6b50cda1mr53811646d6.20.1773843213183; Wed, 18 Mar 2026
 07:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org> <f7to6ktnjxi.fsf@redhat.com>
 <CAO7JXPhfpUb1VM_=mwSUqHPQrLvBW=wurz_apWQkMXssPAQPJA@mail.gmail.com>
In-Reply-To: <CAO7JXPhfpUb1VM_=mwSUqHPQrLvBW=wurz_apWQkMXssPAQPJA@mail.gmail.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 10:13:22 -0400
X-Gm-Features: AaiRm51A0epLogiUfwoUvX3H17X7FM-N_YItWsuNQqgGdOd0yFIoTXs_t_Yz52g
Message-ID: <CAO7JXPgiM12_KcM+-Kxw2A9yC7-G1wwXCmbyVqpAcckojfRrTw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bitbyteword.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269041-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	NEURAL_HAM(-0.00)[-0.921];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,infradead.org,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,ovn.org,vger.kernel.org,openvswitch.org,lists.sourceforge.net];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,goodmis.org:email,bitbyteword.org:dkim,bitbyteword.org:email]
X-Rspamd-Queue-Id: 000DE2BCECC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 9:40=E2=80=AFAM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> On Thu, Mar 12, 2026 at 11:31=E2=80=AFAM Aaron Conole <aconole@redhat.com=
> wrote:
> >
> > "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> writes:
> >
> > > Replace trace_foo() with the new trace_invoke_foo() at sites already
> > > guarded by trace_foo_enabled(), avoiding a redundant
> > > static_branch_unlikely() re-evaluation inside the tracepoint.
> > > trace_invoke_foo() calls the tracepoint callbacks directly without
> > > utilizing the static branch again.
> > >
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > > Assisted-by: Claude:claude-sonnet-4-6
> > > ---
> > >  net/core/dev.c             | 2 +-
> > >  net/core/xdp.c             | 2 +-
> > >  net/openvswitch/actions.c  | 2 +-
> > >  net/openvswitch/datapath.c | 2 +-
> > >  net/sctp/outqueue.c        | 2 +-
> > >  net/tipc/node.c            | 2 +-
> > >  6 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 14a83f2035b93..a48fae2bbf57e 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *h=
ead)
> > >               return;
> > >       if (trace_netif_receive_skb_list_entry_enabled()) {
> > >               list_for_each_entry(skb, head, list)
> > > -                     trace_netif_receive_skb_list_entry(skb);
> > > +                     trace_invoke_netif_receive_skb_list_entry(skb);
> > >       }
> > >       netif_receive_skb_list_internal(head);
> > >       trace_netif_receive_skb_list_exit(0);
> > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > index 9890a30584ba7..53acc887c3434 100644
> > > --- a/net/core/xdp.c
> > > +++ b/net/core/xdp.c
> > > @@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_inf=
o *xdp_rxq,
> > >               xsk_pool_set_rxq_info(allocator, xdp_rxq);
> > >
> > >       if (trace_mem_connect_enabled() && xdp_alloc)
> > > -             trace_mem_connect(xdp_alloc, xdp_rxq);
> > > +             trace_invoke_mem_connect(xdp_alloc, xdp_rxq);
> > >       return 0;
> > >  }
> > >
> > > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > > index 792ca44a461da..420eb19322e85 100644
> > > --- a/net/openvswitch/actions.c
> > > +++ b/net/openvswitch/actions.c
> > > @@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *=
dp, struct sk_buff *skb,
> > >               int err =3D 0;
> > >
> > >               if (trace_ovs_do_execute_action_enabled())
> > > -                     trace_ovs_do_execute_action(dp, skb, key, a, re=
m);
> > > +                     trace_invoke_ovs_do_execute_action(dp, skb, key=
, a, rem);
> >
> > Maybe we should just remove the guard here instead of calling the
> > invoke.  That seems better to me.  It wouldn't need to belong to this
> > series.
> >
> > >               /* Actions that rightfully have to consume the skb shou=
ld do it
> > >                * and return directly.
> > > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > > index e209099218b41..02451629e888e 100644
> > > --- a/net/openvswitch/datapath.c
> > > +++ b/net/openvswitch/datapath.c
> > > @@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_=
buff *skb,
> > >       int err;
> > >
> > >       if (trace_ovs_dp_upcall_enabled())
> > > -             trace_ovs_dp_upcall(dp, skb, key, upcall_info);
> > > +             trace_invoke_ovs_dp_upcall(dp, skb, key, upcall_info);
> >
> > Same as above.  Seems OVS tracepoints are the only ones that include
> > the guard without any real reason.
> >
>
> Makes sense. Its simple enough that I think I will include it as a
> separate patch in v2 and remove these changes from this patch. Thanks
> for pointing it out.
>
On a second look, I'm not sure if this was for performance reasons.
The discussion in the io_uring patch in this series points out that
the check made there was deliberate and for performance reasons to
avoid 6 mov instruction in the hot path. Just wanted to double check
if that was the case here, before I remove the check?

Thanks,
Vineeth

