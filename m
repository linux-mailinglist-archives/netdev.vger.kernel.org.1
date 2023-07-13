Return-Path: <netdev+bounces-17605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8578752539
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781F31C213B0
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D672F9DC;
	Thu, 13 Jul 2023 14:34:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B156FB1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:34:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034A61734;
	Thu, 13 Jul 2023 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1cn7Q6I73HV7gvnlU7oQKxFR3wKoCxsTSAluUNEqkHc=; b=sOgaJ6qdj54VtOsq1KfsidmtDT
	DSiGDNgH4inaB2oU94f3BPqpXBg9phkOiRHg0PNO9Wzexpsofd1PT1A++mo2wAg1AqHEk5lgRwKVN
	jN6xyeGp3xCPzyP7EW1aiESBfhNcch5zQuAS8e/kjm3DrtGgre231nG1T+EA0PWNUsoAVQb6/+WqR
	JPwVj+zA/nGBCHTUuJVmxK0px6hKgwf8gMCDPD6pIpz8b8NwOGXDJorzzBuSlgJWDiHQSfwTmLREJ
	HSeK9beUgz7cDtl5p0iYlCzalxv30mST4xUQlMpX5L/41GqnpgN+BhltBjIFHUnmX9vH3fWtHpl/I
	FDQSYCpg==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qJxOT-003ZqM-0i;
	Thu, 13 Jul 2023 14:34:09 +0000
Message-ID: <d83f5767-a98f-a258-f0c4-e7228345b93f@infradead.org>
Date: Thu, 13 Jul 2023 07:34:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIG5ldCB2MV0gYm5hOkZpeCBlcnJvciBj?=
 =?UTF-8?Q?hecking_for_debugfs=5fcreate=5fdir=28=29?=
Content-Language: en-US
To: =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>
Cc: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru
 <skalluru@marvell.com>,
 "GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krishna Gudipati <kgudipat@brocade.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20230713053823.14898-1-machel@vivo.com>
 <27105f25-f3f9-0856-86e5-86236ce83dee@infradead.org>
 <SG2PR06MB37438F03D13983B7F603E43DBD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <SG2PR06MB37438F03D13983B7F603E43DBD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/13/23 02:05, 王明-软件底层技术部 wrote:
> Ok, so I think we should delete the check operation. What do you think? If it is consistent, I will submit it again
> : )

Yes, that's the idea. Thanks.

> Ming
> -----邮件原件-----
> 发件人: Randy Dunlap <rdunlap@infradead.org> 
> 发送时间: 2023年7月13日 13:50
> 收件人: 王明-软件底层技术部 <machel@vivo.com>; Rasesh Mody <rmody@marvell.com>; Sudarsana Kalluru <skalluru@marvell.com>; GR-Linux-NIC-Dev@marvell.com; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Krishna Gudipati <kgudipat@brocade.com>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> 抄送: opensource.kernel <opensource.kernel@vivo.com>
> 主题: Re: [PATCH net v1] bna:Fix error checking for debugfs_create_dir()
> 
> [Some people who received this message don't often get email from rdunlap@infradead.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi--
> 
> On 7/12/23 22:38, Wang Ming wrote:
>> The debugfs_create_dir() function returns error pointers, it never 
>> returns NULL. Most incorrect error checks were fixed, but the one in 
>> bnad_debugfs_init() was forgotten.
>>
>> Fix the remaining error check.
>>
>> Signed-off-by: Wang Ming <machel@vivo.com>
>>
>> Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")
> 
> Comment from fs/debugfs/inode.c:
> 
>  * NOTE: it's expected that most callers should _ignore_ the errors returned
>  * by this function. Other debugfs functions handle the fact that the "dentry"
>  * passed to them could be an error and they don't crash in that case.
>  * Drivers should generally work fine even if debugfs fails to init anyway.
> 
> so no, drivers should not usually care about debugfs function call results.
> Is there some special case here?
> 
>> ---
>>  drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c 
>> b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
>> index 04ad0f2b9677..678a3668a041 100644
>> --- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
>> +++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
>> @@ -512,7 +512,7 @@ bnad_debugfs_init(struct bnad *bnad)
>>       if (!bnad->port_debugfs_root) {
>>               bnad->port_debugfs_root =
>>                       debugfs_create_dir(name, bna_debugfs_root);
>> -             if (!bnad->port_debugfs_root) {
>> +             if (IS_ERR(bnad->port_debugfs_root)) {
>>                       netdev_warn(bnad->netdev,
>>                                   "debugfs root dir creation failed\n");
>>                       return;
> 
> --
> ~Randy

-- 
~Randy

