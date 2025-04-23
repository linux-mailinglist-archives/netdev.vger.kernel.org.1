Return-Path: <netdev+bounces-185109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA2BA988D5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A847A910D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F1E143748;
	Wed, 23 Apr 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="NduuiM0m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="efh3o/8R"
X-Original-To: netdev@vger.kernel.org
Received: from mx.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201BFC08
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408795; cv=none; b=tFX01TRR6cv2W2TnauTjF2WcAhvGZjnRJ+SU4wYCo6RsrqIXSMJNN9cqXK8aUq5AjUdQHmio1bZVdb067bO4SszDXr9lERxtPtp7mEr74WUH5U2QV6UWHU8dUvXk4lKZ9KlGHp5W5D4bdtno1OY1yYXn8kM4UGghpCB09nNydWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408795; c=relaxed/simple;
	bh=A4/TVm5hPzkhEGJ9kZ/9rz+SF9RCAs18YaCZO8G2UcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpupVWsCbAmaG0/6kux4PZClNJUE2YOZNpHOEBxQnEX3ouH86IX37eayYADgnCr4G3qae8kwpzYwG5sI4OHGGyIQEiVJCF3SgJwCnLJfc6cQvzmgShcxyqsBw0SjWCy3kMs3CvpupDY/8KM1Ojhj3oxGwcefRW+RZlkTD3gXZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizmail.org; spf=none smtp.mailfrom=wizmail.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=NduuiM0m; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=efh3o/8R; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wizmail.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Autocrypt:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=zqDjNeUM3fYyHIeG62FjixCqaw7o1sMlTt5Cr/Jv+4c=; b=NduuiM0mQ0z6vKPTMFNke1Ld0j
	6w3DT0Tp71lM+SRByUXhsKIxJ76FpTQtFyli6ke4wiuUXU+F493UsI/BpgBQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Autocrypt:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=zqDjNeUM3fYyHIeG62FjixCqaw7o1sMlTt5Cr/Jv+4c=; b=efh3o/8RETOFLVmxsEXn4lYYcr
	VGPmbEMRVTDd4OlV281p/UuUnJXSzNW4YsArn9dpkDVLgMDWxA1nOEE5vbKEL5FSxY4plg58uyLGe
	l4D3JvRDdoeAs3u8t6DbYUkKByAOigpgKlqrS/N4Nxyq0pvS1SS186DfX4O4x40FtVdJGZ+dfVSaP
	7eQJMdSbKa256b2QOjE24IMG8LaDiTpORik05R8e8860/KJcFz//3mRBFoRnxfuhOzALurGk45i97
	ZKjh26SIFw3BUi/OJV+4gG/enPTFfCv5KnC9wwSZ0ke9FbvVAmyYnYVwQIowQkywAWJbfymUKbMmx
	qFThuu3w==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1u7YYe-00000001h4f-2Bg9
	(return-path <jgh@wizmail.org>);
	Wed, 23 Apr 2025 11:46:28 +0000
Message-ID: <e50f6e80-61c8-4c6e-a7c2-9b3ab7b27d90@wizmail.org>
Date: Wed, 23 Apr 2025 12:46:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] TCP: note received valid-cookie Fast Open
 option
To: Neal Cardwell <ncardwell@google.com>, Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, edumazet@google.com
References: <20250416090836.7656-1-jgh@exim.org>
 <20250416091513.7875-1-jgh@exim.org>
 <CADVnQyn7i_ZHwZNm5gxwHuAcSAF9NdYZyNZyQ_2abr79oytT4g@mail.gmail.com>
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
 AQABwsB8BBgBCAAmAhsMFiEEqYbzpr1jd9hzCVjevOWMjOQfMt8FAmRaa+cFCRKczCMACgkQ
 vOWMjOQfMt8wLQgAuNQkQJlPzkdm/mvKWmEp/MW5SsYROINr21cFqPXYy+s8UwiDshe+zuCQ
 fXxxSH8xbQWYEKHOgQx7z0E5x8AppAUj0RoN7GxkPzBdoomfKhx7jV8w43YjjpMFbktM2/44
 lTaselejQbcGH7jrgFVK0iifeoPS0x2qNE6LhziIU8IWMSLZffXP32+nEqMr4m1uKna3j3jt
 9jQh8ye2oz4VdVy0NbQDVKgMP4b7gShtIq1i0cxJNviyQ+tOANW92I2Kla6kUvwL6g9ovBVH
 xf01RBCxE+ppjb9N8y58qzwnP0c5X2UqTIBhfNWKRLonvJ5RQeb3R1ZJQJ5Ek2AV21/7Zw==
In-Reply-To: <CADVnQyn7i_ZHwZNm5gxwHuAcSAF9NdYZyNZyQ_2abr79oytT4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

Thanks for the review.  I'm preparing a v2, and a patch to "ss" in iproute2.

> The "TCP:" prefix is not the typical prefix for Linux TCP changes. A
> "tcp:"  is much more common.
> 
> Please follow the convention that we try to adhere to for TCP TFO
> changes by using something like:
> 
>    tcp: fastopen: note received valid-cookie Fast Open option

Will change for v2.


>> -               syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
>> +               syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
>> +               syn_fastopen_in:1; /* Received SYN includes Fast Open option */
> 
> IMHO this field name and comment are slightly misleading.
> 
> Sometimes when a SYN is received with a TFO option the server will
> fail to create a child because the TFO cookie is incorrect.
> 
> When this bit is set, we know not only that the "Received SYN includes
> Fast Open option", but we also know that the TFO cookie was correct
> and a child socket was created.
> 
> So I would suggest a more specific comment and field name, like:
> 
>    syn_fastopen_child:1; /* created TFO passive child socket */

Done.

-- 
Cheers,
   Jeremy

