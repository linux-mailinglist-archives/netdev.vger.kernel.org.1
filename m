Return-Path: <netdev+bounces-106901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B43918050
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CFC282FED
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044A17E445;
	Wed, 26 Jun 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="JyaYUA9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ADD149E06;
	Wed, 26 Jun 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402949; cv=none; b=jSEM5oUlIQr5uLUmxklG9LcbMUgLST6TU8kLcP9LoJcEePiGn+HsX4k7P72Jo1AmH062RUsteV754Xjnu+8ScBiqEAfCamN/dZ/pFhpkw3RkG3RXBu6oeRWpL//HRlZJleeqZELom71a5J+Vg6SpTEFa/Ahhquj+O8c8F7sxUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402949; c=relaxed/simple;
	bh=LexiWfrYm9DMTWjiLp0N38eu6kBfhX6jtR4dGHx5BGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rS70o8++YWadrkL59vvgvGY8KB0z4a4qj0IIlj4bh+yhQ/Ejy2RehrlYbpn6p+D+shRZ9+pVmxlD5fcRiF8wNVnb8FcZxU7VxvHAAro+Kf6ueN3j9lzqjCaA9ow1sAZXubGDsb3IqPCpg/7kSM2l/UBTQv8RUvMTNMhvIBCxe5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=JyaYUA9n; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1719402937;
	bh=LexiWfrYm9DMTWjiLp0N38eu6kBfhX6jtR4dGHx5BGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JyaYUA9nkBmZSDRdAjW37V75tgvL6HDpQUnnlE5tlhaJY8qhmxTR/SmZu+UUfCKSC
	 8gzuKAs/Jt+5NaAxDi42TNtLN2drIEetNQM2h04lHeUVq52XEFnxCpqQf/kzL0FasW
	 u5ER0d9EzP3YGGdNARwxnz96Rz7e49dK33NWUoZRGvO3uSKEOGkzvCDR40TAyBj83n
	 tE4VnhZwkTDOsM0fFHizpMqcIwl9yU3KAt3DXTSZPsxwhFU2knmvWi4cuk/4mJtKY8
	 jftckm8tcX0W4+KFTz3fTBfUyQ+7H7GrUD/fFv2i0Y04Y8OaaSTPvzmvQqrbezCgzb
	 WLY1MmjWL/GOg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9B6AC60078;
	Wed, 26 Jun 2024 11:55:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id B99592018B3;
	Wed, 26 Jun 2024 11:55:31 +0000 (UTC)
Message-ID: <d2df2837-070b-4669-8a35-c3d1341849d2@fiberby.net>
Date: Wed, 26 Jun 2024 11:55:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 2/9] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
To: Davide Caratti <dcaratti@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-3-ast@fiberby.net>
 <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com>
 <0fa312be-be5d-44a1-a113-f899844f13be@fiberby.net>
 <ZnvkIHCsqnDLlVa9@dcaratti.users.ipa.redhat.com>
 <CAKa-r6uqO20RB-fEVRifAEE_hLA50Zch=wbKtX8vNt5m6kE5_Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CAKa-r6uqO20RB-fEVRifAEE_hLA50Zch=wbKtX8vNt5m6kE5_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davide,

On 6/26/24 10:01 AM, Davide Caratti wrote:
> On Wed, Jun 26, 2024 at 11:49 AM Davide Caratti <dcaratti@redhat.com> wrote:
>>
>> So, we must htonl() the policy mask in the second hunk in patch 7,something like:

Good catch.

> or maybe better (but still untested), use NLA_BE32, like netfilter does in [1]
> 
> [1] https://elixir.bootlin.com/linux/latest/A/ident/NF_NAT_RANGE_MASK

Yes, that is better. It should work, as it triggers a htonl() in nla_validate_mask().

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

