Return-Path: <netdev+bounces-24732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F627717A9
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 03:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C72F1C208FA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 01:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08657392;
	Mon,  7 Aug 2023 01:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850A19D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF224C433C7;
	Mon,  7 Aug 2023 01:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691370452;
	bh=d5q7CgXL6qUP6LA9FNwOW1h25EJKgRKBpWbldXr5fgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hgqm5m/lyecX9tQqQm059ocJUSzHNxvuwapBgdXSnt4iv34fv+Pknxf1ow87CynEG
	 jXj9B+aLQa9lv8ujxE/3vBz0I2DE1oL1KLR4gMNHwXpS33lWkvqiUXIC/5Q/u32KWK
	 QtTEeADrabrW3NfkJhLGg7i6AcumKjbkSWI2OHz1vcnJZ+D7qut6Ih/uTgfz362xMY
	 nB0Xu1u7/Y2pBVOY4I95Ahjp/HrlWwWZDmeuU+T2U1AS8rgIo9x3stVxj5B+r/2JI8
	 ijbLLVzUSAhMZSbpDS32MCMdAOjjljFYphEhQtc4z5yu5QEqvSH6YbRuWZw3xqeene
	 SFp2rN//YBZfg==
Message-ID: <ee919c2c-090f-2613-6545-d69e05f95e3f@kernel.org>
Date: Sun, 6 Aug 2023 19:07:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] neighbour: Remove unused function declaration
 pneigh_for_each()
Content-Language: en-US
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20230805105033.45700-1-yuehaibing@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230805105033.45700-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/23 4:50 AM, Yue Haibing wrote:
> pneigh_for_each() is never implemented since the beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/neighbour.h | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


