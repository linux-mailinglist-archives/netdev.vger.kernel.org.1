Return-Path: <netdev+bounces-27620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E977C917
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF042811DF
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EA1BA2B;
	Tue, 15 Aug 2023 08:05:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15AA945
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35205C433C8;
	Tue, 15 Aug 2023 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692086754;
	bh=5Ljew4cQNTDpEZhaF0GRxtadOljJgR6ImBglPGo+hRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwctDhYJMNwfFCmT/7P/5zOpYP4li2pzW9OY5NqOurX9zbTuFQGfniKFmmP0XedmN
	 KpKVFkonyZeoSLVAnurdEvgPN3dbQ0qwwXWrp25m03ih1dGKcSe3ndPM1c0IgW6iFh
	 uM3N7YQFE6hvQWuLbWm8wPbo41zIOBLLsa5FEamAZqVilfz6FM7spWh3qddHVxaqXe
	 jxxpipYEsEbfB0Jh57aahiqFB6fr1F6qRPlFIp8l2sKj/ZkLL0cb0S7iy+pRmkqxW9
	 97KdvJ1wha4/jfF/5esm2rG7rYUctvx5GEE+h6UFlkkf9qw+dC2xE87TfppZ2NUHo/
	 ThCm9r9ze8znA==
Date: Tue, 15 Aug 2023 10:05:48 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	clement.leger@bootlin.com, ulli.kroll@googlemail.com,
	kvalo@kernel.org, bhupesh.sharma@linaro.org, robh@kernel.org,
	elder@linaro.org, wei.fang@nxp.com, nicolas.ferre@microchip.com,
	simon.horman@corigine.com, romieu@fr.zoreil.com,
	dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] net: qualcomm: Remove redundant
 of_match_ptr()
Message-ID: <ZNsx3AfhC0XAe+RB@vergenet.net>
References: <20230814025520.2708714-2-ruanjinjie@huawei.com>
 <20230814025520.2708714-5-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814025520.2708714-5-ruanjinjie@huawei.com>

On Mon, Aug 14, 2023 at 10:55:18AM +0800, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

