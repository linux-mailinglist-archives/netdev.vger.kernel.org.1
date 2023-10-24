Return-Path: <netdev+bounces-43808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2C7D4DC5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E94B20DDF
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C505F2511F;
	Tue, 24 Oct 2023 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT+d7B4a"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29F26283
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:30:52 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DE3111
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:30:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so8098a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698143446; x=1698748246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrsY5SMpX0KhMxGlL3VcqlkeSm0skgCjxoXpak2azgY=;
        b=nT+d7B4aVQNCGDPkOvARBEpL7iqabSuv2BLBnKqi6qB7gnHQWTK6jB4Il+w4dRqV0Z
         yFqnig+qv/0VzDNVKwx/Kx+GugLjE1kiBiuk29vP1DmpI1bTHZdV/m3i/tOZp4bfr9W+
         vLs3HNjSG8euU98bK+fyVk9/iplT04YUveHZAN7sCcoszETns0600BgXyoPh0JnjE5V4
         /GWFqqt7peFHVs7C19mUumJhMNlFwdmTrndVGuOUWL3fBrUpn4GWfUcS3nwtkE4+UqQM
         3hfIk9pjLKUZPW8gYOmFFHgCzJICs1DKGU41QIvGYrsAcwv0xF+5RZ4qi/lGMRoJimfz
         hWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698143446; x=1698748246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrsY5SMpX0KhMxGlL3VcqlkeSm0skgCjxoXpak2azgY=;
        b=FS3/Gcs1MLnjPAAbIZheubTJ/cbER4YES2Y+CoECAoP/UZGLD2bVDlHKb+OmR0AFDj
         v+nQ2BD1YtC4mH8HzBszEa7lzgdn2X8msKu2aiCxynoEi4Laj3lYSj/D/feRXqfXF7b5
         OstCSJuHcJvzm46UjKW0V9OV+bqwumHQ5NvbHvlEVlnUnvuJc6LPYMUv6e9Hl1peappu
         ecUGhwKfE/8HWqj3F54R0FlfTKo5pga8gwYEwOWOdJQTZ1r1ttcSPRnMyGHlcRXPrbbS
         0CqBxBWC+XCeFIw97jkg3g+ZXpJsSi8sGWyw/14/noz6gOdcmwj6XjK4gZxljkZXF1qb
         fNCg==
X-Gm-Message-State: AOJu0YzRHrXFmf9sjVYXv0TXzOzMwN5i4D2pfjwwvABHCRP8iU/9jkYO
	owK9Al8ol6MJZYBbnVS/ds82sbH3KEd0e53qNeYrRw==
X-Google-Smtp-Source: AGHT+IEayzEbnMU7KkNUnMx0j45kuBJVJCbt6AsX3FsNeWab2ahnXcU+1K1FPi/X+kZKl568n2jcupQXxPtNyDHJkEg=
X-Received: by 2002:aa7:cd4c:0:b0:540:9db8:e357 with SMTP id
 v12-20020aa7cd4c000000b005409db8e357mr71204edw.0.1698143446154; Tue, 24 Oct
 2023 03:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698114636.git.yan@cloudflare.com> <a79fe77d7308f7e6de7a019f23a509b84cbacd79.1698114636.git.yan@cloudflare.com>
 <20231024102201.GB2255@breakpoint.cc>
In-Reply-To: <20231024102201.GB2255@breakpoint.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Oct 2023 12:30:32 +0200
Message-ID: <CANn89iL8LfGJF2xJP0JhW7sMUXiMdJGAe7jhL0XW3pVMG7cmkw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/3] ipv6: drop feature RTAX_FEATURE_ALLFRAG
To: Florian Westphal <fw@strlen.de>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 12:22=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Yan Zhai <yan@cloudflare.com> wrote:
> >  #define IPCORK_OPT   1       /* ip-options has been held in ipcork.opt=
 */
> > -#define IPCORK_ALLFRAG       2       /* always fragment (for ipv6 for =
now) */
> > +#define IPCORK_ALLFRAG       2       /* (unused) always fragment (for =
ipv6 for now) */
>
> Nit: Why not remove the ALLFRAG define as well?

I agree, this is not exposed to user space and should be deleted.

Reviewed-by: Eric Dumazet <edumazet@google.com>

>
> Otherwise the series looks good to me, thanks!
>
> Reviewed-by: Florian Westphal <fw@strlen.de>
>

