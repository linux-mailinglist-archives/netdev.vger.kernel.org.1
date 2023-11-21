Return-Path: <netdev+bounces-49610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A0A7F2B95
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7851C2167A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F7348788;
	Tue, 21 Nov 2023 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E4cYMZzx"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7629C
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 03:20:43 -0800 (PST)
Message-ID: <34cb7d4b-58f8-446e-9259-0a234380213c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700565641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHtu2kRGZ0LH/N1X/PWWwv28B3GR8jL1BL7Ou5Resek=;
	b=E4cYMZzxGTT+jZuSXOCoi6zxlnj9qBGTVtIOSMsTXn360AHqjKYPwfZKL2zlb4b0riYh+e
	+RoFh7jo2nNMUZQ5R+Um4UO4WeKvyIeaavqHdRgsyFp3WZN5U1E3QWSHIKTGE6l9zdND5i
	GVBme3DO7/FqpqE+2p8TnktcHUfUA+Y=
Date: Tue, 21 Nov 2023 11:20:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] dpll: Fix potential msg memleak when genlmsg_put_reply
 failed
Content-Language: en-US
To: Hao Ge <gehao@kylinos.cn>, arkadiusz.kubalewski@intel.com
Cc: jiri@resnulli.us, michal.michalik@intel.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <0c6e0cd5-d975-41cc-824e-10b5e28251a2@linux.dev>
 <20231121013709.73323-1-gehao@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231121013709.73323-1-gehao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/11/2023 20:37, Hao Ge wrote:
> We should clean the skb resource if genlmsg_put_reply failed.
> 
> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v1 -> v2: change title due to add some similar fix for some similar cases
> ---
>   drivers/dpll/dpll_netlink.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)

Thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


