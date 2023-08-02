Return-Path: <netdev+bounces-23530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8879176C5F6
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9D91C211A4
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B51865;
	Wed,  2 Aug 2023 06:57:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC3D46AC
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:57:49 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4CF2102
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:57:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5222a38c0a0so9443794a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690959444; x=1691564244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HB8Dw00DZJ09mEmQijXfQQXA6sfh5AwCygh3j6F8AMc=;
        b=lSzUBF6FWUxiw1oYdULIQmYbEwENFVJmgp4JHBGx1zI7B5KvQ4m1+HYCR3R505SGO+
         Slnm+NLgpdt03o6b0L5LjdOksh6iuX/NfrVTmTR1r3wSyzLm1ZvZhs8JTUP/R0HGnXbt
         +dId+PmCsdS9AeXUfXfuzB7uBR58pYzFlr4jLqg6SD6WkBW0X7fzWbq6Ap51X5SrY7f8
         26Rfid8Vp4WklhfLbP86W/a8mULDm3JgxVAUpRVulNg8v5IMCFqe9SbxU29Q2s2n5LbS
         BJ3qf3Q9gDvbLHRTwsNp/N0vzDrst27eU4f2XDPFe7aEPvC8jqnd3eLXFIifyDzPf3/W
         8l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959444; x=1691564244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB8Dw00DZJ09mEmQijXfQQXA6sfh5AwCygh3j6F8AMc=;
        b=Ug/LXrN9z/ulon1eSt+Vq8Ut8QKK/nwKupjUV8gsc86WIgvyOJsrwaDIVpEPsbcGpm
         Cnmqf/tFIukPfmAQZeTumvlt5C7uYiEG0wJhxCEKrG1HqQTOt/fl38wJQR1XW29WG+zC
         h7E0sflBksOXCBXORQXqFUBpBfnmaYT3cczaTrN/FJHJTAPKOMoCLndhz4/BKhmyoWRZ
         vdIs7Ynj3u/FzZHdxp2jujmfGIvzGC00hQMSFkuz/5LhxfQoWHbwKt0PGVV1znzCty2d
         /jaGJ+873Gfh6k8gw9vlOIu6dFjweh8Y091wvNzPWYo2WTqyEh/MnDukyNH2TnDEx6jt
         p19A==
X-Gm-Message-State: ABy/qLYk6pxfu7w3aGh9S6xyjG4ahYfmPsXQrUPM5SrJonEP5YCu/0sv
	y9oiRHRV4fk/JuK9uhQWay/O+Q==
X-Google-Smtp-Source: APBJJlGatQfPGX1zCA4O2oVLRP7VUG8QpcwUx9/zHINaPrjjZYEd6cJWoVD2Oc2hkHgdGZY7lcZQvQ==
X-Received: by 2002:a17:906:3198:b0:98e:1156:1a35 with SMTP id 24-20020a170906319800b0098e11561a35mr3703590ejy.74.1690959444201;
        Tue, 01 Aug 2023 23:57:24 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id mb5-20020a170906eb0500b00997cce73cc7sm8598409ejb.29.2023.08.01.23.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:57:23 -0700 (PDT)
Date: Wed, 2 Aug 2023 08:57:22 +0200
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
Message-ID: <ZMn+Uvu8B6IcCFoj@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLpuaxMJ+8rWAPwi@nanopsycho>
 <DM6PR11MB46571657F0DF87765DAB32FE9B06A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMem35OUQiQmB9Vd@nanopsycho>
 <DM6PR11MB4657C0DA91583D92697324BC9B0AA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657C0DA91583D92697324BC9B0AA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 01, 2023 at 04:50:44PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Monday, July 31, 2023 2:20 PM
>>
>>Sat, Jul 29, 2023 at 01:03:59AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Friday, July 21, 2023 1:39 PM
>>>>
>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>
>>
>>[...]
>>
>>
>>>>>+static int ice_dpll_cb_lock(struct ice_pf *pf, struct netlink_ext_ack
>>>>>*extack)
>>>>>+{
>>>>>+	int i;
>>>>>+
>>>>>+	for (i = 0; i < ICE_DPLL_LOCK_TRIES; i++) {
>>>>>+		if (!test_bit(ICE_FLAG_DPLL, pf->flags)) {
>>>>
>>>>And again, as I already told you, this flag checking is totally
>>>>pointless. See below my comment to ice_dpll_init()/ice_dpll_deinit().
>>>>
>>>
>>>This is not pointless, will explain below.
>>>
>>>>
>>>>
>>>
>>>[...]
>>>
>>
>>[...]
>>
>>
>>>>>+void ice_dpll_deinit(struct ice_pf *pf)
>>>>>+{
>>>>>+	bool cgu = ice_is_feature_supported(pf, ICE_F_CGU);
>>>>>+
>>>>>+	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>>>>+		return;
>>>>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>>>>+
>>>>>+	ice_dpll_deinit_pins(pf, cgu);
>>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>>>>+	ice_dpll_deinit_info(pf);
>>>>>+	if (cgu)
>>>>>+		ice_dpll_deinit_worker(pf);
>>>>
>>>>Could you please order the ice_dpll_deinit() to be symmetrical to
>>>>ice_dpll_init()? Then, you can drop ICE_FLAG_DPLL flag entirely, as the
>>>>ice_dpll_periodic_work() function is the only reason why you need it
>>>>currently.
>>>>
>>>
>>>Not true.
>>>The feature flag is common approach in ice. If the feature was successfully
>>
>>The fact that something is common does not necessarily mean it is
>>correct. 0 value argument.
>>
>
>Like using functions that unwrap netlink attributes as unsigned when
>they are in fact enums with possibility of being signed?

Looks this is bothering you, sorry about that.


>
>This is about consistent approach in ice driver.
>
>>
>>>initialized the flag is set. It allows to determine if deinit of the feature
>>>is required on driver unload.
>>>
>>>Right now the check for the flag is not only in kworker but also in each
>>>callback, if the flag were cleared the data shall be not accessed by
>>>callbacks.
>>
>>Could you please draw me a scenario when this could actually happen?
>>It is just a matter of ordering. Unregister dpll device/pins before you
>>cleanup the related resources and you don't need this ridiculous flag.
>>
>
>Flag allows to determine if dpll was successfully initialized and do proper
>deinit on rmmod only if it was initialized. That's all.

You are not answering my question. I asked about how the flag helps is
you do unregister dpll devices/pins and you free related resources in
the correct order. Because that is why you claim you need this flag.

I'm tired of this. Keep your driver tangled for all I care, I'm trying
to help you, obviously you are not interested.


>
>>
>>>I know this is not required, but it helps on loading and unloading the
>>>driver,
>>>thanks to that, spam of pin-get dump is not slowing the driver
>>>load/unload.
>>
>>? Could you plese draw me a scenario how such thing may actually happen?
>
>First of all I said it is not required.
>
>I already draw you this with above sentence.
>You need spam pin-get asynchronously and unload driver, what is not clear?
>Basically mutex in dpll is a bottleneck, with multiple requests waiting for
>mutex there is low change of driver getting mutex when doing unregisters.

How exactly your flag helps you in this scenario? It does not.


>
>We actually need to redesign the mutex in dpll core/netlink, but I guess after
>initial submission.

Why?


>
>Thank you!
>Arkadiusz
>
>>
>>Thanks!
>>
>>
>>>
>>>>
>>>>>+	mutex_destroy(&pf->dplls.lock);
>>>>>+}
>>
>>
>>[...]

