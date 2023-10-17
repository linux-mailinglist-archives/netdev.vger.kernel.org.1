Return-Path: <netdev+bounces-42057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246087CCE54
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5438C1C20BD1
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8B42D798;
	Tue, 17 Oct 2023 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0WEzhR2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF972E402;
	Tue, 17 Oct 2023 20:41:57 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B992;
	Tue, 17 Oct 2023 13:41:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6be0277c05bso2109119b3a.0;
        Tue, 17 Oct 2023 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697575315; x=1698180115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2QjUtUne6LmfA+Yc1sbIHWXuOgvtYAgxxHwnssJ0D4=;
        b=K0WEzhR2QTGtNfP66dLm0yRgkXznos7Ljj9hjm8+wOK9qZ4Qlck2wg3xKJ4Q4fzlpZ
         XAfBrZaSjMxZiInKr/gt3pTJJ7O1tfMz6GH/adoV9DvJBT0kDi1go7CdwwOv8eu7khew
         IRDGv3/7k14mc/NDdA01ZUHUU970+qqgfIyUY+ksFOV+OLpQd83VzHH9xY0KjbUjeuzC
         xson4Zn57p5lFGta3eqY2ev/BL/uUoGw/RC7rpucFuk+XPSWVOHa/7Wifi8G7dzlpKuy
         PTWjnEjJgOcrTHx5K+7K6jePheNWpV9NthmHsBnvuC5W/iuZj9+Nc4JTIc1qR8RzjWML
         FMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575315; x=1698180115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2QjUtUne6LmfA+Yc1sbIHWXuOgvtYAgxxHwnssJ0D4=;
        b=pO6ybbtrSsScuahn9aBWRpZ7Ke6vjx5OwwAnymXUFEqbwu+/PFQJ0JwAeKd4gJI07C
         +/GbTdFCOE2qpkFA5Gvig4OOzBingvMd4xBa2GPAJGjuvMUnfUzprfKOKBdUUejOR/HL
         yJrVndKJDYeAYxpNVur5wvJuScCvQgWrLzB94n7nAGmlinCpo+qLRxyh1+d5xt4NM/6y
         6QWk1Fw0amKGexNHUoeZPUJkqP1JRR9JeCTbPEGC7AoP+ajfUlC4LCuePKXoDQOxV7Fr
         N6DLXhiw1wrULKd3nQNrNYzvo9TxZkOLt32z8804Q2iYz2XQqa2N1Kzn0Yo1rOQs9JlG
         eRlQ==
X-Gm-Message-State: AOJu0YwW03axfUXpKvnnYVDsQyiNDBFSsFRv4jAdM5y32ZeL/kDt9Eh5
	YfjezETD4MqL7SwLQQtPF4ECWEke+DtVvo9MSLE=
X-Google-Smtp-Source: AGHT+IH3uQEast+qVLuY2ClylosZqqA6hbvLCh4rGE/zP/pQWfjFwV2DonPP2EAs13gfBAzP8Z2L1o5+lRxAzEFJyC4=
X-Received: by 2002:a05:6a21:32a4:b0:17b:43:9ba5 with SMTP id
 yt36-20020a056a2132a400b0017b00439ba5mr2683379pzb.52.1697575314977; Tue, 17
 Oct 2023 13:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016154937.41224-1-ahmed.zaki@intel.com> <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
 <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com> <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
 <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com> <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
 <20231016163059.23799429@kernel.org> <CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
 <20231017131727.78e96449@kernel.org>
In-Reply-To: <20231017131727.78e96449@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Oct 2023 13:41:18 -0700
Message-ID: <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, corbet@lwn.net, jesse.brandeburg@intel.com, 
	anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org, 
	mkubecek@suse.cz, willemdebruijn.kernel@gmail.com, linux-doc@vger.kernel.org, 
	Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 1:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Oct 2023 11:37:52 -0700 Alexander Duyck wrote:
> > > Algo is also a bit confusing, it's more like key pre-processing?
> > > There's nothing toeplitz about xoring input fields. Works as well
> > > for CRC32.. or XOR.
> >
> > I agree that the change to the algorithm doesn't necessarily have
> > anything to do with toeplitz, however it is still a change to the
> > algorithm by performing the extra XOR on the inputs prior to
> > processing. That is why I figured it might make sense to just add a
> > new hfunc value that would mean toeplitz w/ symmetric XOR.
>
> XOR is just one form of achieving symmetric hashing, sorting is another.

Right, but there are huge algorithmic differences between the two.
With sorting you don't lose any entropy, whereas with XOR you do. For
example one side effect of XOR is that for every two hosts on the same
IP subnet the IP subnets will cancel out. As such with the same key
192.168.0.1->192.168.0.2 will hash out essentially the same as
fc::1->fc::2.

> > > We can use one of the reserved fields of struct ethtool_rxfh to carry
> > > this extension. I think I asked for this at some point, but there's
> > > only so much repeated feedback one can send in a day :(
> >
> > Why add an extra reserved field when this is just a variant on a hash
> > function? I view it as not being dissimilar to how we handle TSO or
> > tx-checksumming. It would make sense to me to just set something like
> > toeplitz-symmetric-xor to on in order to turn this on.
>
> It's entirely orthogonal. {sym-XOR, sym-sort} x {toep, crc, xor} -
> all combinations can work.
>
> Forget the "is it algo or not algo" question, just purely from data
> normalization perspective, in terms of the API, if combinations make
> sense they should be controllable independently.
>
> https://en.wikipedia.org/wiki/First_normal_form

I am thinking of this from a software engineering perspective. This
symmetric-xor aka simplified-toeplitz is actually much cheaper to
implement in software than the original. As such I would want it to be
considered a separate algorithm as I could make use of something like
that when having to implement RSS in QEMU for instance. Based on
earlier comments it doesn't change the inputs, it just changes how I
have to handle the data and the key. It starts reducing things down to
something like the Intel implementation of Flow Director in terms of
how the key gets generated and hashed.

As far as sorting that is a different can of worms, but I would be
more open to that being an input specific thing as all it would affect
is the ordering of the fields, it doesn't impact how I would have to
handle the key or hash the inputs.

