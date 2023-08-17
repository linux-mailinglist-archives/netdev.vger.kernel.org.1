Return-Path: <netdev+bounces-28532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7162A77FC32
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305F8282087
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F114F65;
	Thu, 17 Aug 2023 16:37:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C414289
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21499C433C7;
	Thu, 17 Aug 2023 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692290240;
	bh=4nnZ7Rb2Mi2laP13us7rhR18j9Ow7P4tsFtYHbIuMrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7fKv20of2ZSWJV+qRNCKXUydMSkh9qjqt7ohuFCL35vXw8fMFJmxnZnSM1+Z6UF7
	 xB9nyu48oD7IjRHP1VC3pjycmD+QlFio8ObOjXQ9noBfe+fziBx0V60KAyr8GqcztV
	 BxKbAzhYRUNvmV78G+qmhdhvzT55kk4O45VOxO8uPbM2kwu3+JgqgeUWcuZTn3UVg7
	 /mR1iXPDBTAsNHF0dIW+l4EJ/ux6Bz093bybh/V5tt1FPme9qGRA0khK5WURpyDvC8
	 9dIOWSSa7mGkxtWapALktd2DGy/iOc/WeMtU4AxYq81aiQAO6C3qMt7GcBzxB4l/FY
	 aBtcZoIZG49Kw==
Date: Thu, 17 Aug 2023 09:37:18 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Vadim Fedorenko <vadfed@meta.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Bar Shapira <bshapira@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value to
 improve ptp free running mode precision"
Message-ID: <ZN5Mvh9c+joFcJbb@x130>
References: <20230815151507.3028503-1-vadfed@meta.com>
 <20230816193822.1a0c2b0c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230816193822.1a0c2b0c@kernel.org>

On 16 Aug 19:38, Jakub Kicinski wrote:
>On Tue, 15 Aug 2023 08:15:07 -0700 Vadim Fedorenko wrote:
>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>> This reverts commit 6a40109275626267ebf413ceda81c64719b5c431.
>>
>> There was an assumption in the original commit that all the devices
>> supported by mlx5 advertise 1GHz as an internal timer frequency.
>> Apparently at least ConnectX-4 Lx (MCX4431N-GCAN) provides 156.250Mhz
>> as an internal frequency and the original commit breaks PTP
>> synchronization on these cards.
>
>Hi Saeed, any preference here? Given we're past -rc6 and the small
>size of the revert it seems like a tempting solution?

Rahul's solution is also very small and already passed review, we will be
conducting some tests, share the patch with Vadim for testing and I will be
submitting it early next week.

>

