Return-Path: <netdev+bounces-34940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F147A613E
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84E11C20C07
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0983D3BC;
	Tue, 19 Sep 2023 11:32:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87433D82
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:32:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B500194
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695123137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uV8c3dipwfp+gvtDOlprko+QaysbTkKKLFGi7vFt724=;
	b=LQnyQgiqD9Bwn+8CFCEpiN0BenzP8nN7OpBAT4IXE8+4jj3cRGmTIZ+Nh0TJyoL+A67Yod
	aSMRYgkT297BZA0KzhzNU1TqgbEu6zbkX6n/o/8FcW7I62WS5qwe6lN5wJdcGki1CAS3wR
	hlQLfawhG/syusFSOdqF3f8sqcDyQxo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-DRjFjui6Me-b12bo2KFR5A-1; Tue, 19 Sep 2023 07:32:15 -0400
X-MC-Unique: DRjFjui6Me-b12bo2KFR5A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bfb9662d23so12188501fa.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695123134; x=1695727934;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uV8c3dipwfp+gvtDOlprko+QaysbTkKKLFGi7vFt724=;
        b=ECJdQPZLCkNG8KHL9J759ahS+2jRjVOq0NvfgHRndJGx/RzBN68XhLQDvmArdsWwnH
         U27BFlXvlZ3Du4fxLWQCQBBAFVX5dqs2kCnKbtxCMlyLzQtf7T7ZvgH1+ijh4hUAQ3Cw
         VxjiHNMshmg5CrBY2yMjMuWY6hPkQYB1uVccuKqZikcackzHLp0NMNgd4MxGfKTADggd
         +hbV/KNKNFDQJ/0G9/PzsdD6s0u4ZdAk1BDkn7ZuJf8R+wRdSKNikrSkX5FweBtw+DMD
         RyjiXyLkS1MWep/WBY7fC6iHUU7ywIu6yrFIuQxyo6QqKBu5PsshavWr1eGOBI6ZFONP
         0xow==
X-Gm-Message-State: AOJu0YzYnBKf4OSoaUCJR77Pvuvq/uOv+4QyJ43LP6qqiGFMhxXEYPzC
	vSwK7l2GKysm3EXOWNErJ9fIfkCQIzeYFmIMA6UCZi944+xHdRPl149qbH+xvx4Z+oXh7/7Ma7S
	V1pC8WA3IhWFZEKyq
X-Received: by 2002:a05:651c:331:b0:2b9:7034:9bbe with SMTP id b17-20020a05651c033100b002b970349bbemr7472378ljp.4.1695123134364;
        Tue, 19 Sep 2023 04:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvL+O44FMj66QTZdDS25vXpm7q4FV9JjiVweXZrgLxTSV5cwAP8tWfZpCzJGHDXMdpNnZzEA==
X-Received: by 2002:a05:651c:331:b0:2b9:7034:9bbe with SMTP id b17-20020a05651c033100b002b970349bbemr7472355ljp.4.1695123133994;
        Tue, 19 Sep 2023 04:32:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id n8-20020a170906378800b0099cd008c1a4sm7636739ejc.136.2023.09.19.04.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:32:13 -0700 (PDT)
Message-ID: <ba0063d31a926b1775fe98e56b15976b4d8726cd.camel@redhat.com>
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw: add mqprio qdisc
 offload in channel mode
From: Paolo Abeni <pabeni@redhat.com>
To: Roger Quadros <rogerq@kernel.org>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, vladimir.oltean@nxp.com
Cc: horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com, 
	p-varis@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rogerq@kernel.rog
Date: Tue, 19 Sep 2023 13:32:11 +0200
In-Reply-To: <20230918075358.5878-1-rogerq@kernel.org>
References: <20230918075358.5878-1-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 10:53 +0300, Roger Quadros wrote:
> @@ -937,3 +918,296 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw=
_common *common)
>  		       host->port_base + AM65_CPSW_PN_REG_PRI_CIR(tx_ch));

[...]

> +static int am65_cpsw_mqprio_verify_shaper(struct am65_cpsw_port *port,
> +					  struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	u64 min_rate_total =3D 0, max_rate_total =3D 0;
> +	u32 min_rate_msk =3D 0, max_rate_msk =3D 0;
> +	bool has_min_rate, has_max_rate;
> +	int num_tc, i;
> +	struct am65_cpsw_mqprio *p_mqprio =3D &port->qos.mqprio;
> +	struct netlink_ext_ack *extack =3D mqprio->extack;

Please, respect the reverse x-mas tree order.

> +
> +	if (!(mqprio->flags & TC_MQPRIO_F_SHAPER))
> +		return 0;
> +
> +	if (mqprio->shaper !=3D TC_MQPRIO_SHAPER_BW_RATE)
> +		return 0;
> +
> +	has_min_rate =3D !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
> +	has_max_rate =3D !!(mqprio->flags & TC_MQPRIO_F_MAX_RATE);
> +
> +	if (!has_min_rate && has_max_rate) {
> +		NL_SET_ERR_MSG_MOD(extack, "min_rate is required with max_rate");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!has_min_rate)
> +		return 0;
> +
> +	num_tc =3D mqprio->qopt.num_tc;
> +
> +	for (i =3D num_tc - 1; i >=3D 0; i--) {
> +		u32 ch_msk;
> +
> +		if (mqprio->min_rate[i])
> +			min_rate_msk |=3D BIT(i);
> +		min_rate_total +=3D  mqprio->min_rate[i];
> +
> +		if (has_max_rate) {
> +			if (mqprio->max_rate[i])
> +				max_rate_msk |=3D BIT(i);
> +			max_rate_total +=3D  mqprio->max_rate[i];
> +
> +			if (!mqprio->min_rate[i] && mqprio->max_rate[i]) {
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "TX tc%d rate max>0 but min=3D0\n",
> +						       i);
> +				return -EINVAL;
> +			}
> +
> +			if (mqprio->max_rate[i] &&
> +			    mqprio->max_rate[i] < mqprio->min_rate[i]) {
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "TX tc%d rate min(%llu)>max(%llu)\n",
> +						       i, mqprio->min_rate[i],
> +						       mqprio->max_rate[i]);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		ch_msk =3D GENMASK(num_tc - 1, i);
> +		if ((min_rate_msk & BIT(i)) && (min_rate_msk ^ ch_msk)) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack,
> +					       "TX min rate limiting has to be enabled sequentially hi->lo =
tx_rate_msk%x\n",
> +					       min_rate_msk);
> +			return -EINVAL;
> +		}
> +
> +		if ((max_rate_msk & BIT(i)) && (max_rate_msk ^ ch_msk)) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack,
> +					       "TX max rate limiting has to be enabled sequentially hi->lo =
tx_rate_msk%x\n",
> +					       max_rate_msk);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	min_rate_total *=3D 8;
> +	min_rate_total /=3D 1000 * 1000;
> +	max_rate_total *=3D 8;
> +	max_rate_total /=3D 1000 * 1000;

For consistency with other code doing the same algebra, you could use a
single statement for both '*' and '/'. You could also add an helper for
that conversion, as there are multiple use-case already.

> +
> +	if (port->qos.link_speed !=3D SPEED_UNKNOWN) {
> +		if (min_rate_total > port->qos.link_speed) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack, "TX rate min %llu exceeds link speed %=
d\n",
> +					       min_rate_total, port->qos.link_speed);
> +			return -EINVAL;
> +		}
> +
> +		if (max_rate_total > port->qos.link_speed) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack, "TX rate max %llu exceeds link speed %=
d\n",
> +					       max_rate_total, port->qos.link_speed);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	p_mqprio->shaper_en =3D 1;
> +	p_mqprio->max_rate_total =3D max_t(u64, min_rate_total, max_rate_total)=
;
> +
> +	return 0;
> +}
> +
> +static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
> +{
> +	struct am65_cpsw_port *port =3D am65_ndev_to_port(ndev);
> +	struct am65_cpsw_mqprio *p_mqprio =3D &port->qos.mqprio;
> +	struct am65_cpsw_common *common =3D port->common;
> +
> +	p_mqprio->shaper_en =3D 0;
> +	p_mqprio->max_rate_total =3D 0;
> +
> +	am65_cpsw_tx_pn_shaper_reset(port);
> +	netdev_reset_tc(ndev);
> +	netif_set_real_num_tx_queues(ndev, common->tx_ch_num);
> +
> +	/* Reset all Queue priorities to 0 */
> +	writel(0,
> +	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);

No need to wrap the above statement on multiple lines.

> +}
> +
> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_da=
ta)
> +{
> +	struct am65_cpsw_port *port =3D am65_ndev_to_port(ndev);
> +	struct am65_cpsw_mqprio *p_mqprio =3D &port->qos.mqprio;
> +	struct tc_mqprio_qopt_offload *mqprio =3D type_data;
> +	struct am65_cpsw_common *common =3D port->common;
> +	struct tc_mqprio_qopt *qopt =3D &mqprio->qopt;
> +	int tc, offset, count, ret, prio;
> +	u8 num_tc =3D qopt->num_tc;
> +	u32 tx_prio_map =3D 0;
> +	int i;
> +
> +	memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
> +
> +	if (!num_tc) {
> +		am65_cpsw_reset_tc_mqprio(ndev);
> +		return 0;
> +	}
> +
> +	ret =3D pm_runtime_get_sync(common->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(common->dev);
> +		return ret;
> +	}
> +
> +	ret =3D am65_cpsw_mqprio_verify_shaper(port, mqprio);
> +	if (ret)
> +		goto exit_put;
> +
> +	netdev_set_num_tc(ndev, num_tc);
> +
> +	/* Multiple Linux priorities can map to a Traffic Class
> +	 * A Traffic Class can have multiple contiguous Queues,
> +	 * Queues get mapped to Channels (thread_id),
> +	 *	if not VLAN tagged, thread_id is used as packet_priority
> +	 *	if VLAN tagged. VLAN priority is used as packet_priorit
> +	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
> +	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
> +	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
> +	 * assume that Queue_n gets mapped to header_priority_n. We can then
> +	 * set the switch priority in pn_tx_pri_map.
> +	 */
> +
> +	for (tc =3D 0; tc < num_tc; tc++) {
> +	 /* For simplicity we assign the same priority (TCn) to all queues
> +	  * of a Traffic Class.
> +	  */

Please align the comment with the relevant code.

[...]

> +diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ether=
net/ti/am65-cpsw-qos.h
> index 0cc2a3b3d7f9..5431fbf8b6e0 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
> @@ -9,6 +9,7 @@
>  #include <net/pkt_sched.h>
> =20
>  struct am65_cpsw_common;
> +struct am65_cpsw_port;
> =20
>  struct am65_cpsw_est {
>  	int buf;
> @@ -16,6 +17,12 @@ struct am65_cpsw_est {
>  	struct tc_taprio_qopt_offload taprio;
>  };
> =20
> +struct am65_cpsw_mqprio {
> +	struct tc_mqprio_qopt_offload mqprio_hw;
> +	u64 max_rate_total;
> +	unsigned shaper_en:1;

Perhaps 'bool' instead?


Cheers,

Paolo


