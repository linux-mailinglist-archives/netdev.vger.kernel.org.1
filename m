Return-Path: <netdev+bounces-46679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111F17E5C33
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 18:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410E61C20933
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290731591;
	Wed,  8 Nov 2023 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb98JdwQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483E3035C
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 17:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C010C433C8;
	Wed,  8 Nov 2023 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699463849;
	bh=LWObcsfO/U8VMLk0vuZGtU0rY1f8hZssrYeJVoKR3ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hb98JdwQHE5zai/wzaW5EvtRJv+9dkc+E1NUDSeo+E4q0ODo4EbbJh4Li+hawWEsm
	 bTUIIVpivj/VtOEReYFHzGeO14l6+HDaHS76ZxwfueR4o8mCL1SyvGseSekIwkVoEz
	 6YmV2yQVw4jmmJO+U2Vu5ZFsSbIIlMUcccS/b/cq/BEZdF7Jfj18Gp1ShN9jtgsTo2
	 AntgTz+lnNBbhk83iddeUu/ouYmagViGO8tks2KkmwuB9NxJwFkh47ycExlz/TXqiv
	 H9Zw2jEruHHC8N1JLMqyyjxnaCbhg7F1jRk5nQqxniWt51Sci0DISMfBwoAwU0v3y3
	 /q9XuLFPF0ykQ==
Message-ID: <89cd5f11-2c54-4905-b900-b1e06304805f@kernel.org>
Date: Wed, 8 Nov 2023 10:17:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bypass qdiscs?
Content-Language: en-US
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
 <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch>
 <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
 <20231105192309.20416ff8@hermes.local>
 <b80374c7-3f5a-4f47-8955-c16d14e7549a@kernel.org>
 <CAGXJAmz+j0y00XLc2YCyfK5aVPD12aDcrNzc58N1fExT6ceoVw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAGXJAmz+j0y00XLc2YCyfK5aVPD12aDcrNzc58N1fExT6ceoVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/23 9:50 AM, John Ousterhout wrote:
> Hi David,
> 
> Thanks for the suggestion, but if I understand this correctly, this
> will disable qdiscs for TCP as well as Homa; I suspect I shouldn't do
> that?
> 

A means to separate issues - i.e., run Homa tests without qdisc overhead
or delays. You can worry about how to handle if/when you start
upstreaming the code.


