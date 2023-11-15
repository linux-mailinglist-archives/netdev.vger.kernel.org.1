Return-Path: <netdev+bounces-48061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFE67EC691
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D321C2091B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9B533CDB;
	Wed, 15 Nov 2023 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=heiner.kallweit@web.de header.b="YOLSRp6Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E828E2A
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 15:02:42 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64BD8E;
	Wed, 15 Nov 2023 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700060534; x=1700665334; i=heiner.kallweit@web.de;
	bh=QcefKxrK2VrasgqfbSiXBAsgKXWe8Q87Rf5w5FB2Yj0=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
	 In-Reply-To;
	b=YOLSRp6ZvaE1fH6nEzueqkWhuYGqT2LBa+kQ348E7MSDGt+3YtgoUfuew/el7FfQ
	 SfxGHWeSk+s8z4rlw+R0OBOwKOD+HRNkUN/E9UsmJ/4+0v9MfRla55v5XmW17oTbB
	 hlx7PJudTS0cN/7p8EAUGbbreppflPb+TLvkaetED3j5VdiyXv6qAsc8aJG0/SYRc
	 TJ7sZpwqWELTOegHzMRomh/fNOnPWJb0i7IqVGiK0+R5PZMRACkWnmJH4afpVwz0G
	 7BwuMs+LlfU9ibi8oKsZwp05bhGILHzY+H9tW+QpZ5CPvLH5O/TqxFzomWUYy10zs
	 1/6K1CpjEmUHAIEh5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.86] ([95.117.28.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2Phc-1r4v282DC2-004DWd; Wed, 15
 Nov 2023 16:02:14 +0100
Message-ID: <409a4eaf-3d2b-4de6-a0f0-245cc1523bee@web.de>
Date: Wed, 15 Nov 2023 16:02:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <heiner.kallweit@web.de>
Subject: Re: [PATCH net-next v11 10/13] net:ethernet:realtek:rtase: Implement
 ethtool function
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 pkshih@realtek.com, larry.chiu@realtek.com
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
 <20231115133414.1221480-11-justinlai0215@realtek.com>
Content-Language: en-US
In-Reply-To: <20231115133414.1221480-11-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fx7yuBKxygK2Gm12Vio5EL3zI0r4FjunQ6VuYAVKyV8jwsC7QoA
 pNAxVqKxBIbXqOLqFKN4ABSKJ8/QU8+3V3cDazrxpQAEIsu25iuCknGLr2FWaXVDBEEYxec
 BHN2mTA8TBb9qpTFi457fVgsxXtdldw/dkRnXonSlN5oEgewU05y4gR+lLKptEH9U18rhlR
 KZfZaT23QtUc6rX5c+RXA==
UI-OutboundReport: notjunk:1;M01:P0:9VpxuuT1nF4=;RKK+gL/I9ZYH5xWD1spAueBHQRp
 /pgJSXEucJAIYr2gJPWnaBSAkgcdpBbniPFOsuE4lN80yxaB346vs8jsKc+WXDj6uFrzA+9uQ
 GGYh2Wk8pX+h0yC30pX5eosArPXTu2UaKxbF9vDd/WOy09w+nNHm8Y1qjbTRmTXBNB/12Mtw8
 Fp0beu21cb5gTU5zf+eFWGW/YCB0DKy3sjXBpPs85dZwNoJARBUldkYUC9inDSUOQ43GYdiQm
 AAmbPfeX7uWRWOFARHhqzgla+eilyN6FNJNutFEp7tk0LpxiiYjdrpwxAV7u8GaOccL3LbJP6
 Vw7BVLH28IF7KHdkRExDNktKMDkYM5efA67RZbTK8+BrbYs21vV1Uj/XqZCWwuvomeNfdPxQa
 F86Dbon2wx0N5iDSPSJg1wDzlsfFC90mR2XLa5RK/3T2+DiqNIyTPlOiRO/inUKfge89VkYZ/
 /A/o9555bAOqlUQ3i31fttc6cER6cpeO0sDzmzNj0ZcTUio2PMcB5ALUE7wYButSlilS1NisL
 viEolowPdyCP/H918svxnxjLViWjIKGOf4WoEDaP6fBgBdkLCHAzeIAzaAZueskM1ey+1ELAT
 4u1Ki1vJQSVd7fn28QQeoDO3PcaJN54bp4MgA12OArnKT/oL0bwkqoIITl/jqr6nDnacKTvw0
 MyqLCyrXPDwXpl/gh7Y0SYpcYihgio5YTxzrX0dOYPOxok2NXUMf4JFqBC/zXjsbkUMRYogrd
 wAVPAZ/O7TG6W+BefGuYgVDTMKGEv3706jxep2uYoGnKBhm+UVxugiWKquvHiUQhBzH6nlbzv
 Wp

On 15.11.2023 14:34, Justin Lai wrote:
> Implement the ethtool function to support users to obtain network card
> information, including obtaining various device settings, Report whether
> physical link is up, Report pause parameters, Set pause parameters,
> Return a set of strings that describe the requested objects, Get number
> of strings that @get_strings will write, Return extended statistics
> about the device.
>
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/n=
et/ethernet/realtek/rtase/rtase_main.c
> index b7679b74cc8a..5ea4d51fcc47 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1900,9 +1900,153 @@ static void rtase_get_mac_address(struct net_dev=
ice *dev)
>  	ether_addr_copy(dev->perm_addr, dev->dev_addr);
>  }
>
> +static void rtase_get_drvinfo(struct net_device *dev,
> +			      struct ethtool_drvinfo *drvinfo)
> +{
> +	const struct rtase_private *tp =3D netdev_priv(dev);
> +
> +	strscpy(drvinfo->driver, KBUILD_MODNAME, 32);
> +	strscpy(drvinfo->bus_info, pci_name(tp->pdev), 32);
> +}
> +
> +static int rtase_get_settings(struct net_device *dev,
> +			      struct ethtool_link_ksettings *cmd)
> +{
> +	u32 supported =3D SUPPORTED_MII | SUPPORTED_Pause | SUPPORTED_Asym_Pau=
se;
> +
> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
> +						supported);
> +	cmd->base.speed =3D SPEED_5000;
> +	cmd->base.duplex =3D DUPLEX_FULL;
> +	cmd->base.port =3D PORT_MII;
> +	cmd->base.autoneg =3D AUTONEG_DISABLE;
> +
What are you reporting here? Does this refer to the link between MAC and
switch CPU port? Because I would assume that the switch ports can do auton=
eg.

> +	return 0;
> +}
> +
> +static void rtase_get_pauseparam(struct net_device *dev,
> +				 struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp =3D netdev_priv(dev);
> +	u16 value =3D rtase_r16(tp, RTASE_CPLUS_CMD);
> +
> +	pause->autoneg =3D AUTONEG_DISABLE;
> +
> +	if ((value & (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) =3D=3D
> +	    (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) {
> +		pause->rx_pause =3D 1;
> +		pause->tx_pause =3D 1;
> +	} else if ((value & FORCE_TXFLOW_EN)) {
> +		pause->tx_pause =3D 1;
> +	} else if ((value & FORCE_RXFLOW_EN)) {
> +		pause->rx_pause =3D 1;
> +	}
> +}
> +
> +static int rtase_set_pauseparam(struct net_device *dev,
> +				struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp =3D netdev_priv(dev);
> +	u16 value =3D rtase_r16(tp, RTASE_CPLUS_CMD);
> +
> +	if (pause->autoneg)
> +		return -EOPNOTSUPP;
> +
> +	value &=3D ~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
> +
> +	if (pause->tx_pause)
> +		value |=3D FORCE_TXFLOW_EN;
> +
> +	if (pause->rx_pause)
> +		value |=3D FORCE_RXFLOW_EN;
> +
> +	rtase_w16(tp, RTASE_CPLUS_CMD, value);
> +	return 0;
> +}
> +
> +static const char rtase_gstrings[][ETH_GSTRING_LEN] =3D {
> +	"tx_packets",
> +	"rx_packets",
> +	"tx_errors",
> +	"rx_errors",
> +	"rx_missed",
> +	"align_errors",
> +	"tx_single_collisions",
> +	"tx_multi_collisions",
> +	"unicast",
> +	"broadcast",
> +	"multicast",
> +	"tx_aborted",
> +	"tx_underrun",
> +};
> +
> +static void rtase_get_strings(struct net_device *dev, u32 stringset, u8=
 *data)
> +{
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		memcpy(data, *rtase_gstrings, sizeof(rtase_gstrings));
> +		break;
> +	}
> +}
> +
> +static int rtase_get_sset_count(struct net_device *dev, int sset)
> +{
> +	int ret =3D -EOPNOTSUPP;
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		ret =3D ARRAY_SIZE(rtase_gstrings);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void rtase_get_ethtool_stats(struct net_device *dev,
> +				    struct ethtool_stats *stats, u64 *data)
> +{
> +	struct rtase_private *tp =3D netdev_priv(dev);
> +	const struct rtase_counters *counters;
> +
> +	ASSERT_RTNL();
> +
> +	counters =3D tp->tally_vaddr;
> +	if (!counters)
> +		return;
> +
> +	rtase_dump_tally_counter(tp);
> +
> +	data[0] =3D le64_to_cpu(counters->tx_packets);
> +	data[1] =3D le64_to_cpu(counters->rx_packets);
> +	data[2] =3D le64_to_cpu(counters->tx_errors);
> +	data[3] =3D le32_to_cpu(counters->rx_errors);
> +	data[4] =3D le16_to_cpu(counters->rx_missed);
> +	data[5] =3D le16_to_cpu(counters->align_errors);
> +	data[6] =3D le32_to_cpu(counters->tx_one_collision);
> +	data[7] =3D le32_to_cpu(counters->tx_multi_collision);
> +	data[8] =3D le64_to_cpu(counters->rx_unicast);
> +	data[9] =3D le64_to_cpu(counters->rx_broadcast);
> +	data[10] =3D le32_to_cpu(counters->rx_multicast);
> +	data[11] =3D le16_to_cpu(counters->tx_aborted);
> +	data[12] =3D le16_to_cpu(counters->tx_underun);
> +}
> +
> +static const struct ethtool_ops rtase_ethtool_ops =3D {
> +	.get_drvinfo =3D rtase_get_drvinfo,
> +	.get_link =3D ethtool_op_get_link,
> +	.get_link_ksettings =3D rtase_get_settings,
> +	.get_pauseparam =3D rtase_get_pauseparam,
> +	.set_pauseparam =3D rtase_set_pauseparam,
> +	.get_strings =3D rtase_get_strings,
> +	.get_sset_count =3D rtase_get_sset_count,
> +	.get_ethtool_stats =3D rtase_get_ethtool_stats,
> +	.get_ts_info =3D ethtool_op_get_ts_info,
> +};
> +
>  static void rtase_init_netdev_ops(struct net_device *dev)
>  {
>  	dev->netdev_ops =3D &rtase_netdev_ops;
> +	dev->ethtool_ops =3D &rtase_ethtool_ops;
>  }
>
>  static void rtase_reset_interrupt(struct pci_dev *pdev,


