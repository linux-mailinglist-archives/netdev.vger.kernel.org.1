Return-Path: <netdev+bounces-46140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA537E195E
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 05:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9B228126F
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 04:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9D63A1;
	Mon,  6 Nov 2023 04:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnBmfMRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA75676
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 04:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D29C433C7;
	Mon,  6 Nov 2023 04:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699244856;
	bh=6Cm7pOUvjIR9TuKwhmin81I/UFkeSHRm3E5CHJ0OW74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cnBmfMRnnGlmnJT/r8YSbZNjx/duUP+ucFnqh9A6R4oBYfuAnquhFfaa3r+oD1G5z
	 4xj+fHSJ00VITGmYbFMhvzLpPaw9JuzwqcALwtFTIfk+jR1TRM2pp4leLHv+yR9oHZ
	 KATUntXwNJYBt4+Tce/aXD8R2jhEP2GdQi6PbdA1/pyFyBUz1lcKBZklG/ijBw8Dbq
	 LCynZrI1rPDkOlBcp2OLve5vwy6D8N3cGP4BEKknkKyFB/0U5heyA/FS31cKLhD6Hx
	 cZ1C55RAd9h0VYb/BIyfdfe3McDC17e5jLoyfMIoNkK9T8HXx/8UrNvss0WzOIBtIM
	 Tzi2j0SpabtlQ==
Message-ID: <b80374c7-3f5a-4f47-8955-c16d14e7549a@kernel.org>
Date: Sun, 5 Nov 2023 21:27:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bypass qdiscs?
To: Stephen Hemminger <stephen@networkplumber.org>,
 John Ousterhout <ouster@cs.stanford.edu>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
 <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch>
 <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
 <20231105192309.20416ff8@hermes.local>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231105192309.20416ff8@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/23 8:23 PM, Stephen Hemminger wrote:
> On Sat, 4 Nov 2023 19:47:30 -0700
> John Ousterhout <ouster@cs.stanford.edu> wrote:
> 
>> I haven't tried creating a "pass through" qdisc, but that seems like a
>> reasonable approach if (as it seems) there isn't something already
>> built-in that provides equivalent functionality.
>>
>> -John-
>>
>> P.S. If hardware starts supporting Homa, I hope that it will be
>> possible to move the entire transport to the NIC, so that applications
>> can bypass the kernel entirely, as with RDMA.
> 
> One old trick was setting netdev queue length to 0 to avoid qdisc.
> 

tc qdisc replace dev <name> root noqueue

should work

