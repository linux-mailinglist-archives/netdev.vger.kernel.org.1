Return-Path: <netdev+bounces-44198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 913147D6FAC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282B21F22EB6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01EF28691;
	Wed, 25 Oct 2023 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjOr/sIV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2FC8EA
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:49:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB1CB0
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698245355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQg2aiugEAr81dlu2QQgtvQkHg29djoP9+oseI0sItA=;
	b=LjOr/sIVq+rK4VxGJpewtMj8eKR4TDiPtuJwmHZOHgYM4aFMDMUP9CXvFvwAE/gP7IigFy
	Gt+aiMPtykyP9cpe3mao9jqxCUKhNFApt3gc4brLDugPjQ8RkN5abdc6IgVouccnVDGvoA
	bCn4/ifoqd4XWq1ZiG4TGH8Zk93NhJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-D9xpdfXVNhCgtpipLzBmYw-1; Wed, 25 Oct 2023 10:49:14 -0400
X-MC-Unique: D9xpdfXVNhCgtpipLzBmYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 637C9811E91;
	Wed, 25 Oct 2023 14:49:13 +0000 (UTC)
Received: from [10.45.225.62] (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F175525C0;
	Wed, 25 Oct 2023 14:49:11 +0000 (UTC)
Message-ID: <fa91d099-74d7-48f8-9316-dba9a4e0b826@redhat.com>
Date: Wed, 25 Oct 2023 16:49:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: Delete unused
 i40e_mac_info fields
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20231025105911.1204326-1-ivecera@redhat.com>
 <389ecfc4-dfd7-4c56-b18f-82565e059914@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <389ecfc4-dfd7-4c56-b18f-82565e059914@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1



On 25. 10. 23 13:03, Wojciech Drewek wrote:
> On 25.10.2023 12:59, Ivan Vecera wrote:
>>  From commit 9eed69a9147c ("i40e: Drop FCoE code from core driver files")
>> the field i40e_mac_info.san_addr is unused (never filled).
>> The field i40e_mac_info.max_fcoeq is unused from the beginning.
>> Remove both.
>>
>> Co-developed-by: Michal Schmidt<mschmidt@redhat.com>
> Signed-off-by from Michal is needed, other than that:
> Reviewed-by: Wojciech Drewek<wojciech.drewek@intel.com>
Will fix by v2

Ivan


