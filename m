Return-Path: <netdev+bounces-76771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D881886EE2C
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 03:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70551B24416
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 02:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284C384;
	Sat,  2 Mar 2024 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOG4lS83"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4CE7489
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709347529; cv=none; b=ZweerKqX2V8pOQTVS1ZciUwqbWVUgaWNJ5+K/TcLBBYXT2vemN6Kh4YUUm7lShKo0esgvNIY5eN0/HqTP+vSvtUlDA+vqYgGfugMVwJ822bTm13RY9JHO+HRIT7yiaAqEkO4ag1gPOaKEAaj60bSBL5DYbmXB+yBoSIzuW/FewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709347529; c=relaxed/simple;
	bh=rKXLQnMKbF0M34iUUqa8hY7lC1O2aT46MrNGMq0lmcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grNyvMuySqdGgn2Bl2IvVjZPqIgBGZybaMmOc7uuRqqdDHt7XlsbLe1lcHXJV2/OYHrfA7FfjWP4zXalrk6p8Ba0b6v6yJMBLU2cKu0giit1zlg9h3TFj14IFGJpkyT/td1AV4W1GkCxgLJG/QpNHcfOOAdZ7oWK5tLuJJzND40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOG4lS83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77542C433C7;
	Sat,  2 Mar 2024 02:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709347529;
	bh=rKXLQnMKbF0M34iUUqa8hY7lC1O2aT46MrNGMq0lmcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oOG4lS83DjlgxhXwCcJlQKwaVcSlagxpKTEZf2SKKL3hbHoNHr6Pcj7M3T+ylBiQF
	 h/vpaXn6Ed2r1azyMetsc+Qr64VdhBqQTKw5xxz/xAl5Gaok6N4QowOh5UrCT7AjAp
	 6NnNrd9+rY4W3Eo2mZXTmm5/+uGC/4inA0mFYtd9d2zNWtPvM2syNaU5t79gpW5P0t
	 QYxkKAqxjwPtXV/pbeqDRWBsrBlW8hQA4KeUOlRBIUzTjhHeJhMzEPAH8c8ZV8iTHv
	 N1QbjCCAbGGbA4F/Go22xt6ST2Ea0f+BMQEEocfRlWwjvwYFLDBsxCHN0VKhODsTN6
	 HFtA5toKQdyIA==
Message-ID: <ce6e8ffa-c4c6-4080-a54f-7acc4371c81d@kernel.org>
Date: Fri, 1 Mar 2024 19:45:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] net: nexthop: Expose nexthop group stats
 to user space
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Simon Horman <horms@kernel.org>, mlxsw@nvidia.com
References: <cover.1709217658.git.petrm@nvidia.com>
 <223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
 <148968b2-6d8e-476b-afee-5f1b15713c7e@kernel.org>
 <20240301092813.4cb44934@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240301092813.4cb44934@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/24 10:28 AM, Jakub Kicinski wrote:
> On Fri, 1 Mar 2024 08:45:52 -0700 David Ahern wrote:
>>> +	/* uint; number of packets forwarded via the nexthop group entry */  
>>
>> why not make it a u64?
> 
> I think it should be our default type. Explicit length should only 
> be picked if there's a clear reason. Too many review cycles wasted
> steering people onto correct types...
> 
> Now, I'm not sure Pablo merged the sint/uint support into libmnl,
> I can share the patches to handle them in iproute2, if that helps.
> Or just copy/paste from YNL.
> 
> I need to find the courage to ask you how we can start using YNL
> in iproute2, I really worry that we're not getting CLI tools written
> for new families any more :(

I need to find time to play around with the cli tool more; my attempts
last weekend were a bit rough hunting for the right syntax.

