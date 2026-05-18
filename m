Return-Path: <netdev+bounces-289112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCtRFXU1C2qgEgUAu9opvQ
	(envelope-from <netdev+bounces-289112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:51:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC7057050E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C85A30692AD
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A937266D;
	Mon, 18 May 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="EttVm0Sk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1842580F2
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118770; cv=pass; b=Nj3wvSAbFVtd+KbbXsOOwAONOfr5ky73JK1aihrA0AEVjG6zXx0PCdSjCeCYWrnYEfNDOX8FzqSaTShmq8eOtThC0qVNfGWdLwfnmktILMpTNCArwsRA8FwyXwtgRYHNJ44zhQJD60kbY8POqJpL6+oPtTbAHtkuypPm2t0zeZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118770; c=relaxed/simple;
	bh=vyYNJ7XpYeEnkwK3BYHt69QlJLS1/5r59S6tE4i5yXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbrRbtTJYA10mDL5bx5T0jUBaYJXSP62Ms+NlfgmdUmEhVbFg1WhlsAAM7nZNYZ3aZyzZlmW7P8KYeSx5BPfFSGePkxS5jygnEqI+grHvmAjIfon7nWBUE09RYTmOUV2A3H253EwRn+uDJIq1h0c1mze+9G0QEUP1tw9GaSLJ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=EttVm0Sk; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9382e59c0eso525360566b.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779118766; cv=none;
        d=google.com; s=arc-20240605;
        b=jaSmoz0FToKqg6biT0R2nCnLcA/1fq8UoHhBd9vIjhMXIKyEOKXskpBne3LcAO43wz
         Zh7rez9EWnaz7W5m2gTgNkMQQAI2hD7iQfgeFA03a84nLVRhmhuvYG5ZVHvhj73+c+Dr
         XKbdMLbtm3IYkWfr4ukm1yDNctpwBBWPZPQAI3W3iZavU3edeY569IupcHDMfZUTQ4Ws
         4QDrMHl3gd+AwMTO581RRdqXpGzce07FlLncIV23Lqzmb+QhINtIP/K+EIbGivdcYn4j
         iWQAvxJ7J+0tOXHt3i6mwmJV+4Opa/gdEch8kWbOMIIHoH02p7gblcmEi/OjJUc/J8t8
         z+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mAiS/PU3bePErAFFd9nG26hOAbKDwK6BHyjdnMancko=;
        fh=cznkss5kHzKwb2NgzOisRTQ83qnfKWQOYgQJFESzaX0=;
        b=O8Un68KUY6CSpwUnjYOPfikG8QSZVi2foPt9Nlh/RiAk+lRxUBLV1hR0bZl0zPpGUc
         grCZCAZALIuWKR+6zXhL1eLCw10vBA3N/HRGCtzjk0cD/0oE+TmpL1r1MFnx+oTb9gWu
         qCnn4fX7ufKOUwCgMeybfQP0zUTaJS5sWsoD/bMB2Q1pyugKKBKguF6443xGPOkdt+GP
         Lzk6hvI/nMKggryhwoD3zAzd9klTJWgkpYZeOUyyjpsq09Os9xMGP+2Eu7EoyTSl90OB
         ZThzbe9vGAsdWDWF0r+VixMcgmirHE+qc5Yl6AsAtmeQJU6IqAQ05VV0kU/dbG/Hb+V0
         MUeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779118766; x=1779723566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAiS/PU3bePErAFFd9nG26hOAbKDwK6BHyjdnMancko=;
        b=EttVm0SkFAqXkNf55kZLv8BkNrJnS+wufWtAlPzflBLazGdAs7Vb7iO23RPwmKBzuM
         /xUXy01RMfnkjilpSWwUypo2e79Fq0pZNAcNlWZ6lYHIi6u0omj2UPAvt7gW63lzGEqD
         dLtOYbsRaZ4h7NjdBVdCxPPX/r7a5HUEY911+Lb42k18U0IZwi+XCbhysGuaALJ+ZScA
         jb/YgGVVCIumMG7tVfySqihX1DlPpqim0DAdCrp4Wl+dAybKqt+Bn010yJoo3fh79en2
         Z5dypgUVmLB/BI7INMFpHmXMUZeAOvuQsJYJe9jdll8g7Z+0arIw2Me5mze/Lk18NYVU
         tu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118766; x=1779723566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mAiS/PU3bePErAFFd9nG26hOAbKDwK6BHyjdnMancko=;
        b=MSqxxz1C72w413a169K9FUsH+1FLIB+Nr298Na8oVOLUf9zJgB6/gWV9Xg6Rt2a4J1
         3neXtu8J7K6r0tJ17KOM7UxVJf7VIKd3kKGYiIXOuhAEvqks0DjQnqosfq7WUFkaH0N7
         yZhHfKa4wQMwxoTa+izu8/nedLxw/QacjZIBeO4NugcekyQW/LIj776cgfaXezqImgX5
         DItHNZbyoaUNqUywLc8U/HSFpIQCIZ9wPG2EJHNJlAQ5eTyx4IpWLPwJ7q9lh7WiX63d
         r/OyFkc4p1kpxhXfoIr16GMw+b/LjomGgs17brL4D+mnk9yOQ/hxiPjF5JWtNFh7Z1LQ
         9Tdg==
X-Gm-Message-State: AOJu0YwEpMPI60n7nisXfZNW9QZC8W7qYCbXx67NmPWJfZY47FSli0sn
	EAW2GBUAFpiEqYQIT0d6sPhHmls0cQZYd3W4MwG/ZwmMqtEpEnVZDhhN1uDJjPYq+GYwToP/JO/
	+IRY94DjmMee/HmIpnvdlXBM/O/GI90E77ryG61fY7EKQwCx+4Mm4NB8=
X-Gm-Gg: Acq92OGJDrG1CFgeiQua4wzznEI8ll+y2Q8H+jnH3G3rSSRXJ1i7gzf56GclyOUHcoZ
	RSZusVTu2Ja6ITbkLDsl4Z8+fwlMKZGnTt5nLl6Px3u5jWCcMKBzcR2TrZdx+fWaks7/tSkr8ON
	1PsjEbI17T9+PczSeG3Q3xiHy4+hG4Uwh5xdnKxZ9Hy4JJwetDrZjhTI7gOmT2aed/7/Tk1aNRR
	QXdj4yqyhRiVGjLt0BaBrCZceHqt73wMmTrk+jv4FSMZty8Wp792qiyXaoXmlGkD8v3gHjLBKcQ
	Ng8tnw==
X-Received: by 2002:a17:907:94d6:b0:bd8:1c88:cfef with SMTP id
 a640c23a62f3a-bd81c88d064mr206323066b.5.1779118766535; Mon, 18 May 2026
 08:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506161144.465485-1-louis.scalbert@6wind.com>
 <20260506161144.465485-4-louis.scalbert@6wind.com> <150323.1778580585@vermin>
In-Reply-To: <150323.1778580585@vermin>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Mon, 18 May 2026 17:39:15 +0200
X-Gm-Features: AVHnY4JSfaUzL0cWnDCABImV0YYMgETdVkT-I6q-c52BaBRS3l-saaFcorHGYW8
Message-ID: <CAJ5u_OctMHsbqrarP+9cewz6N-2o=ayvB0q34wxpf2HNnCZaSw@mail.gmail.com>
Subject: Re: [PATCH net v5 3/4] bonding: 3ad: fix mux port state on oper down
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, 
	shemminger@vyatta.com, maheshb@google.com, jonas.gorski@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289112-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,6wind.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DBC7057050E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Jay,

Le mar. 12 mai 2026 =C3=A0 12:09, Jay Vosburgh <jv@jvosburgh.net> a =C3=A9c=
rit :
>
> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>
> >When the bonding interface has carrier down due to the absence of
> >usable slaves and a slave transitions from down to up, the bonding
> >interface briefly goes carrier up, then down again, and finally up
> >once LACP negotiates collecting and distributing on the port.
> >
> >When lacp_strict mode is on, the interface should not transition to
> >carrier up until LACP negotiation is complete.
> >
> >This happens because the actor and partner port states remain in
> >Collecting_Distributing when the port goes down. When the port
> >comes back up, it temporarily remains in this state until LACP
> >renegotiation occurs.
> >
> >Previously this was mostly cosmetic, but since the bonding carrier
> >state may depend on the LACP negotiation state, it causes the
> >interface to flap.
> >
> >Move an operationally down port to the Mux WAITING state and clear the
> >Synchronization, Collecting, and Distributing states, in accordance with
> >the 802.1AX Mux state machine diagram.
> >
> >Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> >Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> >---
> > drivers/net/bonding/bond_3ad.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index 1247a1e048df..b531f68a24b0 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -1055,6 +1055,8 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> >       aggregator =3D rcu_dereference(port->aggregator);
> >       if (port->sm_vars & AD_PORT_BEGIN) {
> >               port->sm_mux_state =3D AD_MUX_DETACHED;
> >+      } else if (!port->is_enabled && port->sm_mux_state !=3D AD_MUX_DE=
TACHED) {
> >+              port->sm_mux_state =3D AD_MUX_WAITING;
>
>         Repeating my comment here from the prior version of the patch
> series, that this doesn't seem to comply with the standard.  Bonding
> should comply with IEEE 802.1AX-2014, and I do not want to mix and match
> from different versions of the standard.  The state machines differ
> between versions, and I don't know if a half-and-half implementation
> will function correctly.  The 2020 edition of the standard diverges
> significantly from prior versions, and bonding is very close to the 2014
> standard.
>
My bad. I assumed that 2014 and 2020 versions were similar.

According to IEEE 802.3ad-2000 and IEEE 802.1ax-2014, Collecting and
Distributing should be reset when a port goes down:
- In the Receive state machine, port_enabled =3D=3D FALSE causes a
  transition to the PORT_DISABLED state, which is expected to clear
  Partner_Oper_Port_State.Synchronization.
- In the Mux state machine, Partner_Oper_Port_State.Synchronization =3D=3D
  FALSE causes a transition to the ATTACHED state, which disables
  Collecting and Distributing.

The root cause of the issue is that
Partner_Oper_Port_State.Synchronization is not
cleared in the Receive PORT_DISABLED state.

Clearing this flag fixes the issue. I will publish a new patchset
version this week.

best regards,

Louis Scalbert

>         -J
>
>
>
> >       } else {
> >               switch (port->sm_mux_state) {
> >               case AD_MUX_DETACHED:
> >@@ -1202,6 +1204,11 @@ static void ad_mux_machine(struct port *port, boo=
l *update_slave_arr)
> >                       break;
> >               case AD_MUX_WAITING:
> >                       port->sm_mux_timer_counter =3D __ad_timer_to_tick=
s(AD_WAIT_WHILE_TIMER, 0);
> >+                      port->actor_oper_port_state &=3D ~LACP_STATE_SYNC=
HRONIZATION;
> >+                      ad_disable_collecting_distributing(port,
> >+                                                         update_slave_a=
rr);
> >+                      port->actor_oper_port_state &=3D ~LACP_STATE_COLL=
ECTING;
> >+                      port->actor_oper_port_state &=3D ~LACP_STATE_DIST=
RIBUTING;
> >                       break;
> >               case AD_MUX_ATTACHED:
> >                       if (aggregator->is_active)
> >--
> >2.39.2
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

