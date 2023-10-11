Return-Path: <netdev+bounces-39998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA87C55A6
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1871C20A03
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA931F94E;
	Wed, 11 Oct 2023 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQ0fFCxn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6F2CA6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:41:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BF5A4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697031663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnCtsfSMJ0596JXKTEwqnq/8AJhM3PDAMQhE8KTSUnc=;
	b=hQ0fFCxnroOVgHxmQCNzdZ2VZefrcP2wpsTmREeONaLrPZdJWMmcLxtby+ZawBTfoqyoZT
	fEc8QzApo7joDeshqI4bwIsXS2gEI+SqcDh5wc7wjMdjeywttXoZcnSIJV9aNBRRzcggpy
	wLhdHmf7ohlgJEZLfR3tNBvnUrv4fh4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-oQYP-2PfPjuItR49lDfaaQ-1; Wed, 11 Oct 2023 09:40:58 -0400
X-MC-Unique: oQYP-2PfPjuItR49lDfaaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FF3A1C0759E;
	Wed, 11 Oct 2023 13:40:57 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.140])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD28A21CAC6B;
	Wed, 11 Oct 2023 13:40:56 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Pravin B
 Shelar <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Adrian
 Moreno <amorenoz@redhat.com>,  Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [PATCH net 3/4] selftests: openvswitch: Skip drop testing on
 older kernels
References: <20231006151258.983906-1-aconole@redhat.com>
	<20231006151258.983906-4-aconole@redhat.com>
	<2e7ee087b33fba7e907c76e60d9eaed1807714e2.camel@redhat.com>
Date: Wed, 11 Oct 2023 09:40:56 -0400
In-Reply-To: <2e7ee087b33fba7e907c76e60d9eaed1807714e2.camel@redhat.com>
	(Paolo Abeni's message of "Tue, 10 Oct 2023 12:29:01 +0200")
Message-ID: <f7ta5spcm53.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Paolo Abeni <pabeni@redhat.com> writes:

> On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
>> Kernels that don't have support for openvswitch drop reasons also
>> won't have the drop counter reasons, so we should skip the test
>> completely.  It previously wasn't possible to build a test case
>> for this without polluting the datapath, so we introduce a mechanism
>> to clear all the flows from a datapath allowing us to test for
>> explicit drop actions, and then clear the flows to build the
>> original test case.
>> 
>> Fixes: 4242029164d6 ("selftests: openvswitch: add explicit drop testcase")
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>>  .../selftests/net/openvswitch/openvswitch.sh  | 17 ++++++++++
>>  .../selftests/net/openvswitch/ovs-dpctl.py    | 34 +++++++++++++++++++
>>  2 files changed, 51 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> index 2a0112be7ead5..ca7090e71bff2 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> @@ -144,6 +144,12 @@ ovs_add_flow () {
>>  	return 0
>>  }
>>  
>> +ovs_del_flows () {
>> +	info "Deleting all flows from DP: sbx:$1 br:$2"
>> +	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py del-flows "$2"
>> +        return 0
>
> The chunk above mixes whitespaces and tabs for indenting, please be
> consistent.

Thanks.  Will fix in v2

> Thanks!
>
> Paolo


