Return-Path: <netdev+bounces-41720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623367CBC22
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C581C20912
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D3182DC;
	Tue, 17 Oct 2023 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UkaMoQ3z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB91747B
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:21:34 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95693
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:21:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507bd19eac8so549614e87.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697527291; x=1698132091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9fLTeqd+pfQZExO4SmQFOL9f70l8EA8aD+aWPF6bUs=;
        b=UkaMoQ3zpGQlG4eLKLzrW6QMpJbhdvQwyKHpCl/2iDIqbYYGKBKaTGtYIXKPoR/9lv
         4vmcEXXx2yTMv/I60+ZvmNK8Pr5DvyU1zJv3uLjvFaNMmyjxPLXYyPpz/jWD6a24WQAG
         TXm0xTy9XUvcNVCKRK1EiFS2R0bKxAp5T85I3Igzb/RXnMddG7AjefE1qHDPmi7ifkxx
         p9fpPoIplDsUNdhnywynyL419wbSMKdvglGycpf37OI2K75J7UanBiIyV2P1sWl3nX6/
         pa7iHeEp6uRAYIs4j1CPfkP3SzpJMUzppKtf/AlscTIoknQBMDL5thl/+9W3O1KX5v+k
         8Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697527291; x=1698132091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9fLTeqd+pfQZExO4SmQFOL9f70l8EA8aD+aWPF6bUs=;
        b=pwAXb1Zbhq0s2pSAy2Z0MRYr5bfpkhpTeqRdOMARf6IhAXtiC9hyX3XZEfkFpLrjbU
         D+DL6L0Kp/d7e0Zf9JcXTChbS0He9znb2nWz300yslTFmsmfeihWETA3iGkbQNsAZzKw
         K8ov5YKAt6qJAUWoMt9VBahk53BsaPoyn/uo4eSllE41rrue4a0wuiSoixc9uJnvB5Bk
         BhAKChxlP6IQN/ocC5BrIuPgtlGacRY+RQWSU/kzfTpUD0nlhYwgWPuwJtGPfiIC60bj
         tFitjuriHF7ezHnYmp7IZh6tsBM2p25HnBLhrNF5BOaZvNrfiNprgGAdJtcCYD0zuY+P
         gOgw==
X-Gm-Message-State: AOJu0Ywt4eD6WLVHFqV82QvvwD19R7roixldFDcAByBKlV+5GBCDTTG9
	+pN+CEeB2AdbAhHiaY51reR0QQ==
X-Google-Smtp-Source: AGHT+IEgHTgr9k0Um4OhvcPiCbPlv3fze4eR9i01t+Js8GJMAJYI4PzkdOFA1IlIrK69DbYQkSZVew==
X-Received: by 2002:a19:2d02:0:b0:500:7cab:efc3 with SMTP id k2-20020a192d02000000b005007cabefc3mr936591lfj.11.1697527291329;
        Tue, 17 Oct 2023 00:21:31 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d67cd000000b0032dbf32bd56sm996212wrw.37.2023.10.17.00.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:21:30 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:21:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, gnault@redhat.com, liuhangbin@gmail.com,
	lucien.xin@gmail.com
Subject: Re: [PATCH net 2/5] net: check for altname conflicts when changing
 netdev's netns
Message-ID: <ZS41+WxrRVqq9BgL@nanopsycho>
References: <20231016201657.1754763-1-kuba@kernel.org>
 <20231016201657.1754763-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016201657.1754763-3-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Oct 16, 2023 at 10:16:54PM CEST, kuba@kernel.org wrote:
>It's currently possible to create an altname conflicting
>with an altname or real name of another device by creating
>it in another netns and moving it over:
>
> [ ~]$ ip link add dev eth0 type dummy
>
> [ ~]$ ip netns add test
> [ ~]$ ip -netns test link add dev ethX netns test type dummy
> [ ~]$ ip -netns test link property add dev ethX altname eth0
> [ ~]$ ip -netns test link set dev ethX netns 1
>
> [ ~]$ ip link
> ...
> 3: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 02:40:88:62:ec:b8 brd ff:ff:ff:ff:ff:ff
> ...
> 5: ethX: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 26:b7:28:78:38:0f brd ff:ff:ff:ff:ff:ff
>     altname eth0
>
>Create a macro for walking the altnames, this hopefully makes
>it clearer that the list we walk contains only altnames.
>Which is otherwise not entirely intuitive.
>
>Fixes: 36fbf1e52bd3 ("net: rtnetlink: add linkprop commands to add and delete alternative ifnames")
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>CC: gnault@redhat.com
>CC: liuhangbin@gmail.com
>CC: lucien.xin@gmail.com
>CC: jiri@resnulli.us
>---
> net/core/dev.c | 9 ++++++++-
> net/core/dev.h | 3 +++
> 2 files changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index b08031957ffe..f4fa2692cf6d 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -1086,7 +1086,8 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
> 
> 		for_each_netdev(net, d) {
> 			struct netdev_name_node *name_node;
>-			list_for_each_entry(name_node, &d->name_node->list, list) {
>+
>+			netdev_for_each_altname(d, name_node) {

Well, cleaner would be to do this in a separate patch and the fix itself
too.

One way or another, code looks fine.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!


> 				if (!sscanf(name_node->name, name, &i))
> 					continue;
> 				if (i < 0 || i >= max_netdevices)
>@@ -11047,6 +11048,7 @@ EXPORT_SYMBOL(unregister_netdev);
> int __dev_change_net_namespace(struct net_device *dev, struct net *net,
> 			       const char *pat, int new_ifindex)
> {
>+	struct netdev_name_node *name_node;
> 	struct net *net_old = dev_net(dev);
> 	char new_name[IFNAMSIZ] = {};
> 	int err, new_nsid;
>@@ -11079,6 +11081,11 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
> 		if (err < 0)
> 			goto out;
> 	}
>+	/* Check that none of the altnames conflicts. */
>+	err = -EEXIST;
>+	netdev_for_each_altname(dev, name_node)
>+		if (netdev_name_in_use(net, name_node->name))
>+			goto out;
> 
> 	/* Check that new_ifindex isn't used yet. */
> 	if (new_ifindex) {
>diff --git a/net/core/dev.h b/net/core/dev.h
>index e075e198092c..d093be175bd0 100644
>--- a/net/core/dev.h
>+++ b/net/core/dev.h
>@@ -62,6 +62,9 @@ struct netdev_name_node {
> int netdev_get_name(struct net *net, char *name, int ifindex);
> int dev_change_name(struct net_device *dev, const char *newname);
> 
>+#define netdev_for_each_altname(dev, name_node)				\
>+	list_for_each_entry((name_node), &(dev)->name_node->list, list)
>+
> int netdev_name_node_alt_create(struct net_device *dev, const char *name);
> int netdev_name_node_alt_destroy(struct net_device *dev, const char *name);
> 
>-- 
>2.41.0
>

