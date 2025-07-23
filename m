Return-Path: <netdev+bounces-209187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D4DB0E8FD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 05:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88198561368
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FA717B418;
	Wed, 23 Jul 2025 03:16:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490943D81;
	Wed, 23 Jul 2025 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753240617; cv=none; b=kLabF9hBxa7fy/LY3U5QTu+n0oxbQnO6FlhDOvHoYuvT6BYJaR5TFhKqJVsTaiXwe8AOthW1kjN0i7zSCjda8hMSSSyg4HPsmLRhS5ELHXeScYq6Dpd8vaDb70NcWuuJSXm8N6x5Lc5LlZp3w5YVT/xEhq6mJkRfjLzkPBoUb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753240617; c=relaxed/simple;
	bh=I12L53fYK2ryxp9LT/HlT/GNEMYvF7rY0WsUxEJ19DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twL+pXSHY6Pd9Ohl0yfFSZpZOGQYrWBc7IJm8uBogZcMqSlDM13NQHKninYOYvnNuzBVt/TipQbL73eEFcozGIlcFvd11HBrDK0EQtj7iGWUAj+yhaSotb16fa+MCFxJnJI7vedN48PHls5i4+DbZZnXcWL8jw3dtjnJvM7IylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz20t1753240538tca712300
X-QQ-Originating-IP: rV4rwNUFxgiirp9k9ZNGLT0VujxOTivokED8/hNhqE8=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 11:15:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8027666437285959459
Date: Wed, 23 Jul 2025 11:15:36 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <91FE839B62404862+20250723031536.GC169181@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-5-dong100@mucse.com>
 <20250722131911.GH2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722131911.GH2459@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MQPu5pFEJFN4Chn/tB2LVYSD57KfyWpNHTxcnN2LPjRqbFLv4bBOeKSo
	ZfTYpdN5o/ZrBBba986ko5tAX2qcV18Ye1hfWK9QqUksq0IzW3RhN0wh+AigFxC3NLChb/U
	SDk8R1EId7WUBVUgAHadUDlF6UeITjSEA7eG1veyR7A8PdkmYQKwh3rH4H0e2r8SHHOvDF9
	tFcYHrhRKkmwAPu16A/jKRap1sSvrQGvqszkq5Ze6vGf/xgI6vLpAP0UxOWYRBlL7HPqLU8
	R9X1te1l4nK6u4ANfhPDP8I/uwKInMMbX4EnXuaJd1FInBCkRPEN5CEe81YJig19Bjm6C2V
	Sg2SrDbod5334dlR7M+a8Lq/XcOLMMv5Rvp1qecj0+Idaa9uNexCwn+3taJtm7TZVQHxmRf
	0W2A5RnMRrlC2zSV8Tq2DN3rl88Q5pDmK/KRhirIOdHMuZQcUIA9tIWggE+g4bn/V0ouGDK
	RjucS/xCciS8FipFkBg6Uejf1KhObVzjaaCEQ7CeADd/lcZOwIsreZINIGyErexlvoAySc/
	gbFdXzUp3zHdBCgjErKnglbfLM1hEsx+Hjv1rTPD6O9C5eXLsxkhjXCnlTooqkJQFyWtR5r
	67USvRa2xJJfx3x5Jlg7mYefdJ6e03y2czWgaMYJ/9ekcaegSBAl1HzKoEvqu2GSQ0QI06y
	KOZ1jtAGJJj/53dhqbDtEx4C42zt0VOLMiaBVm/ZxQFsESbL/ru0bxGsdyxFTmBGiKKsrCI
	W/BaZ4IoEWm0t3Q7vAQJheBOjBFC5/TRVNffw01b1C4zFfxD0L9Rr4N3Sg1oCKAgaqbXPiy
	QOIeWMonH/lvekHJgmhL2zitfoiQUOsUBwKPEVddb4GRbvjFvqybFZiaTMzYARMPARtIKW/
	J27YZMs8jaCBztlMM0FGo7Eq208xpDbhsBS3pYlbKaTd0QyeXPX3pTMltX9swjr4YPttbEX
	dOPgM2Wtre/kwFpNBCHcOhXjvsv+hIFx3o3aA3wTgxpADZ42J+neFirv/XsDzjj/RxBEtpp
	pQDGWxxDIz8zp+BhM54FsdC2QhMJg=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 02:19:11PM +0100, Simon Horman wrote:
> On Mon, Jul 21, 2025 at 07:32:27PM +0800, Dong Yibo wrote:
> > Initialize get hw capability from mbx_fw ops.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> 
> ...
> 
> > +struct hw_abilities {
> > +	u8 link_stat;
> > +	u8 lane_mask;
> > +	__le32 speed;
> > +	__le16 phy_type;
> > +	__le16 nic_mode;
> > +	__le16 pfnum;
> > +	__le32 fw_version;
> > +	__le32 axi_mhz;
> > +	union {
> > +		u8 port_id[4];
> > +		__le32 port_ids;
> > +	};
> > +	__le32 bd_uid;
> > +	__le32 phy_id;
> > +	__le32 wol_status;
> > +	union {
> > +		__le32 ext_ability;
> > +		struct {
> > +			__le32 valid : 1; /* 0 */
> > +			__le32 wol_en : 1; /* 1 */
> > +			__le32 pci_preset_runtime_en : 1; /* 2 */
> > +			__le32 smbus_en : 1; /* 3 */
> > +			__le32 ncsi_en : 1; /* 4 */
> > +			__le32 rpu_en : 1; /* 5 */
> > +			__le32 v2 : 1; /* 6 */
> > +			__le32 pxe_en : 1; /* 7 */
> > +			__le32 mctp_en : 1; /* 8 */
> > +			__le32 yt8614 : 1; /* 9 */
> > +			__le32 pci_ext_reset : 1; /* 10 */
> > +			__le32 rpu_availble : 1; /* 11 */
> > +			__le32 fw_lldp_ability : 1; /* 12 */
> > +			__le32 lldp_enabled : 1; /* 13 */
> > +			__le32 only_1g : 1; /* 14 */
> > +			__le32 force_down_en: 1; /* 15 */
> > +		} e;
> 
> I am not sure how __le32 bitfields work on big endian hosts. Do they?
> 
> I would suggest using some combination of BIT/GENMASK,
> FIELD_PREP/FIELT_GET, and le32_from_cpu/cpu_from_le32 instead.
> 
> Flagged by Sparse.
> 

You are right, '__le32 bitfields' is error. I will fix it. 

> > +		struct {
> > +			u32 valid : 1; /* 0 */
> > +			u32 wol_en : 1; /* 1 */
> > +			u32 pci_preset_runtime_en : 1; /* 2 */
> > +			u32 smbus_en : 1; /* 3 */
> > +			u32 ncsi_en : 1; /* 4 */
> > +			u32 rpu_en : 1; /* 5 */
> > +			u32 v2 : 1; /* 6 */
> > +			u32 pxe_en : 1; /* 7 */
> > +			u32 mctp_en : 1; /* 8 */
> > +			u32 yt8614 : 1; /* 9 */
> > +			u32 pci_ext_reset : 1; /* 10 */
> > +			u32 rpu_availble : 1; /* 11 */
> > +			u32 fw_lldp_ability : 1; /* 12 */
> > +			u32 lldp_enabled : 1; /* 13 */
> > +			u32 only_1g : 1; /* 14 */
> > +			u32 force_down_en: 1; /* 15 */
> > +		} e_host;
> > +	};
> > +} __packed;
> 
> ...
> 
> > +/* req is little endian. bigendian should be conserened */
> > +struct mbx_fw_cmd_req {
> 
> ...
> 
> > +		struct {
> > +			__le32 lane;
> > +			__le32 op;
> > +			__le32 enable;
> > +			__le32 inteval;
> 
> interval
> 
> Flagged by checkpatch.pl --codespell
> 
> ...
> 

Got it, I will also use checkpatch.pl to check other patches.

> > +/* firmware -> driver */
> > +struct mbx_fw_cmd_reply {
> > +	/* fw must set: DD, CMP, Error(if error), copy value */
> > +	__le16 flags;
> > +	/* from command: LB,RD,VFC,BUF,SI,EI,FE */
> > +	__le16 opcode; /* 2-3: copy from req */
> > +	__le16 error_code; /* 4-5: 0 if no error */
> > +	__le16 datalen; /* 6-7: */
> > +	union {
> > +		struct {
> > +			__le32 cookie_lo; /* 8-11: */
> > +			__le32 cookie_hi; /* 12-15: */
> > +		};
> > +		void *cookie;
> > +	};
> > +	/* ===== data ==== [16-64] */
> > +	union {
> > +		u8 data[40];
> > +
> > +		struct version {
> > +			__le32 major;
> > +			__le32 sub;
> > +			__le32 modify;
> > +		} version;
> > +
> > +		struct {
> > +			__le32 value[4];
> > +		} r_reg;
> > +
> > +		struct {
> > +			__le32 new_value;
> > +		} modify_reg;
> > +
> > +		struct get_temp {
> > +			__le32 temp;
> > +			__le32 volatage;
> 
> voltage
> 

Got it, I will fix this.

> > +		} get_temp;
> > +
> > +		struct {
> > +#define MBX_SFP_READ_MAX_CNT 32
> > +			u8 value[MBX_SFP_READ_MAX_CNT];
> > +		} sfp_read;
> > +
> > +		struct mac_addr {
> > +			__le32 lanes;
> > +			struct _addr {
> > +				/*
> > +				 * for macaddr:01:02:03:04:05:06
> > +				 * mac-hi=0x01020304 mac-lo=0x05060000
> > +				 */
> > +				u8 mac[8];
> > +			} addrs[4];
> > +		} mac_addr;
> > +
> > +		struct get_dump_reply {
> > +			__le32 flags;
> > +			__le32 version;
> > +			__le32 bytes;
> > +			__le32 data[4];
> > +		} get_dump;
> > +
> > +		struct get_lldp_reply {
> > +			__le32 value;
> > +			__le32 inteval;
> 
> interval
> 

Got it, I will fix this.

> > +		} get_lldp;
> > +
> > +		struct rnpgbe_eee_cap phy_eee_abilities;
> > +		struct lane_stat_data lanestat;
> > +		struct hw_abilities hw_abilities;
> > +		struct phy_statistics phy_statistics;
> > +	};
> > +} __packed;
> 
> ...
> 

Thanks for your feedback.


