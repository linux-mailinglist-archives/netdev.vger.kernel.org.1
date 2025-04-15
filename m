Return-Path: <netdev+bounces-182867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E17A8A31D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8227A3B1F16
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9A29A3F8;
	Tue, 15 Apr 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tiscmh5g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EAA29A3E9
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731624; cv=none; b=bzDDnbWAbObcbADyXoPeiJTLqkb2xBSPcONjgxRszc0bJkRcAsjVvAApqnjeJvgcrG8Yz87iXNDs3IuGRtmmWabU1cZuAG7XAv7aecH0wKtdu9Hb5hPFHuVSHoJQBRIP4os21Xl8glf7yvq5+vZtH+yCeqJYuW37GLQturCSRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731624; c=relaxed/simple;
	bh=PPd/dqC7rztIv5t2RUaA2dzU+3t/WNzF68jMOMUCsEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNNFPIto2Wee0+FNCRt2bgkgJc5AYoDIPQpQ5DYkgOjWly6OYR5xFzZWd8Q+FpO2JiPcTdiU2QcxWUshpVmvmCvy1U8X/qxYfVqVMabS94xo62yW8+ASL/sRFhXaXJBEmhuqPWa1hmdrkVoevgp+0orYoCj0FjN5yHQDnTHsWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tiscmh5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CE4C4CEEB;
	Tue, 15 Apr 2025 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731623;
	bh=PPd/dqC7rztIv5t2RUaA2dzU+3t/WNzF68jMOMUCsEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tiscmh5gsWj4g9+SFElbKu68qwDooF8XFinrrQd7QPx5W+G+yT3qqFOvSk9iuHTxB
	 coAK93wrNV2yH0KmJj4fn2omvqawSErQFxHJRAnvVMg57RBCJsClZRAKQbdEsBOeeb
	 rAJDcalsB1LFdbYOri2Eytt9ZYUukjfPfh3jkAWQPVS345yWSXI+oFyZRna0OOnclY
	 EFJ8siVHVeHjj5uB+9SR4IM51finNAObZB46MUnEqUYL7ZVi97dcmernrj34bwirYY
	 F3/v9sf48x0s2/RCD9dKJn7jtXkl6CL8NIgpjBy9AGFDwP6EALeeNubVZQ6OqyAqFe
	 GRleQhKubls6Q==
Message-ID: <555fa632-34e8-4191-ba3a-1f9a319629a1@kernel.org>
Date: Tue, 15 Apr 2025 08:40:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: fib_rule_tests: Add VRF match tests
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, hanhuihui5@huawei.com
References: <20250414172022.242991-1-idosch@nvidia.com>
 <20250414172022.242991-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250414172022.242991-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 11:20 AM, Ido Schimmel wrote:
> Add tests for FIB rules that match on iif / oif being a VRF device. Test
> both good and bad flows.
> 
> With previous patch ("net: fib_rules: Fix iif / oif matching on L3
> master device"):
> 
>  # ./fib_rule_tests.sh
>  [...]
>  Tests passed: 328
>  Tests failed:   0
> 
> Without it:
> 
>  # ./fib_rule_tests.sh
>  [...]
>  Tests passed: 324
>  Tests failed:   4
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_rule_tests.sh | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Acked-by: David Ahern <dsahern@kernel.org>



