Return-Path: <netdev+bounces-34214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A87A2D96
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 05:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E536282EF7
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B885691;
	Sat, 16 Sep 2023 03:16:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE7374
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 03:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92A8C433C7;
	Sat, 16 Sep 2023 03:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694834213;
	bh=A7gb93rs8D7MB6Qn5P0QHphTngkPr/4vleIBleW1j3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YkK+aortdF5d2avbyU9AqNZtVWAMfg5r4m33pWojHWNwK/Dv4VwRcV4Vhl5dGY+fp
	 o6gp+kkFKmKTXAF8+usaCetKR5GbP1ZkqZM9vX5stcthr56vVtwvlrK36dRa86HoRd
	 XCRI+P8O4iaao/UcdE1gQ9ebZ1T3n6r9cuO3qLu0O4hK4aat3CjurTk4pubdtSZrum
	 sxpMxoa58pwUMDGD3dVxiqAXh4kJlErsyjN5FdgYEiD+qtcS4UQtYhGgvI2AfW9/CM
	 7iEhMAOqyAUJRxThRPJG33Je4r61e3G9RHp2LbxRMk6WcmJmQZ+7ZGwWyBjQaa5j0S
	 RHHmm5inIv9nw==
Message-ID: <43a798c0-bba2-ce82-bdbb-c9345a97d339@kernel.org>
Date: Fri, 15 Sep 2023 21:16:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1 net-next 2/5] net-smnp: reorganize SNMP fast path
 variables
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-3-lixiaoyan@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230916010625.2771731-3-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/23 7:06 PM, Coco Li wrote:
> From: Chao Wu <wwchao@google.com>
> 
> Reorganize fast path variables on tx-txrx-rx order.
> Fast path cacheline ends afer LINUX_MIB_DELAYEDACKLOCKED.
> There are only read-write variables here.
> 
> Below data generated with pahole on x86 architecture.
> 
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 2
> 
> Tested:
> Built and installed.
> 
> Signed-off-by: Chao Wu <wwchao@google.com>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/uapi/linux/snmp.h | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


