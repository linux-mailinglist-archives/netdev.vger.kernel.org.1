Return-Path: <netdev+bounces-36954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AB37B2A0E
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 03:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9A9AE1C20A68
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0115B2;
	Fri, 29 Sep 2023 01:00:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901610FA
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 01:00:15 +0000 (UTC)
Received: from out-191.mta1.migadu.com (out-191.mta1.migadu.com [IPv6:2001:41d0:203:375::bf])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1AFB4
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 18:00:14 -0700 (PDT)
Message-ID: <022235bd-0226-c896-02a1-aa7765eaa6ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695949212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtKt+ZDkUpFphIBKnAoHk52i8tmcI0v9dPl6VlzoB7M=;
	b=A9bOvlMm//bDoKBydN6sv621PcEys4Q1KWYt6SFL67G5XSVHDWO89gXkAZT1ElNueSITkO
	lDRHJSTo8A34TQDzwMit2+IM/xNI5MmKvhj+nJk2vOvuQ/Oyqf3BIpuao7qi3HVvlQh9o+
	mLFO8CQbJAx+IeXSl8gc9qBx9FtAnTU=
Date: Fri, 29 Sep 2023 02:00:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/2] Documentation fixes for dpll subsystem
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 "David S. Miller" <davem@davemloft.net>
References: <20230928052708.44820-1-bagasdotme@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230928052708.44820-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/09/2023 06:27, Bagas Sanjaya wrote:
> Here is a mini docs fixes for dpll subsystem. The fixes are all code
> block-related.
> 
> This series is triggered because I was emailed by kernel test robot,
> alerting htmldocs warnings (see patch [1/2]).
> 
> Changes since v1 [1]:
>    * Collect Reviewed-by tags
>    * Rebase on current net-next
> 
> [1]: https://lore.kernel.org/all/20230918093240.29824-1-bagasdotme@gmail.com/
> 
> Bagas Sanjaya (2):
>    Documentation: dpll: Fix code blocks
>    Documentation: dpll: wrap DPLL_CMD_PIN_GET output in a code block
> 
>   Documentation/driver-api/dpll.rst | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 5a1b322cb0b7d0d33a2d13462294dc0f46911172

For the series:

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

