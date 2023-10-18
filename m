Return-Path: <netdev+bounces-42140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 667897CD559
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7DEB20D76
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B3101CC;
	Wed, 18 Oct 2023 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vgIPcLmZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873A8C1A
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:13:06 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C4FA
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:13:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a29c7eefso5232576e87.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697613181; x=1698217981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAv4H7+8yJJA4zQFNn1Q9Oz7y8shtvBLOcJomcr4PqQ=;
        b=vgIPcLmZ9DVkcrO4dPyXtAXew6abzf0rGowaRM3Lo0zg/sHMiYIMaBWat/ElvZt3h6
         plBRfMujFDb0gKFnKMD8FLQ3CQwML/Q8BX9uIlIf+I8xxB+z1mY6fnq4NjzHJKgi7mA/
         BO6h4WWsgwmrowQ72I04jgvccAsOyuH1LO++sIm55wlreBOgdAIGQhFzav54ojBehJRb
         JT7vNer8EX0+vyp/JfR0TJu8/SsE47Ll7tUa1RaSbRGKzlKYcBQ3CQ1u1utm8Ii8qhnZ
         63+VAWRsJK2eGFdRPZT/RzlDqMeyUWMynMfczSMHwSpXlra9ao9SJzp0+zYJXDIj09p3
         L6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697613181; x=1698217981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAv4H7+8yJJA4zQFNn1Q9Oz7y8shtvBLOcJomcr4PqQ=;
        b=gKsQQqbXAnublHVXeQYfYA2QL3euhg+WzwACX0BImffYczCc5T0oBPdMiHwQYgF8Ch
         jPF7UMF6MRk00VYq9USe0Y2791iNLQ2hTlZr5Az8lO4Fx8t00KmESppHI1vxBSLdQ0WG
         M215WBN1ZGZugbt1bUmbo32VY0DT+so6A8nvIFLlsQcvDjibFFvyE2Pu5AEQqIMq8ErC
         WsaQzZ/7BjiwdC4wVp2vZB0gUTDYnJfHtQ6fPDVmFi0g5ls5hHFVjVRyxG20LDdDECNZ
         PlvBUe3rxdbhbrj857JhSK6djTOSJsR/AXFd60GNK9i8UOeFS+tm8shMWxDboB7ECP+U
         aHzw==
X-Gm-Message-State: AOJu0YzJP6aPyv09EaNk1V/HFLDAQ9EeDvLPx/UnEU0VyxT9Ve2T8QDz
	3TNnkj+9kaxQP0ePu60qswSfEA==
X-Google-Smtp-Source: AGHT+IFEtdObCiuQ+vKITuG+q/KegGBfYd3/1B++a4qEgjLDMDN1+34pVv7fMnTIfwbbJph7JVm2xg==
X-Received: by 2002:ac2:4c4b:0:b0:503:446:c7b0 with SMTP id o11-20020ac24c4b000000b005030446c7b0mr3994764lfk.32.1697613181027;
        Wed, 18 Oct 2023 00:13:01 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc450000000b003fee6e170f9sm850135wmi.45.2023.10.18.00.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 00:13:00 -0700 (PDT)
Date: Wed, 18 Oct 2023 09:12:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com,
	daniel@iogearbox.net, opurdila@ixiacom.com
Subject: Re: [PATCH net v2 1/5] net: fix ifname in netlink ntf during netns
 move
Message-ID: <ZS+FehME4fC4b7w4@nanopsycho>
References: <20231018013817.2391509-1-kuba@kernel.org>
 <20231018013817.2391509-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018013817.2391509-2-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 18, 2023 at 03:38:13AM CEST, kuba@kernel.org wrote:
>dev_get_valid_name() overwrites the netdev's name on success.
>This makes it hard to use in prepare-commit-like fashion,
>where we do validation first, and "commit" to the change
>later.
>
>Factor out a helper which lets us save the new name to a buffer.
>Use it to fix the problem of notification on netns move having
>incorrect name:
>
> 5: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
>     link/ether be:4d:58:f9:d5:40 brd ff:ff:ff:ff:ff:ff
> 6: eth1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
>     link/ether 1e:4a:34:36:e3:cd brd ff:ff:ff:ff:ff:ff
>
> [ ~]# ip link set dev eth0 netns 1 name eth1
>
>ip monitor inside netns:
> Deleted inet eth0
> Deleted inet6 eth0
> Deleted 5: eth1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
>     link/ether be:4d:58:f9:d5:40 brd ff:ff:ff:ff:ff:ff new-netnsid 0 new-ifindex 7
>
>Name is reported as eth1 in old netns for ifindex 5, already renamed.
>
>Fixes: d90310243fd7 ("net: device name allocation cleanups")
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>v2:
> - use a temp buffer in dev_get_valid_name() to avoid
>   clobering dev->name on error
> - move dev_prep_valid_name() up a bit, this will help later
>   cleanups in net-next
>
>CC: daniel@iogearbox.net
>CC: opurdila@ixiacom.com
>---
> net/core/dev.c | 44 +++++++++++++++++++++++++++++++-------------
> 1 file changed, 31 insertions(+), 13 deletions(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index 5aaf5753d4e4..f109ad34d660 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -1123,6 +1123,26 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
> 	return -ENFILE;
> }
> 
>+static int dev_prep_valid_name(struct net *net, struct net_device *dev,
>+			       const char *want_name, char *out_name)
>+{
>+	int ret;
>+
>+	if (!dev_valid_name(want_name))
>+		return -EINVAL;
>+
>+	if (strchr(want_name, '%')) {
>+		ret = __dev_alloc_name(net, want_name, out_name);
>+		return ret < 0 ? ret : 0;
>+	} else if (netdev_name_in_use(net, want_name)) {
>+		return -EEXIST;
>+	} else if (out_name != want_name) {

How this can happen?
You call dev_prep_valid_name() twice:
	ret = dev_prep_valid_name(net, dev, name, buf);
	err = dev_prep_valid_name(net, dev, pat, new_name);

Both buf and new_name are on stack tmp variables.


>+		strscpy(out_name, want_name, IFNAMSIZ);

You don't need the strscpy here, callers do that.


>+	}
>+
>+	return 0;
>+}
>+
> static int dev_alloc_name_ns(struct net *net,
> 			     struct net_device *dev,
> 			     const char *name)
>@@ -1160,19 +1180,13 @@ EXPORT_SYMBOL(dev_alloc_name);
> static int dev_get_valid_name(struct net *net, struct net_device *dev,
> 			      const char *name)
> {
>-	BUG_ON(!net);
>+	char buf[IFNAMSIZ];
>+	int ret;
> 
>-	if (!dev_valid_name(name))
>-		return -EINVAL;
>-
>-	if (strchr(name, '%'))
>-		return dev_alloc_name_ns(net, dev, name);
>-	else if (netdev_name_in_use(net, name))
>-		return -EEXIST;
>-	else if (dev->name != name)
>-		strscpy(dev->name, name, IFNAMSIZ);
>-
>-	return 0;
>+	ret = dev_prep_valid_name(net, dev, name, buf);
>+	if (ret >= 0)

How ret could be bigger than 0?


>+		strscpy(dev->name, buf, IFNAMSIZ);
>+	return ret;
> }
> 
> /**
>@@ -11038,6 +11052,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
> 			       const char *pat, int new_ifindex)
> {
> 	struct net *net_old = dev_net(dev);
>+	char new_name[IFNAMSIZ] = {};
> 	int err, new_nsid;
> 
> 	ASSERT_RTNL();
>@@ -11064,7 +11079,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
> 		/* We get here if we can't use the current device name */
> 		if (!pat)
> 			goto out;
>-		err = dev_get_valid_name(net, dev, pat);
>+		err = dev_prep_valid_name(net, dev, pat, new_name);
> 		if (err < 0)
> 			goto out;
> 	}
>@@ -11135,6 +11150,9 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
> 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
> 	netdev_adjacent_add_links(dev);
> 
>+	if (new_name[0]) /* Rename the netdev to prepared name */

strlen() would probably read a bit nicer?


>+		strscpy(dev->name, new_name, IFNAMSIZ);
>+
> 	/* Fixup kobjects */
> 	err = device_rename(&dev->dev, dev->name);
> 	WARN_ON(err);
>-- 
>2.41.0
>

