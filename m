Return-Path: <netdev+bounces-302282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8qL+AkUbP2qUOwkAu9opvQ
	(envelope-from <netdev+bounces-302282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:37:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF966D09FE
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:37:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PuHBlwib;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302282-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302282-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C01F1303C4EE
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E5B19B5B1;
	Sat, 27 Jun 2026 00:37:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790D1632E7
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 00:37:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782520637; cv=pass; b=ckDXoPJQIYh423ZjFbkCNg5qQDS/sUHjEI1Av/qdfe7GWtx4SUOxvMjaiN8DM8az+nudPRBQrQdGjdi8Pn0XVi0Vy7KYiXOJ1bo+JLKOQOhTg+8vuvFmYja5XrUdt+9u1ztFdZXKSZrlo8OhL3Z7YKMsftDpcn7lbbMrawxBSLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782520637; c=relaxed/simple;
	bh=LsUaRFmdz/PSpFuv9MCZTAI8th0AS1wcvMyHgaWY/KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXsEOGlALZToMlOwMgC148Gt3JOqCI32A0zbW7ae0h+a1HN1l5AG8uzm3KbUFGLeMoOvYKj+D1Ck85pm45rW8nHI2BEcVHcqFXzDeoRZpgf6UqTIH/kprj9Kh74HGth8B+dbbPvKzctDN5aj9Rwfz+YNFDONHN93Ef/Fi3DUjLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuHBlwib; arc=pass smtp.client-ip=209.85.167.42
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aea7e6220aso1038764e87.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782520633; cv=none;
        d=google.com; s=arc-20260327;
        b=YG1GyDljlrmdgAY7C6IyzT2Go4OHXl4QgZsKAMLj/UWpdHjnCr0Zs4kMH+naajOlR0
         Hmx+Vi2nRZEr7vWTp9T5mFdMVCDguSdU5p+Dvgze4/p+SUf2AhnoIf/HUcTJ0n4DhIAD
         YB73LsvGXW+BdmXQ4WCksZl4lKmCBr1f4veAV3sPbAjwkAzUhykMwkPtgCkRLb7wc7+t
         Y3upgS9xhCY/5iphDXx6sywLCAPe4zdHE/iYiWwjGfnzUWFY0wtHrl4DZ5lK8AoGJILD
         dP4ygQdQtPfMjo6bgj2D8fm1WIzbu1ARjZACzVov3+uSnpu+KupaJ2WmIJbptVqCMqs1
         YqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRctBiwHak3TEjMfcTZZ+O2QEFJOYwmchGqXk/RduXo=;
        fh=zbRPPG/cBRIkKKQ/kv7gTUOc3bwtpMTGGHgKdw14rQY=;
        b=Y5wOPM73Ao1TzQ9WUQzJqRF088pnov6nVpMxLEirL/G1R1WK6puY2a0BR0KT+YWEkD
         EIhCCW80avNdEvAvKhWgGpQGIlsAl3y9rUBalnqOeUd+lq779+Fdwr1RUs4jEyomgq3Y
         yg0cHYTjDSGfRUpRcQg14neQT1o6riD3fs3SI7V2+af4v3OfD4Dqk+upun3fISZ8WwMn
         5reGvuCTiQr/CU00t5fyr0jSF8Tg18d/91rnlO7f4nPjPFBf1o+ES2hFfNKf2A8DCcyZ
         U4ck/DFILdMFXbCscfgrFlA7Xige/QVJyG9SoLEW0nPMqzBweCYb3qdek7fO8XDkFMI4
         GLlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782520633; x=1783125433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRctBiwHak3TEjMfcTZZ+O2QEFJOYwmchGqXk/RduXo=;
        b=PuHBlwibcfpXDd3l06RRFz+kPEUt8ugSv2J4Gy24lAd6++bHYhmYbVblB9j3gAIQgb
         Lslp0SzxIwtEsknydJtkt8xCVPX4QMGfaQlThAMnboxU9UgQ9MFMiI8PwmwTwlfyrzB+
         xqrziIKf/JnRqaLBNIOdfs7abHJmiVTGaQj+nNxSUg+2RJyy1dY5tQckiVj6+PviFyLD
         lHAz/3Nz1Aa73FpuvD8sPJcJrLeMFEq1YtvZJty/0roVvIgCPNotKHe89+rWHzNf2vCC
         uCYmi9DvSPULTg83RAx1CV0g+Jktj/U72TfY2DXwPx85jvJt/6mrwSXgxbnnCLT2HaWS
         o5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782520633; x=1783125433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRctBiwHak3TEjMfcTZZ+O2QEFJOYwmchGqXk/RduXo=;
        b=O21w4/vh+x6YPgRAeqMMvregSTOD5UxWcqhRkEy56IjoBbwOqFNYOpE9Bj8s+HTXvG
         ozhwOrTXypUTwWaO2gTpJKQpqD/ZnVTFbUXkV00YcrXEWqAcfS89kdbN+pwR05mZktpr
         8panpnJurvwIjrWNFc9wGydNZHlvVcpa4rWX0OUYApy5C0LBpSiX7kbcukH9CqOhwkSD
         lsJW2jt8mU5Ho/dl82X2hPN70aBseEtA061HZF9dnKT3SSuWlovfa/MKbCJceQHxNok6
         xSVvrzgJ56Hm+IbDknFhqU1+GgRSzgh7nLDssY+M0tfT8pCjs1Q5vjClHcGeK9ADmDM9
         0hxQ==
X-Forwarded-Encrypted: i=1; AHgh+RraWh4PqLd3bwT5oZd+11ihaunQqNPABUoB4zMFf//vQ4SUGupM7iMgXzwoaeFFAI9M08TcKRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjDa9656LR416EyAAmUKIonuA/8Hbr7epnt5jFsUls7VF5SWN
	BMI0Ijnml7lq0RWJguosN0oIvTLoeET3lLM9hDZYdaUbRpOj3XcoxlVN9DbeJVCwHYwqOjGvHr2
	wL5wM2sKdSYhZh4jzghX0AiuEdwAAGTE=
X-Gm-Gg: AfdE7cmHf1tAu+/Jtn4dJQkZ/PkxavMyFOYEMnBxtrvRjNeV93ph4fbXaHcH5qRJP9K
	ldO4H4F17dte2b3xZj7LZBgXQLYVOFdcsbRuF6CMLo4ut9H7BrcvQVcwD09ivzFpzG+COkL5Rc1
	XrrwqodxpoNeyXSuJNI36YfDAYfplvknjH5ZJvWeqXjyTq1vPpgEQLQtnxB+z7ZBWd7yg2167/2
	8hxILWZoripihfuOPjMLH/czGA1WmtyfJomSgzadLjD0iGwdEi+LVPIyky3wowoouKCcsMMKPBd
	JIOjsq4AxBNoQQTgmp3TriSLoNBR+y3eSYuUGTsnXgiXn0C9AK9E4sTvEj9BQ8uGZvDqXax9HPk
	QOwkhPAhgOQ==
X-Received: by 2002:a05:6512:2607:b0:5aa:6f5d:ee09 with SMTP id
 2adb3069b0e04-5aea1f2d737mr2242536e87.14.1782520632585; Fri, 26 Jun 2026
 17:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-2-maciej.fijalkowski@intel.com> <aj5egH5eDwfsY30-@soc-5CG4396X81.clients.intel.com>
 <CAL+tcoBCsn+b5bY-XAhbEw6wvceMNQwkyry0_NUun1AcR0b6Ag@mail.gmail.com> <IA1PR11MB60978AF3799FD895C53A860882EB2@IA1PR11MB6097.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB60978AF3799FD895C53A860882EB2@IA1PR11MB6097.namprd11.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 27 Jun 2026 08:36:34 +0800
X-Gm-Features: AVVi8Cc9CO4LV9MdWtySaQn6G4drH6It2k5fdC5KsK4enM0jJvPxWnqkLv-4J4A
Message-ID: <CAL+tcoD0sNmRKP+4SGT9C5eZPyc4vU4E3XHs7JV7rgJ_SmgzLg@mail.gmail.com>
Subject: Re: [PATCH net 1/7] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP
 multi-buffer Tx
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: "Zaremba, Larysa" <larysa.zaremba@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, "stfomichev@gmail.com" <stfomichev@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-302282-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:roman.gushchin@linux.dev,m:larysa.zaremba@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:kernelxing@tencent.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,kernel.org,redhat.com,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,tencent.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EF966D09FE

On Fri, Jun 26, 2026 at 9:43=E2=80=AFPM Fijalkowski, Maciej
<maciej.fijalkowski@intel.com> wrote:
>
> >
> > On Fri, Jun 26, 2026 at 7:12=E2=80=AFPM Larysa Zaremba <larysa.zaremba@=
intel.com>
> > wrote:
> > >
> > > On Tue, Jun 23, 2026 at 03:32:34PM +0200, Maciej Fijalkowski wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > This patch is inspired by the check[1] from sashiko. It says when
> > > > overflow happens, the address of cq to be published is invalid.
> > > > Actually the severer thing is the whole process of publishing the
> > > > address of cq in this particular case is not right: it should truel=
y
> > > > publish the address and advance the cached_prod in cq as long as it
> > > > reads descriptors from txq.
> > > >
> > > > The following is the full analysis.
> > > > xsk_drop_skb() is called in three places, which all discard a parti=
ally
> > > > built multi-buffer skb:
> > > > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds
> > MAX_SKB_FRAGS
> > > > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
> > > >    the TX ring prevents the partial packet from completing
> > > > 3) xsk_release(): socket close while xs->skb holds an incomplete pa=
cket
> > > >
> > > > In all three cases, the TX descriptors for the already-processed fr=
ags
> > > > have been consumed from the TX ring (xskq_cons_release), and CQ slo=
ts
> > > > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> > > > which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> > > > the buffer addresses never appear in the completion queue, userspac=
e
> > > > permanently loses track of these buffers.
> > > >
> > > > Fix this by letting consume_skb() trigger the existing xsk_destruct=
_skb
> > > > destructor, which already submits buffer addresses to the CQ via
> > > > xsk_cq_submit_addr_locked().
> > > >
> > > > Note that cancelling the descriptors back to the TX ring (via
> > > > xskq_cons_cancel_n) is not a appropriate option because an oversize=
d
> > > > packet that always exceeds MAX_SKB_FRAGS would be retried indefinit=
ely,
> > > > which is an obviously deadlock bug in the TX path.
> > > >
> > > > Also move the desc->addr assignment in xsk_build_skb() above the
> > > > overflow check so that the current descriptor's address is recorded
> > > > before a potential -EOVERFLOW jump to free_err, consistent with the
> > > > zerocopy path in xsk_build_skb_zerocopy().
> > > >
> > > > [1]:
> > https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > >
> > > This change looks good, but overflow case with only 1 descriptor worr=
ies
> > me.
> >
> > I presume you referred to xsk_build_skb_zerocopy()?
> >
> > > In such cases, once we get to following code, kfree_skb() has already
> > happened:
> > >
> > >         if (err =3D=3D -EOVERFLOW) {
> > >                 if (xs->skb) {
> > >                         /* Drop the packet */
> > >                         xsk_inc_num_desc(xs->skb);
> > >                         xsk_drop_skb(xs->skb);
> > >                 } else {
> > >                         xsk_cq_cancel_locked(xs->pool, 1);
> > >                         xs->tx->invalid_descs++;
> > >                 }
> > >                 xskq_cons_release(xs->tx);
> > >         }
> > >
> > > kfree_skb() should have resulted in submission of the single fat desc=
riptor to
> > > xsk_cq_submit_addr_locked() via xsk_destruct_skb(), so far consistent=
 with
> > the
> >
> > At least, in the NO_LINEAR case, xsk_skb_init_misc() is not called
> > since the OVERFLOW skips this function, which means kfree_skb()
> > doesn't invoke xsk_destruct_skb() to publish it in the CQ. So it's
> > safe to cancel the cq reservation (in xsk_cq_cancel_locked(xs->pool,
> > 1)).
>
> (responding from outlook so apologies for any broken formatting)
>
> Yes, I have the same understanding here. However, how technically
> possible would it be to produce > MAX_SKB_FRAGS from a single
> AF_XDP descriptor?

Very unlikely. But my viewpoint might change after a wide deployment
internally in the second half of the year.

>
> I know Sashiko has pointed this out and you came up with previous
> fix, but for valid descriptor it is simply not possible. And invalid
> descs wouldn't reach this function.

Yep.

>
> I wouldn't like to stir up the pot too much so let us keep this
> code, but is there any way to give Sashiko additional context?
> I mean, for case where we would say *this can't happen*, will
> It be able to carry this information onwards?

I don't know about how sashiko works, sorry. Maybe @Roman Gushchin has
unique insights on this?

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> > > multi-descriptor bevaior you are proposing here.
> > >
> > > But what happens when we cancel a submitted CQ slot via
> > > xsk_cq_cancel_locked(xs->pool, 1) in the above code?
> > >
> > > >
> > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on T=
x
> > path")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/xdp/xsk.c | 13 ++++++++-----
> > > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index b970f30ea9b9..a7a83dc4546a 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -794,8 +794,11 @@ static void xsk_consume_skb(struct sk_buff
> > *skb)
> > > >
> > > >  static void xsk_drop_skb(struct sk_buff *skb)
> > > >  {
> > > > -     xdp_sk(skb->sk)->tx->invalid_descs +=3D xsk_get_num_desc(skb)=
;
> > > > -     xsk_consume_skb(skb);
> > > > +     struct xdp_sock *xs =3D xdp_sk(skb->sk);
> > > > +
> > > > +     xs->tx->invalid_descs +=3D xsk_get_num_desc(skb);
> > > > +     consume_skb(skb);
> > > > +     xs->skb =3D NULL;
> > > >  }
> > > >
> > > >  static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > > > @@ -877,7 +880,7 @@ static struct sk_buff
> > *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > > >                       return ERR_PTR(-ENOMEM);
> > > >
> > > >               /* in case of -EOVERFLOW that could happen below,
> > > > -              * xsk_consume_skb() will release this node as whole =
skb
> > > > +              * xsk_drop_skb() will release this node as whole skb
> > > >                * would be dropped, which implies freeing all list e=
lements
> > > >                */
> > > >               xsk_addr->addrs[xsk_addr->num_descs] =3D desc->addr;
> > > > @@ -969,6 +972,8 @@ static struct sk_buff *xsk_build_skb(struct
> > xdp_sock *xs,
> > > >                               goto free_err;
> > > >                       }
> > > >
> > > > +                     xsk_addr->addrs[xsk_addr->num_descs] =3D desc=
->addr;
> > > > +
> > > >                       if (unlikely(nr_frags =3D=3D (MAX_SKB_FRAGS -=
 1) &&
> > xp_mb_desc(desc))) {
> > > >                               err =3D -EOVERFLOW;
> > > >                               goto free_err;
> > > > @@ -986,8 +991,6 @@ static struct sk_buff *xsk_build_skb(struct
> > xdp_sock *xs,
> > > >
> > > >                       skb_add_rx_frag(skb, nr_frags, page, 0, len, =
PAGE_SIZE);
> > > >                       refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc=
);
> > > > -
> > > > -                     xsk_addr->addrs[xsk_addr->num_descs] =3D desc=
->addr;
> > > >               }
> > > >       }
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > > >

