Return-Path: <netdev+bounces-14434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D0741336
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435991C204F6
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37094C2DC;
	Wed, 28 Jun 2023 14:02:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B8BA2F
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 14:02:30 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AF43A98
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 07:02:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so6165447e87.2
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687960945; x=1690552945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeJJDtPNApCUCSNLbnRFD2Juhjv5XOx3haoMLR3t3E0=;
        b=ZK23Wz5Z8GgdygT07do/GeGr7NCgPtbZJrbEsqK+sYNbzD9dq931xi8plPBr2KO/YC
         c2ElDHPq2AXJLH8RWwZpB9knsmuQiwkA75793nzLpisqpqvUa59/U20kPPeRdhQAkFFo
         EcsePNHr4CjPy3GTkqp1HQZS4o+ge1jZitdNMcjjH282ksos55LbhmkEg5xKNUQUAHkW
         6elrjwozhdUiF5BEcoPrNlp7uOlNgyP51atS4qs5XQofDSmEJm98Sjm1IBUOaK7EQWtK
         w84yxmQahBhA3t//6ifI1+JN4mdssr5CTku4Y6hA7S2ImLAYmYaBhDJ+IlVLNrGKFrhO
         3CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960945; x=1690552945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeJJDtPNApCUCSNLbnRFD2Juhjv5XOx3haoMLR3t3E0=;
        b=TY2sAfmX1qASydVJIh3sopnrM7VyS6tujXrH1flwjtePqdbRIikC/oKQIePQaZ1rFI
         AMCMhCCD18+OLv5Jad5xW6FwYiL0o/Tn2+ey1IDEe/c54bwjcBWyzR/uJZ0XKBYTPxO9
         +OH95nxdUDWZcah3Y1iB5+Tp8gH6lxi/8z2bZKI5UyWty0YkGbtpFuCRcLv1ruILJWsb
         B6y8dHVsEuaEZz5oCp02VfTgWqd0GCTJvjSOHLIzTLWLWJqsq9LSSUIUGNcTbTY3Ta4W
         L3bXZhJDOaBFwccYf6dFBghMHSQMcucEgBMYlAx8L9tk9RlmMPlwkz2Qqxaxh8cwq21h
         nsEA==
X-Gm-Message-State: AC+VfDxHTgGix8Rp0OZUT0cCiQsnr8u419sqiDoS+Pb6AhMzsj2fm5rm
	w1UALa+XXsL7oK59W98c2+7MwA==
X-Google-Smtp-Source: ACHHUZ5ZxgNTxIxoQXOSx9k7rDEhnxIvqJQLYYOVQL1GcheSfi0K/9HAYhI29JpjcdxZaZ1hTbJv2w==
X-Received: by 2002:a05:6512:3412:b0:4fb:242:6e00 with SMTP id i18-20020a056512341200b004fb02426e00mr7754216lfr.41.1687960945439;
        Wed, 28 Jun 2023 07:02:25 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fba87298cesm4354984wmi.45.2023.06.28.07.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:02:24 -0700 (PDT)
Date: Wed, 28 Jun 2023 16:02:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"vadfed@meta.com" <vadfed@meta.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
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
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <ZJw9b9RQamu0cLN+@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJq3a6rl6dnPMV17@nanopsycho>
 <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <DM6PR11MB4657A1ACB586AD9B45C7996E9B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <2e9ce197-2732-d061-b11d-4f4513af6abc@linux.dev>
 <ZJwxHucKMwCQMMVM@nanopsycho>
 <4ebfa74e-8998-a1af-e6b9-3701008900ec@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebfa74e-8998-a1af-e6b9-3701008900ec@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 28, 2023 at 03:22:00PM CEST, vadim.fedorenko@linux.dev wrote:
>On 28/06/2023 14:09, Jiri Pirko wrote:
>> Wed, Jun 28, 2023 at 01:11:19PM CEST, vadim.fedorenko@linux.dev wrote:
>> > On 28/06/2023 10:27, Kubalewski, Arkadiusz wrote:
>> > > > From: Kubalewski, Arkadiusz
>> > > > Sent: Wednesday, June 28, 2023 11:15 AM
>> > > > 
>> > > > > From: Jiri Pirko <jiri@resnulli.us>
>> > > > > Sent: Tuesday, June 27, 2023 12:18 PM
>> > > > > 
>> > > > > Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com
>> > > > wrote:
>> > > > > 
>> > > > > > v8 -> v9:
>> > > > > 
>> > > > > Could you please address all the unresolved issues from v8 and send v10?
>> > > > > I'm not reviewing this one.
>> > > > > 
>> > > > > Thanks!
>> > > > 
>> > > > Sure, will do, but first missing to-do/discuss list:
>> > > > 1) remove mode_set as not used by any driver
>> > > > 2) remove "no-added-value" static functions descriptions in
>> > > >     dpll_core/dpll_netlink
>> > > > 3) merge patches [ 03/10, 04/10, 05/10 ] into patches that are compiling
>> > > >     after each patch apply
>> > > > 4) remove function return values descriptions/lists
>> > > > 5) Fix patch [05/10]:
>> > > >     - status Supported
>> > > >     - additional maintainers
>> > > >     - remove callback:
>> > > >       int (*source_pin_idx_get)(...) from `struct dpll_device_ops`
>> > > > 6) Fix patch [08/10]: rethink ice mutex locking scheme
>> > > > 7) Fix patch [09/10]: multiple comments on
>> > > > https://lore.kernel.org/netdev/ZIQu+%2Fo4J0ZBspVg@nanopsycho/#t
>> > > > 8) add PPS DPLL phase offset to the netlink get-device API
>> > > > 
>> > > > Thank you!
>> > > > Arkadiusz
>> > > 
>> > > If someone has any objections please state them now, I will work on
>> > > all above except 5) and 7).
>> > > Vadim, could you take care of those 2 points?
>> > > 
>> > Yeah, sure, I'll update 5 and 7.
>> > I'm not sure about 8) - do we really need this info, I believe every
>> > supported DPLL device exports PTP device as well. But I'm Ok to add this
>> > feature too.
>> 
>> Could you add the notification work while you are at it? I don't want
>> that to be forgotten. Thanks!
>
>Sure, Jiri, I'm working on it for ptp_ocp.

Yep, cool!

>
>> > 
>> > > Thank you!
>> > > Arkadiusz
>> > 
>

