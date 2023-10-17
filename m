Return-Path: <netdev+bounces-42049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A07CCD70
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 22:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA11B212DD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D83A430E5;
	Tue, 17 Oct 2023 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEVW8iTR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE20430E2;
	Tue, 17 Oct 2023 20:04:46 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F4448F;
	Tue, 17 Oct 2023 13:04:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-564af0ac494so4067233a12.0;
        Tue, 17 Oct 2023 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697573057; x=1698177857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol+kCKVMHScc7eCHeFPtS5drRW2fVcdYBunG3FxpNVU=;
        b=SEVW8iTRsYaxHLgl9PeUB3hLp12WH2bNIHpcWjZnKVzFCFv0seiLnRfp7NbujECP++
         V4xe3P8mH5Z20ydxPJtvAsoDAeYbARq+6+dvMBKpvFHkYr2o7vjf4lpyVV+7xDCeJroc
         x91J07xQ2fpNxtfmlgEWwQozVPmczszKhc66tY78nbrq5nsK0m6zg2qQlA2hlPSL0zZt
         DLupMDUFFMyXHLyVhcc0DfALKRuX6S3kX9Cpc3b6t2ewc0BODSrWY0jz9QRMFaIoevMO
         HHLPVXP4fhpmqSeDu0QSn/nap36TFqnSGYbHGzZugBbLbQOZNtZOLVxI73Akq3trYRZs
         8PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573057; x=1698177857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol+kCKVMHScc7eCHeFPtS5drRW2fVcdYBunG3FxpNVU=;
        b=Do1dxyW0OaauHIe5CpM5cTqug1v6NRCxGISgJ9Mk5jwgaaIdtI9Yetm13IP87zGzFI
         ES1m3ECAa+rUGBbZ7zHg4zUp9EFxNTmNBHTwPWS4yUNRcp+Sumxihm6viYizQj3lICMU
         OxZixC3vEdErgnb/AK2j7Ln2wGiHPKkGj5jnkntGhdQPabz1ElFgswZHsFuWSbLexBBv
         po1CowmiLw00tG1OQx/P/tGSQ3VONlaOCWI/TBVP/SW4rqZfvSBAo4XU5MzZbEamMv6G
         lbRwCKU5FfufF2OjxLy2QNJuhlPltHdYNFT8/WcyGaSXLksql8mHma/WDS6b1QOuntlL
         Elsg==
X-Gm-Message-State: AOJu0Yz/CFd9i+IB3DfQz548jiQejjmHfV4VBS4rHfAq74jswvXcdWt+
	rK7nCOJi99YFWFzTqEE25YUpflYA/Mw0l3MsZ4I=
X-Google-Smtp-Source: AGHT+IH20edpPTjoyuZ/zAKfSKbi6Gs2ePTV0lH0/UQIVDHwz+x2K9xMfpBS64dmBMGyuFVtEvR30ZcN6dSBjXd9cJE=
X-Received: by 2002:a05:6a20:3c90:b0:17b:3438:cf92 with SMTP id
 b16-20020a056a203c9000b0017b3438cf92mr683432pzj.5.1697573056583; Tue, 17 Oct
 2023 13:04:16 -0700 (PDT)
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
 <20231016163059.23799429@kernel.org> <afb4a06f-cfba-47ba-adb3-09bea7cb5f00@intel.com>
 <CAKgT0UdPe_Lb=E+P+zuwyyWVfqBQWLaomwGLwkqnsr0mf40E+g@mail.gmail.com> <31cde50b-2603-443c-8f55-a0809ecdd987@intel.com>
In-Reply-To: <31cde50b-2603-443c-8f55-a0809ecdd987@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Oct 2023 13:03:39 -0700
Message-ID: <CAKgT0UepNjfPp=TzXyY9Z7rYSGPZyUY64yjB2pqgWTP56=hCcA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
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

On Tue, Oct 17, 2023 at 12:15=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.com> =
wrote:
>
>
>
> On 2023-10-17 12:42, Alexander Duyck wrote:
> > On Mon, Oct 16, 2023 at 5:08=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.co=
m> wrote:
> >>
> >>
> >>
> >> On 2023-10-16 17:30, Jakub Kicinski wrote:
> >>> On Mon, 16 Oct 2023 15:55:21 -0700 Alexander Duyck wrote:
> >>>> It would make more sense to just add it as a variant hash function o=
f
> >>>> toeplitz. If you did it right you could probably make the formatting
> >>>> pretty, something like:
> >>>> RSS hash function:
> >>>>       toeplitz: on
> >>>>           symmetric xor: on
> >>>>       xor: off
> >>>>       crc32: off
> >>>>
> >>>> It doesn't make sense to place it in the input flags and will just
> >>>> cause quick congestion as things get added there. This is an algorit=
hm
> >>>> change so it makes more sense to place it there.
> >>>
> >>> Algo is also a bit confusing, it's more like key pre-processing?
> >>> There's nothing toeplitz about xoring input fields. Works as well
> >>> for CRC32.. or XOR.
> >>>
> >>> We can use one of the reserved fields of struct ethtool_rxfh to carry
> >>> this extension. I think I asked for this at some point, but there's
> >>> only so much repeated feedback one can send in a day :(
> >>
> >> Sorry you felt that. I took you comment [1]:
> >>
> >> "Using hashing algo for configuring fields feels like a dirty hack".
> >>
> >> To mean that the we should not use the hfunc API ("ethtool_rxfh"). Thi=
s
> >> is why in the new series I chose to configure the RSS fields. This als=
o
> >> provides the user with more control and better granularity on which
> >> flow-types to be symmetric, and which protocols (L3 and/or L4) to use.=
 I
> >> have no idea how to do any of these via hfunc/ethtool_rxfh API so it
> >> seemed a better approach.
> >>
> >> I see you marked the series as "Changes Requested". I will send a new
> >> version tomorrow and move the sanity checks inside ice_ethtool.
> >>
> >>
> >> [1]: https://lore.kernel.org/netdev/20230824174336.6fb801d5@kernel.org=
/
> >
> > So one question I would have is what happens if you were to ignore the
> > extra configuration that prevents people from disabling either source
> > or destination from the input? Does it actually have to be hard
> > restricted or do you end up with the hardware generating non-symmetric
> > hashes because it isn't doing the XOR with both source and destination
> > fields?
>
> Do you mean allow the user to use any RSS fields as input? What do we
> gain by that?
>
> The hardware's TOEPLITZ and SYM_TOEPLITZ functions are the same except
> for the XORing step. What gets XOR'd needs to be programmed (Patch 5:
> ice_rss_config_xor()) and we are programming the hardware to XOR the src
> and dst fields to get this hash symmetry. If any fields that are not
> swapped in the other flow direction or if (for example) only src is
> used, the hardware will generate non-symmetric hash.

The point I am getting at is to determine if the
toeplitz-symmetric-xor is actually changes to the inputs or a change
to the algorithm. Based on your description here it is essentially a
subset of toeplitz, and all of the same inputs would apply. All you
have essentially done is collapsed the key. Rather than symmetric
toeplitz this could almost be considered simplified toeplitz.

One side effect of XORing the source and destination data is that you
can essentially collapse the key. You could XOR together the 5 DWORDs
(159 bits) associated with the source and destination IP portion of
the key, and then do the same with the 3 WORDs (47 bits) associated
with the source and destination port. Then you would only have to
process the XORed inputs. As a result you are going to lose a fair bit
of entropy since it effectively cuts the input length and key length
in half. The same could essentially be done by doing a bit of key
manipulation, the simplest approach being using a 16b repeating key
value, and the more nuanced requiring paying attention to IP and port
boundaries in terms of repetition. I would say because of the extra
processing steps it is a different hfunc versus just being a different
set of inputs.

> >
> > My thought would be to possibly just look at reducing your messaging
> > to a warning from the driver if the inputs are not symmetric, but you
> > have your symmetric xor hash function enabled.
>
> With the restrictions (to be moved into ice_ethtool), the user is unable
> to use non-symmetric inputs.

I think a warning would make more sense than an outright restriction.
You could warn on both the enabling if the mask is already unbalanced,
or you could warn if the mask is set to be unbalanced after enabling
your hashing.

