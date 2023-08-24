Return-Path: <netdev+bounces-30535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C1C787C00
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 01:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B45E2816F5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A1C13A;
	Thu, 24 Aug 2023 23:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0017E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 23:30:26 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4CBC7
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:30:21 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-64914f08c65so2256106d6.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692919820; x=1693524620;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BByVGwxzCpjaN5tiQn8XIAX+kEX1tvFbh/7mJtZcL30=;
        b=gSq5Dg8MXytYcalduds1I+Ny7xfpZXBILzUCa3t77wgmGOUbu6TuTaUnsjTA5wByQi
         +hDML8rjR2LD1casEklgfc99jebiuY4NE0MSkAn2iH6vOu93ZcBWpx3YUoxFoQFEmada
         lw9Y2Vz9JsPnv0ZozjtOOv1VCY6CzomLqxY+xcZAMBYLeo+WhLGahymGsoqWq7Dla6BR
         nExF8t6S6WyvlTeCTY8Cr5ABi3gzcM9BsOrOd8Vf5Z/Xl67/FynGZnggBjNzAEwbhKqN
         fcUWNV8kPYYH1PRhDBgcLdabv6kbTIY9X1At9Bp+d7M9fZn+Ypv+nkrvWPwLgKUS03m7
         fhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692919820; x=1693524620;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BByVGwxzCpjaN5tiQn8XIAX+kEX1tvFbh/7mJtZcL30=;
        b=ArDG08L/EbQnjCBsrqqJzFf95nXcWLtUCOT3UzqzjEwQifOrSlkEpsMtS9TpEtleLc
         xRE163Ei+9hTj26Oe2e9Xb0ipSXoFBZCM380g6z751ZO8SH/DtdrWAQb4HpmsQ8NQ2z2
         K0DRD+shbun+kKbmy6driJxqXxmy9iK+wWaIV2X4cQT0x4pfJ1T274Vh5+4KcfFVfbll
         MYa9jD8m4ne0SSA7zwo/7DGTpXPKT5x08/VSi7SVfz4UpAtkE++oVb2go4a+pvbmVOXx
         YsC2nYXB291WDpBY5cmm7RP57l6L4EYIyPyGlnQHMalmWBoZzNBh0qPXMRsJ7Nwwipm4
         n3mw==
X-Gm-Message-State: AOJu0Yydz5eN2lIwNQXNX0gYAr7kwSc995M6OWwtMG4Aq9ScqsjSTAp0
	jWbUqpSO2s5+jxyj8O1+VFREqSruc38=
X-Google-Smtp-Source: AGHT+IF5fIXswO5Ucql+VVgTn03K+mZBpfML4PEeL+chP9bWw5lMTPwPnsT10LHoHRLQGUxpVPVk4w==
X-Received: by 2002:a0c:b355:0:b0:647:2f8f:8c29 with SMTP id a21-20020a0cb355000000b006472f8f8c29mr16788686qvf.48.1692919820532;
        Thu, 24 Aug 2023 16:30:20 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id v14-20020ae9e30e000000b00767d2870e39sm153719qkf.41.2023.08.24.16.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:30:20 -0700 (PDT)
Date: Thu, 24 Aug 2023 19:30:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, 
 Saeed Mahameed <saeed@kernel.org>
Cc: netdev@vger.kernel.org, 
 jesse.brandeburg@intel.com, 
 anthony.l.nguyen@intel.com
Message-ID: <64e7e80c13b60_4b65d29437@willemb.c.googlers.com.notmuch>
In-Reply-To: <4f0393fb-7f5a-5e91-ce43-4b2d842dd9b3@intel.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
 <20230823164831.3284341-2-ahmed.zaki@intel.com>
 <ZOZhzYExHgnSBej4@x130>
 <94d9c857-2c2b-77f0-9b17-8088068eee6d@intel.com>
 <ZOejNYJgR74JGRse@x130>
 <4f0393fb-7f5a-5e91-ce43-4b2d842dd9b3@intel.com>
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz RSS
 hash function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ahmed Zaki wrote:
> =

> On 2023-08-24 12:36, Saeed Mahameed wrote:
> > On 24 Aug 07:14, Ahmed Zaki wrote:
> >>
> >> On 2023-08-23 13:45, Saeed Mahameed wrote:
> >>> On 23 Aug 10:48, Ahmed Zaki wrote:
> >>>> Symmetric RSS hash functions are beneficial in applications that =

> >>>> monitor
> >>>> both Tx and Rx packets of the same flow (IDS, software firewalls, =

> >>>> ..etc).
> >>>> Getting all traffic of the same flow on the same RX queue results =
in
> >>>> higher CPU cache efficiency.
> >>>>
> >
> > ...
> >
> >>>
> >>> What is the expectation of the symmetric toeplitz hash, how do you =

> >>> achieve
> >>> that? by sorting packet fields? which fields?
> >>>
> >>> Can you please provide a link to documentation/spec?
> >>> We should make sure all vendors agree on implementation and =

> >>> expectation of
> >>> the symmetric hash function.
> >>
> >> The way the Intel NICs are achieving this hash symmetry is by XORing=
 =

> >> the source and destination values of the IP and L4 ports and then =

> >> feeding these values to the regular Toeplitz (in-tree) hash algorith=
m.
> >>
> >> For example, for UDP/IPv4, the input fields for the Toeplitz hash =

> >> would be:
> >>
> >> (SRC_IP, DST_IP, SRC_PORT,=C2=A0 DST_PORT)
> >>
> >
> > So you mangle the input. This is different than the paper you
> > referenced below which doesn't change the input but it modifies the R=
SS
> > algorithm and uses a special hash key.
> >
> >> If symmetric Toeplitz is set, the NIC XOR the src and dst fields:
> >>
> >> (SRC_IP^DST_IP ,=C2=A0 SRC_IP^DST_IP, SRC_PORT^DST_PORT, SRC_PORT^DS=
T_PORT)
> >>
> >> This way, the output hash would be the same for both flow directions=
. =

> >> Same is applicable for IPv6, TCP and SCTP.
> >>
> >
> > I understand the motivation, I just want to make sure the =

> > interpretation is
> > clear, I agree with Jakub, we should use a clear name for the ethtool=

> > parameter or allow users to select "xor-ed"/"sorted" fields as Jakub
> > suggested.
> >> Regarding the documentation, the above is available in our public =

> >> datasheets [2]. In the final version, I can add similar explanation =

> >> in the headers (kdoc) and under "Documentation/networking/" so that =

> >> there is a clear understanding of the algorithm.

Please do define the behavior.

When I hear symmetric Toeplitz, my initial assumption was also
sorted fields, as implemented in __flow_hash_consistentify.

If this is something else, agreed that that is good to make
crystal clear in name and somewhere in the kernel Documentation.
xor-symmetric hash?

