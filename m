Return-Path: <netdev+bounces-17754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5FD752F9F
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A354D280FB8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02A7EB;
	Fri, 14 Jul 2023 02:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CDED0
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:57:01 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D116198A;
	Thu, 13 Jul 2023 19:56:59 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R2GKR2KRlzLnmC;
	Fri, 14 Jul 2023 10:54:35 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:56:56 +0800
Message-ID: <3d5a0d6c-1dcd-7a0d-1f5c-a38e0e15fd85@huawei.com>
Date: Fri, 14 Jul 2023 10:56:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net 2/3] selftests: tc: add 'ct' action kconfig dep
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>, Kees Cook
	<keescook@chromium.org>, "David S. Miller" <davem@davemloft.net>, Paul Blakey
	<paulb@mellanox.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	<mptcp@lists.linux.dev>
CC: Pedro Tammela <pctammela@mojatatu.com>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
 <20230713-tc-selftests-lkft-v1-2-1eb4fd3a96e7@tessares.net>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20230713-tc-selftests-lkft-v1-2-1eb4fd3a96e7@tessares.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/14 5:16, Matthieu Baerts wrote:
> When looking for something else in LKFT reports [1], I noticed most of
> the tests were skipped because the "teardown stage" did not complete
> successfully.
> 
> Pedro found out this is due to the fact CONFIG_NF_FLOW_TABLE is required
> but not listed in the 'config' file. Adding it to the list fixes the
> issues on LKFT side. CONFIG_NET_ACT_CT is now set to 'm' in the final
> kconfig.
> 
> Fixes: c34b961a2492 ("net/sched: act_ct: Create nf flow table per zone")
> Cc: stable@vger.kernel.org
> Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
> Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
> Suggested-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>   tools/testing/selftests/tc-testing/config | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
> index 6e73b09c20c8..d1ad29040c02 100644
> --- a/tools/testing/selftests/tc-testing/config
> +++ b/tools/testing/selftests/tc-testing/config
> @@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
>   CONFIG_NF_CONNTRACK_MARK=y
>   CONFIG_NF_CONNTRACK_ZONES=y
>   CONFIG_NF_CONNTRACK_LABELS=y
> +CONFIG_NF_FLOW_TABLE=m
>   CONFIG_NF_NAT=m
>   CONFIG_NETFILTER_XT_TARGET_LOG=m
>   
> 

Tested-by: Zhengchao Shao <shaozhengchao@huawei.com>

