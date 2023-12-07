Return-Path: <netdev+bounces-54973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA688090F8
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5FA281397
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AB34E1B1;
	Thu,  7 Dec 2023 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq5XZapu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB246B88
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 19:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2B0C433C8;
	Thu,  7 Dec 2023 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701975800;
	bh=Ea9a/a8gzYPY9DbBH6+MQEiyHLiyFaH3pQrUJrTTucw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eq5XZapuQN9MwAbLmMJHGS7E0PilIuc40vXgHSoG4trJjYRdiefShKCEJ7Snnt0OH
	 sE3xBtYL9Pnxmo53r+iJyAVgoylKwEQJ4qd7L6Dw4atDGkuzTQ4DwgXPjootVpb8JI
	 bn0kd1M3Aos9XfLQ+hm0cpM9keLKWbOJ6a5sVUdJ/dwBqm+ErQWZSMd7JcOzdU2z4k
	 +Nylq2z8S/yh0qQIc1A+UV/vzQsrw0o2rILDom6FGCRPAt5VzevNCGouTh9zZOGNyP
	 YlLYV21f37+haXn6J4m2fv1o3ikYua7n3YOo4rYcqKddhuCqlN2zw76qAzx3d6obDy
	 spuwQ2Qy69Ucw==
Date: Thu, 7 Dec 2023 11:03:20 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net V3 00/15] mlx5 fixes 2023-12-05
Message-ID: <ZXIW-JRQY3wemWNm@x130>
References: <20231205214534.77771-1-saeed@kernel.org>
 <20231205144857.5b7297ac@kernel.org>
 <ZXDgZV84L-oZDHr2@x130>
 <20231206184150.64bf029e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231206184150.64bf029e@kernel.org>

On 06 Dec 18:41, Jakub Kicinski wrote:
>On Wed, 6 Dec 2023 12:58:13 -0800 Saeed Mahameed wrote:
>> V1 is more than a week old.
>> V2->V3 which you have an issue with, has no change other than removing
>> 1 patch and adding 2 more patches that were already reviewed on the list
>> for more than a week as well.
>>
>> This is a PR of patches that were already reviewed on the list for way
>> more than 24hours.
>
>The same rules for everybody. Please don't repost within 24h,
>unless someone of import tells you to.
>

Ack.

>> Anyway, do you want me to RESEND ?
>
>I guess that'd be counter-productive. I'll revive it tomorrow,
>no need for a resend.

Thanks !

>-- 
>pv-bot: 24h

