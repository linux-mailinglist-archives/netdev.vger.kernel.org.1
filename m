Return-Path: <netdev+bounces-24960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E901772528
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49651C20B66
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848E410789;
	Mon,  7 Aug 2023 13:12:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F90D51D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:12:29 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DFE99
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:12:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31763b2c5a4so3954933f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691413946; x=1692018746;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bomy3/V3wAAoxNY+UmcphSuiy1xq5Utebs+sAgeRu9U=;
        b=Uhgsu3RI+9bgtHJI4nI+VPlgOy3A8PDMTppL+9sNvOD5pdgh6NNtFPqUdF34AGbUSc
         Zw9jfoozafrauNPwFk3vjNQAWbZLr1u0d1WQQStm9dOesGvXJTZykjgYJqKbNvqbZeas
         V7tK9Jkq34DFmG1wjMlnQf07EfXx6qjrJ5Bco7Bm9FXNqMud8U18HqEGAYSY8Ct6GGAl
         Xm2CBouaxSY+HjVzdDX4MV6xbbE5crZZCyYTy/gIdQ50nV5m2VFLn0OnjkqgmihFGcef
         oKqI/3u7gwCbbfLk8FLtySoqC2cmOtsAdHv4s7mOKmBzsUJO6vFR8RKzvD2qVSDyeWGy
         QhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413946; x=1692018746;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bomy3/V3wAAoxNY+UmcphSuiy1xq5Utebs+sAgeRu9U=;
        b=EFoV+4+VRWAS97DNZhr7AV7UNLXvew1OsoSDNBLNAnybx53JKEGsViV/bn6MB5YQv3
         Vu87sclemgO6I4N4kHL3cgDg0Ip8lujQv2vCPSTw8GutqVDNoU4LcThCP54nJ8aCiPX7
         7KsclYrJs7U03PJLybL+/iWqT5QLMUVxMFIHYSgdWH6BTUnrJgHCjDqey/fTFbLi2PY0
         a/k92UUnqlxXcS4R6MNW08XrZZVIpYS6B1QZ5uOMVGZka73+xoSdjuV7JkBYbtqN35ZV
         L8O0hG3Of239ceVozv9vIqbKZsn/1ZPl6qOWngXu1rw80EQRPDqBXoT7JuQWN0oaXFK1
         E6qg==
X-Gm-Message-State: AOJu0YzFg0jH186PcfaW4wtN1nZCZRYGzbTBNekYkCwGKUkvdS/f3z67
	pwTWIBDXx9gSJ9TAPJJtALw=
X-Google-Smtp-Source: AGHT+IETSTyM21LqrfC0b5qGAkIJug4nlvhbcLcxrZYEUa7sKU9UcWWZJTSrh31rteamjlpP/kU1Dw==
X-Received: by 2002:a5d:4f0e:0:b0:317:5ddd:837b with SMTP id c14-20020a5d4f0e000000b003175ddd837bmr6177170wru.7.1691413946045;
        Mon, 07 Aug 2023 06:12:26 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id s9-20020adfecc9000000b0031416362e23sm10608099wro.3.2023.08.07.06.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 06:12:25 -0700 (PDT)
Subject: Re: [PATCH net-next 7/7] sfc: offload left-hand side rules for
 conntrack
To: Simon Horman <horms@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
References: <cover.1691063675.git.ecree.xilinx@gmail.com>
 <9794c4fd9a32138fb5b30c7b4944f4b09e026ac2.1691063676.git.ecree.xilinx@gmail.com>
 <ZM0Ac2MZxamaS0bG@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <a6510880-1617-84e7-f5f2-e417feb65285@gmail.com>
Date: Mon, 7 Aug 2023 14:12:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZM0Ac2MZxamaS0bG@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/08/2023 14:43, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 12:56:23PM +0100, edward.cree@amd.com wrote:
> 
> ...
> 
>> +static bool efx_tc_rule_is_lhs_rule(struct flow_rule *fr,
>> +				    struct efx_tc_match *match)
>> +{
>> +	const struct flow_action_entry *fa;
>> +	int i;
>> +
>> +	flow_action_for_each(i, fa, &fr->action) {
>> +		switch (fa->id) {
>> +		case FLOW_ACTION_GOTO:
>> +			return true;
>> +		case FLOW_ACTION_CT:
>> +			/* If rule is -trk, or doesn't mention trk at all, then
>> +			 * a CT action implies a conntrack lookup (hence it's an
>> +			 * LHS rule).  If rule is +trk, then a CT action could
>> +			 * just be ct(nat) or even ct(commit) (though the latter
>> +			 * can't be offloaded).
>> +			 */
>> +			if (!match->mask.ct_state_trk || !match->value.ct_state_trk)
>> +				return true;
> 
> Hi Ed,
> 
> I think that to keep static analysers happy there ought to be a
> break statement, or a fallthrough annotation here.

Yeah, I see on patchwork that clang complained about this.
Since the fallthrough is only into a break statement (which is
 presumably why gcc doesn't mind), I'll just add a break here.

> Otherwise the series looks good to me.

Thanks, will respin v2 shortly with your tag included.

