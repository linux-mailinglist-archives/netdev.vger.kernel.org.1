Return-Path: <netdev+bounces-230701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2112BEDC36
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7656740815F
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA626CE06;
	Sat, 18 Oct 2025 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="PAE6Csxt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="MkPyo3Qf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0025D208
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760822244; cv=none; b=dIgFafFVCgtldUeXloFHAI9BgwYqK/0Vm6wtXwhYifLwWUlnuGDidc9gukHkZraGxBS/vGnQrqBJfJ+AYTM7eBRrk6etbTtG/PwyeIt6gRfmvi7UPaQbcd4oHEVAaUxFJ6OdzuUTnECL1Pfgh48ujyMU1OqmfUATm+nEeT6wabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760822244; c=relaxed/simple;
	bh=KeOqy38l1DSjT2ZGfVO9VqGafeODB92UxZ4aPkO71pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICC3/WfSZ7MWaVpnHSnuLomeb7/fVRT66DxVhRN1JeUwiQLcLh7/J+TGiKrnKWg6dRkwjGiW9/50UFXBpvFwcCJcJ06u33nzTABPTFIYGTTL5KvUUP+K0MMMPOHVbRo5ZGDIfUqplgCeZho5ykKgn7U2vbPkkuwHM+YT4nXGdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizmail.org; spf=none smtp.mailfrom=wizmail.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=PAE6Csxt; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=MkPyo3Qf; arc=none smtp.client-ip=85.158.153.28
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
	bh=f3tUYNNRtwt4zNALLY8K7qJsoG+wUbLhJxPgCKMIt+8=; b=PAE6CsxtgW0bjaXWJNNtIPRJeK
	M5BlyYRHh+YGvPx87cj1+eoyqlDa9Hd6waHU30Sg4XBQfJqr1dXQIgTdpHBQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r250621; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Autocrypt:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=f3tUYNNRtwt4zNALLY8K7qJsoG+wUbLhJxPgCKMIt+8=; b=MkPyo3QfxosHA6tCC4fqgMnHn+
	45evxRXT+0Ooxdf4JpTJfb7PkGUt/BFRTSU1kNaMgGhaSlhX2Lyizn2w8WWbSUmhwOpSaEFi5Yw27
	2yYqbFQYDF8ahgt2JI+mRjRa+FHgzJ3cwY6yTTvAlDmGODd8Yqome3hGIHWmwRTvT6BMWWrpzV6iJ
	TJkLC5z8CzATJyT6PnlTGn+7hRlGbhcC1jZUpv8L7SRX4DxVLaie8oA5gFUNpo11I85wRI2BwR0pd
	oT1e7l4YOb3e3z9gd91GjeaABDdRFcIjB+MBeFdkWEW3K5wIZyI332qiWvMqNRqjVnzfyTPH95hb9
	eAOOQB8g==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by wizmail.org (Exim 4.98.120)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1vAEIb-00000004ge1-4B2r
	(return-path <jgh@wizmail.org>);
	Sat, 18 Oct 2025 21:17:14 +0000
Message-ID: <80bb29a8-290c-449e-a38d-7d4e47ce882e@wizmail.org>
Date: Sat, 18 Oct 2025 22:17:12 +0100
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
 <f93076da-4df7-4e02-9d57-30e9b19b3608@wizmail.org>
 <CAAVpQUBD5nozg1azwi9tBHXVWgcXBSV+BXSgpt455Y+CweevYw@mail.gmail.com>
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
In-Reply-To: <CAAVpQUBD5nozg1azwi9tBHXVWgcXBSV+BXSgpt455Y+CweevYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

On 2025/10/18 9:56 PM, Kuniyuki Iwashima wrote:
>> In addition, a client doing this (SYN with cookie but no data) is granting
>> permission for the server to respond with data on the SYN,ACK (before
>> 3rd-ACK).
> 
> As I quoted in patch 2, the server should not respond as such
> for SYN without payload.
> 
> https://datatracker.ietf.org/doc/html/rfc7413#section-3
> ---8<---
>     Performing TCP Fast Open:
> 
>     1. The client sends a SYN with data and the cookie in the Fast Open
>        option.
> 
>     2. The server validates the cookie:
> ...
>     3. If the server accepts the data in the SYN packet, it may send the
>        response data before the handshake finishes.
> ---8<---

In language lawyer terms, that (item 3 above) is a permission.  It does
not restrict from doing other things.  In particular, there are no RFC 2119
key words (MUST NOT, SHOULD etc).


I argue that once the server has validated a TFO cookie from the client,
it is safe to send data to the client; the connection is effectively open.

For traditional, non-TFO, connections the wait for the 3rd-ACK is required
to be certain that the IP of the alleged client, given in the SYN packet,
was not spoofed by a 3rd-party.  For TFO that certainty is given by the
cookie; the server can conclude that it has previously conversed with
the source IP of the SYN.


Alternately, one could read "the data" in that item 3 as including "zero length data";
the important part being accepting it.
-- 
Cheers,
   Jeremy

