Return-Path: <netdev+bounces-12831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB07390E3
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D38E281759
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ABA19E6A;
	Wed, 21 Jun 2023 20:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6317724
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 20:38:39 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF219BD;
	Wed, 21 Jun 2023 13:38:34 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-471b3ad20e1so1198154e0c.1;
        Wed, 21 Jun 2023 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687379914; x=1689971914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLj5idC5I/QLiRFMvWiNyMDzS3MjZTMihHHTmTOAHD4=;
        b=QJwNsmdPlDmntrEtGy94/MBwAUCDKiL6efLCv+MnQtJ60YrqrNX8JtAfWruIJKP8u8
         ivgZJWi555Oy00x39+3TORAu41cPfOHYeeoPvxcNszPm3uYCSvtAVLoFkjH97VpWwGQr
         dTIrJopGXiopUN84IXeJrAIywdxRh6ml4/YCVnE9VarLvlASWW59ftTqIQZxgDjlARE0
         Aur01U3FStnPsC/P5HboSLQ81eY3HeclJ9uopSSzbvaZdk+nidrGAPfFs1+dxtP11F2j
         TOUuVQmwWWapKr6MFs3+OuK5N7309W0NUyvU3EmR53SA+cyXDjuAGr5pLuu5l1EXXIKV
         K17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687379914; x=1689971914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLj5idC5I/QLiRFMvWiNyMDzS3MjZTMihHHTmTOAHD4=;
        b=Q8QXGZXxYKhmaQxWnKgcwTDNEJPUVz3ZMxljqyjtOECseNh5A6OEZK9q3P0pkZJjg2
         kD8+03r3tT6ynwXpmco20+6qG2rVjsJdTmRbNLWfYM7ysNtptGHOC+CD7FfoJnFHQRbV
         n+29wEfzeKMsVnHiicElG5Vl1oHSXNQWEX68K30lLjp62JNiUzJj8thxTmP9L2PtWLWd
         xqjR+miZ3iPxzJfZ9xuPITFLz9xCyBNIaSXJCaEojM2C8gvYpoTIhDVYbQRLzv+ak5tN
         8SJxxo6lf+ZNW8bspjKTrNc1fP6ElX3hF/xu472TqM3sURZbii96SGadOjuyY45JCeXq
         MwgA==
X-Gm-Message-State: AC+VfDz7W+pOYz8s/fEzF6Rqp3CloAeVQS/1cJKz5k5NRXlQszlQikHL
	/VIHcar9DEtGLo76CfH+6DAAQnsg8Rx8HLJ5W4K6rfEDCjQ0yw==
X-Google-Smtp-Source: ACHHUZ59RQy1rbcrJHLGEHxMK5GtycVXYDre/j5n11mt8FPqkRZBUBmllkKurw3az4lYUvMXqERzok4mxP8O7UEMam8=
X-Received: by 2002:a1f:c1c6:0:b0:471:8787:2c6c with SMTP id
 r189-20020a1fc1c6000000b0047187872c6cmr4706478vkf.6.1687379913586; Wed, 21
 Jun 2023 13:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
 <20230621191302.1405623-2-paweldembicki@gmail.com> <27e0f7c9-71a8-4882-ab65-6c42d969ea4f@lunn.ch>
In-Reply-To: <27e0f7c9-71a8-4882-ab65-6c42d969ea4f@lunn.ch>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Wed, 21 Jun 2023 22:38:22 +0200
Message-ID: <CAJN1KkxGNZgzSA2_gVmMRg-LsZmZC2hQEvEjQQ3RSTT9ddGcAQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set function
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

=C5=9Br., 21 cze 2023 o 21:33 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     /* FIXME: STP frames isn't forwarded at this moment. BPDU frames =
are
> > +      * forwarded only from to PI/SI interface. For more info see chap=
ter
> > +      * 2.7.1 (CPU Forwarding) in datasheet.
>
> Do you mean the CPU never gets to see the BPDU frames?
>
> Does the hardware have any sort of packet matching to trap frames to
> the CPU? Can you match on the destination MAC address
> 01:80:C2:00:00:00 ?
>

Analyzer in VSC73XX switches can send some kind of packages to (and
from) processor via registers available from SPI/Platform BUS (for
some external analysis).  In some cases it's possible to configure: if
packet will be copied or forwarded to this special CPU queue.  But
BPDU frames could be sent to processor via CPU queue only. So It's
impossible to forward bridge control data via rgmii interface.

--
Pawel Dembicki

