Return-Path: <netdev+bounces-23913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911EE76E257
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A74282027
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2325713AFD;
	Thu,  3 Aug 2023 08:02:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109929440
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:02:46 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52324DF
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:02:42 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b974031aeaso9708961fa.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 01:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691049760; x=1691654560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWjI4XbkdglCN8ZQ+xl/2dRug01IAQ+rZAOGhdrF4Ds=;
        b=QURGvvcGEVr4NsJwaPPk0f8L+qWGFsRIW9kJE6x1NLrHzXTekeX+1xXxtFhw4vPGrp
         SDA8rpH6xkOQoydND3q8Qi8H3GzflEgEPP85x3WbxNu3AytURbjwWiCcG5kTpfCEvnmI
         ExELbZ43a8zZOPsoyYrGl1iC19dfiX9GDL8Phd8AfqV5V7vjhBeMdoJ+lVTCoEh1rU1c
         fOA6U5xBevZhEkEWBPtv4eLnJZ+bBipcIooK3sRK8zN3PEDrbd9MFQSdQfDUpvONU4fq
         uuKX2f8rXCK2sVkAHvESCs8L7n8ZV2DIgE01wfFfqPFy3whp1ywqQ0Jo2Sn8LcMSPnZv
         jTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691049760; x=1691654560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWjI4XbkdglCN8ZQ+xl/2dRug01IAQ+rZAOGhdrF4Ds=;
        b=QvTGTyA+wSW2qtZfke3nj/IqVOttBJ5ePpGXBdgUcEF30xLmJVEUmPnEf/IUAHe3mp
         aa7TisoO4TWm0IQUEkz9h8ivo+BOmQyB/ER/gsHNWY0MRasdRP53c2uQcYWux9NqiduO
         JBttaaXk4MaBXr73wLgtxjuP0Ludg+yzUl0QZVrp0hut/SWa59qcs11kG+tOGNBfYU7q
         z0p9MZbU4VRXbckmnnxHRwCdyr0T/GrtzJgGyttAXaF0Hrfu1GS/8Z7LGOlkhrKLNmUF
         Um9uSfdwHBxyU4c78gBiskm+y4Kntb7KrIPPGaZj3EU0O7zt6UixEyWK9Ukab3Ms4jfE
         acnA==
X-Gm-Message-State: ABy/qLY0pFR6XrdXL4dMegDwwZXG9AAqibx9Aw/yy9erT4bt+vgio+/j
	idw3T/YV25QY9wDTxYjduztWcg==
X-Google-Smtp-Source: APBJJlFG3nyJLz++ssYp8bbbyIAy60WW2BTl3Sv6RDcrxGf3ztv8ov0tc9h4az4k3zbOiGeUjMteew==
X-Received: by 2002:a2e:9f50:0:b0:2b9:ad7d:a144 with SMTP id v16-20020a2e9f50000000b002b9ad7da144mr6855771ljk.11.1691049760407;
        Thu, 03 Aug 2023 01:02:40 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003fbc30825fbsm3547854wmj.39.2023.08.03.01.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:02:39 -0700 (PDT)
Date: Thu, 3 Aug 2023 10:02:38 +0200
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
Message-ID: <ZMtfHn8es60MSMj+@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLpuaxMJ+8rWAPwi@nanopsycho>
 <DM6PR11MB46571657F0DF87765DAB32FE9B06A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMem35OUQiQmB9Vd@nanopsycho>
 <DM6PR11MB4657C0DA91583D92697324BC9B0AA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMn+Uvu8B6IcCFoj@nanopsycho>
 <DM6PR11MB46575671FF8CB35795EAA0669B0BA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46575671FF8CB35795EAA0669B0BA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 02, 2023 at 05:48:43PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, August 2, 2023 8:57 AM
>>
>>Tue, Aug 01, 2023 at 04:50:44PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Monday, July 31, 2023 2:20 PM
>>>>
>>>>Sat, Jul 29, 2023 at 01:03:59AM CEST, arkadiusz.kubalewski@intel.com
>>>>wrote:
>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>Sent: Friday, July 21, 2023 1:39 PM
>>>>>>
>>>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>
>>>>
>>>>[...]
>>>>
>>>>
>>>>>>>+static int ice_dpll_cb_lock(struct ice_pf *pf, struct netlink_ext_ack
>>>>>>>*extack)
>>>>>>>+{
>>>>>>>+	int i;
>>>>>>>+
>>>>>>>+	for (i = 0; i < ICE_DPLL_LOCK_TRIES; i++) {
>>>>>>>+		if (!test_bit(ICE_FLAG_DPLL, pf->flags)) {
>>>>>>
>>>>>>And again, as I already told you, this flag checking is totally
>>>>>>pointless. See below my comment to ice_dpll_init()/ice_dpll_deinit().
>>>>>>
>>>>>
>>>>>This is not pointless, will explain below.
>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>>[...]
>>>>>
>>>>
>>>>[...]
>>>>
>>>>
>>>>>>>+void ice_dpll_deinit(struct ice_pf *pf)
>>>>>>>+{
>>>>>>>+	bool cgu = ice_is_feature_supported(pf, ICE_F_CGU);
>>>>>>>+
>>>>>>>+	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>>>>>>+		return;
>>>>>>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>>>>>>+
>>>>>>>+	ice_dpll_deinit_pins(pf, cgu);
>>>>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>>>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>>>>>>+	ice_dpll_deinit_info(pf);
>>>>>>>+	if (cgu)
>>>>>>>+		ice_dpll_deinit_worker(pf);
>>>>>>
>>>>>>Could you please order the ice_dpll_deinit() to be symmetrical to
>>>>>>ice_dpll_init()? Then, you can drop ICE_FLAG_DPLL flag entirely, as the
>>>>>>ice_dpll_periodic_work() function is the only reason why you need it
>>>>>>currently.
>>>>>>
>>>>>
>>>>>Not true.
>>>>>The feature flag is common approach in ice. If the feature was
>>>>>successfully
>>>>
>>>>The fact that something is common does not necessarily mean it is
>>>>correct. 0 value argument.
>>>>
>>>
>>>Like using functions that unwrap netlink attributes as unsigned when
>>>they are in fact enums with possibility of being signed?
>>
>>Looks this is bothering you, sorry about that.
>>
>
>Just poining out.
>
>>
>>>
>>>This is about consistent approach in ice driver.
>>>
>>>>
>>>>>initialized the flag is set. It allows to determine if deinit of the
>>>>>feature
>>>>>is required on driver unload.
>>>>>
>>>>>Right now the check for the flag is not only in kworker but also in each
>>>>>callback, if the flag were cleared the data shall be not accessed by
>>>>>callbacks.
>>>>
>>>>Could you please draw me a scenario when this could actually happen?
>>>>It is just a matter of ordering. Unregister dpll device/pins before you
>>>>cleanup the related resources and you don't need this ridiculous flag.
>>>>
>>>
>>>Flag allows to determine if dpll was successfully initialized and do
>>>proper
>>>deinit on rmmod only if it was initialized. That's all.
>>
>>You are not answering my question. I asked about how the flag helps is
>>you do unregister dpll devices/pins and you free related resources in
>>the correct order. Because that is why you claim you need this flag.
>>
>
>I do not claim such thing, actually opposite, I said it helps a bit
>but the reason for existence is different, yet you are still trying to
>imply me this.
>
>>I'm tired of this. Keep your driver tangled for all I care, I'm trying
>>to help you, obviously you are not interested.
>>
>
>With review you are doing great job and many thanks for that.
>
>Already said it multiple times, the main reason of flag existence is not a
>use in the callback but to determine successful dpll initialization.

So use it only for this, nothing else. Use it only to check during
cleanup that you need to do the cleanup as init was previously done.


>As there is no need to call unregister on anything if it was not successfully
>registered.
>
>>
>>>
>>>>
>>>>>I know this is not required, but it helps on loading and unloading the
>>>>>driver,
>>>>>thanks to that, spam of pin-get dump is not slowing the driver
>>>>>load/unload.
>>>>
>>>>? Could you plese draw me a scenario how such thing may actually happen?
>>>
>>>First of all I said it is not required.
>>>
>>>I already draw you this with above sentence.
>>>You need spam pin-get asynchronously and unload driver, what is not clear?
>>>Basically mutex in dpll is a bottleneck, with multiple requests waiting
>>>for
>>>mutex there is low change of driver getting mutex when doing unregisters.
>>
>>How exactly your flag helps you in this scenario? It does not.
>>
>
>In this scenario it helps because it fails the callbacks when dpll subsystem
>was partially initialized and callbacks can be already invoked, but in fact
>the dpll initialization is not yet finished in the driver, and there will always
>be the time between first and second dpll registration where we might wait for
>the mutex to become available on dpll core part.

Draw it to me, please, where exatly there is a problem. I'm still
convinced that with the proper ordering of init/cleanup flows,
you'll get all you need, without any flag use.


>
>>
>>>
>>>We actually need to redesign the mutex in dpll core/netlink, but I guess
>>>after
>>>initial submission.
>>
>>Why?
>>
>
>The global mutex for accessing the data works just fine, but it is slow.
>Maybe we could improve this by using rwlock instead.

"it is slow" is quite vague description of what's wrong with the
locking.


>
>Thank you!
>Arkadiusz
>
>>
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>
>>>>Thanks!
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>>+	mutex_destroy(&pf->dplls.lock);
>>>>>>>+}
>>>>
>>>>
>>>>[...]

