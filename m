Return-Path: <netdev+bounces-24163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E076F0D1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD242822B6
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8E2419C;
	Thu,  3 Aug 2023 17:44:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FD24190
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 17:44:02 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70254139
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 10:43:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so12536835e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691084635; x=1691689435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Io7mQTC7u4TMkvW7liLcAJzZyli7X14Wo5yp9Zcv/ck=;
        b=Cb3LtfP8TOWjRvBUCv9dFJns9DPK8qUrY9qqw+Ub9jScKInJoo6afAViNN5pgcQtsS
         nPXjvf2gxnrlxfoVrsbD83bhVzRQECaiYPAZn0wEdRE6ggozX4fRJmse6mBDWFOwyuZZ
         Ga/WVr0CcDe3SN0rqJQF7WWrjqOg6PEZEpalhgVWn0c7lJQYEK4T/LC2TuajG22E4FQn
         lwnYk++RpMOhqHPOcqS9Yg/uXa4JR03bnKkqpM4Q1yBDvEfCHxaH8DCdy/hd5aDdCe1k
         6IlaGleXY3SAKklfUH/oxtWHst6idHHY/ekPlObAiKwj9Zdqa0zt67d/gTypNV/Sedma
         PXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691084635; x=1691689435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io7mQTC7u4TMkvW7liLcAJzZyli7X14Wo5yp9Zcv/ck=;
        b=TzU3fJdY4XvLXbpycfqK3/sk8pJjzG6bFq21O9m/hVMvkjI/g09fBg+tFDoDZXu4L+
         wVYDHrzc9qg9dxEHXoaFVNH0PBpXKnJLZe9xLpNA1p+7X3VCioD/o7EALA+ssJ0UmEW4
         OIVeMqahShkLrFL3OPypRSGZNLvVPE4B/pnCzScMUwZrca2II7IpKGuRPvwiLPlCVgOT
         1sp/hTp8eYh+Vev9qdlSnVdfzFaWbT2ottwmn1Tob5OOAviDAmGMK19rYJj4XevC3W40
         1tZPR+htbFieNRCZbE+GvARI8VnK+311PAIomX9jHfeS/Xhj02ccsObJa8yJvAxchg5c
         ZaIQ==
X-Gm-Message-State: ABy/qLYkVaPENvAXzUtylsqruPB1WcUj10XFgpuPD/m0WPrmrWXVv9FN
	HkYCWQoSnVuNi5ZKr2BuWJp0v5m6oZ1tXa5VIowwgxyX
X-Google-Smtp-Source: APBJJlHd2CXTasjwVIRtla9qRgzSufHmd1/PKnldS+Y0B5CKOM7CBU2XoOXRoMAj4v/vKI9MMsJQPw==
X-Received: by 2002:adf:fd8b:0:b0:314:3ca0:c8c2 with SMTP id d11-20020adffd8b000000b003143ca0c8c2mr8146003wrr.11.1691084634834;
        Thu, 03 Aug 2023 10:43:54 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id y16-20020adff150000000b0031762e89f94sm382920wro.117.2023.08.03.10.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 10:43:53 -0700 (PDT)
Date: Thu, 3 Aug 2023 19:43:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: Block switchdev mode when ADQ is acvite and
 vice versa
Message-ID: <ZMvnWIhrpOJA8bG+@nanopsycho>
References: <20230801115235.67343-1-marcin.szycik@linux.intel.com>
 <20230803131126.GD53714@unreal>
 <ZMuq9ph8HY6uAiGk@nanopsycho>
 <457944e2-c8bc-74a7-ec5b-4502c4ec2664@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457944e2-c8bc-74a7-ec5b-4502c4ec2664@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 03, 2023 at 05:11:16PM CEST, marcin.szycik@linux.intel.com wrote:
>
>
>On 03.08.2023 15:26, Jiri Pirko wrote:
>> Thu, Aug 03, 2023 at 03:11:26PM CEST, leon@kernel.org wrote:
>>> On Tue, Aug 01, 2023 at 01:52:35PM +0200, Marcin Szycik wrote:
>>>> ADQ and switchdev are not supported simultaneously. Enabling both at the
>>>> same time can result in nullptr dereference.
>>>>
>>>> To prevent this, check if ADQ is active when changing devlink mode to
>>>> switchdev mode, and check if switchdev is active when enabling ADQ.
>>>>
>>>> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
>>>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>>> ---
>>>>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 +++++
>>>>  drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++++++
>>>>  2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>>>> index ad0a007b7398..2ea5aaceee11 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>>>> @@ -538,6 +538,11 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
>>>>  		break;
>>>>  	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>>>>  	{
>>>> +		if (ice_is_adq_active(pf)) {
>>>> +			dev_err(ice_pf_to_dev(pf), "switchdev cannot be configured - ADQ is active. Delete ADQ configs using TC and try again\n");
>> 
>> Does this provide sufficient hint to the user? I mean, what's ADQ and
>> how it is related to TC objects? Please be more precise.
>
>Application Device Queues, a conflicting feature unrelated to switchdev.
>If it's enabled, there's a good chance the user knows what it is because
>they configured it.
>
>Could you suggest a better error message?

The user would need to know what he needs to do in order to make this
work. So it would be nice to hint what rules need to be removed.

>
>> 
>> 
>>>
>>> It needs to be reported through netlink extack.
>>>
>>>> +			return -EOPNOTSUPP;
>>>> +		}
>>>> +
>>>>  		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
>>>>  			 pf->hw.pf_id);
>>>>  		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
>>>
>>> Thanks
>>>
>> 
>
>Regards,
>Marcin

