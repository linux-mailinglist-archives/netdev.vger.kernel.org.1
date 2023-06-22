Return-Path: <netdev+bounces-12958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12AE73995E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F19A28182C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B104015AFE;
	Thu, 22 Jun 2023 08:23:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EAD13ADF
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:23:04 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A561BF2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:23:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9c532f9e3so14872665e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687422180; x=1690014180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aieGnSRt/Al2RSH4zix5cydCGGwAPEa4pZ2MuD6YlxU=;
        b=kWz5+kgIc/E2hEpLAVbY5+omy7+x1NqoWi+Cf8iKlWuYQr+lQIMlAgGjJDwT3tkWf2
         C56myJOOPRd5wEB9tI3tsxFTbbSSqhp9SSgArvELQJatEl9tviyIzFuV5JePmA0s5rrV
         wZ0JuO9iYLrjDYW9g0Yfup1zZOMAAEH/FC37I6kjQqd1O3O/FnmwhL/fdtYnvocOmTb7
         g/k4WBSYP3x7NfgS1XV4n7YIpFlfxT2IP5O5rCMpdtSZ2N+xSlvNmV+kqESGj5pw03Iz
         LKY61jhR/UcDS0lqRDkUhuzBZc1KFyIhJ6GOjbglN76Sz0kbkmF75yF01F7WL3xH4i/I
         ylFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422180; x=1690014180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aieGnSRt/Al2RSH4zix5cydCGGwAPEa4pZ2MuD6YlxU=;
        b=F1ZQxpFEKv9CK9ln7KwEYhMMoGgz57M2jylBbjXfXgxGHHRs/dQk8MGiVGve5B/S3X
         O5v3N9FM+bR4huiSw3NCGgckktxOLYsyn5eY/TLAnJITIXN6C+4GdI548jW75PkKTaPz
         3yp+/mWz118PfKdLM5JPwZKM66JGrb+q6c9xdxWmyzPHeis0tbAgfhmnQVhvC2Lzq9in
         FZ9bNyQi6ddZXLtf2puQFkQrOTirIFPhIHXhH3ifILNMyAyO8FhdoL/lGIws4RgiAVq3
         7Q59JMCzdC+JidSn2ulztaE6Og3fwQSgHgID8cGTBZI7PDYrz8SMZOXpKYnd4zqn3/27
         mrmA==
X-Gm-Message-State: AC+VfDyQO5LVOraKUaMvK0rZkJmw444XrtIj9/h4bdA1ll+kX14tro5J
	uSdZEln+r2XmtvEjxJr91WKQGE1ZYj8SHjlgw+nfxg==
X-Google-Smtp-Source: ACHHUZ7Eb8abrSnKsPkGKg/b3Yq3hgltd8UBrqBkk6qCafAWFFSZ5neoD4ghj/pKM56a8gdLRWHhvA==
X-Received: by 2002:a1c:750a:0:b0:3f7:cb42:fa28 with SMTP id o10-20020a1c750a000000b003f7cb42fa28mr14287444wmc.28.1687422179974;
        Thu, 22 Jun 2023 01:22:59 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id l5-20020a1ced05000000b003f70a7b4537sm18098727wmh.36.2023.06.22.01.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:22:58 -0700 (PDT)
Date: Thu, 22 Jun 2023 10:22:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Piotr Gardocki <piotrx.gardocki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com, michal.swiatkowski@linux.intel.com,
	pmenzel@molgen.mpg.de, kuba@kernel.org,
	maciej.fijalkowski@intel.com, anthony.l.nguyen@intel.com,
	simon.horman@corigine.com, aleksander.lobakin@intel.com,
	gal@nvidia.com
Subject: Re: [PATCH net-next] net: fix net device address assign type
Message-ID: <ZJQE4ieud5Mf8iGi@nanopsycho>
References: <20230621132106.991342-1-piotrx.gardocki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621132106.991342-1-piotrx.gardocki@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 03:21:06PM CEST, piotrx.gardocki@intel.com wrote:
>Commit ad72c4a06acc introduced optimization to return from function

Out of curiosity, what impact does this optimization have? Is it worth
it to have such optimization at all? Wouldn't simple revert of the fixes
commit do the trick? If not, see below.


>quickly if the MAC address is not changing at all. It was reported
>that such change causes dev->addr_assign_type to not change
>to NET_ADDR_SET from _PERM or _RANDOM.
>Restore the old behavior and skip only call to ndo_set_mac_address.
>
>Fixes: ad72c4a06acc ("net: add check for current MAC address in dev_set_mac_address")
>Reported-by: Gal Pressman <gal@nvidia.com>
>Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
>---
> net/core/dev.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index e4ff0adf5523..69a3e544676c 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -8781,14 +8781,14 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
> 		return -EINVAL;
> 	if (!netif_device_present(dev))
> 		return -ENODEV;
>-	if (!memcmp(dev->dev_addr, sa->sa_data, dev->addr_len))
>-		return 0;
> 	err = dev_pre_changeaddr_notify(dev, sa->sa_data, extack);
> 	if (err)
> 		return err;
>-	err = ops->ndo_set_mac_address(dev, sa);
>-	if (err)
>-		return err;
>+	if (memcmp(dev->dev_addr, sa->sa_data, dev->addr_len)) {
>+		err = ops->ndo_set_mac_address(dev, sa);
>+		if (err)
>+			return err;
>+	}
> 	dev->addr_assign_type = NET_ADDR_SET;
> 	call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);

Although I don't think the notifiers here and
dev_pre_changeaddr_notify() above have to be called in case the address
didn't actually change, it restores the old behaviour, even with the
netlink notification, which is probably good.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


> 	add_device_randomness(dev->dev_addr, dev->addr_len);
>-- 
>2.34.1
>
>

