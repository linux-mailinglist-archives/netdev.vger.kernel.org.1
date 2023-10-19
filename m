Return-Path: <netdev+bounces-42728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E957CFFAA
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE19B210EC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103B225B0;
	Thu, 19 Oct 2023 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXeG2e1W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57A32C72
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 16:34:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA77114
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 09:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697733246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6E1CxE28rwmvHmrmBaqAZc7hemqiqtzus/CxVrqL/Sc=;
	b=UXeG2e1WvyvqcQfgifTcgewYYek6IQvwcGfkQ8mh8DB9i1rJzxPF+dq11e0yWZOQfKSZ8P
	qSeDsZYr2Hpileqg9O2H/PGIolBvHMei1PsZ1+yeiFRJjJD7F0yeH4u7+knLtzea2Q7jBn
	/EucRysPKhDLhud42RG7whYMPu9c4gY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-3Ma3c47kOIGexr4gLson0Q-1; Thu, 19 Oct 2023 12:34:03 -0400
X-MC-Unique: 3Ma3c47kOIGexr4gLson0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AFBB10201F3;
	Thu, 19 Oct 2023 16:34:02 +0000 (UTC)
Received: from [10.45.226.105] (unknown [10.45.226.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 776832026D4C;
	Thu, 19 Oct 2023 16:34:01 +0000 (UTC)
Message-ID: <cda1cc98-7c0e-4712-830a-9ba0bfeb951c@redhat.com>
Date: Thu, 19 Oct 2023 18:34:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] iavf: delete unused iavf_mac_info fields
Content-Language: en-US
To: Michal Schmidt <mschmidt@redhat.com>,
 "Drewek, Wojciech" <wojciech.drewek@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231018111527.78194-1-mschmidt@redhat.com>
 <MW4PR11MB577642AB058202687D511502FDD5A@MW4PR11MB5776.namprd11.prod.outlook.com>
 <CADEbmW34Xu9Hq+LN0WfiYZyjnJ244K970wjn-0p-e1tpBkmsDw@mail.gmail.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CADEbmW34Xu9Hq+LN0WfiYZyjnJ244K970wjn-0p-e1tpBkmsDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4



On 18. 10. 23 17:11, Michal Schmidt wrote:
> On Wed, Oct 18, 2023 at 1:26 PM Drewek, Wojciech
> <wojciech.drewek@intel.com>  wrote:
>>> -----Original Message-----
>>> From: Michal Schmidt<mschmidt@redhat.com>
>>> Sent: Wednesday, October 18, 2023 1:15 PM
>>> To:intel-wired-lan@lists.osuosl.org
>>> Cc: Keller, Jacob E<jacob.e.keller@intel.com>; Drewek, Wojciech
>>> <wojciech.drewek@intel.com>; Brandeburg, Jesse
>>> <jesse.brandeburg@intel.com>; Nguyen, Anthony L
>>> <anthony.l.nguyen@intel.com>;netdev@vger.kernel.org
>>> Subject: [PATCH net-next] iavf: delete unused iavf_mac_info fields
>>>
>>> 'san_addr' and 'mac_fcoeq' members of struct iavf_mac_info are unused.
>>> 'type' is write-only. Delete all three.
>>>
>>> The function iavf_set_mac_type that sets 'type' also checks if the PCI
>>> vendor ID is Intel. This is unnecessary. Delete the whole function.
>>>
>>> If in the future there's a need for the MAC type (or other PCI
>>> ID-dependent data), I would prefer to use .driver_data in iavf_pci_tbl[]
>>> for this purpose.
>>>
>>> Signed-off-by: Michal Schmidt<mschmidt@redhat.com>
>> Reviewed-by: Wojciech Drewek<wojciech.drewek@intel.com>
>>
>> Nice cleanup, I've seen similar unused fields in i40e as well.
>> Any plans for i40e cleanup?
> No, I am not planning to look into i40e cleanups in the near future.
> Ivan might want to do that though. [Adding him to the thread]
> Michal

OK, I will do it...

Thanks,
Ivan


