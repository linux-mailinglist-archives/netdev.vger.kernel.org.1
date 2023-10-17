Return-Path: <netdev+bounces-41885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F37CC183
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E38281AB8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464E41A83;
	Tue, 17 Oct 2023 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BcloNKLW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C594538FA7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:07:00 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BCDF0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:06:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so9376570a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697540816; x=1698145616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJC4nFF3vhCV0/q49aZ8HDwgeodSnFveb4bvsgI4wfo=;
        b=BcloNKLWZcnf1n9iQN2f9fxQZkSgqF1QxsawOKBB/3pM8XgUS2d7tM++jLQAQK0hxv
         kt9r7XqUndatyhcndjGsVDLoMWproTXUeUpppgyQkeaoeSMqmuY7JBj5lPzB1gmEemvk
         JPrQl8FQ942tE8dwg/NxmhqzGzQySsoHdV4Md5vXQOBTKUBg7nwV/L4hzLUgg00UzQEP
         mzZD6Z8aFXvJ3TdPCTPS/UangRy1IDaousuorNZ8vMUdg/iAOTlpdKcHxHr52Yh3jBDc
         F7pq4ay3qP7wVrM9yhnyZAMqgz/KkFYbeoSlFY0XXqvFsc+bHOgMykjzUs5yYtwTeUEE
         dD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697540816; x=1698145616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJC4nFF3vhCV0/q49aZ8HDwgeodSnFveb4bvsgI4wfo=;
        b=fePXL/uTfSC6bleqmdCga4ruBOaXXvcUS7t/XM56FUexGCQnWKOrqpW7J2nAEkBzAt
         ABlxa7wrrqBcVRnt4cA3Ey/462C++DxPNHe8lZVFFUNp4LtcYhwYXSosZYLKu0cvoxbb
         +5KgkDUsx8cWk5DJxaZW8P5rgCN1n2kKoKGrPE+iqUyYSo0ROmFxwdFLpeGI9sWrt2kJ
         pPX7gAhRkOITyoX/t3sVg4xjpKeAkzxTfZqm+xkxSIu2XrixOef1MgUXdetl3WHjSvh8
         zZOVv4flbcSgRVKtiXCGOMDiTvC0ztyS38oLY0s6XNa4SRxAMbGtXgpj3YAekjLOxaLn
         PM1w==
X-Gm-Message-State: AOJu0Yy9Jl0c11tz3nNStZX/BuZgWtROluoVfMtyDllruQWQYP75W1sg
	/msFYwOn31QVJXNskHu+G/EHQLZK4ncbv8kcOLs=
X-Google-Smtp-Source: AGHT+IE3+dy9KxR0DMNpJylit/JSLtOQD8wGBT8WZyvnAV56LixZhR/0fOdKoFLIRDgxKatONZOONA==
X-Received: by 2002:a50:ab55:0:b0:52e:1d58:a6ff with SMTP id t21-20020a50ab55000000b0052e1d58a6ffmr1212905edc.35.1697540815909;
        Tue, 17 Oct 2023 04:06:55 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v15-20020a50954f000000b0053120f313cbsm1043876eda.39.2023.10.17.04.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:06:55 -0700 (PDT)
Date: Tue, 17 Oct 2023 13:06:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Coiby Xu <coiby.xu@gmail.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net-next v2 03/11] pds_core: devlink health: use retained
 error fmsg API
Message-ID: <ZS5qztBDc3ebxypI@nanopsycho>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-4-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105341.415466-4-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 17, 2023 at 12:53:33PM CEST, przemyslaw.kitszel@intel.com wrote:
>Drop unneeded error checking.
>
>devlink_fmsg_*() family of functions is now retaining errors,
>so there is no need to check for them after each call.
>
>Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
>add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-57 (-57)
>---
> drivers/net/ethernet/amd/pds_core/devlink.c | 29 ++++++---------------
> 1 file changed, 8 insertions(+), 21 deletions(-)
>
>diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
>index d9607033bbf2..8b2b9e0d59f3 100644
>--- a/drivers/net/ethernet/amd/pds_core/devlink.c
>+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
>@@ -154,33 +154,20 @@ int pdsc_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
> 			      struct netlink_ext_ack *extack)
> {
> 	struct pdsc *pdsc = devlink_health_reporter_priv(reporter);
>-	int err;
> 
> 	mutex_lock(&pdsc->config_lock);
>-
> 	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
>-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
>+		devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
> 	else if (!pdsc_is_fw_good(pdsc))
>-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
>+		devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
> 	else
>-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
>-
>+		devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
> 	mutex_unlock(&pdsc->config_lock);
> 
>-	if (err)
>-		return err;
>-
>-	err = devlink_fmsg_u32_pair_put(fmsg, "State",
>-					pdsc->fw_status &
>-						~PDS_CORE_FW_STS_F_GENERATION);
>-	if (err)
>-		return err;
>-
>-	err = devlink_fmsg_u32_pair_put(fmsg, "Generation",
>-					pdsc->fw_generation >> 4);
>-	if (err)
>-		return err;
>+	devlink_fmsg_u32_pair_put(fmsg, "State",
>+				  pdsc->fw_status & ~PDS_CORE_FW_STS_F_GENERATION);
>+	devlink_fmsg_u32_pair_put(fmsg, "Generation", pdsc->fw_generation >> 4);
>+	devlink_fmsg_u32_pair_put(fmsg, "Recoveries", pdsc->fw_recoveries);
> 
>-	return devlink_fmsg_u32_pair_put(fmsg, "Recoveries",
>-					 pdsc->fw_recoveries);
>+	return 0;

Could you please covert the function to return void? Please make sure
to do this in the rest of the patchset as well.

Thanks!

pw-bot: cr


> }
>-- 
>2.40.1
>

