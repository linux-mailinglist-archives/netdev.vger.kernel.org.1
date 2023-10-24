Return-Path: <netdev+bounces-43891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE07D5387
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274D01C20C6F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F52B765;
	Tue, 24 Oct 2023 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eqpEzEDI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6B125DE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:00:01 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347F10EF
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:59:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so6947440a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698155997; x=1698760797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgdX192KFs5xjFiQY9Esfa/RVC4h8fO0VTXfZSLKSz0=;
        b=eqpEzEDInlHlslZ+v3NLgYMsK6LpydrTC2e/F2dhoOw2dLa+HAqEXL3WKXz4KPW2Fd
         cl4sQpUz88tWGzyweoZgKy4mRu7lmCeTfPu2AbWXrJ5fh06Fse1VFgTQ6z4L2O/zvgwt
         dYhHQ5LvvNy6T6K+gzsd1RN3g1D/NGVFmQS6d4C5pi6ivQZDEQFGZvmGTsvcaRjpm/6f
         X13DhMLZBKDogkn4WgyM0na8I7TaO0BFyoYsUSnGsSgLkwFvGG5RLoeEmkfMVxfK361V
         fTm+Kvv2d15bfkwMq8V9l4lQ1iNTYxHP4vfBlarIWrSWXm9IH3yO+cBIvr18Qfrgomt6
         rEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155997; x=1698760797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgdX192KFs5xjFiQY9Esfa/RVC4h8fO0VTXfZSLKSz0=;
        b=ay8tmgZLiGCtopFVJuM3X8jagWhFicRA/eXLJDzenPRAYA/LDDL7TdLsJFXpt/AUlS
         m/kmvhz+ON4Iz+OKQE3b4LYhIpf0ZZ8j/QyWuSxX0Dv9xpIIymX/sbwDz0By3XmPW+vw
         if0WvGkRER3fKxkmwxyAkXhaZA1O1QkBhj3/iQYNEaa0yCf+JYEo1+cvzyxXjROtq7HY
         H43b6bfzovA1OJz0bUb2gUQi8wBDGn9J0ayg/AeCytjRSNh7m8/IQsK/IvuzC9VURUgL
         Fvd/3UomJm1793rL8qiY5iIuja0/DdGBBVEQ8psFEgf8MFXMKHADEy/x/KbbkX7aCFqt
         /WLg==
X-Gm-Message-State: AOJu0YxpolCigF0okq3m20cmWPGKlKSd7A3FLb8Hh0RN83s/s+sFORdI
	LMKXpslQ7f0dtuWuebRoZQF5Lw==
X-Google-Smtp-Source: AGHT+IEOqSVuyPBWT2PEqpT8k//S2BmNYh48OAyoFg4PNFz48+TogLO7Km36A6Ryl0V8LASW4amubg==
X-Received: by 2002:a05:6402:2707:b0:540:3a46:cdcd with SMTP id y7-20020a056402270700b005403a46cdcdmr6418116edd.29.1698155997370;
        Tue, 24 Oct 2023 06:59:57 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o2-20020a509b02000000b0053db0df6970sm8138765edi.54.2023.10.24.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:59:56 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:59:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	piotr.raczynski@intel.com, wojciech.drewek@intel.com,
	marcin.szycik@intel.com, jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com, jesse.brandeburg@intel.com
Subject: Re: [PATCH iwl-next v1 00/15] one by one port representors creation
Message-ID: <ZTfN22fHri3vKWyF@nanopsycho>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
 <ZTeveEZ1W/zejDuM@nanopsycho>
 <ZTfCVsYtbwSg9nZ/@wasp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTfCVsYtbwSg9nZ/@wasp>

Tue, Oct 24, 2023 at 03:10:46PM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Tue, Oct 24, 2023 at 01:50:16PM +0200, Jiri Pirko wrote:
>> Tue, Oct 24, 2023 at 01:09:14PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >Hi,
>> >
>> >Currently ice supports creating port representors only for VFs. For that
>> >use case they can be created and removed in one step.
>> >
>> >This patchset is refactoring current flow to support port representor
>> >creation also for subfunctions and SIOV. In this case port representors
>> >need to be createad and removed one by one. Also, they can be added and
>> >removed while other port representors are running.
>> >
>> >To achieve that we need to change the switchdev configuration flow.
>> >Three first patches are only cosmetic (renaming, removing not used code).
>> >Next few ones are preparation for new flow. The most important one
>> >is "add VF representor one by one". It fully implements new flow.
>> >
>> >New type of port representor (for subfunction) will be introduced in
>> >follow up patchset.
>> 
>> Examples please. Show new outputs of devlink commands.
>> 
>> Thanks!
>>
>
>If you mean outputs after refactor to one by one solution nothing
>has changed:
>
># devlink port show (after creating 4 VFs in switchdev mode)
>pci/0000:18:00.0/0: type eth netdev ens785f0np0 flavour physical port 0 splittable true lanes 8
>pci/0000:18:00.0/2: type eth netdev ens785f0np0_0 flavour pcivf controller 0 pfnum 0 vfnum 0 external false splittable false
>pci/0000:18:00.0/4: type eth netdev ens785f0np0_3 flavour pcivf controller 0 pfnum 0 vfnum 3 external false splittable false
>pci/0000:18:00.0/5: type eth netdev ens785f0np0_1 flavour pcivf controller 0 pfnum 0 vfnum 1 external false splittable false
>pci/0000:18:00.0/6: type eth netdev ens785f0np0_2 flavour pcivf controller 0 pfnum 0 vfnum 2 external false splittable false
>
>According subfunction, it will also be in cover latter for patchset that
>is implementing subfunction.
>
>Commands:
># devlink dev eswitch set pci/0000:18:00.0 mode switchdev
># devlink port add pci/0000:18:00.0 flavour pcisf pfnum 0 sfnum 1000
># devlink port function set pci/0000:18:00.0/3 state active
>
>Outputs:
>Don't have it saved, will send it here after rebasing subfunction of top
>of this one.

Ah, I was under impression it is part of this set. Sorry.


>
>Thanks,
>Michal
>
>> >
>> >Michal Swiatkowski (15):
>> >  ice: rename switchdev to eswitch
>> >  ice: remove redundant max_vsi_num variable
>> >  ice: remove unused control VSI parameter
>> >  ice: track q_id in representor
>> >  ice: use repr instead of vf->repr
>> >  ice: track port representors in xarray
>> >  ice: remove VF pointer reference in eswitch code
>> >  ice: make representor code generic
>> >  ice: return pointer to representor
>> >  ice: allow changing SWITCHDEV_CTRL VSI queues
>> >  ice: set Tx topology every time new repr is added
>> >  ice: realloc VSI stats arrays
>> >  ice: add VF representors one by one
>> >  ice: adjust switchdev rebuild path
>> >  ice: reserve number of CP queues
>> >
>> > drivers/net/ethernet/intel/ice/ice.h          |  13 +-
>> > drivers/net/ethernet/intel/ice/ice_devlink.c  |  29 +
>> > drivers/net/ethernet/intel/ice/ice_devlink.h  |   1 +
>> > drivers/net/ethernet/intel/ice/ice_eswitch.c  | 562 ++++++++++--------
>> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
>> > .../net/ethernet/intel/ice/ice_eswitch_br.c   |  22 +-
>> > drivers/net/ethernet/intel/ice/ice_lib.c      |  81 ++-
>> > drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
>> > drivers/net/ethernet/intel/ice/ice_repr.c     | 195 +++---
>> > drivers/net/ethernet/intel/ice/ice_repr.h     |   9 +-
>> > drivers/net/ethernet/intel/ice/ice_sriov.c    |  20 +-
>> > drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   4 +-
>> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   9 +-
>> > drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +-
>> > 14 files changed, 553 insertions(+), 422 deletions(-)
>> >
>> >-- 
>> >2.41.0
>> >
>> >

