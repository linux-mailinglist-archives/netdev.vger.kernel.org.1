Return-Path: <netdev+bounces-52466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9BA7FED43
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9974E1C2025F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6780432180;
	Thu, 30 Nov 2023 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGuq1hRK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0A3D40
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:48:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so8298a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701341293; x=1701946093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykGjQrOjmniE2t69HYM3rTxvcWLyuSJ9pU8gnEfKeyY=;
        b=FGuq1hRKeq9eSB+0NbDRZHFILIa+hByGCQtadaRPo/w2447lvzKjYU9zsNn7wK0TXr
         cUDECiNfeAizEDFMbzXy6oS2dpLM9BEz0zpk7IHGlxOIJZb6PR/DaFGY0D6IB9LaoC2B
         hrPIg6E1lJrrgNvv3WmD5SSdELUtGZh6eJ17tp9d6F721mj7x8b9mX0nvBw4L5vBwvzx
         icNwHow/fgTbH0vRS6YDDLEkEtNFCJEA+a2Ixr+EYM9J1U5pR4CV3K+eolZV1spEAnA5
         ur3B82URIiCTDl4RJVeVLM+AOX4fs+VsWwt4vNiiIC+b3eBLNi0Vq8mFsloxSgLAEeWB
         WwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701341293; x=1701946093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykGjQrOjmniE2t69HYM3rTxvcWLyuSJ9pU8gnEfKeyY=;
        b=vIigZCmUBsXFyyk01bMjmfnoN2j0On5zbblQ5puzpJVbh9GuSn1HsTqKDiYp6ZuMGq
         Uhhl2zaYyM9QUs3LtsxV/VbKxLvEjvJ7mC1TXMHKEeIO4VQzOrWuYJBDxml05j2p+3lO
         7pxrVCshIHKstQSO92k1RjLacsRowZ8F50BmyN/EHBWdhxNm1dYqgvedgRCyzlGyg/so
         gaLmARwe+dgnNERkI5N4oU7QgV/LmCLIG5w5TbzYWMiS/T/lNrFfIOL5bfZ8bb89s8ZS
         cL1goVavqMd53XNIoPqEhNhQZZmXraN71b5priH1M/SrV56JxPPWTQLG94LtQbpB+Y+O
         J/Bw==
X-Gm-Message-State: AOJu0YwW+8Aw3CvCaDOkGggz0LC3JIMKcR/wnyzz5F49yPSt/LP6/l5A
	/T8NYWt7nGkFUpKsTm46OjCFg0jxEAGEHvYF5ZcNRw==
X-Google-Smtp-Source: AGHT+IE/yB3oJDjknguCIHwoq95dBUjT02qjY1Bsr4blVKyppsIUzx1rp2gOgbuADIrmpyLcx6W9V+PIrxy7C+/1hNQ=
X-Received: by 2002:a50:8a8d:0:b0:544:466b:3b20 with SMTP id
 j13-20020a508a8d000000b00544466b3b20mr99444edj.5.1701341293082; Thu, 30 Nov
 2023 02:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-4-lixiaoyan@google.com>
In-Reply-To: <20231129072756.3684495-4-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 11:48:02 +0100
Message-ID: <CANn89i+FtEQbT0ADuNVTdr=zqx6HdQKKXp-W0CCJ=ykxxGQ02A@mail.gmail.com>
Subject: Re: [PATCH v8 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast
 path variables
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:28=E2=80=AFAM Coco Li <lixiaoyan@google.com> wrot=
e:
>
> Reorganize fast path variables on tx-txrx-rx order.
> Fastpath cacheline ends after sysctl_tcp_rmem.
> There are only read-only variables here. (write is on the control path
> and not considered in this case)
>
> Below data generated with pahole on x86 architecture.
> Fast path variables span cache lines before change: 4
> Fast path variables span cache lines after change: 2
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> ---
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

