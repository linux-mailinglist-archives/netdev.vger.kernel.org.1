Return-Path: <netdev+bounces-42729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C4B7CFFAE
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680041F23DD1
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CC1225C8;
	Thu, 19 Oct 2023 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsKSQJsz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256532C70
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 16:35:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AED114
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697733327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A0TxOuArDcomwzRpdOzuputQGYUhRrujAZgHVzm3P74=;
	b=WsKSQJszxnMVRX6s9irBGTyPfxFMT+Qh31MiMMKL4NcavttMzSgY04nNj7lHD462I+vyxs
	bV6Hp/bmXuLfi4DLKZc2RasakOz/5H0cd51VO14TXj+Z+/YqosRWLaovIwWaLT15VbTbPM
	PO6x4S0Y46p7whUSCvs37YP4Tsfy4Ow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-QnnxGI2yNW6TXlgwbkvJMQ-1; Thu, 19 Oct 2023 12:35:22 -0400
X-MC-Unique: QnnxGI2yNW6TXlgwbkvJMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C62E88CC4B;
	Thu, 19 Oct 2023 16:35:22 +0000 (UTC)
Received: from [10.45.226.105] (unknown [10.45.226.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8CEF22026D4C;
	Thu, 19 Oct 2023 16:35:19 +0000 (UTC)
Message-ID: <3f12a532-a0f9-4a7e-bfda-c85b539b81d0@redhat.com>
Date: Thu, 19 Oct 2023 18:35:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Mateusz Palczewski
 <mateusz.palczewski@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20231018112621.463893-1-ivecera@redhat.com>
 <20231019091408.GA2100445@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20231019091408.GA2100445@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4



On 19. 10. 23 11:15, Simon Horman wrote:
> On Wed, Oct 18, 2023 at 01:26:20PM +0200, Ivan Vecera wrote:
>> Commit c87c938f62d8f1 ("i40e: Add VF VLAN pruning") added new
>> PF flag I40E_FLAG_VF_VLAN_PRUNING but its value collides with
>> existing I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED flag.
>>
>> Move the affected flag at the end of the flags and fix its value.
>>
>> Cc: Mateusz Palczewski <mateusz.palczewski@intel.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> Hi Ivan,
> 
> I agree with the correctness of this patch and that it was
> introduced by the cited commit.
> 
> However, I do wonder if, as a fix for 'net':
> 
> 1) The patch description could include some discussion of
>     what problem is resolved, and, ideally, how I user might
>     get into such a situation.
> 
> 2) The following fixes tag is appropriate.
> 
> Fixes: c87c938f62d8 ("i40e: Add VF VLAN pruning")
> 
Ahh, thanks Simon! I forgot to add Fixes: tag.

Will fix it by v2 and add the reproducer.

Thanks,
Ivan


