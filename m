Return-Path: <netdev+bounces-44195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65A7D6EDE
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15008281CF3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAAD273E4;
	Wed, 25 Oct 2023 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA6Lk5b6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3328E28
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:39:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5F6196
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698244764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKSNaHDd6rmGllCi23XMfucJBxxGAMgO6JLoDnVZ6/0=;
	b=ZA6Lk5b6uiQk08Sp59KZut6MBbDV9h/M7Qlwx8xHj01h3j6Lhh5S7KbOWMIRu34uaZPLIR
	6gIAyuHopw5p7k3qSIMsXZHlqGz3WQ9ohmVpvf7SIui9aBAa5uNpdNbGa601LQWsHLvpA9
	bZs2JHtvbhsffCxvXJZjcbCABn9GigQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-uGjaI0IbPZiTFloVzjgFZA-1; Wed, 25 Oct 2023 10:39:20 -0400
X-MC-Unique: uGjaI0IbPZiTFloVzjgFZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4A3788D140;
	Wed, 25 Oct 2023 14:39:18 +0000 (UTC)
Received: from [10.45.225.62] (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 619A0492BFA;
	Wed, 25 Oct 2023 14:39:17 +0000 (UTC)
Message-ID: <cbb2e9f4-03f8-4a46-99e4-e952bb754a2f@redhat.com>
Date: Wed, 25 Oct 2023 16:39:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
 <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10



On 25. 10. 23 12:48, Wojciech Drewek wrote:
> 
> On 25.10.2023 12:33, Ivan Vecera wrote:
>> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
>> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
>> i40e_adminq_init_regs() and remove enums for these VF MAC types.
>>
>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>>   drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>>   2 files changed, 10 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> index 29fc46abf690..896c43905309 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> @@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
>>   static void i40e_adminq_init_regs(struct i40e_hw *hw)
>>   {
>>   	/* set head and tail registers in our local struct */
>> -	if (i40e_is_vf(hw)) {
>> -		hw->aq.asq.tail = I40E_VF_ATQT1;
>> -		hw->aq.asq.head = I40E_VF_ATQH1;
>> -		hw->aq.asq.len  = I40E_VF_ATQLEN1;
>> -		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
>> -		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
>> -		hw->aq.arq.tail = I40E_VF_ARQT1;
>> -		hw->aq.arq.head = I40E_VF_ARQH1;
>> -		hw->aq.arq.len  = I40E_VF_ARQLEN1;
>> -		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
>> -		hw->aq.arq.bah  = I40E_VF_ARQBAH1;
> What about removing those I40E_VF_* defines?
> This is their only usage here, right?

Yes, do you want to remove them in this patch? Or follow-up is sufficient?

Ivan


