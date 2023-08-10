Return-Path: <netdev+bounces-26297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF27777656
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF811C21201
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1301ED3F;
	Thu, 10 Aug 2023 10:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF341DDF0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46C7C433C9;
	Thu, 10 Aug 2023 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691664988;
	bh=VNB7J0sNStEzCd8cGx8BrhaRIe5VtMJrq9LUHaC2pkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ikvI6GdYlwWwP/8GJbRw77QRHRO56Btg9nX8tmPKOFjCcPaWTvk5Xsii9p+xrOklm
	 DnV8Hf2pc6TEolos3MzpZD/Mb3WzpTohxN0y5Ngotqt9UWUEJOjVBKRUYhkWJo2XK3
	 z1cw3Yee57W+AYSKY8h4B5Pj5briru7DJKqdWj2hIjA4cERSCwZwLJ2hqMG7rdXSUH
	 VUoLOfHHyNp+rETLPrBfslIZvdvZnbVjW5nxOBcy5w1wa2rlAt339D/3lmXvMSj89s
	 gprIC1pZWuwbRoHGWbS9DCqRbZaxHlu98PoIsmFsIdwSuf8mRdfZOkA9aU86rGEyq+
	 8bilumKeR7zQQ==
Message-ID: <beb378c1-cba4-26a0-0737-90243ec226c1@kernel.org>
Date: Thu, 10 Aug 2023 05:56:25 -0500
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
To: Stephen Boyd <sboyd@kernel.org>, niravkumar.l.rabara@intel.com
Cc: adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, netdev@vger.kernel.org, p.zabel@pengutronix.de,
 richardcochran@gmail.com, robh+dt@kernel.org, wen.ping.teh@intel.com
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
 <4c0dfd1c-2b61-b954-73ad-ac8d4b82487d@kernel.org>
 <677706de77d5d5b799d25c855a723b2c.sboyd@kernel.org>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <677706de77d5d5b799d25c855a723b2c.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/9/23 16:28, Stephen Boyd wrote:
> Quoting Dinh Nguyen (2023-08-08 04:03:47)
>> Hi Stephen/Mike,
>>
>> On 7/31/23 20:02, niravkumar.l.rabara@intel.com wrote:
>>> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>>
>>> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
>>> driver for the Agilex5 is very similar to the Agilex platform,we can
>>> re-use most of the Agilex clock driver.
>>>
>>> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
>>> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
>>> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>> ---
>>>    drivers/clk/socfpga/clk-agilex.c | 433 ++++++++++++++++++++++++++++++-
>>>    1 file changed, 431 insertions(+), 2 deletions(-)
>>>
>>
>> If you're ok with this patch, can I take this through armsoc?
>>
> 
> Usually any binding files go through arm-soc and clk tree but the driver
> only goes through clk tree via a PR. Is that possible here?

Ok. Should be fine in this case.

Thanks,
Dinh

