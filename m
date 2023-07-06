Return-Path: <netdev+bounces-15745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E074979F
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D58B1C20B8A
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F41C15D4;
	Thu,  6 Jul 2023 08:42:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A5A7E6
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 08:42:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88CF1BC3
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688632965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6rDF3CskNlnocyiQd+/MQFl4wcMc6bzpk2CUQ+RXxc=;
	b=Ht273YKvwoq8jpbfGh1ihE5QZjVpUI1PAFktjR8gue1rd3RIsvNuefkTh2s0aHm6bRU/Zv
	/LXe85U7RmXmHQZSswGvGksSJXd0NR7LEygu/MsZB7/o0hy4+OjrSUOAmzy9t6DW19JpiN
	fteoUwL3Owow02jTyC8d40nV0NNciNQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-ZvstolKoNJ-S-71RuH2sog-1; Thu, 06 Jul 2023 04:42:44 -0400
X-MC-Unique: ZvstolKoNJ-S-71RuH2sog-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765ad67e600so11538285a.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 01:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688632964; x=1691224964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6rDF3CskNlnocyiQd+/MQFl4wcMc6bzpk2CUQ+RXxc=;
        b=OJBQX+5JAi9Z7+tpe/lRL8tDUdUgm8JLrUQrGlUbupTgGsgOIhRHZFt5/y7yrfhpNP
         iqXpbgZZrg4DzMXkjjv+8Y5kHxKrx+S5mrkpson6x9gxCuCkmtCQ2ZodCKAXM4TSRhuj
         w+x1ucuwwTibsOxkIuTMiYBXnulhDuZvCD8++MfvRmQ4QqJcH66BL66x6heeZipIakxr
         FutTGaKOkOEqqfWjEc7cEVvRMtE46fLfyvhXdVOHBJFVfTLaTDxwPlryOJsji0AqAHfC
         jfD5UNI9tpkiqN7yrdZYycVUvltKfuE4rmVQeQ6vOZ08P14MrAQ/2cB5yq1Eo1GfpMFo
         /Usg==
X-Gm-Message-State: ABy/qLamHM5rJQ12QPqA0gtc40x1Hf9pO4GYJf1Tpvcmx4CF1OQBfeTU
	LrIY8Twx6K9aPcBjhpNFxf4oOfUUQqetmryEEFlu8ZA+ueCQUIZOJj9uttHnOe792uuyW3V4XCv
	BhSRu8E5x3J/ReU/DjPhfH6yQ
X-Received: by 2002:a05:620a:40c2:b0:765:9e34:a77e with SMTP id g2-20020a05620a40c200b007659e34a77emr1523537qko.2.1688632964083;
        Thu, 06 Jul 2023 01:42:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzgaYXclsPfL9sEoyaeA9jji27GaEyrb+cFPy2fXy0aidVV/TNS07gc7ReWtcD6iCG08YP1Q==
X-Received: by 2002:a05:620a:40c2:b0:765:9e34:a77e with SMTP id g2-20020a05620a40c200b007659e34a77emr1523521qko.2.1688632963710;
        Thu, 06 Jul 2023 01:42:43 -0700 (PDT)
Received: from gerbillo.redhat.com (host-95-248-55-118.retail.telecomitalia.it. [95.248.55.118])
        by smtp.gmail.com with ESMTPSA id i22-20020ae9ee16000000b00767765561absm512848qkg.100.2023.07.06.01.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:42:43 -0700 (PDT)
Message-ID: <c6cf7b4c0a561700d2015c970d52fc9d92b114c7.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From: Paolo Abeni <pabeni@redhat.com>
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, intel-wired-lan
 <intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Thu, 06 Jul 2023 10:42:38 +0200
In-Reply-To: <CAA85sZuZLg+L7Sr51PPaOkPKbbiywXbbKzhTyjaw12_S6CsZHQ@mail.gmail.com>
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

On Wed, 2023-07-05 at 15:58 +0200, Ian Kumlien wrote:
> On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >=20
> > On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >=20
> > > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > > > More stacktraces.. =3D)
> > > > >=20
> > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > > > [  411.413767] ------------[ cut here ]------------
> > > > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud     p.h=
:509
> > > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c:800
> > > > > net/ipv6/udp.c:787)
> > > >=20
> > > > I'm really running out of ideas here...
> > > >=20
> > > > This is:
> > > >=20
> > > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > > >=20
> > > > sort of hint skb being shared (skb->users > 1) while enqueued in
> > > > multiple places (bridge local input and br forward/flood to tun
> > > > device). I audited the bridge mc flooding code, and I could not fin=
d
> > > > how a shared skb could land into the local input path.
> > > >=20
> > > > Anyway the other splats reported here and in later emails are
> > > > compatible with shared skbs.
> > > >=20
> > > > The above leads to another bunch of questions:
> > > > * can you reproduce the issue after disabling 'rx-gro-list' on the
> > > > ingress device? (while keeping 'rx-udp-gro-forwarding' on).
> > >=20
> > > With rx-gro-list off, as in never turned on, everything seems to run =
fine
> > >=20
> > > > * do you have by chance qdiscs on top of the VM tun devices?
> > >=20
> > > default qdisc is fq
> >=20
> > IIRC libvirt could reset the qdisc to noqueue for the owned tun
> > devices.
> >=20
> > Could you please report the output of:
> >=20
> > tc -d -s qdisc show dev <tun dev name>
>=20
> I don't have these set:
> CONFIG_NET_SCH_INGRESS
> CONFIG_NET_SCHED
>=20
> so tc just gives an error...

The above is confusing. AS CONFIG_NET_SCH_DEFAULT depends on
CONFIG_NET_SCHED, you should not have a default qdisc, too ;)

Could you please share your kernel config?

Thanks!

/P


