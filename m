Return-Path: <netdev+bounces-109323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7273B927EBB
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 23:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C011F22B1E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DFC14389F;
	Thu,  4 Jul 2024 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="n/69CsbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F341411E9;
	Thu,  4 Jul 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720129535; cv=none; b=Xcox3U2yeMoaoMVBxeySILyjgLcia5n/9JUt8nI51yPyPihm2zVBdD0B9rSItbNuUirSAVvssGK4pD/zlrvlMHhCwDSjC7ZBoDllsnEr/CE3DxUFi9EQZXVhC9Z4zIJumx5xQAUrChXs2dscOS343FVJmlvDYQyfIxPVKr0/A1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720129535; c=relaxed/simple;
	bh=CQYRZeEJYehwol1s8+mG6Q+2ubuR3CvZFq0eup2MD64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExjSlFs+wGHFjll5y5gLhYRuaqcPs240+94NScFsjQX3wBNLo95DI3zS4sQBeOqPKEMJ4tmeR0fgrTjlYM3cQWk03D/rHiC0GsXiiWxZyO+HIm0q+ljiWNZZHYfoM43RVl2DzSYM7MXx+/RInQuaO6X1t+cRil7BS5BJadcpFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=n/69CsbT; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720129521;
	bh=CQYRZeEJYehwol1s8+mG6Q+2ubuR3CvZFq0eup2MD64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n/69CsbTkiO93w/BWlUW309bIbnR67JDjVvSm5YJ88PM8D0Rw7HwIQwikGTMczCE/
	 vQjWZRsKwOe1/dL/4nqN7NPNmQo81yFsx4xt9bg4yR+6K5Hzy/AzRHBmjNW0dOmGwE
	 Cmp4jwrh3eUwJZvKUfuHL7DUuVO13IXpGpft4dnfCWjYEgOgM2ZMDV3FJRW2Vv6XQg
	 WDaKB81bXBAPW6d+hXGvkm/IKbtx6amFziijSXEBt7yEMpKCnUazOIbk0So5hbswUd
	 W+lQWSrW7eJJ9bo24fyKHPF6MQHDLZ4czU8f/bMsEhDe8g+XaKf9mfG5AOMrugVfmZ
	 JN9o5+na0tkKg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E3C8360079;
	Thu,  4 Jul 2024 21:45:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id AEDB4201F16;
	Thu, 04 Jul 2024 21:45:14 +0000 (UTC)
Message-ID: <7db43f91-80d5-4034-ab25-f589e5510024@fiberby.net>
Date: Thu, 4 Jul 2024 21:45:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/9] net/sched: flower: define new tunnel flags
To: Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org
References: <20240703104600.455125-1-ast@fiberby.net>
 <20240703104600.455125-2-ast@fiberby.net>
 <b501f628-695a-488e-8581-fa28f4c20923@intel.com>
 <20240703172039.55658e68@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240703172039.55658e68@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kuba and Alexander,

On 7/4/24 12:20 AM, Jakub Kicinski wrote:
> On Wed, 3 Jul 2024 12:59:54 +0200 Alexander Lobakin wrote:
>>>   enum {
>>>   	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
>>>   	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
>>> +	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */
>>
>> Should uAPI header contain this comment? FLOW_DIS_ENCAPSULATION is an
>> internal kernel definition, so I believe its name shouldn't leak to the
>> userspace header.
> 
> Also since it's internal, can avoid the gap in uAPI and make
> ENCAPSULATION be something like "last uAPI bit + 1" ?

Would the below work?

-#define FLOW_DIS_IS_FRAGMENT   BIT(0)
-#define FLOW_DIS_FIRST_FRAG    BIT(1)
-#define FLOW_DIS_ENCAPSULATION BIT(2)
+/* The control flags are kept in sync with TCA_FLOWER_KEY_FLAGS_*, as those
+ * flags are exposed to userspace in some error paths, ie. unsupported flags.
+ */
+enum flow_dissector_ctrl_flags {
+       FLOW_DIS_IS_FRAGMENT            = TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT,
+       FLOW_DIS_FIRST_FRAG             = TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST,
+       FLOW_DIS_F_TUNNEL_CSUM          = TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM,
+       FLOW_DIS_F_TUNNEL_DONT_FRAGMENT = TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT,
+       FLOW_DIS_F_TUNNEL_OAM           = TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM,
+       FLOW_DIS_F_TUNNEL_CRIT_OPT      = TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT,
+
+       /* These flags are internal to the kernel */
+       FLOW_DIS_ENCAPSULATION          = (TCA_FLOWER_KEY_FLAGS_MAX << 1),
+};

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

