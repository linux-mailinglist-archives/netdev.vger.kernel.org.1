Return-Path: <netdev+bounces-34000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E117A1424
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 05:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C9281FC3
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 03:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A728ED8;
	Fri, 15 Sep 2023 03:08:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F238ED2
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 03:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AB6C433C8;
	Fri, 15 Sep 2023 03:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694747299;
	bh=7FrTAJzDfQNtCoU7xoLCY3JDAAiuz6chuqMQHUAg074=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gKu9pswdkmp7iVYNR2YoS1HTjjkROIlZL6oQ0F6PnEPdjxfi5y/ms0xHxjHDOLhma
	 rQICRSMN0yJlYbutX17NwAbTz2abApq/0RlkSBWtU6qwv6J4s4z0xbNmaphXJ/UNxy
	 tlhZPybZyGmOv283sM3x1B+57noDfwnAFnG1laW+aTUncVPzlWJja42RXTaENeDm5R
	 cRVQNIMLah8tJxY5Yt5j8TzZycCAfuJN/RezClRhh2k5gH8fNe3qvQxhCQ5k6akVue
	 fxeLn3eU6Jf1nMSefqLu+8/7M45zMU35ac3CumdmTzzH91++zDF7XYsfV1HHXPfZZv
	 iS/YTSRpgMu2g==
Message-ID: <c5a71b96-30aa-4543-2d8e-196a37693254@kernel.org>
Date: Thu, 14 Sep 2023 21:08:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Thomas Haller <thaller@redhat.com>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
 <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com> <ZPBn9RQUL5mS/bBx@Laptop-X1>
 <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
 <2546e031-f189-e1b1-bc50-bc7776045719@kernel.org>
 <bf3bb290-25b7-e327-851a-d6a036daab03@6wind.com> <ZQPAL84/w323CgNT@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZQPAL84/w323CgNT@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/23 8:23 PM, Hangbin Liu wrote:
> On Fri, Sep 01, 2023 at 11:36:51AM +0200, Nicolas Dichtel wrote:
>>> I do agree now that protocol is informative (passthrough from the kernel
>>> perspective) so not really part of the route. That should be dropped
> 
> I'm not sure. Is there any user space route daemon will use this info? e.g. some
> BGP route daemon?

It is passthrough information for userspace to track who installed the
route. It is not part of the route itself, but metadata passed in and
returned.

