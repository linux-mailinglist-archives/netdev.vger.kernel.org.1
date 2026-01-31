Return-Path: <netdev+bounces-255480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGBgKepAfmmPWgIAu9opvQ
	(envelope-from <netdev+bounces-255480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:50:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50959C368D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89D723032CD0
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79C362142;
	Sat, 31 Jan 2026 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hY+mskVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE0361DB5
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881824; cv=pass; b=I3k5JiP9yYXnsPufXQ0fb87bdnMolyVKqz94ffddjY4lN+qsI3/hgpJSX830PKwhJS/iLO8nby+nG/UMCfU5KEDGrQbL19myR6mCXtsqhVghCZ3vlj2dgHAT3wCTVass6MCVNx7nk11XYGFfMYc+CJ2ActWZkG2wrUvxPobMDDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881824; c=relaxed/simple;
	bh=2Y2BujAHsclU7T5BY1yexqxfK32dnixNYzgQTFG2vI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRaaZOUo3VelfJh0xjARyyv2RGfDO1h8KSPFWHWx4YKHKbMxqozMJBWwuiHiwqi+X0ZWrHm3pErTflAQ37AAwWEFcxi5Jxho3LgGF5NpJ6/pzYU7ziRmdoLQ7L57L8PQGOJFT7vFYFgemLP5Bb41In/1f1IsQaSTaRIUIe+BlWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hY+mskVR; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-501488a12cbso37664601cf.3
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:50:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769881821; cv=none;
        d=google.com; s=arc-20240605;
        b=KsfjGpLS3iRp42ov3XZZp7srFY8aORK4WmqjryjY7rOBESveoiflzCCu2nTwdv4s7R
         KXdjm7oFeYfNIYNE8YrM0q7OG8HsMCqwvUnF7gs8dx5U3CbN7oSfDRcG4kymO9j+wLUX
         rJdh92DWml5UI7GFrCjSYYYklZIa9K6COLXoGfUw4dFH4B7XhbEBrYW/bWInIG+4Fc6a
         OwNt6TYapBjKOTxBXvBL1+sqDs2uHai7ebJ1SYZ5iSchHsYc9NUKCynD1QNZnn5mjxt0
         FfM+VTsiV85sOf0m64h6mxzjGWYC/XUtyI8Jg07yIY+hKo747RXH/cDEjRKFbtpt6sLK
         FlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K00MmcXjKYVCCFxtITvYE2L51mTblfO92rCXNxYYf0I=;
        fh=lVTVYsYmiuyJFbhGIHbxNRaEKPYGHeF1FnfZWxmq7tk=;
        b=H3xdj3GlMrUDSoDRCSg22NYpTSlaB1jjiT+OQsV7avFas9wtAA4qSlBuDC13hzAlPY
         8IfOHcZ89iWhaOLeO4UBkj+P0VdMst2G00PzRS1MpDSSoSQ9+/Eac/vPRs0QYRS0L3hp
         q6mxfc9C4kDdmA4SD1MqI9VTJA2I8Xb1aVvUC1NPbNKcwtluzwUJMpgPZus2qcmoHuuF
         QhI8SsssCALA361Oztsielpzoe5/uzHyQKzhQSxprOeUKJafJeMOzLt92FPhAYKU4zMT
         DCJ+QADpwh6ZLyCWQjDKzh0x/3s/4VPQD3LKySIiR767VbRQr3MjY2B/o+nUDX1rG++N
         XePw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769881821; x=1770486621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K00MmcXjKYVCCFxtITvYE2L51mTblfO92rCXNxYYf0I=;
        b=hY+mskVRNAei7n2iwD7rLHJuVjqFE2SfWwleMjlKRWhACc1LqQpXiGtebAit9AxJdo
         Kkw3V9PV3+Y7txeu5aBZ8+RL7EUecV06IP3d5UJYfW9eR/nDzJg6++HBxwn8gGOzGY+Y
         dS5vaRdOxIB/z2DXZE9124uhXBaAV0/posoQEqUMrhhtyr27b4oNJXcwcfl3ZHXus073
         H/3JAgrG768xsQPLaO/K+iOYY3fxFLi+BckWZSu7RwC1qadKarKJRyJcUZjNuopl5UXk
         i9VVaxgoeDiZKnvcuFTa4P3TwUL+NMFpP62JRSB+rh3UQXeYVfd8Jh+xvpA9f/3aCHio
         jISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769881821; x=1770486621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K00MmcXjKYVCCFxtITvYE2L51mTblfO92rCXNxYYf0I=;
        b=LZzcNBoxW56vApQV7rs7rXvYQZdF33jkZNzNTMCx3mo/p0kOIgwjwD2VuT+8PyyyF1
         c/jQp8oIJOyRa+2DrJEKi8Eh8BughRGRYm0UuSgmBgotOXPv1ft7zyV2VE3ISIZ/mG8B
         jP5Kq3Ia4CjdZz5nZtCshMo6npQBlmWq0YptfIbRm1up2vREA8M00VtKl4Bq2aX3+rX2
         d7qL/uVGTVPpi/X1ZxsP9X8PxVkIHKn5dnFPoOA4hIlACt7bJd5lKrfXy+fw8XQmyEwV
         3DeuwAGu2JxDS2p9EFXLHVw4RnmC0Tojb6kJaycnc0HDA2sF5S/Ne/Mcw/q1T8Wj9Fw9
         /pAw==
X-Forwarded-Encrypted: i=1; AJvYcCU58ex+wajBBfCzQsVqibAhciRXxf62EkrkZzbaQVxUfp2234eGA9dqTodgbYBiF9SqFOh5mu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygq84l3BFRTk7Se7Amlmjx/58oHOeIOMkr2puJYphDpdmsc6Fi
	x+7Pr+Ta9EvC7TL8hoK67H3HGo/RjaPEYYI5FXwtBxG0B/0NRl2Z2ZoqrsrHYAi4+ukHlO5s3tT
	lTfCqtLqgC+aZtfrOqtwjGKtQNNLCmHPui5+yHRBjqfiRzYLgldtYi8LxgUI=
X-Gm-Gg: AZuq6aIQxAtONbJQ9+qdZNruV/U0ZOj/OJFA/PsfQQNudYb3sTVYFLbkm1ohVvPuCa5
	XfMPbgpeOKOGQ3/D4xpNDSj1IkvNZiun1LhT/QXtbhIvsSQZd0847AiZhURGKqFoWqZsvRQZ1Jl
	RksUKssjK2Gc6S11v8jVzNWdwSjB2qbfE6QcY5T05MlljBDjOFHuFRBjM8I5FQP8uNnwG92VX1o
	POBWdONbp7MskI2MlBw8gvTQ3DK65p/oUcyPXSJw+y7iz8QX5cww1MRznTE/YrQUv8sew==
X-Received: by 2002:ac8:7fc3:0:b0:4ee:4a3a:bd07 with SMTP id
 d75a77b69052e-505d22b1c9dmr93283271cf.75.1769881820961; Sat, 31 Jan 2026
 09:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128070359.6762-1-fengwei_yin@linux.alibaba.com>
 <20260130191845.404c5e64@kernel.org> <willemdebruijn.kernel.39472926ed88e@gmail.com>
In-Reply-To: <willemdebruijn.kernel.39472926ed88e@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 31 Jan 2026 18:50:10 +0100
X-Gm-Features: AZwV_QhflGpRC729rLlBZ22ro3ARXyRtEbQgBianeoaVabhAatyw3CIVru6iAYQ
Message-ID: <CANn89i+pv6ECtn5zrPYgUfcKkoEMF1BABfxQb13yTP41QhcGvg@mail.gmail.com>
Subject: Re: [PATCH] net: procfs: Fix RCU stall and soft lockup in ptype_seq_next()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, fengwei_yin@linux.alibaba.com, davem@davemloft.net, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255480-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 50959C368D
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 6:41=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jakub Kicinski wrote:
> > On Wed, 28 Jan 2026 15:03:59 +0800 fengwei_yin@linux.alibaba.com wrote:
> > > The root cause is in ptype_seq_next(): when iterating over packet
> > > types, it's possible that a packet type entry (pt) has been removed,
> > > its dev set to NULL, and pt->af_packet_net is not initialized.
> > > In that case, the function may return the same 'nxt' pointer indefini=
tely.
> > > This results in an infinite loop under RCU read-side critical section=
,
> > > causing an RCU stall and eventually a soft lockup.
> > >
> > > Fix the issue by properly handling the case where 'nxt' points to
> > > an empty list, ensuring forward progress in the iterator.
> >
> > > @@ -247,7 +247,7 @@ static void *ptype_seq_next(struct seq_file *seq,=
 void *v, loff_t *pos)
> > >
> > >     if (pt->af_packet_net) {
> > >  net_ptype_all:
> > > -           if (nxt !=3D &net->ptype_all && nxt !=3D &net->ptype_spec=
ific)
> > > +           if (!list_empty(nxt) && nxt !=3D &net->ptype_all && nxt !=
=3D &net->ptype_specific)
> > >                     goto found;
> > >
> > >             if (nxt =3D=3D &net->ptype_all) {
> > > @@ -267,6 +267,9 @@ static void *ptype_seq_next(struct seq_file *seq,=
 void *v, loff_t *pos)
> > >                     return NULL;
> > >             nxt =3D ptype_base[hash].next;
> > >     }
> > > +
> > > +   if (list_empty(nxt))
> > > +           return NULL;
> > >  found:
> > >     return list_entry(nxt, struct packet_type, list);
> > >  }
> >
> > I'm not sure this fix works, TBH, we're dealing with an RCU list here.
> > The elements are not deleted with list_del_init(), so they won't
> > look "empty".
> >
> > If the pt entries are under RCU protection I think the issue is that
> > af_packet is clearing pt->dev before waiting for the grace period to
> > expire.
> >
> > Willem, is there a reason for that or just convenience?
>
> That would be wrong. Do we see it doing that somewhere?
>
> These handlers should get removed with dev_remove_pack. Or
> __dev_remove_pack and observe the RCU grace period some other way.
> I can review these, but was not aware of any abuses.
>

packet_notifier()

case NETDEV_DOWN:
if (dev->ifindex =3D=3D po->ifindex) {
spin_lock(&po->bind_lock);
if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
__unregister_prot_hook(sk, false);
/* removed without a synchronize_rcu() */
sk->sk_err =3D ENETDOWN;
if (!sock_flag(sk, SOCK_DEAD))
sk_error_report(sk);
}
if (msg =3D=3D NETDEV_UNREGISTER) {
packet_cached_dev_reset(po);
WRITE_ONCE(po->ifindex, -1);
netdev_put(po->prot_hook.dev,
   &po->prot_hook.dev_tracker);
po->prot_hook.dev =3D NULL;                       // pointer set to NULL
}
spin_unlock(&po->bind_lock);
}
break;

