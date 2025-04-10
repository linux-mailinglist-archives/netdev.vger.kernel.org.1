Return-Path: <netdev+bounces-181316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0BA84679
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E2F3A3FD0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE6C28C5A1;
	Thu, 10 Apr 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r59kqoDk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4B14F9D6
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295651; cv=none; b=H0l+louaQuDYtqXvxLyhwq/JcWnjz0essvSV0t9rVCKcucngbfrvvhzytUKMdHzDjv75UvBaKCzfTaut2ZUlq3Ej+xPebBet0jy0BQS6CFJhIZzz54kvjZAIWw8iPvBVwcsYsghWW3JBMFzliY4y1OXJyTmysa6xaH/EP4U1+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295651; c=relaxed/simple;
	bh=ePhY5t6pBMUMM5fcX6rcUE9HAp1q2kNqQKD5e8sCChA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7EM8jS/FBTyuRjXh3pq4YVQU+nvP2AF24P/scLBySl8OLE8a9NrI34Rf6UDw0bBseueVGD7TkeRf8LxO9xkCcnqH0pOHo8HGbSGmnv6RTpyhe1UKlI7NvIJreQSQHo5yiTKxXYoTUVmBXGUT1+NRd5euvWFHcZ9TYb5Z3jHszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r59kqoDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CAEC4CEDD;
	Thu, 10 Apr 2025 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744295649;
	bh=ePhY5t6pBMUMM5fcX6rcUE9HAp1q2kNqQKD5e8sCChA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r59kqoDk6sbxu0eD1MOiYrWp5F1G7oeFAVR0efIGWxFLuEo0WBMKwXhXaqbRTqz82
	 CsNonV81jBNe4xHcSFZ7VsXimDxLSR6wk0Sn2N2m5dUduU98hFjRSxbVxIzcqNiqe1
	 bbdvHVt+HYSWKr5pr9SYpbLMmTzjLvh6Ym9HgW+AXItJ1QPEOuz2yzeMlXt7g2cV+K
	 Ql/q3/NL1QrKzmnX6lop1t1fOswcdJ1MG4FK19tYwn0kpYmuNDEh8/otfcQdKBFBMI
	 GuD579f3yU8S6w4hXIVy3BlXgaPe+xe9Po/Hml0/M//+oYq/18HbC2mUf7OSyDI2Sz
	 4q5HN9U07oBgw==
Message-ID: <d2b7a049-97f1-4f4e-8f00-6cfa9a52a0c6@kernel.org>
Date: Thu, 10 Apr 2025 08:34:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 04/14] nexthop: Convert
 nexthop_net_exit_batch_rtnl() to ->exit_rtnl().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250410022004.8668-1-kuniyu@amazon.com>
 <20250410022004.8668-5-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250410022004.8668-5-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/25 8:19 PM, Kuniyuki Iwashima wrote:
> nexthop_net_exit_batch_rtnl() iterates the dying netns list and
> performs the same operation for each.
> 
> Let's use ->exit_rtnl().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: David Ahern <dsahern@kernel.org>
> ---
>  net/ipv4/nexthop.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



