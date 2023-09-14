Return-Path: <netdev+bounces-33887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87107A08FF
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13A61C20E5E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688141CFA1;
	Thu, 14 Sep 2023 15:07:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1328E32
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762C3C433C8;
	Thu, 14 Sep 2023 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694704072;
	bh=/Gd/IrIUuQI3SG8hfO+oNqm84K27rd51B9r0OruuVE0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tFDgMA5vDqLhpVr/2l27k7wpVFQRViXN+62+rMlE50pL5a7vjM02LJJj66gY5yETH
	 q0J+x+lNjp7cpOIBiu3MmXg4f+RSYIqCYgMBONVG8qkPVc2GjZjEu5BXm1q6VMRZWC
	 D+A+zLdC28ZNnwLFWVrcneS6IezJM+lUTjN+Fzj150BKUc4FegrZCP61OwotlpTzae
	 +AUqEdatRlNXtBCnEOpRoLWQgJr88tJ5m8Antk6QpQPRCTABy/+qPuv4mlhtVOWTOV
	 Kf54Dopzw/DW/oZI6FCQKEhqoTh3pbwrf0MmZ21EIFpkZZj87NYnzR20L6B/8R4dwI
	 +wPjxmq+mWfwA==
Message-ID: <a8630baf-458d-3dd2-c8e4-3fccd9b9a5a5@kernel.org>
Date: Thu, 14 Sep 2023 09:07:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 11/14] ipv6: move np->repflow to atomic flags
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-12-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-12-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> Move np->repflow to inet->inet_flags to fix data-races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     |  1 -
>  include/net/inet_sock.h  |  1 +
>  net/dccp/ipv6.c          |  2 +-
>  net/ipv6/af_inet6.c      |  3 ++-
>  net/ipv6/ip6_flowlabel.c |  8 ++++----
>  net/ipv6/tcp_ipv6.c      | 14 ++++++--------
>  6 files changed, 14 insertions(+), 15 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



