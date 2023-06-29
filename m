Return-Path: <netdev+bounces-14501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD0774203A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE7F1C2031A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38F524E;
	Thu, 29 Jun 2023 06:14:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C96523D
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 06:14:33 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D22703
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 23:14:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31409e8c145so339756f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1688019267; x=1690611267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxPmChzKXR1dj/ko+9tzcHvICaNxDCij9PscVU1CwGY=;
        b=g4spu/YTypGbdobXCPpsNMEE7fZgSTh6dwO8ck/RlyJzKG32ec8qbcH4voInoYNI6o
         nG6/zJ1n82WItH1lu3qQCRFI8uw3L8ph8dhnODO74Jobt9mAAC6aVPmcAOEeHa3CijaY
         GQ0EQQTgLWtAzMyQV8sZkz9pP1Q5sB+jGzX0IRtVzmIH7vRZDqd7kAqk/QYf3QTa8aEJ
         QSuo/h0rl0fcrDEeomgjT4HhlbHIS1Bzm651nwZXtQyAM08WdVMOLO0uppwo8McOoT1j
         8CGh366oXSh0q2wYy6HTFoOLtXKgeVtSm3qpnqhqbheagjwO+/UJVS4tnevaSr7XLabv
         Rrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688019267; x=1690611267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxPmChzKXR1dj/ko+9tzcHvICaNxDCij9PscVU1CwGY=;
        b=OPBPVNySbiFmiBuBMb6odscJ7Fs6rr3RJMPWiYqGiHFnnLyOmrMV+6ujmOYPOHsW+R
         /hCXTCcBHTL8LHc/AEljGbew4FXgroveu4o1Wq9kKdTTL0NkdY4fqfo/Yq6cab/XVnvD
         yOl9wQGT66blyPtf5yv/5dE/UoHshDpq4cBnMUTPdgqzV1T9c50WsyUBMwUituEAWz+0
         WUl+9ycFwQu5GI1pC/YuBoBLlWsYufiffxUGGt2fv7S6nO9Q57ONdS9nSGmcpe0Clzrx
         hK5LsvyzgM1l2LqcwYC8jkaLhXPNsMDUB24L9NcSwJqaS//Q/kPHEZFbCN2V1HLAAdXh
         T0aw==
X-Gm-Message-State: AC+VfDzjf4NM6ulNuIirc8Q5BbLmJxoVSfna73xWeHRkjUjX9Rpm9Yw6
	H5lltHMdKCJ3p4h89cQh+apWNQ==
X-Google-Smtp-Source: ACHHUZ7KKCQek3b9yJkpoCmAdgzst9lXvnl9IF1wrn2teksRP3fkGVdr25X0T5kABFTNqxM9KgVooQ==
X-Received: by 2002:a05:6000:181:b0:30f:d218:584a with SMTP id p1-20020a056000018100b0030fd218584amr32939868wrx.23.1688019267545;
        Wed, 28 Jun 2023 23:14:27 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d45c7000000b003141a3c4353sm460558wrs.30.2023.06.28.23.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 23:14:26 -0700 (PDT)
Date: Thu, 29 Jun 2023 08:14:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"vadfed@meta.com" <vadfed@meta.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"vadfed@fb.com" <vadfed@fb.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"M, Saeed" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"sj@kernel.org" <sj@kernel.org>,
	"javierm@redhat.com" <javierm@redhat.com>,
	"ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jacek.lawrynowicz@linux.intel.com" <jacek.lawrynowicz@linux.intel.com>,
	"airlied@redhat.com" <airlied@redhat.com>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"nipun.gupta@amd.com" <nipun.gupta@amd.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux@zary.sk" <linux@zary.sk>,
	"masahiroy@kernel.org" <masahiroy@kernel.org>,
	"benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"Olech, Milena" <milena.olech@intel.com>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"andy.ren@getcruise.com" <andy.ren@getcruise.com>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"idosch@nvidia.com" <idosch@nvidia.com>,
	"lucien.xin@gmail.com" <lucien.xin@gmail.com>,
	"nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
	"phil@nwl.cc" <phil@nwl.cc>,
	"claudiajkang@gmail.com" <claudiajkang@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	poros <poros@redhat.com>, mschmidt <mschmidt@redhat.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH v8 08/10] ice: implement dpll interface to control cgu
Message-ID: <ZJ0hQRcm6S05r8VE@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-9-arkadiusz.kubalewski@intel.com>
 <ZISmmH0jqxZRB4VX@nanopsycho>
 <DM6PR11MB4657161D2871747A7B404EDD9B5FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZJLtR0c+tvCbUgri@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJLtR0c+tvCbUgri@nanopsycho>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 02:29:59PM CEST, jiri@resnulli.us wrote:
>Mon, Jun 19, 2023 at 10:34:12PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Saturday, June 10, 2023 6:37 PM
>>>
>>>Fri, Jun 09, 2023 at 02:18:51PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>
>>>[...]
>>>
>>>
>>>>+static int ice_dpll_mode_get(const struct dpll_device *dpll, void *priv,
>>>>+			     enum dpll_mode *mode,
>>>>+			     struct netlink_ext_ack *extack)
>>>>+{
>>>>+	*mode = DPLL_MODE_AUTOMATIC;
>>>
>>>I don't understand how the automatic mode could work with SyncE. The
>>>There is one pin exposed for one netdev. The SyncE daemon should select
>>>exacly one pin. How do you achieve that?
>>>Is is by setting DPLL_PIN_STATE_SELECTABLE on the pin-netdev you want to
>>>select and DPLL_PIN_STATE_DISCONNECTED on the rest?
>>>
>>>
>>>[...]
>>
>>AUTOMATIC mode autoselects highest priority valid signal.
>>As you have pointed out, for SyncE selection, the user must be able to manually
>>select a pin state to enable recovery of signal from particular port.
>>
>>In "ice" case there are 2 pins for network PHY clock signal recovery, and both
>>are parent pins (MUX-type). There are also 4 pins assigned to netdevs (one per
>>port). Thus passing a signal from PHY to the pin is done through the MUX-pin,
>>by selecting proper state on pin-parent pair (where parent pins is highest prio
>>pin on dpll).
>
>Could you show me some examples please?

Arkadiusz, could you please reply to this?
Thanks!

>
>
>>
>>Thank you!
>>Arkadiusz

