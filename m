Return-Path: <netdev+bounces-57473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E201181323D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831AAB21973
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5555F5786B;
	Thu, 14 Dec 2023 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If1izdon"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6A57866
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 13:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9875C433C7;
	Thu, 14 Dec 2023 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702562040;
	bh=hpFFXTmdXfzanXnsdALphQX0Ep1vz2YY4i+cRKKFp8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=If1izdonII/GWHYWsyA6KwnvJHTklxXM1V9F5kzkZ8ovqBrxTZn1/1g1FVBrZMuis
	 UExbC7QuscqXwxTU0LPbUGyOeBwhp5z/LTUA0EhXC3xBfjxGWeulEOLJCLO09RYZd8
	 TOP6S+TZZd32o14Y2J5lwrwKl62vUZKH/0mZQk/uQrEUOBzI42KDUFtZ2LITdsai6g
	 VV9Fk99I9mHlwfThDaQ6Ein0ofJylcLnqoYJPgBlntNs8vpsAzP6GopqZ9ny+dZkbN
	 2508wRg93+N0MgCvfz/rASnku5kmzLrxePUW/BSc+0J8PyP6Ta1Ga9lekBFfczwFXc
	 lJn4bOZ16qT0w==
Message-ID: <4b20b60a-c72d-4283-a8af-ff82bc5d1b19@kernel.org>
Date: Thu, 14 Dec 2023 15:53:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 09/11] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
 p-varis@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-10-rogerq@kernel.org>
 <20231214110448.lycg7yusrusbd7w2@skbuf>
 <c08814cb-86b6-44bb-8682-00a5b6a0c0bc@kernel.org>
 <20231214135039.6lcixyy7z6u56zgv@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231214135039.6lcixyy7z6u56zgv@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/12/2023 15:50, Vladimir Oltean wrote:
> On Thu, Dec 14, 2023 at 03:44:03PM +0200, Roger Quadros wrote:
>> On 14/12/2023 13:04, Vladimir Oltean wrote:
>>>> +	/* verify_timeout_count can only be set at valid link */
>>>> +	if (cfg->verify_time > 0)
>>>> +		port->qos.iet.verify_time_ms = cfg->verify_time;
>>>> +	else
>>>> +		port->qos.iet.verify_time_ms = 10;
>>>
>>> I don't think I understand what the check is for? The netlink policy for
>>> ETHTOOL_A_MM_VERIFY_TIME limits the range between 1 ms and 128 ms.
>>> How can it be 0?
>>
>> I didn't check ETHTOOL_A_MM_VERIFY_TIME before.
> 
> Not even when the exact same policy was rejecting the verify-time set by
> LLDP in v6, for being larger than the upper limit of 128 ms? :-/

Sorry. I did check it before but overlooked it here. My memory seems to be failing me. :(

-- 
cheers,
-roger

