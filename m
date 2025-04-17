Return-Path: <netdev+bounces-183702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF7FA91947
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C0B7AF604
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1817C22A7EE;
	Thu, 17 Apr 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="kcrKepOK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="hyfmq+8F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F340A55
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885588; cv=none; b=lvaTapCQjN++ae74hHqbbJivh2ViFi12QV1qrOZLUe/8+cywuFt3E0qeXjmwwcaQBSvL17i0/VOW3Ntixt8cWe/c4+K8A2rKUneSMn3ckHsaEMTTBKFP93GwpARHjMrgqXwaiRDbzT6mJohopGGSEryzneHcdwjSMbkxeIFDA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885588; c=relaxed/simple;
	bh=/pr56dnvB2J7fsHAj5aq3zpk0PNHF6JeQjq0U1sS9kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuPO+oEprUfYUEp246WGnP2xhM1tHdOoON15khYRWcpnf7ynRp70gCHizHxHlfXpjzZyz6Xnd6X7pSF/fpDsA6ZoOYTi2RyPzEnIJ9olunJhyViD/izmIe5JVDPcQ6Tea3g+PFSHkM2uQit07rgYnV1OJsAhUV95rv0yvXdGTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=kcrKepOK; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=hyfmq+8F; arc=none smtp.client-ip=85.158.153.28
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
	bh=+RwE9InggEsni0ynXIiJwfZ1elV+iieI89NSYopSrAw=; b=kcrKepOK0efrNfbdnJo8JdWHWc
	9RSkYmnUBfABNZ/62k8xqquQZVx7QO51/+RArfJZXHtQAb2k5P4ridcORQAg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Autocrypt:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=+RwE9InggEsni0ynXIiJwfZ1elV+iieI89NSYopSrAw=; b=hyfmq+8FAxUi8iWvVJIPpQOtOm
	hOJ1liYDcwzgFb2ODoJ0EiuaoRLFU1K7LMv93EdjdIsEJQ70NeTzovq42pvyVwdNa3KlKxHYj4uty
	hn9da4JINlI7fztRuhlW/+G+W3S4PacfVv2xK6Morv0slGrDz22Urj3IFQu+/b1POMVTpD7XTt+l2
	wOmzNp4aEY+TY+gW9yrR5AS/TCW7YMX1MpUAGKa61GpX6pmyLNA7DewypBCyCcmOYKbzFjz6ZFb9j
	aoJXySPjdLliwvPY42/eFmttrc590opqxPZWTTRIDlsnm1/f0bTjFqnxLZiDAnL+99hA7KAVgUtgG
	/DYGoTEw==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1u5MRp-00000002HEB-0IAp
	(return-path <jgh@exim.org>);
	Thu, 17 Apr 2025 10:26:21 +0000
Message-ID: <6054b382-40f8-4718-b1ac-63194b37f333@exim.org>
Date: Thu, 17 Apr 2025 11:26:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] TCP: pass accepted-TFO indication through
 getsockopt
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: edumazet@google.com, ncardwell@google.com, netdev@vger.kernel.org
References: <20250416091538.7902-1-jgh@exim.org>
 <20250416192705.16673-1-kuniyu@amazon.com>
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
In-Reply-To: <20250416192705.16673-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

On 2025/04/16 8:26 PM, Kuniyuki Iwashima wrote:
>> +#define TCPI_OPT_TFO_SEEN	128 /* we accepted a Fast Open option on SYN */
> 
> This is the last bit of tcpi_options.
> 
> We can add another field at the end of the struct if necessary in
> the future, but from the cover letter and commit message, I didn't
> get why this info is needed at per-socket granurality.

An application is operating at socket granularity.  The provision is
so that an application can tell what is going on with each one of
its comms channels independently, rather than (for instance) the
rolled-up information on the entire system that the existing
statistics counter offers.

> Also, This can be retrieved with BPF.

If I understand correctly, BPF is aimed at sysadminss probing
or modifying system operations rather than production use by
an application.  While your point is true, I don't think BPF
is a good fit.
-- 
Cheers,
   Jeremy

