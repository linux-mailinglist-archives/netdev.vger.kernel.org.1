Return-Path: <netdev+bounces-139956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79299B4C9E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A022836DE
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B518E756;
	Tue, 29 Oct 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Aweivx8q"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1B18FC8F;
	Tue, 29 Oct 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213459; cv=none; b=HwxbjW8nk42UZBe58bJfA4yzmf1yoqOAfJL5z8NtXBi5U0ebGi3hAgtGYTEaA8R4vdYhSvznHQden5oSFkBG3ilEpSK7W3WuRJDipBf5RIR83tMYEsbLeQHCjEQJEQjeJ4QMwRUtQGqt+IQds1pVRFXWuyTDJ2rDYe9nkkjBK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213459; c=relaxed/simple;
	bh=p8gKlUR+XnPnpvCUTFAsQ7TvXElasLqrzPI7KsPyRVk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqYZVPQ+/wEXDY7d9Ofvu8c/xAEeOXdusDbX+7GpW3xJiuIdUiyj1g7/+ogXDaCLX4IZql9nUIDVkYf5vDE4LFfZmetgxgrcQwFEGlvrsl8Tk+ruxKsOrcHOkQ8uOYHSdWLy5Drrn/0k82din0bq//3RubIy7uGX+63io48m0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Aweivx8q; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730213456; x=1761749456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p8gKlUR+XnPnpvCUTFAsQ7TvXElasLqrzPI7KsPyRVk=;
  b=Aweivx8qoZHtYHqRyycszBd2OdKmIzHS95x1a3Jqb+52TFONUdDYq1Iy
   clnGYmfGF+2EVsi98WyH9hGtNSazsk/ga0nnL3agCqvCs9otM0fXGQvmh
   cZIg+Pis2V3HtdiK9b9YuBIEe35Jxdu5PeLg81qRcdBCyPD4K75dWqxFr
   wh/VwKQ5MGweX9XyoGcruocJAr747WeGfu5g2kmZfivURXn7550dN8HJc
   iM2dDrPCt3iuyr6qhOfMqnOH++slxcbKaKVJBBJs6seufL8TsSaFmNshE
   R1+atXIzhWjhQ7nzzgIwGTDXB1qY1FjiTgjLR9LErOrlaOGkRTCbt7EpA
   g==;
X-CSE-ConnectionGUID: GbrZWjlaTRy9wbOt2O55Eg==
X-CSE-MsgGUID: cDvk8xD6RSCJTNrM4h1R9g==
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="264731749"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 07:50:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 29 Oct 2024 07:50:14 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 29 Oct 2024 07:50:12 -0700
Date: Tue, 29 Oct 2024 14:50:11 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
Message-ID: <20241029145011.4obrgprcaksworlq@DEN-DL-M70577>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-6-734776c88e40@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-6-734776c88e40@intel.com>

Hi Jacob,

> The ice driver needs to write the Tx and Rx queue context when programming
> Tx and Rx queues. This is currently done using some bespoke custom logic
> via the ice_set_ctx() and its helper functions, along with bit position
> definitions in the ice_tlan_ctx_info and ice_rlan_ctx_info structures.
> 
> This logic does work, but is problematic for several reasons:
> 
> 1) ice_set_ctx requires a helper function for each byte size being packed,
>    as it uses a separate function to pack u8, u16, u32, and u64 fields.
>    This requires 4 functions which contain near-duplicate logic with the
>    types changed out.
> 
> 2) The logic in the ice_pack_ctx_word, ice_pack_ctx_dword, and
>    ice_pack_ctx_qword does not handle values which straddle alignment
>    boundaries very well. This requires that several fields in the
>    ice_tlan_ctx_info and ice_rlan_ctx_info be a size larger than their bit
>    size should require.
> 
> 3) Future support for live migration will require adding unpacking
>    functions to take the packed hardware context and unpack it into the
>    ice_rlan_ctx and ice_tlan_ctx structures. Implementing this would
>    require implementing ice_get_ctx, and its associated helper functions,
>    which essentially doubles the amount of code required.
> 
> The Linux kernel has had a packing library that can handle this logic since
> commit 554aae35007e ("lib: Add support for generic packing operations").
> The library was recently extended with support for packing or unpacking an
> array of fields, with a similar structure as the ice_ctx_ele structure.
> 
> Replace the ice-specific ice_set_ctx() logic with the recently added
> pack_fields and packed_field_s infrastructure from <linux/packing.h>
> 
> For API simplicity, the Tx and Rx queue context are programmed using
> separate ice_pack_txq_ctx() and ice_pack_rxq_ctx(). This avoids needing to
> export the packed_field_s arrays. The functions can pointers to the
> appropriate ice_txq_ctx_buf_t and ice_rxq_ctx_buf_t types, ensuring that
> only buffers of the appropriate size are passed.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.h    |   5 +-
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h |  14 --
>  drivers/net/ethernet/intel/ice/ice_base.c      |   3 +-
>  drivers/net/ethernet/intel/ice/ice_common.c    | 249 +++++--------------------
>  drivers/net/ethernet/intel/Kconfig             |   3 +
>  5 files changed, 50 insertions(+), 224 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
> index 27208a60cece..a68bea3934e3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.h
> +++ b/drivers/net/ethernet/intel/ice/ice_common.h
> @@ -92,9 +92,8 @@ ice_aq_set_rss_key(struct ice_hw *hw, u16 vsi_handle,
>  bool ice_check_sq_alive(struct ice_hw *hw, struct ice_ctl_q_info *cq);
>  int ice_aq_q_shutdown(struct ice_hw *hw, bool unloading);
>  void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode);
> -extern const struct ice_ctx_ele ice_tlan_ctx_info[];
> -int ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
> -               const struct ice_ctx_ele *ce_info);
> +
> +void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf);
> 
>  extern struct mutex ice_global_cfg_lock_sw;
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> index a76e5b0e7861..31d4a445d640 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> @@ -408,20 +408,6 @@ struct ice_rlan_ctx {
>         u8 prefena;     /* NOTE: normally must be set to 1 at init */
>  };
> 
> -struct ice_ctx_ele {
> -       u16 offset;
> -       u16 size_of;
> -       u16 width;
> -       u16 lsb;
> -};
> -
> -#define ICE_CTX_STORE(_struct, _ele, _width, _lsb) {   \
> -       .offset = offsetof(struct _struct, _ele),       \
> -       .size_of = sizeof_field(struct _struct, _ele),  \
> -       .width = _width,                                \
> -       .lsb = _lsb,                                    \
> -}
> -
>  /* for hsplit_0 field of Rx RLAN context */
>  enum ice_rlan_ctx_rx_hsplit_0 {
>         ICE_RLAN_RX_HSPLIT_0_NO_SPLIT           = 0,
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 260942877968..0a325dec804e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -909,8 +909,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
>         ice_setup_tx_ctx(ring, &tlan_ctx, pf_q);
>         /* copy context contents into the qg_buf */
>         qg_buf->txqs[0].txq_id = cpu_to_le16(pf_q);
> -       ice_set_ctx(hw, (u8 *)&tlan_ctx, (u8 *)&qg_buf->txqs[0].txq_ctx,
> -                   ice_tlan_ctx_info);
> +       ice_pack_txq_ctx(&tlan_ctx, &qg_buf->txqs[0].txq_ctx);
> 
>         /* init queue specific tail reg. It is referred as
>          * transmit comm scheduler queue doorbell.
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 48d95cb49864..905f5c745a7b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -6,6 +6,7 @@
>  #include "ice_adminq_cmd.h"
>  #include "ice_flow.h"
>  #include "ice_ptp_hw.h"
> +#include <linux/packing.h>
> 
>  #define ICE_PF_RESET_WAIT_COUNT        300
>  #define ICE_MAX_NETLIST_SIZE   10
> @@ -1385,9 +1386,12 @@ static int ice_copy_rxq_ctx_to_hw(struct ice_hw *hw,
>         return 0;
>  }
> 
> +#define ICE_CTX_STORE(struct_name, struct_field, width, lsb) \
> +       PACKED_FIELD((lsb) + (width) - 1, (lsb), struct struct_name, struct_field)
> +
>  /* LAN Rx Queue Context */
> -static const struct ice_ctx_ele ice_rlan_ctx_info[] = {
> -       /* Field                Width   LSB */
> +static const struct packed_field_s ice_rlan_ctx_fields[] = {
> +                                /* Field               Width   LSB */
>         ICE_CTX_STORE(ice_rlan_ctx, head,               13,     0),
>         ICE_CTX_STORE(ice_rlan_ctx, cpuid,              8,      13),
>         ICE_CTX_STORE(ice_rlan_ctx, base,               57,     32),
> @@ -1408,9 +1412,26 @@ static const struct ice_ctx_ele ice_rlan_ctx_info[] = {
>         ICE_CTX_STORE(ice_rlan_ctx, tphhead_ena,        1,      196),
>         ICE_CTX_STORE(ice_rlan_ctx, lrxqthresh,         3,      198),
>         ICE_CTX_STORE(ice_rlan_ctx, prefena,            1,      201),
> -       { 0 }
>  };
> 
> +/**
> + * ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
> + * @ctx: the Rx queue context to pack
> + * @buf: the HW buffer to pack into
> + *
> + * Pack the Rx queue context from the CPU-friendly unpacked buffer into its
> + * bit-packed HW layout.
> + */
> +static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
> +                            ice_rxq_ctx_buf_t *buf)
> +{
> +       CHECK_PACKED_FIELDS_20(ice_rlan_ctx_fields, ICE_RXQ_CTX_SZ);
> +       BUILD_BUG_ON(sizeof(*buf) != ICE_RXQ_CTX_SZ);
> +
> +       pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
> +                   QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
> +}
> +

FWIW, I noticed that smatch bails out checking all the CHECK_PACKED_FIELDS_*
variants >= 20, with the warning:

ice_common.c:1486 ice_pack_txq_ctx() parse error: OOM: 3000148Kb sm_state_count = 413556
ice_common.c:1486 ice_pack_txq_ctx() warn: Function too hairy.  No more merges.
ice_common.c:1486 ice_pack_txq_ctx() parse error: Function too hairy.  Giving up. 43 second

Maybe this can just be ignored .. not sure :-)

>  /**
>   * ice_write_rxq_ctx
>   * @hw: pointer to the hardware structure
> @@ -1431,12 +1452,13 @@ int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
> 
>         rlan_ctx->prefena = 1;
> 
> -       ice_set_ctx(hw, (u8 *)rlan_ctx, (u8 *)&buf, ice_rlan_ctx_info);
> +       ice_pack_rxq_ctx(rlan_ctx, &buf);
> +
>         return ice_copy_rxq_ctx_to_hw(hw, &buf, rxq_index);
>  }
> 
>  /* LAN Tx Queue Context */
> -const struct ice_ctx_ele ice_tlan_ctx_info[] = {
> +static const struct packed_field_s ice_tlan_ctx_fields[] = {
>                                     /* Field                    Width   LSB */
>         ICE_CTX_STORE(ice_tlan_ctx, base,                       57,     0),
>         ICE_CTX_STORE(ice_tlan_ctx, port_num,                   3,      57),
> @@ -1465,9 +1487,25 @@ const struct ice_ctx_ele ice_tlan_ctx_info[] = {
>         ICE_CTX_STORE(ice_tlan_ctx, drop_ena,                   1,      165),
>         ICE_CTX_STORE(ice_tlan_ctx, cache_prof_idx,             2,      166),
>         ICE_CTX_STORE(ice_tlan_ctx, pkt_shaper_prof_idx,        3,      168),
> -       { 0 }
>  };
> 
> +/**
> + * ice_pack_txq_ctx - Pack Tx queue context into a HW buffer
> + * @ctx: the Tx queue context to pack
> + * @buf: the HW buffer to pack into
> + *
> + * Pack the Tx queue context from the CPU-friendly unpacked buffer into its
> + * bit-packed HW layout.
> + */
> +void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf)
> +{
> +       CHECK_PACKED_FIELDS_27(ice_tlan_ctx_fields, ICE_TXQ_CTX_SZ);
> +       BUILD_BUG_ON(sizeof(*buf) != ICE_TXQ_CTX_SZ);
> +
> +       pack_fields(buf, sizeof(*buf), ctx, ice_tlan_ctx_fields,
> +                   QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
> +}
> +

Same here with the 27 variant.

>  /* Sideband Queue command wrappers */
> 
>  /**
> @@ -4545,205 +4583,6 @@ ice_aq_add_rdma_qsets(struct ice_hw *hw, u8 num_qset_grps,
> 
>  /* End of FW Admin Queue command wrappers */
> 
> -/**
> - * ice_pack_ctx_byte - write a byte to a packed context structure
> - * @src_ctx: unpacked source context structure
> - * @dest_ctx: packed destination context data
> - * @ce_info: context element description
> - */
> -static void ice_pack_ctx_byte(u8 *src_ctx, u8 *dest_ctx,
> -                             const struct ice_ctx_ele *ce_info)
> -{
> -       u8 src_byte, dest_byte, mask;
> -       u8 *from, *dest;
> -       u16 shift_width;
> -
> -       /* copy from the next struct field */
> -       from = src_ctx + ce_info->offset;
> -
> -       /* prepare the bits and mask */
> -       shift_width = ce_info->lsb % 8;
> -       mask = GENMASK(ce_info->width - 1 + shift_width, shift_width);
> -
> -       src_byte = *from;
> -       src_byte <<= shift_width;
> -       src_byte &= mask;
> -
> -       /* get the current bits from the target bit string */
> -       dest = dest_ctx + (ce_info->lsb / 8);
> -
> -       memcpy(&dest_byte, dest, sizeof(dest_byte));
> -
> -       dest_byte &= ~mask;     /* get the bits not changing */
> -       dest_byte |= src_byte;  /* add in the new bits */
> -
> -       /* put it all back */
> -       memcpy(dest, &dest_byte, sizeof(dest_byte));
> -}
> -
> -/**
> - * ice_pack_ctx_word - write a word to a packed context structure
> - * @src_ctx: unpacked source context structure
> - * @dest_ctx: packed destination context data
> - * @ce_info: context element description
> - */
> -static void ice_pack_ctx_word(u8 *src_ctx, u8 *dest_ctx,
> -                             const struct ice_ctx_ele *ce_info)
> -{
> -       u16 src_word, mask;
> -       __le16 dest_word;
> -       u8 *from, *dest;
> -       u16 shift_width;
> -
> -       /* copy from the next struct field */
> -       from = src_ctx + ce_info->offset;
> -
> -       /* prepare the bits and mask */
> -       shift_width = ce_info->lsb % 8;
> -       mask = GENMASK(ce_info->width - 1 + shift_width, shift_width);
> -
> -       /* don't swizzle the bits until after the mask because the mask bits
> -        * will be in a different bit position on big endian machines
> -        */
> -       src_word = *(u16 *)from;
> -       src_word <<= shift_width;
> -       src_word &= mask;
> -
> -       /* get the current bits from the target bit string */
> -       dest = dest_ctx + (ce_info->lsb / 8);
> -
> -       memcpy(&dest_word, dest, sizeof(dest_word));
> -
> -       dest_word &= ~(cpu_to_le16(mask));      /* get the bits not changing */
> -       dest_word |= cpu_to_le16(src_word);     /* add in the new bits */
> -
> -       /* put it all back */
> -       memcpy(dest, &dest_word, sizeof(dest_word));
> -}
> -
> -/**
> - * ice_pack_ctx_dword - write a dword to a packed context structure
> - * @src_ctx: unpacked source context structure
> - * @dest_ctx: packed destination context data
> - * @ce_info: context element description
> - */
> -static void ice_pack_ctx_dword(u8 *src_ctx, u8 *dest_ctx,
> -                              const struct ice_ctx_ele *ce_info)
> -{
> -       u32 src_dword, mask;
> -       __le32 dest_dword;
> -       u8 *from, *dest;
> -       u16 shift_width;
> -
> -       /* copy from the next struct field */
> -       from = src_ctx + ce_info->offset;
> -
> -       /* prepare the bits and mask */
> -       shift_width = ce_info->lsb % 8;
> -       mask = GENMASK(ce_info->width - 1 + shift_width, shift_width);
> -
> -       /* don't swizzle the bits until after the mask because the mask bits
> -        * will be in a different bit position on big endian machines
> -        */
> -       src_dword = *(u32 *)from;
> -       src_dword <<= shift_width;
> -       src_dword &= mask;
> -
> -       /* get the current bits from the target bit string */
> -       dest = dest_ctx + (ce_info->lsb / 8);
> -
> -       memcpy(&dest_dword, dest, sizeof(dest_dword));
> -
> -       dest_dword &= ~(cpu_to_le32(mask));     /* get the bits not changing */
> -       dest_dword |= cpu_to_le32(src_dword);   /* add in the new bits */
> -
> -       /* put it all back */
> -       memcpy(dest, &dest_dword, sizeof(dest_dword));
> -}
> -
> -/**
> - * ice_pack_ctx_qword - write a qword to a packed context structure
> - * @src_ctx: unpacked source context structure
> - * @dest_ctx: packed destination context data
> - * @ce_info: context element description
> - */
> -static void ice_pack_ctx_qword(u8 *src_ctx, u8 *dest_ctx,
> -                              const struct ice_ctx_ele *ce_info)
> -{
> -       u64 src_qword, mask;
> -       __le64 dest_qword;
> -       u8 *from, *dest;
> -       u16 shift_width;
> -
> -       /* copy from the next struct field */
> -       from = src_ctx + ce_info->offset;
> -
> -       /* prepare the bits and mask */
> -       shift_width = ce_info->lsb % 8;
> -       mask = GENMASK_ULL(ce_info->width - 1 + shift_width, shift_width);
> -
> -       /* don't swizzle the bits until after the mask because the mask bits
> -        * will be in a different bit position on big endian machines
> -        */
> -       src_qword = *(u64 *)from;
> -       src_qword <<= shift_width;
> -       src_qword &= mask;
> -
> -       /* get the current bits from the target bit string */
> -       dest = dest_ctx + (ce_info->lsb / 8);
> -
> -       memcpy(&dest_qword, dest, sizeof(dest_qword));
> -
> -       dest_qword &= ~(cpu_to_le64(mask));     /* get the bits not changing */
> -       dest_qword |= cpu_to_le64(src_qword);   /* add in the new bits */
> -
> -       /* put it all back */
> -       memcpy(dest, &dest_qword, sizeof(dest_qword));
> -}
> -
> -/**
> - * ice_set_ctx - set context bits in packed structure
> - * @hw: pointer to the hardware structure
> - * @src_ctx:  pointer to a generic non-packed context structure
> - * @dest_ctx: pointer to memory for the packed structure
> - * @ce_info: List of Rx context elements
> - */
> -int ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
> -               const struct ice_ctx_ele *ce_info)
> -{
> -       int f;
> -
> -       for (f = 0; ce_info[f].width; f++) {
> -               /* We have to deal with each element of the FW response
> -                * using the correct size so that we are correct regardless
> -                * of the endianness of the machine.
> -                */
> -               if (ce_info[f].width > (ce_info[f].size_of * BITS_PER_BYTE)) {
> -                       ice_debug(hw, ICE_DBG_QCTX, "Field %d width of %d bits larger than size of %d byte(s) ... skipping write\n",
> -                                 f, ce_info[f].width, ce_info[f].size_of);
> -                       continue;
> -               }
> -               switch (ce_info[f].size_of) {
> -               case sizeof(u8):
> -                       ice_pack_ctx_byte(src_ctx, dest_ctx, &ce_info[f]);
> -                       break;
> -               case sizeof(u16):
> -                       ice_pack_ctx_word(src_ctx, dest_ctx, &ce_info[f]);
> -                       break;
> -               case sizeof(u32):
> -                       ice_pack_ctx_dword(src_ctx, dest_ctx, &ce_info[f]);
> -                       break;
> -               case sizeof(u64):
> -                       ice_pack_ctx_qword(src_ctx, dest_ctx, &ce_info[f]);
> -                       break;
> -               default:
> -                       return -EINVAL;
> -               }
> -       }
> -
> -       return 0;
> -}
> -

Some nice cleanup!

>  /**
>   * ice_get_lan_q_ctx - get the LAN queue context for the given VSI and TC
>   * @hw: pointer to the HW struct
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 20bc40eec487..c4ea8ae65a95 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -292,6 +292,9 @@ config ICE
>         select DIMLIB
>         select LIBIE
>         select NET_DEVLINK
> +       select PACKING
> +       select PACKING_CHECK_FIELDS_20
> +       select PACKING_CHECK_FIELDS_27
>         select PLDMFW
>         select DPLL
>         help
> 
> --
> 2.47.0.265.g4ca455297942
> 
>

/Daniel

