Return-Path: <netdev+bounces-42054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37457CCE13
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 22:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263A7B21137
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E4643119;
	Tue, 17 Oct 2023 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTxGbbMZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8B43105;
	Tue, 17 Oct 2023 20:29:32 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7929F;
	Tue, 17 Oct 2023 13:29:31 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c4fa1c804bso4185658a34.2;
        Tue, 17 Oct 2023 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697574570; x=1698179370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7+b5JfTWkepP8jCDtrMDryElpr4dXa6a9h6U1KYSv8=;
        b=ZTxGbbMZ2ZzaFzcjFlcsTFSs4VDKxwD62tISCp9nnH3SIeur6Pvct1pnKyev475Xfo
         233NpQZeFxLrFXRxja4Qi+C7PNbTbG6o6kWEg/FmCDuubgSSX5TnHAcBRCxaARNtWdOb
         X1DRPcavUb6gjcCgW2u9qDUUATn/z6lEHM7KlJYnj+4SqxI15FGp5PR6pQsPfh6tF9kM
         Aw4xgAhcjTnUdlid9yUek4UaHlrLu5N8qkMtKCxVm3lj/P/Cdechf/MHRB8Iy6V0LZOk
         HVCGF0LyJQllUik2JjlL+aHMr+jPefB9XcmIjkYcPDNCbqReFZKR8+8Blb/ojgtkOBxW
         dPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574570; x=1698179370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7+b5JfTWkepP8jCDtrMDryElpr4dXa6a9h6U1KYSv8=;
        b=ek/sEfe0d/jdY+JJ52rOJ4krNFPK9qjD4EttsdGYxI9hF6KHvmZSATtjp771ODE89Y
         fQ0jHFy7jCtFA3R+I2kZx2ZLAQWvdd7IfkY7rUTlfor96iDTLEDroqUNVQpUXSmj6wyG
         uF8o6/NYC3T5RiFMk1Etz91Yjukx7bP1WjEf5FG9ePCBAZgMgWTp/p3STJ5pUdQeZ4IF
         6S/z16eHoYRqeKjHayip7XNDgI3m62TurXbFODxvhOVwdhXNbvax2UAPFZHNIUSzgGHV
         0IuqbfjUzENQI2OAQZXXe8g6FJDP8y4U8oBmfaJKOQgVNaiE32t/4Yblo2/KJHKAVIPD
         mjZg==
X-Gm-Message-State: AOJu0YwXeeXTMQWN4rbbBSNQ9POg6H2RdX46kiwkqK3eHUE/wsEcrFJk
	D5rsiWlOxnlDkPByFL4Sx2KfR7Xjl0PCwe1RC7U=
X-Google-Smtp-Source: AGHT+IEuxiv8xSGBDDCBbap36vPXxEu6RmtoHlSJvC8QGyQS0zJBXqiXAnDvnTGZ3kxdkWndU3a5kENQVXQ/0lDJilU=
X-Received: by 2002:a05:6870:7f06:b0:1e9:93c0:34f6 with SMTP id
 xa6-20020a0568707f0600b001e993c034f6mr2896216oab.55.1697574570351; Tue, 17
 Oct 2023 13:29:30 -0700 (PDT)
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
 <CAKgT0UdPe_Lb=E+P+zuwyyWVfqBQWLaomwGLwkqnsr0mf40E+g@mail.gmail.com>
 <31cde50b-2603-443c-8f55-a0809ecdd987@intel.com> <CAKgT0UepNjfPp=TzXyY9Z7rYSGPZyUY64yjB2pqgWTP56=hCcA@mail.gmail.com>
 <20231017131957.200bbb7e@kernel.org>
In-Reply-To: <20231017131957.200bbb7e@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Oct 2023 13:28:53 -0700
Message-ID: <CAKgT0UeP8mbpakyjEqkDNZPArZpM59mxb5ExMCQ2qV2qSf-jMg@mail.gmail.com>
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

On Tue, Oct 17, 2023 at 1:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Oct 2023 13:03:39 -0700 Alexander Duyck wrote:
> > > > My thought would be to possibly just look at reducing your messagin=
g
> > > > to a warning from the driver if the inputs are not symmetric, but y=
ou
> > > > have your symmetric xor hash function enabled.
> > >
> > > With the restrictions (to be moved into ice_ethtool), the user is una=
ble
> > > to use non-symmetric inputs.
> >
> > I think a warning would make more sense than an outright restriction.
> > You could warn on both the enabling if the mask is already unbalanced,
> > or you could warn if the mask is set to be unbalanced after enabling
> > your hashing.
>
> Either it's a valid configuration or we should error out in the core.
> Keep in mind that we can always _loosen_ the restriction, like you
> asked for VLAN ID, but we can never _tighten_ it without breaking uAPI.
> So error.

I would say it is a valid configuration then. If the user opts to
shoot themselves in the foot then so be it. It doesn't actually break
anything and is just there to make sure the hashing conforms to the
marketing use case.

