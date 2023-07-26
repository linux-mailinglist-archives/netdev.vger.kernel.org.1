Return-Path: <netdev+bounces-21404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23430763849
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA130281F2D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62EA21D34;
	Wed, 26 Jul 2023 14:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82079453
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:04:04 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE01E211F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:04:03 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40550136e54so370471cf.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690380243; x=1690985043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tbSP44OXD0rVtMEjWWeHi2dhgC7ScSEnveej74PA6I=;
        b=hr1hTxm1fhlWsqR+3Ca89B8s+2ZNh4ZwzFgJJgkkX+Xnb/8eJNPdAm8ljDZb+lspQC
         FtblyUdA2VEm1od6D1Vn4R9PWO/onYOCnws/nX4QNHK8o7elV5x0XKNX8Uh/3dfXeIv3
         7SkJSsMbh7/0NEe+SIRudeZhszdhKzeV/9SSZtIlvFSZANmhGGJv7j1H20PTpgzBbpbZ
         +43cRrrXgzGbPEuUv7sE3uX2eI+N1cY7TqvPNlFbKjap4cp1rqXPQG71dQfGrQzpAfx0
         bcB/4rnm4TBO3R4bQyGKpTmOsrRp5FRmiL+bJ7AHOV41UYNYK9VYVMM1t4s1HHE2Ajaq
         Db0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380243; x=1690985043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tbSP44OXD0rVtMEjWWeHi2dhgC7ScSEnveej74PA6I=;
        b=j9IOv/EY2WI5TgYovvgQplJ4+fSJ3w60u615A+jJv6prwhTLdc3GyPIPYAsVecSpDO
         EYYaTeNWEP7T6PGhA/elLEO++HNMXPBk40F9OeJrnsWU9ui2zHqdqLQ6ZlZ4UoFHTQtT
         TpbaHrRfiORH55gM57SqAqjZFGpIx3OQq9ZHFSigsxYPEMscWyLa+I+GeWR9dzWjlKn0
         kZtMIrHYxWLtVOadSayB+f0agTOetwon449qU0y4bbuHXTL9EYU1tNHT267VKkVSRT0+
         q5BIh3Z9bNquDqZS6QOEerWGBGVxAB04T1Rx+GNqPG33bxypvP226r+LhBeHvC3jgWJ1
         0s0Q==
X-Gm-Message-State: ABy/qLZ0Vey2AS0gU7b6S9OvCDQNDn6arJmvd/XTXV8K/mtFjLN4Idij
	htf7Q2m81HzUSYiyk3+C1MO5an1bszmzVuwPsJcsBnBteNixymIFzkQ=
X-Google-Smtp-Source: APBJJlGx7bH4xe2beTuTZvUsga5pLW1fBGOV3dxGIWTkZp8OvsK98i2INkn48eYelRAL++Xzxa3vray71hZaevbOlGI=
X-Received: by 2002:ac8:5c0a:0:b0:404:8218:83da with SMTP id
 i10-20020ac85c0a000000b00404821883damr495713qti.1.1690380242607; Wed, 26 Jul
 2023 07:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
 <5eb8631d430248999116ce8ced13e4b2@AcuMS.aculab.com> <fce08e76da7e3882319ae935c38e9e2eccf2dcae.camel@redhat.com>
 <4deda035df8142a6977ce844eb705bdb@AcuMS.aculab.com>
In-Reply-To: <4deda035df8142a6977ce844eb705bdb@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jul 2023 16:03:51 +0200
Message-ID: <CANn89iJ--FGA38nLJvZNKyZrqSdGAS1ktsmLULk8ZVRp8XScUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Move hash calculation inside udp4_lib_lookup2()
To: David Laight <David.Laight@aculab.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 4:02=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Paolo Abeni
> > Sent: 26 July 2023 14:44
> >
> > On Wed, 2023-07-26 at 12:05 +0000, David Laight wrote:
> > > Pass the udptable address into udp4_lib_lookup2() instead of the hash=
 slot.
> > >
> > > While ipv4_portaddr_hash(net, IP_ADDR_ANY, 0) is constant for each ne=
t
> > > (the port is an xor) the value isn't saved.
> > > Since the hash function doesn't get simplified when passed zero the h=
ash
> >
> > Are you sure? could you please objdump and compare the binary code
> > generated before and after the patch? In theory all the callers up to
> > __jhash_final() included should be inlined, and the compiler should be
> > able to optimze at least rol32(0, <n>).
>
> I looked the hash is 20+ instructions and pretty much all of
> them appeared twice.
> (I'm in the wrong building to have a buildable kernel tree.)
>
> It has to be said that ipv4_portaddr_hash(net, IPADDR_ANY, port)
> could just be net_hash_mix(net) ^ port.
> (Or maybe you could use a different random value.)
>
> I'm not even sure the relatively expensive mixing of 'saddr'
> is needed - it is one of the local IPv4 addresses.
> Mixing in the remote address for connected sockets might
> be useful for any server code that uses a lot of connected
> udp sockets - but that isn't done.
>
> We will have hundreds of udp sockets with different ports that
> are not connected (I don't know if they get bound to a local
> address). So a remote address hash wouldn't help.
>
> If you look at the generated code for __udp4_lib_lookup()
> it is actually quite horrid.
> Too many called functions with too many parameters.
> Things spill to the stack all the time.
>
> The reuse_port code made it a whole lot worse.
>

Maybe ... Please show us performance numbers.

If less than 1%, I would not bother changing this code, making future
backports more risky.

