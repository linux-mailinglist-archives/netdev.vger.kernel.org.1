Return-Path: <netdev+bounces-284502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDaiBtUX+mlYJQMAu9opvQ
	(envelope-from <netdev+bounces-284502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:16:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF94D1153
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29EE5300D145
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941CF481FB8;
	Tue,  5 May 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="bMOsNSIP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCA48095A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997419; cv=pass; b=eo9RfPmKMr9XXwzHhDDKR/lzFV53G46dxo5tNeV7mnqhnUXlWjVJ8Tgmb/8gZimDqYPmGvBlBGBcT9iNX3ldhOLVrCM38PkXRTkRqPNcgvC0kw3ectZ9SZ0TAYMdPisLFKze8LeP8B9lSBUBnwwe0XybtMiRiyPZirrII58Kyok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997419; c=relaxed/simple;
	bh=Z0rIC/cx5i0Js1KOIk9f3HJePiP8tqlo7jKj0hmDWVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHAaQxY54clmxQ7GTZkjYkXdk5dneAxZBPOQdrmDxC8OHvGRgmCfc4lX2WSB1hF6Ml0DUXXeXDBdzpCDCWuemEr624G9xuwLd3xbqQejasGIDDnpS0LVM1QnB4FlP6aMCfd7xKivgbvdKR6LijYMFB923bx0SyepRt4iNDg9xqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=bMOsNSIP; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b936331786dso649386166b.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777997416; cv=none;
        d=google.com; s=arc-20240605;
        b=IMPlc8Sy6RapXMbjo00+qR/uWC3NrPglSoxzt6hoeS/xYRHVxuu+/QVzVknrCw73AU
         qAm0vDEHRodcsJXIjKSGPIELkvT4ymYsLZ2peD8DCBJPURH9FNUfpnypGxt120ItJG2m
         h77VNdUfHjp/nxzDAniy/Rd6HQ3w3c7iBZCFfL9D/TS2H3dzqAmcnqCRByHNS7OCPtrq
         mzuIs23BQi8RpIvAfxhyTmoZzqkJuGv2JiIrzYGFFUrJxo2cdQvsmbgWfY+896w4jT9h
         vdQeM/3+atdq+uqOJwNVk3HOGkrMyycfFZNwBmo9KQHNKhvjlh7DSxPXQ8JCRMG9CPqa
         daTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yt5OWwUWDVV4Zqx76acGWCtdqRNXgLDKgAdlP1bWoas=;
        fh=pkIXUcn01GGiDFnfP6H/CpcnxExCcINNWxTzJY6qJpo=;
        b=Tuc3z/AtF56iap+hjZwQdfZZEnq9FHDGvN/KODXCrC3jWm45FHI5Rr1OLjfWBrFkXx
         Cx7mpI1gVDUdM3Y3KoRIHMRSqmdCNBKRDDArM+gCMwdaoFOpKFXA6PUbhQawRbrpWkjG
         RBcKPDvW1gH7sO1BZt5c9H/nzw0DU99gHmcIVbxPdZFVuOE5KmwsqLyD6bTunbde/PFB
         cZ9XvOKYT7dFEU/8ASvodyq15hwT+K5JgKrrgihVZFFr2cKNGnFDJthLPg6w79aIszba
         /q+en81p4tY5xL6QhdR67V8cRBBADMwp+MwiVrBqABl5zMVEIUaZ+8/979LmPshskzJV
         wAwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1777997416; x=1778602216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt5OWwUWDVV4Zqx76acGWCtdqRNXgLDKgAdlP1bWoas=;
        b=bMOsNSIPM6Mh8d5X2eKxUp/1WkB0cnShbiWf5oHuJC/Gl0KSnOHUknm8jnqk8Xvakn
         DM271jjT509U38qKUFVk41dU6m5lWdbkZP8d1mZRB5bmPr+MfUaQrDH0qd5UZk/dTxcN
         WSYCwkLZ18YfDITCiZ/jrc+7fbqsp9OPcXvgqjKorizUyeOAhKkn6l90cMFdiydNXhJV
         dnM3bnC5qh3r5lcWL6xIblCYkXiDEVp73UdWj3k4JYXXSFXyZXxyV64c0AtFHetXXCgF
         IXbZ8QGYhF1WDk7JjKct1ng4ei3boMCk8bxf41wDQyOnmigg3DUxIqGddgN/M1gfVNsb
         K66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997416; x=1778602216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yt5OWwUWDVV4Zqx76acGWCtdqRNXgLDKgAdlP1bWoas=;
        b=qw6Fjx2LEzXwu5S1EjHbishXj+7K8yTWwrgeOUFy7XkJesIhCfGXi9QHOtZ0Zwti+9
         pwF9jHitsHtbYbMBU5XD+auyT8WIpyo/xjXdlcMf3GBdZuYQudUbbCmEnLRxkIMXM46M
         D/DMTl93DL+LnIRZoukHxeURKhok/KGJ3Wg3y79MtfWby+Hv3X1xEts+KSWFa60Qo7Wh
         p8vGzRyOkDi239EQjx72rJ9k8lE0EUV7vhaQSLVxBYOnfDygAJO1R4aFNRL9XcQhYJuO
         rqEGn5XnGI63v9iLhJywdfwlxH54MxQ0IXP7RqyYEyxSFusnmdn4IQQVQ450rP8JvyQ8
         ZXGg==
X-Gm-Message-State: AOJu0Yx//+hJraBhLcSENN1T8rNSA59V2zirUH1ONbLBgepghVEGSCLG
	nBR0CQIhBeSa9IZSNR6V/TNGqcBZz0nnrhQx+t6MpLJSp3gAZ15jWcOA7vMflhzNpUKjIt7nkPY
	haorcJLA5EKUB3oGKfljMsxYmvqrxdtWxZWxWIHisgA==
X-Gm-Gg: AeBDies/47Lt2spxgIMxV7sTaj3HJY8zDbMCEoO1mrmRRrE3ludmJzbOxfCC4x1dd0s
	kRBoByoc4pANdC54ljSRzXqqEME2ycKOLVLF4zlYGwHceQI8AMdUIez4+O2xI9uS7ppvTDMDVAO
	KlvrlcbDPHuhCDkMji+mBlTzSu2rT8lIEtMZ4Tou/ItoPAiJGWQJY3LVFJtCWQxsHrgi5DSNgmS
	b384wYXx70jgcvrqnP6s8nKA1YDLcSBOjNv8TZupOsB3jBLEBiLCClsnUMEMpVDELyNlJ1V7zdU
	U2waG6SjqWYR6MnS
X-Received: by 2002:a17:907:742:b0:ba3:e9be:f77e with SMTP id
 a640c23a62f3a-bbffbf77da5mr851028066b.38.1777997415541; Tue, 05 May 2026
 09:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417140505.3860237-1-louis.scalbert@6wind.com>
 <20260417140505.3860237-4-louis.scalbert@6wind.com> <1142168.1776974419@famine>
In-Reply-To: <1142168.1776974419@famine>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Tue, 5 May 2026 18:10:04 +0200
X-Gm-Features: AVHnY4JT26pesWizPg_88wuvRwsKEYrh0N3Gph8Is5s4oiC37EEKQZgTz_V54gw
Message-ID: <CAJ5u_OdCjZJLYr8OhfskTxavuW83dYSFx1_bTto9wezTn60nfA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] bonding: 3ad: fix mux port state on oper down
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, 
	andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6EFF94D1153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284502-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello Jay,

Sorry for the late reply. I=E2=80=99ve been busy with another project these
past few days.

Le jeu. 23 avr. 2026 =C3=A0 22:00, Jay Vosburgh <jv@jvosburgh.net> a =C3=A9=
crit :
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
> >index 9cf064243d58..bc2964ea11f5 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -1053,6 +1053,8 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> >
> >       if (port->sm_vars & AD_PORT_BEGIN) {
> >               port->sm_mux_state =3D AD_MUX_DETACHED;
> >+      } else if (!port->is_enabled && port->sm_mux_state !=3D AD_MUX_DE=
TACHED) {
> >+              port->sm_mux_state =3D AD_MUX_WAITING;
>
>         Technically, this is not exactly following the state machines.
>
>         The mux machine should transition to WAITING from DETACHED when
> Selected =3D=3D SELECTED or STANDBY, not for !is_enabled ("port_enabled" =
in
> the standard).

The MUX machine still transitions from DETACHED to WAITING; this
happens a few lines later and is unchanged.

The relevant code is:

} else if (!port->is_enabled && port->sm_mux_state !=3D AD_MUX_DETACHED) {
    port->sm_mux_state =3D AD_MUX_WAITING;
} else {
     switch (port->sm_mux_state) {
     case AD_MUX_DETACHED:
          if ((port->sm_vars & AD_PORT_SELECTED)
              || (port->sm_vars & AD_PORT_STANDBY))
          /* if SELECTED or STANDBY */
          port->sm_mux_state =3D AD_MUX_WAITING;
          break;

My change is for NOT is_enabled AND NOT AD_MUX_DETACHED.

> The check for !is_enabled happens in the receive
> machine, and it would transition to PORT_DISABLED state (which clears
> Synchronization).

I agree with that statement. However, clearing Synchronization is not
sufficient: the purpose of the fix is to clear Collecting and
Distributing.

I noticed that is_enabled is defined in the 802.3ad-2000 standard, while
Port_Operational is defined in 802.1AX-2020. I am not sure about
802.1AX-2014, as I do not have access to that version.

The 802.1AX-2020 standard uses a different MUX state diagram. Compared to
802.3ad, the ATTACHED state has been split into ATTACH and ATTACHED.
There is no longer a WAITING state; it has been replaced by
ATTACHED_WTR.

The new standard says that the MUX machine should transition to
ATTACHED_WTR when Port_Operational is FALSE and the current state is
not DETACHED.

So, in my opinion, the change is correct, at least with respect to
802.1AX-2020.

>
>         I'm not sure if this is actually an issue or not; I need to read
> the relevant bits again to make sure I understand how it's supposed to
> work.

Please confirm what you want me to do: should I keep the fix as it is ?

best regards,

Louis Scalbert
>
>         -J
>
> >       } else {
> >               switch (port->sm_mux_state) {
> >               case AD_MUX_DETACHED:
> >@@ -1200,6 +1202,11 @@ static void ad_mux_machine(struct port *port, boo=
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
> >                       if (port->aggregator->is_active)
> >--
> >2.39.2
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

