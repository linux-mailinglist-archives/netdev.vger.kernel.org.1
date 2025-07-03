Return-Path: <netdev+bounces-203866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5914AF7C71
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949861CA3D86
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767902E8E0D;
	Thu,  3 Jul 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG0c3PQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750672617;
	Thu,  3 Jul 2025 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556646; cv=none; b=PF/cyvvzAIE0CS9I80YZtyuOGekYm+lRmWl7PJAGpIIM5xobq/ICjpxrCSTJhDa7hexLWXNasN5kisaBfJCUKMPXyauhyxadVKDt4F11y2OsdElTPYV6VUuc6OJ9e3E6S+EdIg+7UNKE2HXCw3X7CEwbAEAxcYu2/51aR7cynEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556646; c=relaxed/simple;
	bh=kf3R69g/8+n9ejwwkL6h4el8NdPueW74hEy4yuQ+Fcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRAt9LLnFfZg+M79nfJ5NP5Em3BV8LjKtlBKqIm1U2MMfrdBrLJFI39wy1m7NRtleapxaR7ML+BRC/JEl5KK5lclf8PXH6ktmUSSk11KhH6yGTmF/xMhj5n4tzSNU5Y+ks+AUMUV4cniWgFZymH8ehAl7Aics1gDWXNGmhRHQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG0c3PQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB859C4CEED;
	Thu,  3 Jul 2025 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751556645;
	bh=kf3R69g/8+n9ejwwkL6h4el8NdPueW74hEy4yuQ+Fcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nG0c3PQKGVGoTtfCDduTcEI7W1NSi6vabGp+6w7YXIKmlYKIrjxaDRvDafBw0K0Qr
	 oGHuVf6XBn3o1jILbhnAFdiQFJAdbFG38T/avxI6ruCAYXZEdVWCGO+I2FetJqbA3d
	 vpLTDmrQksbPAlmfTn3E+RzN+ASyuwjyreA220nPQK5WV+iLFhfactLuqf5ACtHbyP
	 O6gmYgwTkqq5P3KCMd0lCz5w+DjoZg7FOygXUggOVQwA89jEtX8Q6ZdT72lTiQxoGr
	 3XhRfmbBLBier1wTDGeV6f5IRMyEsmjeQKZYxC6JtFxhF9fZG6A75HUqI0edagzTat
	 ose0hmAvxc0yQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade5b8aab41so2917266b.0;
        Thu, 03 Jul 2025 08:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSPbFVi+ZqqRBs2UnEZUoQhIyO8LyXdY8K+fcPNsxa6dZM+N1KQ/knDSsM7N99wU49gUQK4lZUhN/rLeNA@vger.kernel.org, AJvYcCWI/f4V8tSEAJOAgtwqigNvlBW+PGPxgx0mBoUZKghnyGNFDmhnUZWizjfkeqP6m+dtFQfRr0fd@vger.kernel.org, AJvYcCWmn6ksIxJEbF/bGmuq8DMP26pGhSflPdheG1YLrO+6jdwD0rR0McebSJGci89YEK7CEbTN+0GxgtTm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/m+51b/mIQaksCF9v/AxI5krZWmLPvhvM5HjQt1LPNAQF25q
	oz+i0TQrSO/0Ey1A8SZGkB7KWOqxYwbWJ3k4dtZAu3BFMx5Y3FhmekoYkSqYX6znt4QinvLYT3q
	h8tEkIthR0KVMtVAYjxd4lgim6KuWOQ==
X-Google-Smtp-Source: AGHT+IFGK3wNYEmDTQE7cJvW5bwhu5w4lNajdS9akjc5i1/E/t6dIX21GgObTKsLF38FMy+/VygKrLB7PYcfFn+IPck=
X-Received: by 2002:a17:907:94cb:b0:ade:44f8:569 with SMTP id
 a640c23a62f3a-ae3c2c9d41bmr815278466b.42.1751556644360; Thu, 03 Jul 2025
 08:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630213748.71919-1-matthew.gerlach@altera.com>
In-Reply-To: <20250630213748.71919-1-matthew.gerlach@altera.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Jul 2025 10:30:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLrLJ6wiqBk31NhronsUqX4_5FN-Lb26r-3SceDD7kkAA@mail.gmail.com>
X-Gm-Features: Ac12FXxuKTihI_ySZjceamap3hZ9PwUnYru49iIiSxON-urQArDwhuRwHAUu1ZI
Message-ID: <CAL_JsqLrLJ6wiqBk31NhronsUqX4_5FN-Lb26r-3SceDD7kkAA@mail.gmail.com>
Subject: Re: [PATCH v7] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: dinguyen@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, richardcochran@gmail.com, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Mun Yew Tham <mun.yew.tham@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 4:38=E2=80=AFPM Matthew Gerlach
<matthew.gerlach@altera.com> wrote:
>
> Convert the bindings for socfpga-dwmac to yaml. Since the original
> text contained descriptions for two separate nodes, two separate
> yaml files were created.

Did you test this against your dts files?:

ethernet@ff804000 (altr,socfpga-stmmac-a10-s10): iommus: [[11, 3]] is too s=
hort
ethernet@ff802000 (altr,socfpga-stmmac-a10-s10): iommus: [[11, 2]] is too s=
hort
ethernet@ff800000 (altr,socfpga-stmmac-a10-s10): iommus: [[11, 1]] is too s=
hort

There's also one for 'phy-addr', but that needs to be dropped from the
.dts files as it doesn't appear to be used.

[...]

> +  iommus:
> +    maxItems: 2

You need to add:

minItems: 1


Rob

