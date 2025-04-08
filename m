Return-Path: <netdev+bounces-180329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9F3A80FB2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6AE8A6305
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB822333A;
	Tue,  8 Apr 2025 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgsfQ4YJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916541FCFF1;
	Tue,  8 Apr 2025 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125413; cv=none; b=HaoJDqxRtJe1hVGK7CviILi5/5JZdUgjZsFsqz8vOLGg0bps0Q0s2yjm/PN8k1ewEK5XTdo8Wlo8D94CZCDyMDX4uHD0RA3e33ggeUnJt7tokIPcyPIMW6oUWDKeB0gRzfmO5PAqHfMcXIK4MsYe+Vc5C6BFyh9+w706l7p35jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125413; c=relaxed/simple;
	bh=v7nE5Qxso0GfDO+ohqRXGHd38Cl4aufPArKIzY0z5uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvi76u2aCD8/Zc0tbsT6JtF8/LLa62l9kVA294s1nPSnl973Xn1sYecUFNwXIveQ+Ho88bo6/k4fwTVJxQHn8ljvbw/t9TohZAUu4lbBDG42W9sxz8Zknyc0NbHsOzSvhe3Egl4ayXHPlIOFBiyqzPeR5zDfQnGlyvGWoDyXj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgsfQ4YJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500E6C4CEE5;
	Tue,  8 Apr 2025 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125413;
	bh=v7nE5Qxso0GfDO+ohqRXGHd38Cl4aufPArKIzY0z5uY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MgsfQ4YJFufd2j4bbWzT9Xq+0gnUHgK/phZTfZO5JZLPgJ3yTbw3DDk647D1QMhrf
	 nLb8jogStSK/IK+L9Ik/zydDupjvsv163aeLSzvt5NjUhF5zMHwSlWNeWQMGyo8RP8
	 749lEuQNPyH1qhZEm1o9UMobn87WjfxODn0XIoOGTt4L+/5b0ax3MgzojX4nM05Jzm
	 5cIf2CEeEM97L5M+uncdSH1Pr2hOtAiiCeE4SXvJ+4J6c1xEqv6KxFYM42F88PrTny
	 eDZqIHt0j35/ADz0Tb9GHvo8m/TDdUpQ6SxWCzqydHtEAz+VaQt6k96OQIP9XuZbh1
	 bvtQSv2C8GlvA==
Message-ID: <b85ddaa3-6115-466c-8fc9-84b58d55e4b4@kernel.org>
Date: Tue, 8 Apr 2025 09:16:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] trace: tcp: Add tracepoint for
 tcp_sendmsg_locked()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, ncardwell@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com, rostedt@goodmis.org, song@kernel.org,
 yonghong.song@linux.dev
References: <20250407-tcpsendmsg-v2-2-9f0ea843ef99@debian.org>
 <20250408010143.11193-1-kuniyu@amazon.com> <Z/UyZNiYUq9qrZds@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <Z/UyZNiYUq9qrZds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 8:27 AM, Breno Leitao wrote:
> 
> 	SEC("tracepoint/tcp/tcp_sendmsg_locked")

Try `raw_tracepoint/tcp/tcp_sendmsg_locked`.

This is the form I use for my tracepoint based packet capture (not tied
to this tracepoint, but traces inside our driver) and it works fine.

As suggested, you might need to update raw_tp_null_args

