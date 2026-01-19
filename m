Return-Path: <netdev+bounces-251187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3ABD3B3F1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0D7D30BA5D3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04FC3A63E7;
	Mon, 19 Jan 2026 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGgVvr3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4038B9AE;
	Mon, 19 Jan 2026 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841006; cv=none; b=Zscq3zl9t7HaAQOipmMowiUYXr3cBHdcB98NXXQroSFLFZDaDmzlqVcxQQEJue8SG/BOLTcHvNSDzh2+qy+ecxGIDcqHerxxvWYGAxIZzgHufAQMml7zumlvrxTP6FdV7Iml2tGlcSuk+ciNH945XAL0KnmSgSn5wa68YV7S8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841006; c=relaxed/simple;
	bh=Blmndc2F8IpoDSrgJIam/viSIzwukGW+2zxBHD8tcAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiVGMdq9DJOSqPvuwb9qdSxL2w2hQIX5/NtF+3RqzC0WhT9Ga1MWiQocu2Ruo24p2VWD0vTJVpojqYX9ITWu1P8vQ5PEhb0oK4rpVsCUdsRIUwG3QERm8utPUbFIQDwBEEZJcSLDa5fnxtSYPEB68k2PgcbF2z/UmW/uyNScekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGgVvr3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21EBC116C6;
	Mon, 19 Jan 2026 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768841006;
	bh=Blmndc2F8IpoDSrgJIam/viSIzwukGW+2zxBHD8tcAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DGgVvr3XuCa10j115khZv3duq9vhJQdbvzoN3BQO4pOAUuZznWNMNhUeaG58wZfmN
	 vnuiKbhVbDyxlwOZN6aDMktTICaHJ9YwUB7ic8agnOfISs+1EGjzA4PyqeyohjykFS
	 BUDJErre1jjFdsRaekzdC9IOEGd5i+Zok1q2AMQaDgBgCSMSxCrfOObhOy5ciHcZWU
	 H0lA1bMKf0YEABczAh7wjN7NKxM4OAKdTHxRl5ofNtonKuy5efPyUc4rZ3XRdO8woT
	 QoqWy60DodlLtvB/kX/N405k3ODTMX9araSE5mvJ24FCZZllmqGO+BbAc+Bh4O70mf
	 l6jMTabE60tWA==
Message-ID: <47152311-1357-44f8-ae12-61e4850e62c6@kernel.org>
Date: Mon, 19 Jan 2026 17:43:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] page_pool: Add page_pool_release_stalled
 tracepoint
To: Jakub Kicinski <kuba@kernel.org>, Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, kerneljasonxing@gmail.com,
 lance.yang@linux.dev, jiayuan.chen@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Leon Huang Fu <leon.huangfu@shopee.com>
References: <20260119102119.176211-1-leon.hwang@linux.dev>
 <20260119083759.5deeaa3c@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260119083759.5deeaa3c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/01/2026 17.37, Jakub Kicinski wrote:
> On Mon, 19 Jan 2026 18:21:19 +0800 Leon Hwang wrote:
>> Introduce a new tracepoint to track stalled page pool releases,
>> providing better observability for page pool lifecycle issues.
> 
> Sorry, I really want you to answer the questions from the last
> paragraph of:
> 
>   https://lore.kernel.org/netdev/20260104084347.5de3a537@kernel.org/

Okay, I will answer that, if you will answer:

What monitoring tool did production people add metrics to?

People at CF recommend that I/we add this to prometheus node_exporter[0].
Perhaps somebody else already added this to some other FOSS tool?

--Jesper

[0] https://github.com/prometheus/node_exporter




