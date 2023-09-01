Return-Path: <netdev+bounces-31744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39378FEA2
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 15:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEF7281ADA
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151E8BE62;
	Fri,  1 Sep 2023 13:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE40846B
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 13:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A6DC433C8;
	Fri,  1 Sep 2023 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693576397;
	bh=A7D2RfHQokxJIsd8z/X3dLrvSu2Y7PYLn15rfZSIxh4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aG75KBj3JF0cfgy9wWfRgsOdkDNSTZpgaLml5IP636Ejf25d8eOtxhuS9qvpJax+r
	 Dc6JAzVjogMLR9SS0kxCco8RNPBlPk004TgpQxcQUP3/45kmOR97J+U6Qy3DIa8Pu1
	 FXqMkpJ4TBHk3cP3OVbyb4s+aIDrWjjcfnbLcwTnU0vDNMeu4iKOqKlP3XpmCYMcVN
	 0SSx0psmQpiMt++jNXsOCk669Qia9uZaJT2987ACHQA4BMmYP0+BYxv5eO5nZRd7ru
	 9g/THeaZIXmprfCtinNQ3ZuXOQRuCbgR3pZY3+KdKSrRm3YHXsjuBKiFWw8x6aDc8Y
	 wrWSYH8bT3gOw==
Message-ID: <dcade967-d407-f8bb-c18e-209ea38ad8bd@kernel.org>
Date: Fri, 1 Sep 2023 07:53:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3] net: ipv6/addrconf: avoid integer underflow in
 ipv6_create_tempaddr
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 jbohac@suse.cz, benoit.boissinot@ens-lyon.org, davem@davemloft.net,
 hideaki.yoshifuji@miraclelinux.com, pabeni@redhat.com, kuba@kernel.org
References: <20230829054623.104293-2-alexhenrie24@gmail.com>
 <20230901044219.10062-1-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230901044219.10062-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/23 10:41 PM, Alex Henrie wrote:
> The existing code incorrectly casted a negative value (the result of a
> subtraction) to an unsigned value without checking. For example, if
> /proc/sys/net/ipv6/conf/*/temp_prefered_lft was set to 1, the preferred
> lifetime would jump to 4 billion seconds. On my machine and network the
> shortest lifetime that avoided underflow was 3 seconds.
> 
> Fixes: 76506a986dc3 ("IPv6: fix DESYNC_FACTOR")
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> Changes from v2:
> - Use conventional format for "Fixes" line
> - Send separately and leave the other four patches for later
> ---
>  net/ipv6/addrconf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


