Return-Path: <netdev+bounces-101885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B97749006A7
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57FD0B29620
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439A3195B2E;
	Fri,  7 Jun 2024 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WISwcBMr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179BC194AD3;
	Fri,  7 Jun 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770555; cv=none; b=AeY3cn3RPUN3uaVPqET/ci+PBByNsjDWiSyHJZ2zWyjwMq1oKGO5i70kSYUo/R7ifD2Ep7OhnhuC0Yjf4oElvkdmsac/4la7u2hVDFPmxL4+DIoT3KrOngMPM2D0UD7q7EuFkpAPj2RoQ87QaqqU4o7yKht9utH2GLWVQpvLAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770555; c=relaxed/simple;
	bh=dKD4INyKXeP5zXbI15q6iLNYwFvtOX/hgD4VslxEkyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbjBauPJBqIc+lAASD/GpXB6o9XM9hq3dA1TLvgH0DxZ24jP/ug1PGK8Fz50RdYaZ0wRwMoYXSCbwQGDinWZ8q6d2ts+Fk+ZfH3MjER4PuT3IK0+CSCHGHLHFEXiOp6vUzPgCXjmsXWT/MJWPBLtqVH/4HNiBm+T28TFLgPrT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WISwcBMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F37C3277B;
	Fri,  7 Jun 2024 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717770554;
	bh=dKD4INyKXeP5zXbI15q6iLNYwFvtOX/hgD4VslxEkyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WISwcBMrAlDtOZwQNGG7H8FM9ZvP+UGPYDCIUIKTqiMMcXsizYH1EYEEHDSPz5p0v
	 dJhixKrlIUO1MxqfW7e1uRUlTc/F36SEg7I0WhWDEcle7mk69ivFU3bQbAHUR1TOfm
	 tHI0KmjC1gKxrYugOD07N23v8LpCOrRD85d5aWYMupoumVX1nVScNWFXNkxlZKmHNp
	 HVe3OBheGeM4fSRhqLATCDyIriWuI2Iii07Y0wD3zQwoXrzvQu2PjCkvFv5BIi7wog
	 HXn/PaK8+9RYFxCFmcjhagwCpzIH7jPBMQqMjD75MmJHgQx21p8Bb6FR8G2B17QW2p
	 Fw1zdllHqbjxw==
Message-ID: <4533aea5-550a-454b-8b82-2ae28a97fd1c@kernel.org>
Date: Fri, 7 Jun 2024 08:29:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 net-next 1/7] net: add rx_sk to trace_kfree_skb
Content-Language: en-US
To: Yan Zhai <yan@cloudflare.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Neil Horman <nhorman@tuxdriver.com>, linux-trace-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <cover.1717529533.git.yan@cloudflare.com>
 <983c54f98746bd42d778b99840435d0a93963cb3.1717529533.git.yan@cloudflare.com>
 <20240605195750.1a225963@gandalf.local.home>
 <CAO3-PbqRNRduSAyN9CtaxPFsOs9xtGHruu1ACfJ5e-mrvTo2Cw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAO3-PbqRNRduSAyN9CtaxPFsOs9xtGHruu1ACfJ5e-mrvTo2Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 9:37 AM, Yan Zhai wrote:
> # cat /sys/kernel/debug/tracing/events/skb/kfree_skb/format
> name: kfree_skb
> ID: 2260
> format:
>         field:unsigned short common_type;       offset:0;
> size:2; signed:0;
>         field:unsigned char common_flags;       offset:2;
> size:1; signed:0;
>         field:unsigned char common_preempt_count;       offset:3;
>  size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
> 
>         field:void * skbaddr;   offset:8;       size:8; signed:0;
>         field:void * location;  offset:16;      size:8; signed:0;
>         field:unsigned short protocol;  offset:24;      size:2; signed:0;
>         field:enum skb_drop_reason reason;      offset:28;
> size:4; signed:0;
>         field:void * rx_skaddr; offset:32;      size:8; signed:0;
> 
> Do you think we still need to change the order?
> 

yes. Keeping proper order now ensures no holes creep in with later changes.


