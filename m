Return-Path: <netdev+bounces-185111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D27FA988DB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668FB1B66406
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161320E00C;
	Wed, 23 Apr 2025 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="MZBIW8TG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="mN+9qoyk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355DB211A21
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408920; cv=none; b=FaNUumLEVfWWc7YuDiUX5WZfIq7NGkTG9dPRPRwZxv6+GV1a6bCzxazaa5G7UL/zfQshrUOTjOeyrHE6KHTnHg6yu2WOeLep0KJOydbDddCKrWQv4PmfVYx9M/XyH24BHvrcUtm1sqzHTrWqO3a7b5/2wK0BrJiYDW0aGuIg7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408920; c=relaxed/simple;
	bh=ULcqbt3EGF2MNAUoPtw5+9lyCqwWXkgoxyYDAOKLFoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHBU6wyYyLuvSUQLRAx+HtPpBy9ainwdntrVjTtknZu5XrsU68qv7uzG5ZuiLLHQtHDuy4BEaETJGk8Qe+dlN4r43NI/W+gX4DzBlkIG4ie9zfxyl2ml19odjS0hKatO4KaG9Hi2dMweHRBoG3ZWClvmIBvuWVEtlcC2zmN7KLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=MZBIW8TG; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=mN+9qoyk; arc=none smtp.client-ip=85.158.153.28
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
	bh=fjI2/jZRplnpKKCY+1ZuAMauLeBrFFdMFRkHuAQUpmA=; b=MZBIW8TGMVS1j0ot2dd3teJiyr
	54G5deecB4H7eek9O3SyB2wLbFECu3RVposyzxDx3WgEHJz1Y8hagKnReqDg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Autocrypt:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=fjI2/jZRplnpKKCY+1ZuAMauLeBrFFdMFRkHuAQUpmA=; b=mN+9qoykHvQ4kLGCerJ46W4oJ8
	x+eUg3za0kgTvIpeUvB1ctPxl8it2wgaDYkpFjH0mPWAKzXgmAMH8xasbjwsUs89yuOpie2/YQIQR
	/b2/EMwIqjGk6OVdeVMjhUltxQpTUfCisssIPZrAEMY3lFmok309toTy1Y12+H98Us3kOBzNkTD9t
	kdEhwd+ZVFy8lEA05a8Lz03ciFNgrddZ/p2sn8t6xYdvi6S1cOl0t69tUCxzqctanyKYDjl5NZPP2
	w6VPIDbd5rtS7zp8nLXPhh4SE0P/IcuzdNXsq0o++sUA9/f95pVaQMFYbZ9VS0pX6LzKfpXNel9Td
	ORBHj0Cg==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1u7Yai-00000001h95-1MoI
	(return-path <jgh@exim.org>);
	Wed, 23 Apr 2025 11:48:36 +0000
Message-ID: <0607b63a-7555-44e2-b040-949a34c07f12@exim.org>
Date: Wed, 23 Apr 2025 12:48:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] TCP: pass accepted-TFO indication through
 getsockopt
To: Neal Cardwell <ncardwell@google.com>, Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, edumazet@google.com
References: <20250416090836.7656-1-jgh@exim.org>
 <20250416091538.7902-1-jgh@exim.org>
 <CADVnQym3FmsuCOZdjhf+G42xryOmGLT23gBiHdam2fDcMv7TFg@mail.gmail.com>
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
In-Reply-To: <CADVnQym3FmsuCOZdjhf+G42xryOmGLT23gBiHdam2fDcMv7TFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

Thanks for the review.  I'm preparing a v2, and a patch to "ss" in iproute2.

On 2025/04/22 4:50 PM, Neal Cardwell wrote:
>    TCP: pass accepted-TFO indication through getsockopt
> 
> Please use something more like:
> 
>    tcp: fastopen: pass TFO child indication through getsockopt

Will change for v2.

>> +#define TCPI_OPT_TFO_SEEN      128 /* we accepted a Fast Open option on SYN */
> 
> IMHO this bit name is slightly misleading, and does not match the comment.
> 
> Sometimes when a SYN is received with a TFO option the server will
> fail to create a child because the TFO cookie is incorrect. In such a
> case, a TFO option is "seen", but TFO is not *used* because the TFO
> cookie is incorrect; so this "TFO_SEEN" bit would be 0 even though a
> TFO option was "seen". IMHO that is confusing/misleading.
> 
> When this bit is set, we know not only that the "Received SYN includes
> Fast Open option" (comment from the previous patch), but we also know
> that the TFO cookie was correct and a child socket was created.
> 
> So I would suggest a more specific bit name, something like:
> 
> +#define TCPI_OPT_TFO_CHILD      128 /* child from a Fast Open option on SYN */
> 
> +       if (tp->syn_fastopen_child)
> +               info->tcpi_options |= TCPI_OPT_TFO_CHILD;

Done.

-- 
Cheers,
   Jeremy

