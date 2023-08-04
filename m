Return-Path: <netdev+bounces-24376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EA677001A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588B91C217FD
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EE3BA55;
	Fri,  4 Aug 2023 12:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C613FBA50
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 12:20:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46F46B1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691151627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bi7oZhJ0pwsGnsF8DihtaSZ95yhE0U9tzdVwK9en+qo=;
	b=F0APe8blov0GVMVIT4Cgr/DgFt1wWMVf1qk5cgFmFa39HxwrB7XWAIWFM0cOv8OHa2HeBz
	zvArAhwoCEUMBI9XMshbyYzMn10VkrIrI1be2+Bv8l0+/SYDOYBw4qYRSscYlsrl889ZDI
	acRT3pDOQMuYmfpXRO6BxoadVx9JGGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-4JDI8jaOPTm4SGbyil7H2A-1; Fri, 04 Aug 2023 08:20:24 -0400
X-MC-Unique: 4JDI8jaOPTm4SGbyil7H2A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1061E10113C1;
	Fri,  4 Aug 2023 12:20:24 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.33.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DF93492CA6;
	Fri,  4 Aug 2023 12:20:22 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Shuah
 Khan <shuah@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Eric Dumazet
 <edumazet@google.com>,  "David S. Miller" <davem@davemloft.net>,  Pravin B
 Shelar <pshelar@ovn.org>,  Adrian Moreno <amorenoz@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH v3 net-next 0/5] selftests: openvswitch: add flow
 programming cases
References: <20230801212226.909249-1-aconole@redhat.com>
	<8470c431e0930d2ea204a9363a60937289b7fdbe.camel@redhat.com>
Date: Fri, 04 Aug 2023 08:20:21 -0400
In-Reply-To: <8470c431e0930d2ea204a9363a60937289b7fdbe.camel@redhat.com>
	(Paolo Abeni's message of "Thu, 03 Aug 2023 15:22:12 +0200")
Message-ID: <f7tbkfn6ltm.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Paolo Abeni <pabeni@redhat.com> writes:

> On Tue, 2023-08-01 at 17:22 -0400, Aaron Conole wrote:
>> The openvswitch selftests currently contain a few cases for managing the
>> datapath, which includes creating datapath instances, adding interfaces,
>> and doing some basic feature / upcall tests.  This is useful to validate
>> the control path.
>> 
>> Add the ability to program some of the more common flows with actions. This
>> can be improved overtime to include regression testing, etc.
>> 
>> v2->v3:
>> 1. Dropped support for ipv6 in nat() case
>> 2. Fixed a spelling mistake in 2/5 commit message.
>> 
>> v1->v2:
>> 1. Fix issue when parsing ipv6 in the NAT action
>> 2. Fix issue calculating length during ctact parsing
>> 3. Fix error message when invalid bridge is passed
>> 4. Fold in Adrian's patch to support key masks
>
> FTR, this apparently requires an [un?]fairly recent version of
> pyroute2. Perhaps you could explicitly check for a minimum working
> version and otherwise bail out (skip) the add-flow tests.

I'll make sure to get a follow up out ASAP that includes some check for
supported version and will skip if not.  I will try to also include some
additional robustness checks.

Thanks Paolo!

> Cheers,
>
> Paolo


