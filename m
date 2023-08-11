Return-Path: <netdev+bounces-26635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D528C778794
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FA21C20EB8
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DAAED7;
	Fri, 11 Aug 2023 06:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53EAA35
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:42:49 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C352694
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:42:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so2103030a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691736166; x=1692340966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UA0nO9juLyFW+Jtj68ZCAufXmqF67N7i4UPe3da6hdA=;
        b=rKBxI4JkGcPeKBzie4MolJGAyuZzD8n9xTyA9T2Bz4IfKm3Rj7bJu+svQCbyMqaeoz
         LMHxcwdT6Vju1TzGJKDBjiTgZLOl0kmtKGtVY8XNBoEi5dpTmLaLmezsq2CD0kwGh0KH
         /gucf++Erua7WzEDHU1jVwOcVpjILUQe4HSYyC8upHJJEUDYnfE+8Pz1BCJu2iWPUwZB
         G8PHngL/3JgwsGpj4QO8aAth7TK5poNxtEuA+h66IIZ7NSO4UsmI5tuQyath6fD9gJ72
         eK/jnYJs9utstbjRlvnI5+0aWbT/jiktj519yZOSn5p9kjtdp8LBRmqcPFWrY1EkiMFj
         YKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691736166; x=1692340966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA0nO9juLyFW+Jtj68ZCAufXmqF67N7i4UPe3da6hdA=;
        b=kFEG5Hhl9/bi6EE8/GE/9vpNqGPAdVSj+pgbo10I5Q4XK9ZhE5znPob+CMK6Lh6KH+
         +pRWZl2ywbVMwECXI/IoQOZGEiUfWo04+u86Z92xOJZq1OUT1K1kdHuDrn6cgIZsL0Zb
         J1PjVLBGng/cxwEa+OxpfiSL4a+LDQ5qhDmU3U6nYZvtCmzpYVKkjzkHTbViBljzFhFa
         M+PQ0VqImlIt/H4HiyZO/fAUx3hGVy7iYUXD5mUvH4AQV4P+bk8fghb8L3sWm2/13HyO
         glklm4T1Eh9G7NkEvDezGk961MYVD6HYWWe+JSuxfWCU2sIvLqzIT3ZX/2aAHe2muMXU
         sEAA==
X-Gm-Message-State: AOJu0Ywyd5wJ7T6YD4ANYeViy/g6KyhFvcmuY/KcBsHJg+sppTS7BfjB
	/gnZPNIt9JSKpQb+7inEZj3NXQ==
X-Google-Smtp-Source: AGHT+IHDWxBJUFHsdb8ij4Xm7UXaMOi5Gn2PETgDqr6LvRxVp7dLLlqlqZnWdCMwngbwDrFNKXI2rg==
X-Received: by 2002:a05:6402:b11:b0:522:27f1:3c06 with SMTP id bm17-20020a0564020b1100b0052227f13c06mr984018edb.21.1691736166538;
        Thu, 10 Aug 2023 23:42:46 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402074400b005233ec5f16bsm1641863edy.79.2023.08.10.23.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:42:45 -0700 (PDT)
Date: Fri, 11 Aug 2023 08:42:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net,
	Vladimir Oltean <vladimir.oltean@nxp.com>, gal@nvidia.com,
	tariqt@nvidia.com, lucien.xin@gmail.com, f.fainelli@gmail.com,
	andrew@lunn.ch, simon.horman@corigine.com, linux@rempel-privat.de,
	mkubecek@suse.cz
Subject: Re: [PATCH net-next v2 10/10] ethtool: netlink: always pass
 genl_info to .prepare_data
Message-ID: <ZNXYZRNJkAqw686J@nanopsycho>
References: <20230810233845.2318049-1-kuba@kernel.org>
 <20230810233845.2318049-11-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810233845.2318049-11-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 11, 2023 at 01:38:45AM CEST, kuba@kernel.org wrote:

[...]


>diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
>index f7b3171a0aad..3bbd5afb7b31 100644
>--- a/net/ethtool/netlink.c
>+++ b/net/ethtool/netlink.c
>@@ -444,12 +444,12 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
> 
> static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
> 				  const struct ethnl_dump_ctx *ctx,
>-				  struct netlink_callback *cb)
>+				  const struct genl_info *info)
> {
> 	void *ehdr;
> 	int ret;
> 
>-	ehdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
>+	ehdr = genlmsg_put(skb, info->snd_portid, info->snd_seq,
> 			   &ethtool_genl_family, NLM_F_MULTI,
> 			   ctx->ops->reply_cmd);
> 	if (!ehdr)
>@@ -457,7 +457,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
> 
> 	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
> 	rtnl_lock();
>-	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, NULL);
>+	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
> 	rtnl_unlock();
> 	if (ret < 0)
> 		goto out;
>@@ -495,7 +495,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
> 		dev_hold(dev);
> 		rtnl_unlock();
> 
>-		ret = ethnl_default_dump_one(skb, dev, ctx, cb);
>+		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
> 
> 		rtnl_lock();
> 		dev_put(dev);
>@@ -647,11 +647,14 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
> 	struct ethnl_reply_data *reply_data;
> 	const struct ethnl_request_ops *ops;
> 	struct ethnl_req_info *req_info;
>+	struct genl_info info;
> 	struct sk_buff *skb;
> 	void *reply_payload;
> 	int reply_len;
> 	int ret;
> 
>+	genl_info_init_ntf(&info, &ethtool_genl_family, cmd);
>+
> 	if (WARN_ONCE(cmd > ETHTOOL_MSG_KERNEL_MAX ||
> 		      !ethnl_default_notify_ops[cmd],
> 		      "unexpected notification type %u\n", cmd))
>@@ -670,7 +673,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
> 	req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
> 
> 	ethnl_init_reply_data(reply_data, ops, dev);
>-	ret = ops->prepare_data(req_info, reply_data, NULL);
>+	ret = ops->prepare_data(req_info, reply_data, &info);
> 	if (ret < 0)
> 		goto err_cleanup;
> 	ret = ops->reply_size(req_info, reply_data);


[...]


>@@ -24,7 +24,7 @@ const struct nla_policy ethnl_wol_get_policy[] = {
> 
> static int wol_prepare_data(const struct ethnl_req_info *req_base,
> 			    struct ethnl_reply_data *reply_base,
>-			    struct genl_info *info)
>+			    const struct genl_info *info)
> {
> 	struct wol_reply_data *data = WOL_REPDATA(reply_base);
> 	struct net_device *dev = reply_base->dev;
>@@ -39,7 +39,8 @@ static int wol_prepare_data(const struct ethnl_req_info *req_base,
> 	dev->ethtool_ops->get_wol(dev, &data->wol);
> 	ethnl_ops_complete(dev);
> 	/* do not include password in notifications */
>-	data->show_sopass = info && (data->wol.supported & WAKE_MAGICSECURE);
>+	data->show_sopass = genl_info_is_ntf(info) &&
>+		(data->wol.supported & WAKE_MAGICSECURE);

I believe that you are missing "!" here:
	data->show_sopass = !genl_info_is_ntf(info) &&
		(data->wol.supported & WAKE_MAGICSECURE);

But, you are changing the output for dumpit if I'm not mistaken.
ethnl_default_dump_one() currently calls this with info==NULL too, not
only ethnl_default_notify().

Anyway, the genl_info_is_ntf() itself seems a bit odd to me. The only
user is here and I doubt there ever going to be any other. This
conditional per-op attr fill seems a bit odd.

Can't you handle this in side ethtool somehow? IDK :/


> 
> 	return 0;
> }
>-- 
>2.41.0
>

