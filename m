Return-Path: <netdev+bounces-185108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF98A988CD
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0261B65979
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC47270EA4;
	Wed, 23 Apr 2025 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="AMrqt3GP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="VIgdES2C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D026F444
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408644; cv=none; b=d9JDuLNlJYyx5J+NiDvpGMdsOn4Vt6Wq6U/8Yi8eostgonD4Y6Rc6Ah/iPdOnWXhskTQI2Nu1idmn8vt+aNot0mM3+U66M8Tpl9Nm+MCQEl1I7wGfKNw0rfaQC5ivYdeAkEoJxLtl1D73RLJ0U1uU4ZRMncrfyoOfaVCSjJ4ypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408644; c=relaxed/simple;
	bh=H8cTURXJ55kT+NgkNCsPonfmKkYjt4a4bBbNGI2vUSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTtLU1AVkMfPkZqcz8TvhGkEtgkOcqbe0Oh8hqNN0wuqKyxosl9rUH18cyPowp8EsnEtHQwxwbtwHRFhqHq4H8nx39+b/Aa9HudTyk5w12pEbamf6r5l/4eRY08f/vN7DV9m8hRyw64hXqDRL8Dm/1tHTQxIljLuh7v2jyYY29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=AMrqt3GP; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=VIgdES2C; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Autocrypt:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=cdYYOFgUIJiA3LNsW/OGkunfgngvuevP51Pm7QtNZMM=; b=AMrqt3GPkfyz4Rm5Y7cpGsfcvr
	Q3KeIAqFJlHw3gkr64OqaZyzOHKLva9L3GsEL4cj9Nm07O7OdpvYoppRehBA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Autocrypt:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=cdYYOFgUIJiA3LNsW/OGkunfgngvuevP51Pm7QtNZMM=; b=VIgdES2Ci27FXCevvYIFqN6r7m
	wjBwH7j1ojL3eg+ctuipZs6ikCRiRAsdiZ1wuts56ERxC6K3t58ucB1mdEVpTdjm0xR6DWptuIjsX
	p5MfVmyG2YMUZlNrGNGM3ToWLXPc+8qfL7deLv4Ev0I2mJ6cU5gmRGgmKV4suqEn1NpTV+YQjc7Vn
	xWhhDttMC+4jEDo/7n/lOfTIemWN4meUbHUQ21VSV7tI2F0a8PtKfY0iKdX2C1/SaT4eA58jIPMuJ
	dJF3g8x96kOqO0egAPbI95ZH/P0paHfiVFdNbdaa7OiUoHX8lpRVH4UroVg0vXIYi4rXNrdzGh9sQ
	cpiOP+Zw==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1u7YWE-00000001h0w-20rb
	(return-path <jgh@exim.org>);
	Wed, 23 Apr 2025 11:43:58 +0000
Message-ID: <b613e5d2-b1f0-4d3c-833e-969abf2af082@exim.org>
Date: Wed, 23 Apr 2025 12:43:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] TCP: note received valid-cookie Fast Open
 option
To: Paolo Abeni <pabeni@redhat.com>, Jeremy Harris <jgh@exim.org>,
 netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com
References: <20250416090836.7656-1-jgh@exim.org>
 <20250416091513.7875-1-jgh@exim.org>
 <f5d244d2-acd4-4dfc-8221-93d2a714b97f@redhat.com>
From: jgh@exim.org
Content-Language: en-GB
Autocrypt: addr=jgh@exim.org; keydata=
 xsBNBFWABsQBCADTFfb9EHGGiDel/iFzU0ag1RuoHfL/09z1y7iQlLynOAQTRRNwCWezmqpD
 p6zDFOf1Ldp0EdEQtUXva5g2lm3o56o+mnXrEQr11uZIcsfGIck7yV/y/17I7ApgXMPg/mcj
 ifOTM9C7+Ptghf3jUhj4ErYMFQLelBGEZZifnnAoHLOEAH70DENCI08PfYRRG6lZDB09nPW7
 vVG8RbRUWjQyxQUWwXuq4gQohSFDqF4NE8zDHE/DgPJ/yFy+wFr2ab90DsE7vOYb42y95keK
 tTBp98/Y7/2xbzi8EYrXC+291dwZELMHnYLF5sO/fDcrDdwrde2cbZ+wtpJwtSYPNvVxABEB
 AAHNMkplcmVteSBIYXJyaXMgKEV4aW0gTVRBIE1haW50YWluZXIpIDxqZ2hAZXhpbS5vcmc+
 wsCOBBMBCAA4FiEEqYbzpr1jd9hzCVjevOWMjOQfMt8FAl4kUrYCGwMFCwkIBwIGFQoJCAsC
 BBYCAwECHgECF4AACgkQvOWMjOQfMt+dqAf/bLKl+fzSgRXtW8HALADDAxTwcJKbF+ySo+P6
 0G5NGGTqYpajbPxER+WpCa1O4pDKs3XU8HyZQx1FhBskYlUyoiFXfFylliGwDXv5IeKdh9VP
 IiWshZuRIJe8DmGclH22vUKdM2ZkRMPspYxIGpJWLnvFGE/97CiJsW39fZotffWszb9nIxBU
 POsNnKhrA3c1pn8kN5PhyfOy5CUwO1xmxlTYpDiAxwXN+emNipxpje/YrTH0JFWDd8Tl4/m8
 DfFpTJdahfxkcF4sQve/DU/aHboB4KSRmDyRqyFj+DX5wp1sfdHX6/gpwwQW3M+lP0wxs0gh
 aFJsKRNh5dQk2m2UPs7ATQRVgAbEAQgA6YSx2ik6EbkfxO0x3qwYgow2rcAmhEzijk2Ns0QU
 KWkN9qfxdlyBi0vAnNu/oK2UikOmV9GTeOzvgBchRxfAx/dCF2RaSUd0W/M4F0/I5y19PAzN
 9XhAmR50cxYRpTpqulgFJagdxigj1AmNnOHk0V8qFy7Xk8a1wmKI+Ocv2Jr5Wa5aJwTYzwQM
 h4jvyzc/le32bTbDezf1xq5y23HTXzXfkg9RDZmyyfEb8spsYLk8gf5GvSXYxxyKEBCei9eu
 gd4YXwh6bfIgtBj2ZLYvSDJdDaCdNvYyZtyatahHHhAZ+R+UDBp+hauuIl8E7DtUzDVMKVsf
 KY71e8FSMYyPGQARAQABwsB8BBgBCAAmAhsMFiEEqYbzpr1jd9hzCVjevOWMjOQfMt8FAmRa
 a+cFCRKczCMACgkQvOWMjOQfMt8wLQgAuNQkQJlPzkdm/mvKWmEp/MW5SsYROINr21cFqPXY
 y+s8UwiDshe+zuCQfXxxSH8xbQWYEKHOgQx7z0E5x8AppAUj0RoN7GxkPzBdoomfKhx7jV8w
 43YjjpMFbktM2/44lTaselejQbcGH7jrgFVK0iifeoPS0x2qNE6LhziIU8IWMSLZffXP32+n
 EqMr4m1uKna3j3jt9jQh8ye2oz4VdVy0NbQDVKgMP4b7gShtIq1i0cxJNviyQ+tOANW92I2K
 la6kUvwL6g9ovBVHxf01RBCxE+ppjb9N8y58qzwnP0c5X2UqTIBhfNWKRLonvJ5RQeb3R1ZJ
 QJ5Ek2AV21/7Zw==
In-Reply-To: <f5d244d2-acd4-4dfc-8221-93d2a714b97f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

Thanks for the review.  I'm preparing a v2, and a patch to "ss" in iproute2.

On 2025/04/22 11:36 AM, Paolo Abeni wrote:
> The commit description is missing.

Ack.

>> +		syn_fastopen_in:1; /* Received SYN includes Fast Open option */
> 
> Worth mentioning in the commit message that this will fill a bit hole.

Will do.


>> @@ -401,6 +401,7 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>>   				}
>>   				NET_INC_STATS(sock_net(sk),
>>   					      LINUX_MIB_TCPFASTOPENPASSIVE);
>> +				tcp_sk(child)->syn_fastopen_in = 1;
> 
> Likely you need to reset the bit on disconnect().

Added.

-- 
Cheers,
   Jeremy

