Return-Path: <netdev+bounces-35576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96297A9C75
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72BE1C21294
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C34B14F6D;
	Thu, 21 Sep 2023 19:13:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37114F63
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B200BC433C7;
	Thu, 21 Sep 2023 19:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695323608;
	bh=luIFf+VqWsAOzFv7LKCRll3Uulp2jrl461uJPcy9Sjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vQKEgOziTMGvZo8oSuZIt16LTtiwg+Ang3rlCHsZd7rWGyTpDs3flmjyUnucL2don
	 WJUVP2k6sO37BCklXjOgk7BdnpCqccIiP96jTc4craTHs6RqQ2J06O9owxQhPwGEG9
	 CovmfJTKiNsI2tQjNbfEuixsp/xojw8BAOItTMCoHwgPMCCZeu8nD4YZH3S4TiVFwu
	 1e9PV9YOTBSvTosCKd6d9VhJ3kjrjfhBsdTMV2zNNCscs7XFXfBjWlCoNUjLORanan
	 FMg6dzTQBrD7X6h58K3knP/Q9Grczgnw7CsmVTbA9cFRMBL4ihSz4Yja9nkI6KPWBv
	 9DS0m0J4xR2aA==
Message-ID: <753c9998-7ce0-3e98-ba30-da154d5591a9@kernel.org>
Date: Thu, 21 Sep 2023 13:13:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 5/8] inet: lockless getsockopt(IP_MTU)
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921133021.1995349-1-edumazet@google.com>
 <20230921133021.1995349-6-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921133021.1995349-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 7:30 AM, Eric Dumazet wrote:
> sk_dst_get() does not require socket lock.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/ip_sockglue.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



