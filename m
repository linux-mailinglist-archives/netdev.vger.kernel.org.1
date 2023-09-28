Return-Path: <netdev+bounces-36935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247C7B26C2
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 22:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 277F9282A68
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 20:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269EB9CA6F;
	Thu, 28 Sep 2023 20:42:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD22917
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 20:42:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820419C;
	Thu, 28 Sep 2023 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Ounj1+uXd+VOP4zrK2phg+RjnwNWyqqQjfN2b+rvDes=; b=TmxnbLPx4XXYwmI1upPf32XSYB
	TZn2i1I6Doptnl8FAfj4f/tQiRkRCfIpH845+OfdtWTyZSu4xfD7ci6GUeL7tsp+q2ODLPp+Yl5NC
	ghmklItQMJIzbv6A5/4c7eP0GdAIxiISRxVSeUEqXfh4XNgAxnRFUxKQQcy98X9VB0H2BHFlPpXhq
	+ViWew9yo3ydTBtj0fLN8QIaE4pfFJ5sD5zYze5Sx1feSi+EUaLtX8PYTikeF69Oru9BpOI1IAeu5
	SzZZURscNsi1YrqhYV20T04LoJATGE6tmWYwcYKQEq18tWiyhWnDUIVNCJpYacesvgvsg6H33HyhF
	uWCVMOaQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qlxpk-006eoe-2y;
	Thu, 28 Sep 2023 20:42:04 +0000
Message-ID: <4731c8da-3dfa-47da-baf1-26df019d08ee@infradead.org>
Date: Thu, 28 Sep 2023 13:42:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] Documentation: dpll: Fix code blocks
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 "David S. Miller" <davem@davemloft.net>, kernel test robot <lkp@intel.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230928052708.44820-1-bagasdotme@gmail.com>
 <20230928052708.44820-2-bagasdotme@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230928052708.44820-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/27/23 22:27, Bagas Sanjaya wrote:
> kernel test robot and Stephen Rothwell report htmldocs warnings:
> 
> Documentation/driver-api/dpll.rst:427: WARNING: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 18 supplied.
> 
> .. code-block:: c
> 	<snipped>...
> Documentation/driver-api/dpll.rst:444: WARNING: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 21 supplied.
> 
> .. code-block:: c
> 	<snipped>...
> Documentation/driver-api/dpll.rst:474: WARNING: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 12 supplied.
> 
> .. code-block:: c
> 	<snipped>...
> 
> Fix these above by adding missing blank line separator after code-block
> directive.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309180456.lOhxy9gS-lkp@intel.com/
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20230918131521.155e9e63@canb.auug.org.au/
> Fixes: dbb291f19393b6 ("dpll: documentation on DPLL subsystem interface")
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/driver-api/dpll.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
> index bb52f1b8c0be31..01eb4de867036f 100644
> --- a/Documentation/driver-api/dpll.rst
> +++ b/Documentation/driver-api/dpll.rst
> @@ -425,6 +425,7 @@ The simplest implementation is in the OCP TimeCard driver. The ops
>  structures are defined like this:
>  
>  .. code-block:: c
> +
>  	static const struct dpll_device_ops dpll_ops = {
>  		.lock_status_get = ptp_ocp_dpll_lock_status_get,
>  		.mode_get = ptp_ocp_dpll_mode_get,
> @@ -442,6 +443,7 @@ structures are defined like this:
>  The registration part is then looks like this part:
>  
>  .. code-block:: c
> +
>          clkid = pci_get_dsn(pdev);
>          bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE);
>          if (IS_ERR(bp->dpll)) {
> @@ -472,6 +474,7 @@ The registration part is then looks like this part:
>  In the error path we have to rewind every allocation in the reverse order:
>  
>  .. code-block:: c
> +
>          while (i) {
>                  --i;
>                  dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);

-- 
~Randy

