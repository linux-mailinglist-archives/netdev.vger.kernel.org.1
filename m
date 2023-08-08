Return-Path: <netdev+bounces-25266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE787739D6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 13:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E2281717
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3356FEAF4;
	Tue,  8 Aug 2023 11:03:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E8E57E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FDFC433C8;
	Tue,  8 Aug 2023 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691492630;
	bh=A+mqCpN+QuFAcnM1ap+yOp5utSXZlVUNIHG5R4odB6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lik0sr/+SSNBgc79MfJ0720gb9FA9wUR4ajKbE4hlQU6LR65Rua/0DtXWZPnb1DcG
	 O8S9x3mi3rg6f3b/25KTN1yGu+//8gTrvLdJNpL6MBlgN+OL7yD/a5LCCQ7s5wRz+W
	 il/KbU0sOxJm3PI2uS15NacnsFKi4D8/aNvPGNKTSu+f1v7cEoyXzlOm9qUZGjOjBo
	 2XjDDJUpf9x71LBBoQtAEXWcTLpdyF0gxg1ikRhp+ZMePGOLAGme6a9c6PjX0IYCCl
	 sPPm2ZRYpnLlp42kQv2Vr5psLo4DHDAqcZCzE+6CtOX/1phyAG/52byRnUO6ef2GKQ
	 HrZXAh5+GT4WA==
Message-ID: <4c0dfd1c-2b61-b954-73ad-ac8d4b82487d@kernel.org>
Date: Tue, 8 Aug 2023 06:03:47 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/5] clk: socfpga: agilex: add clock driver for the
 Agilex5
Content-Language: en-US
To: niravkumar.l.rabara@intel.com
Cc: adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, netdev@vger.kernel.org, p.zabel@pengutronix.de,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 wen.ping.teh@intel.com
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stephen/Mike,

On 7/31/23 20:02, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
> driver for the Agilex5 is very similar to the Agilex platform,we can
> re-use most of the Agilex clock driver.
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   drivers/clk/socfpga/clk-agilex.c | 433 ++++++++++++++++++++++++++++++-
>   1 file changed, 431 insertions(+), 2 deletions(-)
> 

If you're ok with this patch, can I take this through armsoc?

Dinh

