Return-Path: <netdev+bounces-38873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD367BCCD4
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 09:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BDF281743
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1561747B;
	Sun,  8 Oct 2023 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BShKJaRt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0246B8
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 07:00:47 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF2DDE
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 00:00:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so5432a12.1
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 00:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696748442; x=1697353242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH8rgsD0Hcv//mdO9CGjCjg749l4skH04u5NpNfXSJo=;
        b=BShKJaRtusNijZZ57Kaaydm5cxCfHocp+nOGciKvqb++6Z9nyuOD/uC/kwsqizh687
         mFCJJDc0urQQh8PUEZpRDB/57VWp8QQL0APQ1smHc1IlmJKuQB/El5qROWmyM0VacBco
         0A9gWDEdTwWZUHz6i8escGbPUk+91X8GZVCK4ScPcGUG7Z5Hvknlv82uujz3OWIz09xc
         zuxWkk0Rgyg0O67zeZyl1tZBwYl653Ub4NuaRjZptmkgBr/R3t3EIsSz82C3x0SZm5j7
         I2qJPEGGMPOdJtEZnHrvaxoj7eYt8xYe/WVxl0ptpTU3+tNzNcTzagg0FQubKas09fM9
         WWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696748442; x=1697353242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH8rgsD0Hcv//mdO9CGjCjg749l4skH04u5NpNfXSJo=;
        b=I/WUO5gDj356tkny/m66TQd4H3Jas1ihS6NfQqtClnFp30bfPd+WbKgxd0p8T+VOmk
         x9002Y7blTWXMEesGyximPkyyWMQGHOPVCX5/WmHRoTHWYWcxaxNQ2XQzuevSnpgTBdg
         Ui9R3k2zPfTNuIGKqsM/BSAY0r6EhyXgYd6qwY5PE3+aJryaVWO0W2l7W14tnyRJVaN5
         caBHrwb2eIBiCq6TSR3SvgbrFCejsJHLwbgupsO30RqHmvJL5h1ZZ+6vwsrIqvzUJV6q
         QF4S+E4TffG/9smwW/WU1JJNMzByJ2+PhV6u1EmlybadiAoebF+XB3UfoP4bn5j1yOn5
         o78A==
X-Gm-Message-State: AOJu0Yx7168I0uLl2RWeTulQ/PPrksEj+tDexkyJJwCPEyZ6qqGfx3yW
	kWUB3tsmFHzb7dWmGqxNx4JwxUKGlPyIETYfLiQlvQ==
X-Google-Smtp-Source: AGHT+IEsm3Yaeezo31ko5A6vpc3J66AXEC7Qr6Rm72BDJiSgp93BqqzS34935wa+NNU03Xl/ZB6KCTMLkH8SD9/RjuM=
X-Received: by 2002:a50:9fa4:0:b0:538:5f9e:f0fc with SMTP id
 c33-20020a509fa4000000b005385f9ef0fcmr307070edf.0.1696748442128; Sun, 08 Oct
 2023 00:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003145150.2498-1-ansuelsmth@gmail.com> <20231003145150.2498-3-ansuelsmth@gmail.com>
 <CANn89iK226C-pHUJm7HKMyEtMycGC=KCA2M6kw2KJaUj0cCT6w@mail.gmail.com>
 <20231005093253.2e25533a@kernel.org> <CANn89iJQ50AdXP2C1YB2pGjE02WCJ-QCsZqE1yGXtcGsfLA0Jw@mail.gmail.com>
 <65205789.5d0a0220.7e49b.ccb0@mx.google.com>
In-Reply-To: <65205789.5d0a0220.7e49b.ccb0@mx.google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 8 Oct 2023 09:00:29 +0200
Message-ID: <CANn89i+ntByi2709y10PN6cgri-b0EWxPSNXdu_Nf2nOvJ45FQ@mail.gmail.com>
Subject: Re: [net-next PATCH v2 3/4] netdev: replace napi_reschedule with napi_schedule
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Chris Snook <chris.snook@gmail.com>, Raju Rangoju <rajur@chelsio.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Douglas Miller <dougmill@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Nick Child <nnac123@linux.ibm.com>, 
	Haren Myneni <haren@linux.ibm.com>, Rick Lindsley <ricklind@linux.ibm.com>, 
	Dany Madden <danymadden@us.ibm.com>, Thomas Falcon <tlfalcon@linux.ibm.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Krzysztof Halasa <khalasa@piap.pl>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Gregory Greenman <gregory.greenman@intel.com>, 
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Intel Corporation <linuxwwan@intel.com>, 
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>, Liu Haijun <haijun.liu@mediatek.com>, 
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>, 
	Ricardo Martinez <ricardo.martinez@linux.intel.com>, Loic Poulain <loic.poulain@linaro.org>, 
	Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Yuanjun Gong <ruc_gongyuanjun@163.com>, Simon Horman <horms@kernel.org>, 
	Rob Herring <robh@kernel.org>, Ziwei Xiao <ziweixiao@google.com>, 
	Rushil Gupta <rushilg@google.com>, Coco Li <lixiaoyan@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Junfeng Guo <junfeng.guo@intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Wei Fang <wei.fang@nxp.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Yuri Karpov <YKarpov@ispras.ru>, Zhengchao Shao <shaozhengchao@huawei.com>, 
	Andrew Lunn <andrew@lunn.ch>, Zheng Zengkai <zhengzengkai@huawei.com>, Lee Jones <lee@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dawei Li <set_pte_at@outlook.com>, Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL,WEIRD_QUOTING
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 8:52=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> On Thu, Oct 05, 2023 at 06:41:03PM +0200, Eric Dumazet wrote:
> > On Thu, Oct 5, 2023 at 6:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Thu, 5 Oct 2023 18:11:56 +0200 Eric Dumazet wrote:
> > > > OK, but I suspect some users of napi_reschedule() might not be race=
-free...
> > >
> > > What's the race you're thinking of?
> >
> > This sort of thing... the race is in fl_starving() though...
> >
> > diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c
> > b/drivers/net/ethernet/chelsio/cxgb4/sge.c
> > index 98dd78551d89..b5ff2e1a9975 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
> > +++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
> > @@ -4261,7 +4261,7 @@ static void sge_rx_timer_cb(struct timer_list *t)
> >
> >                         if (fl_starving(adap, fl)) {
> >                                 rxq =3D container_of(fl, struct sge_eth=
_rxq, fl);
> > -                               if (napi_reschedule(&rxq->rspq.napi))
> > +                               if (napi_schedule(&rxq->rspq.napi))
> >                                         fl->starving++;
> >                                 else
> >                                         set_bit(id, s->starving_fl);
>
> Ehhh problem is that this is a simple rename so if any race is present,
> it's already there and not caused by this rename :(
>
> Don't know maybe this is out of scope and should be investigated with a
> bug report?
>
> Maybe this should be changed to prep/__schedule to prevent any kind of
> race? But doing so doesn't prevent any kind of ""starving""?
>

I gave a "Reviewed-by: Eric Dumazet <edumazet@google.com>", meaning
your patch was ok for me.

My remark was orthogonal, I am not asking you to act on it ;)

