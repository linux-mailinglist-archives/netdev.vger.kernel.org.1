Return-Path: <netdev+bounces-25151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72C577312C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618CB281582
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41034174FF;
	Mon,  7 Aug 2023 21:25:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542F4435
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:25:35 +0000 (UTC)
Received: from out-111.mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF5EE6A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:25:33 -0700 (PDT)
Message-ID: <a7e2f7e1-e36a-2c79-46c3-874550d24575@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691443530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ru8zGvKg03gqB6GmVvzBu1vOdq2JxR2kLEcmblTX14=;
	b=cuh5B+hMwOeMx7QNFVS1Me32+fiKBNFaaYoRhBeAHBOYKtgOJC0wx/L9rZ7pnd6JWuZsj1
	l8isGq0u03fpSg0CFrSArp3QKInSqeDCSI921ACrN8z0D+4BEti6jYm36NMr6RMffkeg3c
	SZGEAgFggLraPSp2D0F2sqTGJlg0f3g=
Date: Mon, 7 Aug 2023 22:25:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/9] dpll: spec: Add Netlink spec in YAML
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Milena Olech <milena.olech@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com, mschmidt@redhat.com,
 netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org,
 Simon Horman <simon.horman@corigine.com>
References: <20230804190454.394062-1-vadim.fedorenko@linux.dev>
 <20230804190454.394062-3-vadim.fedorenko@linux.dev>
 <ZNCjwfn8MBnx4k6a@nanopsycho>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZNCjwfn8MBnx4k6a@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/08/2023 08:56, Jiri Pirko wrote:
> Fri, Aug 04, 2023 at 09:04:47PM CEST, vadim.fedorenko@linux.dev wrote:
>> Add a protocol spec for DPLL.
>> Add code generated from the spec.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> ---
> 
> Hmm, running tools/net/ynl/ynl-regen.sh generates following diff:
> diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
> index ff3f55f0ca94..638e21a9a06d 100644
> --- a/drivers/dpll/dpll_nl.c
> +++ b/drivers/dpll/dpll_nl.c
> @@ -17,7 +17,6 @@ const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_STATE + 1] =
>   	[DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
>   	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
>   };
> -
>   const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1] = {
>   	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
>   	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index f659fabb1041..18d4fda484e8 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -163,7 +163,6 @@ enum dpll_a {
>   	DPLL_A_PIN_PARENT_DEVICE,
>   	DPLL_A_PIN_PARENT_PIN,
>   
> -	/* private: */
>   	__DPLL_A_MAX,
>   	DPLL_A_MAX = (__DPLL_A_MAX - 1)
>   };
> @@ -182,7 +181,6 @@ enum dpll_cmd {
>   	DPLL_CMD_PIN_DELETE_NTF,
>   	DPLL_CMD_PIN_CHANGE_NTF,
>   
> -	/* private: */
>   	__DPLL_CMD_MAX,
>   	DPLL_CMD_MAX = (__DPLL_CMD_MAX - 1)
>   };
> 
> Do you base this patchset on top of recent net-next? If not, please do
> rebase.
> 

Well, in my case after rebasing on latest net-next I got just part of 
your diff:

diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index ff3f55f0ca94..638e21a9a06d 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -17,7 +17,6 @@ const struct nla_policy 
dpll_pin_parent_device_nl_policy[DPLL_A_PIN_STATE + 1] =
         [DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
         [DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
  };
-
  const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE 
+ 1] = {
         [DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
         [DPLL_A_PIN_ID] = { .type = NLA_U32, },


The "/* private: */" comment was added to the generator after Simon's
comment. But I'll include this part into the next version.

> 
> Other than this, looks fine to me.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

