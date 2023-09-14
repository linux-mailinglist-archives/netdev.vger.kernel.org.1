Return-Path: <netdev+bounces-33879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA037A08CF
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8461F24213
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC72D261;
	Thu, 14 Sep 2023 15:01:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4B28E28
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9DFC433C7;
	Thu, 14 Sep 2023 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703696;
	bh=DldlN/rJDcbQjdii1OXIMebBG7I2u1q/R7dxdkUwNcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n47Vcu9oI7qTs+4+mCNhbyBRzdgiQvVF5qQmLY2YfaPtzseC9rZ9E6KI/OpoOkXeK
	 /bPkNgp0VltvRJcLry591gMpAzToavNiud9GB01rcKNUxZwEvV93maCfU5oNv7GdD3
	 rB+N1kl844ynTcVm/hylZBMPfQvjntBbWtVcYLJZCQMHLk0PpIVbxRxOM/dYrp4VfF
	 821ocV3+GP/8DkBW63OooPqyuPBJvgksIMJTHlr2+E3xAH8Bj9THEMKChkUwfNxYFZ
	 dpXYuJmuJ5cAdHtJC49VuEOBDwiRlSEh8hTVjUp2UJa1Ahd79F08VsPQFEkB8MD+bQ
	 0v4/bMiWW/55Q==
Message-ID: <ce3531de-f020-4ec2-7c15-720b6cac951a@kernel.org>
Date: Thu, 14 Sep 2023 09:01:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 05/14] ipv6: lockless IPV6_MINHOPCOUNT
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-6-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> Add one missing READ_ONCE() annotation in do_ipv6_getsockopt()
> and make IPV6_MINHOPCOUNT setsockopt() lockless.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ipv6_sockglue.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



