Return-Path: <netdev+bounces-43486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD67D3929
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E55B20BDA
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FBB1B287;
	Mon, 23 Oct 2023 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSECD4wA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919301B286
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 14:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEF6C433C9;
	Mon, 23 Oct 2023 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698070747;
	bh=wLIy1aefQ4yhPBXOUHP6N6N5h16eUxi70U54zf14d2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jSECD4wASSCL7oY68tn8qcx6oln6oYy1ZxEnvAJI1xnZESdsiwCidSTRatyXtnMZT
	 npKxW0s+xXT1+Tqb4bTUgby0ZxrDZ5AVzLm+09XTOC1iXc0Q80hzQ0ve3IWS3/2X98
	 v98oSgjiUN1nsLi73bn/6M97Ynw25ryU3HVhv1jNx8GA4l4e4aWXbfaCrRImVk+BG/
	 U5p7YhpQ8SXIB1z8ti+C/9jE5WWSW6frwXxZGWL/ymHqNPh0OHjYr7du/IruudxXjs
	 Ye6HCZefSYBT+6uW3ZVXWHTXhCmdBDJsm8q5FSVDDZUp5FShLMrt5sGrBhNa35MOi5
	 lNZ+xLIamUQSA==
Message-ID: <f22a0a5b-2813-4c59-9d30-af9f87a2f5aa@kernel.org>
Date: Mon, 23 Oct 2023 08:19:06 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:net change ifconfig with ip command
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, David Ahern <dsahern@kernel.org>
Cc: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20231022113148.2682-1-swarupkotikalapudi@gmail.com>
 <fde654ce-e4b6-449c-94a9-eeaad1eed6b7@kernel.org>
 <ZTYc04N9VK7EarHY@nanopsycho>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZTYc04N9VK7EarHY@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/23 1:12 AM, Jiri Pirko wrote:
>> ip addr add ...
> 
> Why not "address" then? :)

no objection from me.

> What's wrong with "a"?

1-letter commands can be ambiguous. Test scripts should be clear and
obvious.



