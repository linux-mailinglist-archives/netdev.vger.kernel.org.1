Return-Path: <netdev+bounces-180454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42DDA815D4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC00D7A8449
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A4243958;
	Tue,  8 Apr 2025 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpacp7lY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180712405F5;
	Tue,  8 Apr 2025 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744140754; cv=none; b=twEBVeLMNrcketxJEhT1UI5QDzTg9pPVNLakZIO6vXCorNHO1FJE3wtua5uE9+BGxQM69T+sLRBxH6G2imZeAvZUpVgtkR1mIoxtRp6x3Ccei14kNBSkfUz6ioXw/CtP2qEW4WbViEbqIIrbB50UkRLgBdmvQpPe4PArVsODSwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744140754; c=relaxed/simple;
	bh=W2dDfp+6u530Uuogb1eaOEl6QW1bQx+CZ05zi1+pviA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQu35ere/I5bIk7L9OgjztKdtL+iHajrIf7eJG7UgBG1vZuL3/JZAvzAi+qRmhhMXGB1CewVVh134ODjOboYrEEUJQyc3MXFtLRXc+fXLng4Qj3nM7E/RajIoICO/jdBazzVmsnuLl3GoSeLqLnukj/wR8IG5CscyitTEQbWfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpacp7lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF541C4CEE8;
	Tue,  8 Apr 2025 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744140753;
	bh=W2dDfp+6u530Uuogb1eaOEl6QW1bQx+CZ05zi1+pviA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kpacp7lYjuknjeAUWo5lS7cD5D5R+2q49I1ToQQmf3CwzY2vKGxLFvIl/+yMDjTND
	 8z/bPR/98nlFDyN1yZUcQgYmuybBx4nVHL8XDlMtMNzVYgzxRIRMaVjImdkTzM37+L
	 SmfNM2mC1lkqirTYweGVBb2sYCFaozT69SxJG/q6J7Tew2e5jc9xxUDJ5psd+akeHH
	 pOZ3YS//QOzJveCqT9R1ZkBg+drHdvnvOvi4re2ewjDrV8Ko/0DJlG7p/yRxzahwXQ
	 nfJFLIORTZjE+OTzvN8e24ILmdssYNetW2JarrgM5ZJNKk1FuE8lLHbA/ga07uFNZh
	 7SVSbMgh7g4Fg==
Message-ID: <fcf2d508-d44e-43c3-b381-8f33fec11859@kernel.org>
Date: Tue, 8 Apr 2025 13:32:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] trace: tcp: Add tracepoint for
 tcp_sendmsg_locked()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
References: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org>
 <20250408-tcpsendmsg-v3-2-208b87064c28@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250408-tcpsendmsg-v3-2-208b87064c28@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 12:32 PM, Breno Leitao wrote:
> Add a tracepoint to monitor TCP send operations, enabling detailed
> visibility into TCP message transmission.
> 
> Create a new tracepoint within the tcp_sendmsg_locked function,
> capturing traditional fields along with size_goal, which indicates the
> optimal data size for a single TCP segment. Additionally, a reference to
> the struct sock sk is passed, allowing direct access for BPF programs.
> The implementation is largely based on David's patch[1] and suggestions.
> 
> Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/trace/events/tcp.h | 24 ++++++++++++++++++++++++
>  kernel/bpf/btf.c           |  1 +
>  net/ipv4/tcp.c             |  2 ++
>  3 files changed, 27 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



