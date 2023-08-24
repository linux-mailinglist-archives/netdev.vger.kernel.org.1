Return-Path: <netdev+bounces-30253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDA78699D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704491C20DDD
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFAF5696;
	Thu, 24 Aug 2023 08:10:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07252455E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:10:11 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748E41BD5
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:09:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40078c4855fso10897935e9.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692864544; x=1693469344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOoRVdRM/Q9tMhCNdS4M5xTmqEs260amH9lg6cGcCJw=;
        b=YHHk0yFRDlslFRuTQiwcxVePLDYBzWXiTxVlB3Fekxk/AWPyTAPSPd9WdXx03QNcVn
         CKDTCDMJZWXyfoCyJ8S20OhiDDNMTU0PejkYgW3KtfEqJnDwiHnlF1n67yEYiWUs3HKP
         SK0UStzxMFSipk7haD2YtqKvFdbsg/Nonli+WiL2ivpkxCZTy4xZpp+UPbzQJ141D5VK
         Q6dlnmEW7unTLHiVhvwMuchouq6OhkusdvMZGvJ5KJmR/8FtQB6F4hNWVu4cm8k0LEaO
         t3/3twD1zhOUDu5JS2MKnMGa33jttATaDhdS/y6aHLtt1yZsewBKVjWqNGIN4Sz77iJg
         sSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692864544; x=1693469344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOoRVdRM/Q9tMhCNdS4M5xTmqEs260amH9lg6cGcCJw=;
        b=X2J3qgx8tpXaN4oKlpmTMXZyg0GR4RfG3h7NRc2C6vlbcaBVCJ4MY4bA/evKrlnjVZ
         9rZxTW7UGnghS85b/SUTXYp0dXWXS0RoPrDXHn0yVAE67oYUzGTsCWQq624pL8vP+JAT
         lePIamsOn14AuNG4x6HHsAu00In0XO+BtMUYgObAczRcLtB+HEa/GzXppBDzX6gsxTEn
         4Wz+JLKpB4TRAmwbsKbFlUgmDQGnQ+XvVtHqtsFjz6w66Pyewh5Xf/tk2ANAje3ZEgPX
         og5/IK457IrOVP+CcifGPrnCLgOGzzJDKDZbPQ+p6to/7zhU1RFqTwlONX2q6cXkcXYV
         AZEg==
X-Gm-Message-State: AOJu0Ywhd+hqfr9KoBVErxJ6fDYFpFp1E5RTRKG+vri9u/IXthBc47l9
	5jNSWNeRnjnWOxeCJM97843/G9aTsM2afaKVcqc1gw==
X-Google-Smtp-Source: AGHT+IE70PjcuIVVnONA1P+T+aLarLCse3QG37svKtGHOJRuzkIbb6QHO0QZg/VEq2xpfo9CrWElAg==
X-Received: by 2002:a7b:cbcb:0:b0:3fe:34c2:654b with SMTP id n11-20020a7bcbcb000000b003fe34c2654bmr11548157wmi.14.1692864543695;
        Thu, 24 Aug 2023 01:09:03 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id y26-20020a7bcd9a000000b003fed7fa6c00sm1890003wmj.7.2023.08.24.01.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 01:09:02 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:09:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next] devlink: add missing unregister linecard
 notification
Message-ID: <ZOcQHYAcUwd+VguS@nanopsycho>
References: <20230817125240.2144794-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817125240.2144794-1-jiri@resnulli.us>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kuba, do you plan to merge net into net-next any time soon? I have
another patchset depending on this.

Btw, I aimed this to net-next on purpose, in net it does not make much
sense imho.

Thanks!

Thu, Aug 17, 2023 at 02:52:40PM CEST, jiri@resnulli.us wrote:
>From: Jiri Pirko <jiri@nvidia.com>
>
>Cited fixes commit introduced linecard notifications for register,
>however it didn't add them for unregister. Fix that by adding them.
>
>Fixes: c246f9b5fd61 ("devlink: add support to create line card and expose to user")
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
> net/devlink/leftover.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
>index c26c63275b0b..e7f76cc58533 100644
>--- a/net/devlink/leftover.c
>+++ b/net/devlink/leftover.c
>@@ -6630,6 +6630,7 @@ void devlink_notify_unregister(struct devlink *devlink)
> 	struct devlink_param_item *param_item;
> 	struct devlink_trap_item *trap_item;
> 	struct devlink_port *devlink_port;
>+	struct devlink_linecard *linecard;
> 	struct devlink_rate *rate_node;
> 	struct devlink_region *region;
> 	unsigned long port_index;
>@@ -6658,6 +6659,8 @@ void devlink_notify_unregister(struct devlink *devlink)
> 
> 	xa_for_each(&devlink->ports, port_index, devlink_port)
> 		devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
>+	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
>+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
> 	devlink_notify(devlink, DEVLINK_CMD_DEL);
> }
> 
>-- 
>2.41.0
>

