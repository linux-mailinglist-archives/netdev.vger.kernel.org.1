Return-Path: <netdev+bounces-33292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2DE79D535
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18572281DD6
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA118C1E;
	Tue, 12 Sep 2023 15:43:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408518C19
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E95C433C8;
	Tue, 12 Sep 2023 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694533410;
	bh=hj0RC1WXc1DnjIlLTA7SyBZ02s+JLUdYH29vAGditPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VwYFCPHWIBC0kH4kkwXXOjfI9Ei6Nduu4v1Nu+IiNRiGR5oheUxCJ2zDnNTvF+CvB
	 uD1A6knRj8t7yiSzhVLcFAZalTcuDUnqI6usAswJl6MFhlJWeFl3RKF+BQcaLvCSFf
	 sOEFCVKXXuFFgfQ64I53CRmeqLyxbNRnjI5+u16xJxWw+jw9OIuv43njJJQugfAsQV
	 cLQLE8YiYvtZkMzLpyw3wuFB2Y7revjkr4OL7hZ65n+SeaB5d+k17Hmx/Dnq2GSAjf
	 /K+3IsB8qNaahy8cVHwVoLitM3HmdErv+PO9AvaJ/NTo+Y7dszYlEaWDkpHy3X5yy5
	 v+fnix8iqTSWA==
Message-ID: <4c8ce973-15fb-1e25-7ec2-049336ed7f2b@kernel.org>
Date: Tue, 12 Sep 2023 09:43:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next] ipv6: mcast: Remove redundant comparison in
 igmp6_mcf_get_next()
Content-Language: en-US
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
 "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230912084100.1502379-1-Ilia.Gavrilov@infotecs.ru>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912084100.1502379-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 2:42 AM, Gavrilov Ilia wrote:
> The 'state->im' value will always be non-zero after
> the 'while' statement, so the check can be removed.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
> Repost according to https://lore.kernel.org/all/cdc2183a-c79a-b4bd-2726-bd3a2d6d5440@kernel.org/
>  net/ipv6/mcast.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



