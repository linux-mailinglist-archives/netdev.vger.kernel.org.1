Return-Path: <netdev+bounces-39601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AAA7C0046
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DCE28166E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287E27448;
	Tue, 10 Oct 2023 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g34fVlju"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011F27446
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3B0C433C7;
	Tue, 10 Oct 2023 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696951288;
	bh=V7L1P+EZAtwdElzEwCGdF7YC48NTaOOFglzR1FdvmzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g34fVljuX4kOTXEop7zYvN91Z9/vKbmPqqSwEWORPb9Fju1zboNr/YIyujP9fLqYt
	 f6XAMeuVM1hPAzOwcQu/TQ5Pokj59WN+LV+bldPQ/HkSBY4zcLhLjhg/mWs7y6IdVQ
	 2gmOtUcX18tzbikqhgSAqG1uAqzAhq155NDEH5D4h54i8AFRnTzo7b62poxev5YzjE
	 D70dgUxDbICIVoMzm2MB0ws0EoVkxu/y7leBOy4RAE/NG5jTKx6hQ2P3T5Jb5Ttc5m
	 SvtyMmYivHsnSArykDPtLfY82ZSIf4iJpHtPskhfZ4Dc2+gabUlTTDCb7xtaUKq/jn
	 dtu4hBzFx8Wrg==
Message-ID: <e482309c-acd7-02af-b405-6b9ac04387a9@kernel.org>
Date: Tue, 10 Oct 2023 09:21:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 1/2] selftests: fib_tests: Disable RP filter in
 multipath list receive test
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@gmail.com, sriram.yagnaraman@est.tech,
 oliver.sang@intel.com, mlxsw@nvidia.com
References: <20231010132113.3014691-1-idosch@nvidia.com>
 <20231010132113.3014691-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231010132113.3014691-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/23 7:21 AM, Ido Schimmel wrote:
> The test relies on the fib:fib_table_lookup trace point being triggered
> once for each forwarded packet. If RP filter is not disabled, the trace
> point will be triggered twice for each packet (for source validation and
> forwarding), potentially masking actual bugs. Fix by explicitly
> disabling RP filter.
> 
> Before:
> 
>  # ./fib_tests.sh -t ipv4_mpath_list
> 
>  IPv4 multipath list receive tests
>      TEST: Multipath route hit ratio (1.99)                              [ OK ]
> 
> After:
> 
>  # ./fib_tests.sh -t ipv4_mpath_list
> 
>  IPv4 multipath list receive tests
>      TEST: Multipath route hit ratio (.99)                               [ OK ]
> 
> Fixes: 8ae9efb859c0 ("selftests: fib_tests: Add multipath list receive tests")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/netdev/202309191658.c00d8b8-oliver.sang@intel.com/
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



