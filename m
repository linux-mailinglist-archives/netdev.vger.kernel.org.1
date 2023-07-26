Return-Path: <netdev+bounces-21538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859A9763DB9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15EA1C21235
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC11AA9C;
	Wed, 26 Jul 2023 17:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531951AA81
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 17:33:34 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD92697
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:33:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40631c5b9e9so19411cf.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690392804; x=1690997604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtIy08pp5HfXcX9OUYtJL+0L1NNsjbESIXlJjsDZKI8=;
        b=CMCZPd64uNy9aduzei9ImLFfsZ3HXYND7ITzOtVEw0tymcoYO87udLaSVqR8D3xk2v
         Na3N4HEvCKvHCO9XQ+d88AkngCq3U2L4sLwexMV3Iz6tugbbwSgRBt5wLlYyEiNxhv9+
         NmVBIJdf6UZmFlMb3A8DhvE/bRtvykm4N6nMzoE29ch7MCF+3SSq7nJC4jsEDZK86E8m
         mrt1I2zkfKjR8Q8fz4dC67rR56ZC0FdrMoLkqwDZ0rwTbTDaSLDfBaoCwteBVSp1heyG
         4hY22qe8KNKjNMz9PCGolQ2stQaXjVUdsBR/K8FgC7H9ze6lLSDxKPgktq0y81mMKwrb
         BJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690392804; x=1690997604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtIy08pp5HfXcX9OUYtJL+0L1NNsjbESIXlJjsDZKI8=;
        b=cjEMxX18pRl95ebjNDYmKHPCIJBh/6kXhrDTX1Vz5AKUVpv8BQECmcIPwj8IZaLhJ/
         iOj33n4Yis+YjT0Fg8PEiWPNEcjdJR/J0IRLq1+ovshpvNC2YzA4SjjBQF3lvyVdFpta
         48ZSrmKtizEPRGrUKP7DXa2Lk41sWXnbC6dQMNZGKjjvRlXbiMA/dtwdATihNZ0iP0Qc
         dspudDm3BjsvA+9CEtijKSJkhnXqvuWk2xkNOv3DMM3kyaAyzxGu6OXG42YYbyhpOOdo
         NsrlEwj82a5AMh8CKbJc8wroGXsk9fnh3T4vPdhtx8afi+v0cBihoEyxn8fNK22QqnXm
         ienA==
X-Gm-Message-State: ABy/qLZ3zPCZyuh/sdcouSuv1hEHQqtDPxE2mtvOjaSWCcv26uq9LQjS
	wIEyKOaDA2487ycloql4GtbSKncCslxW2H3ZyqeShw==
X-Google-Smtp-Source: APBJJlGDYq0rOFSwCXhXTm+EF3lfPllSN0RRTn8OupqpKIHyIMT0Io8RwSkzQM+4Uc4AJsHwbctZVt+tRJjgaRSXCB8=
X-Received: by 2002:a05:622a:18a7:b0:403:affb:3c03 with SMTP id
 v39-20020a05622a18a700b00403affb3c03mr614292qtc.10.1690392804100; Wed, 26 Jul
 2023 10:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725183122.4137963-1-prohr@google.com> <1940c057-99c4-8355-cc95-3f17cca38481@kernel.org>
In-Reply-To: <1940c057-99c4-8355-cc95-3f17cca38481@kernel.org>
From: Patrick Rohr <prohr@google.com>
Date: Wed, 26 Jul 2023 10:33:07 -0700
Message-ID: <CANLD9C1aV3U+GZ3hUE-_AgbeSyCNgUvJPmOPcFEDDgD_fQWJ0A@mail.gmail.com>
Subject: Re: [net-next] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 4:28=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 7/25/23 12:31 PM, Patrick Rohr wrote:
> > @@ -2727,6 +2727,11 @@ void addrconf_prefix_rcv(struct net_device *dev,=
 u8 *opt, int len, bool sllao)
> >               return;
> >       }
> >
> > +     if (valid_lft !=3D 0 && valid_lft < in6_dev->cnf.accept_ra_min_lf=
t) {
> > +             net_info_ratelimited("addrconf: prefix option lifetime to=
o short\n");
>
> The error message does not really provide any value besides spamming the
> logs. Similar comment applies to existing error logging in that function
> too. I think a counter for invalid prefix packets would be more useful.
>

Agreed. Let me remove the error log in this commit and clean up the
entire function in a follow up.

> The commit mentioned in the Fixes was just applied and you are already
> sending a follow up moving the same code around again.

I got feedback off of the mailing list after the patch was applied. In orde=
r for
the sysctl to be useful to Android, it should really apply to all lifetimes=
 in
the RA, since that is what determines the minimum frequency at which RAs mu=
st be
processed by the kernel. Android uses hardware offloads to drop RAs
for a fraction of the
minimum of all lifetimes present in the RA (some networks have very
frequent RAs (5s) with high lifetimes (2h)). Despite this, we have
encountered
networks that set the router lifetime to 30s which results in very frequent=
 CPU
wakeups. Instead of disabling IPv6 (and dropping IPv6 ethertype in the
WiFi firmware)
entirely on such networks, it seems better to ignore such routers
while still processing RAs from other IPv6 routers on the same network
(i.e. to support IoT applications).
The previous implementation dropped the entire RA
based on router lifetime. This turned out to be hard to expand to the other
lifetimes present in the RA in a consistent manner -- dropping the
entire RA based on
RIO/PIO lifetimes would essentially require parsing the whole thing twice. =
I am
sending this follow up patch now to fix 1671bcfd76fd before it is released.

>
> >  #ifdef CONFIG_IPV6_ROUTE_INFO
> >       if (!in6_dev->cnf.accept_ra_from_local &&
> >           ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
> > @@ -1530,6 +1522,9 @@ static enum skb_drop_reason ndisc_router_discover=
y(struct sk_buff *skb)
> >                       if (ri->prefix_len =3D=3D 0 &&
> >                           !in6_dev->cnf.accept_ra_defrtr)
> >                               continue;
> > +                     if (ri->lifetime !=3D 0 &&
> > +                         ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_=
min_lft)
> > +                             continue;
> >                       if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_in=
fo_min_plen)
> >                               continue;
> >                       if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_in=
fo_max_plen)
>

