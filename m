Return-Path: <netdev+bounces-42281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5537E7CE09C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18ECE28102E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4BA37C9A;
	Wed, 18 Oct 2023 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAV69AUY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7D15AC4
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:01:05 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E384FA
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:01:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so74125e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697641261; x=1698246061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk+MM8czq8tgZOqn2VBLd0vJ/2zm2P/1DV6ZL3LXnqE=;
        b=aAV69AUYEaScpeEE4dqzuh1sZIvqWOPFIphoLC8aRoiaT8GrEqautZKWObyyzrjvRn
         UrWfntfBBY3PlHLKvBFHO236zsWpGT0Femg6Be9eC6TBUmHlc8t7TsbecToKqBPscogd
         H7YSZJhIi4H8Wh+WVhIHRnoHT1pyU3L88I+Ovu9kOn+vcuc2Cvl83DFithEHOu3j2/ie
         DUth8KVwby4BnASthE5KHIb82K53Ao4D1hIy7LXlZU1GmVhymlbIi/WqfyirYlE/rSD2
         wG5mrjVNMVoqqThc3pyQ2u8OD4SWfUDDQTp9C2QuSJZFGbHKt1Tss4cVXcpUFYiVcm24
         aREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641261; x=1698246061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fk+MM8czq8tgZOqn2VBLd0vJ/2zm2P/1DV6ZL3LXnqE=;
        b=RvTrY8BBYddTGp1QUOrMklJmgIGwQNNOc3vYPoHSjtBm+RvtK9AWsRvU9DBfjhwS7l
         olDUbQ8l/Z+9cM84js53Xo0QRyGy/ki6lXPczl1/sb4l+HopFxHZ1mZlv9i1ksk1pWdN
         6j2t0wcwjE3i6PKsUJQPq+78lupU/jI4FKLgEDAR77nHvhJJglpng+vUJPBMzsDeGBRL
         55z79hJLutKmz+f3iCyFChDEVPMspIAiG27Y1Y/9TW32HxiB6CreJW29vZeks6pnUFWK
         ZyMeOOJdATA1n8kHoe/Qw8AOwCYs0cnH28mVEH6qJ2gRLOZk8WWXXukUqCW3jWcUU1pV
         L11A==
X-Gm-Message-State: AOJu0YyG7os8jv8i8Js/hZFsRBeTZkdSas7R84OlkgyH96KoHmuYfeS8
	bGVwmDwa3SObXrbMRSjjQx/Nvm2cNr1Qu1egAwExXw==
X-Google-Smtp-Source: AGHT+IFWwSb1RVFY6lDcXkgSyswXKbEpQdqRJL3k+/d4+rZy2CE3vpR2U4Gis3Ebw3YUMony2CiNFuWPAhLI9dg3x/Q=
X-Received: by 2002:a1c:790b:0:b0:405:38d1:e146 with SMTP id
 l11-20020a1c790b000000b0040538d1e146mr135173wme.4.1697641261203; Wed, 18 Oct
 2023 08:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016125934.1970789-1-vschneid@redhat.com> <CANn89i+pQ3j+rb2SjFWjCU7BEges3TADDes5+csEr1JJamtzPQ@mail.gmail.com>
 <xhsmhil74m10c.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhil74m10c.mognet@vschneid.remote.csb>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Oct 2023 17:00:46 +0200
Message-ID: <CANn89iJUicsEdbp7qrsaSUg8jQ=dBUr0nK296LxXp5rnPrw8cA@mail.gmail.com>
Subject: Re: [RFC PATCH] tcp/dcpp: Un-pin tw_timer
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 4:57=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:

>
> Looks reasonable to me, I'll go write v2.
>
> Thanks for the help!

Sure thing !

BTW, we also use TIMER_PINNED for req->rsk_timer, are you working on it too=
 ?

