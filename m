Return-Path: <netdev+bounces-58787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D519818385
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 09:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0CE1C23983
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B142125CC;
	Tue, 19 Dec 2023 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8+dGmau"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56D13AD5
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so29875e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702975013; x=1703579813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siz1aP3ObfhV4yvlFrkOWXqqkGRhrBfwEAj7xN3VCkc=;
        b=s8+dGmau0ecN2Rm/XX8jbqcubFhOEM7Q02plPS/tbWXiFH6RGMgUb6Ltb6hwtzuEbw
         faCPkSKAgPJmz+8+EiBFdVfltn17xN/49Lhc7f2qytbMMYdvRL5DwVSPuruV1WnjShAv
         ModI2kL/0mOL072khqMvIjpbgCMHlLC+cmi/VMb+z8IsFsbQX5E+npqtc6JZ6sXEGeq1
         r96XmZdnb+FABlKIBUBYKzfZmU35xUFenA7pUoJrfnqiRLaF4NjJcW9Lruki4uq9i1r3
         QTkvGHFEicPP2TVPUaMOieCeYmU0s53Pm7UKh0WTo2qMqd6rMJT9/OgDFRi/NbDe8wUW
         YEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975013; x=1703579813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siz1aP3ObfhV4yvlFrkOWXqqkGRhrBfwEAj7xN3VCkc=;
        b=unPKXggBSHcoPDhxD6Nr1tsaG0gUalNoDFoO1sWyB4nbIHU/8F7qCSM+m4AbKv/wvI
         hxkNmhDHqaArDjOuQC3glUU3ZnWANz8xLYPylIIEHJqc3lF/fyYhCJI4uJfG9kgh8TU0
         PjA9Z57lWrD3/WAicrbO19tv8yQ0DyHGK3zkEA8T1RKPcgouIEgEOR4te9k54G1DNZjI
         cDAqwbh3zNddxp5cSULNr/dj4ujp9nJ5bU7vleEJse+DW2AC1a4E3ec0mGebklj7cz82
         1XzcF6UHB5kxiJNbMRbODGP791UrRjC5hXs1S52v9Zc49Ce6um2TsPTtfE9Y4zh98fQx
         Vc3A==
X-Gm-Message-State: AOJu0Yw2rC1uxXmLF1KIgm5j+dADHBxq0yXWNdttby1cKOp/8leIwaXs
	WyyjT0+jlViZu40oh36I6kWpR7z2EHwcIl+2jqi1SVNBVfVFx78kemtslF99Eg==
X-Google-Smtp-Source: AGHT+IFhbmGF1uEujzNNCq8sm6ZyN68nG0N4kWBCfPpYcuUq0ItEQwatBppBMdh4wszbrgxGqNcAdAY78NWfjEoMlVE=
X-Received: by 2002:a05:600c:1d88:b0:40b:4355:a04b with SMTP id
 p8-20020a05600c1d8800b0040b4355a04bmr124420wms.6.1702975013384; Tue, 19 Dec
 2023 00:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219030243.25687-1-dsahern@kernel.org>
In-Reply-To: <20231219030243.25687-1-dsahern@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 09:36:42 +0100
Message-ID: <CANn89i+MV6eKwD774-_Rpfx2oeAj5umAxHoveLCpM+fiZi5xBw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net/ipv6: Revert remove expired routes with a
 separated list of routes
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:02=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> This reverts commit 3dec89b14d37ee635e772636dad3f09f78f1ab87.
>
> The commit has some race conditions given how expires is managed on a
> fib6_info in relation to gc start, adding the entry to the gc list and
> setting the timer value leading to UAF. Revert the commit and try again
> in a later release.
>
> Fixes: 3dec89b14d37 ("net/ipv6: Remove expired routes with a separated li=
st of routes")
> Cc: Kui-Feng Lee <thinker.li@gmail.com>
> Signed-off-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

