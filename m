Return-Path: <netdev+bounces-202706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F458AEEBCC
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BC818897B8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C17145B16;
	Tue,  1 Jul 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RObX+mQf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94551E4A4;
	Tue,  1 Jul 2025 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331955; cv=none; b=CUxEuoLkywli2vXtYIbMx7c5g5ZdoYyKMVEeFkfFqyKHvYxG8TV/cKfAmsaaNrPvMmcBPPgnKZkpUK4kNX5LrCHNwNNAIPVKCu592Rw9pX2ZVn7PePmroylDfbdO9knHBoAtseOqUETstekyNBJFB1A6QvhjAsJY0h2KLLGyvUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331955; c=relaxed/simple;
	bh=iI2aTGNA3c7KUOp3mEmuzi+6XcgZXj+IEo9Fcm/BwHc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=YXYTC1qsOEzapfsRqVBqkiDgze49dEekzKqJIstV7U/c4+r1LZ0GfLOc7VGTn11nQKyPydTdO3rJTFzUKrMHWErdDk5VFOtWlkRrvk1t2d7Zj9LAOAWg5b39654DjwBGj+FHg+shno5no5Plf9FL+b0plU34F77kxTSZ17lnNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RObX+mQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC73C4CEE3;
	Tue,  1 Jul 2025 01:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331954;
	bh=iI2aTGNA3c7KUOp3mEmuzi+6XcgZXj+IEo9Fcm/BwHc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RObX+mQfMOTd+dnkK5YqCpzEIgFOn9B+oK+NLutuToTH0vH6N/z62Sa2vQAG6MKGf
	 iZs+0b7PbJZKO2gMrjc/ArMxKPuWgLjIj1GZp/cZcr6KQBMohxy025W0aYssHFuB5K
	 saiaaGmKE0xfznqO8xtZfwSen/CvqHYHz5lqsM9h032Q4k7bU3SBfvZayKiTQAdly8
	 e8+qFYf5fP7GW2yUvztieaFZNxLHJ8lGfEb1t3pmPCkFn6DNLDhlz9KSL/hZtTlkHK
	 jPV3XWLrtV5owsBtPjfXOsSuAjqfJbUUT9hUZwF5EElXEqjj5KL73C82/6imiluDTk
	 cKYQiF7jo71Tw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250513234837.2859-1-matthew.gerlach@altera.com>
References: <20250513234837.2859-1-matthew.gerlach@altera.com>
Subject: Re: [PATCH v5] clk: socfpga: agilex: add support for the Intel Agilex5
From: Stephen Boyd <sboyd@kernel.org>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>, Teh Wen Ping <wen.ping.teh@intel.com>, Matthew Gerlach <matthew.gerlach@altera.com>
To: Matthew Gerlach <matthew.gerlach@altera.com>, dinguyen@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, netdev@vger.kernel.org, richardcochran@gmail.com
Date: Mon, 30 Jun 2025 18:05:55 -0700
Message-ID: <175133195554.4372.1414444579635929023@lazor>
User-Agent: alot/0.11

Quoting Matthew Gerlach (2025-05-13 16:48:37)
> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-a=
gilex.c
> index 8dd94f64756b..43c1e4e26cf0 100644
> --- a/drivers/clk/socfpga/clk-agilex.c
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2019, Intel Corporation
> + * Copyright (C) 2019-2024, Intel Corporation
> + * Copyright (C) 2025, Altera Corporation
>   */
>  #include <linux/slab.h>
>  #include <linux/clk-provider.h>
> @@ -8,6 +9,7 @@
>  #include <linux/platform_device.h>
> =20
>  #include <dt-bindings/clock/agilex-clock.h>
> +#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
> =20
>  #include "stratix10-clk.h"
> =20
> @@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex_gat=
e_clks[] =3D {
>           10, 0, 0, 0, 0, 0, 4},
>  };
> =20
> +static const struct clk_parent_data agilex5_pll_mux[] =3D {
> +       { .name =3D "osc1", },
> +       { .name =3D "cb-intosc-hs-div2-clk", },
> +       { .name =3D "f2s-free-clk", },

Please don't use clk_parent_data with only .name set with dot
initializers. This is actually { .index =3D 0, .name =3D "..." } which means
the core is looking at the DT node for the first index of the 'clocks'
property. If you're using clk_parent_data you should have a DT node that
has a 'clocks' property. If the clks are all internal to the device then
use clk_hw pointers directly with clk_hws.

