Return-Path: <netdev+bounces-160764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D5A1B42E
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0D63A7A22
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDAC21B196;
	Fri, 24 Jan 2025 10:54:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09B21ADA4;
	Fri, 24 Jan 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716053; cv=none; b=TSwgJRBchB2gFXF/wMKQXGgKYzDubgs1J/wtecQxfHQ1a4AarIQgFzQXnYnOCPZVrLKoRK4jADxRPNQM6uIkRz+sirueGPH/Lbj7kDC+m+V8gLpQPCQEP4NLcLh4YKIai8u1Jm4LXlUljVPkk1JTIUKwv+rC61PN2VVDVAjZrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716053; c=relaxed/simple;
	bh=3vFoRvl5iwIxE7CqMjQHnlQODkOxOcxxJedSEXTxJRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LJvqqONaGTJbLzSSgTVcftq0Uxi5WiJAdaN8FwjYyJOqcJ+7aCXWmJTNyWZhbG6XUocJ7TbzKujgLtfcCszVhneKG4u3kJ/15a1ifXHIaZLpRnCbwejaVHQOtc9ph1f7gLCR04ZLNVwfpmMKQKWtwvlGibOudq3kLVIqi3NOgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YfZRs6DPrz6K934;
	Fri, 24 Jan 2025 18:53:45 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 272961400D4;
	Fri, 24 Jan 2025 18:54:07 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 24 Jan 2025 13:54:05 +0300
Message-ID: <96feafd3-de2d-3a0e-102a-40418ab79848@huawei-partners.com>
Date: Fri, 24 Jan 2025 13:54:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] landlock: Add UDP access control support
Content-Language: ru
To: Matthieu Buffet <matthieu@buffet.re>, Mickael Salaun <mic@digikod.net>
CC: Gunther Noack <gnoack@google.com>, <konstantin.meskhidze@huawei.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241214184540.3835222-1-matthieu@buffet.re>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20241214184540.3835222-1-matthieu@buffet.re>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 12/14/2024 9:45 PM, Matthieu Buffet wrote:
> Hi Mickael,
> 
> Thanks for your comments on the v1 of this patch, I should have everything
> fixed so (hopefully) this v2 boils down to something simpler.
> 
> This patchset is based on
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
> Linux 6.12 (adc218676eef).
> 
> This patchset should add basic support to completely block a process
> from sending and receiving UDP datagrams, and delegate the right to
> send/receive based on remote/local port. It should fit nicely with
> the socket creation restrictions WIP (either don't have UDP at all, or
> have it with just the rights needed).
> 
> @Mikhail: I saw the discussions around TCP error code inconsistencies +
> over-restriction, and your patch v1. I took extra care to minimize this
> diff size: no unnecessary comment/refactor, especially in
> current_check_access_socket(). It should be just what is required for a
> basic UDP support without changing error handling in that main function.

Hello, Matthieu! Thank you for sending the second version and
checking these fix patches.

We decided to implement errors consistency fix for the whole LSM [1],
but your patches will merge well with current_check_access_socket()
refactoring [2].

[1] https://lore.kernel.org/all/20241210.ahg9Zawoobie@digikod.net/
[2] 
https://lore.kernel.org/all/20241017110454.265818-3-ivanov.mikhail1@huawei-partners.com/

> 
> The only question that remained open from v1 was about UDP rights naming.
> Since there were no strong preferences and the hooks now only handle
> sendmsg() if an explicit address is specified, that's now
> LANDLOCK_ACCESS_NET_UDP_SENDTO since the name (and prototype with a
> destination address parameter) of sendto(3) is closer to these semantics.
This can be interpreted as a restriction only for sendto(2), but I don't 
see any better options.

> 
> Changes since v1 (link below):
> - recvmsg hook is gone and sendmsg hook doesn't apply to connected
>    sockets anymore, to improve performance
> - don't add a get_addr_port() helper function, which required a weird "am
>    I in IPv4 or IPv6 context" to avoid a addrlen>sizeof(struct sockaddr_in)
>    check in connect(AF_UNSPEC) IPv6 context. A helper was useful when ports
>    also needed to be read in a recvmsg() hook, now it's just a simple
>    switch case in the sendmsg() hook, more readable
> - rename sendmsg access right to LANDLOCK_ACCESS_NET_UDP_SENDTO
> - reorder hook prologue for consistency: check domain, then type and
>    family
> - add additional selftests cases around minimal address length
> - update documentation
> 
> lcov gives me net.c going from 94% lines/80% functions to 96.6% lines/
> 85.7% functions
> 
> Any feedback welcome!
> 
> Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
> Closes: https://github.com/landlock-lsm/linux/issues/10
> 
> Link: https://lore.kernel.org/all/20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com/
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> 
> Matthieu Buffet (6):
>    landlock: Add UDP bind+connect access control
>    selftests/landlock: Adapt existing bind/connect for UDP
>    landlock: Add UDP sendmsg access control
>    selftests/landlock: Add ACCESS_NET_SENDTO_UDP
>    samples/landlock: Add sandboxer UDP access control
>    doc: Add landlock UDP support
> 
>   Documentation/userspace-api/landlock.rst     |  84 +++-
>   include/uapi/linux/landlock.h                |  67 ++-
>   samples/landlock/sandboxer.c                 |  58 ++-
>   security/landlock/limits.h                   |   2 +-
>   security/landlock/net.c                      | 137 +++++-
>   security/landlock/syscalls.c                 |   2 +-
>   tools/testing/selftests/landlock/base_test.c |   2 +-
>   tools/testing/selftests/landlock/net_test.c  | 455 +++++++++++++++++--
>   8 files changed, 715 insertions(+), 92 deletions(-)
> 
> 
> base-commit: adc218676eef25575469234709c2d87185ca223a

