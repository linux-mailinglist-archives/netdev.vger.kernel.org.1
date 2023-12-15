Return-Path: <netdev+bounces-57925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A50A814816
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8611F2399A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03F15EBC;
	Fri, 15 Dec 2023 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="K3mtzr3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC138F
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336445a2749so419132f8f.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702643435; x=1703248235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qS1FGYqQUVgg6kmNF1jX+vnsM7iLoRSHDDPBhaHTk2c=;
        b=K3mtzr3ZnMrsi8h+uzxXkHgfzsqoaLtvSYkKD4yrLvV5L7Wkav1EEXK9lrq5eUYagS
         BaP5HaKVHPnd7sd8VMzMEpD4u5EL/q3lMNRFRnlwXBuTmkkqzlhDQWos02dXsrMT/xeh
         zCooiJYiR3UgkmZp23olyzchzlyXiSKvvIWOzxejUPlNU0KSU9aUawtZ3fYQrtCF1ZA1
         quwl1Y/TMlYoT7l5M5eWu4CVZ3uSC1U28L2G5gKCLkw85me0vs1O03IBnh8Y0htyxhB3
         upW3WjhUZUPDdRgK9bV+OmzXTGj9RBOc572CdFrhJBd53gybjm66+o8vFXBOnDwrjYME
         LODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702643435; x=1703248235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qS1FGYqQUVgg6kmNF1jX+vnsM7iLoRSHDDPBhaHTk2c=;
        b=qLASyvg2p2bDDp5PgFDPDluNMxQ61QFhE/tMikoftzXTA93U3FmnmP1jFM210kNmVU
         Ffnb+RfmbhI++hWuOCnkIatPI3KvfC1NjtGo8+4nLUMcl3oYLfP5u5gH93emo8KqBMPN
         eqnkwmrbhOj7dGGKM1oe03oYgfZh7cTtCfrEw/c6iYuHOLe6/ZmDk4BXo7ZL332POnz6
         DpT8FsjXpO8trsN3wAenCGkfsblejsSh2C0AF9iwjOmFIiWVKgzlrGHFTVLatZ4RL+dg
         yMaB4Tv+hQeS075ccO1wioKQXdkcwn62uiLTXECxaH5wcIPAJyfAi3wXZTgb9AUvLXOr
         8CVA==
X-Gm-Message-State: AOJu0YwFqjDrZnZmtc32UHjozojJmVvfAZ+/l/wuT6bA2NWmMoKB3RME
	mW71x1WDAeIBQxHkdcEAeN855IiZsAplKGLjwKw=
X-Google-Smtp-Source: AGHT+IFlj4q60v6pJqLAyyHxPTjQFrEhx3e7Vy7nAJ7PJz1rp7p1y8vJEgxT2DqM6935BHDDhsMGTA==
X-Received: by 2002:a5d:5309:0:b0:336:3ac4:b8ba with SMTP id e9-20020a5d5309000000b003363ac4b8bamr2290149wrv.60.1702643434740;
        Fri, 15 Dec 2023 04:30:34 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d69cf000000b0033641783aeesm6487430wrw.7.2023.12.15.04.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 04:30:34 -0800 (PST)
Date: Fri, 15 Dec 2023 13:30:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
	qi.z.zhang@intel.com, Wenjun Wu <wenjun1.wu@intel.com>,
	maxtram95@gmail.com, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	Simon Horman <simon.horman@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
Message-ID: <ZXxG6MFb3KO-RVw9@nanopsycho>
References: <5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
 <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
 <20231118084843.70c344d9@kernel.org>
 <3d60fabf-7edf-47a2-9b95-29b0d9b9e236@intel.com>
 <20231122192201.245a0797@kernel.org>
 <e662dca5-84e4-4f7b-bfa3-50bce30c697c@intel.com>
 <20231127174329.6dffea07@kernel.org>
 <55e51b97c29894ebe61184ab94f7e3d8486e083a.camel@redhat.com>
 <20231214174604.1ca4c30d@kernel.org>
 <7b0c2e0132b71b131fc9a5407abd27bc0be700ee.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b0c2e0132b71b131fc9a5407abd27bc0be700ee.camel@redhat.com>

Fri, Dec 15, 2023 at 12:06:52PM CET, pabeni@redhat.com wrote:
>On Thu, 2023-12-14 at 17:46 -0800, Jakub Kicinski wrote:
>> On Thu, 14 Dec 2023 21:29:51 +0100 Paolo Abeni wrote:
>> > Together with Simon, I spent some time on the above. We think the
>> > ndo_setup_tc(TC_SETUP_QDISC_TBF) hook could be used as common basis for
>> > this offloads, with some small extensions (adding a 'max_rate' param,
>> > too).
>> 
>> uAPI aside, why would we use ndo_setup_tc(TC_SETUP_QDISC_TBF)
>> to implement common basis?
>> 
>> Is it not cleaner to have a separate driver API, with its ops
>> and capabilities?
>
>We understand one of the end goal is consolidating the existing rate-
>related in kernel interfaces.  Adding a new one does not feel a good
>starting to reach that goal, see [1] & [2] ;). ndo_setup_tc() feels
>like the natural choice for H/W offload and TBF is the existing
>interface IMHO nearest to the requirements here.
>
>The devlink rate API could be a possible alternative...

Again, devlink rate was introduced for the rate configuration of the
entity that is not present (by netdev for example) on a host.
If we have netdev, let's use it.


>
>> > The idea would be:
>> > - 'fixing' sch_btf so that the s/w path became a no-op when h/w offload
>> > is enabled
>> > - extend sch_btf to support max rate
>> > - do the relevant ice implementation
>> > - ndo_set_tx_maxrate could be replaced with the mentioned ndo call (the
>> > latter interface is a strict super-set of former)
>> > - ndo_set_vf_rate could also be replaced with the mentioned ndo call
>> > (with another small extension to the offload data)
>> > 
>> > I think mqprio deserves it's own separate offload interface, as it
>> > covers multiple tasks other than shaping (grouping queues and mapping
>> > priority to classes)
>> > 
>> > In the long run we could have a generic implementation of the
>> > ndo_setup_tc(TC_SETUP_QDISC_TBF) in term of devlink rate adding a
>> > generic way to fetch the devlink_port instance corresponding to the
>> > given netdev and mapping the TBF features to the devlink_rate API.
>> > 
>> > Not starting this due to what Jiri mentioned [1].
>> 
>> Jiri, AFAIU, is against using devlink rate *uAPI* to configure network
>> rate limiting. That's separate from the internal representation.
>
>... with a couples of caveats:
>
>1) AFAICS devlink (and/or devlink_port) does not have fine grained, per
>queue representation and intel want to be able to configure shaping on
>per queue basis. I think/hope we don't want to bring the discussion to
>extending the devlink interface with queue support, I fear that will
>block us for a long time. Perhaps I’m missing or misunderstanding
>something here. Otherwise in retrospect this looks like a reasonable
>point to completely avoid devlink here.
>
>2) My understanding of Jiri statement was more restrictive. @Jiri it
>would great if could share your genuine interpretation: are you ok with
>using the devlink_port rate API as a basis to replace
>ndo_set_tx_maxrate() (via dev->devlink_port->devlink->) and possibly

Does not make any sense to me.


>ndo_set_vf_rate(). Note the given the previous point, this option would

ndo_set_vf_rate() (and the rest of ndo_[gs]et_vf_*() ndo) is the
legacy way. Devlink rate replaced that when switchdev eswich mode is
configured by:
$ sudo devlink dev eswitch set pci/0000:08:00.1 mode switchdev

In drivers, ndo_set_vf_rate() and devlink rate are implemented in the
same way. See mlx5 for example:
mlx5_esw_qos_set_vport_rate()
mlx5_esw_devlink_rate_leaf_tx_share_set()



>still feel problematic.
>
>Cheers,
>
>Paolo
>
>[1] https://xkcd.com/927/
>[2] https://www.youtube.com/watch?v=f8kO_L-pDwo
>

