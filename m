Return-Path: <netdev+bounces-35058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E37A6B8B
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 21:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F5C28194C
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0B42AB45;
	Tue, 19 Sep 2023 19:23:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8C1865A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 19:23:26 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD899D
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:23:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-273d9b1908eso1502144a91.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695151393; x=1695756193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAnjs0mFCn+qyZ5rAIxb7rIqkT4eggDQJ8b5rJPPOqo=;
        b=VWYi4emtxGEocRQXZI2YejJHwtYXykIrFNE9XTEui4y4Pzt+L6SSkWvYiA1U1inVGv
         w4MfvjvPLJMcgsOYlMqTYGGUvBqsUUemD6hkWbq9WhVNPgsnv80KtuD+DhYvFpQtGmLe
         pULAV3HwcLoZ0m8/C8wDn+9E6Ay2HH3WNg78F5yYr/ZZy80tXLNItM3WFGqQliSJBphg
         Kg+j4g/BdMXQ5FvxT9ECN1Gb27bDiPr93fgqormFD20CuRMypozWJqPirprlpLdu3Ai6
         6EzxLFi5mMleHW3QjqggGq7N6sX6d7qt2J61nhi+0ENMgIdSwfeeTQVWx7cZh/1Bpmh3
         gb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151393; x=1695756193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAnjs0mFCn+qyZ5rAIxb7rIqkT4eggDQJ8b5rJPPOqo=;
        b=FyWRHS2Psct2OE6pDvp+1Np1R7DV992NgAjB4LFrOEZuH/FLrluPysl2mBST7SaFvB
         t8W4FA3I5eO8W7HBR2lz07mxuYlDEauCiwkSPaFGMksXq6i3Nkilaygwlz6u9habdxH/
         f+xTCPc7p9YLfX10Ld092Mzaz3/DudH7rLASniF3B6W29uFpR21DjEXdnU3xILD30aJC
         dr4Tx5274QMz+Z61DFgxNOvVdKnhZWeVnFzVOc/0T+0jNUlCCK2+zCT1xZe9N3yC06cc
         Yk8qo2YMuN8WeyPjIU4B6Rl7ISZ1qurJG8yxzQWTnLMZhvuurSjExKXe8vG6iTcWPl+o
         XoMA==
X-Gm-Message-State: AOJu0Yxx85pOpLBwSHGoIka2bBt4DC1DzvU/d5FPCweSBaHJekNmJkXE
	rrmsnHv2T8ViQm97z2d+w7pYr1t+8B1c0iTk0/U=
X-Google-Smtp-Source: AGHT+IE7/DTt4lwslNIX2CLuR/nNnaNsDo8xPF0/u8s5QcGa7gGiCVllihkE+GHRhFtNrzrAwEvzuQ0DJNsEBTcZxGs=
X-Received: by 2002:a17:90a:674b:b0:25c:1ad3:a4a1 with SMTP id
 c11-20020a17090a674b00b0025c1ad3a4a1mr590950pjm.1.1695151393113; Tue, 19 Sep
 2023 12:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch> <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
 <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch> <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
 <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch> <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
 <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch> <CAOMZO5C3zPsu_K3z09Rc5+U1NCLc3wqbTpbeScn_yO02HwYkAg@mail.gmail.com>
 <2ff5a364-d6b3-4eda-ab5c-e61d4f7f4054@lunn.ch>
In-Reply-To: <2ff5a364-d6b3-4eda-ab5c-e61d4f7f4054@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 19 Sep 2023 16:23:01 -0300
Message-ID: <CAOMZO5D-F+V+5LFGqiw_N8tNPtAVMANGQjUnUW9_WeTj6sBN5g@mail.gmail.com>
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com, netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Fri, Sep 15, 2023 at 3:23=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> The problem with this is that the way to read the contests of the
> EEPROM depend on the switch family.
>
> linux/drivers/net/dsa/mv88e6xxx$ grep \.get_eeprom chip.c
>         .get_eeprom =3D mv88e6xxx_g2_get_eeprom8,
>         .get_eeprom =3D mv88e6xxx_g2_get_eeprom16,

Indeed, there are two methods for reading the EEPROM.

> And how do you know the EEPROM does not in fact contain 0xffff?

The functional spec doc says:

"If the just read in Command is all one=E2=80=99s, terminate the serial EEP=
ROM
reading process, go to 8."

> What i found interesting in the datasheet for the 6352:
>
>      The EEInt indicates the processing of the EEPROM contents is
>      complete and the I/O registers are now available for CPU
>      access. A CPU can use this interrupt to know it is OK to start
>      accessing the device=E2=80=99s registers. The EEInt will assert the
>      device=E2=80=99s INT pin even if not EEPROM is attached unless the E=
EPROM
>      changes the contents of the EEIntMast register (Global 1, offset
>      0x04) or if the Test SW_MODE has been configured (see 8888E6352,
>      88E6240, 88E6176, and 88E6172 Functional Specification Datasheet,
>      Part 1 of 3: Overview, Pinout, Applications, Mechanical and
>      Electrical Specifications for details).  The StatsDone, VTUDone
>      and ATUDone interrupts de-assert after the Switch Globa
>
> So i would expect that EEInt is set when there is no EEPROM.
>
> What strapping do you have for SW_MODE? Is the switch actually in
> standalone mode?

Pardon my ignorance, but I don't know the answer to these.

I do have access to the schematics. How can I tell?

Thanks

