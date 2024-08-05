Return-Path: <netdev+bounces-115760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685BB947B6D
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7571C21253
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20D15D5A4;
	Mon,  5 Aug 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWK9+3A7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999415CD52;
	Mon,  5 Aug 2024 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862563; cv=none; b=juym+TZflfE22e0o6qRZMCJn60Vrnz9IjkoagDLYc/++RgqlwtIAGCJ444+F5qKHW01MELXsmAjuyz0XaPNiDat9AEE71rXqteGmOnNEwzGUgD8IL2NdPcb3018CvcHRgoUnzlBvxOV3KperpM3C29Oj+I5ddCtDGBojb+sSaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862563; c=relaxed/simple;
	bh=+O99yLw0aH2KVipoUYhulsI++009286z3qZMdDnIzFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H23Qb7HmpQvxhuFuK/2smnmNL/BjhRiJxLFMS/cEvk6h/Cn71w7nsmo2OOkRjk/UE0rkkrt/JNmsg42Xm7ceks1Ee+zEy8XYFksL0HsELuH7MiyYWOaBAEMBxh00yEz6Ebzn7f4CYpAVDlikfLDHbSIvsK6N3Oy4z1oWSLJo6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWK9+3A7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64B9C32782;
	Mon,  5 Aug 2024 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862563;
	bh=+O99yLw0aH2KVipoUYhulsI++009286z3qZMdDnIzFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWK9+3A7mZvmVfIM+HUIVUOCu7tON9jR4Q2EvAw7GudQIgnQKANFyeftWD/u+JP5O
	 65h+giWNHxxIsKsi7l6qirs0bHW/MDHG+PAxD+9YfhROwoAuO4mErEPiUKmH2bLmmT
	 VDdNi/4ely/OMvFWjHE782JcwMaF5xjEiGe6358o9aj/AIhIdXg5JeVyjE6Ks701KI
	 jy528JntcczD+Y/DQfx45DzlsmWAvYN0RXISCLoyYXVQKlSyFL0ew8lR4wym3O/kUb
	 mcx77TL7fbFKHwpWC67JgXkc5bk1B7/hu4whsTD8cVt/+BEYwQv6BMnXXZ9bnkkoU4
	 JxrYkdNSNWygA==
Date: Mon, 5 Aug 2024 13:55:58 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 02/10] net: hibmcge: Add read/write
 registers supported through the bar space
Message-ID: <20240805125558.GA2633937@kernel.org>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731094245.1967834-3-shaojijie@huawei.com>

On Wed, Jul 31, 2024 at 05:42:37PM +0800, Jijie Shao wrote:
> Add support for to read and write registers through the pic bar space.
> 
> Some driver parameters, such as mac_id, are determined by the
> board form. Therefore, these parameters are initialized
> from the register as device specifications.
> 
> the device specifications register are initialized and writed by bmc.
> driver will read these registers when loading.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h

...

> +static inline void hbg_reg_write_field(struct hbg_priv *priv,  u32 reg_addr,
> +				       u32 mask, u32 val)
> +{
> +	u32 reg_value = hbg_reg_read(priv, reg_addr);
> +
> +	reg_value &= ~mask;
> +	reg_value |= FIELD_PREP(mask, val);

Hi,

I may well be wrong but I think that FIELD_PREP can only be used with
a compile-time constant as the mask.

In any case, with Clang-18 W=1 allmodconfig builds on x86_64 I see:

  CC      drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.o
   CC      drivers/net/ethernet/hisilicon/hibmcge/hbg_main.o
In file included from drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:8:
drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h:31:15: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
   31 |         reg_value |= FIELD_PREP(mask, val);
      |                      ^~~~~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
  115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
   72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   74 |                                  _pfx "type of reg too small for mask"); \
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
././include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
  510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
  498 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
  490 |                 if (!(condition))                                       \
      |                       ^~~~~~~~~
1 warning generated.
In file included from drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:8:
drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h:31:15: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
   31 |         reg_value |= FIELD_PREP(mask, val);
      |                      ^~~~~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
  115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
   72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   74 |                                  _pfx "type of reg too small for mask"); \
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
././include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
  510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
  498 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
  490 |                 if (!(condition))                                       \
      |                       ^~~~~~~~~
1 warning generated.

...

