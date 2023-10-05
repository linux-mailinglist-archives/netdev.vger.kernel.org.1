Return-Path: <netdev+bounces-38310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D547BA4A4
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 99DAD1C2090A
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111A341BD;
	Thu,  5 Oct 2023 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sIFf5Zh2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA96339BD
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:10:08 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E9CDB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:10:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso12327a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696522200; x=1697127000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRCO/tDP4lRLu2OPV/gEOu9clmIfNVaCcbX9ayRgMZQ=;
        b=sIFf5Zh2sZHqRywywGBF8so85oAW0i5GI0cfRWdSUM8jDcIuCvvr/mdR2e96GGLdfV
         Gq13bsMyuJsLjtXcYKN1HBsa5ehu+CPd/k5pv9KgHTZrdmCJrA9SjsvkYp5XjmfvQ4im
         12eztqV2Pz56UGyn/8wKmIPKtvh2SKa7FLlU+18dtVgdKlbrTrs/3E1PybeQdrvC0nVc
         oGVK1HjcgbBKi2lEbQq2QHHfSB45JcGS7qGwTh32GVgkI+TsiQfEEKyczPIOes6YgeZ3
         J5DVSgGwxfLVdZl4nP+XOYx2Ho1RU+q95bPKdLh/LqpGgHA5wW67Ym+6Oi9AC84wXiH9
         M8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522200; x=1697127000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRCO/tDP4lRLu2OPV/gEOu9clmIfNVaCcbX9ayRgMZQ=;
        b=oS/XMB4TEwJxLkcWuo4Bx4KfhMc3lDSvdGCFH4UOgmSJqmoN4AceQ85Du6pZHF3DRs
         ZHZJNF3mM9LduO/mhCJPjietKD/wMBHmVF3d73/pvDtQdV5z/+KajNJeytwE8VEJCtCS
         1OAwRe2gOKu1WaNlamPafsbQUgut3UaLajFLRpyjSsohAQ7+lBGsQW1My5xH2MFFwgmT
         11fu2jCpW8VnMWEdv9oOLtVMcjLgjFoc4Sucf3nBTLjTjAtUNrjcIUNb8w8FOHLep2x1
         m+tn1//xTNKRPek9Dbl3mmJblPTpiZox0JTVGry7e52CgpbSYhsNJoEQ28MZJOhVolg/
         wlxw==
X-Gm-Message-State: AOJu0Yy2M5WSV21o2gWmw590u46VSvXAEuX5f9/tgi7dOFJPm1hpmMgv
	Rs/w58nfXhpTU+WH2Lys/D5JqtcVTb4YjdXbTi/vgQ==
X-Google-Smtp-Source: AGHT+IFzYlK6nOXqFn3XTRyZ9yDEZC9Bs5FeKRJ0Zfr3978r7XwjxquujorP05hjLrjSFu1gUI2ea386eAkHyH3Ha+s=
X-Received: by 2002:a50:8d0f:0:b0:538:50e4:5446 with SMTP id
 s15-20020a508d0f000000b0053850e45446mr71813eds.5.1696522199600; Thu, 05 Oct
 2023 09:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003145150.2498-1-ansuelsmth@gmail.com>
In-Reply-To: <20231003145150.2498-1-ansuelsmth@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Oct 2023 18:09:42 +0200
Message-ID: <CANn89iK5E=SFJoNNTd3SNdT0oPR503dEf_gNfP=Ls3AKS_4F_g@mail.gmail.com>
Subject: Re: [net-next PATCH v2 1/4] netdev: replace simple
 napi_schedule_prep/__napi_schedule to napi_schedule
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 8:36=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> Replace drivers that still use napi_schedule_prep/__napi_schedule
> with napi_schedule helper as it does the same exact check and call.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

