Return-Path: <netdev+bounces-269873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IhfoCGEbvWkB6wIAu9opvQ
	(envelope-from <netdev+bounces-269873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:03:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA052D86C8
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A796D3076738
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AE346E43;
	Fri, 20 Mar 2026 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="h2JzDtdU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6228F935
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000908; cv=pass; b=YFnFRXmLLpnlFBJvobr8QTfnv+UXgGGe+2gE6+l0A4vsYOglcu+ekeJVdzZUlX58WU+QsMX1N6ruZZzr87kYdpZjWORuHJxLWjivhLRbPgycj08WwYq6yr5JCBU3maC1HKKv+xh/qsztvDeKRI+j7kbS9j3L8SQJgCrOKJTaA9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000908; c=relaxed/simple;
	bh=LZf0bZ25Chu0GbSjn1yvyLTs8TXVIXLyOw6BcTV6MtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWI0JdSm6/FIvH9i9bdj6ttDQFpEJBCNVdKOvedgWGMVopAfoWEvC7Lsh1DkjQh0KNSRuDTeLNhDMbtDXwqpqOQlu9yYfhx2aEqfY7NNXXRUqeXk3hwKYqc2GpA7QLUG2oa7q8L2tL/7DLZkZJvNaa5Gz2hX1jEmiHYD5CjP/dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=h2JzDtdU; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso2612042a12.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 03:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774000905; cv=none;
        d=google.com; s=arc-20240605;
        b=eY2MWP+O56+jARBQoNYHFZWxnnLtsZmeaGwez9hQvGv8WLYAi97QdC8JkIfVmSP7tV
         Oh1Evo11mCckfqWNjxWBy8sAzjk7kxpH8PzQGyxD3AJYgmCJy4SP/c0dXqs19fusQQ1r
         FnUOaINn4b9lWuwzdPp92Th51Yvzlpie+VtUpJhe2f3ZDn2Bx1RoGJ9EeTlEeQkuQGdW
         SgU0Hpmz1RLhgyyVRgoxB+474CQvSfJdD14t8SA+t7dfTm4w4zDkx5SiOIQoRY2DE2Dg
         rKc/Gc58l9EQVy3ErHTAq4zVo7nq8M2NwajWtExHhKSFV8rNm5i0jgKaOZ3QT33SLpF1
         frYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mc5qlKFnsnxGQkzuWZOgpev+WoqY1ijdIsS0JSYOCf8=;
        fh=peeRqe6xFmL8vnYQdpz8Sfexgod6WGUsvBvHNpoaKGE=;
        b=dQNL81CEokXGk7AZoPGsx39RcEmyAA7ywUgF/dt2pkbYnjEmbZ2J7/F7umC6wOl570
         gUqIVTBZjUUVwEKnuyznAQhtjSJGFbz+BF6XLNYEifmGw8aDkZKPFjjNVU9mghPzh+sD
         KQ6cNKBUO6FMNkvdqabfOTKaMHbT6a0YncdGaE6cRFGfbtJN2+nH/zDtnqjsii2F0k7C
         g0XTev1hVQIsoaVRG5aOGS2LZ2bm7pV3rkKJgh+JhJdur26FNzDJz46IcQk+4uoTrVBd
         bQiw/R3Lr4OavAq7uYPFlyCKQCRqLfM7LkwGedgDfp9EXLGmHEcu/SAmbQs7O7YgVGs8
         TIcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774000905; x=1774605705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc5qlKFnsnxGQkzuWZOgpev+WoqY1ijdIsS0JSYOCf8=;
        b=h2JzDtdUBsXIQUDXaZPtavh183jYPYn8HxChJqElp7JmmJH2cBzyMnJLPT2gjwJpg+
         fP3diTfHuaqjOaKIyK4wz099F6RGbLNKccMinH3DaecU9zrRqjnD66jiyy7D5XtHwCGA
         7+RDyjaPZ4UQCpkRxSGg1HZpBj+yXOfpOwa+/iBLisJdFf74O4SWm1Gm7IyJ5u605jiW
         kssDuD1URyGLNKqTlG3/xut9r0f/hfiTSQqBfmFn0VYwMQKbR3gfzaT4V+UaxFeiSYvW
         rttYgUQ6ZGEdx2X07YO8e3YCadWNsebg1ozDLIJCtKgnE7Bwbmbd4Dytk8DYFoCixyhM
         LM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774000905; x=1774605705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mc5qlKFnsnxGQkzuWZOgpev+WoqY1ijdIsS0JSYOCf8=;
        b=d9JZC/vjXtOyU9Pb4i4m2HQEuGw9AF9b8occcES87luS+wAMU7b4akmNoFKjPmLiNv
         AYvE3CGrjr4OfP3E3tOC6hJfNWdq7aVGQ/eMDeEH1DUwtSaPuCX7fFQ+zPWzy4IFKlRH
         Fq7QZf7xjr3UlN6Fvs16oex21HVLJH9UXKpKVK7nDyZtDVC5YLK0sEu8zbjY+8Ru021G
         QjUXK1kxur5GKFloyWiwfIZXBZs/FPoER7XY4eEdLAFMtDeRQX0dI9qa01PHr9EjxCtP
         nuzN2K0k1DTKF4BuPfE6hLTU6q62m+GiWrqlpDu0IUewrkaqQ/RvD0wy0g3wUiOHSdqv
         osSw==
X-Gm-Message-State: AOJu0YxxuWfGiKrb1Sz2prk+D88K1gOnkYKfKJlsIP+E2YldSkfF/E/V
	sBc+ZXN0CwTi8/ExfbR8s/FuOf3VJdSjOHijNQ6J4HRfq2oB0BFULQtCL7BmVK+Or5a8cyla0lk
	4WenePLqpeiNNfjyDbdIb5zCcty+dh+5xOK5M4jpmrQ==
X-Gm-Gg: ATEYQzzxmLw4B71Zl290quIdB7evdUnP0iiStkamq+/ElC+dWeUQBPJyZvOXlSvkkPl
	dyzssZORlzyI8cnCvJdNLDU7EfOlRvkdbRtWJBsnkY9sx4G72obTkiZxGynxj+xLZg+1hRXpA+Z
	4n980IfLyO9HjNoYRy2ER/8Xdhdyg0wmu7vegA43nAiD0mwSZlSeLB9rVORmwBfWDWMX629Brm5
	uL/YcjW7zSE9gOv04bEn4EIdYNjJF3x0lDKpSfumP+NAhXIZub1r5TxSitrvZVCBIXtY9xe77XM
	JQUsAQ==
X-Received: by 2002:a17:906:5905:b0:b97:d30f:cce8 with SMTP id
 a640c23a62f3a-b982f36e0d7mr140880166b.27.1774000904766; Fri, 20 Mar 2026
 03:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316131838.3257889-1-louis.scalbert@6wind.com>
 <20260316131838.3257889-3-louis.scalbert@6wind.com> <1944595.1773884448@famine>
In-Reply-To: <1944595.1773884448@famine>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Fri, 20 Mar 2026 11:01:33 +0100
X-Gm-Features: AaiRm50XeFxDRTh7wOOpw5az60owKPbi5qz11VSb3r9DFealaqYWygK2_4VPHx8
Message-ID: <CAJ5u_OfqTsFFWXTz_we=hZ3N=qG8YOkwMSAC+0kEd7LjUoKZmA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] bonding: 3ad: fix mux port state on oper down
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, 
	shemminger@vyatta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269873-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,6wind.com:dkim,6wind.com:email]
X-Rspamd-Queue-Id: 2AA052D86C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for the review.

Le jeu. 19 mars 2026 =C3=A0 02:40, Jay Vosburgh <jv@jvosburgh.net> a =C3=A9=
crit :
>
> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>
> >When the bonding interface has carrier down due to the absence of
> >valid slaves and a slave transitions from down to up, the bonding
> >interface briefly goes carrier up, then down again, and finally up
> >once LACP negotiates collecting and distributing on the port.
> >
> >The interface should not transition to carrier up until LACP
> >negotiation is complete.
> >
> >This happens because the actor and partner port states remain in
> >collecting (and distributing) when the port goes down. When the port
> >comes back up, it temporarily remains in this state until LACP
> >renegotiation occurs.
> >
> >Previously this was mostly cosmetic, but since the bonding carrier
> >state now depends on the LACP negotiation state, it causes the
> >interface to flap.
> >
> >Fix this by unsetting the SELECTED flag when a port goes down so that
> >the mux state machine transitions through ATTACHED and DETACHED,
> >which clears the actor collecting and distributing flags.

I will add in the next version: Do not attempt to set the SELECTED flag if =
the
interface is still down (!port->is_enabled).

>
> >
> >Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> >Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> >---
> > drivers/net/bonding/bond_3ad.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index 7d7661972c5e..367d89977000 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -716,6 +716,8 @@ static int __agg_ports_are_ready(struct aggregator *=
aggregator)
> >               for (port =3D aggregator->lag_ports;
> >                    port;
> >                    port =3D port->next_port_in_aggregator) {
> >+                      if (!port->is_enabled)
> >+                              continue;
>
>         Your commit message mentions clearing SELECTED, further below,
> but not the new two tests for port->is_enabled.  In this change,
>
> __agg_ports_are_ready is testing that all ports of an aggregator are
> READY_N, but if a port of the aggregator is not is_enabled, then
> logically it would not be READY_N, either.  So why exclude it here?

__agg_ports_are_ready was testing that all ports were READY_N independently
of the ports operation state (up/down). Now, it is testing that only
the enabled ports
are READY_N.

>
>         Is a this is an optimization to settle the aggregator state more
> quickly, as an !is_enabled port is likely to be transitioning out of the
> aggregator?

This is not an optimization, but a fix for a side effect caused by unsettin=
g
the SELECTED flag: after a link comes back up, it may no longer be able to
renegotiate LACP.

Consider the following scenario:

1. All aggregator ports go down
  - The SELECTED flag is cleared on all of them.
2. One port comes back up
  - Its SELECTED flag is set again.
  - It enters the WAITING state and gets its READY_N flag.
  - The remaining ports stay UNSELECTED. Because of that, they cannot enter=
 the
  WAITING state and therefore never get READY_N.
  - __agg_ports_are_ready() returns 0 because it finds a port without READY=
_N.
  - As a result, __set_agg_ports_ready() keeps the READY flag cleared on al=
l
  ports.
  - The port that came back up is therefore not marked READY and cannot
  transition to ATTACHED.
  - LACP negotiation becomes stuck, and the port cannot be used.
3. All aggregator ports come back up
  - They all regain SELECTED and READY_N.
  - __agg_ports_are_ready() now returns 1.
  - __set_agg_ports_ready() sets READY on all ports.
  - They can then transition to ATTACHED.
  - Negotiation resumes and the aggregator becomes operational again.

The fix is to consider only enabled ports, which allows negotiation to proc=
eed
in step 2. In that case, __agg_ports_are_ready() returns 1.

The solution is consistent with IEEE 802.3ad, which states:

"The Selection Logic asserts Ready TRUE when the values of Ready_N for all =
ports
that are waiting to attach to a given Aggregator are TRUE."

An even more accurate fix would be to check only ports currently in the WAI=
TING
mux state for READY_N. I plan to send a new version implementing that behav=
ior,
and to move the __agg_ports_are_ready() change in a dedicated commit.

>
> >                       if (!(port->sm_vars & AD_PORT_READY_N)) {
> >                               retval =3D 0;
> >                               break;
> >@@ -1570,6 +1572,9 @@ static void ad_port_selection_logic(struct port *p=
ort, bool *update_slave_arr)
> >       struct slave *slave;
> >       int found =3D 0;
> >
> >+      if (!port->is_enabled)
> >+              return;
> >+
>
>         Same question as above, why exclude !is_enabled ports here?

This function is intended to transition UNSELECTED ports into the SELECTED
state. The change prevents attempting this transition while the port is sti=
ll
down.

I will add a comment here in version 2.


>
>
>         -J
>
> >       /* if the port is already Selected, do nothing */
> >       if (port->sm_vars & AD_PORT_SELECTED)
> >               return;
> >@@ -2794,6 +2799,7 @@ void bond_3ad_handle_link_change(struct slave *sla=
ve, char link)
> >               /* link has failed */
> >               port->is_enabled =3D false;
> >               ad_update_actor_keys(port, true);
> >+              port->sm_vars &=3D ~AD_PORT_SELECTED;
> >       }
> >       agg =3D __get_first_agg(port);
> >       ad_agg_selection_logic(agg, &dummy);
> >--
> >2.39.2
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

