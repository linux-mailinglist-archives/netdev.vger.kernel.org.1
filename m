Return-Path: <netdev+bounces-13309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA0B73B381
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136F92819EE
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF853D70;
	Fri, 23 Jun 2023 09:27:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D39B3D6E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:27:17 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD0E1FF7
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:27:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30fcda210cfso433451f8f.3
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687512432; x=1690104432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz+koRVLaM+wLBuWj88aZ6U5IT0wslOoiijOidrLc+A=;
        b=pf2yPjgNm/ewuj/2unXpTZPj8QlCNFl3XL5MAgc1f4+LkLmdI5PCf6AwrF/AzfLLdl
         mDC/XTopMPQtySvHDy5PHfZGUgCB0RDAkT+Fq3pK2VRMxFigUd0DwE9DJmGSfINAmLpg
         AWDDpESD7aUp9WV5HBBHC64EQLRfCA+t/1qya93LC66F3s3kQ1R6S7lgXz7TXDqwnqvv
         CkejPX7AsgBpeOWq0ybLOGzFGh0v49qm4V+x41Z5sOQuFzQ8TQ/p0MUKJTGSMDDy9CS+
         AXngqfGtXco7F0lk9buEKe2eFQ3uYc3DP7sEXAcvutNhX/AsusWEZpjL8W7MG2ll+NQb
         y+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687512432; x=1690104432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz+koRVLaM+wLBuWj88aZ6U5IT0wslOoiijOidrLc+A=;
        b=FWjtpZGiixFjjaCHAEWonaMOpyDUmRzNPmsFfQSk3YKESqLo5SBVeD1IvK0PX+j9fZ
         3Clds+ETwcBWtwhiyWeYem6WwUvkk0+2GEPZFhVfmIOZnVLxkqTEM/b5LL9XPazbBFPa
         nyiHPfzakMs0VbmpM5ie22mGAWInyjIaGxW8xjM0LUFXT95y/gHH6J5+nHqR/AJwCXdE
         t2Sn8A9Ubd/adgJ7+/CzOaIqy+ue8H3TRg8F3U6skXGYgNaY5yPhHWVO+zPo3rFJYYrj
         QarzoJQQX+anKvsFy4wgjGivguNgOnMlLtiJFTQQAQcnqbfrDOfJeTKDBjyRz+XDId8k
         knEA==
X-Gm-Message-State: AC+VfDw5p+F7bQ84GGVxHzuO67YjqvjiJTKg0VprylemGlbrWJM3V9VP
	lZpDVOlhgQLnROP7muaUMoBZ8A==
X-Google-Smtp-Source: ACHHUZ7yjSFL2PE69H/jIlY4NZ8+7AgDmIyzQU9UY0iyCwQ6xiZLdyA6kySzrRIMAcDcTaEmC7Uj2Q==
X-Received: by 2002:a5d:4a45:0:b0:30f:b1ea:408 with SMTP id v5-20020a5d4a45000000b0030fb1ea0408mr3573537wrs.52.1687512432487;
        Fri, 23 Jun 2023 02:27:12 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x5-20020adff645000000b0031276f8be22sm9025218wrp.97.2023.06.23.02.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:27:11 -0700 (PDT)
Date: Fri, 23 Jun 2023 11:27:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <ZJVlbmR9bJknznPM@nanopsycho>
References: <20230612105124.44c95b7c@kernel.org>
 <ZIj8d8UhsZI2BPpR@x130>
 <20230613190552.4e0cdbbf@kernel.org>
 <ZIrtHZ2wrb3ZdZcB@nanopsycho>
 <20230615093701.20d0ad1b@kernel.org>
 <ZItMUwiRD8mAmEz1@nanopsycho>
 <20230615123325.421ec9aa@kernel.org>
 <ZJL3u/6Pg7R2Qy94@nanopsycho>
 <ZJPsTVKUj/hCUozU@nanopsycho>
 <20230622093523.18993f44@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622093523.18993f44@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 22, 2023 at 06:35:23PM CEST, kuba@kernel.org wrote:
>On Thu, 22 Jun 2023 08:38:05 +0200 Jiri Pirko wrote:
>> I checked, the misalignment between sfnum and auxdev index.
>> The problem is that the index space of sfnum is per-devlink instance,
>> however the index space of auxdev is per module name.
>> So if you have one devlink instance managing eswitch, in theory we can
>> map sfnum to auxdev id 1:1. But if you plug-in another physical nic,
>> second devlink instance managing eswitch appears, then we have an
>> overlap. I don't see any way out of this, do you?
>> 
>> But, I believe if we add a proper reference between devlink sf port and
>> the actual sf devlink instace, that would be enough.
>
>SG. For the IPU case when spawning from within the IPU can we still
>figure out what the auxdev id is going to be? If not maybe we should

Yeah, the driver is assigning the auxdev id. I'm now trying to figure
out how to pass that to devlink code/user nicely. The devlink instance
for the SF does not exist yet, but we know what the handle is going to
be. Perhaps some sort of place holder instance would do. IDK.


>add some form of UUID on both the port and the sf devlink instance?

What about the MAC?

$ sudo devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 102
pci/0000:08:00.0/32769: type eth netdev eth8 flavour pcisf controller 0 pfnum 0 sfnum 102 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached
$ sudo devlink port function set pci/0000:08:00.0/32769 hw_addr AA:22:33:44:55:66
$ sudo devlink port function set pci/0000:08:00.0/32769 state active
$ ip link show eth9
15: eth9: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether aa:22:33:44:55:66 brd ff:ff:ff:ff:ff:ff

There are 2 issues with this:
1) If the hw_addr stays zeroed for activation, random MAC is generated
2) On the SF side, the MAC is only seen for netdev. That is problematic
   for SFs without netdev. However, I don't see why we cannot add
   devlink port attr to expose hw_addr on the SF.


>Maybe there's already some UUID in the vfio world we can co-opt?

Let me check that out.

