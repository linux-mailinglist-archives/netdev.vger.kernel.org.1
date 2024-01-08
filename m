Return-Path: <netdev+bounces-62491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C0C82787D
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 20:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A351C20973
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6655576D;
	Mon,  8 Jan 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="15/oa8U4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64054FAE
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7cc970f8156so455481241.2
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704741774; x=1705346574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t630KAds7hYgoJ0f0LCQ0AiFafn/yi4jTUENLdj9Tv0=;
        b=15/oa8U4pdYzJkHwwrBD/ZBIkmGcfTosoOL6LTbBCbW9PSojKpdH1liW5vWEyMcehQ
         vEx6D2purj1hfQkQAL3p7NY67GY3BgKuLDFWxCiRsNi9pB6cnKjGzbPHUmnWKyKCjdtf
         kCENjprM5m6D9ONGevgO16eUiQJ7c+XnFGq+uwkdXxbjjwgNVYwk/gCf4oAdEpUEQ8L7
         0OqmMouljJgrcrBqjkntsuGjj4ZJzLOSxVVK8UYut5H65FahRmMsln2nAHcgAK9SzAQK
         YKS8MBcUY3csqZgpL3Yov7vR97sH6qVXqaOH+q/SooB/SUXyoRfC9X0cu4mQNvPb/ONS
         J0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741774; x=1705346574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t630KAds7hYgoJ0f0LCQ0AiFafn/yi4jTUENLdj9Tv0=;
        b=GOrKW3XnQOKGdVHSDOce4O9cTJPilFXA/S+DqFRZmqBGDkxdbRnw/n5Wvrj1qBoeJE
         ZT3uWQVZv2NRwUp/Ewi47TKPPbegnRhVCPRm/UntSBVdCDBzXhJcnzFYpPQhp4pYJSk/
         egO2O7iEddNyd1OS4qe2IZw7oWZAVyFwZ5Z32g3NkcTLn/mNOGSlW3b7JvKExxJaKzXx
         vIH69kyj406g3RaDzfviBDJnqn9l0npPvBEAUNXJiCIj5tczgChP7ellYKejxlBR/21z
         iBhI1LzyZ8CQusLj+jDnzyFNvoZg16hg1dhuhRzYNIqRvq5jC3yFXo1CuQ2YTh6o/bh5
         HJwA==
X-Gm-Message-State: AOJu0Yy5Egf36skXoImcd3Ti7SyJ8Tw9mXVqHUvbFsdqhOvDsCFzMT9i
	z0i+m71FdMVtXpiS8HB7GBlygmNaqYWSkCEQIO49GEHxmoU/Rg==
X-Google-Smtp-Source: AGHT+IEah3V2Xy4oFA525rnBCO8YyKWJvg7Na5/wUj76Z4lWssvjCk0GeQpBn6QxzFQI/HexZWRnBZrcb5Awcliqtng=
X-Received: by 2002:a05:6122:17a6:b0:4b6:aeb7:3f1d with SMTP id
 o38-20020a05612217a600b004b6aeb73f1dmr1198020vkf.9.1704741773775; Mon, 08 Jan
 2024 11:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-7-brgl@bgdev.pl>
 <20240108191052.GA1893484-robh@kernel.org>
In-Reply-To: <20240108191052.GA1893484-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Jan 2024 20:22:42 +0100
Message-ID: <CAMRc=Mc7D1rVHaA4yoOC2DHDkkCptF4wjAm=24Rr=kkqM1ztjg@mail.gmail.com>
Subject: Re: [RFC 6/9] dt-bindings: vendor-prefixes: add a PCI prefix for
 Qualcomm Atheros
To: Rob Herring <robh@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 8:10=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jan 04, 2024 at 02:01:20PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Document the PCI vendor prefix for Qualcomm Atheros so that we can
> > define the QCA PCI devices on device tree.
>
> Why? vendor-prefixes.yaml is only applied to property names. 'qca'
> should be the prefix for those.
>
> Rob

I didn't have any better idea. PCI devices on DT are defined by their
"pci<vendor ID>,<model ID>" compatible, not regular human-readable
strings and this makes checkpatch.pl complain.

I'm open to suggestions.

Bartosz

