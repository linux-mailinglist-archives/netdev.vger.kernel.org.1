Return-Path: <netdev+bounces-25050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D19772C09
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5FF2814BC
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0393125D8;
	Mon,  7 Aug 2023 17:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB40125D1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:06:45 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB741722
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 10:06:43 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-564fb0b4934so1332856a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 10:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691428003; x=1692032803;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCqBPwcGvk4SNm1HywtZ952fQL+NIVgTalXwXvLxX4g=;
        b=uPDjltqLhHoJE8CSxsuf7vt2t+Uze7UPvuMnwoyK2QkynAL3x9YdBy2gsiB2NBlySX
         KF0iLHdKeXtWrlhvsZ4xWvX0QiCDH2qKiOASHo8gmV9HXkX487MJQWC74l8qMFrhDfEa
         F+XSWTHSLi07Yw4pJmj2GVGN8onxL2Phv5QhrE0Di04XwK3ZuG6C9Wpp8+wCFXLbUuLm
         4djmJ1ipg/XZYtsPh7/D0I/+otHuzZ70DVAx/WsZtavKjlKeeqLRB5UfXuSSTQpMawWo
         O/V1y5GuhSTGtlKAFDhoTzcPOCSEwJgde1Z+5aMtw8SsisX2ZN/FOBNrJl8/hsC+aEoC
         cMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428003; x=1692032803;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xCqBPwcGvk4SNm1HywtZ952fQL+NIVgTalXwXvLxX4g=;
        b=PrIPRRhhLjmL4/MgNWXgNiA7j9n8ra4+CWJVyUKkcFPpFOgF2h19WZytjx/GDLvRPK
         HmAUS3Z3lX+qmppfYSAGQboRVWzlF3k/tj7jLgXrp2GCBr4sCd5Q5WX7tqA7QIKjfTVY
         yWKKf0Kf2fWVSueIhEjMADHUYp7gwTaCRI5LXLysmPxCe8x+BUnIjATlnagOeLMcchig
         RLKr9x1aJFrAisXMSNAbqc2/4AVeaqAKvtZ+gGX3ZyP8VsP/QWabOM/cbsQhT3p9SCrG
         C4ia21Htfu43wRiWg0EWiAOV71GN1kYpdrjeerzwF2roES7FNW5olWwBnNzXX/qYx1QS
         XMgg==
X-Gm-Message-State: AOJu0Yy2dQV9GZA5ZHu92tGVwwUuj7hWOa6IXcb8au/hApNIAH6MYQ1d
	JlUac61VTcAhU5xSyEbc5DUSvf0=
X-Google-Smtp-Source: AGHT+IF1Ub8nnXN9lzviQxESFtGW3uOj/sIuB471K04fFyWhyNrpqbHOMftxvXz27Zww5FuvYIZ2idY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:b218:0:b0:563:3b08:f869 with SMTP id
 x24-20020a63b218000000b005633b08f869mr46596pge.2.1691428003007; Mon, 07 Aug
 2023 10:06:43 -0700 (PDT)
Date: Mon, 7 Aug 2023 10:06:41 -0700
In-Reply-To: <ZNEOf3vTu6pmNG1J@lincoln>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com> <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
 <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch> <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
 <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
 <ZMeSUrOfhq9dWz6f@lincoln> <CAADnVQJPgpo7J0qVTQJYYocZ=Jnw=O5GfN2=PyAQ55+WWG_DVg@mail.gmail.com>
 <ZNEOf3vTu6pmNG1J@lincoln>
Message-ID: <ZNEkofzo04pCbFvO@google.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>, 
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, 
	Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net, 
	Network Development <netdev@vger.kernel.org>, Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/07, Larysa Zaremba wrote:
> On Mon, Jul 31, 2023 at 06:03:26PM -0700, Alexei Starovoitov wrote:
> > On Mon, Jul 31, 2023 at 3:56=E2=80=AFAM Larysa Zaremba <larysa.zaremba@=
intel.com> wrote:
> > >
> > > On Sun, Jul 30, 2023 at 09:13:02AM -0400, Willem de Bruijn wrote:
> > > > Alexei Starovoitov wrote:
> > > > > On Sat, Jul 29, 2023 at 9:15=E2=80=AFAM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Alexei Starovoitov wrote:
> > > > > > > On Fri, Jul 28, 2023 at 07:39:14PM +0200, Larysa Zaremba wrot=
e:
> > > > > > > >
> > > > > > > > +union xdp_csum_info {
> > > > > > > > +   /* Checksum referred to by ``csum_start + csum_offset``=
 is considered
> > > > > > > > +    * valid, but was never calculated, TX device has to do=
 this,
> > > > > > > > +    * starting from csum_start packet byte.
> > > > > > > > +    * Any preceding checksums are also considered valid.
> > > > > > > > +    * Available, if ``status =3D=3D XDP_CHECKSUM_PARTIAL``=
.
> > > > > > > > +    */
> > > > > > > > +   struct {
> > > > > > > > +           u16 csum_start;
> > > > > > > > +           u16 csum_offset;
> > > > > > > > +   };
> > > > > > > > +
> > > > > > >
> > > > > > > CHECKSUM_PARTIAL makes sense on TX, but this RX. I don't see =
in the above.
> > > > > >
> > > > > > It can be observed on RX when packets are looped.
> > > > > >
> > > > > > This may be observed even in XDP on veth.
> > > > >
> > > > > veth and XDP is a broken combination. GSO packets coming out of c=
ontainers
> > > > > cannot be parsed properly by XDP.
> > > > > It was added mainly for testing. Just like "generic XDP".
> > > > > bpf progs at skb layer is much better fit for veth.
> > > >
> > > > Ok. Still, seems forward looking and little cost to define the
> > > > constant?
> > > >
> > >
> > > +1
> > > CHECKSUM_PARTIAL is mostly for testing and removing/adding it doesn't=
 change
> > > anything from the perspective of the user that does not use it, so I =
think it is
> > > worth having.
> >=20
> > "little cost to define the constant".
> > Not really. A constant in UAPI is a heavy burden.
>=20
> Sorry for the delayed response.
>=20
> I still do not comprehend the problem fully for this particular case,=20
> considering it shouldn't block any future changes to the API by itself.
>=20
> But, I personally have no reason to push hard the veth-supporting changes=
=20
> (aside from wanting the tests to look nicer).
>=20
> Still, before removing this in v5, I would like to get some additional fe=
edback=20
> on this, preferably from Jesper (who, if I remember correctly, takes an i=
nterest=20
> in XDP on veth) or Stanislav.
>=20
> If instead of union xdp_csum_info we will have just checksum as a second=
=20
> argument, there will be no going back for this particular kfunc, so I wan=
t to be=20
> sure nobody will ever need such feature.
>=20
> [...]

I'm interested in veth only from the testing pow, so if we lose
csum_partial on veth (and it becomes _none?), I don't see any issue
with that.

