Return-Path: <netdev+bounces-35575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4C7A9C76
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759D8282E8F
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C169CA4E;
	Thu, 21 Sep 2023 19:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935C9CA42
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B93BC433CB;
	Thu, 21 Sep 2023 19:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695323555;
	bh=slLvj+3kkrXrf5tAu5DCSIppIsZy/Vzd/iLxLr6tFzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tFeZk3gCdNCLzdujKitvesn0znryN8v2dUe4sv50d1Z28+JuPWgGIFFC9bv3D6LOV
	 HMcRvhTRIxvfz/qUTwdpFzg1PkkP2tLKN3WBN8F8+Kgq8Tm97gbt3hpTgsz8FyemLI
	 fK6veL4fn1KiDciuYzGPn8oRk+VlgVQMYnlXiGfBLNqcC/i9sIDC0wZDUG9lg2SvV1
	 U0hFQfGKTwk0s3TaEUSLPc9BYt7oQY3MyFAQ5S/I2HDQ6d/0S7/VZvnqGUq20JNDD4
	 kNGAkP7S9JLuVo/2O15xMRTV1LESjZ6koZLc7wM55I9RUG2TdLCH3LLkYYsO2AMwL+
	 /jdvaAkimCDRQ==
Message-ID: <2f033367-fdcc-7a44-18bd-1fcf8257e1b1@kernel.org>
Date: Thu, 21 Sep 2023 13:12:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 4/8] inet: lockless getsockopt(IP_OPTIONS)
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921133021.1995349-1-edumazet@google.com>
 <20230921133021.1995349-5-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921133021.1995349-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 7:30 AM, Eric Dumazet wrote:
> inet->inet_opt being RCU protected, we can use RCU instead
> of locking the socket.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/ip_sockglue.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



