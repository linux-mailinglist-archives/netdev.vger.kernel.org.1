Return-Path: <netdev+bounces-20786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E05760FB3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BBF28179E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5615AC2;
	Tue, 25 Jul 2023 09:49:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6AC156DD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:49:37 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6071A3;
	Tue, 25 Jul 2023 02:49:36 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-584034c706dso18390047b3.1;
        Tue, 25 Jul 2023 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690278575; x=1690883375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezMBKSK/EY8q/B0BuW7EtqZYoTEy/3+qIvsVYAaeTBQ=;
        b=j6VXGaqA0F4Fa6HNSZLPfiCJa6rEMFKltoI6vTRR03OCVcC6wHuvS9h8v86ZA6QmbQ
         Q1ZBrX8m7zaH6QdKwilVQ9BsMh1G5tzrcOem+7INO+5yShXRgO2EDoiV6/CGMyyu8UOk
         JJLJ/g75ILbuzXlf0Aws4WXbmqbyrLWBIl60aBsjctBkPR4BgmRIHZdvnxf8gijYE3KJ
         CTwf+ww/3KRH8Q91EDS6xLZLSLXOhuRAU05/b6ciHIpeiXrkXfV4CC7LwfOkJpNLrXnJ
         GMPOA9+SdYr+wkXK/FzUtKzmWDPMA/N80/L14FKIcwrOc418+yqfrsMkDws7j4D4yWzw
         GGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690278575; x=1690883375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezMBKSK/EY8q/B0BuW7EtqZYoTEy/3+qIvsVYAaeTBQ=;
        b=EPr4TIQzc9lKZaJL7o14YZsW5Vj6PMfgUn4vckMbu/SHV/Re8MHhS4CqRc7DVPI0Wh
         vJGpLSYHaT+DiiyMzarb/0X9dYcvaAZ+f6obDtK4KTGyrRiBqVh/x+zzXvb1mpDeBdB/
         PBy6Wp7sMndiW1B5CCXK1xGjzaPTXpoEZ5YadMHXT1wb8ruamqZRgXHDyqY07pT2OqVE
         F4m60XEXBgHFM7tx7j6CuolEb80tqZm9XjkZakxXH+xJLCpj1KaQ4GqYZH3YxC736ohI
         opQEG++VozBkeakj0BwgBjq52RgYFMh1cmFdI1yRGRyc9qdNoiQ6XIDpvfgLAaZm4PJE
         dWVg==
X-Gm-Message-State: ABy/qLaRd1mr9IDcV4miOjdJ2D7lFZveYya1wBi7UOGtMvzAuUIClPck
	WyvGehPIxzFjSiarbMVqW/82Zx0GYkq0pD4wPCY=
X-Google-Smtp-Source: APBJJlHj+YPKQhiGEt+VZIscIcX/9DaXO8sAZWgsBI1XpI2Q2UbV2V1sZUdiOVu/hBXyCaX2d+YejJyjbrIpMTicMMI=
X-Received: by 2002:a81:4e82:0:b0:583:52ca:4f23 with SMTP id
 c124-20020a814e82000000b0058352ca4f23mr9003998ywb.0.1690278575264; Tue, 25
 Jul 2023 02:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1689703232-24858-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20230719070826.GF8808@unreal>
In-Reply-To: <20230719070826.GF8808@unreal>
From: Souradeep Chakrabarti <souradch.linux@gmail.com>
Date: Tue, 25 Jul 2023 15:19:24 +0530
Message-ID: <CABNGXZr+rM7B-inQayHuQAYv17DP3mEKgcXCPHr30BO6xzzaxw@mail.gmail.com>
Subject: Re: [PATCH V4 net-next] net: mana: Configure hwc timeout from hardware
To: Leon Romanovsky <leon@kernel.org>
Cc: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	longli@microsoft.com, sharmaajay@microsoft.com, cai.huoqing@linux.dev, 
	ssengar@linux.microsoft.com, vkuznets@redhat.com, tglx@linutronix.de, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	schakrabarti@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 12:43=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Tue, Jul 18, 2023 at 11:00:32AM -0700, Souradeep Chakrabarti wrote:
> > At present hwc timeout value is a fixed value. This patch sets the hwc
> > timeout from the hardware. It now uses a new hardware capability
> > GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG to query and set the value
> > in hwc_timeout.
> >
> > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > ---
> > V3 -> V4:
> > * Changing branch to net-next.
> > * Changed the commit message to 75 chars per line.
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 30 ++++++++++++++++++-
> >  .../net/ethernet/microsoft/mana/hw_channel.c  | 25 +++++++++++++++-
> >  include/net/mana/gdma.h                       | 20 ++++++++++++-
> >  include/net/mana/hw_channel.h                 |  5 ++++
> >  4 files changed, 77 insertions(+), 3 deletions(-)
>
> <...>
>
> >       gc->hwc.driver_data =3D NULL;
> >       gc->hwc.gdma_context =3D NULL;
> > @@ -818,6 +839,7 @@ int mana_hwc_send_request(struct hw_channel_context=
 *hwc, u32 req_len,
> >               dest_vrq =3D hwc->pf_dest_vrq_id;
> >               dest_vrcq =3D hwc->pf_dest_vrcq_id;
> >       }
> > +     dev_err(hwc->dev, "HWC: timeout %u ms\n", hwc->hwc_timeout);
>
> Why do you print this message every time and with error level?
> Probably you should delete it.
>
In V5 I have changed it to dev_dbg from dev_err.
> Thanks

