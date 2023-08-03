Return-Path: <netdev+bounces-24062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65F76EA33
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A6B1C21337
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F41F19C;
	Thu,  3 Aug 2023 13:26:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3218B17
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:26:22 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11C273B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:26:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso1205374a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691069176; x=1691673976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsfLa50d0LTbTXWGIG9cWCrDi/9kxGjI71wE6S3Ncd0=;
        b=IoDOJWgnq1g0EZJtytRQIX8dk7lTzTaSp4bYaSLV0C5R85mxcwHWG/Z0hTtTK2HeyJ
         F/PAv+8ZuyKmrnJ4cOs/k4w17cs1tM/jo58yeEHU4SD5xbIt0rX6gVJrvijp4QTncqIJ
         /YRuy98ENiQxc8R3it4TkDdPQl57pGKzfGNs+apma+QzCD8WeX1XU5PepK6Qce5Ku8CG
         Lik2txXBHL9OZYwsR+A1IbsANVCvPOdWpD7dVKSCb3qEW7KpJ9cRowLVAFaypBOZn+W6
         e4D2D/QF704pracRnmkptpthLJ2D3qLjzYXTNJrns85mt/OIYsxiHjhXRoqFavehFCvn
         O0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691069176; x=1691673976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsfLa50d0LTbTXWGIG9cWCrDi/9kxGjI71wE6S3Ncd0=;
        b=g33n9IyCiJWNNWxlEn1zpu0DPDaQQKX5MOltSbLtHAJtKnLXg1YhF982nE7bsB2lUi
         RH1+SE6wEzKzU8RsHHuGcYcVP16jgXpcK3pYFcDOPeEiG8JEjNuGkmsnq8WFv1NjpYim
         s4JfuIL02F8UuyLPNUcGQusswfnpL5RmNquiubEt0m4I8KvwAI3v0b8FUAp/S/ZMgVuC
         Y+PJWqN/EAy96yckXy7KsCZSphIBBKDEpcJBNrTomAYfz63xTR6uv7MqT1dZBEuoDj0/
         ebY/irQs/kf/v9SL5FiInQfnbfYar20qCveLAdZUEcttiOqhTcBTnbkFFs8AspYIDrON
         EgHQ==
X-Gm-Message-State: ABy/qLaSqHZoGmUJFtq38mNAkh/XAyJ2kVohzqkh3k+RMTKY0BA8DI7s
	L2Knxbc0mDjm3RwJGIND1vWgjQ==
X-Google-Smtp-Source: APBJJlHDFRJQKUaRPC6zjQ12Grp104tPB3KJmKbvY+QD51uwRYjZpcZCH1rkAtq5qzoHXh22xgUpug==
X-Received: by 2002:aa7:c0d2:0:b0:522:d6f4:c0eb with SMTP id j18-20020aa7c0d2000000b00522d6f4c0ebmr6632791edp.40.1691069176497;
        Thu, 03 Aug 2023 06:26:16 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056402202900b005223d76a3e3sm10039636edb.85.2023.08.03.06.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:26:15 -0700 (PDT)
Date: Thu, 3 Aug 2023 15:26:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: Block switchdev mode when ADQ is acvite and
 vice versa
Message-ID: <ZMuq9ph8HY6uAiGk@nanopsycho>
References: <20230801115235.67343-1-marcin.szycik@linux.intel.com>
 <20230803131126.GD53714@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803131126.GD53714@unreal>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 03, 2023 at 03:11:26PM CEST, leon@kernel.org wrote:
>On Tue, Aug 01, 2023 at 01:52:35PM +0200, Marcin Szycik wrote:
>> ADQ and switchdev are not supported simultaneously. Enabling both at the
>> same time can result in nullptr dereference.
>> 
>> To prevent this, check if ADQ is active when changing devlink mode to
>> switchdev mode, and check if switchdev is active when enabling ADQ.
>> 
>> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 +++++
>>  drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++++++
>>  2 files changed, 11 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> index ad0a007b7398..2ea5aaceee11 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> @@ -538,6 +538,11 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
>>  		break;
>>  	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>>  	{
>> +		if (ice_is_adq_active(pf)) {
>> +			dev_err(ice_pf_to_dev(pf), "switchdev cannot be configured - ADQ is active. Delete ADQ configs using TC and try again\n");

Does this provide sufficient hint to the user? I mean, what's ADQ and
how it is related to TC objects? Please be more precise.


>
>It needs to be reported through netlink extack.
>
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>  		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
>>  			 pf->hw.pf_id);
>>  		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
>
>Thanks
>

