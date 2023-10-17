Return-Path: <netdev+bounces-41741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370227CBCCB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C66B20F8C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FFF339A7;
	Tue, 17 Oct 2023 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nmHgtbzx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A5179A1
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:51:10 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2DCFB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:51:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c603e2354fso80770866b.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697529064; x=1698133864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtp5Dk2V0bXJ/0BVKTUHzPQ4mQRhcSAPMqIZjVjjJoc=;
        b=nmHgtbzxu17ceGIUszI4pk1NqBIIXSx7ydsac7Qm+9L4yIc+DFlnTXNRpM40jfzaUx
         ADoVDl8sLwDIgJfJG3JOSpjgIwzbCGdliN10XekK//wQ7tV2c9CONfYYt0noR9WoEW8v
         bFlXyDSv+ePJFejtHgVE3oIREdOpHl+gy4WhpoY9KZQrWGMJ/CbdDo0DVekQq7ijDccd
         0TtPTg8/8DMD6atwYWbbhtpF7Ot9Tq2wHNeRcLNZoYLXMs6z5nVclobCQA+hHLUL6evC
         f2/2OnrxAUFpzYSAZfnWD4iYitgVgEM9Rl1wpmh+1ZH5rDLxDhDLvNx1orNQxOPoecyG
         qN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529064; x=1698133864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtp5Dk2V0bXJ/0BVKTUHzPQ4mQRhcSAPMqIZjVjjJoc=;
        b=GvqRV9/zw4Sgh1OZldaQIm0MgA0LjXEBswsCNWLx33TjouNPU2Njyr/ReJMYgU7G+G
         7mLdCiQiharnN60Kk1xMQykiQPlXJU4ICjAo/pzr72LoCdn2fZghPyG/wCp7DHr8psUb
         a6wUW3pBg6oHt4/ac32g1CQM/wwhMzfnEPQZJzvWu+H+bYeeKCtkps9hYHGV2qEpbzdu
         ngI9GqLGYZLgpexTp4fWpeOoFHgTv9echV++ioDGYiY5qh698TXnpvCx0txxWXTLosBl
         qUdmssDbK0bl3FJi9HQkwjt0F+nvh4PWSHgP1A/9vVIM5lUVn1WOo/CcUgYIcPsAVpQi
         ArJw==
X-Gm-Message-State: AOJu0Yw+2TCOOVLngIwTKyJhRpMhvypALsq8AALSmfPkw9hIu/ufIxu8
	E0n8jLdKKihJbZ9mDHkxrIIXRQ==
X-Google-Smtp-Source: AGHT+IEJbc37Q7h3XQH/uiEmqmirFQpSb71pSKNd/9fEyzT24qRF418i5ACUplVkkHNnW/Pr5i3eNg==
X-Received: by 2002:a17:907:7ba0:b0:9b2:b15b:383d with SMTP id ne32-20020a1709077ba000b009b2b15b383dmr1219786ejc.11.1697529064073;
        Tue, 17 Oct 2023 00:51:04 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906178d00b0099293cdbc98sm732721eje.145.2023.10.17.00.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:51:03 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:51:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net 3/5] net: avoid UAF on deleted altname
Message-ID: <ZS485sWKKb99KrBx@nanopsycho>
References: <20231016201657.1754763-1-kuba@kernel.org>
 <20231016201657.1754763-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016201657.1754763-4-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Oct 16, 2023 at 10:16:55PM CEST, kuba@kernel.org wrote:
>Altnames are accessed under RCU (__dev_get_by_name())

dev_get_by_name_rcu()


>but freed by kfree() with no synchronization point.
>
>Because the name nodes don't hold a reference on the netdevice
>either, take the heavier approach of inserting synchronization

What about to use kfree_rcu() in netdev_name_node_free()
and treat node_name->dev as a rcu pointer instead?

struct net_device *dev_get_by_name_rcu(struct net *net, const char *name)
{
        struct netdev_name_node *node_name;

        node_name = netdev_name_node_lookup_rcu(net, name);
        return node_name ? rcu_deferecence(node_name->dev) : NULL;
}

This would avoid synchronize_rcu() in netdev_name_node_alt_destroy()

Btw, the next patch is smooth with this.


>points. Subsequent patch will remove the one added on device
>deletion path.
>
>Fixes: ff92741270bf ("net: introduce name_node struct to be used in hashlist")
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>CC: jiri@resnulli.us
>---
> net/core/dev.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index f4fa2692cf6d..7d5107cd5792 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -345,7 +345,6 @@ int netdev_name_node_alt_create(struct net_device *dev, const char *name)
> static void __netdev_name_node_alt_destroy(struct netdev_name_node *name_node)
> {
> 	list_del(&name_node->list);
>-	netdev_name_node_del(name_node);
> 	kfree(name_node->name);
> 	netdev_name_node_free(name_node);
> }
>@@ -364,6 +363,8 @@ int netdev_name_node_alt_destroy(struct net_device *dev, const char *name)
> 	if (name_node == dev->name_node || name_node->dev != dev)
> 		return -EINVAL;
> 
>+	netdev_name_node_del(name_node);
>+	synchronize_rcu();
> 	__netdev_name_node_alt_destroy(name_node);
> 
> 	return 0;
>@@ -10937,6 +10938,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
> 	synchronize_net();
> 
> 	list_for_each_entry(dev, head, unreg_list) {
>+		struct netdev_name_node *name_node;
> 		struct sk_buff *skb = NULL;
> 
> 		/* Shutdown queueing discipline. */
>@@ -10964,6 +10966,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
> 		dev_uc_flush(dev);
> 		dev_mc_flush(dev);
> 
>+		netdev_for_each_altname(dev, name_node)
>+			netdev_name_node_del(name_node);
>+		synchronize_rcu();
> 		netdev_name_node_alt_flush(dev);
> 		netdev_name_node_free(dev->name_node);
> 
>-- 
>2.41.0
>

