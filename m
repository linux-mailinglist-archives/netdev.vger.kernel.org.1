Return-Path: <netdev+bounces-41028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF757C95AC
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43662B20BBC
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B31D698;
	Sat, 14 Oct 2023 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI8Eqp1u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D2224DD
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C33C433C9;
	Sat, 14 Oct 2023 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303995;
	bh=Tdn/lgbmNNfEWv1MrUZkmKcklbp5g0/qGrE1S1yYFi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MI8Eqp1ud1ZcuClLpnCyK3k1+RTlGbHNX0qVAefOaM5FxC4BFpcv8M8UL67z2Sku+
	 heu9E5bcYJn5+FteGl3ejDH1k4y+2SCRG9ZxxLt6T4KyE3VcRDfYrVsm/XGdBMBnC6
	 b5/Gmj78DuPu1BBdxLPHVyZfW4G6ipxJWNj2tbXrJapc8JR9c0qvCqLjGUyA7z1xdp
	 8HSucIpsTmA0V0n4qvWN9aysbbNWY8a1A84/MIBCm8KPplsKoHN7584+Z2ECi/r36G
	 AM4z+ir4vcYdTwWJ8mm/0sRNAJrXo21uD8qsrmBBLYSp5T0jsPqBswvBRCKf+5B87A
	 CZ+WJYEcXkijQ==
Date: Sat, 14 Oct 2023 10:19:55 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-10
Message-ID: <ZSrNu+3yXxa5q4yv@x130>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231013181019.1c8540dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231013181019.1c8540dd@kernel.org>

On 13 Oct 18:10, Jakub Kicinski wrote:
>On Thu, 12 Oct 2023 12:27:35 -0700 Saeed Mahameed wrote:
>> v1->v2:
>>   - patch #2, remove leftover mutex_init() to fix the build break
>>
>> This provides misc updates to mlx5 driver.
>> For more information please see tag log below.
>>
>> Please pull and let me know if there is any problem.
>
>There are missing sign-offs on the PR and patches don't apply
>because I pulled Leon's ipsec branch :(
>

Thanks ! just sent v3.

