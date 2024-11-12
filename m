Return-Path: <netdev+bounces-144220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A69C6158
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776A8280ECD
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D21218D92;
	Tue, 12 Nov 2024 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="UuGMq0mE"
X-Original-To: netdev@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8021832A
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439277; cv=none; b=jZsw9X/RVJBhbYC0tvS0DT3lzhseoEZEsNUE7vTvlmUBe0jvCzO3+NA1N0s8rSN2PIvdmKwtXG+m45YkVh3skFxpyODKS/ZtmDETco317bZA1Uq8JBCaGZMWqY/NjfIpT8CrN/s+BJ57ZetHLcLydSXcDXPjw3mGWlo322pBQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439277; c=relaxed/simple;
	bh=HzTz+zkDjCfyc0Xw+jURVPdAEW/0cXyh7yElhXrCzl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLTrh+2ZY2qOROSlyb6uiURVhqvp7+yx8/727udvT8qZSNCEK3Derc2/a0mP9188cOL3RelunVBIm7oCBh+INFxnASQFAomKWmd04wLHhFjY4ctveixpRD5mj9Eno4MlynWQVndUYmQ/FZ02mL1PYTk0PROu+AF1nqQBi9+oQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=UuGMq0mE; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731439270; bh=HzTz+zkDjCfyc0Xw+jURVPdAEW/0cXyh7yElhXrCzl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UuGMq0mEHzoELSMWvDoXVB5iqUxmh2n6eBqGYYlIZ/s2ZCbi2raAR29zEW3kPRe4X
	 0+lsBNVgYi8ZiU0jJcMD8Y/FHzwoQiwGENpb5BxzY+CAO4H/TqeR/vhsZn+Om2m3vU
	 Xgi90AEw4hGI+yU7rC8KxjdfUzg5stuU5wefwgvo+YPz/Hc9fp6I3GJ5UI/RvXWc5z
	 jUeAcojvZzALF0JRxcf6eQ3pFR/Tf/IJN2HpyUZHM/d3IJzAOjKEQnNTg4o3yoPLJs
	 SpMUe1JSJ2U9al3ii/1QFGk/xoeT2BAqkptkPRfKTzWB9wH2FI7LlQQiB7XEOtqeGJ
	 vmvkMjn2zEe4SPbKifDA5yC6dVe3s4Pzfs+I4B40AC+Y05Jh6NodR9MiFmZ4FxXsK7
	 PB3bMXLBabRmobTgcAo+3i4ev2InOF4SOcTkHBGiTB+D3WAljnRAs4K/mrIdxNnQaU
	 GfANYXE5f2NIRYaGM5n8/tpnFoQTJtmSCsNvJdDAD+KBpfxGLbySDNrpx5Wukzi3zo
	 aq5gT1RoeonAmv0EJnhbvW+5QCB8MH/An8wiU/ndlPcvd14Q+n2PZPC1ponpgJBatK
	 lU5DgxihmfI0AXWFQx0+CEFffsQVzCKXuU55wn3/OSBBOKUd7f9LT7iqb8ecaiW9P7
	 zmbhSDC6eZlcONmD4de66SSI=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 41A3C1683CF;
	Tue, 12 Nov 2024 20:21:10 +0100 (CET)
Message-ID: <d514ef1a-bf56-4949-91f1-c64e3f599922@ijzerbout.nl>
Date: Tue, 12 Nov 2024 20:21:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] xfrm: Add support for per cpu xfrm state handling.
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
References: <f9eb1025-9a3d-42b3-a3e4-990a0fadbeaf@ijzerbout.nl>
 <ZzM1/S72Qj0tBCC0@gauss3.secunet.de>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <ZzM1/S72Qj0tBCC0@gauss3.secunet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 12-11-2024 om 12:03 schreef Steffen Klassert:
> On Mon, Nov 11, 2024 at 09:42:02PM +0100, Kees Bakker wrote:
>> Hi Steffen,
>>
>> Sorry for the direct email. Did you perhaps forgot a "goto out_cancel" here?
> Yes, looks like that. Do you want to send a patch?
I prefer that you create the patch.
>
>> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
>> [...]
>> @@ -2576,6 +2603,8 @@ static int build_aevent(struct sk_buff *skb, struct
>> xfrm_state *x, const struct
>>       err = xfrm_if_id_put(skb, x->if_id);
>>       if (err)
>>           goto out_cancel;
>> +    if (x->pcpu_num != UINT_MAX)
>> +        err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
>>
>>       if (x->dir) {
>>           err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
>>
>> -- 
>> Kees Bakker


