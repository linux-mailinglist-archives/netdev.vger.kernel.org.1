Return-Path: <netdev+bounces-96209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D028C4A6A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ED228287D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F51537E;
	Tue, 14 May 2024 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY6CfJ0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068F7EF;
	Tue, 14 May 2024 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646250; cv=none; b=ag1mbY+X+3LLFLJ/56jU+8nGruWiPctN59yz067uFsIP2s0NAxccdRmpiTlJKNipKT3YagV0XxOPvJY9VzOfNNNKsBYwf8L0KT0HAeAHVG/jCgAEdRIZG7wXROuEr+17Hok+fx1delfTMxTNgvwuNH6G0eIvNPjzMQYoKt8UaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646250; c=relaxed/simple;
	bh=NW6vEkjncf0dhMOgViKtjptdXYcJxVIDHjLO2k1Cf+4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VWPS2sKPuhrXlZgGDTjAhucQ5Elgm7XUmb3LaYAr5CSMdom+Ztf2V0YAxFV/yZqEcVAGRq3HQbmJMIVp0hqce9/awcMec/nekKe46Rworq5CXJ/W9RMtFNqAzK9Ff3zJEfDWhRrUqgKEFWa8bO7DmFCjFR6RQ2kPF4UG/HOIRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY6CfJ0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE084C32781;
	Tue, 14 May 2024 00:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715646249;
	bh=NW6vEkjncf0dhMOgViKtjptdXYcJxVIDHjLO2k1Cf+4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YY6CfJ0PGVF7B07+H/k3VNW6PimUAYUiQdS6YEcxDPuL8N9zcSOblOZsgD0udZvGf
	 r5Xx7oAu0YKMiNsw7SnrcedNr7F5Hy0u5mZmKPluFT5/OBNvgC1P6UKgf02CI2tYQ5
	 8RWabP++zrcR2Od/WO54fvExmWwHQoqFoxUgJRQ+XyOYEajbjtBJz8eg4phc3lxzJ8
	 HUDqFHudSiJigaMKkHnC5KXcbo+aUEIzpYxR66oEa0XlH5nCWOPUHuUZsHHHR+DZnT
	 S2A/igTGxG3MQFRn5GEWZNAFpfvIZAhcSDSCztGLFrlmHSRzA5is/nYbGUuDBb3dgV
	 D3JCyDb+IiYEw==
Date: Mon, 13 May 2024 17:24:08 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
    Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Gregory Detal <gregory.detal@gmail.com>
Subject: Re: [PATCH net-next 0/8] mptcp: small improvements, fix and
 clean-ups
In-Reply-To: <20240513160630.545c3024@kernel.org>
Message-ID: <f60cac35-5a2b-16cf-4706-b2e41acfacae@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org> <20240513160630.545c3024@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 13 May 2024, Jakub Kicinski wrote:

> On Fri, 10 May 2024 13:18:30 +0200 Matthieu Baerts (NGI0) wrote:
>> This series contain mostly unrelated patches:
>>
>> - The two first patches can be seen as "fixes". They are part of this
>>   series for -next because it looks like the last batch of fixes for
>>   v6.9 has already been sent. These fixes are not urgent, so they can
>>   wait if an unlikely v6.9-rc8 is published. About the two patches:
>>     - Patch 1 fixes getsockopt(SO_KEEPALIVE) support on MPTCP sockets
>>     - Patch 2 makes sure the full TCP keep-alive feature is supported,
>>       not just SO_KEEPALIVE.
>>
>> - Patch 3 is a small optimisation when getsockopt(MPTCP_INFO) is used
>>   without buffer, just to check if MPTCP is still being used: no
>>   fallback to TCP.
>>
>> - Patch 4 adds net.mptcp.available_schedulers sysctl knob to list packet
>>   schedulers, similar to net.ipv4.tcp_available_congestion_control.
>>
>> - Patch 5 and 6 fix CheckPatch warnings: "prefer strscpy over strcpy"
>>   and "else is not generally useful after a break or return".
>>
>> - Patch 7 and 8 remove and add header includes to avoid unused ones, and
>>   add missing ones to be self-contained.
>
> Seems to conflict with:
> https://lore.kernel.org/all/20240509-upstream-net-next-20240509-mptcp-tcp_is_mptcp-v1-1-f846df999202@kernel.org/

Hi Jakub -

The conflict here is purely in the diff context, patch 2 of this series 
and "tcp: socket option to check for MPTCP fallback to TCP" add cases to 
the same switch statement and have a couple of unmodified lines between 
their additions.

"git am -3" handles it cleanly in this case, if you have time and 
inclination for a second attempt. But I realize you're working through a 
backlog and net-next is now closed, so that time might not be available. 
We'll try again when net-next reopens if needed.


Thanks,
Mat

