Return-Path: <netdev+bounces-38317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CAC7BA63A
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7C3EB28194C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DF7273EE;
	Thu,  5 Oct 2023 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no9ws3a7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA1266D5
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6E2C433C7;
	Thu,  5 Oct 2023 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696523576;
	bh=DwGgZF4pD8dMdjurYEUQSJd03FIsbJFkpL4uiIiTuZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=no9ws3a7X4UxOs3t1ZnClQiQoxdBhGZlGNfhrbp5JYwIpj/luaWE1/qY2mSml/Kfv
	 zKudrb4eO3/FEIzOZYMQJKll4e2+nISBj2e5Rvu5vuQs/ZUa8I1Zn5+VpnT9OcLx2W
	 fvuvLuyWkgJ83aCEIvKvuGL1eIVFeTN24MUbRgt45QNq7GpmY3n38lq0MOtmUlI8QQ
	 iWoap0bfmYLCa2VFhE0e48qsh+nGdajFa+QB6GMzZwbrY6JBAYCgo9AWa3hcqOkaJQ
	 Qt19l3uNvUWIvQuiq1darSKlP0coe5ZIZFZXLNlx2kT97+BBmOlMO823CbI3XoIvg3
	 SR+zm46cxSuGQ==
Date: Thu, 5 Oct 2023 09:32:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Wolfgang Grandegger
 <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Chris Snook
 <chris.snook@gmail.com>, Raju Rangoju <rajur@chelsio.com>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Douglas Miller
 <dougmill@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nick Child <nnac123@linux.ibm.com>, Haren Myneni <haren@linux.ibm.com>,
 Rick Lindsley <ricklind@linux.ibm.com>, Dany Madden
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
 <johannes@sipsolutions.net>, Yuanjun Gong <ruc_gongyuanjun@163.com>, Simon
 Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>, Ziwei Xiao
 <ziweixiao@google.com>, Rushil Gupta <rushilg@google.com>, Coco Li
 <lixiaoyan@google.com>, Thomas Gleixner <tglx@linutronix.de>, Junfeng Guo
 <junfeng.guo@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Wei Fang <wei.fang@nxp.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Yuri Karpov
 <YKarpov@ispras.ru>, Zhengchao Shao <shaozhengchao@huawei.com>, Andrew Lunn
 <andrew@lunn.ch>, Zheng Zengkai <zhengzengkai@huawei.com>, Lee Jones
 <lee@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Dawei Li <set_pte_at@outlook.com>,
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/4] netdev: replace napi_reschedule with
 napi_schedule
Message-ID: <20231005093253.2e25533a@kernel.org>
In-Reply-To: <CANn89iK226C-pHUJm7HKMyEtMycGC=KCA2M6kw2KJaUj0cCT6w@mail.gmail.com>
References: <20231003145150.2498-1-ansuelsmth@gmail.com>
	<20231003145150.2498-3-ansuelsmth@gmail.com>
	<CANn89iK226C-pHUJm7HKMyEtMycGC=KCA2M6kw2KJaUj0cCT6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 18:11:56 +0200 Eric Dumazet wrote:
> OK, but I suspect some users of napi_reschedule() might not be race-free...

What's the race you're thinking of?

