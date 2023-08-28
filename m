Return-Path: <netdev+bounces-31103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F478B7A8
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 20:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C6C280EBA
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B03713FEF;
	Mon, 28 Aug 2023 18:57:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED529AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 18:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42181C433C7;
	Mon, 28 Aug 2023 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693249041;
	bh=lHQWUIGPBs3/A8CdAI4l/jbbdBYxLqQ8A2lhdNBEVfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZCadsNZxlGDGpGa6XJH546B0ODhgLEfTmy08o6mWMCPnNV7mIwGmC7jBOH/Gozu11
	 +dST19qPTlm7TN4twVIHgnDSyHUFnV722IjFxBb/FAm3uORnEMOsizquhX2i80I3YU
	 6oCv3TqW/pSTFh/z97eGbTlCVhFNsg/+LYIqkmam8V1nZVCKI5Ke1uHS7fk9//r1av
	 JS6l9w41IXoLweaA81JP/FIex0jaFkoRjfHB3P1jL5Wwjs17dJfEd8LsVstdO5CyTm
	 yFQOanVjMD3cjNNfHrpHAe9wR4YlLFDoQcWxkxPK5DB6vfXTneXnmzmcg3f6L9KWIZ
	 umuldV564dHDA==
Message-ID: <a2d78f3e-b1a4-1309-c7a4-7198fc26f9cc@kernel.org>
Date: Mon, 28 Aug 2023 12:57:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net v3 3/3] selftests: fib_tests: Add multipath list
 receive tests
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-4-sriram.yagnaraman@est.tech>
 <ZOy8JOjw9W4g8fYa@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZOy8JOjw9W4g8fYa@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/23 9:24 AM, Ido Schimmel wrote:
> On Mon, Aug 28, 2023 at 01:32:21PM +0200, Sriram Yagnaraman wrote:
>> The test uses perf stat to count the number of fib:fib_table_lookup
>> tracepoint hits for IPv4 and the number of fib6:fib6_table_lookup for
>> IPv6. The measured count is checked to be within 5% of the total number
>> of packets sent via veth1.
>>
>> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> I just tested this with a debug config and noticed that the single path
> test is not very stable. It's not really related to the bug fix, so I
> think you can simply remove it.
> 
> Jakub / Paolo, this change conflicts with changes in net-next and I
> assume that the next PR that you are going to send is from net-next.
> What is your preference in this case? Wait for the PR to be accepted and
> for master to be merged into net?
> 
> Thanks

Ido, thanks for staying on top of this change and the details with the
test cases.

