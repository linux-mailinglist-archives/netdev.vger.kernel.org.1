Return-Path: <netdev+bounces-224590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E2B86704
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0A41C25036
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B182D29C8;
	Thu, 18 Sep 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5A2LmHN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112F34BA47
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220977; cv=none; b=Ox/tfD8cPV3fx3vgk8qbCoUJPYAywpLyQxQBN0ekM+ZDN6gp6uOTaAlZWjyy6bjie+pddxqB2M7rctGSTAUjqUmzAVIFjI95+44C6aTh6/5OH3WcpcXO835iMYdA0F1zDHNWLkvr77vhfR6MAD993uk1M2dTKE3bIFlty7Doyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220977; c=relaxed/simple;
	bh=Vr7NrQQZ6NHYMVOIxFwt3JMOI+Vf4YhPCmGmZXvIgaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0gX/Hk4/gYjjo1tQBHwqnoy/FV4sLRwf4+0nXwzxl/ltLCCwfdLQNtHUqwFNLHrIWgqaaV3FNMZ1ZsD83KtXbW+p7QmwQ65kZ9cFQ1TnPL3y+bsA5X2+ewIXNY3TIlijdPJYQow3BIW4DV+8rSV3IWLJoEU+lLrkV63crNlIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5A2LmHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0CBC4CEE7;
	Thu, 18 Sep 2025 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758220977;
	bh=Vr7NrQQZ6NHYMVOIxFwt3JMOI+Vf4YhPCmGmZXvIgaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K5A2LmHNMRPzzoWdI+PlKsdKtCzZJBwGnyya5wDzJ0AE7B6GzxNNFuUrxCE3krVuf
	 jAB49PMxcEHmz5+1l4zsxL9Wog6eNLcGceyeRSz4iTLI//jU6aksmL0EVzdAeGwI99
	 nEBjiAl1rB4tGqyNPq8/ZUVZ9mZ0yz7nyYbaE4jVfr1H5vs0v3bpu3m6Ig9V3Kkk78
	 YgZNLMOJtR88tfzY3WPVLMtcP5WPV4tiMuRGu594xcepz7zahLm0XM4ZWlUev5E65T
	 O/KTzo3i09PctheLvvewY2MxBuBhJkvAL4/v+gdpkre6R9xlmBtExKiGIr4eObvphd
	 Qp26HR1BET6Ng==
Message-ID: <ec2332ad-4af5-4762-a446-779a6b38ac1b@kernel.org>
Date: Thu, 18 Sep 2025 12:42:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: ipv4: simplify drop reason handling
 in ip_rcv_finish_core
Content-Language: en-US
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org
References: <20250918083127.41147-1-atenart@kernel.org>
 <20250918083127.41147-3-atenart@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250918083127.41147-3-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 2:31 AM, Antoine Tenart wrote:
> Instead of setting the drop reason to SKB_DROP_REASON_NOT_SPECIFIED
> early and having to reset it each time it is overridden by a function
> returned value, just set the drop reason to the expected value before
> returning from ip_rcv_finish_core.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  net/ipv4/ip_input.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



