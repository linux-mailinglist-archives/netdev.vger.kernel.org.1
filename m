Return-Path: <netdev+bounces-38217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFA17B9C99
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 12:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1AE95281AF6
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DFF12B68;
	Thu,  5 Oct 2023 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW/X1y63"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697A01C3D
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 10:49:18 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AF22CA8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 03:49:16 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-664bd97692dso4683356d6.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696502956; x=1697107756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxsBuH4sqYmmyfcUGEapzWF8Tbcbm5u4qp8OCjdRNYc=;
        b=DW/X1y63HeY5UnMUeAms2JxawdHkSWervwqXyKeFl/jvOt0m4sCtTMArIhqDzvTU7h
         B5bXpeqLAhZL75KkxsN8xlFNkrySiWecHhOhkO6NpYwkR6ztxfJrzuKco6vTKY0ETUej
         3OJVdYb/OZROLTSEzB6dAdZa+GmWuPRWJwx/q886cSkYUquo00/qf01ne+JCrbCufq0+
         YRL9S5VWCAV7PH4+GLWRUrGnXiWY3Yk6v9PQjqhKql7rdDMfMTMyV5yTU5cGHkgyHZMk
         Z69EcUn45cAfI2nEJQWkUpw+KwsQV1YzKDpfhcUdjyGAqtZSsf9LcvkoG2kVYcp+UIKo
         wMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502956; x=1697107756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxsBuH4sqYmmyfcUGEapzWF8Tbcbm5u4qp8OCjdRNYc=;
        b=UE+aOe8rn6Suj6RMRsKcVszPn8bSpohVLeBvmgzrdjKFi+YMdK32hXLFe/rcSc3qAW
         itmpHxF6Io29hOsf1uw4tHejjp1G/g8P9x/z9oGPx/slYJcHQgz7GCBkFsyt0Cy7NQq6
         gufy6fmoNN4Tg0kE7ICFSew68ylcpZlI73WL5fKAlclkFh14Auheo/2Ch2TJfIyPjS28
         60jgSg1VbROgeHUcNmu3VE6JB9ziWxXR5exaPKuDife8zfeuuZcNYYrWjP+V5HvTrNnX
         q5Y36jTbIJE0WQCwo3OPjW+2ZkgbuXhupWXln8GfbPZfbpSqQpGO+tyBgV+SheNYLBNU
         46HA==
X-Gm-Message-State: AOJu0YySvZfjCVwJFhrnjlaSdAf1y/pbauCmltvXs63V5z+l15MibZWN
	rL2eiErVgaWgHeDMsztWRvM=
X-Google-Smtp-Source: AGHT+IEqrKzaZJppgDcF6e+slsCKDD1nb+siMxz9VWe9KDnKZRbc/4M5jORCygOqUTA6B7d4jW1voQ==
X-Received: by 2002:a0c:aaca:0:b0:647:2f9f:59f3 with SMTP id g10-20020a0caaca000000b006472f9f59f3mr4060566qvb.65.1696502955598;
        Thu, 05 Oct 2023 03:49:15 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a0cac44000000b00647386a3234sm403694qvb.85.2023.10.05.03.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:49:15 -0700 (PDT)
Message-ID: <651e94ab.0c0a0220.2c147.1299@mx.google.com>
X-Google-Original-Message-ID: <ZR6UqcLgiYXebmKS@Ansuel-xps.>
Date: Thu, 5 Oct 2023 12:49:13 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: dsa: qca8k: fix potential MDIO bus
 conflict when accessing internal PHYs via management frames
References: <20231004091904.16586-1-kabel@kernel.org>
 <20231004091904.16586-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004091904.16586-3-kabel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 11:19:04AM +0200, Marek Behún wrote:
> Besides the QCA8337 switch the Turris 1.x device has on it's MDIO bus
> also Micron ethernet PHY (dedicated to the WAN port).
> 
> We've been experiencing a strange behavior of the WAN ethernet
> interface, wherein the WAN PHY started timing out the MDIO accesses, for
> example when the interface was brought down and then back up.
> 
> Bisecting led to commit 2cd548566384 ("net: dsa: qca8k: add support for
> phy read/write with mgmt Ethernet"), which added support to access the
> QCA8337 switch's internal PHYs via management ethernet frames.
> 
> Connecting the MDIO bus pins onto an oscilloscope, I was able to see
> that the MDIO bus was active whenever a request to read/write an
> internal PHY register was done via an management ethernet frame.
> 
> My theory is that when the switch core always communicates with the
> internal PHYs via the MDIO bus, even when externally we request the
> access via ethernet. This MDIO bus is the same one via which the switch
> and internal PHYs are accessible to the board, and the board may have
> other devices connected on this bus. An ASCII illustration may give more
> insight:
> 
>            +---------+
>       +----|         |
>       |    | WAN PHY |
>       | +--|         |
>       | |  +---------+
>       | |
>       | |  +----------------------------------+
>       | |  | QCA8337                          |
> MDC   | |  |                        +-------+ |
> ------o-+--|--------o------------o--|       | |
> MDIO    |  |        |            |  | PHY 1 |-|--to RJ45
> --------o--|---o----+---------o--+--|       | |
>            |   |    |         |  |  +-------+ |
> 	   | +-------------+  |  o--|       | |
> 	   | | MDIO MDC    |  |  |  | PHY 2 |-|--to RJ45
> eth1	   | |             |  o--+--|       | |
> -----------|-|port0        |  |  |  +-------+ |
>            | |             |  |  o--|       | |
> 	   | | switch core |  |  |  | PHY 3 |-|--to RJ45
>            | +-------------+  o--+--|       | |
> 	   |                  |  |  +-------+ |
> 	   |                  |  o--|  ...  | |
> 	   +----------------------------------+
> 
> When we send a request to read an internal PHY register via an ethernet
> management frame via eth1, the switch core receives the ethernet frame
> on port 0 and then communicates with the internal PHY via MDIO. At this
> time, other potential devices, such as the WAN PHY on Turris 1.x, cannot
> use the MDIO bus, since it may cause a bus conflict.
> 
> Fix this issue by locking the MDIO bus even when we are accessing the
> PHY registers via ethernet management frames.
> 
> Fixes: 2cd548566384 ("net: dsa: qca8k: add support for phy read/write with mgmt Ethernet")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel

