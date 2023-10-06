Return-Path: <netdev+bounces-38588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF17BB8D9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4771C20990
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0475E20B0B;
	Fri,  6 Oct 2023 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="HSN6NSDf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD01D55B
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 13:15:54 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAA0EA
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 06:15:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4060b623e64so13340415e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1696598149; x=1697202949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u3No+tEtAczGHwk0FS59fcQbsVL06vZXyJIYRaE8Tk=;
        b=HSN6NSDfHuPUIZABk6fniy+XCebR6Ky0HHEPfDyGFE4qZsFzQhRLUDULIzTPuzZWRm
         AqvpfHapEnEkzdZJyJiARXgNfioa7eupWS/4wpXtIdPoDwYhTOtJKgg7zjeq1qXzTh+b
         QLBNctw8fRIePWnduK/phja/gRANMU3B5sEbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696598149; x=1697202949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u3No+tEtAczGHwk0FS59fcQbsVL06vZXyJIYRaE8Tk=;
        b=h1NBnmzM0zdzt25CiQAnFLzdJgTmae8TvtNHBCUm8WpNfNEKR0SP5caJqGAdlE/4AE
         jOMQE4qewFwiCT8NvnvxWIFx0k+9tFeEgz822vjHkVhHZGvJRa7FsSubvlzbsDhdAQJY
         q+wBzls4eOKfg0wQQRxycvNYfRHuO0oZypn80u0UiczEII60fNNOL2m9bMG/bjQ9ePur
         1oFMLoAKkr/UZtxGbOhC8E7iayeBaWByh50DIsfHbjygnlzBLX8PzbWmBawiKsJ9/w+P
         FYoms4rUXVfsZ3+s28eKvYCuSm4DpwzMxmJvZndE+GUQ73gQDKGndZUb6EV6Wmlsxqvh
         ARIQ==
X-Gm-Message-State: AOJu0YzSmn+YGoT1YIeA5j36e8qG3WrWJ20H0TJAMu4bsUWuj9jjP7TC
	PHxqRd0FKRCIGLSPHYoKWWmcSl4C5UwL5OEaJjS7
X-Google-Smtp-Source: AGHT+IEhVvOcQOtLTbsHnMfSpeq7GltoUpxG99Rgayd8nZ8RlSHyh7d1e0syV2RPhnErDHz48fOjez/pJ/HH9GmkPGM=
X-Received: by 2002:a05:600c:3795:b0:401:b92f:eec5 with SMTP id
 o21-20020a05600c379500b00401b92feec5mr4056905wmr.9.1696598149645; Fri, 06 Oct
 2023 06:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005140831.89117-1-roger.pau@citrix.com>
In-Reply-To: <20231005140831.89117-1-roger.pau@citrix.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Fri, 6 Oct 2023 14:15:38 +0100
Message-ID: <CAG7k0Er8cVKHF2NwogmXtuN57iYb0rGoQH4aZgg7boy2Hv4-fw@mail.gmail.com>
Subject: Re: [PATCH] xen-netback: use default TX queue size for vifs
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>, 
	Paul Durrant <paul@xen.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ian Campbell <Ian.Campbell@citrix.com>, Ben Hutchings <bhutchings@solarflare.com>, 
	xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 3:08=E2=80=AFPM Roger Pau Monne <roger.pau@citrix.co=
m> wrote:
>
> Do not set netback interfaces (vifs) default TX queue size to the ring si=
ze.
> The TX queue size is not related to the ring size, and using the ring siz=
e (32)
> as the queue size can lead to packet drops.  Note the TX side of the vif
> interface in the netback domain is the one receiving packets to be inject=
ed
> to the guest.
>
> Do not explicitly set the TX queue length to any value when creating the
> interface, and instead use the system default.  Note that the queue lengt=
h can
> also be adjusted at runtime.
>
> Fixes: f942dc2552b8 ('xen network backend driver')
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> ---

Reviewed-by: Ross Lagerwall <ross.lagerwall@citrix.com>

