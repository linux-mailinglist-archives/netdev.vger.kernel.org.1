Return-Path: <netdev+bounces-230689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F77BBED81B
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 21:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3EA3AB401
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1C242D89;
	Sat, 18 Oct 2025 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="do1Jhd5j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="Ypb97y0m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C14244693
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814117; cv=none; b=ur7ivF1zSJToe03TS9bm8Tc1gTjEe3tcET7jNnH7TI3FG65R/fV6CAf5oUougZ7U1bohpDCVwP5kM6NUqcNQwFLW6z4GrsYdbSIzhG+1fXioyRVeH3CxcZ91X8QzVYj8FaIq9fJ5JLmbLr8EOzu4zJbLOOuZ9sIZ41d8Y3HP82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814117; c=relaxed/simple;
	bh=DXPGtBYOP85JnzCcHPms0Ngg0wVQ3bIQoqv7CeVL+iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1r1+qtl2+521H+cF01mRXB0Sv8Z0GeGOdICSepmQFbOJE+foMDoIhH1h0s5WYTsYwzKRHmI4I8t5E7WBdceEjbGn2OAcIzS7g2w5lk02pWbqBkvkAtIiLxfIRdcIaPTX9jb9A4xseVnS2hHCnrJHBpEH4Naw0XY2G9yUIS/Cxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizmail.org; spf=none smtp.mailfrom=wizmail.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=do1Jhd5j; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=Ypb97y0m; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wizmail.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e250621; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Autocrypt:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=XARMZO+O0tITHFCH4jUR5pjp90oMywID5Zp2nK6FlkY=; b=do1Jhd5jAAAuLhM1wYS8EFBs9L
	U2Rj7csKlM00OmsLKA7gfKt5QDgpxbIGnop/RNPL3vFVQMmI8K8ygrAyrFAg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r250621; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Autocrypt:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=XARMZO+O0tITHFCH4jUR5pjp90oMywID5Zp2nK6FlkY=; b=Ypb97y0mFfiM5Ygy1zzBtPWOzq
	LCasAuVtfj4C2IHIUbhXul7o4wh5J+wHkYJDgfp7y+5r/X+PXc1whBiN1Rl6uojxogobhXXlLyFOE
	Qf3Eq5S1HA3+JokoID6m/qvMFsLueFjGOyQrn4NhAonGtPkyvyTOfqIGtw9FmMga7whDUc+Zo6N5L
	QwcMwppsMNVc4pHjmUfK9VOiNacMPENwQwB09dMC3NEGeI9b/+po7PHU952G/QSGVu9nwTMTXM8CR
	FVo8JJ7YFa65gYzQLn47zTQlGE8WhtbD9WzbjuxALCQ4vSoaO4p1Z5nKJ0Y4o7/uFU3AWJyx/MNnA
	DoNbmIzA==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by wizmail.org (Exim 4.98.120)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1vABsA-00000004c6F-3Qzs
	(return-path <jgh@wizmail.org>);
	Sat, 18 Oct 2025 18:41:46 +0000
Message-ID: <f93076da-4df7-4e02-9d57-30e9b19b3608@wizmail.org>
Date: Sat, 18 Oct 2025 19:41:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 1/4] tcp: Make TFO client fallback behaviour
 consistent.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Yuchung Cheng <ycheng@google.com>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>
References: <20251016040159.3534435-1-kuniyu@google.com>
 <20251016040159.3534435-2-kuniyu@google.com>
 <CANn89iJnQErC8OLoTgnNxU8MURKANbiqXBYaUHsNaTO3m+P54Q@mail.gmail.com>
From: Jeremy Harris <jgh@wizmail.org>
Content-Language: en-GB
Autocrypt: addr=jgh@wizmail.org; keydata=
 xsBNBFWABsQBCADTFfb9EHGGiDel/iFzU0ag1RuoHfL/09z1y7iQlLynOAQTRRNwCWezmqpD
 p6zDFOf1Ldp0EdEQtUXva5g2lm3o56o+mnXrEQr11uZIcsfGIck7yV/y/17I7ApgXMPg/mcj
 ifOTM9C7+Ptghf3jUhj4ErYMFQLelBGEZZifnnAoHLOEAH70DENCI08PfYRRG6lZDB09nPW7
 vVG8RbRUWjQyxQUWwXuq4gQohSFDqF4NE8zDHE/DgPJ/yFy+wFr2ab90DsE7vOYb42y95keK
 tTBp98/Y7/2xbzi8EYrXC+291dwZELMHnYLF5sO/fDcrDdwrde2cbZ+wtpJwtSYPNvVxABEB
 AAHNJkplcmVteSBIYXJyaXMgKG5vbmUpIDxqZ2hAd2l6bWFpbC5vcmc+wsCOBBMBCAA4FiEE
 qYbzpr1jd9hzCVjevOWMjOQfMt8FAl4WMuMCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AA
 CgkQvOWMjOQfMt946ggAvqDr2jvVnGIN2Njnjl2iiKyw4dYdFzNhZgjTaryiV90BftUDxRsB
 uTVFUC6XU+B13MEgSK0zRDyI5NpEH+JTW539gWlmz2k2WTTmoBsm/js1ELoAjGr/i32SByqm
 0fo3JPctn/lc7oTo0muGYvB5xWhTHRlcT9zGTRUb/6ucabVLiJUrcGhS1OqDGq7nvYQpFZdf
 Dj7hyyrCKrq6YUPRvoq3aWw/o6aPUN8gmJj+h4pB5dMbbNKm7umz4O3RHWceO9JCGYxfC4uh
 0k85bgIVb4wtaljBW90YZRU/5zIjD6r2b6rluY55rLulsyT7xAqe14eE1AlRB1og/s4rUtRf
 8M7ATQRVgAbEAQgA6YSx2ik6EbkfxO0x3qwYgow2rcAmhEzijk2Ns0QUKWkN9qfxdlyBi0vA
 nNu/oK2UikOmV9GTeOzvgBchRxfAx/dCF2RaSUd0W/M4F0/I5y19PAzN9XhAmR50cxYRpTpq
 ulgFJagdxigj1AmNnOHk0V8qFy7Xk8a1wmKI+Ocv2Jr5Wa5aJwTYzwQMh4jvyzc/le32bTbD
 ezf1xq5y23HTXzXfkg9RDZmyyfEb8spsYLk8gf5GvSXYxxyKEBCei9eugd4YXwh6bfIgtBj2
 ZLYvSDJdDaCdNvYyZtyatahHHhAZ+R+UDBp+hauuIl8E7DtUzDVMKVsfKY71e8FSMYyPGQAR
 AQABwsB8BBgBCAAmAhsMFiEEqYbzpr1jd9hzCVjevOWMjOQfMt8FAmgeKicFCRZfl6wACgkQ
 vOWMjOQfMt8Bewf9F3xhidAAzCrlwceeSx16n82sSmtCopkoSp85++P6P3Nzt/erkqnhZY0Y
 OZM5xIBJU5ejKalb6aYB4OU7q20MfTerPo+XhuWDjKYb0RrMmekVsE4/V5sFCgdwkqjax1ZX
 Jk3/vkTRnpHtuKas9FxGxeyaJrsYBhJIgzcXAfN3zYRD+x6L/zNYzvvoEEH8dKIeKh0dEXg0
 3p0VWJU8zfWo2NT+xeqYnG8OO2HAr9/D9Sw9W4HZ4csdWXOJ/GmnHYri9Q4RyrF8uH4fAxKr
 c1cFYEY84iaBog5uv3dti9vUit8XWyae8rTPC/QyAekgREvAJnISWxLQWWbOqd6TkoTqJw==
In-Reply-To: <CANn89iJnQErC8OLoTgnNxU8MURKANbiqXBYaUHsNaTO3m+P54Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

On 2025/10/16 5:10 PM, Eric Dumazet wrote:
> On Wed, Oct 15, 2025 at 9:02 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>
>> In tcp_send_syn_data(), the TCP Fast Open client could give up
>> embedding payload into SYN, but the behaviour is inconsistent.
>>
>>    1. Send a bare SYN with TFO request (option w/o cookie)
>>    2. Send a bare SYN with TFO cookie
>>
>> When the client does not have a valid cookie, a bare SYN is
>> sent with the TFO option without a cookie.
>>
>> When sendmsg(MSG_FASTOPEN) is called with zero payload and the
>> client has a valid cookie, a bare SYN is sent with the TFO
>> cookie, which is confusing.

> I am unsure. Some applications could break ?
> 
> They might prime the cookie cache initiating a TCP flow with no payload,
> so that later at critical times then can save one RTT at their
> connection establishment.

In addition, a client doing this (SYN with cookie but no data) is granting
permission for the server to respond with data on the SYN,ACK (before
3rd-ACK).

-- 
Cheers,
   Jeremy

