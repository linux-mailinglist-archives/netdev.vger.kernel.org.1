Return-Path: <netdev+bounces-207672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A4B0826D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 03:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9174A698A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDBD1E3769;
	Thu, 17 Jul 2025 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDxTEnWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36641D7995;
	Thu, 17 Jul 2025 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715930; cv=none; b=MYxCjVs7Os/DDhAvnxvKQHxG/GQs5T3KgngcU/X6qVKT0zb/r2B+n1D2HzWLz4o5punuemObIf2OuAwDoPNNW3kYZScEEQVSRFDbn6G/FVNKpn0BP/Q4pYtZYN6qy98p26NETmHG3yQ9xMvrZ4p7QX14VM7rtwLq9+qo3nVWP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715930; c=relaxed/simple;
	bh=q3gbWN4lUDA9/8GciDsCitUO16WNWP86/4SJ9AWBf/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1E9GNNHWTfo4qAB2BF/GfeRds1+psOGBoljSEquYDk2TteVG3oqnJhDz/r3g7eDLEgifKMtoQGccov0QUP8qSxbUJjo0E49wBOqOUP6Yj8ZJRVpcBrrK4EnYRQuXvYoq0odNmEa1t0tm2/RF+gr5tsKH7g11T6E4W8RyeIdM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDxTEnWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CB4C4CEE7;
	Thu, 17 Jul 2025 01:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715930;
	bh=q3gbWN4lUDA9/8GciDsCitUO16WNWP86/4SJ9AWBf/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fDxTEnWyCmxlhBg2ImepaJVnj5fF5fR+tWR7vVaGZMu9FI/JIISMMroE7oBjDG98q
	 XTLT3vO3VtCC8408o4+iRvii3jfH/QErJ5X8hIOBtQBjUI1M9EmIhIHd802ZjFZmtm
	 lGWOX9B70h5snEoG1Hgxasb11z1XKdNVIjbEq4CzVvkuGispHqHtNDifjY0rdD9seZ
	 PCvQ8GlWdwliN1s0qlF+lhrjEnQ/FyRgq1LGUwKWhd3AgIb8uICgt06JBOrrCqWGAJ
	 pp8pxk/hoSLAI5SYGWfHzFzzNCNEdRp/7+FTxKEuI4R9U7xCexShxqapWaQwSNp3EY
	 k5u5KQKDR84Tw==
Date: Wed, 16 Jul 2025 18:32:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Fu Guiming <fuguiming@h-partners.com>, Meny Yossefi
 <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
 <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v09 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250716183208.26b87aa8@kernel.org>
In-Reply-To: <7666dc6771ef43bf97f1cfabfb50c97ccea31d9d.1752489734.git.zhuyikai1@h-partners.com>
References: <cover.1752489734.git.zhuyikai1@h-partners.com>
	<7666dc6771ef43bf97f1cfabfb50c97ccea31d9d.1752489734.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 08:28:36 +0800 Fan Gong wrote:
> +/* Data provided to/by cmdq is arranged in structs with little endian fields but
> + * every dword (32bits) should be swapped since HW swaps it again when it
> + * copies it from/to host memory. This is a mandatory swap regardless of the
> + * CPU endianness.

This comment makes no sense, FWIW. The device writes a byte steam 
to host memory. For what you're saying to make sense the device would
have to intentionally switch the endian based on the host CPU.
And if it could do that why wouldn't it do it in the opposite
direction, avoiding the swap ? :/

I suppose the device is always writing in be32 words, and you should 
be converting from be32.

> +	/* Ensure handler can observe our intent to unregister. */
> +	mb();

What is "our intent"? I suppose you mean the change to the cb_state
bitfield? Please document the barriers explaining what two (or more)
memory accesses are separated. Not what they are achieving at the high
level.

> +	clear_bit(HINIC3_AEQ_CB_REG, cb_state);
> +	/* Ensure handler can observe our intent to unregister. */
> +	mb();
> +	while (test_bit(HINIC3_AEQ_CB_RUNNING, cb_state))
> +		usleep_range(HINIC3_EQ_USLEEP_LOW_BOUND,
> +			     HINIC3_EQ_USLEEP_HIGH_BOUND);

Please do not try to implement locks manually using bits ops.
Use standard synchronization primitives like wait queues or normal
locks, so that lockdep can help you validate your code is correct.

> +	val = EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED);
> +	val = val |
> +		EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
> +		EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);

Why not:

	val = EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED) |
		EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
		EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);
-- 
pw-bot: cr

