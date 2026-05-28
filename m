Return-Path: <netdev+bounces-292584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMO3F572F2q5WAgAu9opvQ
	(envelope-from <netdev+bounces-292584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:02:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BE25EE311
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54625301451E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E05D32ED5C;
	Thu, 28 May 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cngP+3li"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020483016E0
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954965; cv=pass; b=JKBX9V/bh8BX7w++Pi9nlbmCRUTzcyPC/OAP4MJ6sMsLEs06HoLntUsEfnzBVzrpYnenNcVpyHc9kIrsFW6+Ad8Zx2koF+aOKC4Jx3VkZcYbQjqhSU/eJqjJQPSWQJWoYzCCPDCynG4yHF4fOZ4fVt63pMfr3Y3X/9Pnh5xSJss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954965; c=relaxed/simple;
	bh=hkwx/QqtlFrYLSUYjSVWXxT9V7UxEPt9pqmRV2kvQ+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtmEufxZpwoHzq49TmzhYnhKzKmxx+yh3ogdq+6e9PW/L+/Qsi7e7aYvh4NRjcwv9MxZJILYze/z53+gqZyDoaTq4efs1l5bXT7rAAMeLBDEYT0Gd9zNhpaI3tbv3IfQ4yZKV87QT1zok+XRV4iA7k/IlD5lOx+Fge9ahz4P7JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cngP+3li; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9639b1ef167so32611241.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779954963; cv=none;
        d=google.com; s=arc-20240605;
        b=HLCKmTQeaWzsVmwPNQLOfAhKnwOa8JCr8/Hf6Gu2OtZwWiMGMonI/AwG3zft/MJNxb
         o0gJAYnZxrk6mbpy38J27Y2kWXV+c7S7j1I0teQMAnA73WPyMO1BnOjA+OROp0oB3N/X
         zw6Lugn48lfjTXTh+uBJykz9tnJs+0rLqKlgO4y+s6bz6n6bkmrH8DJJ1nwW+41du5v1
         qCx5E2AoTm/2SGDLTMxPq5W37kZTBpGLlI/chpjJQMPRQrkXdk5leu0hbLlhrYISsVI8
         uIHwvX5mdsllLXpmsEXzQNwQFHOhPvKwmPK+wQdUax2d/KQZeH0PfqblOTC7TLbjufmo
         NylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VFolBHTHctRcgOmhLZ2X1Ve+6vqUoRz+SuXWq82uSoo=;
        fh=LrwjDNbctRWC4IWBdC+DSXm1hPOLkuj6sUM1yLO/zwc=;
        b=iAty7Vu7GDAkTGmJCoV16UJU4zIbBO/aGJP3di1ml3EkEr292eVbAcQfxr8mVZ4t6f
         e+BHUF8vXVwEywetQgVOWTXUnAXrpWUB56kh4jaHhi4GcmQ+jwML4H6mNYco8bfO2ueN
         mlsqQSsPnzRuRO3Jo8QfpQmze7gwUhjoluUT8ir24DCjjzOdSkn9aVEOwIRtNuiUUT3f
         9eQNVMvQdffXGUW7KD03RT+66vznf6UCrb9aAQuWHu/TCpnnPawMUnB8fBMpNpZpHJcl
         aeYNxJfSk4zWT/qHAaZVqQGclCNJSLgSIuDxXdr2bt1OjsSq0Z5Z+pCoaXNdGeev2wwk
         J6DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779954963; x=1780559763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFolBHTHctRcgOmhLZ2X1Ve+6vqUoRz+SuXWq82uSoo=;
        b=cngP+3livHDcgXNQsNIUAAaZkEwJugmiETGCFttgtSgu9zOYVvsF9cVdS79yH5PLp+
         tjIGYeId/76si/OWVkbwP1MINFac3noXf73GJWcIYa7n96AQUEdWurdQWZUOnlm90aJ1
         UnTWPHoDNGpqVjJdpmf7An6y8m+3MzfdXmHIPZ//VXKw0en7Ckc5NaQN2x4X2rJI/YPZ
         yRgewTJQbJs1FngiZMhDKpxBgbhUlPSEKhu7oh5wEggho3t3lfqumYAwtca0TJV5shu7
         zCKlJBsipNnxynpJncgnq+5+3U0uigcQI7R6nhmL1x5USUDFLHC7jB4mSmJf5tG60ux0
         20rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779954963; x=1780559763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFolBHTHctRcgOmhLZ2X1Ve+6vqUoRz+SuXWq82uSoo=;
        b=qOtZBgNMRjsOPeou0UXCVxpk4tbteUbHifpSDBrwY5odTK7Q7pOkI/zXnSgHQh/Rlf
         N2fBXiSZqmM09EwBGZXYB0JM7Du9Ot4KgO1D2KEWgMAVwFsxvxtpy1SQV1LUnc8OuUjr
         w6aV0BOguAbuXWwFO6FNDN9rc+rq9hdng79HskZsGhuiUm/m40/pak7eA5ph9oSI+zfI
         UMZzRhlUwTjNg9YOo/xZ3Tz9NRfdHrPyTRcIb08eMKSh8kgXSdvt3+QkX9stZTJ+CBYd
         7KtlKGCL5zeX2RX1hLW5CTJsmhEeYR3HbwLxheBQ3OYs22QNpvlRbGtm8bB3drB1JWLe
         +Q7g==
X-Forwarded-Encrypted: i=1; AFNElJ9C+2w7n6+PE9ecS6puhlBpa4WuI2HW3v3gh4Ilnjy4C7KODHeq/EN+yUHxdXxFzHBmoCTr82o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2JMHYbtFUA4eRwgiAPJ4qlnZlj1bn5r6mByy+uFp6GbnGP+/X
	07FwBre2uARlLD3MIr1uwcDqtr2DTtUmAzUOxnmeZowyv1sLU+PqB1OLEyXjnsbEX/Lw2SEL0SX
	9uFdapNUv06OLM5M0oEi/UpWOFebrWEA=
X-Gm-Gg: Acq92OFqGtpPxhtlPGGQ22Ywc5bjh3ZHDXdNgRObyS+/4Is1zzGQH0caKGhJ4JD4/5M
	+hA5By7HDcP0rJVYripxa4jVzzQmv6yT6MYb0xcl/YedkPo+NoJ0jnatDOnm/IMzuQJM/LVbnkD
	Xve4EJbQ+BUCnpD2z3VgKuQz+SxzTr50ZmXZwLRd05cxZd9dG+4fpHhn/NvJt0GLz6h5pzRMFV9
	T2+32ZmqJjCMKFZeAx70p6AB5wcHeXNYLgUAJh9lfmoWFWIqjeUTmCp7dIq3DRN2pz5mxoCW3PX
	Fn41aj11UbKj0vvn5DfJ965/ctVyYrX5tVYJ6sZqfRr+RSlPRYGj
X-Received: by 2002:a05:6102:418f:b0:650:94b2:3839 with SMTP id
 ada2fe7eead31-67c7152364dmr13252893137.7.1779954962816; Thu, 28 May 2026
 00:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-net-next-mv88e6xxx-cbs-v3-0-2f387eb5ff63@luminex.be>
 <20260527-net-next-mv88e6xxx-cbs-v3-2-2f387eb5ff63@luminex.be> <31F2127F-685B-4409-BF0E-21CB378B2CD6@padl.com>
In-Reply-To: <31F2127F-685B-4409-BF0E-21CB378B2CD6@padl.com>
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Date: Thu, 28 May 2026 09:55:51 +0200
X-Gm-Features: AVHnY4IWeIQ1T1SbUdE5e3WCaxiLHO2uoLBWwEfTrp1c7ew69Utr9pdzhQi70hI
Message-ID: <CABvLYuBGAL7zWZhs0L5eqyzVBGqr=zbA-NGs2_ELptND4LiJLA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
To: Luke Howard <lukeh@padl.com>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292584-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,padl.com:email]
X-Rspamd-Queue-Id: C9BE25EE311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 8:28=E2=80=AFAM Luke Howard <lukeh@padl.com> wrote:
>
> Hi Cedric,
>
> One further comment: the Marvell DSDT reference implementation (GPLv2) al=
so sets an undocumented register on the 6352 family of switches to enable C=
BS. (This does not apply to the 6390 family.)
>
> My understanding is that you should call mv88e6xxx_port_qav_read(MV88E635=
2_PORT_QAV_CFG) and then set or unset MV88E6352_PORT_QAV_CFG_ENABLE accordi=
ngly.
>
> The values are given below:
>
> #define MV88E6352_PORT_QAV_CFG                    0x08
> #define MV88E6352_PORT_QAV_CFG_ENABLE             0x8000
>

I'm wondering if this is needed.
I can't find this in the UMSD, which is newer than the DSDT. Why was this
removed by Marvell? And the register is undocumented.

Cedric

