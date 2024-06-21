Return-Path: <netdev+bounces-105741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C08769128FE
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001811C26795
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E84A9B0;
	Fri, 21 Jun 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="f3oiNN+X"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DAD3987D;
	Fri, 21 Jun 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982557; cv=none; b=aSdXX6l1o5PTdiplMGo0kS7OCuufM4i4eg5Qh3IzqqLqxwb8JUpAi1SAQ+xAnD9yrJmNj/H614TnDQV09iig7E8siFkkOLvQkvVIkTM50jaM6RMohCYXQ1F9bK0UvWN9FM1SsK5iRRpacJRBp1OGDHM+w9ld+57rJDkDMDuLZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982557; c=relaxed/simple;
	bh=sVkHYUzchJZmDdzs/amWdjxvo08cI5C5ingJuyXLnfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXqv+RlECafmPyuU9qY0M8kxF/jZ6nlp0eNxCKqtSf3d6hBawDWCNPsxMb6n7KF4hJuE2ULtk/sPUHaFQ2D2rzy8tXCRKQ5HuiT1zXtIe5UttNQz0BOvb/RZRW6zczfMNt79aSgE5F3P2vyIeXyUd0myTLVpcQi5McCaZBq4rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=f3oiNN+X; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718982181;
	bh=sVkHYUzchJZmDdzs/amWdjxvo08cI5C5ingJuyXLnfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f3oiNN+Xo2MwELUXMvR9dWVJ/IlEYpSQWdQFX9pYyYs+25TPDaqa5jICJ5/sfFpAW
	 W8qXxoh8dc1CwXqlk/LUAsXhwnf/BP63RUDg4KA+ZJ3dMfo+gCfiosQDcPBRyu2JyR
	 FP+WkyzJcH2LKlncW5ymVUh+xpvxEbAnzYruwC7RsXfljZr9VDpZ9P/lk+ORwBTqaJ
	 nqPaQ3G3BI5dtiuO3MbMCPmIUeqciZO0LjfvsQIXF4bzjgOuf7iw1MpZb3yoP6BaYB
	 a43TKVFaShAGvJpJkjKcC75ho/DuLzu1y/GiqUb85DX0Y8cBDsdR4qZDFGJUbUo5pn
	 8SETdXf3Tm+Sg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EC25560078;
	Fri, 21 Jun 2024 15:03:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 8D8E9200D72;
	Fri, 21 Jun 2024 15:02:55 +0000 (UTC)
Message-ID: <c3f9a3ae-7bf6-4c31-b19e-f98e6bd6caed@fiberby.net>
Date: Fri, 21 Jun 2024 15:02:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 5/9] flow_dissector: set encapsulated control
 flags from tun_flags
To: Davide Caratti <dcaratti@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-6-ast@fiberby.net>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240611235355.177667-6-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davide,

On 6/11/24 11:53 PM, Asbjørn Sloth Tønnesen wrote:
> Set the new FLOW_DIS_F_TUNNEL_* encapsulated control flags, based
> on if their counter-part is set in tun_flags.
> 
> These flags are not userspace visible yet, as the code to dump
> encapsulated control flags will first be added, and later activated
> in the following patches.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>   net/core/flow_dissector.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 86a11a01445ad..6e9bd4cecab66 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -396,6 +396,15 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
>   
>   	key = &info->key;
>   
> +	if (test_bit(IP_TUNNEL_CSUM_BIT, key->tun_flags))
> +		ctrl_flags |= FLOW_DIS_F_TUNNEL_CSUM;
> +	if (test_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, key->tun_flags))
> +		ctrl_flags |= FLOW_DIS_F_TUNNEL_DONT_FRAGMENT;
> +	if (test_bit(IP_TUNNEL_OAM_BIT, key->tun_flags))
> +		ctrl_flags |= FLOW_DIS_F_TUNNEL_OAM;
> +	if (test_bit(IP_TUNNEL_CRIT_OPT_BIT, key->tun_flags))
> +		ctrl_flags |= FLOW_DIS_F_TUNNEL_CRIT_OPT;
> +
>   	switch (ip_tunnel_info_af(info)) {
>   	case AF_INET:
>   		skb_flow_dissect_set_enc_control(FLOW_DISSECTOR_KEY_IPV4_ADDRS,

I am not too familiar with the bitmap helpers, so this is the part of this
RFC series that I am most unsure of.

These should maybe have been test_bit(*_BIT, &key->tun_flags), test_bit() in
general is mostly used with a reference, but with tun_flags it's a mixed bag:

git grep 'test_bit(' | grep tun_flags

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

