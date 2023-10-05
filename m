Return-Path: <netdev+bounces-38331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4057BA6B3
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CD7B1281B3E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6081D36B1E;
	Thu,  5 Oct 2023 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+9rGAz/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC20358A7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:41:18 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3181700
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:41:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405459d9a96so1835e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696524075; x=1697128875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKTDRIoUmCSN9wKAZkd+bxIJEDblkCbUKypHY3ps4Iw=;
        b=Q+9rGAz/E7g9ybkcIAMcFbKwvoF1EZUZRfBom65Nza9mTZxv5FdEt5FcqQNQF4BW3Q
         6rUFyD4mxY75T+3bGjsgQYrrEBDxwaWrhNrtrwWIweqXkPyzy2PqaqDxs0dREmRn5Tzr
         YNyLMfb8A8zAGs9Yg7BF5MmvP0QI6wJACnWAejFGjNFYBl8w3lkkjY4i+AA4Mxas3Dj+
         ooHh7ByEuqTi7CdLSa3a0V/FuVsVaQ2uPyA+TdPD7ILsl3k2SZJMQpQT+KqTY+9EetUm
         dgTEPMriDfHV42y+ZQBfdJpC263VP4M/pnNHLYwAFzsRL5Q9H6j99SQVa2AUSVR6UW9A
         hGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696524075; x=1697128875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKTDRIoUmCSN9wKAZkd+bxIJEDblkCbUKypHY3ps4Iw=;
        b=tl6tqqEle4TKkNI7r0Ewzt2QUC1nQHP2o8CqMhWUWv4nsUugVhC3Q6na0LQJSXU/CK
         oL25nvc6LiQ0ko8sD4d68cph54Jjmf1+mm9lKiWSYxDUEjsTUNv0ld7v47Uji/kxaam2
         yHP3w6WID4u7jl96uvTIHlv5j8err9vakgsR4QFk0XKNKRiIwHXhYsUJ3dfEuBkS2nWv
         1P0ofDjIxjo0L1pNLn7M0oifNPi2VmJQeC5bdowBTxQCl6SFQdLLo6r84l0aFAkSkPyF
         ND1i370TR9LbRfWyKLK7a0EiaeVxQfvGPU2KqmBNvwSTsp8nAjLcqTaVhXCqT/6s1WQM
         2idA==
X-Gm-Message-State: AOJu0YyYwLzGmVJkP5ZBAPfYly4861xAeAqg4NJzqPfYv0PKXrHzr+jy
	MqNJfCieC860OIic4ID9v3Huf/ckzTqJ5n7gi4P1jg==
X-Google-Smtp-Source: AGHT+IHCYz0blMBWwpdJoZ1RUCKFkOGFeBm9VdaHikhjZLlf2r3eA9UAmptIepXMQVxXyXzuuEUlEkvL8t18CpmL0rk=
X-Received: by 2002:a05:600c:2301:b0:405:38d1:e146 with SMTP id
 1-20020a05600c230100b0040538d1e146mr66369wmo.4.1696524074654; Thu, 05 Oct
 2023 09:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003145150.2498-1-ansuelsmth@gmail.com> <20231003145150.2498-3-ansuelsmth@gmail.com>
 <CANn89iK226C-pHUJm7HKMyEtMycGC=KCA2M6kw2KJaUj0cCT6w@mail.gmail.com> <20231005093253.2e25533a@kernel.org>
In-Reply-To: <20231005093253.2e25533a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Oct 2023 18:41:03 +0200
Message-ID: <CANn89iJQ50AdXP2C1YB2pGjE02WCJ-QCsZqE1yGXtcGsfLA0Jw@mail.gmail.com>
Subject: Re: [net-next PATCH v2 3/4] netdev: replace napi_reschedule with napi_schedule
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Chris Snook <chris.snook@gmail.com>, 
	Raju Rangoju <rajur@chelsio.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Douglas Miller <dougmill@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Nick Child <nnac123@linux.ibm.com>, Haren Myneni <haren@linux.ibm.com>, 
	Rick Lindsley <ricklind@linux.ibm.com>, Dany Madden <danymadden@us.ibm.com>, 
	Thomas Falcon <tlfalcon@linux.ibm.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Gregory Greenman <gregory.greenman@intel.com>, 
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 6:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 5 Oct 2023 18:11:56 +0200 Eric Dumazet wrote:
> > OK, but I suspect some users of napi_reschedule() might not be race-fre=
e...
>
> What's the race you're thinking of?

This sort of thing... the race is in fl_starving() though...

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c
b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 98dd78551d89..b5ff2e1a9975 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -4261,7 +4261,7 @@ static void sge_rx_timer_cb(struct timer_list *t)

                        if (fl_starving(adap, fl)) {
                                rxq =3D container_of(fl, struct sge_eth_rxq=
, fl);
-                               if (napi_reschedule(&rxq->rspq.napi))
+                               if (napi_schedule(&rxq->rspq.napi))
                                        fl->starving++;
                                else
                                        set_bit(id, s->starving_fl);

