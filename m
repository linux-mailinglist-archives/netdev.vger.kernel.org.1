Return-Path: <netdev+bounces-294685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XTgcBivsH2rHsQAAu9opvQ
	(envelope-from <netdev+bounces-294685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:56:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117DD635E68
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=MtH9mD5O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294685-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294685-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 671B73043AFC
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E7408002;
	Wed,  3 Jun 2026 08:33:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C63D171F
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:33:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475630; cv=pass; b=gk4XoGP1vlXmoqSjQI7WdmmzqDdGDrEkumgnSAYlE/RdzaC5GC7bvNbJ0S7dKXJ/H4ovpjRHBaJ4clIzRscEQnlNgsiyxMcxAsQ5aoGwEUy34lOFWCl3XqJxQzTlK8ZL52h7doLWIThUI+Ew2oR7LsJdXEI9jx4NFQoePiuYjxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475630; c=relaxed/simple;
	bh=osBoVV+QwvgMopOqjz9wQZ3xob93jzdY33RW7GW+XcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKfqeWrEjV0YcWDBbomHmzQmBltEPgFo3CZ278QhUqaCuOjLFx8c0Z+JQA5WDkYkO1N/OAPGFAiXS8TsPPkjAVGrVYJYt8V3Z5kaeBbmzDo/H8KP+XMW8SplPkTlAbJGWd5baNMTS2Tq3NfPRZi22IZb0wo6P1YvjfubEFQmW6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtH9mD5O; arc=pass smtp.client-ip=209.85.222.177
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91564c3a968so60834885a.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 01:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780475628; cv=none;
        d=google.com; s=arc-20240605;
        b=cJJnv7wk/kMd2VlnZsWpHapsn3UhmTGTgrvvdgg32X8cbPNs09ypiZAmdCCe3AUHUZ
         BA2FoMNKoqxtfT+VyEtU0ilhIwTQgX1NBLPskHFGtkqMFt8hBGbtFxJ0Ocdij9Sz/EEw
         P0CpujVe6qf3IN7qItYgaCAZrNe6WdNwPnCrUTnKvyB2DIUhs+xjQbbpnVHp/NwCOsR0
         aeEAZAKu/EACTl1WNhADWrWO/jEhNQMII098qqEji6o4UfjX5tHM827xYaSsSA2XgUeN
         bdRl3V9+DuTEob12kdJfk+mueou17LCFtRedWNcB5apbzOETNSUd3bKbEXAhRgarcF9I
         Vizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=czPGIebIv7FPLlAuly+Ff7MhU0xxOpux/g+uQcloPkc=;
        fh=f8tlj1NbZYQAxkrpmDNQQl0/yAf9jayWHk2xTnjiBeY=;
        b=XIAcJvCXhsNSxliJwN0+DQmq4cIWT1Zezik230769FmNS/uQ34nR8IjPqrw3VNo2Gs
         KaUzs3s7REpalNoOMCkVDwNUFeq2Zipoupili6RN+Q06H8VhlkfZzMDfGUHF4UWxu0mD
         tlqXjXMQeEe6CsGRe1im8EZZZ+KTtXex/ctxpuLIPCBER4Xfpg9hQeYpRwyzDFC3A1u1
         aPEoxEvSOFdJdES20NuYQ9/FzavBTNXf6+4d/bfaaOLgUT4QHHZxx6CXWnmjCIB1hRpa
         32dRVmPp1gqsFL2kslUfQp537K4o1ZHgpTI7jN2UOXWfPxC3kVnCQdQ47Oaq2l4m8dRb
         fguw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780475628; x=1781080428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czPGIebIv7FPLlAuly+Ff7MhU0xxOpux/g+uQcloPkc=;
        b=MtH9mD5OvzAQzFJ/unLvIemyUweE4+SaqJ+gV6EUrT5DSn6W5JVxn82w+474CgHE42
         5KG+ObXzBdXVv4jLa8o8/ZveaxVukn/3Eu9NhNWfaF+B9l91muWLV5Q80IX0Bahg8ves
         f4oeY6UXDNuESWvaAJJu8evYk6VSlF2CoL+AsE5y3O4eDhLQsN5MAFiB2GqdpmeoHo73
         CGZTrgRyLMAXL2XBMdMfZ4jgtcHh4Bq9/gWGl8BYLFxaW26VlEw78xocL2WmmrWbE46q
         no8YRIajeWSgAqRF+Oh//zlOs8UWoYTVegjy6JcGiIdisndVGoQVf8Bj7n5/hrVhjDdk
         RsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780475628; x=1781080428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=czPGIebIv7FPLlAuly+Ff7MhU0xxOpux/g+uQcloPkc=;
        b=BBfn34mWIRNx953adj6UARzusqeZdFqaUdU44AVh9/puXlGRXlBodei4Fr6UEiSyyb
         qLPAOFD4bDnlL5o6g44PtFlnKJN7A3QF5mBQtMvNFp73A6qWfT3xThkY178HlWHi8ZTi
         WHXms1PPPnsdGrgGrtbpARCnDnZgyj/VWUgBppFv9xg+bocnSuLWi2THfxbh94L28hAJ
         tj2Zt6t2YX8iJkNHfIiyVzE8UYRgrTysJ1jckGnox48RHbToHExrIwk585Lg0ZqLjEQo
         ijg7GLD68rkREgmtRLryWOkUOSmTboGvRUSuv9p4sxsq/EOsj+6SSdRTgDYaxBe0uTP5
         mtzA==
X-Forwarded-Encrypted: i=1; AFNElJ/oYj/2uOZPtyK+lf06OUpDSAilRvExsEcp+x1ZD9bEEIzkgLNTPuoWnC3SFJErcIs0erE35CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZk7NLFxdk9ZGV/+beJq7AC2iVkUeLYuiJxkfTf6o09izEvbAQ
	2Ntpmq+b3JYsXhZ17lkDOqX9lttrlmlPdLoNFytbyoTo5yRw/Z2BfJyIZrag93pg/hxpg/yuM1n
	c/uS//DssIGZ33P6l2nvy/DmOv5XRwiW87GeJWQKA
X-Gm-Gg: Acq92OF/RYtW1Y0dY5QjuNFdxfSAfpnsF6bVUXpXVVNkFeC5ceLiaV2qH0/FJy4jgHJ
	55go5NujX9sz77D2zZD02ucQu3Qg8CuZFUXHLX2mP7sF+CEBv990MOnmH4veXlWtf0tvV1r9wsH
	ugzuh9WG+6gGdgu7te1RayMOPNYV4/V3L0wP2dT2oMeQ6KOtdFfXcAADxtXS5CIvO7NwhrY3Bz3
	Aco6OlJ7hayljnnjxU8jWiLiPHt1GcJYm1WYOk4WZQGH+cLmACuOKOhepsnMANCUCHxeDOTTwfx
	zZt8N9Kp2IlSqz47S6QX1uKMw/BugOL7/M3gQ+Tg2iUd0fYkOwRViyhWKyXPQ2j4cobZayxfUee
	ge0koYrpg2z9Z91A4sUwqtjvIYZy/9A==
X-Received: by 2002:a05:620a:4414:b0:914:d65e:4660 with SMTP id
 af79cd13be357-9158b79b1b9mr290966685a.42.1780475627662; Wed, 03 Jun 2026
 01:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603030810.3593625-1-yun.zhou@windriver.com>
 <CANn89iL2OnKcFOV7hHON=70670bC9vsUXBFm3nADU89qgepVfA@mail.gmail.com> <2fe4890d-842b-4595-b0db-6859579ca6ef@windriver.com>
In-Reply-To: <2fe4890d-842b-4595-b0db-6859579ca6ef@windriver.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jun 2026 01:33:35 -0700
X-Gm-Features: AVHnY4KePQCPPDs8tLsW9wya3icTO3g0qVhZFnqI-HuFcAWuFRRczCszD84QJgo
Message-ID: <CANn89iJhZTztRYSoNsUhN0y2UUucm5g5=jHAWKqN1wLOpeJoMA@mail.gmail.com>
Subject: Re: [PATCH] flow_dissector: fix uninit-value in __skb_flow_dissect()
 for ETH_ADDRS
To: "Zhou, Yun" <yun.zhou@windriver.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,windriver.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 117DD635E68

On Wed, Jun 3, 2026 at 1:16=E2=80=AFAM Zhou, Yun <yun.zhou@windriver.com> w=
rote:
>
>
>
> On 6/3/26 13:44, Eric Dumazet wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >
> > On Tue, Jun 2, 2026 at 8:08=E2=80=AFPM Yun Zhou <yun.zhou@windriver.com=
> wrote:
> > Please add a Closes: tag
> I will add a Closes link in v2.
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfa2f5b1fb06147be5e16
> >
> > I found some not relevant syzbot report :
> >
> > https://lore.kernel.org/netdev/6a196faf.c16d89a8.217f2c.0002.GAE@google=
.com/
> This should be the same issue. And it can be reproduced by
> https://syzkaller.appspot.com/text?tag=3DReproC&x=3D12924152580000

Please investigate which device allowed to send an Ethernet packet
smaller than the ethernet header.

We do not want to add tests all over the places, we should fix the origin.

Look for dev->min_header_len

Thanks.

> >
> >> Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet a=
ddresses")
> >> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> >> ---
> >>   net/core/flow_dissector.c | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> >> index 2a98f5fa74eb..d5817b800079 100644
> >> --- a/net/core/flow_dissector.c
> >> +++ b/net/core/flow_dissector.c
> >> @@ -1173,13 +1173,19 @@ bool __skb_flow_dissect(const struct net *net,
> >>
> >>          if (dissector_uses_key(flow_dissector,
> >>                                 FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> >> -               struct ethhdr *eth =3D eth_hdr(skb);
> >>                  struct flow_dissector_key_eth_addrs *key_eth_addrs;
> >>
> >>                  key_eth_addrs =3D skb_flow_dissector_target(flow_diss=
ector,
> >>                                                            FLOW_DISSEC=
TOR_KEY_ETH_ADDRS,
> >>                                                            target_cont=
ainer);
> >> -               memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
> >> +               /* Ensure the skb has enough data at mac_header to cov=
er
> >> +                * both src and dst Ethernet addresses.
> >> +                */
> >> +               if (skb_mac_header_was_set(skb) &&
> >> +                   skb_tail_pointer(skb) - skb_mac_header(skb) >=3D s=
izeof(*key_eth_addrs))
> >> +                       memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*ke=
y_eth_addrs));
> >> +               else
> >> +                       memset(key_eth_addrs, 0, sizeof(*key_eth_addrs=
));
> >>          }
> > Can you show us a stack trace, why mac_header would not be set at this =
point?
> It seems that there is no need to call skb_mac_header_was_set(skb).

