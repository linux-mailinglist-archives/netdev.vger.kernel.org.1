Return-Path: <netdev+bounces-246579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E66DCEE909
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 13:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B83F0301B4AC
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370531064A;
	Fri,  2 Jan 2026 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV6jw05W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC08B67A
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358015; cv=none; b=qvdMD4oi+WTQHPOJeqO/JA/D97697/LchkIgyVtrm1Dh6U30AOecHr0sip548mRXAVGcexnDNw5YuSwbdzQDuZEQuNOd7xvG+PEgzgJaaq7Xi9JyzpApqEqxA65l83kAmfdijcBWa7S3ysq22S+dHwwCTSsK16LkXHeHcH2ELSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358015; c=relaxed/simple;
	bh=6KPWXH/kC7jOHkn729my4NVFkh9cBa46BBKTL8WhXtA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSzHbKGm1tzFTJPr5oC2hzI4t8+uCaRCQrje8CulSd20qoB1WyoiwMl4A7oPiTPN+cvFwP4gZsUghoioLJMBidKtPaVVB5LQl8RLA9HV+gN1qC+tOKG8onl9dRBtOd6ZzPixF51hFn9p8nvKWZunfooeQPSQFhfkcMEKiluVYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV6jw05W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D68C2BCB5
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767358015;
	bh=6KPWXH/kC7jOHkn729my4NVFkh9cBa46BBKTL8WhXtA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=sV6jw05WlDa4lzlJBHb2S67x1hzAEQa+WWS1lFPEQsHpW8B4auVXf1lvZVjXt+H6R
	 96hPogCq/X4laURQYwA7ru6XcAe0TYsP7uqpVbOiTye5vmDjek8TByUne84MeToflN
	 0uNXLncnrqm/evbhpAjDgFOuiQjibUiK2Eu4qneHDgQ9hfqR5fp+UppQ+hiL1Nd2w5
	 /XOhwP95grfBn2iwMi8NtIAXiBClGRNVBc+qwkuB2N59ndIXpFxCAc73OhAapODfs6
	 rW1p5GokFmWow2B2rgOe0lm8AAdfw0j+5nnSMqMJxq4ivwBi35RcV6YNDzYO06mmOf
	 UHlc14sG6yI9g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5958187fa55so9014404e87.3
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 04:46:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBS73/Xcj6tGyMgBwupr87AiC5wtkSvtFJJUa82y/7hBkiz42SBtQjzVSHbJGkUCZTiMgw8dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx1+YkFbty9tySKww9W1z/nWhMdR8imgIE6OoC0lW6BNhmlRG9
	Z62JQFXGNz+2mfAo00kEV0I6L6IWnXcWpu6253kQFX0fcBkpxjPNN+uyHyyQs/qlJYFnYtVPjnL
	eAbdLo6KUqSW57oAH+umk8t0NDsdFxL5fN4lY8w0spg==
X-Google-Smtp-Source: AGHT+IGc2inPJAzzOkCkSBFCoOg9QxkQFVWecr7c4xhZfdJchBGS03PyeQgZEMV/dRlvfiPAbf/AJ8Wav/AAUBMesSQ=
X-Received: by 2002:a05:6512:33cc:b0:592:f521:188a with SMTP id
 2adb3069b0e04-59a17d66a60mr12745131e87.49.1767358012955; Fri, 02 Jan 2026
 04:46:52 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 06:46:51 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 06:46:51 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <6f2f2a7a74141fa3ad92e001ee276c01ffe9ae49.1767112757.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767089672.git.mst@redhat.com> <6f2f2a7a74141fa3ad92e001ee276c01ffe9ae49.1767112757.git.mst@redhat.com>
Date: Fri, 2 Jan 2026 06:46:51 -0600
X-Gmail-Original-Message-ID: <CAMRc=MdaHfsJnbB2hOO6EbVMwZaWqO7zMkv8ZVugHnfOuDn=AA@mail.gmail.com>
X-Gm-Features: AQt7F2oUFrPkMorjc5uJ7mhwaGHd2BKNe3yeZtbMYJ_tunJRlIVF48L1J9wKaic
Message-ID: <CAMRc=MdaHfsJnbB2hOO6EbVMwZaWqO7zMkv8ZVugHnfOuDn=AA@mail.gmail.com>
Subject: Re: [PATCH RFC 14/13] gpio: virtio: fix DMA alignment
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 17:40:28 +0100, "Michael S. Tsirkin" <mst@redhat.com> said:
> The res and ires buffers in struct virtio_gpio_line and struct
> vgpio_irq_line respectively are used for DMA_FROM_DEVICE via virtqueue_add_sgs().
> However, within these structs, even though these elements are tagged
> as ____cacheline_aligned, adjacent struct elements
> can share DMA cachelines on platforms where ARCH_DMA_MINALIGN >
> L1_CACHE_BYTES (e.g., arm64 with 128-byte DMA alignment but 64-byte
> cache lines).
>
> The existing ____cacheline_aligned annotation aligns to L1_CACHE_BYTES
> which is now always sufficient for DMA alignment. For example,
> with L1_CACHE_BYTES = 32 and ARCH_DMA_MINALIGN = 128
>   - irq_lines[0].ires at offset 128
>   - irq_lines[1].type at offset 192
> both in same 128-byte DMA cacheline [128-256)
>
> When the device writes to irq_lines[0].ires and the CPU concurrently
> modifies one of irq_lines[1].type/disabled/masked/queued flags,
> corruption can occur on non-cache-coherent platform.
>
> Fix by using __dma_from_device_aligned_begin/end annotations on the
> DMA buffers. Drop ____cacheline_aligned - it's not required to isolate
> request and response, and keeping them would increase the memory cost.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

