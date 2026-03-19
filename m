Return-Path: <netdev+bounces-269674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BeZKSpuvGkPygIAu9opvQ
	(envelope-from <netdev+bounces-269674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:44:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4BF2D2C5F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ACEF3081BEE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132840628F;
	Thu, 19 Mar 2026 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="mXG/UDAm"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07DE3D6CA7
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956642; cv=none; b=poY/AfecO428ve+ppI/KnRe3JSog2JNM33Uekir3y640U2vVA9++CXD/tUhVibk7NuJ2H1z5VxEJB3LpG0DK8wpVSykR+spR5h6JYNEBYHcX/RfTIFhJA7uuoEYX0JZshjFYZoSCn3S70dHYOhWBGagnc0Zr2XLUQIquBdIPLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956642; c=relaxed/simple;
	bh=fr+lDfiSMMNaE/s26s0qPfOntOd793P0wcaxZbWz1y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnRU8/HU01HrCxrjuPlgyseR0LYr2ropsCVVdogVvUQ8PVyl+IChAt8qTTxPYkgu4zADCsKHaG1tVmSqfpP/ec6suh9RFvHXXeOWx3c4it3hGeKVArigQluMjVDVt9psE7cZJlhOUVOze7BnKIYcCm4UWe+nuVfbAWs98SpCarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=mXG/UDAm; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 39101 invoked from network); 19 Mar 2026 22:43:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1773956630; bh=qaPVhbRu1G86zuwZYA6Qve/9kiObUTyjN99j4mbFB9I=;
          h=Subject:To:Cc:From;
          b=mXG/UDAmVoOaVNyjQdOukEISuA8NJOu/vCKKq9qDZ5wasLTKwLvWA/Nsq/PJ30j6G
           PwA37HSho/BIG3w0TQqZVZUWDoFIKqTMzCdAv0zU8n3dQRdCnuKg3i1wZLMc3kD+AO
           lNHvpO8LVvQgcop8JBneJoiJDfRbAJynipMVo85ZE8VewNzL0yxCaAP263nDUcnG9c
           2erIhvv/5vMNPWfK5GrrCvE3PSjPAHwktN5r8WUmokN5tlDowcT75XRPE1EKmd4s3C
           Faf9eQJrc00UoTcr0lJ76ZJsxFrcsvOu53EgCPcE6CYvdQtv6dD4+y0iCvz0ZkYgIS
           BzaFJyaZgdWLQ==
Received: from 83.5.169.164.ipv4.supernova.orange.pl (HELO [192.168.1.21]) (olek2@wp.pl@[83.5.169.164])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <mail@birger-koblitz.de>; 19 Mar 2026 22:43:50 +0100
Message-ID: <2bfede0e-f8d1-472d-80c4-7c3570b5921e@wp.pl>
Date: Thu, 19 Mar 2026 22:43:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
To: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
 <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 8505abe36b728b77c0bf681ff6f5e887
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0eNM]                               
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269674-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[wp.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:dkim,wp.pl:mid]
X-Rspamd-Queue-Id: 0D4BF2D2C5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Birger,

W dniu 17.03.2026 o 19:07, Birger Koblitz pisze:
> The RTL8157 supports 5GBit Link speeds. Add support for this speed
> in the setup and setting/getting through ethool. Also add 5GBit EEE.
> Add functionality for setup and ethtool get/set methods.
>
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
>   drivers/net/usb/r8152.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 3b6d4252d34c63ead8f11a120e212325a5f7d505..bab8e10e5f99afcb332e333c2739ed7509b03419 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -604,6 +604,7 @@ enum spd_duplex {
>   	FORCE_100M_FULL,
>   	FORCE_1000M_FULL,
>   	NWAY_2500M_FULL,
> +	NWAY_5000M_FULL,
>   };
>   
>   /* OCP_ALDPS_CONFIG */
> @@ -725,6 +726,7 @@ enum spd_duplex {
>   #define BP4_SUPER_ONLY		0x1578	/* RTL_VER_04 only */
>   
>   enum rtl_register_content {
> +	_5000bps	= BIT(12),

Based on other Realtek chips, I guess that BIT(11_ corresponds to 2500 Mbps
over two twisted pairs. Realtek calls this 5G Lite. Similarly, there are
2.5G Lite and 1G Lite, offering 1250 Mbps and 500 Mbps, respectively, over
two pairs of wires.


>   	_2500bps	= BIT(10),
>   	_1250bps	= BIT(9),
>   	_500bps		= BIT(8),
> @@ -738,6 +740,7 @@ enum rtl_register_content {
>   };
>   
>   #define is_speed_2500(_speed)	(((_speed) & (_2500bps | LINK_STATUS)) == (_2500bps | LINK_STATUS))
> +#define is_speed_5000(_speed)	(((_speed) & (_5000bps | LINK_STATUS)) == (_5000bps | LINK_STATUS))
>   #define is_flow_control(_speed)	(((_speed) & (_tx_flow | _rx_flow)) == (_tx_flow | _rx_flow))
>   
>   #define RTL8152_MAX_TX		4
> @@ -944,6 +947,7 @@ struct r8152 {
>   	unsigned int pipe_in, pipe_out, pipe_intr, pipe_ctrl_in, pipe_ctrl_out;
>   
>   	u32 support_2500full:1;
> +	u32 support_5000full:1;
>   	u32 lenovo_macpassthru:1;
>   	u32 dell_tb_rx_agg_bug:1;
>   	u16 ocp_base;
> @@ -1194,6 +1198,7 @@ enum tx_csum_stat {
>   #define RTL_ADVERTISED_1000_HALF		BIT(4)
>   #define RTL_ADVERTISED_1000_FULL		BIT(5)
>   #define RTL_ADVERTISED_2500_FULL		BIT(6)
> +#define RTL_ADVERTISED_5000_FULL		BIT(7)
>   
>   /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
>    * The RTL chips use a 64 element hash table based on the Ethernet CRC.
> @@ -5400,6 +5405,11 @@ static void r8156_eee_en(struct r8152 *tp, bool enable)
>   	else
>   		config &= ~MDIO_EEE_2_5GT;
>   
> +	if (enable && (tp->eee_adv2 & MDIO_EEE_5GT))
> +		config |= MDIO_EEE_5GT;
> +	else
> +		config &= ~MDIO_EEE_5GT;
> +
>   	ocp_reg_write(tp, OCP_EEE_ADV2, config);
>   }
>   
> @@ -6298,6 +6308,9 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>   
>   			if (tp->support_2500full)
>   				support |= RTL_ADVERTISED_2500_FULL;
> +
> +			if (tp->support_5000full)
> +				support |= RTL_ADVERTISED_5000_FULL;
>   		}
>   
>   		if (!(advertising & support))
> @@ -6343,15 +6356,20 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>   				r8152_mdio_write(tp, MII_CTRL1000, new1);
>   		}
>   
> -		if (tp->support_2500full) {
> +		if (tp->support_2500full || tp->support_5000full) {
>   			orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
> -			new1 = orig & ~MDIO_AN_10GBT_CTRL_ADV2_5G;
> +			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G);
>   
>   			if (advertising & RTL_ADVERTISED_2500_FULL) {
>   				new1 |= MDIO_AN_10GBT_CTRL_ADV2_5G;
>   				tp->ups_info.speed_duplex = NWAY_2500M_FULL;
>   			}
>   
> +			if (advertising & RTL_ADVERTISED_5000_FULL) {
> +				new1 |= MDIO_AN_10GBT_CTRL_ADV5G;
> +				tp->ups_info.speed_duplex = NWAY_5000M_FULL;
> +			}
> +
>   			if (orig != new1)
>   				ocp_reg_write(tp, OCP_10GBT_CTRL, new1);
>   		}
> @@ -8780,6 +8798,9 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
>   	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>   			 cmd->link_modes.supported, tp->support_2500full);
>   
> +	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +			 cmd->link_modes.supported, tp->support_5000full);
> +
>   	if (tp->support_2500full) {
>   		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>   				 cmd->link_modes.advertising,
> @@ -8793,6 +8814,19 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
>   			cmd->base.speed = SPEED_2500;
>   	}
>   
> +	if (tp->support_5000full) {
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +				 cmd->link_modes.advertising,
> +				 ocp_reg_read(tp, OCP_10GBT_CTRL) & MDIO_AN_10GBT_CTRL_ADV5G);
> +
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +				 cmd->link_modes.lp_advertising,
> +				 ocp_reg_read(tp, OCP_10GBT_STAT) & MDIO_AN_10GBT_STAT_LP5G);
> +
> +		if (is_speed_5000(rtl8152_get_speed(tp)))
> +			cmd->base.speed = SPEED_5000;
> +	}
> +
>   	mutex_unlock(&tp->control);
>   
>   	usb_autopm_put_interface(tp->intf);
> @@ -8840,6 +8874,10 @@ static int rtl8152_set_link_ksettings(struct net_device *dev,
>   		     cmd->link_modes.advertising))
>   		advertising |= RTL_ADVERTISED_2500_FULL;
>   
> +	if (test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +		     cmd->link_modes.advertising))
> +		advertising |= RTL_ADVERTISED_5000_FULL;
> +
>   	mutex_lock(&tp->control);
>   
>   	ret = rtl8152_set_speed(tp, cmd->base.autoneg, cmd->base.speed,
> @@ -8957,7 +8995,7 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
>   
>   	tp->eee_en = eee->eee_enabled;
>   	tp->eee_adv = val;
> -	if (tp->support_2500full) {
> +	if (tp->support_2500full || tp->support_5000full) {
>   		val = linkmode_to_mii_eee_cap2_t(eee->advertised);
>   		tp->eee_adv2 = val;
>   	}
> @@ -8994,6 +9032,13 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>   			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, common);
>   	}
>   
> +	if (tp->support_5000full) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, eee->supported);
> +
> +		if (speed & _5000bps)
> +			linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, common);
> +	}
> +
>   	eee->eee_enabled = tp->eee_en;
>   
>   	if (speed & _1000bps)
> @@ -9934,6 +9979,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
>   		} else {
>   			tp->speed = SPEED_1000;
>   		}
> +		if (tp->support_5000full &&
> +		    tp->udev->speed >= USB_SPEED_SUPER) {
> +			tp->speed = SPEED_5000;
> +			tp->advertising |= RTL_ADVERTISED_5000_FULL;
> +		}
>   		tp->advertising |= RTL_ADVERTISED_1000_FULL;
>   	}
>   	tp->duplex = DUPLEX_FULL;


Best regards,
Aleksander


