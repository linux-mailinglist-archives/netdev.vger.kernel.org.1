Return-Path: <netdev+bounces-41886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A128C7CC1A1
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CFA1C20931
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B942C41A91;
	Tue, 17 Oct 2023 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jtiC2PFZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23090BE69
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:16:03 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6158F2
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:16:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so9390083a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697541359; x=1698146159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKh8Rphk+/QSFMLZeP3WthmhQMsK2wQ8t/XPNfZzXF0=;
        b=jtiC2PFZ/ctlViRmzDIeYttICdRNZsk6xOq4Mo16v3piTbASgDoP93mslyXk1LRZn2
         C+zzqDx6GYOgaumnnVu9XmiwrGjwDJJp7Ql6O4yImgtPSNIMbSCIWL3bbaHSMvbT90Tm
         Zs5Ps1cgYj3mEG0v7KLpDPfcTYVFD+FfRx8zNRzj6VCmOz2ii6IIke2E8QkJLCP3npJz
         ZNPE0005kvMvQtkSqO7q14tBDlEktgdcUsIoh/seCIaYrtrfIlhwZiiLQWsoKnx6qvA1
         ywY+XsW1RLGb9ii04rtB/pyi5s/Huuj49RWshfwZpGE6dPUxIwYsx/YnWzH4igdA0QpR
         7ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697541359; x=1698146159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKh8Rphk+/QSFMLZeP3WthmhQMsK2wQ8t/XPNfZzXF0=;
        b=Vop8oOyen4NBReJAbC/tIBmJoRwh7NSRsx9rvxMCpItrzGFjdL9s3E3qPo1Kw2M0rX
         r31GWkZBAih1kWGPGZw0kD5TboBV95kg3GN+s9oySQPMhMYrZaspFjTz9ytvsvH0MffR
         4HuwxYgBp2fbjS51kHARkFzHTjyS0Oh4zV7CW/qvxWdq9/hMvk8CcForrYMoYDTh/NXO
         /UFD5DFS8+XtAObwITxsILSorHyvslkKd+rRuPbiIzEFyGu+1G8Vc6GXyzREE1JnHLUN
         8SL/l/nsmhBk0B8YR/GifinTNseYwj5892HZDjkEjsh9ucV73NvpsEDFvW7z1y0H7Ps5
         5lQw==
X-Gm-Message-State: AOJu0Yw06SAiN+5khLczF//vspeId9jtKtbF837GDW2WuFpPzfDxjpQg
	nX7U7JfLmNAblEYtoZV0oHmFew==
X-Google-Smtp-Source: AGHT+IGdLLMfzeGUUoZpp3W//fLDT9ZgDB2F7ofod39QUKUD4n0ocXqUTpi4CI3YiG1K1NX3Yqyy6Q==
X-Received: by 2002:aa7:d1c7:0:b0:53e:1815:ed0f with SMTP id g7-20020aa7d1c7000000b0053e1815ed0fmr1287255edp.31.1697541359166;
        Tue, 17 Oct 2023 04:15:59 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k21-20020aa7d8d5000000b0053e89721d4esm998411eds.68.2023.10.17.04.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:15:58 -0700 (PDT)
Date: Tue, 17 Oct 2023 13:15:57 +0200
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
Message-ID: <ZS5s7QE07YkO55O7@nanopsycho>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-4-przemyslaw.kitszel@intel.com>
 <ZS5qztBDc3ebxypI@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5qztBDc3ebxypI@nanopsycho>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 17, 2023 at 01:06:54PM CEST, jiri@resnulli.us wrote:
>Tue, Oct 17, 2023 at 12:53:33PM CEST, przemyslaw.kitszel@intel.com wrote:
>>Drop unneeded error checking.
>>
>>devlink_fmsg_*() family of functions is now retaining errors,
>>so there is no need to check for them after each call.
>>
>>Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>---
>>add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-57 (-57)
>>---
>> drivers/net/ethernet/amd/pds_core/devlink.c | 29 ++++++---------------
>> 1 file changed, 8 insertions(+), 21 deletions(-)
>>
>>diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
>>index d9607033bbf2..8b2b9e0d59f3 100644
>>--- a/drivers/net/ethernet/amd/pds_core/devlink.c
>>+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
>>@@ -154,33 +154,20 @@ int pdsc_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
>> 			      struct netlink_ext_ack *extack)
>> {
>> 	struct pdsc *pdsc = devlink_health_reporter_priv(reporter);
>>-	int err;
>> 
>> 	mutex_lock(&pdsc->config_lock);
>>-
>> 	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
>>-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
>>+		devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
>> 	else if (!pdsc_is_fw_good(pdsc))
>>-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
>>+		devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
>> 	else
>>-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
>>-
>>+		devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
>> 	mutex_unlock(&pdsc->config_lock);
>> 
>>-	if (err)
>>-		return err;
>>-
>>-	err = devlink_fmsg_u32_pair_put(fmsg, "State",
>>-					pdsc->fw_status &
>>-						~PDS_CORE_FW_STS_F_GENERATION);
>>-	if (err)
>>-		return err;
>>-
>>-	err = devlink_fmsg_u32_pair_put(fmsg, "Generation",
>>-					pdsc->fw_generation >> 4);
>>-	if (err)
>>-		return err;
>>+	devlink_fmsg_u32_pair_put(fmsg, "State",
>>+				  pdsc->fw_status & ~PDS_CORE_FW_STS_F_GENERATION);
>>+	devlink_fmsg_u32_pair_put(fmsg, "Generation", pdsc->fw_generation >> 4);
>>+	devlink_fmsg_u32_pair_put(fmsg, "Recoveries", pdsc->fw_recoveries);
>> 
>>-	return devlink_fmsg_u32_pair_put(fmsg, "Recoveries",
>>-					 pdsc->fw_recoveries);
>>+	return 0;
>
>Could you please covert the function to return void? Please make sure
>to do this in the rest of the patchset as well.
>
>Thanks!

Sorry, I messed up, this is a cb. Looks fine.

pw-bot: under-review

>
>pw-bot: cr
>
>
>> }
>>-- 
>>2.40.1
>>

