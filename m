Return-Path: <netdev+bounces-15803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC5A749E4A
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A962C2812EE
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B17944E;
	Thu,  6 Jul 2023 13:56:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6899440
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 13:56:55 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C41BC2
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 06:56:51 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-401d1d967beso317161cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688651810; x=1691243810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o4NNAa0hEp40MVI+hiXpvFx+kGwffUnYwX0NvprFrM=;
        b=JnyflN6PUKyqI7ewT3XXEZWRKVLniQMvIuQLxFHC/dmxQ8lwB6HEcKrmIPpGMMDSuU
         jg7QLZ4mpNSokFlOr0Kgh1zJHmOxa8RpU1oiOHtLv23R7R+u+h18wBN+l8GxZfDMZFvC
         B56h3KzPm84Bf28/RdNWAxypmU0KMwM8Bw2kbSII1opUPHq1YC0LPhN7cKyAMDyhEb36
         ialNyHhaq6ZSRxGYMq/a+qGita4ERfSym1AeWkkUM7AIXZPg3etqC93IxawyLeNRKKct
         gjH5T+B7YWlLd7040vFwYE43AWsggser8E/WGSVcA/05/l4XEYT159HB6+5QCavjLe5o
         IzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651810; x=1691243810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o4NNAa0hEp40MVI+hiXpvFx+kGwffUnYwX0NvprFrM=;
        b=CetR1Ds12x52d0u5sVZ8XB/a0O1113NS9G9eBqBsf6O8L77Px4SzS4PRqGRaKltqM6
         YjSBi63mR6C/SiZw9J0HUr2mKiC217HVYpyiqGolnVD2XPr1eV43F1UI00qn/BZuiWEt
         Mjf27Mo4Ms+sE5JBOSCV/MRQGp4UiYwm2EE9EVUy/4hoWyujzm3/3bd2P75Dz01WCAdl
         ShdG0C/gck+h4HOAcGbUYRhbKScHc7JdFfqR4Tb1CpOfedUeY/+lq5YHM3oNg0jMCWwO
         AQfHQm3uAKXjYbbKmDiR0i/6Vdjc/P/zk3LrAVH6tvQ2v1uyMYVUp3przz85Kqa4ncbL
         Z8rw==
X-Gm-Message-State: ABy/qLak5QKKwuOz5H3c+IkBn2BK0ZFQeiTIwL8znv1aPZpNQfXLdwtx
	vViW9r245kZNqSsPLM0KWzxwT55XW3b6ushkGDebPw==
X-Google-Smtp-Source: APBJJlEDtP/lmO1GgVOyh/3iYAbZvHjlNxw50iq/tp7xGY0Dwc7Y+VtoavfKVgkd36e3D4omB4TQ/Kh6tpmFL7Yl9qo=
X-Received: by 2002:ac8:5887:0:b0:3f9:6930:1308 with SMTP id
 t7-20020ac85887000000b003f969301308mr115350qta.13.1688651810098; Thu, 06 Jul
 2023 06:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com> <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
 <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
 <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
 <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
 <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
 <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
 <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
 <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
 <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
 <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
 <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
 <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
 <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
 <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
 <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
 <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
 <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
 <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
 <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
 <CAA85sZuQh0FMoGDFVyOad6G1UB9keodd3OCZ4d4r+xgXDArcVA@mail.gmail.com>
 <062061fc4d4d3476e3b0255803b726956686eb19.camel@redhat.com>
 <CAA85sZv9KCmw8mAzK4T-ORXB48wuLF+YXTYSWxkBhv3k_-wzcA@mail.gmail.com>
 <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com>
 <d9bf21296a4691ac5aca11ccd832765b262f7088.camel@redhat.com>
 <CAA85sZsidN4ig=RaQ34PYFjnZGU-=zqR=r-5za=G4oeAtxDA7g@mail.gmail.com>
 <14cd6a50bd5de13825017b75c98cb3115e84acc1.camel@redhat.com>
 <CAA85sZuZLg+L7Sr51PPaOkPKbbiywXbbKzhTyjaw12_S6CsZHQ@mail.gmail.com>
 <c6cf7b4c0a561700d2015c970d52fc9d92b114c7.camel@redhat.com>
 <CAA85sZvZ_X=TqCXaPui0PDLq2pp5dw_uhga+wcXgBqudrLP9bQ@mail.gmail.com> <67ff0f7901e66d1c0d418c48c9a071068b32a77d.camel@redhat.com>
In-Reply-To: <67ff0f7901e66d1c0d418c48c9a071068b32a77d.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jul 2023 15:56:38 +0200
Message-ID: <CANn89i+F=R71refT8K_8hPaP+uWn15GeHz+FTMYU=VPTG24WFA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To: Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
Cc: Ian Kumlien <ian.kumlien@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	intel-wired-lan <intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 3:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Thu, 2023-07-06 at 13:27 +0200, Ian Kumlien wrote:
> > On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > > On Wed, 2023-07-05 at 15:58 +0200, Ian Kumlien wrote:
> > > > On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > > >
> > > > > On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > > > > > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > > > > > > More stacktraces.. =3D)
> > > > > > > >
> > > > > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > > > > > > [  411.413767] ------------[ cut here ]------------
> > > > > > > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud  =
   p.h:509
> > > > > > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c=
:800
> > > > > > > > net/ipv6/udp.c:787)
> > > > > > >
> > > > > > > I'm really running out of ideas here...
> > > > > > >
> > > > > > > This is:
> > > > > > >
> > > > > > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > > > > > >
> > > > > > > sort of hint skb being shared (skb->users > 1) while enqueued=
 in
> > > > > > > multiple places (bridge local input and br forward/flood to t=
un
> > > > > > > device). I audited the bridge mc flooding code, and I could n=
ot find
> > > > > > > how a shared skb could land into the local input path.
> > > > > > >
> > > > > > > Anyway the other splats reported here and in later emails are
> > > > > > > compatible with shared skbs.
> > > > > > >
> > > > > > > The above leads to another bunch of questions:
> > > > > > > * can you reproduce the issue after disabling 'rx-gro-list' o=
n the
> > > > > > > ingress device? (while keeping 'rx-udp-gro-forwarding' on).
> > > > > >
> > > > > > With rx-gro-list off, as in never turned on, everything seems t=
o run fine
> > > > > >
> > > > > > > * do you have by chance qdiscs on top of the VM tun devices?
> > > > > >
> > > > > > default qdisc is fq
> > > > >
> > > > > IIRC libvirt could reset the qdisc to noqueue for the owned tun
> > > > > devices.
> > > > >
> > > > > Could you please report the output of:
> > > > >
> > > > > tc -d -s qdisc show dev <tun dev name>
> > > >
> > > > I don't have these set:
> > > > CONFIG_NET_SCH_INGRESS
> > > > CONFIG_NET_SCHED
> > > >
> > > > so tc just gives an error...
> > >
> > > The above is confusing. AS CONFIG_NET_SCH_DEFAULT depends on
> > > CONFIG_NET_SCHED, you should not have a default qdisc, too ;)
> >
> > Well it's still set in sysctl - dunno if it fails
> >
> > > Could you please share your kernel config?
> >
> > Sure...
> >
> > As a side note, it hasn't crashed - no traces since we did the last cha=
nge
>
> It sounds like an encouraging sing! (last famous words...). I'll wait 1
> more day, than I'll submit formally...
>
> > For reference, this is git diff on the running kernels source tree:
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index cea28d30abb5..1b2394ebaf33 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -4270,6 +4270,17 @@ struct sk_buff *skb_segment_list(struct sk_buff =
*skb,
> >
> >         skb_push(skb, -skb_network_offset(skb) + offset);
> >
> > +       if (WARN_ON_ONCE(skb_shared(skb))) {
> > +               skb =3D skb_share_check(skb, GFP_ATOMIC);
> > +               if (!skb)
> > +                       goto err_linearize;
> > +       }
> > +
> > +       /* later code will clear the gso area in the shared info */
> > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > +       if (err)
> > +               goto err_linearize;
> > +
> >         skb_shinfo(skb)->frag_list =3D NULL;
> >
> >         while (list_skb) {
>
> ...the above check only, as the other 2 should only catch-up side
> effects of lack of this one. In any case the above address a real
> issue, so we likely want it no-matter-what.
>

Interesting, I wonder if this could also fix some syzbot reports
Willem and I are investigating.

Any idea of when the bug was 'added' or 'revealed' ?

