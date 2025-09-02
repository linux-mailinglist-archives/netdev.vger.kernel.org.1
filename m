Return-Path: <netdev+bounces-218978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5F3B3F26B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FAC3AC7CD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 02:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6A82DE6F3;
	Tue,  2 Sep 2025 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGRxtjgj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B372D663B;
	Tue,  2 Sep 2025 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780696; cv=none; b=G5fgsk/dg4z2z40zJ/JO0oOZP/HZDKuqKz/RFU6BLx3iBbSC67kCUkNK8KTLT212jYs3ygQIr/L9Suis9ujtpflLmK64xC2oRMyHztXT7fAdkSXQMCVfnmU9Al0Nit2NDgCTAIMsllr7JvtXVU0qVYk4+xBtP3EOoytZxMxlO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780696; c=relaxed/simple;
	bh=G/rzjRZol/kD0wSeHNrbUYRAx5SpAB+8oMFXPQzZc94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FomFedfoF2uym+I3OAnITfd9r7DyP/EAQq/Tl/c4dNgQRjpQHVVD6He98wyyg4b/1EvHtEqqtdoLA4LO96+0I+f5UdUREdMBDVzpN+Ac1xl7CdVqauLZFDZuTXvKGkZK7EB5nVTsdkVoe9/1GvgLCRGDPRbXny9b/0+aBTOwzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGRxtjgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF88C4CEF0;
	Tue,  2 Sep 2025 02:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780696;
	bh=G/rzjRZol/kD0wSeHNrbUYRAx5SpAB+8oMFXPQzZc94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cGRxtjgjEeq9+D04G+DCKlvI4buGc+HlE+J2rHT5+aGBbSSsPK61dCgTFsq3QD1FR
	 hhP5zL8BY+ubI/CRuIAZ3jYvb4z9OcDwq9mLsumUBYSEHYgXzsiuDxJi96+ba+DdJR
	 vV0l2WFjyrX5Im9Hx29CyPLTwUHSi+BExYA6Z2c22nGWwYeHyZ8yQF3RIy3bm99zC+
	 4Ka81OrEY3IzaOVaVxyDcsGsV4q07M1m3n7U6Q6FU6D4F6h/klLN3Q0V9XTXHpbcnE
	 H+YbBMA+84huqvcVKTqUwvyJ1L58INXauEW6t2ywBz9JwiJ9kQCqx7MUebeBiC/nFU
	 toIwCCnQK3HzA==
Message-ID: <2ba001d8-9cae-44e0-9ba9-c2bbc8194a92@kernel.org>
Date: Mon, 1 Sep 2025 20:38:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] selftests: traceroute: Use require_command()
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, paul@paul-moore.com,
 petrm@nvidia.com, linux-security-module@vger.kernel.org
References: <20250901083027.183468-1-idosch@nvidia.com>
 <20250901083027.183468-6-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250901083027.183468-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:30 AM, Ido Schimmel wrote:
> Use require_command() so that the test will return SKIP (4) when a
> required command is not present.
> 
> Before:
> 
>  # ./traceroute.sh
>  SKIP: Could not run IPV6 test without traceroute6
>  SKIP: Could not run IPV4 test without traceroute
>  $ echo $?
>  0
> 
> After:
> 
>  # ./traceroute.sh
>  TEST: traceroute6 not installed                                    [SKIP]
>  $ echo $?
>  4
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/traceroute.sh | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



