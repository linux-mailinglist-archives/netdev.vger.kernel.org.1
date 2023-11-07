Return-Path: <netdev+bounces-46347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFBC7E3449
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 04:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C281C2082E
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 03:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17368A20;
	Tue,  7 Nov 2023 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3RncPv0g"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8E6132
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 03:44:26 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070EDD57
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 19:44:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so24025e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 19:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699328663; x=1699933463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP2Iv5ELrzaYeydQncBJF2e6SJXKbOLGVt01FUaqFHY=;
        b=3RncPv0g4GdWmSVAMYDsqIzqJLVvRQoE4iLNFxT2GUei3hqS3nkg9o0U3HbqANEMWE
         32UEnpgTGCWxPVnzXbAkurpp8NofeuB/UMLr/bNMV1EOQVlsRcll6qM5AWgggvoafWYX
         PrRn4DOoCgnvL4qifeubONep3IzXSZEE3/hlKTVXaqgHhKaNMhx4ei5fdf3oLiF4Kg6L
         o7tRiJOipNQ7xVLEVw/gnLgZ68y/N6WAvi0AKxAhRaQOjrj/uLHkfqCzKwezvf3fGDmm
         CYtfdAAY3s60z/NMyvGVfIC0Tcw0eaUh+KNRfnFde0ChXYYevfGwEExoM0vFEA6NBNrb
         D4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699328663; x=1699933463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP2Iv5ELrzaYeydQncBJF2e6SJXKbOLGVt01FUaqFHY=;
        b=YupNNBF0eDgnCB+OOdhfibDjt4QxJ1StlV0Zq9/p4uG/U3+5xBc0UC/wXIdQf9m6/n
         sDPquBBVheaVdz82OrN1WfQuLaJZuVmtFWMJCZDsiEzy4Lwr7BDSqG7FRpFUFCdmX7I+
         faHkEIr3Sj7yMKeG1bXrI9QXMVaqrTLSiABWgUOPi42Wwm6gXIBKonRmUvo//EaMQazH
         AFmGMo34ooN6SNRmSgQxvJl3BbjKJBta+b+acLIecxjjHK2Pvz0JWvoVT6aygAfQ9Rmc
         PB4RkKkVRe+G07Q0YMMo82bMadUcXC1tGAXe+chU29NfWa19tlsVbf+VMW9/91vqasJK
         xarw==
X-Gm-Message-State: AOJu0Yzj9GqxxO3jWt+6PH4V7eRWdS+Wl2FSt/JQyRBTlfq0NlZ9Ptkq
	RBdXG4bFemCSSEY+amwJyxT850yzquqPAouzYznUug==
X-Google-Smtp-Source: AGHT+IGr1YusOCrM9bnppsDzO/xFTrsGhIsHdn6pdF3Q6lPJRBaX4KJY4IqfIL0/XIRV040XF8zD5jzk0UPeSFTaFPU=
X-Received: by 2002:a05:600c:1ca7:b0:404:74f8:f47c with SMTP id
 k39-20020a05600c1ca700b0040474f8f47cmr3856wms.5.1699328663197; Mon, 06 Nov
 2023 19:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
In-Reply-To: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Nov 2023 04:44:12 +0100
Message-ID: <CANn89iKzVACROr7gzR2H3HPEQfVjctiXyiUswc-zyvN-06p3=Q@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: Fix -Wc23-extensions in tcp_options_write()
To: Nathan Chancellor <nathan@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, ndesaulniers@google.com, trix@redhat.com, 
	0x7f454c46@gmail.com, noureddine@arista.com, hch@infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 10:14=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Clang warns (or errors with CONFIG_WERROR=3Dy) when CONFIG_TCP_AO is set:
>
>   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement =
is a C23 extension [-Werror,-Wc23-extensions]
>     663 |         }
>         |         ^
>   1 error generated.
>
> On earlier releases (such as clang-11, the current minimum supported
> version for building the kernel) that do not support C23, this was a
> hard error unconditionally:
>
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
> Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v3:
> - Don't use a pointer to a pointer for ptr parameter to avoid the extra
>   indirection in process_tcp_ao_options(), just return the modified ptr
>   value back to the caller (Eric)

SGTM thanks.
Reviewed-by: Eric Dumazet <edumazet@google.com>

