Return-Path: <netdev+bounces-44527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722C17D86F3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 18:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D78282087
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDFD2DF6A;
	Thu, 26 Oct 2023 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="va5WiXQZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50711CB3
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:48:44 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCB11AD
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:48:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b6f4c118b7so1116566b3a.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698338923; x=1698943723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsvtzZhaeGLEaz4oteU5Hnb+KWT4Jz2r9xbtXdijvP0=;
        b=va5WiXQZDKYe65Gw2TFpRu4zBvCBCD51aEQYvhjAzeLBgr/LBqOVqDxjCCgKuGIyLD
         nNAibJoSuebMviMvk6YhFiYoJxXyjiE/NatkbdAZQczMTxtQQPWndImWoanEgpM/2LdX
         /dLmFOE58Q5+deDGBuIdtr35SaDrXuvXbxj/OfbQPtkxeSkiEaXAmjyfWFD8NtuFVHj5
         AhhvkMuVBYUg78HWH73F2NSR6gcUQvm71G8tO1n8K7cqCcFNymzFve2vQ/pDUVYlgKS7
         mNUVLgAGqUPEbzHT9StdtYTO+Tt+xyUXw0p1vDwep4xzkKwVq5eGzT3A+AbqtsR01jpG
         SwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338923; x=1698943723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsvtzZhaeGLEaz4oteU5Hnb+KWT4Jz2r9xbtXdijvP0=;
        b=vSAJqUeNjcmRS04lgG/RQcva80pEPY5GXFKGca4joRaBOehxQM0j4rCNWrekOrqQXY
         z0ugrviWwNhOy4AO/hpsQIiNUb5/E49GzkqUUr31O31wCPNkX579mrkgsmRMDyhml6vv
         QPidk3sfcd1IbehEGpLhEJsdd2JccuY6dWPXeNTQtMkIslmEjAEqU9QwQjNjYewhGnru
         4Ih0n0iRF/YafeUTYOXHYsS6lNbTOZMLjig8qzRNxdGufCzsWBSXv42U8P0Tsp5l9oYL
         KPyzpd4Q1wczhSJjJcP2kjG+cWd3PMYqtrT98H64axAPvDtGMOwcegIqvrPzGo+pJ5dS
         ZXjw==
X-Gm-Message-State: AOJu0YxGCNZOhwbAUlUQgyD4u4snzSsUUAbPmvW9xepLYIG+NankdKFO
	Yva7JK6Ho9i8NWt//gat83KPMA==
X-Google-Smtp-Source: AGHT+IHbvOMnCphFZ0wNNkpM6jLDJMcgLAP1gCu3oFnu8OZ6vA3KZjiKKUu8/g1ZFm0ACGNRGoqEUA==
X-Received: by 2002:a05:6a20:9189:b0:156:e1ce:d4a1 with SMTP id v9-20020a056a20918900b00156e1ced4a1mr449257pzd.9.1698338922779;
        Thu, 26 Oct 2023 09:48:42 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id s188-20020a625ec5000000b0068fb9f98467sm11919892pfb.107.2023.10.26.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:48:42 -0700 (PDT)
Date: Thu, 26 Oct 2023 09:48:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Message-ID: <20231026094841.39f01d26@hermes.local>
In-Reply-To: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
References: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 15:50:50 -0700
longli@linuxonhyperv.com wrote:

> @@ -2347,6 +2342,12 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
>  	if (!ndev)
>  		return NOTIFY_DONE;
>  
> +	if (event == NETDEV_POST_INIT) {
> +		/* set slave flag before open to prevent IPv6 addrconf */
> +		vf_netdev->flags |= IFF_SLAVE;
> +		return NOTIFY_DONE;
> +	}
> +
>  	net_device_ctx = netdev_priv(ndev);
>  	netvsc_dev = rtnl_dereference(net_device_ctx->nvdev);
>  	if (!netvsc_dev || rtnl_dereference(net_device_ctx->vf_netdev))
> @@ -2753,8 +2754,9 @@ static int netvsc_netdev_event(struct notifier_block *this,
>  		return NOTIFY_DONE;
>  
>  	switch (event) {
> +	case NETDEV_POST_INIT:
>  	case NETDEV_REGISTER:
> -		return netvsc_register_vf(event_dev);
> +		return netvsc_register_vf(event_dev, event);

Although correct, this is an awkward way to write this.
There are two events which call register_vf() but the post init
one short circuits and doesn't really register the VF.

The code is clearer if flag is set in switch statement.

@@ -2206,9 +2206,6 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
-
 	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
@@ -2753,6 +2750,10 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_POST_INIT:
+		/* set slave flag before open to prevent IPv6 addrconf */
+		vf_netdev->flags |= IFF_SLAVE;
+		return NOTIFY_DONE;
 	case NETDEV_REGISTER:
 		return netvsc_register_vf(event_dev);
 	case NETDEV_UNREGISTER:



