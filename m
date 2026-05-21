Return-Path: <netdev+bounces-290599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENTGMRlXD2o8JQYAu9opvQ
	(envelope-from <netdev+bounces-290599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:03:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 431A65AB530
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A74C3025A60
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B66400E1B;
	Thu, 21 May 2026 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWJWdznW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D83FFAA8
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390186; cv=pass; b=n8jioRjWn+tCWDiK+LC1cjKtL/6gF42K3SB4RCHtYsNTN2uP9gSDduo3hU78mSYzB8JPsUPHmvuAwkUxqNKMbN+YDjA4qGIOAihA7KOkwXEug7AslZYkBYaBRnc7GsntT5nE7tjHGu56B3Ph/Fpyzcd7X0ioVJ6HmCH/hesbvc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390186; c=relaxed/simple;
	bh=eU9C3eldjspdtWrfxsD0cBqCaUA7FdDCoYoJYJ707LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLH2ir1J+w4jPCZNyjL9TOi55e6gMgnj9JLqp8ziYDL4vvma3cZmLVvunhZ1a7mLJffuvk0qeJNWVgPMf230nEt0y7lpcxL92QqCXRRI7aIE/xTJsWhHAq4xWcE3t1eGhd4bb842ur+eKHCtQEqiMg1+Ex863pYQRFuW3zC+tck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWJWdznW; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so14502555a12.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779390182; cv=none;
        d=google.com; s=arc-20240605;
        b=bxqARdATrA0up9dDPijTHTqCBXA0ox/7d6tInX/XdVfN9GPNCJZEOq+0rmMWeNP+cV
         u6Mo3fBHO2tRyhzGKr1zJCN5qZ1a6qM+fU2ECStiXU5sHrFep2taQz6W9jI3vTsYXCBi
         XbBMlRSNnZSwVCcw+LywCpV+zWbpQXeWJa+OVaydPziQUvYxbER8GkuOHbjJlTLerWoY
         R8Fk8EEX/l8qVGxdzP57hVp22cKVNTEOJeYAZaeAQRo7d6Yseb0tsx1ip5pztO6A6/KA
         WjvEwtlm6VXtxqk+p9IJMUW7SYYDO5uh4T/8t/A4sXlcemBgpxTZk8mZ8yBOzv75iaY3
         Dngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vWTHXMq/uvSomrBLkUGFWEuMqZyKiswcu6U6iRS0yzQ=;
        fh=hyzL3TVtVY+BVYTZp1Sb3zyg8wV4dhvw4ovxwJvTFcI=;
        b=dAl44OSprDpcCxOHR73o2yHEXYlcUuo1852veQfzsh8Ny/cjn0Q352MjLEQuRMjnap
         8uqrmgabDYj15kimOZyA7j6YbBqhYXf2ogMFy6WWBAC2qvVuPfVXae0FE+d4rZae/L7A
         4eWxCIOkq/eHjPRo0QJMkD+kXnxC+x0Fbcljf+AOOAx2f6FIm/CkdFv8/W7GHml8oZYk
         717DVjN9s9E8qOrInaXqEOFh8t5xP+xDFGeM5kaJNQfqNI9sQ8el0lVdYZqF9cDbSK53
         1NlZ+Pj3MqETuPo7VjQgwyQ+js2L20LorjkbpSe/YkPOQ4Hj/ZLgfC64u004xVXY3ZvB
         C9BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779390182; x=1779994982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWTHXMq/uvSomrBLkUGFWEuMqZyKiswcu6U6iRS0yzQ=;
        b=PWJWdznW7eQ+sMtA+4cB3sok2R1SjFrM+WGShXJXANJ07Q8BwAfpg4byiqzZjXvoB3
         5vciUSZORp5t4hDMfaLD1Gfkb3pxiNuIQdKA3qBZWx3/kWkYPIuyLyZae2YfPEY5i1s7
         xwQ2+lhGlex0dOhJ6F23yHXNELBTSysu9E713h+VFjRnEZPfwwHBymxX94AXAa7Ra7Bv
         2EMzT7YuYexwfvZoty3SUaQtBDYUaxIx5fuU9g3H6eEaahxDWJqzQ4/BBoLeAA4I3LTS
         eymN17IKfsusOUTQ9xbKczWbAio5qbw0vYLVUgalRDw3Nd7n0xdz8rpIpJnN3ZHxMBEQ
         oxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390182; x=1779994982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vWTHXMq/uvSomrBLkUGFWEuMqZyKiswcu6U6iRS0yzQ=;
        b=MNJ+QDSGYcPpGbSb4lL1EyQvb1+iCAVrj4upVU+W7KckN+hq94+ioGlGX0kNZ9wbdv
         m+RL+qPAWHoJW/ndFJv8FddxFNXC1J8PGCxEDJwa0qQ2ZG6vKIVFv0Y3pBDrsdRDD8SM
         Si30816EBuUeBzwhBEBWNrpK//VIEOo+IHlMSwBdkn/Hx3abcNszK/SFvDn8MEDV+X47
         r10R/r9f2xAaWJ+uAQ0O5oIu/7Xb9ZUqEAPNT2Vv2m+iIzfkXfPPLS8ZrKLtRJ6vWN7O
         JkfiWyXzM5mFc0vOdSIC2g9kFfJG2EUJMGtD46k0+QItz6tFcevD4efwjbOjixF7CQKw
         s4aw==
X-Forwarded-Encrypted: i=1; AFNElJ+w+gSyjDY6iIyo7z1wT0n9KCEAj4sja3j/Ng2/9hCT0N+xgcABcEeWkWkggchP66WD2NHRnEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3U7kKX3pJuNCTgy9grJRGgT3TS8ZtX9zsEVrAR437CNQ2VS13
	9Ks3VTElj75LOkyk5SV5NF1jCo3ZMJ1ycyAn/6JcQbcbNTnZs1ltTn/nw6XT5nX63CKtm4MgoLx
	9qPbx7Y2He8wshupeZc7/ktNDfu3pPuc=
X-Gm-Gg: Acq92OFL9zLtTNfOywHjVA4UbVNT1WexZt0wsNcFiLkH2WYmc/9nipQhUqVjqM1SsjY
	kuLFHAirGQoJBk80d9h765exgditqtvHnxLBulHjWt6dBMTg9xeDsCwpmaDI1vWSbxa8u0Wi7yz
	91TMxjvLfU64iGRsC3ZvWGGMVt/qT9g9VgrG4/rM/6u+CaipftWKH1ljITBSBkerdkIhvNeyTWX
	mPS3DjMO6XLey7uy0aED7gRGBHniOYr7M4Cv+BiOr/7D2k2TmLunr5/9dN9E8EOmUxlQ2annHVf
	2M7RUwsHK3UmYD6hBqKrvFh7ZaQ0xCM1zoz0tS78tZOC6cPmkZ54Cn9WCil3+GegczzaS2YjpOL
	icv3kt7Yl6xtc9/anp+VHSqU0hPzO4XvvjdValQZu/nF7lgyHbmc9R8cB8g==
X-Received: by 2002:a17:906:ef0c:b0:bc6:2bd3:8176 with SMTP id
 a640c23a62f3a-bdd279d1b58mr37926866b.35.1779390182272; Thu, 21 May 2026
 12:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517033621.1839397-1-rosenp@gmail.com> <b9a1ce9c-1f5c-485c-8d65-bb00c7850842@redhat.com>
 <19663d71-94e3-4b6f-ba41-7920ea5935e3@lunn.ch>
In-Reply-To: <19663d71-94e3-4b6f-ba41-7920ea5935e3@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 21 May 2026 12:02:50 -0700
X-Gm-Features: AVHnY4JUydPp5wSYlDt2uqlTYcmfjIJzrzTtQL38nEywuVoPj6FjZVSjjFFCMAo
Message-ID: <CAKxU2N99WxMRM5v1C-Qiqe4R18u51437B3bmA1VjQW+qE-OzcA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ibm: emac: Clear MAL descriptors without memset
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290599-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 431A65AB530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 5:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, May 21, 2026 at 11:45:25AM +0200, Paolo Abeni wrote:
> > On 5/17/26 5:36 AM, Rosen Penev wrote:
> > > Clear MAL descriptor rings with explicit field stores instead of
> > > memset().  The descriptor rings are carved from MAL coherent DMA memo=
ry,
> > > which may be mapped uncached on 32-bit powerpc.  The optimized memset=
()
> > > path can use dcbz there and trigger an alignment warning.
> >
> > Sashiko noted that the compiler could still optimize the above to a
> > memset(). Perhaps a barrier() is needed here?
>
> Maybe my understanding is wrong, but the compiler should have the
> knowledge about if the addresses are aligned or not, and so if it can
> call the optimised memset, or needs to keep with individual byte
> accesses?
>
> Has this patch been in user for a while, a port from downstream
> OpenWRT or something?
Yes and no. These devices are currently on kernel 6.12, where the
warnings are present. In the transition to 6.18, I'm fixing them.
>
>         Andrew

