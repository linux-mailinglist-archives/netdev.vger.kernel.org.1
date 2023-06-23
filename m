Return-Path: <netdev+bounces-13302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A106673B2ED
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24211C21021
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D031388;
	Fri, 23 Jun 2023 08:51:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897010F7
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 08:51:47 +0000 (UTC)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80B9172D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 01:51:44 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 846FF24002A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1687510302; bh=B1c7aclKQlYnbAu4S2v+VVqp1E6daoHU8MjvPcNrGNA=;
	h=MIME-Version:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
	 Message-ID:From;
	b=g/FFazuPoHXK0hRGWywrWG3suHsNGWkJB0tV+CHSY+gdr7TjUDRy7KN1VoyTCfnq8
	 1ypKDAbljvq19ZK6620XsQ1i5hPA3HdwyGEDf3YhJOXQ34v8zCBZfLPMZb6zKOfpVZ
	 dSQVS65rds9WP31vcLE6imHgkknbx7ZrCk3gHFhQSXxnGgLpUNmT1zmLom2dVAX1u/
	 9INrxqC0tJIMaVAiDcpNoj4XQqBGV5Odt+O9t1TLgwbpnMTi+mhI04yVrHy4ohKSE2
	 7UWn8h3J10tUu8s0xUHXYGPzkFD57BOLQfggmKBqXj4gtbL/QcXthHPvBNA4gmXmPL
	 p+BcoUxt7Z13g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4QnWF755Jkz9rxQ;
	Fri, 23 Jun 2023 10:51:39 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2023 08:51:39 +0000
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: jgg@ziepe.ca, leon@kernel.org, anthony.l.nguyen@intel.com,
 davem@davemloft.net, kvalo@kernel.org, jejb@linux.ibm.com,
 pabeni@redhat.com, apw@canonical.com, joe@perches.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Fix comment typos about "transmit"
In-Reply-To: <168748862634.32034.1394302200661050543.git-patchwork-notify@kernel.org>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
 <168748862634.32034.1394302200661050543.git-patchwork-notify@kernel.org>
Message-ID: <50a88781b9e2a80588438c315167bbec@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear Maintainer,

On 23.06.2023 04:50, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 22 Jun 2023 01:26:21 +0000 you wrote:
>> Fix typos about "transmit" missing the first "s"
>> found by searching with keyword "tram" in the first 7
>> patches.
>> 
>> Add related patterns to "scripts/spelling.txt" in the
>> last patch.
>> 
>> [...]

Thanks for merging!

> Here is the summary with links:
>   - [1/8] RDMA/rxe: fix comment typo
>     (no matching commit)
>   - [2/8] i40e, xsk: fix comment typo
>     https://git.kernel.org/netdev/net-next/c/b028813ac973
>   - [3/8] zd1211rw: fix comment typo
>     (no matching commit)
>   - [4/8] scsi: fix comment typo
>     (no matching commit)
>   - [5/8] tcp: fix comment typo
>     https://git.kernel.org/netdev/net-next/c/304b1875ba02
>   - [6/8] net/tls: fix comment typo
>     https://git.kernel.org/netdev/net-next/c/a0e128ef88e4
>   - [7/8] selftests: mptcp: connect: fix comment typo
>     (no matching commit)
>   - [8/8] scripts/spelling.txt: Add "transmit" patterns
>     (no matching commit)
> 
> You are awesome, thank you!

Should I rebase the local branch onto netdev/net-next/main
and send the "no matching commit" patches again?

Best regards,

Shamrock

