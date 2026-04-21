Return-Path: <netdev+bounces-280254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IxJMsLt52mhCwIAu9opvQ
	(envelope-from <netdev+bounces-280254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 23:36:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 762D943FC75
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 23:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D4A53052896
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39FD3DCDB1;
	Tue, 21 Apr 2026 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="YKya8M+p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442619CD1B
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807290; cv=pass; b=SRpTBC+fI6IuskKbA1294mV0qSX8AqpuVLrNjT0NQt5edqKFzJneSLlo2OuQH/z85gQr/1b8QysSg0YGCedRIoRWCUAz55Scze7gREeZNbO4SMDc0BSKAZgsJpWYTmfHaUwDuuJv/rQRVlMknzrdhhn4aM9QN2zy7KARFPavTNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807290; c=relaxed/simple;
	bh=CNb+tRlhSa+ap/C1lp5GwDLIrgQst2MxGRx4ejuGA7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3pDuDs4ba9NnwlM4Dypt6MV1v+zxB4fqiCGI5lNX3MUczdF18LWTk5/BW5ICWDLm24NUvSzakTbEggMucE1V0zUZoVieIbrb/ePxdyzW/dX0kyV23ZAe+q/lukHA7oKXpSEmQ4175O5L+oOqOCropc8hLXFmqxF2RExB/vFvOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=YKya8M+p; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79db5e18ac6so59145237b3.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776807287; cv=none;
        d=google.com; s=arc-20240605;
        b=a94jmgjI7GnTJ33NL/LDntLOGtcUfTr1Sjs/MucdtfGUgtncs4cGsx/AnL2JYOTC5Z
         W+MLz4NLKzmDaVii0VeXionWlxMNwdPHNWILE56KXiJ6Go+OwoIu9TuiwPDmTM4km+CT
         +5T+V/8BVONNzNyAYA+nhkTy+sCp/ZRqi5TUPx9b4T0QDXAVYf7fm0tvZfMTjaigVfhn
         Urfuw52kNxML9AAPhQVarIebVl/T1Zsucm+AwVST4YoM0Vpjcbho/zDXL2S5ZPnNU2r2
         XwdftglOwZD9omBP7kANjt6nEKZ/WQqhaGoOPU3kMYfEx8+kGfFc0tfaO8zJ/T4GHpG0
         dWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CNb+tRlhSa+ap/C1lp5GwDLIrgQst2MxGRx4ejuGA7A=;
        fh=96vO9PzS39GwF3/gUhyMtJ2FWsVlWNXsV1pcdgljONU=;
        b=ZGsAMrhT2f7oBerZOeCMpgbbRp08/i9lurRIDNHKuTKz3rM9iBJ/ozYT/Rtv2ES/MA
         WsgskMKUXhCiES5ERDE74uhkhDPkuGHtRMPkCUsxWDgERi4TAC17XOdLz0rifJp68QVY
         AjGHXRjvLumnhVK7rKAbQ25ivM3lJHkrHkFyDgBYr5BSAeSa/AFhiGf0z/eMDF/mWanZ
         jKVA86/N+dSo2lc7D0nVtDogqSjPQYC8qYrZgc2wW9m6tkIlbB/KDSYQXsFxXtA9dh+x
         UjAKkF0TfdLSMOXa2ThT+DJrPadaNsLc198pcKKmyiCEWYWpBOlY6W+LHDAIux5KwuYZ
         pf/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1776807287; x=1777412087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNb+tRlhSa+ap/C1lp5GwDLIrgQst2MxGRx4ejuGA7A=;
        b=YKya8M+peYB/WJOw1qzf2tMUWwFNqm2PymkGgmMUH3+lHHqngS4LEzy47rXhrmeEaY
         h04iMDDKCyN5v9BZxcZqdNHr7V1CsaHWzPy0nZVL0x6ZfUGeOaG1/7taAsZ62zDhKUfY
         csZeFLXULU3NmhXNRUYzeGRmNgDySL7QqkCSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807287; x=1777412087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNb+tRlhSa+ap/C1lp5GwDLIrgQst2MxGRx4ejuGA7A=;
        b=i9xra4cnNpdtcmVwd8wkgW2cg1v5gH0bLkEnMXiyaJbppFs/ftaHlvu9u3p7/Ncjln
         aHTxJWfoQL122hnw/zkzjXKcBdEVfTxV+BSe+doxWWZz7Vuo8lWob6Uj5N5tz+o4vP9X
         y12g+xinlWe0h/TvlPByWV9zL0AslTGAkYMby0S1Cns3tQF8k4YQY7+K86xVjJ3gNW0X
         NCTXPCvOB/o4YbEuU6c4kg1RRr0R2wdhLPlzxV1qjZNB7EiKQf6hJ5xOAnY/JMVctabN
         gd1hKRdyNsTRUHR7nuVXx00gEcK6SbLUx9bX7dXUgtieYuAkVWnOrxSvaLMEYoeh/BCz
         +5Cg==
X-Forwarded-Encrypted: i=1; AFNElJ+RQVVj9ifdc+NqmtAO7l0360MAsvhPEBbxOUbeSqL0tcReTLpd6NQShBJGQn/XDQ7h99dUc/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkPb0VbAXn37Tlk1PJ/W1mFPBUbCcaZpylTXouUn1aIiUAq4H
	bbdJirIvm4YMx1gOMOSQvUCBwA9xiG9BqFAf7ZFnbGgYm7xF1XdcVcihS1o83bWABbX5dycgQ9a
	2kvZvfjLqKJpD0dr/DSfRO2gY5mGxJNXrveUKA5rnPQ==
X-Gm-Gg: AeBDievb6mGAmuwgY8W0mfE/FEJ8IsDbo/9Se/zuB+mNEIE4EnLEoJtEB7Fx2tAyWVY
	LESfPaPMHqVm3xmoX9gUx06m7/4r8tnq78JhbzegeLJll0Lo563CMjy4W5sVE//4++tEMNBtmko
	DyP8C7VUkPANfnju2EPyKBx0rOLVmopQJB3A4kvLVys5WIX4mlZSI/4RmIvaTTtlneARQCmElpd
	VF+5k7JNDHWLUAy2s6A+pFxqaXb3m00+eki3g5ITpXEehhWFGsQn9asPgYOxqs1MQv+Lpgf2FCa
	UOly4XQzwyx/ENjR2A76z0WyaGhniXbU/2hQeAoHtV+aCi67U/E=
X-Received: by 2002:a05:690c:3181:b0:7b4:ad41:482d with SMTP id
 00721157ae682-7b9ed276d75mr150110487b3.3.1776807286998; Tue, 21 Apr 2026
 14:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
 <20260421-v7-0-0-net-next-driver-removal-v1-v1-12-69517c689d1f@lunn.ch>
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-12-69517c689d1f@lunn.ch>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 22 Apr 2026 06:34:32 +0900
X-Gm-Features: AQROBzCe49AfCvVC9cn8YlKac5QLSyex0DDcogmQpbxNAaVurwjo7KrBmDLXCYw
Message-ID: <CAFr9PXk9GMmPWeaURvgQySwAHtFDxRH7B43u9mG1P_v-oJmzNA@mail.gmail.com>
Subject: Re: [PATCH net 12/18] drivers: net: cirrus: mac89x0: Remove this driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0x0f.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280254-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[0x0f.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,0x0f.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 762D943FC75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On Wed, 22 Apr 2026 at 05:01, Andrew Lunn <andrew@lunn.ch> wrote:
>
> The mac89x0 was written by Russell Nelson in 1996. It is an MAC
> device, so unlikely to be used with modern kernels.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

I think I might be using this with a mac and I'm running mainline.
FWIW the m68k mac stuff still works perfectly fine with modern kernels
and there are people using it.

