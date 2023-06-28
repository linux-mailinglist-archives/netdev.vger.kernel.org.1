Return-Path: <netdev+bounces-14426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A77411F3
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 15:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C092F1C203D9
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF99C12E;
	Wed, 28 Jun 2023 13:09:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2DBE74
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 13:09:57 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCDD212D
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 06:09:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51da8a744c4so2406021a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687957793; x=1690549793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k76YrPTzyyjATZAkPWsngOApRdksnz4938tVnCuwxy0=;
        b=ScgYnUQe6P6kGA/N6ZPo3yO417tWRwpx3GvemyrdtyZVRiMKBb3mX7VI2GC9diLcMu
         CBglKEUKyw7sx2XjP/XbJOD3iNnN+N9GWxQ1mlTSXafAi8ZUGZ1eDbHmnkr5clkYOrjz
         8GDQoZ2Tp1PraxZ/pmeSyq/QVCRc/QRFE5TFbBS9xF88g2abpug24dt9lgXFX5GM+yij
         RiioISv2/N2ZwCj6vMlrza/ubjNUMvoHHzw+bfeT37sBUEtzdgN4KJIymYZ3Ku4VDzhk
         Mj4zVAxzoFL1AljyNcajNKEfjlIxauzw/vVgq7tTHszhYZyGB1ntaUvlngn31dONZgTd
         zmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687957793; x=1690549793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k76YrPTzyyjATZAkPWsngOApRdksnz4938tVnCuwxy0=;
        b=fXFcARQdvYxEbUoXjrQrgBvbQXMIYS9mam3m8Hs36YgNCpkEHOXH9906UfjTw8jxRy
         BFegYR/++qW3stz9pn61hWOe5h14IhDU0st383TK/p1aIl2XLqaWqYj6JE1TWF0fa/xo
         5pXZQQyYVXyN5UrSAqh3iTw/LYypliIxqzLy/7eRb9NY05CpwGUllEaG6y+cSrSqX4ws
         T9Y0pOTL0MmMLI9Hgn8QIR556PLNaD0wgGvvX4AkqsWUTvIMhv1Pi1NrLWVCrZE1oB4t
         m95goBww3YGHhl9nwqCc+3x6/h2Y8rNuTaPR1FtG+KE9SxXah96i/QfyfZVscP3fc2C4
         h1wg==
X-Gm-Message-State: AC+VfDxOKEw5IQ3jZYOADo0bNCdQhAzLcqQrlo3bNjKqh1UGQ2iBJ0zK
	Aiblqf6tjsiDYsEVvWus3SOEfQ==
X-Google-Smtp-Source: ACHHUZ4FQ7JmqxI+YoYuBXCwpW4UP8TYDQSff2DdAMDuypxC1caOuVE2XCGI/Z0rJ4e0navjgsMuwg==
X-Received: by 2002:a05:6402:1496:b0:51d:91ef:c836 with SMTP id e22-20020a056402149600b0051d91efc836mr6548808edv.32.1687957792701;
        Wed, 28 Jun 2023 06:09:52 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402165300b0051d9df5dd2fsm2609023edx.72.2023.06.28.06.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:09:51 -0700 (PDT)
Date: Wed, 28 Jun 2023 15:09:50 +0200
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
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <ZJwxHucKMwCQMMVM@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJq3a6rl6dnPMV17@nanopsycho>
 <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <DM6PR11MB4657A1ACB586AD9B45C7996E9B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <2e9ce197-2732-d061-b11d-4f4513af6abc@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e9ce197-2732-d061-b11d-4f4513af6abc@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 28, 2023 at 01:11:19PM CEST, vadim.fedorenko@linux.dev wrote:
>On 28/06/2023 10:27, Kubalewski, Arkadiusz wrote:
>> > From: Kubalewski, Arkadiusz
>> > Sent: Wednesday, June 28, 2023 11:15 AM
>> > 
>> > > From: Jiri Pirko <jiri@resnulli.us>
>> > > Sent: Tuesday, June 27, 2023 12:18 PM
>> > > 
>> > > Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com
>> > wrote:
>> > > 
>> > > > v8 -> v9:
>> > > 
>> > > Could you please address all the unresolved issues from v8 and send v10?
>> > > I'm not reviewing this one.
>> > > 
>> > > Thanks!
>> > 
>> > Sure, will do, but first missing to-do/discuss list:
>> > 1) remove mode_set as not used by any driver
>> > 2) remove "no-added-value" static functions descriptions in
>> >    dpll_core/dpll_netlink
>> > 3) merge patches [ 03/10, 04/10, 05/10 ] into patches that are compiling
>> >    after each patch apply
>> > 4) remove function return values descriptions/lists
>> > 5) Fix patch [05/10]:
>> >    - status Supported
>> >    - additional maintainers
>> >    - remove callback:
>> >      int (*source_pin_idx_get)(...) from `struct dpll_device_ops`
>> > 6) Fix patch [08/10]: rethink ice mutex locking scheme
>> > 7) Fix patch [09/10]: multiple comments on
>> > https://lore.kernel.org/netdev/ZIQu+%2Fo4J0ZBspVg@nanopsycho/#t
>> > 8) add PPS DPLL phase offset to the netlink get-device API
>> > 
>> > Thank you!
>> > Arkadiusz
>> 
>> If someone has any objections please state them now, I will work on
>> all above except 5) and 7).
>> Vadim, could you take care of those 2 points?
>> 
>Yeah, sure, I'll update 5 and 7.
>I'm not sure about 8) - do we really need this info, I believe every
>supported DPLL device exports PTP device as well. But I'm Ok to add this
>feature too.

Could you add the notification work while you are at it? I don't want
that to be forgotten. Thanks!

>
>> Thank you!
>> Arkadiusz
>

