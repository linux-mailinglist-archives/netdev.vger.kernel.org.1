Return-Path: <netdev+bounces-162200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CB3A26203
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC2B7A1E9C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A714920550C;
	Mon,  3 Feb 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="KVYnc9/M"
X-Original-To: netdev@vger.kernel.org
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA502C859
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738606462; cv=none; b=eACPhM8wgWo426WA19mj9zvIZyF2LxDMXNjAFAbTzzmcfaOiy0HTGNd12tKE1G056VH74iHCctqhliQksefQfylN60vuFezUUh9mbhHiN1VInlqCLmdqpUiGtfKbLpvTRCkLZmLDF4IhDO5+VlgS1fCojc//9R/TCsYFUNYaZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738606462; c=relaxed/simple;
	bh=4H/1WMt6VMCtIZs9zCa0ttVpZohm7D2tzopVyWLjqDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BE9f1Z5HS6iPvoOqSjk+ZoA3e3G/FyWlR0KZH5dvjDsLvauB28TknBR6NsyusgsXZZL7scmPxhUyGoBjV3ayYVDG7Z3dn3Y0WmjnvlTvdeOi16T1pB/b3CJP2hh7mrfIhH9NJ2okfKDPoH4bzjifRwv6ZPVILxghLRp6M1u7cxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=KVYnc9/M; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:362e:0:640:4be2:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id D2EE960F80;
	Mon,  3 Feb 2025 21:14:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6EoCWBKOo8c0-uaX7CA3Q;
	Mon, 03 Feb 2025 21:14:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738606448; bh=4H/1WMt6VMCtIZs9zCa0ttVpZohm7D2tzopVyWLjqDc=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=KVYnc9/MEnf07JpA4OLdVWYYnGWQTnJQZVupqLNd8LlgnR+8G6gpTsnb9gV7G2lAt
	 +Q+UTUhy0skWsxwtw1RYFaSTheDyYrXD2aoYMMOxmxfOzy+yJWBR1UH+opKVISMm98
	 wwSeplx72WaE5zaJg0er1I7eg5ZHdl0jjALmFztg=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <48edf7d4-0c1f-4980-b22f-967d203a403d@yandex.ru>
Date: Mon, 3 Feb 2025 21:14:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun: revert fix group permission check
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jasowang@redhat.com, Willem de Bruijn
 <willemb@google.com>, Ondrej Mosnacek <omosnace@redhat.com>
References: <20250203150615.96810-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20250203150615.96810-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

03.02.2025 18:05, Willem de Bruijn пишет:
> From: Willem de Bruijn <willemb@google.com>
>
> This reverts commit 3ca459eaba1bf96a8c7878de84fa8872259a01e3.
>
> The blamed commit caused a regression when neither tun->owner nor
> tun->group is set. This is intended to be allowed, but now requires
> CAP_NET_ADMIN.
>
> Discussion in the referenced thread pointed out that the original
> issue that prompted this patch can be resolved in userspace.

The point of the patch was
not to fix userspace, but this
bug: when you have owner set,
then adding group either changes
nothing at all, or removes all
access. I.e. there is no valid case
for adding group when owner
already set.
During the discussion it became
obvious that simpler fixes may
exist (like eg either-or semantic),
so why not to revert based on
that?

> The relaxed access control may now make a device accessible when it
> previously wasn't, while existing users may depend on it to not be.
>
> Since the fix is not critical and introduces security risk, revert,
Well, I don't agree with that justification.
My patch introduced the usability
problem, but not a security risk.
I don't want to be attributed with
the security risk when this wasn't
the case (to the very least, you
still need the perms to open /dev/net/tun),
so could you please remove that part?
I don't think you need to exaggerate
anything: it introduces the usability
regression, which should be enough
for any instant revert.

