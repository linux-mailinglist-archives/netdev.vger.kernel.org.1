Return-Path: <netdev+bounces-12943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADCC73986C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD932817F8
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A838830;
	Thu, 22 Jun 2023 07:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882681FB4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 07:51:46 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9601A1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:51:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3094910b150so6994021f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687420301; x=1690012301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeKOG3SmthWv0DbuStt/suDJPACQGhMHBNxKdIDAJr0=;
        b=F/B0S0cVmfFVgc+PS/ic2JPtiHtm74v61KY4nNAKpZfbuPTZP7BhP2/4Bi6pfPxqIL
         VW4jw+mp9Tv761uy2WPNZXG6aviAAqSpsU7s7656aXwhLnAap+D9Wes9O8ll3mrMu57L
         waQ+UiaXFIRgq1R0lBajep4fAr4rZ7Iv1tvZYnWGztMgohySrxdYAEe388MQt+Hw90pj
         V9uSr9hVqZmNI7yPGS93T3uAud+5kB2SsXJqnIxt4Sa1GUroVornUW5tRXZD8dK5Rmlh
         YN4m/zlK/lgkvS4RJ9SqjM5RbtB/W3Ln5Ic6srBpw6PGflw5hxJhTLCkUXoDwd4JRzM6
         kmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420301; x=1690012301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeKOG3SmthWv0DbuStt/suDJPACQGhMHBNxKdIDAJr0=;
        b=kQrkQMuLl4t0vFw6CF8FO/oS+vZP3n0BHiiEf5KVC+UHLZKAZHMy/7jZG2wAPe7tHo
         mbTt91mM5f6pwxp01DVoGr3A5IuC00mEj1FlU6tGyX/bE6Tv2h0NGOfybMjN0oKgzFJb
         o4mf1vaBJQ6wbuR4wEnjuW820YR4iRYuahoLXPomxqzSNo1XwMunFesUxG0OwdlthGv7
         KYb7nxfOrnbm0iGxNIsLyiwslGMm1tmC2v8ThljMoFSnCvX4GQF9jUAf21sjnnuokSQO
         bcRJhVfkZ08BXxQhlLtlanwXpr9Qc11/vaHIXTWpotNExLWkB6VYKMczq2CTry5dN+A2
         my+g==
X-Gm-Message-State: AC+VfDxOduCgMmEth5cc+bEFy3T8z8XWg362NvrUbhAYHyYK0Plm8rXI
	dZ5DG1G40C/8LrwPAOzRJ/bBzA==
X-Google-Smtp-Source: ACHHUZ4BUFYu97t9mdfYA5KV6YA2C+Bz9BHAJiOYXmHN9/MPJdGw/NAIAIyFZinwusV1ZnTFyAqvNg==
X-Received: by 2002:a5d:5255:0:b0:30e:4714:bc93 with SMTP id k21-20020a5d5255000000b0030e4714bc93mr14177214wrc.5.1687420301108;
        Thu, 22 Jun 2023 00:51:41 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b003113943bb66sm6283824wru.110.2023.06.22.00.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:51:40 -0700 (PDT)
Date: Thu, 22 Jun 2023 09:51:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	david.m.ertman@intel.com, michal.swiatkowski@linux.intel.com,
	marcin.szycik@linux.intel.com, simon.horman@corigine.com
Subject: Re: [PATCH iwl-next] ice: Accept LAG netdevs in bridge offloads
Message-ID: <ZJP9i6DLPOfJkUyB@nanopsycho>
References: <20230622070956.357404-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622070956.357404-1-wojciech.drewek@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 22, 2023 at 09:09:56AM CEST, wojciech.drewek@intel.com wrote:
>Allow LAG interfaces to be used in bridge offload using
>netif_is_lag_master. In this case, search for ice netdev in
>the list of LAG's lower devices.
>
>Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
>Note for Tony: This patch needs to go with Dave's LAG
>patchset:
>https://lore.kernel.org/netdev/20230615162932.762756-1-david.m.ertman@intel.com/
>---
> .../net/ethernet/intel/ice/ice_eswitch_br.c   | 47 +++++++++++++++++--
> 1 file changed, 42 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
>index 1e57ce7b22d3..81b69ba9e939 100644
>--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
>+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
>@@ -15,8 +15,23 @@ static const struct rhashtable_params ice_fdb_ht_params = {
> 
> static bool ice_eswitch_br_is_dev_valid(const struct net_device *dev)
> {
>-	/* Accept only PF netdev and PRs */
>-	return ice_is_port_repr_netdev(dev) || netif_is_ice(dev);
>+	/* Accept only PF netdev, PRs and LAG */
>+	return ice_is_port_repr_netdev(dev) || netif_is_ice(dev) ||
>+		netif_is_lag_master(dev);
>+}
>+
>+static struct net_device *
>+ice_eswitch_br_get_uplnik_from_lag(struct net_device *lag_dev)

s/uplnik/uplink/


>+{
>+	struct net_device *lower;
>+	struct list_head *iter;
>+
>+	netdev_for_each_lower_dev(lag_dev, lower, iter) {
>+		if (netif_is_ice(lower))
>+			return lower;

What if there are 2 ice Nics in the same lag?


>+	}
>+
>+	return NULL;
> }
> 
> static struct ice_esw_br_port *
>@@ -26,8 +41,19 @@ ice_eswitch_br_netdev_to_port(struct net_device *dev)
> 		struct ice_repr *repr = ice_netdev_to_repr(dev);
> 
> 		return repr->br_port;
>-	} else if (netif_is_ice(dev)) {
>-		struct ice_pf *pf = ice_netdev_to_pf(dev);
>+	} else if (netif_is_ice(dev) || netif_is_lag_master(dev)) {
>+		struct net_device *ice_dev;
>+		struct ice_pf *pf;
>+
>+		if (netif_is_lag_master(dev))
>+			ice_dev = ice_eswitch_br_get_uplnik_from_lag(dev);
>+		else
>+			ice_dev = dev;
>+
>+		if (!ice_dev)
>+			return NULL;
>+
>+		pf = ice_netdev_to_pf(ice_dev);
> 
> 		return pf->br_port;
> 	}
>@@ -712,7 +738,18 @@ ice_eswitch_br_port_link(struct ice_esw_br_offloads *br_offloads,
> 
> 		err = ice_eswitch_br_vf_repr_port_init(bridge, repr);
> 	} else {
>-		struct ice_pf *pf = ice_netdev_to_pf(dev);
>+		struct net_device *ice_dev;
>+		struct ice_pf *pf;
>+
>+		if (netif_is_lag_master(dev))
>+			ice_dev = ice_eswitch_br_get_uplnik_from_lag(dev);
>+		else
>+			ice_dev = dev;
>+
>+		if (!ice_dev)
>+			return 0;
>+
>+		pf = ice_netdev_to_pf(ice_dev);
> 
> 		err = ice_eswitch_br_uplink_port_init(bridge, pf);
> 	}
>-- 
>2.40.1
>
>

