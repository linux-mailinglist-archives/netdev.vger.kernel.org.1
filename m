Return-Path: <netdev+bounces-37532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0947B5D13
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 00:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 59317B20816
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C6208AD;
	Mon,  2 Oct 2023 22:21:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240B1F18C
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 22:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC12C433C8;
	Mon,  2 Oct 2023 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696285314;
	bh=CGV3l4m1Fsxjo5KVleucQ9ACIj7qp3IjWnhkCyY4rZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YPx5MEwF/HCg5A6rfAedz2iYizSQOXr/9gtMzV+E2dlwiqJvuiHqVp6YRtAwC9ZlS
	 iOAwE9rZIHCPbdG0ZKTqccGsZvdmJOo/00bYzDZF8QdQBQe94QFgEyvtBE9hUE1ZhX
	 FPhADmeOCjSVgRUmxviHjBL7ROHTUtdiWaeb4uQfNFQMva2lL3M61UoF3ATuxEMgMo
	 Uj/iFCrNIKmeNh9SROF1KxJx/VsHoXbgWm43eAwiShXr57QIf5n+H60C5Q59nRGkQM
	 Fnuq18MhzNA8vdaj3zP3dQsTNCYa/h7xuzPe+Ktf6dcjXsvZ3NikpBFsjOaB3zpmQy
	 FO3A4oVVbVVRw==
Date: Mon, 2 Oct 2023 15:21:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Chris Snook
 <chris.snook@gmail.com>, Raju Rangoju <rajur@chelsio.com>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Douglas Miller
 <dougmill@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Haren Myneni
 <haren@linux.ibm.com>, Rick Lindsley <ricklind@linux.ibm.com>, Dany Madden
 <danymadden@us.ibm.com>, Thomas Falcon <tlfalcon@linux.ibm.com>, Tariq
 Toukan <tariqt@nvidia.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Gregory Greenman <gregory.greenman@intel.com>, Chandrashekar Devegowda
 <chandrashekar.devegowda@intel.com>, Intel Corporation
 <linuxwwan@intel.com>, Chiranjeevi Rapolu
 <chiranjeevi.rapolu@linux.intel.com>, Liu Haijun <haijun.liu@mediatek.com>,
 M Chetan Kumar <m.chetan.kumar@linux.intel.com>, Ricardo Martinez
 <ricardo.martinez@linux.intel.com>, Loic Poulain <loic.poulain@linaro.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, Yuanjun Gong <ruc_gongyuanjun@163.com>, Wei
 Fang <wei.fang@nxp.com>, Alex Elder <elder@linaro.org>, Simon Horman
 <horms@kernel.org>, Rob Herring <robh@kernel.org>, Bailey Forrest
 <bcf@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Junfeng
 Guo <junfeng.guo@intel.com>, Ziwei Xiao <ziweixiao@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rushil Gupta <rushilg@google.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Yuri
 Karpov <YKarpov@ispras.ru>, Zhengchao Shao <shaozhengchao@huawei.com>,
 Andrew Lunn <andrew@lunn.ch>, Zheng Zengkai <zhengzengkai@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lee Jones
 <lee@kernel.org>, Dawei Li <set_pte_at@outlook.com>, Hans de Goede
 <hdegoede@redhat.com>, Benjamin Berg <benjamin.berg@intel.com>, Anjaneyulu
 <pagadala.yesu.anjaneyulu@intel.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH 1/4] netdev: replace simple
 napi_schedule_prep/__napi_schedule to napi_schedule
Message-ID: <20231002152142.4e8e2cfb@kernel.org>
In-Reply-To: <20231002151023.4054-1-ansuelsmth@gmail.com>
References: <20231002151023.4054-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Oct 2023 17:10:20 +0200 Christian Marangi wrote:
>  			queue_work(priv->xfer_wq, &priv->rx_work);
> -		else if (napi_schedule_prep(&priv->napi))
> -			__napi_schedule(&priv->napi);
> +		else
> +			napi_schedule(&priv->napi)

Missing semi-colon, please make sure each patch builds cleanly 
with allmodconfig.
-- 
pw-bot: cr

