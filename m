Return-Path: <netdev+bounces-14219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7584C73F9BA
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5A6281033
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F67174C5;
	Tue, 27 Jun 2023 10:12:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEC171CF
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:12:16 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E48F
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 03:12:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313f04ff978so2021154f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687860732; x=1690452732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YL2QQUhpqE9xA9J15CwAM3uwbflJFyWhdgrXyOa8TF8=;
        b=yHzIRhhMMndSefK4R5L6JAxM0Lcy/WZBA/wKRFn9S1L2E4GUGHlpx8UT87zIW+HY1R
         LvqjTa2dxgl/q8P2qIcG3scmQuMXFPR6TAQ2hKynx2NHZ/aFqrQBWasEQZLN1qrvMFos
         XWoFt9bZ0v8EFLROymmyFC6itXyq+hOgl6qLWrwFubIgv3PsIQMeF8Plk0jVnVQhKlhi
         Z5MJFDMAlMukebJVYjBJJvrCTUFZi8U67yPmA57KyT57Udx+rM+wzSzASmJfauEPvJ96
         nxe+1gz0luz47Bra26yUf/MW92N9oulaz7MYJ8JrR9jGJo3J06rOPDorLyagvGrRzeNZ
         oRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687860732; x=1690452732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YL2QQUhpqE9xA9J15CwAM3uwbflJFyWhdgrXyOa8TF8=;
        b=RpBfVFFDJ0wd450N06Po3kmZ76VhglhC+tmqN1LESsFau0Au2RZtI9gBTTrdWBtQt+
         9F+jNYJSUvr2xURn5ZSOJTaF557KMWvplnKir9lX9LE8AVsepr5gNQNov6jUsxG7qkcA
         GkfsI7DRivVmfa+2QveJy9lsi98xueVNrO6MDRhX7F/2/zx8GdAIP+zDWeT9Tj3YccTd
         3FGGujovbxByfzke0kD+i1T7YCxpwez2/Va7DL5VzdbyEAweztwEf5Wp2Rc6N8QmpUrk
         ng5taDdZ0dITaevzv8Y7K4FjJTtlV0PTtAXWBA4czbb6OhDu4qxxD2yH6iEK0jAnve2C
         kRrA==
X-Gm-Message-State: AC+VfDxug9IHQKLFx2owKvhPhv2WOs44tAwHko/k7F/0TrsXPopJHg/l
	YELlOkjgSlcGVSgO8KyuQcnbeQ==
X-Google-Smtp-Source: ACHHUZ4dtpQnP56zKIswwusuY/no3dKswn8NHgv+eEOE1NJvI8wDtEMVaAb0en4PcSRIRMxgGgltDg==
X-Received: by 2002:a5d:538b:0:b0:30f:c42e:3299 with SMTP id d11-20020a5d538b000000b0030fc42e3299mr22115787wrv.60.1687860732304;
        Tue, 27 Jun 2023 03:12:12 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d58ee000000b00313f1c5b56dsm5275675wrd.79.2023.06.27.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 03:12:11 -0700 (PDT)
Date: Tue, 27 Jun 2023 12:12:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <ZJq1+ok+WkwePYaq@nanopsycho>
References: <20230615093701.20d0ad1b@kernel.org>
 <ZItMUwiRD8mAmEz1@nanopsycho>
 <20230615123325.421ec9aa@kernel.org>
 <ZJL3u/6Pg7R2Qy94@nanopsycho>
 <ZJPsTVKUj/hCUozU@nanopsycho>
 <20230622093523.18993f44@kernel.org>
 <ZJVlbmR9bJknznPM@nanopsycho>
 <20230623082108.7a4973cc@kernel.org>
 <ZJa4YPtXaLOJigVM@nanopsycho>
 <20230624134703.10ec915f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624134703.10ec915f@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sat, Jun 24, 2023 at 10:47:03PM CEST, kuba@kernel.org wrote:
>On Sat, 24 Jun 2023 11:33:20 +0200 Jiri Pirko wrote:
>> >of the SF after all, right? Probably best to find another way...  
>> 
>> Well, yeah. The mac/hw_addr is quite convenient. It's there and
>> I believe that any device could work with that. Having some kind of
>> "extra cookie" would require to implement that in FW, which makes things
>> more complicated.
>
>"Let's piggyback on something else in the uAPI because I don't want 
>to extend FW" is not an argument which can be taken seriously.

It's not about what I want or not. It's about what can realistically
happen (not talking about mlx5 specifically).

But what is a difference between using hw_addr and some other uuid.
cmdline wise:

option 1 - JUST HW_ADDR:

$ sudo devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 103
pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 0 pfnum 0 sfnum 103 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached

$ sudo devlink port function set pci/0000:08:00.0/32770 hw_addr AA:22:33:44:55:66

$ sudo devlink port show pci/0000:08:00.0/32770
pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 0 pfnum 0 sfnum 103 splittable false
  function:
    hw_addr aa:22:33:44:55:66 state inactive opstate detached

$ sudo devlink port function set pci/0000:08:00.0/32770 state active
pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 0 pfnum 0 sfnum 103 splittable false
  function:
    hw_addr aa:22:33:44:55:66 state active opstate detached devlink_handle auxiliary/mlx5_core.eth.5
# This is new, currently activation does not give feedback,
# devlink_handle attr is new here

$ sudo devlink port show pci/0000:08:00.0/32770
pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 0 pfnum 0 sfnum 103 splittable false
  function:
    hw_addr aa:22:33:44:55:66 state active opstate attached devlink_handle auxiliary/mlx5_core.eth.5
# devlink_handle attr is new here

$ sudo devlink dev show auxiliary/mlx5_core.eth.5
auxiliary/mlx5_core.eth.5: hw_addr aa:22:33:44:55:66
# hw_addr attr is new here

hw_addr value is passed through FW here. This value is currently used
for netdevice mac. So it is just a matter of exposing for auxdev
devlink/devlink_port (not 100% sure which)


option 2 - ADDED UUID:

$ sudo devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 103
pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 0 pfnum 0 sfnum 103 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached

$ sudo devlink port function set pci/0000:08:00.0/32770 hw_addr AA:22:33:44:55:66 uuid SOMETHINGREALLYUNIQUE

$ sudo devlink port show pci/0000:08:00.0/32770
pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 0 pfnum 0 sfnum 103 splittable false
  function:
    hw_addr aa:22:33:44:55:66 uuid SOMETHINGREALLYUNIQUE state inactive opstate detached
# uuid attr is new here

$ sudo devlink port function set pci/0000:08:00.0/32770 state active
pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 0 pfnum 0 sfnum 103 splittable false
  function:
    hw_addr aa:22:33:44:55:66 uuid SOMETHINGREALLYUNIQUE state active opstate detached devlink_handle auxiliary/mlx5_core.eth.5
# This is new, currently activation does not give feedback,
# devlink_handle attr is new here, uuid attr is new here

$ sudo devlink port show pci/0000:08:00.0/32770
pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 0 pfnum 0 sfnum 103 splittable false
  function:
    hw_addr aa:22:33:44:55:66 uuid SOMETHINGREALLYUNIQUE state active opstate attached devlink_handle auxiliary/mlx5_core.eth.5
# devlink_handle attr is new here, uuid attr is new here

$ sudo devlink dev show auxiliary/mlx5_core.eth.5
auxiliary/mlx5_core.eth.5: uuid SOMETHINGREALLYUNIQUE
# uuid attr is new here

uuid value is passed through FW here.


The uuid kind of values is nothing new in netdev. We have:
IFLA_PHYS_PORT_ID
IFLA_PHYS_SWITCH_ID
In most of the cases (if not all), these are in drivers filled-up with
MAC. So I'm quite positive that the drivers would implement the auxdev
uuid as a MAC as well.

Do you like option 2 better than option 1? Is there option 3?

Thanks!


