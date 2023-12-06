Return-Path: <netdev+bounces-54607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A0A8079DF
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416BA281B15
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34C247F42;
	Wed,  6 Dec 2023 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiFLLP5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985204B13F
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 20:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127ADC433C7;
	Wed,  6 Dec 2023 20:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701896295;
	bh=wQoHAsfKd3Ap4eDwOKHBUKCt3pMAGwhoLKepR7VTZ7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiFLLP5/RGiv4jQFgUc7wc8ed1sAkBVLXvhK5Jsc374Q5vdrdp7PqEa6KopFYJLgj
	 ME61hTawoF5cxUMljC/m7e/U3Yawni1BJB4w1TybczRYvjSqllZjHXRPn8wN5H0N3k
	 LMFTSXbmsmgW8En6YvFqpv74+8mPI+UC9NpVL2UhRJk5ZZ8DrjIDRisQQ272aP1Av2
	 SCVXhYS3C9GTcoyoxH8qPfeMSh0t6voE9VmMvjS/oBpFdvcK/1ZAW6OUcaNg/WG0bW
	 HPr1uC4jXczZGsHWVXkBrUQySmnMsDfgSn/0ak8S0GRCzko9oWmAbP4VIy1lJIPesA
	 QqxIutrOA3MJw==
Date: Wed, 6 Dec 2023 12:58:13 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net V3 00/15] mlx5 fixes 2023-12-05
Message-ID: <ZXDgZV84L-oZDHr2@x130>
References: <20231205214534.77771-1-saeed@kernel.org>
 <20231205144857.5b7297ac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231205144857.5b7297ac@kernel.org>

On 05 Dec 14:48, Jakub Kicinski wrote:
>On Tue,  5 Dec 2023 13:45:19 -0800 Saeed Mahameed wrote:
>> V2->V3:
>>   - Drop commit #8 as requested by Jianbo.
>>   - Added two commits from Rahul to fix snprintf return val
>>
>> V1->V2:
>>   - Drop commit #9 ("net/mlx5e: Forbid devlink reload if IPSec rules are
>>     offloaded"), we are working on a better fix
>>
>> Please pull and let me know if there is any problem.
>
>Why are you reposting this without waiting 24 hours?

V1 is more than a week old.
V2->V3 which you have an issue with, has no change other than removing 1
patch and adding 2 more patches that were already reviewed on the list
for more than a week as well.

This is a PR of patches that were already reviewed on the list for way
more than 24hours.

Anyway, do you want me to RESEND ?

Thanks,
Saeed.

