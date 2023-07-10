Return-Path: <netdev+bounces-16378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE174CFD9
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 10:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3DB1C209BB
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 08:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34444C2EE;
	Mon, 10 Jul 2023 08:24:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CAFA933
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 08:24:08 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8665E76
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 01:23:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99342a599e9so548927666b.3
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1688977436; x=1691569436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVVTTcakGIJzotpbfodORieW7nDILC8yQwEKuMOUYLA=;
        b=v8PbxExQdeZ1rHkHw7LZ/7j9U0WaA1dkJRr1esV51tDnEYnz1yXdBnwheipucQw7iU
         Dwny0J0H5BLnpfGCG5wzHd2FnzlN2eKCW8gMzeSEoxaUGxTKsnw6EvOsEUU4TK67JfFM
         Fphyzekktczmyd9ASIWTNFAeo2y/sK6qzV5gvKJEWK5UQrHLGo1bEQy410Gg0pjYZAno
         l+f8A80ndIBgzckm1LdIX5bAeQYPaJaXuB13ipB3GplwZOJY/GVnmBg1MPjebry6Ueg9
         L5E9ztuma8giElufrDqCE9zHYDHjDcl1vKgQ9QXsO3zircBl8jFsHwzGNf5dL/40PtRb
         4zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688977436; x=1691569436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVVTTcakGIJzotpbfodORieW7nDILC8yQwEKuMOUYLA=;
        b=WmKx6aiRbWQa2MHtsmnODOJ/FA+rdnHWkjSgL01/BdFdoOrsFLxDrnn6d66PN5o1ie
         MoiZxngs6ehArAfBBleZIs7KcqM/bTuYWH3DJxNHIQGj5Zwhgs8XUav9cD8S013ezCDS
         IGEqU0ZMw2FLHWcrC9DqW/tFZ6pbrCEgHVKXaAXHjRePxKk/i8VqVENzHTKV1bySOY7W
         bDWD9IIUo7kXSYqQgJpwEi92Q/3W5Y5cyFcYIgZNU/ax9bBOGEDbBL60k5bST2arp/Fb
         q0dMb5euy5kJqU9VngDXnGU0qjI7mMrWxllcXXD2w8EZK8kgF/cCDli2RBkEk5qa4h76
         hprA==
X-Gm-Message-State: ABy/qLZ/tX6gWMoCWNQ30rFCK0O8Mois7galwxf5QioSWC+n0dMcb8up
	e3n0Z3r21kFsO13ayGaVqH8HeQ==
X-Google-Smtp-Source: APBJJlF/N78SzaPnYo5KIYgXXWBnknej6T2zV2RqWE8pAe5WopCVgqY0xM4CSFkpZNpYhf0+V/cUNg==
X-Received: by 2002:a17:906:101e:b0:993:fba5:cdf3 with SMTP id 30-20020a170906101e00b00993fba5cdf3mr5110018ejm.6.1688977436009;
        Mon, 10 Jul 2023 01:23:56 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709063b8200b0098e42bef732sm5733689ejf.183.2023.07.10.01.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:23:55 -0700 (PDT)
Date: Mon, 10 Jul 2023 10:23:53 +0200
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
Message-ID: <ZKvAGSwbJWEQmESs@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-9-arkadiusz.kubalewski@intel.com>
 <ZISmmH0jqxZRB4VX@nanopsycho>
 <DM6PR11MB4657161D2871747A7B404EDD9B5FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZJLtR0c+tvCbUgri@nanopsycho>
 <ZJ0hQRcm6S05r8VE@nanopsycho>
 <DM6PR11MB465726733894C7E64AD3367E9B29A@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB465726733894C7E64AD3367E9B29A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Jul 03, 2023 at 02:37:18PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Thursday, June 29, 2023 8:14 AM
>>
>>Wed, Jun 21, 2023 at 02:29:59PM CEST, jiri@resnulli.us wrote:
>>>Mon, Jun 19, 2023 at 10:34:12PM CEST, arkadiusz.kubalewski@intel.com
>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Saturday, June 10, 2023 6:37 PM
>>>>>
>>>>>Fri, Jun 09, 2023 at 02:18:51PM CEST, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>
>>>>>[...]
>>>>>
>>>>>
>>>>>>+static int ice_dpll_mode_get(const struct dpll_device *dpll, void *priv,
>>>>>>+			     enum dpll_mode *mode,
>>>>>>+			     struct netlink_ext_ack *extack)
>>>>>>+{
>>>>>>+	*mode = DPLL_MODE_AUTOMATIC;
>>>>>
>>>>>I don't understand how the automatic mode could work with SyncE. The
>>>>>There is one pin exposed for one netdev. The SyncE daemon should select
>>>>>exacly one pin. How do you achieve that?
>>>>>Is is by setting DPLL_PIN_STATE_SELECTABLE on the pin-netdev you want to
>>>>>select and DPLL_PIN_STATE_DISCONNECTED on the rest?
>>>>>
>>>>>
>>>>>[...]
>>>>
>>>>AUTOMATIC mode autoselects highest priority valid signal.
>>>>As you have pointed out, for SyncE selection, the user must be able to
>>>>manually
>>>>select a pin state to enable recovery of signal from particular port.
>>>>
>>>>In "ice" case there are 2 pins for network PHY clock signal recovery, and
>>>>both
>>>>are parent pins (MUX-type). There are also 4 pins assigned to netdevs
>>>>(one per
>>>>port). Thus passing a signal from PHY to the pin is done through the MUX-
>>>>pin,
>>>>by selecting proper state on pin-parent pair (where parent pins is highest
>>>>prio
>>>>pin on dpll).
>>>
>>>Could you show me some examples please?
>>
>>Arkadiusz, could you please reply to this?
>>Thanks!
>>
>
>Sure, sorry for the delays, let's try that.
>
>'ice' use case:
>Enabling a PHY clock recovery for DPLL_MODE_AUTOMATIC dpll (ID#0) with PHY
>recovered clock signals (PIN_ID#13) being muxed using MUX-type pin (PIN_ID#2)
>
>1. Set MUX-type pin to state selectable and highest priority on a dpll device
>(or make sure it is already configured):
>CMD_PIN_SET:
>	PIN_ID			2
>	PIN_PARENT_DEVICE	(nest)
>		ID		0
>		PIN_STATE	SELECTABLE
>		PIN_PRIO	0
>(assume all the other pins have prio >=1)
>
>2. Set connected state on a pin-parent_pin tuple where parent is a pin from #1
>CMD_PIN_SET:
>	PIN_ID			13
>	PIN_PARENT_PIN		(nest)
>		PIN_ID		2
>		PIN_STATE	CONNECTED

How does this look from the perspective of a SyncE flow. Let's say you
have eth0 and eth1, both is connected with a DPLL pin. Could you show
how you select eth0 and then eth1?



>
>Thank you!
>Arkadiusz
>
>>>
>>>
>>>>
>>>>Thank you!
>>>>Arkadiusz

