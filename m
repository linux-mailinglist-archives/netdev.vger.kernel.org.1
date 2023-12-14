Return-Path: <netdev+bounces-57420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD28813120
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458A41C214E3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0719A53E3F;
	Thu, 14 Dec 2023 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeNqshmt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D104116
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:16:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso9210a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702559814; x=1703164614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOwx/mzdDKXszuaQLdYZ1msi9ylZyxJ8mX7DjwOPBEw=;
        b=jeNqshmtzVItlAWzSzV8k3NGNGlSbaJlo0wClasTi5q3siJPbUBufJyjHQ+7JeFSy9
         GcJ7QdYz8voqHQg5JilAaqYRRAPjrp72jeijcdb0VCd6dNfkZjswZXP+QZrq9ohW0Wu4
         oL2hRRRnrX/Hkd4BvxJyvs9pu1MS9T2Q3pgCDMyCksC4saUAka80RB595tjaSHoBzXi3
         2C8Ha3xWvaJ6h3PnWV+NZMbqpBRlr3gd8EalTjTd7Mj5w5vUnVCnGtNHE+DO7JHFTVLc
         LGl1p8fwasGipoTYWuiN7fnz1SJk35CEP74tZOIxfbQ6OF9DwmLaa4b1BF6I+/u+OSWH
         0Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559814; x=1703164614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOwx/mzdDKXszuaQLdYZ1msi9ylZyxJ8mX7DjwOPBEw=;
        b=p8pf9RsU9kcnFAJYhyblcun0lmVJd+3CxAWA5/50MWLqU0lct2MuQthDdaslArKID5
         QFW1Jzvf2GrUyTAHCfXBfABcLWK8UPMFMVV7ZrTORWus+/EcK2VIroBkWRyl2UdBCeZ1
         ywOOON+UTjA5Cb0wXLaZzATWWBks/Opk+DXKWAn088AdaDbrQolK17WcOU9WrCGYOMXB
         N1bFD/w0/SUwlfo4oS8XTBuv0jMLGHHI+f9pQjBJ2HsT7gBxQ6W0LuPemaxkNQh1u0SZ
         HKkOTbq0a7a1rokiSAMsZBBBVWFfgWYF1w6Yan/5GxtIVi3bes3w6zUKJslSYAW3Qn0i
         Fhkw==
X-Gm-Message-State: AOJu0YxCLVSINkBLmMmOqUtBMzAq6v++LTyh+6Y3Jr+xLosHCJ/3UW7S
	vgMXkWoGW2AjrI+57GsZb886hIytHHEAq+lOn33ghA==
X-Google-Smtp-Source: AGHT+IGPDxq0uza/+XgXG2IMOVmp4USK/BgaYfsY2x/YbZF38+w2YUrljG49XX3YUQ0U6joCplt/Sk0pleh5niEVIrM=
X-Received: by 2002:a50:bacf:0:b0:54d:6a88:507e with SMTP id
 x73-20020a50bacf000000b0054d6a88507emr682903ede.4.1702559813499; Thu, 14 Dec
 2023 05:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <63bd69c0-8729-4237-82e6-53af12a60bf9@gmail.com>
In-Reply-To: <63bd69c0-8729-4237-82e6-53af12a60bf9@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 14:16:38 +0100
Message-ID: <CANn89iLcXjzWQSs9VW-=c0d0YL0Ksc4B54cTYZawUUnBkSLRNg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipmr: support IP_PKTINFO on cache report IGMP msg
To: Leone Fernando <leone4fernando@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 5:28=E2=80=AFPM Leone Fernando <leone4fernando@gmai=
l.com> wrote:
>
> In order to support IP_PKTINFO on those packets, we need to call
> ipv4_pktinfo_prepare.
>
> When sending mrouted/pimd daemons a cache report IGMP msg, it is
> unnecessary to set dst on the newly created skb.
> It used to be necessary on older versions until
> commit d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference") which
> changed the way IP_PKTINFO struct is been retrieved.
>
> Changes from v1:
> 1. Undo changes in ipv4_pktinfo_prepare function. use it directly
>    and copy the control block.
>
> Fixes: d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference")
> Signed-off-by: Leone Fernando <leone4fernando@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

