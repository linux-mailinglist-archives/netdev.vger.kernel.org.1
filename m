Return-Path: <netdev+bounces-20002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39475D54D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 22:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E67282455
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA78423BC3;
	Fri, 21 Jul 2023 20:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3122F1E
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 20:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5900BC433C9;
	Fri, 21 Jul 2023 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689969665;
	bh=EqrevjWJXEX2uI/wWrGnSTIWi02WPnapbwsT0JNyJtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hFOM/dq1sc7GRhffeqkQrd74tuUbxxYNR5D8VNYWSuA5ycodclel9klwkNZcZbt5d
	 M81YKkBTge4RhKQJUVZed1JFvp0oOcPgc5b/NyjkncVn0fzD6ugPRgW1P0kjirt5QU
	 64QgrRQKQ348NDz84ktfXXv+KSE+RnSCTo/AyrRB9L6b4XKHHtwKqr607WnhCKCzCm
	 WGnVCS4lBAczbVIyGizrRlTj5Jg0aiSmV61tA9QA0RNUDZ/hkY5RExHk4KWkfdvHxM
	 WmAQXMUjglb/1HEfI/iiGpwQ3QGHB3cQdr1t45boI40ENztKk5yqIAvBsTIjQgYpFt
	 UOP+WXsxVme6Q==
Message-ID: <0b992d26-f22d-7310-308a-339300628690@kernel.org>
Date: Fri, 21 Jul 2023 14:01:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
 <20230718180321.294721-3-kuifeng@meta.com>
 <9743a6cc267276bfeba5b0fdcf7ba9a4077c67e1.camel@redhat.com>
 <3057afe9-ac48-84e2-bd39-b227d2dcbc2f@gmail.com>
 <239ca679597a10b6bc00245c66419f4bdedaff83.camel@redhat.com>
 <03ef2491-6087-4fd4-caf7-a589d0dfda13@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <03ef2491-6087-4fd4-caf7-a589d0dfda13@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/23 12:31 PM, Kui-Feng Lee wrote:
>>
>> sysctl -wq net.ipv6.route.flush=1
>>
>> # add routes
>> #...
>>
>> # delete expired routes synchronously
>> sysctl -wq net.ipv6.route.flush=1
>>
>> Note that the net.ipv6.route.flush handler uses the 'old' flush value.
> 
> May I use bpftrace to measure time spending on writing to procfs?
> It is in the order of microseconds. time command doesn't work.
> 

Both before this patch and after this patch are in microseconds?


