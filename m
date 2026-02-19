Return-Path: <netdev+bounces-259388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBmMHpxnlmleewIAu9opvQ
	(envelope-from <netdev+bounces-259388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:30:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE515B5EE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8CB03019111
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C2325C6EE;
	Thu, 19 Feb 2026 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkgJwX+R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB282264D3;
	Thu, 19 Feb 2026 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771464601; cv=none; b=ff7asTfDNYaqM3XHZnABqyAQcoBaAG0uepV/BXN5VYAxJfqAa3ZXO3dFRji4qA5PJvmO/fK1OQvfb+56BWukD31R1bhu+kg1EGH17CNA3d/hCXVSj2QcDRWjs0QQbxBtYf9hRHAQSuAQQskeO4lMuH2xC+O/yjA1mBw36ZN4CEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771464601; c=relaxed/simple;
	bh=T8Ma8VZaNHsXdV3GsG9USlali9VvMOZ+l/Y7uA1elPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJ2wQ9ll8Labovyj9PpTQ8yXAvJPOHoj2vG0a9XlCgVhmeLvDae42x8Us1bR6e4jEexbPULzSeztf/YFx36DmcPPwXZ2bbFNWe/qWXI4ybAkzsbTxGrisEzayr+MUflJ+IFp2Arz1oRCf1Ax9BNcuTm6klTrBl8tGybg1MUNq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkgJwX+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E974CC116D0;
	Thu, 19 Feb 2026 01:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771464601;
	bh=T8Ma8VZaNHsXdV3GsG9USlali9VvMOZ+l/Y7uA1elPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OkgJwX+Rpz97LiFNEnUJFmma0Wi0St8j+K2fdxDbG0N1l35LGvqIzVSSfw8FvSQ5q
	 Q6/gSfRyxq+0OmLaucO+Mjwduld5zAkTSxvQ1+6PmURNByzTn/JzAQJkdVheFxebdK
	 QXKjxd99Njs8LB/8HrdG6AFFtUGcjBTazeiU+jo3LzBZk14lhAUupC6MRYG2JVH+aC
	 +Dne/41oE0a830V3HUu+SYpISfaE86TJ8IBtJbrvtbPjTAtolqgn0t3ymecqKAMVY6
	 /sSCRfOj774KqzX4FSedIeRPRK9TGPAxgRnWgjoOKvSVtqMMigdfowQnQ6uNFOgIi5
	 fz8tAV6AUxatw==
Date: Wed, 18 Feb 2026 17:30:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tiernan Hubble <thubble@thubble.ca>
Cc: Igor Russkikh <irusskikh@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lorenz Brun
 <lorenz@brun.one>, Andrew Lunn <andrew@lunn.ch>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: atlantic: fix reading SFP module info on
 some AQC100 cards
Message-ID: <20260218173000.01a44c80@kernel.org>
In-Reply-To: <20260216224913.419470-1-thubble@thubble.ca>
References: <20260216224913.419470-1-thubble@thubble.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259388-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,thubble.ca:email]
X-Rspamd-Queue-Id: DEEE515B5EE
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 16:49:12 -0600 Tiernan Hubble wrote:
> Commit 853a2944aaf3 ("net: atlantic: support reading SFP module info")
> added support for reading SFP module info on AQC100-based cards. However,
> it only supports reading directly from the controller's hardware
> registers, and this does not seem to be supported on certain cards,
> including my TRENDnet TEG-10GECSFP V3. "ethtool -m" times out when reading
> certain registers, even when I increase the read poll timeout values.
> 
> The DPDK "atlantic" driver reads module info via firmware calls instead of
> directly reading the hardware registers, provided that the NIC's firmware
> version supports it.
> 
> This change adapts the DPDK firmware call code to the kernel driver. It
> preserves the old hardware-based module read code as a fallback when the
> firmware does not support it, to avoid breaking cards that are currently
> working.
> 
> Tested on 2 different TRENDnet TEG-10GECSFP V3 cards, both with firmware
> version 3.1.121 (current at the time of this patch). Both cards correctly
> reported module info for a passive DAC cable and 2 different 10G optical
> transceivers.
> 
> Fixes: 853a2944aaf3 ("net: atlantic: support reading SFP module info")
> Signed-off-by: Tiernan Hubble <thubble@thubble.ca>

Overall looks quite nice, but I don't think it qualifies as a fix.
Fix means something regressed from previous release, crashes, etc
For the adapters in question IIUC ethtool -m has never worked before.
Please drop the Fixes tag and repost next week for net-next.

Some drive by comments below..

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> index a6e1826dd5d7..5be9e9ee7e9f 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> @@ -983,6 +983,36 @@ static int aq_ethtool_set_phy_tunable(struct net_device *ndev,
>  	return err;
>  }
>  
> +static bool aq_ethtool_can_read_module_eeprom(struct aq_nic_s *aq_nic)
> +{
> +	return aq_nic->aq_fw_ops->read_module_eeprom ||
> +		aq_nic->aq_hw_ops->hw_read_module_eeprom;
> +}
> +
> +static int aq_ethtool_read_module_eeprom(struct aq_nic_s *aq_nic, u8 dev_addr,
> +					 u8 reg_start_addr, int len, u8 *data)
> +{
> +	int err = -EOPNOTSUPP;

maybe add a temp variable:

	const struct aq_fw_ops *ops = aq_nic->aq_fw_ops;

> +	if (aq_nic->aq_fw_ops->read_module_eeprom) {
> +		err = aq_nic->aq_fw_ops->read_module_eeprom(aq_nic->aq_hw,

to avoid the long lines and awkward wrapping ?

> +			dev_addr, reg_start_addr, len, data);
> +
> +		/* If the only error is that the firmware version doesn't
> +		 * support reading EEPROM, we can still attempt to read it
> +		 * directly from the hardware if supported.
> +		 */
> +		if (err != -EOPNOTSUPP)
> +			return err;
> +	}
> +
> +	if (aq_nic->aq_hw_ops->hw_read_module_eeprom)
> +		err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,

and here

> +			dev_addr, reg_start_addr, len, data);
> +
> +	return err;
> +}

> +static int aq_fw2x_read_module_eeprom(struct aq_hw_s *self, u8 dev_addr,
> +				      u8 reg_start_addr, int len, u8 *data)
> +{
> +	u32 low_status, orig_low_status, low_req = 0;
> +	u32 res_bytes_remain_cnt = len % sizeof(u32);
> +	u32 res_dword_cnt = len / sizeof(u32);
> +	struct smbus_request request = { 0 };
> +	u32 req_dword_cnt;
> +	u32 result = 0;
> +	u32 caps_lo;
> +	u32 offset;
> +	int err;
> +
> +	caps_lo = aq_fw2x_get_link_capabilities(self);
> +	if (!(caps_lo & BIT(CAPS_LO_SMBUS_READ)))
> +		return -EOPNOTSUPP;
> +
> +	request.msg_id = 0;
> +	request.device_id = dev_addr;
> +	request.address = reg_start_addr;
> +	request.length = len;
> +
> +	/* Write SMBUS request to cfg memory */
> +	req_dword_cnt = (sizeof(request) + sizeof(u32) - 1) / sizeof(u32);

DIV_ROUND_UP()

> +	err = hw_atl_write_fwcfg_dwords(self, (void *)&request, req_dword_cnt);
> +	if (err < 0)
> +		return err;
> +
> +	/* Toggle 0x368.CAPS_LO_SMBUS_READ bit */
> +	low_req = aq_hw_read_reg(self, HW_ATL_FW2X_MPI_CONTROL_ADDR);
> +	orig_low_status = low_req & BIT(CAPS_LO_SMBUS_READ);

the mixing of BIT(CAPS_LO_SMBUS_READ)..

> +	low_req ^= HW_ATL_FW2X_CAP_SMBUS_READ;

.. and HW_ATL_FW2X_CAP_SMBUS_READ which is defined to

+#define HW_ATL_FW2X_CAP_SMBUS_READ       BIT(CAPS_LO_SMBUS_READ)

seems unnecessary and confusing?
-- 
pw-bot: cr

