Return-Path: <netdev+bounces-45441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8267DCFD2
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDE61C20C14
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127741DFD6;
	Tue, 31 Oct 2023 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8uIeS9C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B86DF65;
	Tue, 31 Oct 2023 15:00:14 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12077E4;
	Tue, 31 Oct 2023 08:00:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4275723a12.2;
        Tue, 31 Oct 2023 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698764412; x=1699369212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpUa0c0ro2tLbbAgAvEyUhNQOLHcv6VqwMFHwh6wE9s=;
        b=V8uIeS9CPmn1Qrd0o5MuxpICFx/i+0InaSLQ5mIrBPYwmFWi6DG4yau9asARtnmi63
         fUPIJy9DxLg04a+UV5l4FBBdjUqoqE0zJfb9459oQl0z7Hx0kK6nvCJ9s/9CjFZtnoLZ
         ZTcpWThZYqM9x592dJtGkmBkemNfcQ9eV6HHKPNxrf4STP0UgQ/VwNjTqkYZUBdxy7BX
         vttkB1lA7jR1EiELBV5A/5Ik1He116ujkAHBJRQ1/acWRkAg3TRf1xbvdDY67MjJZ3Ah
         YOKHsZgT7i7EYulzcAWL9OQY+3dhcv5w65kEoPdXOjHWSNPiMGh7+kfXstLA4f5/hJDj
         FUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764412; x=1699369212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpUa0c0ro2tLbbAgAvEyUhNQOLHcv6VqwMFHwh6wE9s=;
        b=WUdr4kb6eOE96DRStTh59PQ6tAxx9riUVEZV4z+Ykjwq+jHA4a5BHb1+oYM+l0F0yW
         vQcOUEWM19Ofck/DPTlcpk/bSbJLIqekqO4Qm4P77JJ8/XtmAp6STzkxbryJHva1Gjnu
         /lrpLvFb6SHUvbhCH2F9FBgid723Zri+esde/RdXiEgNfiZu17RN4PEdktWc28h7l/13
         7tecHcfDsc+dnDhZnhxl//gOLcHfZ5JNruomtYhTMKtsOkSyGmydb5S/Zu47Sfx11dJC
         uhfxbd2fMF9SIyMNHY2PjSDOADf187Jtnpap1ZrFYmHaCd4OIh3cLMzcb3oV//NtQsHs
         jXSA==
X-Gm-Message-State: AOJu0YzdaK3OcD7IX+9Nmvl37DR4V6PpISS0SOIhK08PCZEbCTNTB1SC
	VYJlsW10koQs73A33WNLav3wlsix2tRU0AxidsU=
X-Google-Smtp-Source: AGHT+IFjc/sxR3TCJRREmly4thmkk546QuSy1uQX1ftXCq3d3xvNCegoaYqO9f6wJkoRnH26cjKeRQrvqP7WTZcP3H4=
X-Received: by 2002:a17:90a:62c3:b0:280:85a:b425 with SMTP id
 k3-20020a17090a62c300b00280085ab425mr8949115pjs.49.1698764412260; Tue, 31 Oct
 2023 08:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016154937.41224-1-ahmed.zaki@intel.com> <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
 <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
 <20231016163059.23799429@kernel.org> <CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
 <20231017131727.78e96449@kernel.org> <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
 <20231017173448.3f1c35aa@kernel.org> <CAKgT0Udz+YdkmtO2Gbhr7CccHtBbTpKich4er3qQXY-b2inUoA@mail.gmail.com>
 <20231018165020.55cc4a79@kernel.org> <45c6ab9f-50f6-4e9e-a035-060a4491bded@intel.com>
 <20231020153316.1c152c80@kernel.org> <c2c0dbe8-eee5-4e87-a115-7424ba06d21b@intel.com>
 <20231020164917.69d5cd44@kernel.org> <f6ab0dc1-b5d5-4fff-9ee2-69d21388d4ca@intel.com>
 <89e63967-46c4-49fe-87bc-331c7c2f6aab@nvidia.com> <e644840d-7f3d-4e3c-9e0f-6d958ec865e0@intel.com>
 <e471519b-b253-4121-9eec-f7f05948c258@nvidia.com> <a2a1164f-1492-43d1-9667-5917d0ececcb@intel.com>
 <d097e7d3-5e16-44ba-aa92-dfb7fbedc600@nvidia.com>
In-Reply-To: <d097e7d3-5e16-44ba-aa92-dfb7fbedc600@nvidia.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 31 Oct 2023 07:59:35 -0700
Message-ID: <CAKgT0UdObrDUGKMC7Tneqc4j3tU1jxRugoEB=u63drHhxOeKyw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/6] net: ethtool: allow
 symmetric-xor RSS hash for any flow type
To: Gal Pressman <gal@nvidia.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, Jakub Kicinski <kuba@kernel.org>, mkubecek@suse.cz, 
	andrew@lunn.ch, willemdebruijn.kernel@gmail.com, 
	Wojciech Drewek <wojciech.drewek@intel.com>, corbet@lwn.net, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, jesse.brandeburg@intel.com, edumazet@google.com, 
	anthony.l.nguyen@intel.com, horms@kernel.org, vladimir.oltean@nxp.com, 
	Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 5:01=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote=
:
>
> On 29/10/2023 18:59, Ahmed Zaki wrote:
> >
> >
> > On 2023-10-29 06:48, Gal Pressman wrote:
> >> On 29/10/2023 14:42, Ahmed Zaki wrote:
> >>>
> >>>
> >>> On 2023-10-29 06:25, Gal Pressman wrote:
> >>>> On 21/10/2023 3:00, Ahmed Zaki wrote:
> >>>>>
> >>>>>
> >>>>> On 2023-10-20 17:49, Jakub Kicinski wrote:
> >>>>>> On Fri, 20 Oct 2023 17:14:11 -0600 Ahmed Zaki wrote:
> >>>>>>> I replied to that here:
> >>>>>>>
> >>>>>>> https://lore.kernel.org/all/afb4a06f-cfba-47ba-adb3-09bea7cb5f00@=
intel.com/
> >>>>>>>
> >>>>>>> I am kind of confused now so please bear with me. ethtool either
> >>>>>>> sends
> >>>>>>> "ethtool_rxfh" or "ethtool_rxnfc". AFAIK "ethtool_rxfh" is the
> >>>>>>> interface
> >>>>>>> for "ethtool -X" which is used to set the RSS algorithm. But we
> >>>>>>> kind of
> >>>>>>> agreed to go with "ethtool -U|-N" for symmetric-xor, and that use=
s
> >>>>>>> "ethtool_rxnfc" (as implemented in this series).
> >>>>>>
> >>>>>> I have no strong preference. Sounds like Alex prefers to keep it
> >>>>>> closer
> >>>>>> to algo, which is "ethtool_rxfh".
> >>>>>>
> >>>>>>> Do you mean use "ethtool_rxfh" instead of "ethtool_rxnfc"? how wo=
uld
> >>>>>>> that work on the ethtool user interface?
> >>>>>>
> >>>>>> I don't know what you're asking of us. If you find the code to
> >>>>>> confusing
> >>>>>> maybe someone at Intel can help you :|
> >>>>>
> >>>>> The code is straightforward. I am confused by the requirements: don=
't
> >>>>> add a new algorithm but use "ethtool_rxfh".
> >>>>>
> >>>>> I'll see if I can get more help, may be I am missing something.
> >>>>>
> >>>>
> >>>> What was the decision here?
> >>>> Is this going to be exposed through ethtool -N or -X?
> >>>
> >>> I am working on a new version that uses "ethtool_rxfh" to set the
> >>> symmetric-xor. The user will set per-device via:
> >>>
> >>> ethtool -X eth0 hfunc toeplitz symmetric-xor
> >>>
> >>> then specify the per-flow type RSS fields as usual:
> >>>
> >>> ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
> >>>
> >>> The downside is that all flow-types will have to be either symmetric =
or
> >>> asymmetric.
> >>
> >> Why are we making the interface less flexible than it can be with -N?
> >
> > Alexander Duyck prefers to implement the "symmetric-xor" interface as a=
n
> > algorithm or extension (please refer to previous messages), but ethtool
> > does not provide flowtype/RSS fields setting via "-X". The above was th=
e
> > best solution that we (at Intel) could think of.
>
> OK, it's a weird we're deliberately limiting our interface, given
> there's already hardware that supports controlling symmetric hashing per
> flow type.
>
> I saw you mentioned the way ice hardware implements symmetric-xor
> somewhere, it definitely needs to be added somewhere in our
> documentation to prevent confusion.
> mlx5 hardware also does symmetric hashing with xor, but not exactly as
> you described, we need the algorithm to be clear.

It is precisely because of the way the symmetric-xor implements it
that I suggested that they change the algo type instead of the input
fields.

Instead of doing something such as rearranging the inputs, what they
do is start XORing them together and then using those values for both
the source and destination ports. It would be one thing if they
swapped them, but instead they destroy the entropy provided by XORing
the values together and then doubling them up in the source and
destination fields. The result is the hash value becomes predictable
in that once you know the target you just have to offset the source
and destination port/IP by the same amount so that they hash out to
the same values, and as a result it would make DDoS attacks based on
the RSS hash much easier.

Where I draw the line in this is if we start losing entropy without
explicitly removing the value then it is part of the algo, whereas if
it is something such as placement or us explicitly saying we don't
want certain fields in there then it would be part of the input.
Adding fields to the input should increase or at least maintain the
entropy is my point of view.

