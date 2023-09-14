Return-Path: <netdev+bounces-33880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5C87A08D7
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1564CB20BE1
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B17208A9;
	Thu, 14 Sep 2023 15:02:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACC28E32
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6164C433C8;
	Thu, 14 Sep 2023 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703773;
	bh=s4CX6yfkYpZkgGYLs4/h4yQQJ1/RanXeYZnEbctm+eA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NikygRI4GZDL782OudAkEREFNsb4o6XJMPILWT4CALV5n1EaVM4embxX3AB7rhN4t
	 jLxGbJEUFyJitGbol3WEAS2/0BWGsCn8TEKkNmLjLSrHW1u6a32e1Ui0mPxbBu27aN
	 wEDw+ww/T2P5jZ1T/DTyCaHfsg2g//GCmpGAVLb2WfRWSKbZOM69GpENnwtlKBmmaM
	 TJLXX+gZd2KbkFF/l0YDQ9DqxRW1MLzQTmgbBVIwBR33eh9lYPy7CDvtsS5H56wP4a
	 dTwDDpYWfsTW9ed6WChGEow6FJynhcesvLktXo8aLgfeLi11GkKdSInEFKQ42lKTWi
	 5Y/J6XH9BD+ng==
Message-ID: <75e89ee6-9716-f859-ed91-7f6a1fb0d100@kernel.org>
Date: Thu, 14 Sep 2023 09:02:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 06/14] ipv6: lockless IPV6_RECVERR_RFC4884
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-7-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-7-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> Move np->recverr_rfc4884 to an atomic flag to fix data-races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     |  1 -
>  include/net/inet_sock.h  |  1 +
>  net/ipv6/datagram.c      |  2 +-
>  net/ipv6/ipv6_sockglue.c | 17 ++++++++---------
>  4 files changed, 10 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



