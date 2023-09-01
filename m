Return-Path: <netdev+bounces-31752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5069A78FEE4
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D151C20CEE
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE8EC125;
	Fri,  1 Sep 2023 14:20:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7CAD41
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 14:20:30 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6810FB
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 07:20:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52c1d861c5eso7920a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693578021; x=1694182821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLYc3vJ+1jGUSwUQ2/6dymNSsyl9qkwUUYtxF6WyxJw=;
        b=2tfbcEwe0FPb5STb54hDNn+vHAGxRhrjXH190OnX6yXy26JH7tFnY0jtbG1iezDIA6
         n2REe+/c6z3ZqEom8fo8oxZoovPVoT2XUBzIH8+FJK6OLh3Y4MtT7ZVCx652s8iyy0iC
         V3QFxkbCJXgDxUZFyBn/4cnz1OH82V1VVKbZ/JKLBJfnNtauWGPKwlMw3ji0iutrcyyW
         VfouyVXdqfAYVSgPMUwQ3KPYGgYTeiEs6j/hh8CN+wlTpf3iuImLPSn4UPKehGCzibDJ
         1l4SbVqptRDw6Gca5JnGr8JB3bg+Atb23AUuRAXYoxK7TbvjODG9qq9TuW1nKhSbJgLv
         uNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578021; x=1694182821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLYc3vJ+1jGUSwUQ2/6dymNSsyl9qkwUUYtxF6WyxJw=;
        b=gTH7GQxvtU8h5oa4l/0/0xnpKqDGdA+tz5cQYtTGWv6zg964//ynE0wrQXS0tIWv3g
         x/y2WHlUiUHQXQRMVPsLLvANCD3bd8Y9nYimvZ5PVmWBIoiZl32AMKcPoIOEgVa15FjA
         4lyE3KOEhnu6yDopKe4KdCD1ysksnH7avqZEmXKPx1E3au7q00vUNFdshYnXUIPKkODr
         QKuywvTfjMLcxhszsja8DJEYCurSfSflphayOOxjdmTFp4kLw5HJiDq1PEOghhsu71No
         rkKoUupzgteAWVLvCa0bxHd8x9sQN7Bpo14bP82t/FRkpm/Rq3ke3R9STvmy5pIzrr4+
         nLTw==
X-Gm-Message-State: AOJu0YwE84qpPHn6TkysFfudJ+F1wDHRQoBrNRvXtjxJ695jZKakZ/Lo
	ZUjXrYmi6EBJ+00VEwfRoflIE34tERMA/nWZ5x0Tyg==
X-Google-Smtp-Source: AGHT+IE6fqZNxfUiGPgMvrGpigzvO9Rm8Cr5t8QclfJHuwLJqwIUeKNnkpKrOdMXSwPYk16Aapf7gLbmTuVpnWuLLjc=
X-Received: by 2002:a50:8d5c:0:b0:525:573c:643b with SMTP id
 t28-20020a508d5c000000b00525573c643bmr116417edt.7.1693578020944; Fri, 01 Sep
 2023 07:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606140041.3244713-1-ptf@google.com> <CAJs+hrHAz17Kvr=9e2FR+R=qZK1TyhpMyHKzSKO9k8fidHhTsA@mail.gmail.com>
 <7aa7af7f-7d27-02bf-bfa8-3551d5551d61@gmail.com> <20230606142907.456eec7e@kernel.org>
 <CAJs+hrEO6nqRHPj4kUWRm3UsBiSOU128a4pLEp8p4pokP7MmEg@mail.gmail.com> <5caf123b-f626-fb68-476a-5b5cf9a7f31d@gmail.com>
In-Reply-To: <5caf123b-f626-fb68-476a-5b5cf9a7f31d@gmail.com>
From: Patrick Thompson <ptf@google.com>
Date: Fri, 1 Sep 2023 10:20:08 -0400
Message-ID: <CAJs+hrGmHF4EHsYGVPCosSNOE075CzTsP1d9hppMNXAB1n=JAw@mail.gmail.com>
Subject: Re: [PATCH] r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, nic_swsd@realtek.com, 
	Chun-Hao Lin <hau@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Okay sounds good. By the way, here's the patch where the VER_35 logic
was added. So one question would be are there more chips without
multicast hardware filters?
------------------

From: Nathan Walp <faceprint@xxxxxxxxxxxxx>

commit 0481776b7a70f09acf7d9d97c288c3a8403fbfe4 upstream.

RTL_GIGA_MAC_VER_35 includes no multicast hardware filter.

Signed-off-by: Nathan Walp <faceprint@xxxxxxxxxxxxx>
Suggested-by: Hayes Wang <hayeswang@xxxxxxxxxxx>
Acked-by: Francois Romieu <romieu@xxxxxxxxxxxxx>
Signed-off-by: David S. Miller <davem@xxxxxxxxxxxxx>
Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski@xxxxxxxxxxxxx>
---
drivers/net/ethernet/realtek/r8169.c | 3 +++
1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.c
b/drivers/net/ethernet/realtek/r8169.c
index eb81da4..e19e1f1 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4271,6 +4271,9 @@ static void rtl_set_rx_mode(struct net_device *dev)
mc_filter[1] =3D swab32(data);
}

+ if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35)
+ mc_filter[1] =3D mc_filter[0] =3D 0xffffffff;
+
RTL_W32(MAR0 + 4, mc_filter[1]);
RTL_W32(MAR0 + 0, mc_filter[0]);

--
1.7.9.5

--

On Fri, Sep 1, 2023 at 8:48=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.co=
m> wrote:
>
> On 01.09.2023 14:28, Patrick Thompson wrote:
> > Hello,
> >
> > I was wondering if this should be extended to all RTL_GIGA_MAC_VERs
> > greater than 35 as well.
> >
> I *think* the mc filtering issue with version 35 is different from the
> one you're seeing. So not every chip version may be affected.
> As there's no public errata information let's wait for a statement
> from Realtek.
>
> > Realtek responded to me but I was slow to get them packet captures
> > that they needed. I am hoping to restart things and get back to this
> > over the finish line if it's a valid patch.
> >
> > I will add the appropriate tags and annotations once I hear back.
> >
> > On Tue, Jun 6, 2023 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >>
> >> On Tue, 6 Jun 2023 17:11:27 +0200 Heiner Kallweit wrote:
> >>> Thanks for the report and the patch. I just asked a contact in Realte=
k
> >>> whether more chip versions may be affected. Then the patch should be
> >>> extended accordingly. Let's wait few days for a response.
> >>>
> >>> I think we should make this a fix. Add the following as Fixes tag
> >>> and annotate the patch as "net" (see netdev FAQ).
> >>>
> >>> 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> >>
> >> Perhaps it's best if you repost with the Fixes tag included once
> >> Realtek responded.
>

