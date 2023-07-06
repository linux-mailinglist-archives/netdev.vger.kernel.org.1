Return-Path: <netdev+bounces-15808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15436749E81
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EC51C20D96
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073FE945F;
	Thu,  6 Jul 2023 14:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D709440
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 14:04:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A351BF1
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688652270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHTfnSRwUdQlWNgZN6CsLFTWCgyvgmK6xceI83/ifHY=;
	b=LLNModQCx7gTx1MMjIIccMqZxo+6YjbpeUetab9K4E1U/cV8dUaJkdUipW6PjlsO0R/9EJ
	sb7zwxlBYWkowGkXrIiVx2KTTIA9vDotu0ZOuMjZKkBHD3O9kXSPpBYgbUBDZ0mJmXPFHy
	jF15QcPI+ycZ54KtYQgCU3qQirqqTiA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-yf_gfA72PWqNChL38j_mZw-1; Thu, 06 Jul 2023 10:04:28 -0400
X-MC-Unique: yf_gfA72PWqNChL38j_mZw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76714d4beebso14013485a.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 07:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688652268; x=1691244268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHTfnSRwUdQlWNgZN6CsLFTWCgyvgmK6xceI83/ifHY=;
        b=YYHAVdMc8h/TSAszNUWFNuE+7T4WaeHlT902tR+Uo5oDTF4yFUwunU8+eslxLrNa0e
         UWV9bk2mP3lXf+m15NHL0yopgfsslihSqyWgkDhTxFAsDEOaqwzNRuQmexyfbKeI8/A9
         O6iV8R7oeSpt4PwlP7TTLQzWyiGAZDrizX8XVO0OTEo0vdtVyXgvyioznTSqqt3LasLY
         6gJlQWMeQX0r741e2RWf2mL4UoAkK5IMfITM1VTVtjzK5kpEQ5JIlvM+pfQiMc/PoLty
         OZslKlR35C5Pu3ofBz31gVECvzvB1jes/ClnI1Bwpb+yWec07kehOewz7/ODXXqqeqSj
         vElw==
X-Gm-Message-State: ABy/qLZQLp2RJaFYfANS59s3t4SFOFr2+Tge3kVR/bIQO1BRRH0lFNVQ
	Ty5Yto+hz8LN9WI9y8n+FGq5GHiP/FjQAXEe7hTyUCBhzxQi5p4W3FbW/VWlBrUbT+UROtQKBoH
	3gMplqB6oOcsdOIlU0suJaQFM
X-Received: by 2002:a05:620a:1a95:b0:767:13cd:e17d with SMTP id bl21-20020a05620a1a9500b0076713cde17dmr2228717qkb.3.1688652268048;
        Thu, 06 Jul 2023 07:04:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGxZgQ1bMsrU4kU9bu5sFcUtkyAMCH1a4fdDD2/ba3E6cKqGY3UoRRM+J748ZFycPpsw5psXg==
X-Received: by 2002:a05:620a:1a95:b0:767:13cd:e17d with SMTP id bl21-20020a05620a1a9500b0076713cde17dmr2228693qkb.3.1688652267735;
        Thu, 06 Jul 2023 07:04:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-43.dyn.eolo.it. [146.241.240.43])
        by smtp.gmail.com with ESMTPSA id n14-20020a05620a152e00b00762f37b206dsm767199qkk.81.2023.07.06.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:04:27 -0700 (PDT)
Message-ID: <c4e40b45b41d0476afd8989d31e6bab74c51a72a.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
Cc: Ian Kumlien <ian.kumlien@gmail.com>, Alexander Lobakin
	 <aleksander.lobakin@intel.com>, intel-wired-lan
	 <intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 06 Jul 2023 16:04:23 +0200
In-Reply-To: <CANn89i+F=R71refT8K_8hPaP+uWn15GeHz+FTMYU=VPTG24WFA@mail.gmail.com>
References: 
	<CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
	 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
	 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
	 <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
	 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
	 <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
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
	 <CAA85sZvZ_X=TqCXaPui0PDLq2pp5dw_uhga+wcXgBqudrLP9bQ@mail.gmail.com>
	 <67ff0f7901e66d1c0d418c48c9a071068b32a77d.camel@redhat.com>
	 <CANn89i+F=R71refT8K_8hPaP+uWn15GeHz+FTMYU=VPTG24WFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-07-06 at 15:56 +0200, Eric Dumazet wrote:
> On Thu, Jul 6, 2023 at 3:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >=20
> > On Thu, 2023-07-06 at 13:27 +0200, Ian Kumlien wrote:
> > > On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > > On Wed, 2023-07-05 at 15:58 +0200, Ian Kumlien wrote:
> > > > > On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <pabeni@redhat=
.com> wrote:
> > > > > >=20
> > > > > > On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > > > > > > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni@r=
edhat.com> wrote:
> > > > > > > >=20
> > > > > > > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > > > > > > > More stacktraces.. =3D)
> > > > > > > > >=20
> > > > > > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > > > > > > > [  411.413767] ------------[ cut here ]------------
> > > > > > > > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud=
     p.h:509
> > > > > > > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp=
.c:800
> > > > > > > > > net/ipv6/udp.c:787)
> > > > > > > >=20
> > > > > > > > I'm really running out of ideas here...
> > > > > > > >=20
> > > > > > > > This is:
> > > > > > > >=20
> > > > > > > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > > > > > > >=20
> > > > > > > > sort of hint skb being shared (skb->users > 1) while enqueu=
ed in
> > > > > > > > multiple places (bridge local input and br forward/flood to=
 tun
> > > > > > > > device). I audited the bridge mc flooding code, and I could=
 not find
> > > > > > > > how a shared skb could land into the local input path.
> > > > > > > >=20
> > > > > > > > Anyway the other splats reported here and in later emails a=
re
> > > > > > > > compatible with shared skbs.
> > > > > > > >=20
> > > > > > > > The above leads to another bunch of questions:
> > > > > > > > * can you reproduce the issue after disabling 'rx-gro-list'=
 on the
> > > > > > > > ingress device? (while keeping 'rx-udp-gro-forwarding' on).
> > > > > > >=20
> > > > > > > With rx-gro-list off, as in never turned on, everything seems=
 to run fine
> > > > > > >=20
> > > > > > > > * do you have by chance qdiscs on top of the VM tun devices=
?
> > > > > > >=20
> > > > > > > default qdisc is fq
> > > > > >=20
> > > > > > IIRC libvirt could reset the qdisc to noqueue for the owned tun
> > > > > > devices.
> > > > > >=20
> > > > > > Could you please report the output of:
> > > > > >=20
> > > > > > tc -d -s qdisc show dev <tun dev name>
> > > > >=20
> > > > > I don't have these set:
> > > > > CONFIG_NET_SCH_INGRESS
> > > > > CONFIG_NET_SCHED
> > > > >=20
> > > > > so tc just gives an error...
> > > >=20
> > > > The above is confusing. AS CONFIG_NET_SCH_DEFAULT depends on
> > > > CONFIG_NET_SCHED, you should not have a default qdisc, too ;)
> > >=20
> > > Well it's still set in sysctl - dunno if it fails
> > >=20
> > > > Could you please share your kernel config?
> > >=20
> > > Sure...
> > >=20
> > > As a side note, it hasn't crashed - no traces since we did the last c=
hange
> >=20
> > It sounds like an encouraging sing! (last famous words...). I'll wait 1
> > more day, than I'll submit formally...
> >=20
> > > For reference, this is git diff on the running kernels source tree:
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index cea28d30abb5..1b2394ebaf33 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -4270,6 +4270,17 @@ struct sk_buff *skb_segment_list(struct sk_buf=
f *skb,
> > >=20
> > >         skb_push(skb, -skb_network_offset(skb) + offset);
> > >=20
> > > +       if (WARN_ON_ONCE(skb_shared(skb))) {
> > > +               skb =3D skb_share_check(skb, GFP_ATOMIC);
> > > +               if (!skb)
> > > +                       goto err_linearize;
> > > +       }
> > > +
> > > +       /* later code will clear the gso area in the shared info */
> > > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > > +       if (err)
> > > +               goto err_linearize;
> > > +
> > >         skb_shinfo(skb)->frag_list =3D NULL;
> > >=20
> > >         while (list_skb) {
> >=20
> > ...the above check only, as the other 2 should only catch-up side
> > effects of lack of this one. In any case the above address a real
> > issue, so we likely want it no-matter-what.
> >=20
>=20
> Interesting, I wonder if this could also fix some syzbot reports
> Willem and I are investigating.
>=20
> Any idea of when the bug was 'added' or 'revealed' ?

The issue specifically addressed above should be present since
frag_list introduction commit 3a1296a38d0c ("net: Support GRO/GSO
fraglist chaining."). AFAICS triggering it requires non trivial setup -
mcast rx on bridge with frag-list enabled and forwarding to multiple
ports - so perhaps syzkaller found it later due to improvements on its
side ?!?

Cheers,

Paolo


