Return-Path: <netdev+bounces-19845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D5975C93F
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EF61C2098E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318CD1E53A;
	Fri, 21 Jul 2023 14:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269061EA66
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:10:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCF2D50
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689948638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLR1KIDJDJPKL5gVajVFRvk+rmdQhGE0FkmlDu8zRd0=;
	b=I86FuqM4Kdfnj3LSgPK8QKJWSENeJv4YZoar58s4N3OGcjXUjDtzfK3eXh2J5VS8VnpVz/
	I1W/RuoeQunndXDY9O9M7oyCxwgEBKvKB9ArlYj/AlPsQv7iVtp/CnLHPkUus+xD4qM5aw
	SmCJ0Eqrk2aJOSVJUt/ujDdpWAL4OT4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-d0hHnyTdMru7up4omFgDcg-1; Fri, 21 Jul 2023 10:10:35 -0400
X-MC-Unique: d0hHnyTdMru7up4omFgDcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3FBF858EED;
	Fri, 21 Jul 2023 14:10:34 +0000 (UTC)
Received: from [10.45.225.111] (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1000BC584E0;
	Fri, 21 Jul 2023 14:10:33 +0000 (UTC)
Message-ID: <a9cdd1b9-c10d-ace1-7d60-ab98d24d1eb7@redhat.com>
Date: Fri, 21 Jul 2023 16:10:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 0/2][pull request] Intel Wired LAN Driver
 Updates 2023-07-14 (i40e)
To: Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, netdev@vger.kernel.org
References: <20230714201253.1717957-1-anthony.l.nguyen@intel.com>
 <8261532fc0923d3cd9a8937e66c2e8c7e2e1d3b2.camel@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <8261532fc0923d3cd9a8937e66c2e8c7e2e1d3b2.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 18. 07. 23 12:14, Paolo Abeni wrote:
> Hi,
> 
> On Fri, 2023-07-14 at 13:12 -0700, Tony Nguyen wrote:
>> This series contains updates to i40e driver only.
>>
>> Ivan Vecera adds waiting for VF to complete initialization on VF related
>> configuration callbacks.
>>
>> The following are changes since commit 68af900072c157c0cdce0256968edd15067e1e5a:
>>    gve: trivial spell fix Recive to Receive
>> and are available in the git repository at:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE
>>
>> Ivan Vecera (2):
>>    i40e: Add helper for VF inited state check with timeout
>>    i40e: Wait for pending VF reset in VF set callbacks
>>
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 65 +++++++++++--------
>>   1 file changed, 38 insertions(+), 27 deletions(-)
>>
> The series LGTM, but is targeting net-next while it looks like -net
> material to me (except for the missing Fixes tag ;). Am I missing
> something? Could you please clarify?
> 
> Thanks!
> 
> Paolo

Next is the fine... You are right there are no Fixes tags as there are 
no such commits. So I have selected -next.

Ivan


