Return-Path: <netdev+bounces-41742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF597CBCD0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A13BB20FD7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2306F341B4;
	Tue, 17 Oct 2023 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="l4mq+guK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C515AF6
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:51:42 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B361ED
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:51:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so9338567a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697529099; x=1698133899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGbKB+flKfQvR3BIytAtxhvo0o0w+Aq3uMDs7t9/RSA=;
        b=l4mq+guKKezoF8fWH7bAs522mPVzL/QkXfPUOc1RV+t2zSXcTvZtFh6hkPTDBkyZzH
         oTmID072XEbIbxC80mJRkq9zp/DufNp8XO53ZvM1xxtAH89YaC2lLyQ5d1XiosR303Qh
         Y1IpA4ekmPKoWPLjLD7zns76S39bA7hzGZpjaHMNOzS99hp5rtjIeNcz9ERKHGORLRDa
         jqVZl4/FfMtgjdUECZm9ukKQGqLkYZExiUre/LBwYd+/Oj++DxZpYfCiO1LPqJuHFf31
         8I7tCApW5cN+nvxHA/W8I8+MEflXrX3r9hpAr2o3MQh9akhu7Ne3V+/PmrSVMgtr6kJo
         KwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529099; x=1698133899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGbKB+flKfQvR3BIytAtxhvo0o0w+Aq3uMDs7t9/RSA=;
        b=kVP6eJ3xebcZM5XvgFVM8t31Tt+nWoc8zDndFclW+EXP6IahQrEiAZTf7478uMy8yE
         9U/MT0LIrdUSrE+x5dNMx8tgKzoIAm617+PGqdk+nUUAhJbINoTtryjHjZjGCn1BhV/s
         DM1EQcocZESntZMDurWeZR6Ua2mx4zXLEOSCxQPk6RCTsZqmkGeXYFc7A+MjZ/9XHW2I
         m4CPzmHgA44qpUa5x02JR2scGamRl/6AH63wTOkBAT1F62Q/vT+Q1ej/0p+RNHsy+/Tv
         rQEkS4E4JKp5hPx+ukearaPxQxIcGT5o8Q8OQ3rH9ylq7y9JdNGvQ5rj7jnX12XyLykC
         DV6w==
X-Gm-Message-State: AOJu0YwP4yfI8Xq0UjRKohZcbG8iLoJcDK0ouVfQqME8mmgEW2JMoQD/
	QF5t1Fp6MvJ5VnKLq98kDSSeFQ==
X-Google-Smtp-Source: AGHT+IFoWzg5Dhcda/++S65LAPkIFh5YlyQ1IuzkXdFGXQPclRwbBg95Q1lr11EubLz0fDu/rJ2a2A==
X-Received: by 2002:a50:871b:0:b0:53d:b1ca:293c with SMTP id i27-20020a50871b000000b0053db1ca293cmr1125093edb.22.1697529099608;
        Tue, 17 Oct 2023 00:51:39 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id co25-20020a0564020c1900b0053e36dd75dfsm705978edb.35.2023.10.17.00.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:51:39 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:51:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net 4/5] net: move altnames together with the netdevice
Message-ID: <ZS49CjLECQHdcQwv@nanopsycho>
References: <20231016201657.1754763-1-kuba@kernel.org>
 <20231016201657.1754763-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016201657.1754763-5-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Oct 16, 2023 at 10:16:56PM CEST, kuba@kernel.org wrote:
>The altname nodes are currently not moved to the new netns
>when netdevice itself moves:
>
>  [ ~]# ip netns add test
>  [ ~]# ip -netns test link add name eth0 type dummy
>  [ ~]# ip -netns test link property add dev eth0 altname some-name
>  [ ~]# ip -netns test link show dev some-name
>  2: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>      link/ether 1e:67:ed:19:3d:24 brd ff:ff:ff:ff:ff:ff
>      altname some-name
>  [ ~]# ip -netns test link set dev eth0 netns 1
>  [ ~]# ip link
>  ...
>  3: eth0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>      link/ether 02:40:88:62:ec:b8 brd ff:ff:ff:ff:ff:ff
>      altname some-name
>  [ ~]# ip li show dev some-name
>  Device "some-name" does not exist.
>
>Remove them from the hash table when device is unlisted
>and add back when listed again.
>
>Fixes: 36fbf1e52bd3 ("net: rtnetlink: add linkprop commands to add and delete alternative ifnames")
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Nice, thanks!

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

