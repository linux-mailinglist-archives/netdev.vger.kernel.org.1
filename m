Return-Path: <netdev+bounces-52206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4827FDDDF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E71CB20E63
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4D3B78E;
	Wed, 29 Nov 2023 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAb8pb0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAEDB6
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:02:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b422a274dso87875e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701277338; x=1701882138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLapLfMiK02kYDh1bquJqUL8gsBXcNy1X+KHQGHXYD0=;
        b=wAb8pb0xsD//iIrmeWbbXmp2q9DzNfsuu/lcvy8xzxcNGgm1rSpIQY9pCQCSBrG5nQ
         rp0QwEpP/kteaC6dyvu7F26mTSmrs6itvFzrtGstmpWaQikLZf/EWtY2bf79v+xnXIbk
         cohBUH9Fp8XNxTJVZbEI9VLyE6iNlTyLVSLjjisUa0OZL905jR6Hp97HYPWL4BT82rxw
         j2S6AbmKDlGKp+WNDcZHRpjuGUaOMN2MIQdBobC4mL4xTBmFd57QLuKczRSRTVLpdXu9
         kTDc+xtvutNX5uPKkFw0tz6HJjxOcdaediU0qNDp8kSoNg3qtwG6NUx3rl9HV4S3Fbob
         LaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277338; x=1701882138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLapLfMiK02kYDh1bquJqUL8gsBXcNy1X+KHQGHXYD0=;
        b=N3lg7BcpF4IMfcrZ1BRv44QZImgsg36bgXMj6QbP/EbG8UhwAJaMHKpnFMXAFeLRT7
         VqN76PsGURWFVSh5XYyUuEw6f9ix09dH+6r5rq9Gz7ShHq3OkO895Ocrnu2mwAEKMsks
         juULuoPxRpt8/Qx+I3+MR7UsRNFhnF4u36vlHCOZ1cEm0azIY27EUzYOatMDOgOQr1MV
         EM3IDYHH5zk+XJLjlawK7WrWj9a1VG3AajKV6mmhSjSq+eepLyTVyBsI9PGc3CMHJtHo
         cEJlNKHXN4Je/kV9PfDNe8FlYABDyGlEFuzvzGOl86/YabXThN1S9ZwSx8ZbaJA1zX7H
         W+yA==
X-Gm-Message-State: AOJu0YyROSnC4o7r5Tk42VdYHkpHFY+5+suNL0kyn3gPsCHudZfN/BQP
	umjbfWt8rhJfJoARlfCYrTlgXtujlNFda9zOhkTR7A==
X-Google-Smtp-Source: AGHT+IFBkpteu493p6KGhPWnWumYPbA4E84jTO/ph6gkjrWloQemnVn+ZZ7IdYxics91NQxE3ePslWlS5OqrF/dxV1k=
X-Received: by 2002:a05:600c:3c83:b0:3f4:fb7:48d4 with SMTP id
 bg3-20020a05600c3c8300b003f40fb748d4mr949555wmb.3.1701277337573; Wed, 29 Nov
 2023 09:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-3-dima@arista.com>
In-Reply-To: <20231129165721.337302-3-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 18:02:03 +0100
Message-ID: <CANn89iLr53_W2183MU97Eqd9A4sZp7M_kEB79sLp+1pPa7pFcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] net/tcp: Consistently align TCP-AO option in the header
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Currently functions that pre-calculate TCP header options length use
> unaligned TCP-AO header + MAC-length for skb reservation.
> And the functions that actually write TCP-AO options into skb do align
> the header. Nothing good can come out of this for ((maclen % 4) !=3D 0).
>
> Provide tcp_ao_len_aligned() helper and use it everywhere for TCP
> header options space calculations.
>
> Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

