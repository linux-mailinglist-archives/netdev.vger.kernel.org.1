Return-Path: <netdev+bounces-281671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EWRMChW8GkNSAEAu9opvQ
	(envelope-from <netdev+bounces-281671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:39:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C947E235
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABAE23001CE0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337F34D901;
	Tue, 28 Apr 2026 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="L62Io0Z8"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0E30CDA2;
	Tue, 28 Apr 2026 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358314; cv=none; b=MlQ6W3C/ukV1/NpRJ2l8MY7yz/sskO8FxyijTP5NUQDxnJdEbrxVrV9PAJflr9UE27J4UYIqPGJoigioW1l4R0sIKYusVWHZtPIoMhy9DNxYERn06ONn3McD5m0BO9pKnurX2gwE6YNdBnGEBTXk9ZQj9+XIzSeXuI6yAxzxwhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358314; c=relaxed/simple;
	bh=9HnGw/t7U1/Pbv+oGwm7p6ug5He8Nqsiefyt1ABg2XQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ohKcampj9SomDD9dXmkISElgNON/sN4UeQOnpZ1ZkKseGTcyaqzso8eaYqbEVMU/rQcrg5JJiSMIeo2AmOATmlDk2d8rDqczXvm5DMGzOaZCm63OTvV/fVtcYD9QT+v9NhWlCX3qPqqE0nJvfLvUCI9mEzGsKbXKimCiXXj3fiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=L62Io0Z8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63S6bs5F3222148, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777358275;
	bh=q++JEV4iiNxmphjYrzBFCgJHCztF3zPpUV/TZWmoBgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=L62Io0Z8/m4Sx/KHnbd05HY9mi2xvb2dEDXt2QwTyoRL71ZVOnDNjnhsOwTquzv9S
	 yya5fMUfzv3G3TpcQPQ+oO4hF2WPy6wJ2LlmNw6uabvav4f3cBGFJyz7MfJ/rcUxeV
	 GAzbN69Ljq9EODHFJgKncz6AAisbzQEtd3zyxf2vmKudbKs6wt/E2TvE7cLPFGaMWx
	 iYObgk3wgIIdjfpp3LAZEjI6b7ss0rJxyWHypNtxwGujhwO5Fu0WT/bOrYzg70w0BB
	 +DrYo5Hw5xJuGyUBDYMCroBOL0NxkqgoQe/HpVU3n2LiS62Nzk5lFFLoNNVspBJOws
	 FKmCzmnLsfsgA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63S6bs5F3222148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Apr 2026 14:37:55 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 28 Apr 2026 14:37:54 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Tue,
 28 Apr 2026 14:37:54 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Subbaraya Sundeep <sbhatta@marvell.com>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch net-next v1 9/9] r8169: add support for ethtool
Thread-Topic: [RFC Patch net-next v1 9/9] r8169: add support for ethtool
Thread-Index: AQHc0Gw5eixkY5b8f0iWI9ytCWf1u7XxJ6cAgALpwxA=
Date: Tue, 28 Apr 2026 06:37:54 +0000
Message-ID: <5f10215481794848892ba759a61e4bb6@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-10-javen_xu@realsil.com.cn>
 <20260426180546.GA791856@kernel-ep2>
In-Reply-To: <20260426180546.GA791856@kernel-ep2>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 064C947E235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281671-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]

>Hi,
>On 2026-04-20 at 07:49:57, javen (javen_xu@realsil.com.cn) wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> This patch add support for changing rx queues by ethtool. We can set
>> rx 1, 2, 4, 8 by ethtool -L eth1 rx num.
>>
>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 68
>> +++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>> b/drivers/net/ethernet/realtek/r8169_main.c
>> index 6b574fc336d6..57087abe7d88 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -6518,6 +6518,72 @@ static void r8169_init_napi(struct rtl8169_privat=
e
>*tp)
>>       }
>>  }
>>
>> +static void rtl8169_get_channels(struct net_device *dev,
>> +                              struct ethtool_channels *ch) {
>> +     struct rtl8169_private *tp =3D netdev_priv(dev);
>> +
>> +     ch->max_rx =3D tp->HwSuppNumRxQueues ? tp->HwSuppNumRxQueues :
>1;
>> +     ch->max_tx =3D tp->HwSuppNumTxQueues ? tp->HwSuppNumTxQueues :
>1;
>> +     ch->max_other =3D 0;
>> +     ch->max_combined =3D 0;
>> +
>> +     ch->rx_count =3D tp->num_rx_rings;
>> +     ch->tx_count =3D tp->num_tx_rings;
>> +     ch->other_count =3D 0;
>> +     ch->combined_count =3D 0;
>> +}
>> +
>> +static int rtl8169_set_channels(struct net_device *dev,
>> +                             struct ethtool_channels *ch) {
>> +     struct rtl8169_private *tp =3D netdev_priv(dev);
>> +     bool if_running =3D netif_running(dev);
>> +     int i;
>> +
>> +     if (!tp->rss_support && (ch->rx_count > 1 || ch->tx_count > 1)) {
>> +             netdev_warn(dev, "This chip does not support multiple
>channels/RSS.\n");
>> +             return -EOPNOTSUPP;
>> +     }
>> +
>> +     if (ch->rx_count =3D=3D 0 || ch->tx_count =3D=3D 0)
>> +             return -EINVAL;
>> +     if (ch->rx_count > tp->HwSuppNumRxQueues ||
>> +         ch->tx_count > tp->HwSuppNumTxQueues)
>> +             return -EINVAL;
>> +     if (ch->other_count || ch->combined_count)
>> +             return -EINVAL;
>> +
>> +     if (ch->rx_count =3D=3D tp->num_rx_rings &&
>> +         ch->tx_count =3D=3D tp->num_tx_rings)
>> +             return 0;
>> +
>Revisit the above checks, they are not needed since ethtool code does all
>these.
>> +     if (if_running)
>> +             rtl8169_close(dev);
>> +
>> +     tp->num_rx_rings =3D ch->rx_count;
>> +     tp->num_tx_rings =3D ch->tx_count;
>> +
>> +     tp->rss_enable =3D (tp->num_rx_rings > 1 && tp->rss_support);
>Please help me understand your HW..Is there a condition where there are
>multi Rx queues but HW do not support RSS? I dont know how traffic is
>distributed across queues in that case (maybe - pinning flows to individua=
l
>queues via ntuple or TC ?)
>
>Thanks,
>Sundeep
>
Hi, Sundeep

Thanks for your review.
This condition is not exist. I have removed it in the following link:
https://lore.kernel.org/netdev/f7dfe0357c04466895080f2b9aae1b56@realsil.com=
.cn/

BRs,
Javen
>> +
>> +     for (i =3D 0; i < tp->HwSuppIndirTblEntries; i++) {
>> +             if (tp->rss_enable)
>> +                     tp->rss_indir_tbl[i] =3D ethtool_rxfh_indir_defaul=
t(i, tp-
>>num_rx_rings);
>> +             else
>> +                     tp->rss_indir_tbl[i] =3D 0;
>> +     }
>> +
>> +     if (tp->rss_enable)
>> +             tp->InitRxDescType =3D RX_DESC_RING_TYPE_RSS;
>> +     else
>> +             tp->InitRxDescType =3D RX_DESC_RING_TYPE_DEAFULT;
>> +
>> +     if (if_running)
>> +             return rtl_open(dev);
>> +
>> +     return 0;
>> +}
>> +
>>  static const struct ethtool_ops rtl8169_ethtool_ops =3D {
>>       .supported_coalesce_params =3D ETHTOOL_COALESCE_USECS |
>>                                    ETHTOOL_COALESCE_MAX_FRAMES, @@
>> -6536,6 +6602,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops =
=3D {
>>       .nway_reset             =3D phy_ethtool_nway_reset,
>>       .get_eee                =3D rtl8169_get_eee,
>>       .set_eee                =3D rtl8169_set_eee,
>> +     .get_channels           =3D rtl8169_get_channels,
>> +     .set_channels           =3D rtl8169_set_channels,
>>       .get_link_ksettings     =3D phy_ethtool_get_link_ksettings,
>>       .set_link_ksettings     =3D rtl8169_set_link_ksettings,
>>       .get_ringparam          =3D rtl8169_get_ringparam,
>> --
>> 2.43.0
>>

