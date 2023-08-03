Return-Path: <netdev+bounces-24206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ABC76F3B8
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7958128217F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F0B2593C;
	Thu,  3 Aug 2023 19:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1363BC
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 19:58:28 +0000 (UTC)
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96342420F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 12:58:26 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTP
	id RZnpqiQ5zEoVsReSnqPoeb; Thu, 03 Aug 2023 19:58:26 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ReSnqp40UKJKAReSnqK30f; Thu, 03 Aug 2023 19:58:25 +0000
X-Authority-Analysis: v=2.4 cv=E9reGIRl c=1 sm=1 tr=0 ts=64cc06e1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=jrvim2RH1L3wMXzH:21 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10
 a=nOJuxIDNmBreB4syKN0A:9 a=QEXdDO2ut3YA:10 a=HTSSj-r2zjXQe2K4smQw:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jWguheqDRFk5ih57FOhs7hR8F8ynpVmSMPNMK7J4pks=; b=IgSMGjszOK21o+fsP3lRpJU/Ac
	aD3ll1ltbgH9c8fL3mKv/GI83ZFaSukEZZmhabwvRm7K+ytX3pk8VYxJ7Dg4gfu16tHmiYfbwpFLl
	9vh6qFxe5P83alkhPriJp1W4bponvk/FghBzlWxlJiTaBNtHvY0Gf8c8kTClQA9HDABsqyuZxrum4
	J8WU0Rq+McTC7Ejw3OmO4uTDQ3SpbmJ1aTEDQTygskiCP7nd9PGts6vSuNDft2t5xO7ySVuiHjsNa
	7sC8PyAXWrVr8k7dZCQ7jL475wqPlkG/GjKgAfkthuzz0UNj48YJCH7MA+uh9U7PS7y/g/2kDorxA
	qfu8YUqw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:43556 helo=[192.168.15.8])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qReSm-001vr8-1j;
	Thu, 03 Aug 2023 14:58:24 -0500
Message-ID: <c332844d-d0d9-8443-b119-3943532c15d1@embeddedor.com>
Date: Thu, 3 Aug 2023 13:59:30 -0600
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
To: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
References: <20230727190726.1859515-1-kuba@kernel.org>
 <20230727190726.1859515-2-kuba@kernel.org>
 <58c12dc4-87e2-5c91-5744-27777acfa631@embeddedor.com>
 <20230803072123.1fbd56db@kernel.org>
 <CACKFLinikvXmKcxr4kjWO9TPYxTd2cb5agT1j=w9Qyj5-24s5A@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CACKFLinikvXmKcxr4kjWO9TPYxTd2cb5agT1j=w9Qyj5-24s5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qReSm-001vr8-1j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:43556
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHYb1wwsFlho6dbhEpGQ+wy0AeQqoNgIg/HGbYHysciU/Hwv2uh5W6OQF3tq49PFUspepZvD+a5Xrms5lJGWIWNgPhkT2VeLZmCrjequckWEMFsePwXi
 UozFajpMM/vvAE5/otUN9LKYjxWwivZ82PD3el81KDcMPMIxJ81KtvzYd7aFgC7jGICEQaOZTdXrXh6yrDJTp2v2grBBEKSil1E=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 08:46, Michael Chan wrote:
> 
> The way I plan to fix this is to change the auto-generated struct
> hwrm_queue_cos2bw_qcfg_output to have an array of substruct.  I think
> that will look the cleanest.  I'll post it later today or tomorrow.

Will that also fix the -Wstringop-overflow warning I mentioned in my
previous reply?

drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:133:17: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]

--
Gustavo


