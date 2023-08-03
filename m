Return-Path: <netdev+bounces-24233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DDC76F61A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 01:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7085E1C216E5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30626B0E;
	Thu,  3 Aug 2023 23:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ECC26B0B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 23:20:59 +0000 (UTC)
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B19EA2
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:20:58 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTP
	id RZnpq6Wf0QFHRRhcnq44uB; Thu, 03 Aug 2023 23:20:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RhcnqsD8UKJKARhcnqMrw0; Thu, 03 Aug 2023 23:20:57 +0000
X-Authority-Analysis: v=2.4 cv=E9reGIRl c=1 sm=1 tr=0 ts=64cc3659
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=jrvim2RH1L3wMXzH:21 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10
 a=_Wotqz80AAAA:8 a=skJPDk5bIpxW11t4dXAA:9 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=HTSSj-r2zjXQe2K4smQw:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=erNX2FTnzylJt1ql2OiFdFxnD1PfSsmi+UlFClAcMRM=; b=XsoLxrPRms200SG0tJzd700Dzg
	A1vbkNccXm8Fhox1RC9UbHd/lZXzyBjZa+ojauuRJDzaCHYJPugoVzibyNLyR1Gq/8gqcpsjdl03q
	RFSLDTXc6AgDtjkXKZ8BGq4NzaUl9cmuy9wL4XatMVdegiMZ6MunKHb5Pwia7wGJs4GKSX1CQHsGs
	FUeTNEl7Sr6ENyQ4i41Vh1PE8vn/zqDmVNAG0hjHju0kr3ncyklrhxWMgNR0HyKvitHAscObp3xNT
	PxseFjcY6hcvBQGD0K4uI0UrKtcPuZps8ZHY/HE9JOw4BbRuWWn+BPmqnZLpWlLNWQjGZFHvkcxio
	aqhvRzGg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:50214 helo=[192.168.15.8])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qReeM-0029Vv-0u;
	Thu, 03 Aug 2023 15:10:22 -0500
Message-ID: <31a6821b-1eb0-abf9-6ede-549b158e8232@embeddedor.com>
Date: Thu, 3 Aug 2023 14:11:28 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/2] eth: bnxt: fix one of the W=1 warnings about
 fortified memcpy()
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20230727190726.1859515-1-kuba@kernel.org>
 <20230727190726.1859515-2-kuba@kernel.org>
 <58c12dc4-87e2-5c91-5744-27777acfa631@embeddedor.com>
 <20230803072123.1fbd56db@kernel.org>
 <CACKFLinikvXmKcxr4kjWO9TPYxTd2cb5agT1j=w9Qyj5-24s5A@mail.gmail.com>
 <c332844d-d0d9-8443-b119-3943532c15d1@embeddedor.com>
 <CACKFLinNnw033RFYfbX_nfkKJKSGd2RJ=kPx8aPocy2=M1CddQ@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CACKFLinNnw033RFYfbX_nfkKJKSGd2RJ=kPx8aPocy2=M1CddQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qReeM-0029Vv-0u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:50214
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAIqjFGUZYFL3Tc/LYxBrBJxjX9mQ3ZY4rlOMF8ZwkrPEeAlSVmzRZ+2tFpoNnLSYW/YSMhW66DLDaoE66ceVDRUScKv49jtTz/LiPqKYrSZNYos6iS+
 CFm+YTdgPI+FPBP+tzJsvxRWh+gwOWWdYb6UmZ0WrD6hB8oUx/5cg6PoD8st8dttD4sJaC+Qd6KnR2EcSMjMd290tHkQB89I2FA=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 14:04, Michael Chan wrote:
> On Thu, Aug 3, 2023 at 12:58 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>>
>>
>> On 8/3/23 08:46, Michael Chan wrote:
>>>
>>> The way I plan to fix this is to change the auto-generated struct
>>> hwrm_queue_cos2bw_qcfg_output to have an array of substruct.  I think
>>> that will look the cleanest.  I'll post it later today or tomorrow.
>>
>> Will that also fix the -Wstringop-overflow warning I mentioned in my
>> previous reply?
>>
>> drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:133:17: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]
>>
> 
> Yes, I will fix the other similar struct hwrm_queue_cos2bw_cfg_input
> in a similar way with an array of substruct.  Thanks.

Awesome! :)

Thank you
--
Gustavo

