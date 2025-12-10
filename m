Return-Path: <netdev+bounces-244286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9262BCB3D93
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 20:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93CF0300D301
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB32301704;
	Wed, 10 Dec 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="f2GhHC1T"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CFB3B8D75;
	Wed, 10 Dec 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765394366; cv=pass; b=Sn1x5detNBL4yFmROQy2v0R9h1M1nn75RXN/CCB/YqzZG+gwESy/tGVWG8eP349lDQlQNAQBCHCVzTxCvM7adU4NV/TAldin/3lZH/U1YwBcwuYiaNFjEW7TZoD+PQgK9VMBLqWnxkvcnXshnetn7NDq1ZEtfMA8/ASJZGiUnDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765394366; c=relaxed/simple;
	bh=qpqeS8IY7ytezFjaY1n8JNgWEvn7E++Jo6BtI1yqF1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2i1SK7hAmun42Ia0pZuMdaggNTJpsXBTudYsJFvxoFWmTfS/Ddz7CuaLLEdudEWgCxXaw0C9kUllQcfcmkeM6S/fYZuwrVL6h3p7w9eN5FDMYtXlSWTr3wOrI9AcKBKRqzVBkAtGl2Id26n3RysBtbe+EYq08RwC+vGAKfcDsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=f2GhHC1T; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1765394320; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aqe3TBAt+Tf0ej1pnT0Q/FVbFd4P3HQepnc0AnxzkzXCpk5Lcgd22x15NG92ZfY0xZHuUqCPWrFyaa2GWF4/ctlh8b/VJF6vdQWERqyTCJ2iQDrdRSWUzWffnehi0CkfFmfSuvKb6LUqVMmkECcUbUTA55HMScAeeWBF/1mV2t4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765394320; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/seT+FFLHD7j8BZlv3zXV+mp3M09SGTEChMYjY4N0aM=; 
	b=dxzjcuBCZYLaV3HfHUgxcTDhdnlvqiooOiKOk4OYtKkWTAPbedWwkA30j7fNaP+gqUnZFhNNriMlL3EC83cfYulP9tmv/6+wOscpEbvErY64b4XypzC1Xwya9wHO9geLShdqQbJWkEztNSyjHltdgMilCRucOgEQFJ4w2RJ0kdY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765394320;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=/seT+FFLHD7j8BZlv3zXV+mp3M09SGTEChMYjY4N0aM=;
	b=f2GhHC1TsWeTycQokWrZsUlRhL9O8gqFrjxSBXdgjw5RLD+K9bVw6dT21a8iXV5W
	3bgVD3OmXuWkBbXri3DX2gklcQUGMaOZLGmcBEBzq2NtMN5WGZ9M0luYMK50DWp/BSw
	Q5UHYNw4A+Dwl5GBHVPqIS7IIRlM5Dz7fVCYRnWk=
Received: by mx.zohomail.com with SMTPS id 176539431766081.4852419704248;
	Wed, 10 Dec 2025 11:18:37 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Luo Jie <quic_luoj@quicinc.com>, Peter Zijlstra <peterz@infradead.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Simon Horman <simon.horman@netronome.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, david.laight.linux@gmail.com
Cc: David Laight <david.laight.linux@gmail.com>
Subject:
 Re: [PATCH 3/9] bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
Date: Wed, 10 Dec 2025 20:18:30 +0100
Message-ID: <2262600.PYKUYFuaPT@workhorse>
In-Reply-To: <20251209100313.2867-4-david.laight.linux@gmail.com>
References:
 <20251209100313.2867-1-david.laight.linux@gmail.com>
 <20251209100313.2867-4-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 9 December 2025 11:03:07 Central European Standard Time david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> not be used outside bitfield) and open-coding the generation of the
> masked value, just call FIELD_PREP() and add an extra check for
> the mask being at most 16 bits.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  include/linux/hw_bitfield.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
> index df202e167ce4..d7f21b60449b 100644
> --- a/include/linux/hw_bitfield.h
> +++ b/include/linux/hw_bitfield.h
> @@ -23,15 +23,14 @@
>   * register, a bit in the lower half is only updated if the corresponding bit
>   * in the upper half is high.
>   */
> -#define FIELD_PREP_WM16(_mask, _val)					     \
> -	({								     \
> -		typeof(_val) __val = _val;				     \
> -		typeof(_mask) __mask = _mask;				     \
> -		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
> -				 "HWORD_UPDATE: ");			     \
> -		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
> -		((__mask) << 16);					     \
> -	})
> +#define FIELD_PREP_WM16(mask, val)				\
> +({								\
> +	__auto_type _mask = mask;				\
> +	u32 _val = FIELD_PREP(_mask, val);			\
> +	BUILD_BUG_ON_MSG(_mask > 0xffffu,			\
> +			 "FIELD_PREP_WM16: mask too large");	\
> +	_val | (_mask << 16);					\
> +})
>  
>  /**
>   * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
> 

This breaks the build for at least one driver that uses
FIELD_PREP_WM16, namely phy-rockchip-emmc.c:

drivers/phy/rockchip/phy-rockchip-emmc.c:109:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  109 |                      HIWORD_UPDATE(PHYCTRL_PDB_PWR_OFF,
      |                      ^
drivers/phy/rockchip/phy-rockchip-emmc.c:25:4: note: expanded from macro 'HIWORD_UPDATE'
   25 |                 (FIELD_PREP_WM16((mask) << (shift), (val)))
      |                  ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/phy/rockchip/phy-rockchip-emmc.c:114:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  114 |                      HIWORD_UPDATE(PHYCTRL_ENDLL_DISABLE,
      |                      ^
drivers/phy/rockchip/phy-rockchip-emmc.c:25:4: note: expanded from macro 'HIWORD_UPDATE'
   25 |                 (FIELD_PREP_WM16((mask) << (shift), (val)))
      |                  ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/phy/rockchip/phy-rockchip-emmc.c:167:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  167 |                      HIWORD_UPDATE(PHYCTRL_PDB_PWR_ON,
      |                      ^
drivers/phy/rockchip/phy-rockchip-emmc.c:25:4: note: expanded from macro 'HIWORD_UPDATE'
   25 |                 (FIELD_PREP_WM16((mask) << (shift), (val)))
      |                  ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/phy/rockchip/phy-rockchip-emmc.c:190:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  190 |                      HIWORD_UPDATE(freqsel, PHYCTRL_FREQSEL_MASK,
      |                      ^
drivers/phy/rockchip/phy-rockchip-emmc.c:25:4: note: expanded from macro 'HIWORD_UPDATE'
   25 |                 (FIELD_PREP_WM16((mask) << (shift), (val)))
      |                  ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/phy/rockchip/phy-rockchip-emmc.c:196:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  196 |                      HIWORD_UPDATE(PHYCTRL_ENDLL_ENABLE,
      |                      ^
drivers/phy/rockchip/phy-rockchip-emmc.c:25:4: note: expanded from macro 'HIWORD_UPDATE'
   25 |                 (FIELD_PREP_WM16((mask) << (shift), (val)))
      |                  ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/phy/rockchip/phy-rockchip-emmc.c:291:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  291 |                      HIWORD_UPDATE(rk_phy->drive_impedance,
      |                      ^
drivers/phy/rockchip/phy-rockchip-emmc.c:25:4: note: expanded from macro 'HIWORD_UPDATE'
   25 |                 (FIELD_PREP_WM16((mask) << (shift), (val)))
      |                  ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/phy/rockchip/phy-rockchip-emmc.c:298:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  298 |                      HIWORD_UPDATE(PHYCTRL_OTAPDLYENA,
      |                      ^
drivers/phy/rockchip/phy-rockchip-emmc.c:25:4: note: expanded from macro 'HIWORD_UPDATE'
   25 |                 (FIELD_PREP_WM16((mask) << (shift), (val)))
      |                  ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/phy/rockchip/phy-rockchip-emmc.c:305:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  305 |                      HIWORD_UPDATE(rk_phy->output_tapdelay_select,
      |                      ^
drivers/phy/rockchip/phy-rockchip-emmc.c:25:4: note: expanded from macro 'HIWORD_UPDATE'
   25 |                 (FIELD_PREP_WM16((mask) << (shift), (val)))
      |                  ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/phy/rockchip/phy-rockchip-emmc.c:312:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  312 |                      HIWORD_UPDATE(rk_phy->enable_strobe_pulldown,
      |                      ^
drivers/phy/rockchip/phy-rockchip-emmc.c:25:4: note: expanded from macro 'HIWORD_UPDATE'
   25 |                 (FIELD_PREP_WM16((mask) << (shift), (val)))
      |                  ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^

Maybe the wrapping in HIWORD_UPDATE (which was done to make the
transitionary patch easier) is playing a role here.

pcie-dw-rockchip.c is similarly broken by this change, except
without the superfluous wrapper:

drivers/pci/controller/dwc/pcie-dw-rockchip.c:191:37: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  191 |         rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
      |                                            ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:43:35: note: expanded from macro 'PCIE_CLIENT_ENABLE_LTSSM'
   43 | #define  PCIE_CLIENT_ENABLE_LTSSM       FIELD_PREP_WM16(BIT(2), 1)
      |                                         ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:197:37: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  197 |         rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DISABLE_LTSSM,
      |                                            ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:44:36: note: expanded from macro 'PCIE_CLIENT_DISABLE_LTSSM'
   44 | #define  PCIE_CLIENT_DISABLE_LTSSM      FIELD_PREP_WM16(BIT(2), 0)
      |                                         ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:222:38: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  222 |                 rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY,
      |                                                    ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:67:29: note: expanded from macro 'PCIE_CLKREQ_READY'
   67 | #define  PCIE_CLKREQ_READY              FIELD_PREP_WM16(BIT(0), 1)
      |                                         ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:234:6: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  234 |                                  PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
      |                                  ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:69:33: note: expanded from macro 'PCIE_CLKREQ_PULL_DOWN'
   69 | #define  PCIE_CLKREQ_PULL_DOWN          FIELD_PREP_WM16(GENMASK(13, 12), 1)
      |                                         ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:234:30: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  234 |                                  PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
      |                                                          ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:68:33: note: expanded from macro 'PCIE_CLKREQ_NOT_READY'
   68 | #define  PCIE_CLKREQ_NOT_READY          FIELD_PREP_WM16(BIT(0), 0)
      |                                         ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:535:9: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  535 |                 val = FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_DONE, 1);
      |                       ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:574:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  574 |         val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
      |               ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:578:6: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  578 |                                  PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
      |                                  ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:41:34: note: expanded from macro 'PCIE_CLIENT_SET_MODE'
   41 | #define  PCIE_CLIENT_SET_MODE(x)        FIELD_PREP_WM16(PCIE_CLIENT_MODE_MASK, (x))
      |                                         ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:592:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  592 |         val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0);
      |               ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:624:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  624 |         val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1) |
      |               ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:625:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  625 |               FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_EN, 1);
      |               ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:629:6: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  629 |                                  PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
      |                                  ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:41:34: note: expanded from macro 'PCIE_CLIENT_SET_MODE'
   41 | #define  PCIE_CLIENT_SET_MODE(x)        FIELD_PREP_WM16(PCIE_CLIENT_MODE_MASK, (x))
      |                                         ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:653:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  653 |         val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
      |               ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
drivers/pci/controller/dwc/pcie-dw-rockchip.c:654:8: error: variable '_mask' declared with deduced type '__auto_type' cannot appear in its own initializer
  654 |               FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
      |               ^
include/linux/hw_bitfield.h:29:24: note: expanded from macro 'FIELD_PREP_WM16'
   29 |         u32 _val = FIELD_PREP(_mask, val);                      \
      |                               ^
14 errors generated.

Kind regards,
Nicolas Frattaroli



