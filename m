Return-Path: <netdev+bounces-37565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885727B6054
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 07:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9EEC31C20844
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 05:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32D15D5;
	Tue,  3 Oct 2023 05:22:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204801391
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 05:22:01 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ECFB4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 22:21:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso8163a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 22:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696310518; x=1696915318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqpR6B8+nR6pcymfGZfMhsWiKXO7OC+lMbowiW4LVxc=;
        b=UaBLzEzVytEjZbXxfZJ/yKqhK1RZp492+FSmCuOa7ivIYhUjuF8hhU9LAqmzdU4w6t
         ul2WUkeUtwkfafuUvtV5ho6mCBWCD1BhiuFT3QHzF9AgAZincFasUEejf8VNCz3bzWlf
         GcEipmR4Vx/LRl/d6L2tGAtJhsSmlAtgXdQ+lecGw4omrkwjLD213+u2cjhh74VBEOOo
         QIO1M7y3isPpmNsFx+OBLYxufeYEl8tgPqr0eoUNHY5EkFk9sRSqyWRRUootS4hdLrMg
         dMK2ipfmJzdEbgC5gFllURR7gNvSbIldfQxtXeVgoX8FZYliPEHedY71EL84X+SlgOTP
         vjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696310518; x=1696915318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqpR6B8+nR6pcymfGZfMhsWiKXO7OC+lMbowiW4LVxc=;
        b=IyXiw2qFe7fZnTe+buORmTT4t9BThDMNNIr6Qzj9YY+2PjFrEV2xfrpoSIlUPplpMn
         1FtVSmXdrVWgC9GWu0R36dqdcWYBhtivJmaqPjw7d78/DSrqnvzhHvVijJQDuhtw3ZHG
         pM3B06UP+/bEEVtCkGHjSnx1KeZgkj4Q0JT34qHbNEUFQ5qNtdqoIuXiDVchxQ5J7ppU
         rJTEpvXl5Fvao6tBSwWcD3xiv61Znb5BAx5JrpCWoFTXwtw1C7lqd8PDq63B0QENqOcz
         vejjjuI/1LrTcVLryUip5qWro+0HsljadoVjXN9nsjSMHON1PbHKLgDX1g/S7bVFpcF8
         byCg==
X-Gm-Message-State: AOJu0YwnnCRmIoz1xGnw1HLIy/hQc9xkaE8b/R8GnQpMi1SMeUXFHaIE
	3byeOX4A9Pq5iMaDkoOFFnr3LE3d+olbhRUXNyZJeQ==
X-Google-Smtp-Source: AGHT+IFKI0HKrYVLDl5vmsJpfAS1RFLGp2hw35YvLJzj9lzKha+Fza93n9nqgIQgLugkI+eoDblKihBS9oaXtRjP+8s=
X-Received: by 2002:a50:d4d7:0:b0:538:1d3b:172f with SMTP id
 e23-20020a50d4d7000000b005381d3b172fmr49263edj.3.1696310517644; Mon, 02 Oct
 2023 22:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002151023.4054-1-ansuelsmth@gmail.com> <20231002151023.4054-2-ansuelsmth@gmail.com>
In-Reply-To: <20231002151023.4054-2-ansuelsmth@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Oct 2023 07:21:46 +0200
Message-ID: <CANn89i+eSWYuE=wE1TPJFtAS1OCfFYytC_nAjDWkizxmR9e6JQ@mail.gmail.com>
Subject: Re: [net-next PATCH 2/4] netdev: make napi_schedule return bool on
 NAPI successful schedule
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chris Snook <chris.snook@gmail.com>, Raju Rangoju <rajur@chelsio.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Douglas Miller <dougmill@linux.ibm.com>, 
	Nick Child <nnac123@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
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
	Yuanjun Gong <ruc_gongyuanjun@163.com>, Wei Fang <wei.fang@nxp.com>, 
	Alex Elder <elder@linaro.org>, Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bailey Forrest <bcf@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Junfeng Guo <junfeng.guo@intel.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rushil Gupta <rushilg@google.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Yuri Karpov <YKarpov@ispras.ru>, Zhengchao Shao <shaozhengchao@huawei.com>, 
	Andrew Lunn <andrew@lunn.ch>, Zheng Zengkai <zhengzengkai@huawei.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lee Jones <lee@kernel.org>, 
	Dawei Li <set_pte_at@outlook.com>, Hans de Goede <hdegoede@redhat.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
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

On Mon, Oct 2, 2023 at 5:10=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> Change napi_schedule to return a bool on NAPI successful schedule. This
> might be useful for some driver to do additional step after a NAPI ahs

This might be useful for some drivers to do additional steps after a
NAPI has been scheduled.

> been scheduled.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Yeah, I guess you forgot to mention I suggested this patch ...

Reviewed-by: Eric Dumazet <edumazet@google.com>

