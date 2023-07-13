Return-Path: <netdev+bounces-17703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BEA752C3B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 23:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352D9281F48
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0120F8B;
	Thu, 13 Jul 2023 21:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1720F8A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3AFC433C8;
	Thu, 13 Jul 2023 21:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689284095;
	bh=wBghzI871DqslOPP4CYZ+fRgwU6hswlJdVbSmrzFeeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uk3WWDJNfD+hhRWecX+EIcA00KTb5FzswrdIBvy7gjEE1E5681LYjypBsrw8JRxDT
	 2B+Lo20qpa3LYwW0OP5VEzBpLAsum+84rhMgtp5QEHFT3MJ9jtTqv53pHgE6GQvXRo
	 4ZNmdL/+T1R6Yb/OJGKjIA1wIjKKYpwm8o+kjtf+ZOQpKoxJo5d3doKl57WMm/Pttl
	 WD3yMZ2C348eTh3+n9mc7vNSyEILXa+rhk07jLBF4QiGLGrnRUJRr2H5xvw3Nt4IoZ
	 puQUfmO7HlAxtVxrstbzHTINTz3mQpSLN2AP6xDgJLDvkd8vjlmCyo+3WSPFkSiH+1
	 xFeLXW69iQXeg==
Message-ID: <51dcd448-183c-7ec3-86b7-5d9acad34772@kernel.org>
Date: Thu, 13 Jul 2023 15:34:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 3/4] ipv6: Constify the sk parameter of several
 helper functions.
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
References: <cover.1689077819.git.gnault@redhat.com>
 <38ea4cdcbd51177aae71c2e9fd9ca4a837ae01ec.1689077819.git.gnault@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <38ea4cdcbd51177aae71c2e9fd9ca4a837ae01ec.1689077819.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/23 7:06 AM, Guillaume Nault wrote:
> icmpv6_flow_init(), ip6_datagram_flow_key_init() and ip6_mc_hdr() don't
> need to modify their sk argument. Make that explicit using const.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  include/linux/icmpv6.h | 10 ++++------
>  net/ipv6/datagram.c    |  7 ++++---
>  net/ipv6/icmp.c        |  6 ++----
>  net/ipv6/mcast.c       |  8 +++-----
>  4 files changed, 13 insertions(+), 18 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



