Return-Path: <netdev+bounces-210550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059BEB13E17
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5ED189FC78
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B91271466;
	Mon, 28 Jul 2025 15:19:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A001E2823
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715971; cv=none; b=SMaVRCGX1Jw5E31ToWGsWzpg4Y20K7xJQggz6vSB99b6CrsQNInnh/D3yuPsheYrjjQCcGC0n3Xp88xpZtj4gEOty3FvD8WIKlRY3s0KoGiyFIsYc6KvpOzl91AwncDe2OxKyAd28qesLt01P1gj+cGmZ1c9eJ6trXVVB1vpFVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715971; c=relaxed/simple;
	bh=hLpesYBCR8AADZ4fZwGsw+lJjfd3PVLEIOtqSVpCBE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZ0s7S32xOOx3qK7zXM7279l9x1wyQ6uQae4IZdNDdLeqrHfBqhCetq7pbrNDNOIUvTArcL95O3kuhhjge3DautAwqqREvcRXWWJf2ndTk7b/eikNLJmoy9skVcw1gNkl+SLNx5CCJh1f9AlFkjjy9MC2+Ej89NDUUJqtyi1APM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-87f74a28a86so3164258241.2
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 08:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753715969; x=1754320769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meQ0SiqTorB3mrzTz0Np43mLiPNMi2QHlhVL50UhqWw=;
        b=XDQymSQLyOfbgB8IabLDwEb+cO60xIQfFtP8P15yYsl4OGQWWGXwaKvF09MckRv7c+
         ENJRpTM/EmyLjNEm5sYQuPPEVdwKIF/I6rxpwZby2jOaYWYAsNJysCrnucmDSAX0xnOr
         D6OX1vH6ITlu3sUy+VMG7+M7LZiWbgjPXyBaYqk8WxeH1ykOjteGUy6slXuE1I2wzCZO
         PDJqpXgZ8+LBuWkH9pXiML4WygHiLpuGNI5ujPjmvnARunpl2s8GMz9ig1fYhfr1yjoC
         V0e/CR/mGXLDON+IDpju9XsohR1DkSRp2KwK4xtYlXADRbpCBaz+VuUH5Y35BhH9rIGk
         9pcQ==
X-Gm-Message-State: AOJu0YwR63F8VQNzm5xCDxFdSX+VEkGZEFp7er67Z/8CpeXKs8rQl2i/
	Rmh1OIKjnC7vVJvaDmvCbIqCeuF3PxqouGuh7K/1G88FSlRv4t36ePMFyD8JN+n1
X-Gm-Gg: ASbGnctw7dDTjwl90wi8V5jYch4lZ8DPZyyIXAZDD+W5Yyp/66FTOUJhNnxBfWdmH6d
	asPCBahr7Tt5Y//mczFg8okkaZFVd9vbGeFc8DoCqD9bD+VIWpsXNZDwRCXlTtD8qYYq1lRXXLK
	SKDA0RICXC3LWja0EMTikMd1km4+m/jYeaTXE8R9t8qJTqZNnHuINU2VZEqu/eAD1qrkjRVCHX3
	TjLOfwxJ7bBUSBQ7xNAkpGRE/nChpLhBIe8qeC0zvG4udUSaSS42YaM4LPRLHeTO92KCh/ye8/N
	Uuedxjw2RgvIWOrMbiZyvxvaxdpCAKfLu5qXEwEl1IqyHS6tEW0/4dAb14xPwRTplcw8OVDbAFM
	/0DAF3CvZngD7xhV4EHxfjk4IHnOeY9iGIdwNvn+0Oqk7o3jgNIQCoX476wdc
X-Google-Smtp-Source: AGHT+IEUvqAi8xasQp/IRzDYPCsy/X94DJdnRFuf8xnL2VNkrqNLSx/7r+MNfw/E0cX8oKof2h2H5Q==
X-Received: by 2002:a05:6102:5088:b0:4ec:b36e:ad0b with SMTP id ada2fe7eead31-4fa3fadaa4cmr4864853137.11.1753715968547;
        Mon, 28 Jul 2025 08:19:28 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fa46e08fc0sm1179605137.14.2025.07.28.08.19.28
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 08:19:28 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e80d19c7ebso3032511137.3
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 08:19:28 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad5:b0:4db:e01:f2db with SMTP id
 ada2fe7eead31-4fa3f833b6emr5177726137.0.1753715967953; Mon, 28 Jul 2025
 08:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724110645.88734-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20250724110645.88734-1-xuanzhuo@linux.alibaba.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jul 2025 17:19:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9tWObJgHH5g5q9fhoyV4LmHweLq2y2TEOuK34xyFfdA@mail.gmail.com>
X-Gm-Features: Ac12FXy4zek4JRbBSjttXkQUiAi1cHRtu5oYnN3wKowQYBEXmgDV3mPBDyK8uT0
Message-ID: <CAMuHMdW9tWObJgHH5g5q9fhoyV4LmHweLq2y2TEOuK34xyFfdA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Dust Li <dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

Hi Xuan,

On Thu, 24 Jul 2025 at 13:06, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> Add a driver framework for EEA that will be available in the future.
>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/Kconfig
> @@ -0,0 +1,29 @@
> +#
> +# Alibaba network device configuration
> +#
> +
> +config NET_VENDOR_ALIBABA
> +       bool "Alibaba Devices"
> +       default y
> +       help
> +         If you have a network (Ethernet) device belonging to this class, say Y.
> +
> +         Note that the answer to this question doesn't directly affect the
> +         kernel: saying N will just cause the configurator to skip all
> +         the questions about Alibaba devices. If you say Y, you will be asked
> +         for your specific device in the following questions.
> +
> +if NET_VENDOR_ALIBABA
> +
> +config EEA
> +       tristate "Alibaba Elastic Ethernet Adaptor support"
> +       depends on PCI_MSI
> +       depends on 64BIT

Any specific reason to depend on 64BIT?

> +       select PAGE_POOL
> +       default m

Drivers should be disabled by default, unless you have a very good
reason to do otherwise.

> +       help
> +         This driver supports Alibaba Elastic Ethernet Adaptor"
> +
> +         To compile this driver as a module, choose M here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

