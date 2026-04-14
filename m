Return-Path: <netdev+bounces-278323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL6ACHTx3WmMlQkAu9opvQ
	(envelope-from <netdev+bounces-278323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:49:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94E3F6BBC
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B8EE302A2F8
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE5C38237B;
	Tue, 14 Apr 2026 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="SHN0dr2z"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353738238A;
	Tue, 14 Apr 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776152822; cv=none; b=VCXaK6bUpPrknQ/oTxc7NSo+IhthGJ8S0vc+zKJHbG+9MP4FtmD28pZx3X/J+SNQkpWSuR1KkFs/J32PGWZM3lLUD+oor6JZpXZTkjb+Bp6EtQAEc1sesp0Ku2C1KegRYe9/Kki5ZDtQfcbyxIjYn9Zzg3LKiaPI2A3Sd+zHZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776152822; c=relaxed/simple;
	bh=YDzvRcbIcNb6Qw7lZXKYQmRuZNwt561DKkZg4FweOjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IL31e3T/Q8HyESsABTLGrDksaenHG/UOXL6mBikoxi8Ogu9XiEItdC9+M9LhOAC+zAvgGD7nnAYaDOQqB80ONAjObDoCi/dQSOrnX6WHaNgTb1uKTADN8pqSc2P09f4diw1dsorj38zdDaGSOn/K0zkLFi5Vi999mxcBlAWFBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=SHN0dr2z; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776152818; x=1776757618; i=deller@gmx.de;
	bh=pIDcCY9Pm13zOlAXFwgB3yEZsQU3tzlrbvGlklGJXxc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SHN0dr2zHMAqG3aEGsW8BvqE02wzlb1rmzDWMu8VPD28w6Rrk32PZiY8FyyPE/ad
	 Gk1ijFSDK71UAgVC3cOSYC0nDIFZLGW6ofUk8t0KbNA3yf2uGxhLGJrh1p5ImvMDd
	 Ud8uUSYhIb3eyx0pqVsNDp7Ai6Fl+z+1RToF/3QXWIurMHLJSMuPKzZoX4IXCfAzS
	 cFKKlVxWvZWk+aTKs/W9jdKT3frhigk4BHvXj/KJPTOY2kki/r1WbWquznWlmACpj
	 W1B+/lt5+WxMXUepPksZfgGJRmlmheP40/LwBL5Pjtfk0Tu0tnql0Gklh8rzYDp0Q
	 sKGFycrfZc4fSzFUJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTAFb-1w0dxu30ZD-00PNfc; Tue, 14
 Apr 2026 09:46:57 +0200
Message-ID: <49c05cd8-5ad0-4015-8f55-fed3416784bf@gmx.de>
Date: Tue, 14 Apr 2026 09:46:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Optimize flush calculation in inet_gro_receive()
To: David Laight <david.laight.linux@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: deller@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, edumazet@google.com
References: <adkMqgP6QeBPgqP9@p100>
 <20260411052037.2013228-1-kuniyu@google.com>
 <20260411130958.70202bab@pumpkin>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260411130958.70202bab@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CliraCk4BkLnwC1Fq9TsqKC9uRgGKF7K586brBWCPEBA0EicGZR
 gHaTwjraw1EZzR3YXOQxYxrYH3jEX2bCKcb9HV8KqZzN6iMAJO3jAt/Rr/HCADgaee6h8mg
 qAx+0c6L1rhx9bcfOooPymVLjPfX/MPCsEY93r+VvR4FtQiHqbyFZ7jeCj2ZZJ81Dr2i6uT
 huYcB6gZP5kHF9XjyRTNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H1dK9btVpVA=;HNARaKuqPZ98ke2UPstu1h/ewle
 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
 nlx1nvEHJySdnPQ==
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278323-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB94E3F6BBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kikuyu and David,

On 4/11/26 14:09, David Laight wrote:
> On Sat, 11 Apr 2026 05:19:35 +0000
> Kikuyu Iwashima <kuniyu@google.com> wrote:
>=20
>> From: Helge Deller <deller@kernel.org>
>> Date: Fri, 10 Apr 2026 16:43:54 +0200
>>> For the calculation of the flush variable, use the get_unaligned_xxx()=
 helpers
>>> to access only relevant bits of the IP header.
>>>
>>> Note: Since I don't know the network details, I'm not sure if "& ~IP_D=
F"
>>> (& ~0x4000) is correct, or if "& IP_OFFSET" (& 0x1FFF) should be used =
instead
>>
>> ~IP_DF is correct (MF bit needs to be checked), see

Ok, Thanks for checking!

>> commit db8caf3dbc77599dc90f4ea0a803cd1d97116f30
>> Author: Eric Dumazet <edumazet@google.com>
>> Date:   Fri May 31 11:18:10 2013
>>
>>      gro: should aggregate frames without DF
>>
>>
>>> (which I believe would be more correct). Instead of possibly breaking =
things I
>>> left it as is, but maybe some expert can check?
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>
>>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>>> index c7731e300a44..58cad2687c2c 100644
>>> --- a/net/ipv4/af_inet.c
>>> +++ b/net/ipv4/af_inet.c
>>> @@ -1479,7 +1479,7 @@ struct sk_buff *inet_gro_receive(struct list_hea=
d *head, struct sk_buff *skb)
>>>   	struct sk_buff *p;
>>>   	unsigned int hlen;
>>>   	unsigned int off;
>>> -	int flush =3D 1;
>>> +	u16 flush =3D 1;
>>>   	int proto;
>>>  =20
>>>   	off =3D skb_gro_offset(skb);
>>> @@ -1504,7 +1504,8 @@ struct sk_buff *inet_gro_receive(struct list_hea=
d *head, struct sk_buff *skb)
>>>   		goto out;
>>>  =20
>>>   	NAPI_GRO_CB(skb)->proto =3D proto;
>>> -	flush =3D (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(=
*(__be32 *)&iph->id) & ~IP_DF));
>>> +	flush =3D (get_unaligned_be16(&iph->tot_len) ^ skb_gro_len(skb)) |
>>> +	        (get_unaligned_be16(&iph->frag_off) & ~IP_DF);
>>
>> I think here we intentionally use 32-bit loads:
>>
>> commit=20
>> Author: Herbert Xu <herbert@gondor.apana.org.au>
>> Date:   Tue May 26 18:50:29 2009
>>
>>      ipv4: Use 32-bit loads for ID and length in GRO

I see, this patch is exactly the opposite of mine.

>> Before your patch, 32-bit load + bswap are used while
>> 16-bit load + rol 8 after the change.
>>
>> I feel the 4-byte aligned load + bswap is faster than
>> misaligned access + 8 times shift (Is this internally
>> optimised like xchg for a single word size ?)
>>
>> Do you have some numbers ?

No, I don't have.
In the end it's very platform specific anyway.
 =20
> Check on some architecture that doesn't support misaligned loads.
> Actually, aren't the accesses aligned??

The reason why I touched this code at all, is because I got unaligned
accesses in that function on parisc.
But those unaligned accesses were triggered by parisc-specific
inline assembly, and not by this code here.

So, I believe those accesses here are aligned, and the get_unaligned_XX()
helpers make the code more readable, but are NOT necessary.

That said, I suggest to drop my patch.
It makes the code more readable, but probably will not improve speed.

Thanks for your help!
Helge

> Also on ones without 32bit byteswap (some do have byteswapping
> memory reads).
>=20
> Also you may not want to change 'flush' to u16.
> On non-x86 it may force the compiler add extra masking instructions.
>=20
> 	David
>  =20
>>
>>
>> Before:
>> 	flush =3D (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb))
>> mov    edx,DWORD PTR [rcx]
>> bswap  edx
>> 	return skb->len - NAPI_GRO_CB(skb)->data_offset;
>> mov    r8d,DWORD PTR [rsi+0x38]
>> mov    r9d,DWORD PTR [rsi+0x70]
>> sub    r9d,r8d
>> xor    r9d,edx
>> 	| (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
>> mov    ebp,0xffbfffff
>> and    ebp,DWORD PTR [rcx+0x4]
>> bswap  ebp
>> or     ebp,r9d
>>
>>
>> After:
>> 	flush =3D (get_unaligned_be16(&iph->tot_len) ^ skb_gro_len(skb))
>> movzx  edx,WORD PTR [rcx+0x2]
>> rol    dx,0x8
>> 	return skb->len - NAPI_GRO_CB(skb)->data_offset;
>> mov    r8d,DWORD PTR [rsi+0x38]
>> mov    r9d,DWORD PTR [rsi+0x70]
>> sub    r9d,r8d
>> xor    r9d,edx
>> 	| (get_unaligned_be16(&iph->frag_off) & ~IP_DF);
>> movzx  ebp,WORD PTR [rcx+0x6]
>> and    ebp,0xffffffbf
>> rol    bp,0x8
>> or     ebp,r9d
>>
>=20


