Return-Path: <netdev+bounces-176485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E9CA6A888
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3784C1B64AA5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E04225407;
	Thu, 20 Mar 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv7nNr6G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE6224AFA
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480430; cv=none; b=BqxiCUQuNvb8qAf79SyJl+oLMFUavlk6Ee+6g/IJf6tXPKDmIzCzYVqHbGPFm0zrCWzS6xdxRggG34l8xlB3WjCk8FLEl1zvbT0qtcKXxUYRljZfrgP3I86tRx3zjmi53nV7hNoRCgkYAHl12RaVNaCRSdry9QKH8FquLPTReMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480430; c=relaxed/simple;
	bh=/gQ2PpBMOtuhzS7MOd7FrwkCv/VClU9YfP2AXCiqZbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPUVycd1Fn5HUAP+1k2JBAVNypCqvubfRbzAz/ylu5WPoB5E/J4JMI0EH5Wyx/5o/CF0zaDASBwu4mOO6ufWW0Z7zExICceNzx7ESrF5rgsy8h8Lsd4PgLguH5kOPeDs5kXQG1pQvUpGJ7TaPh2qLdCPuHAh6WSZTSqaRopxSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv7nNr6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708FFC4CEE3;
	Thu, 20 Mar 2025 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480429;
	bh=/gQ2PpBMOtuhzS7MOd7FrwkCv/VClU9YfP2AXCiqZbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cv7nNr6Gi4pW6pXfQCygeifxQvynx0+jNleD4mi7lDru903tXeb1gYp8V0JUpnh9R
	 gFCSeTDgsT6tbiyUmn7yD2l9WS8NhYrilfz16lccaTHPSHCYCQTPWOe36gTfi8WCV2
	 SHCEukeogd0fQxfXJUipKNUqRKUEUeFfwZxqtBvuI5/eJrR+ADiK9OSY80gHtIvh/L
	 W+9I9U4Oo2CZRxMBL37BPsMNbP1PyE417sIhGesRFvbsYRi+mOd+Yqlu2FqJUey1IF
	 B/2Gxjf3LvbsNsgdSEcb8rs5UipV5LFUZ5fl6Mr587fqTBl13iWYHAxJKiydP6ZHwS
	 4BRSD3aTyshnw==
Message-ID: <95fa22b7-89f4-478e-8061-8f161b392d72@kernel.org>
Date: Thu, 20 Mar 2025 08:20:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/7] nexthop: Check NLM_F_REPLACE and NHA_ID
 in rtm_new_nexthop().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250319230743.65267-1-kuniyu@amazon.com>
 <20250319230743.65267-5-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250319230743.65267-5-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:06 PM, Kuniyuki Iwashima wrote:
> nexthop_add() checks if NLM_F_REPLACE is specified without
> non-zero NHA_ID, which does not require RTNL.
> 
> Let's move the check to rtm_new_nexthop().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/nexthop.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



