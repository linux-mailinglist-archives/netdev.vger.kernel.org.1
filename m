Return-Path: <netdev+bounces-41400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96AD7CADCA
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83841C20995
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7B2AB4B;
	Mon, 16 Oct 2023 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKiSSHFp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28B2AB2B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 15:41:00 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B2B4;
	Mon, 16 Oct 2023 08:40:59 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49ab0641e77so1969795e0c.0;
        Mon, 16 Oct 2023 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697470858; x=1698075658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JyrPV6/isChg/aWoV8Vdox7jNb/LeSH8h9ZE9RQZ4k=;
        b=RKiSSHFp3Y56c42pxA8NcctPS+vB2KvEaJaJ97M5qDuLadDj+RkSg/Tqa9pTajSTQQ
         p6aLGYb9BG2QBnRQ6fyfs8/WnO1tkjfe4l/xgwvmso/zA05F7LKY6zcXIKvZtf2wLpEw
         BV1kInv7MYsJftCraFHVKRYbO0Teh4FlAfttffcN6OUtf7PmfoyKlPAH0+pXIae1phAQ
         lJeWfmSNuBkWx8xrMZ2AyLhNYnpngxdr1Z53SUYIX6mzoZOoVeXB8KWsrI1V9TWsk8Hx
         ytL+N1G527PaEjPVsiDm4tLmWZu0ktpTv0oSD5Vbos27at8CeAMCVy3f4yH/GFoc3stQ
         RY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470858; x=1698075658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JyrPV6/isChg/aWoV8Vdox7jNb/LeSH8h9ZE9RQZ4k=;
        b=oUq5vE1p2clovAfm9niRKNppHH793o9jtFh2v2C891COxTdHcUtdJC8WG5KuXcJiGv
         wpOKqIvdiJt7gBpk16308zR+h3HtCmsOhCQXTKrRfzztvo5e0gtA9A6fEsnB6pQhydn1
         naLn5TRhzXxsS4KQM2lI55zXVdXltsRcItgVn0o8Yq0wT4xgFgwQrVcONXQLZLC8+nji
         9dnnVEBFMC5khhy4sKf9EOsgR6Luv59nYPCgzdMF7b7Yx8XeB9qKul/+M1FynJjuxIgf
         ge9rBtDGicrstabPH+VwjHJfXFRF95qdDmjBgR0Wa+T8tFaGcUGDFHbRYPs2nTJXn5Ne
         Fm9A==
X-Gm-Message-State: AOJu0YwpaqdUKMbGmJRzgD6wBPjU8gTw2EtUHlqjMCwqWeslhttlDr0S
	6Ih5wEHqF5z4UQ8VlyzwIHcwoasMgBdo5zgjkiY=
X-Google-Smtp-Source: AGHT+IEUS6diCI0qP0NzRCHHthfHGe1z+pXjLCt2SKZVkH+NQW/kPzzEZY2133jtIGuI9wooUY358mw8Vy0zXSvuQs4=
X-Received: by 2002:a1f:4ec4:0:b0:4a4:887:514c with SMTP id
 c187-20020a1f4ec4000000b004a40887514cmr8133579vkb.6.1697470858089; Mon, 16
 Oct 2023 08:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-3-hch@lst.de>
In-Reply-To: <20231016054755.915155-3-hch@lst.de>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 16 Oct 2023 16:39:40 +0100
Message-ID: <CA+V-a8va9W7Gpgr22RcPHL=fJvbViMjrpUfqKekcQ+rSZeYebw@mail.gmail.com>
Subject: Re: [PATCH 02/12] riscv: only select DMA_DIRECT_REMAP from RISCV_ISA_ZICBOM
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 6:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> RISCV_DMA_NONCOHERENT is also used for whacky non-standard
> non-coherent ops that use different hooks in dma-direct.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0ac0b538379718..9c48fecc671918 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -273,7 +273,6 @@ config RISCV_DMA_NONCOHERENT
>         select ARCH_HAS_SYNC_DMA_FOR_CPU
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>         select DMA_BOUNCE_UNALIGNED_KMALLOC if SWIOTLB
> -       select DMA_DIRECT_REMAP if MMU
>
>  config RISCV_NONSTANDARD_CACHE_OPS
>         bool
> @@ -549,6 +548,7 @@ config RISCV_ISA_ZICBOM
>         depends on RISCV_ALTERNATIVE
>         default y
>         select RISCV_DMA_NONCOHERENT
> +       select DMA_DIRECT_REMAP
>         help
>            Adds support to dynamically detect the presence of the ZICBOM
>            extension (Cache Block Management Operations) and enable its
> --
> 2.39.2
>

