Return-Path: <netdev+bounces-27668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCFF77CBD3
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 13:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7213F1C20C2B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF610979;
	Tue, 15 Aug 2023 11:36:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038165C9D
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 11:36:22 +0000 (UTC)
Received: from out-6.mta1.migadu.com (out-6.mta1.migadu.com [95.215.58.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5CA10C0
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 04:36:20 -0700 (PDT)
Message-ID: <43395307-9d11-7905-0eec-0a4c1b1fc62a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692099378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdaOhJMcLy8g2NeNhcZ0hjcc5u5LnChRhx//RtiayQ4=;
	b=OWMV0nhGYN/Xpcdri2nKwD8iSdWtf+SoVmD0ynb6XBq7aevH38T/J7f4EyvMgs+IbLLaoK
	BBMPl5leCQ99nxanJAOjIDE7trjwwvU8TliNlMXmnZhpOKwqtRNKKOp6abth0eL3v/B9NR
	cHd9by0qtahbeg3ZcFMSJjLeTkHVYVw=
Date: Tue, 15 Aug 2023 12:36:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 0/9] Create common DPLL configuration API
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Milena Olech <milena.olech@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com, mschmidt@redhat.com,
 netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230814194528.00baec23@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230814194528.00baec23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/08/2023 03:45, Jakub Kicinski wrote:
> On Fri, 11 Aug 2023 21:03:31 +0100 Vadim Fedorenko wrote:
>>   create mode 100644 Documentation/driver-api/dpll.rst
>>   create mode 100644 Documentation/netlink/specs/dpll.yaml
>>   create mode 100644 drivers/dpll/Kconfig
>>   create mode 100644 drivers/dpll/Makefile
>>   create mode 100644 drivers/dpll/dpll_core.c
>>   create mode 100644 drivers/dpll/dpll_core.h
>>   create mode 100644 drivers/dpll/dpll_netlink.c
>>   create mode 100644 drivers/dpll/dpll_netlink.h
>>   create mode 100644 drivers/dpll/dpll_nl.c
>>   create mode 100644 drivers/dpll/dpll_nl.h
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.c
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.h
>>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>   create mode 100644 include/linux/dpll.h
>>   create mode 100644 include/uapi/linux/dpll.h
> 
> Feels like we're lacking tests here. Is there a common subset of
> stuff we can expect reasonable devices to support?
> Anything you used in development that can be turned into tests?

Well, we were playing with the tool ynl/cli.py and it's stated in
the cover letter. But needs proper hardware to run. I'm not sure
we can easily create emulation device to run tests.

