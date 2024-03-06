Return-Path: <netdev+bounces-77763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEA7872D7F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19EC1C216B3
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF40134B6;
	Wed,  6 Mar 2024 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="OgJGzG5u"
X-Original-To: netdev@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57912E7C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695566; cv=none; b=l+MIvJrapk+mXQwuhqNV5bRSions354vPLTkl9uC+x5LiDL32ZufOPO/E2CbNcFOAYDTh0qfIkUCXYJlfpXYiwaQnBhHZDBkK/4TNTFTMrGH6cir45aGigwASsieFxz2DAceEkBZfTOug16N1cSOp6FSbCXvpaU/6NBnN8ESUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695566; c=relaxed/simple;
	bh=zAReeEU8/qi5a+yFDj7UXBuoBjH1MPHcc7huo3+zByw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3RLIQPuW93zYK3IKaMv/ahBRvFjFIMbspFNJ2fccciRrQh8gITTMVUlvdU7y0wxodqKCYfWCwEqPUq4KOn1KlRIstVdgY5toEsg9+BsRHgV5fsGQts8Wl4a4ZxtCG2gxt5/phy/dWImLwy2PxYJ7S67GO0j665sBLg7Qca1QXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=OgJGzG5u; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id h5f7r4o6Vuh6shhumrMgzz; Wed, 06 Mar 2024 03:25:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id hhulraWnr5geahhulrLJgV; Wed, 06 Mar 2024 03:25:56 +0000
X-Authority-Analysis: v=2.4 cv=SomW6uO0 c=1 sm=1 tr=0 ts=65e7e244
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=XVdhlGlpZy0Tqqe4dGwA:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hA5anOLDf9hOII6ZL+mpHqZgQ3rs+L/N8KnCrTRwBMY=; b=OgJGzG5urvOSye6X4o/ZpFKHHX
	TbW58mPd5ZZTTYRrOfSOsYbTltFxdq/haZS2WgK4RzIVvF6vv1E2KwmkmgVoaO8ts84sRaGGGLy4A
	JpAIy29MWILwYRBPY6ygZJ4Xb6JkMkR0A+20gaC9EyZPjW7qw9J/ld6ZpVB27UL+u2Dci3Tm7caLY
	5OAiRCHSdvKjD8WrqiQCXOTi3bKUV0622cYY7YWN3zFrPjmKNiCaL6qnNrlGk/iGjnlFYrTqYcKAm
	wU5U99v5vc0nvjAba/Ymv1j9eur9ovuP/TcwFBetIXAZgib48WQgdySJx0DyGVd/JeGNheFLMa1kv
	vArK3QuQ==;
Received: from [201.172.172.225] (port=46818 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rhhuj-001ukg-2u;
	Tue, 05 Mar 2024 21:25:53 -0600
Message-ID: <9c2990f0-7407-49c6-9e3a-b92de82ea437@embeddedor.com>
Date: Tue, 5 Mar 2024 21:25:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] overflow: Change DEFINE_FLEX to take __counted_by member
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org
References: <20240306010746.work.678-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240306010746.work.678-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rhhuj-001ukg-2u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.172.225]:46818
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA8DGcUdBAEWzM6mHEXsqDz7n6R+LSpJMyB+OOO4WAlRmQOaREzeKPg5e+wpI6I2o+pxvCGzzsXyyyHxMWqL4DVj2Pu9bOE2JtwG8y1oa37ar+sE8tCO
 Iixy582qMbbabfhsAnquSRrcK7YhthXQ0PcoOqeCddtEYrrwdp9JDW8c4gO61dFauICMpJtO1XenTtWigGQ5QlEHmXk3HyZ7YJM=



On 05/03/24 19:07, Kees Cook wrote:
> The norm should be flexible array structures with __counted_by
> annotations, so DEFINE_FLEX() is updated to expect that. Rename
> the non-annotated version to DEFINE_RAW_FLEX(), and update the few
> existing users. Additionally add self-tests to validate syntax and
> size calculations.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

[..]

> +/**
> + * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
> + * flexible array member.
> + *
> + * @TYPE: structure type name, including "struct" keyword.
> + * @NAME: Name for a variable to define.
> + * @COUNTER: Name of the __counted_by member.
> + * @MEMBER: Name of the array member.
> + * @COUNT: Number of elements in the array; must be compile-time const.
> + *
> + * Define a zeroed, on-stack, instance of @TYPE structure with a trailing
> + * flexible array member.
> + * Use __struct_size(@NAME) to get compile-time size of it afterwards.
> + */
> +#define DEFINE_FLEX(TYPE, NAME, COUNTER, MEMBER, COUNT)	\

Probably, swapping COUNTER and MEMBER is better?

	DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)

Thanks
--
Gustavo

