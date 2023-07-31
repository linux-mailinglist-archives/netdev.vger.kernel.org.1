Return-Path: <netdev+bounces-22822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA17B7695FD
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81EA1C20B19
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96068182CB;
	Mon, 31 Jul 2023 12:19:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3C1800B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 12:19:55 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DDC171B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 05:19:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso49499425e9.2
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 05:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690805985; x=1691410785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XM+dBkL9BOQB5M0QkPLLYoaZfMRgmlrJZ/IVtD0ioO0=;
        b=K/ixDBtHAoED1QTZkzrM0HP35wmxU5en+ia0zc1sDJnLq2BhUN1mjgwFGR3x0mhUTm
         H3OGTNuakXfxocEdqK1GhB3S8ynucvmwby3nWGTgvzmW49oBhpMPPdFAcSMbboxIRnU4
         qKduZksCoD63Qc6ufiHOWoJc41ELb6Vq9XiC1ggxpI9Ch37s/vd9s1KhlnqneJ39yKbE
         xvoRMFv7kumu57kjrYbkZp1tjuXo2Te+/Kf/dZlJ8g7PjBW+cB0Rj0SCLXWinfJmVqSV
         OQMt2XyprtX9qNGZQKMuoaR7LapJai9uasZrHpbx8KCHwCsJpCf1oB9++nilbbY57J6n
         FIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805985; x=1691410785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM+dBkL9BOQB5M0QkPLLYoaZfMRgmlrJZ/IVtD0ioO0=;
        b=fdJp5H2WFoTjNnJyD+ZYjvNNkVeJBG27udugJaYygoWClUcPaT/1KW8EpFe1W+LWo+
         0WVQAJO71zfxCYA3qD9GitCxGfOVyu+Ddbwyq9mj9oFWCpnbug3irXoM756ShQuVCyJZ
         5/JJeMpnx/ON7xD75hrI48SJqbagOWld01gCriEZL0sp8pUbU40HJMw1Cbds6rtg92fK
         gB4IUyhNa2MXtoWpYAt5fiPyXjBvIv/rlkNXGdosrRAUnI4D8oN3YHOdaBGu2pK6C3PW
         qvCeE14EjPvTyym3hiZe1kFpsPA47JJHP/p8DOUhZXcZj8/GFzUynXVLbdLdgrNFi1TP
         fKXA==
X-Gm-Message-State: ABy/qLZOvzZGWc7ZldVh5xBKzyjiuuNTO1QakVDmtTLcCZfs1Dtg0DRt
	9UDstF0gl/w5dlaOEZ5yHAiQWQ==
X-Google-Smtp-Source: APBJJlEctlAU59sp6IeHDQnotTpHuuRt9EWdIcJSmwMi77Aq/AtVjK71uRjSDGZv/d1bBLLm+M5qIw==
X-Received: by 2002:a7b:ca53:0:b0:3fb:415a:d07 with SMTP id m19-20020a7bca53000000b003fb415a0d07mr7933564wml.36.1690805984930;
        Mon, 31 Jul 2023 05:19:44 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id x13-20020a05600c21cd00b003fe21c7386esm2247355wmj.45.2023.07.31.05.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:19:44 -0700 (PDT)
Date: Mon, 31 Jul 2023 14:19:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	poros <poros@redhat.com>, mschmidt <mschmidt@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 09/11] ice: implement dpll interface to control cgu
Message-ID: <ZMem35OUQiQmB9Vd@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLpuaxMJ+8rWAPwi@nanopsycho>
 <DM6PR11MB46571657F0DF87765DAB32FE9B06A@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46571657F0DF87765DAB32FE9B06A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sat, Jul 29, 2023 at 01:03:59AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Friday, July 21, 2023 1:39 PM
>>
>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>

[...]


>>>+static int ice_dpll_cb_lock(struct ice_pf *pf, struct netlink_ext_ack
>>>*extack)
>>>+{
>>>+	int i;
>>>+
>>>+	for (i = 0; i < ICE_DPLL_LOCK_TRIES; i++) {
>>>+		if (!test_bit(ICE_FLAG_DPLL, pf->flags)) {
>>
>>And again, as I already told you, this flag checking is totally
>>pointless. See below my comment to ice_dpll_init()/ice_dpll_deinit().
>>
>
>This is not pointless, will explain below.
>
>>
>>
>
>[...]
>

[...]


>>>+void ice_dpll_deinit(struct ice_pf *pf)
>>>+{
>>>+	bool cgu = ice_is_feature_supported(pf, ICE_F_CGU);
>>>+
>>>+	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>>+		return;
>>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>>+
>>>+	ice_dpll_deinit_pins(pf, cgu);
>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>>+	ice_dpll_deinit_info(pf);
>>>+	if (cgu)
>>>+		ice_dpll_deinit_worker(pf);
>>
>>Could you please order the ice_dpll_deinit() to be symmetrical to
>>ice_dpll_init()? Then, you can drop ICE_FLAG_DPLL flag entirely, as the
>>ice_dpll_periodic_work() function is the only reason why you need it
>>currently.
>>
>
>Not true.
>The feature flag is common approach in ice. If the feature was successfully

The fact that something is common does not necessarily mean it is
correct. 0 value argument.


>initialized the flag is set. It allows to determine if deinit of the feature
>is required on driver unload.
>
>Right now the check for the flag is not only in kworker but also in each
>callback, if the flag were cleared the data shall be not accessed by callbacks.

Could you please draw me a scenario when this could actually happen?
It is just a matter of ordering. Unregister dpll device/pins before you
cleanup the related resources and you don't need this ridiculous flag.


>I know this is not required, but it helps on loading and unloading the driver,
>thanks to that, spam of pin-get dump is not slowing the driver load/unload.

? Could you plese draw me a scenario how such thing may actually happen?

Thanks!


>
>>
>>>+	mutex_destroy(&pf->dplls.lock);
>>>+}


[...]

