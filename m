Return-Path: <netdev+bounces-38311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFAE7BA4DF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 23E301C2088B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC834CC2;
	Thu,  5 Oct 2023 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o681KbIh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240E30F93
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:12:11 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8924234
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:12:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405459d9a96so99565e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696522328; x=1697127128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r0z6lg6WCpdjTrIkK0dVsLYyVCZ/7MdG8Aqn4UL8Rc=;
        b=o681KbIh2TlLlhg8XG13gpUMzwdOWGu93tlv1/AmAQmTSR1pYFOLQ39scqoBCGGlhi
         4twWQG1uOshmLs2xF5w3/nPDQegq0pHr0IWitMDfaFoK/bDa9m+nCYE67EVozR0MX0+X
         EyGpMb4MPF9fy3rf61gcJROjNqNa6HcEqJuxmhB+ki0io7BHtCw0U0i/lw4kIKZpWQfR
         6Kjip00dYddoVNJ958TrIuB6gJsLypWAVPUE31LC1LfuJ6rivEEgPkbYFRhuBmoZQOui
         QtqcpUzWEIo2mO1rI7Z0w5A7W0peQitW15tx4IKCl23o7rV+GX/ihXN7g61y1pw7elN7
         oC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522328; x=1697127128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r0z6lg6WCpdjTrIkK0dVsLYyVCZ/7MdG8Aqn4UL8Rc=;
        b=cfEzgaSzYd4uzgVc8xgtkZl4e0kWuV9nojOWZAi7S6ZlsfyGrReLDcNgpm5cp5nYC4
         k3sg98NQEOIxfdRjNgShJGojo85Gr+FoByJG34vZjuzMT9P2QIojMsTlYKkCCufWfVKO
         dHv5LVdomSrsoWK3EI6TF2GjPoN34TTe+Q10nRP5ETRyBww86ICk2DJphdCo/1+iJP8t
         qzsrJlm0ZeutjgASkl101Ow3bkviOvrIQqAzVA7CT+I0HZahUK8mwZqawDXJr4ddnSsa
         EoBygFpYW1OJOHYxu0XuLLAdqf8j2wXOfbIdxUPCO/z/EWqd91T8SWHEIHC3rAPKMmrm
         SzQQ==
X-Gm-Message-State: AOJu0YzIdc2D5wORgFFvbh6eQYkfJrLy8AJZQxwq12spvI5i9Z++66R1
	Srt8SGBNDkGpH6rUoOj+Qqu6s2l0Mqy9Dx52MZlMSw==
X-Google-Smtp-Source: AGHT+IHsG9cALy9l/AGtf9WGqoTk1+vFPuwod1G0A2HPE9T+W6tIBWkayyF2LSEa5O28SfRy9xIMPv/xnERf3BuOFTY=
X-Received: by 2002:a05:600c:b93:b0:3fe:eb42:7ec with SMTP id
 fl19-20020a05600c0b9300b003feeb4207ecmr61696wmb.1.1696522327966; Thu, 05 Oct
 2023 09:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003145150.2498-1-ansuelsmth@gmail.com> <20231003145150.2498-3-ansuelsmth@gmail.com>
In-Reply-To: <20231003145150.2498-3-ansuelsmth@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Oct 2023 18:11:56 +0200
Message-ID: <CANn89iK226C-pHUJm7HKMyEtMycGC=KCA2M6kw2KJaUj0cCT6w@mail.gmail.com>
Subject: Re: [net-next PATCH v2 3/4] netdev: replace napi_reschedule with napi_schedule
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 8:36=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> Now that napi_schedule return a bool, we can drop napi_reschedule that
> does the same exact function. The function comes from a very old commit
> bfe13f54f502 ("ibm_emac: Convert to use napi_struct independent of struct
> net_device") and the purpose is actually deprecated in favour of
> different logic.
>
> Convert every user of napi_reschedule to napi_schedule.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com> # ath10k
> Acked-by: Nick Child <nnac123@linux.ibm.com> # ibm
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for can/dev/rx-offload=
.c

OK, but I suspect some users of napi_reschedule() might not be race-free...

Reviewed-by: Eric Dumazet <edumazet@google.com>

