Return-Path: <netdev+bounces-208949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5378BB0DAA2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8839B1655F4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7504828BA96;
	Tue, 22 Jul 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq+lxiGc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48285242D94;
	Tue, 22 Jul 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190358; cv=none; b=FoQxHKLJEZcIuN1YY4P85whwYL9Lz0O2IlRlH0cQHYIjV4fYtunvu9KjRdOvXxSBUVxlE61hUhhA/sZxB9kHmQJ1hGcfkLV4NCuV3gslM9Oin7hhH/+s95M8l+8eUv1En9lD62KNOXym6mzVfAaCC+Iqzyv9V05LyN50eX4sxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190358; c=relaxed/simple;
	bh=P/WzJ2D9t/ao8VHQl5uRNGISLH+oh58TVVF1a3iiIzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqur/ILUC63w07MfGmcGt68qf6ctkR6y404BZ/HiBhF3j5XAE4NG554yQ4OkFkDrr681/xyeyhkb58eM5obvXSGJg5rpsf8MhQeLw0pbF3Q/PnIfxomUgCJWayBkrhr+WxaEdtANG4f0vat00ZEA04SZku4gnbHX6xZFBGBzgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq+lxiGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72FFC4CEF1;
	Tue, 22 Jul 2025 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753190357;
	bh=P/WzJ2D9t/ao8VHQl5uRNGISLH+oh58TVVF1a3iiIzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iq+lxiGcFWezWsXBtQ//ad86nasH9e1YuE6TQ2fxJB2uKgCqHG646V9iQjX+E7yaw
	 ya1Nr28lfdtv83ebYJRcEb0J1glIRtoTJn83Z+GoFb3Iv2Y365Tlbf5VCMNGKsuL7X
	 QQZPPgn86YflmG81yBbJhplRD7hzSCBlKE6ifE6THzvvZG5oETKlsIz2TyEK5JRyrU
	 CzdxvfF0/IcG5WLoqMw4IZnGUSefpDwKp9p9UaecrnHp1JZPe86dcq7n46w3ZAR4RZ
	 S3I5L7k+7T+uB/CXdIMWszW7a4Owjy362YSHHjfdqCsuIdgPfsty1qiFBDtc7jvvry
	 a8TBzP7gZ+scw==
Date: Tue, 22 Jul 2025 14:19:11 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/15] net: rnpgbe: Add get_capability mbx_fw ops
 support
Message-ID: <20250722131911.GH2459@horms.kernel.org>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113238.18615-5-dong100@mucse.com>

On Mon, Jul 21, 2025 at 07:32:27PM +0800, Dong Yibo wrote:
> Initialize get hw capability from mbx_fw ops.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

...

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h

...

> +struct hw_abilities {
> +	u8 link_stat;
> +	u8 lane_mask;
> +	__le32 speed;
> +	__le16 phy_type;
> +	__le16 nic_mode;
> +	__le16 pfnum;
> +	__le32 fw_version;
> +	__le32 axi_mhz;
> +	union {
> +		u8 port_id[4];
> +		__le32 port_ids;
> +	};
> +	__le32 bd_uid;
> +	__le32 phy_id;
> +	__le32 wol_status;
> +	union {
> +		__le32 ext_ability;
> +		struct {
> +			__le32 valid : 1; /* 0 */
> +			__le32 wol_en : 1; /* 1 */
> +			__le32 pci_preset_runtime_en : 1; /* 2 */
> +			__le32 smbus_en : 1; /* 3 */
> +			__le32 ncsi_en : 1; /* 4 */
> +			__le32 rpu_en : 1; /* 5 */
> +			__le32 v2 : 1; /* 6 */
> +			__le32 pxe_en : 1; /* 7 */
> +			__le32 mctp_en : 1; /* 8 */
> +			__le32 yt8614 : 1; /* 9 */
> +			__le32 pci_ext_reset : 1; /* 10 */
> +			__le32 rpu_availble : 1; /* 11 */
> +			__le32 fw_lldp_ability : 1; /* 12 */
> +			__le32 lldp_enabled : 1; /* 13 */
> +			__le32 only_1g : 1; /* 14 */
> +			__le32 force_down_en: 1; /* 15 */
> +		} e;

I am not sure how __le32 bitfields work on big endian hosts. Do they?

I would suggest using some combination of BIT/GENMASK,
FIELD_PREP/FIELT_GET, and le32_from_cpu/cpu_from_le32 instead.

Flagged by Sparse.

> +		struct {
> +			u32 valid : 1; /* 0 */
> +			u32 wol_en : 1; /* 1 */
> +			u32 pci_preset_runtime_en : 1; /* 2 */
> +			u32 smbus_en : 1; /* 3 */
> +			u32 ncsi_en : 1; /* 4 */
> +			u32 rpu_en : 1; /* 5 */
> +			u32 v2 : 1; /* 6 */
> +			u32 pxe_en : 1; /* 7 */
> +			u32 mctp_en : 1; /* 8 */
> +			u32 yt8614 : 1; /* 9 */
> +			u32 pci_ext_reset : 1; /* 10 */
> +			u32 rpu_availble : 1; /* 11 */
> +			u32 fw_lldp_ability : 1; /* 12 */
> +			u32 lldp_enabled : 1; /* 13 */
> +			u32 only_1g : 1; /* 14 */
> +			u32 force_down_en: 1; /* 15 */
> +		} e_host;
> +	};
> +} __packed;

...

> +/* req is little endian. bigendian should be conserened */
> +struct mbx_fw_cmd_req {

...

> +		struct {
> +			__le32 lane;
> +			__le32 op;
> +			__le32 enable;
> +			__le32 inteval;

interval

Flagged by checkpatch.pl --codespell

...

> +/* firmware -> driver */
> +struct mbx_fw_cmd_reply {
> +	/* fw must set: DD, CMP, Error(if error), copy value */
> +	__le16 flags;
> +	/* from command: LB,RD,VFC,BUF,SI,EI,FE */
> +	__le16 opcode; /* 2-3: copy from req */
> +	__le16 error_code; /* 4-5: 0 if no error */
> +	__le16 datalen; /* 6-7: */
> +	union {
> +		struct {
> +			__le32 cookie_lo; /* 8-11: */
> +			__le32 cookie_hi; /* 12-15: */
> +		};
> +		void *cookie;
> +	};
> +	/* ===== data ==== [16-64] */
> +	union {
> +		u8 data[40];
> +
> +		struct version {
> +			__le32 major;
> +			__le32 sub;
> +			__le32 modify;
> +		} version;
> +
> +		struct {
> +			__le32 value[4];
> +		} r_reg;
> +
> +		struct {
> +			__le32 new_value;
> +		} modify_reg;
> +
> +		struct get_temp {
> +			__le32 temp;
> +			__le32 volatage;

voltage

> +		} get_temp;
> +
> +		struct {
> +#define MBX_SFP_READ_MAX_CNT 32
> +			u8 value[MBX_SFP_READ_MAX_CNT];
> +		} sfp_read;
> +
> +		struct mac_addr {
> +			__le32 lanes;
> +			struct _addr {
> +				/*
> +				 * for macaddr:01:02:03:04:05:06
> +				 * mac-hi=0x01020304 mac-lo=0x05060000
> +				 */
> +				u8 mac[8];
> +			} addrs[4];
> +		} mac_addr;
> +
> +		struct get_dump_reply {
> +			__le32 flags;
> +			__le32 version;
> +			__le32 bytes;
> +			__le32 data[4];
> +		} get_dump;
> +
> +		struct get_lldp_reply {
> +			__le32 value;
> +			__le32 inteval;

interval

> +		} get_lldp;
> +
> +		struct rnpgbe_eee_cap phy_eee_abilities;
> +		struct lane_stat_data lanestat;
> +		struct hw_abilities hw_abilities;
> +		struct phy_statistics phy_statistics;
> +	};
> +} __packed;

...

