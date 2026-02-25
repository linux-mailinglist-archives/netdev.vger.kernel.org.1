Return-Path: <netdev+bounces-261001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH/tFNoNn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-261001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:57:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B063E19912E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8BB3013A91
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9203AEF5F;
	Wed, 25 Feb 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnLHqxHF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DetyLtqt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7C34CFBA
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031447; cv=none; b=g5ALtD2BNxkcBZSQNY89PG8/k2f8wB4cEuM9uPqkahUkhLd2mrSCQi5aMZSmzmWJaCPJP3wLvayiZDo3RLSS9pV3bV9roVQlk9LqVQTjUp1VLzb4J2CzZC1hhGXgvWKNJG+Kuu7UvoNwSMLfgI7/CaDfGl+ciQ/8th1DxkAOaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031447; c=relaxed/simple;
	bh=3nDq6V9sMil92xFBi9eCRFNPceNL07AhmXRsNjKjL9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTkAlUCL3kc+n/FQftH68Pus8+hU8Qlj65X/enngjHh3nfKn13BN5CNw30PRYeRVTz+RdBe69a8K1aZL9VjdAN5CZjDLb6KFWRzY8KMKhwjHUgMjx1yKQ2lijpgtkaWVSUs0hvhWDxT5wIEPp3FxQLTbLjbx6KWvPjKeBqtbX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnLHqxHF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DetyLtqt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772031445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOFZD4dDncjyTTf4CK7xsUk9kkt0EXLPHp2enm9+JaE=;
	b=UnLHqxHFxlwQozkurPLpQAcGGnGZw12Pw35CCjA039TSiqGIKszuKqzAdJkBxEaGkJZTlK
	ISBgYS9+4OZklZd1rOE1nUVvUaKmlDDoYKSWEbD1rTiv/nXnI09V0whY99bG2dV04UUdci
	0wXtm4zg2w1JTAKrAInkO+M+pUeINbo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-dRLauFdzNMu9EL0-auVHug-1; Wed, 25 Feb 2026 09:57:23 -0500
X-MC-Unique: dRLauFdzNMu9EL0-auVHug-1
X-Mimecast-MFC-AGG-ID: dRLauFdzNMu9EL0-auVHug_1772031442
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3883f5ddd9aso42089021fa.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772031442; x=1772636242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOFZD4dDncjyTTf4CK7xsUk9kkt0EXLPHp2enm9+JaE=;
        b=DetyLtqt17ZgNG3gI1AEf5+2z8RUgsnqAmltNnWsD6SgNdwC3ijkmWbx+8zIka1SJI
         wizBsVL3WFAxpnc3iHzIU0h5hdXbFfOdjWYlOyPbNeQaUcgu4F74JJg79RDYG0ZbneA4
         MW4mn5HldO/RFNZaAt1DSktTs92JvnMFWi/m2EqvmAS82HIoIpwR1xT3/juf+tJkB3dS
         lzfIMKgzNyKi+h2llbzOM/h/OM3TslMr8Fh/zMN+yyLiPZ49g4u0xhMWBMSN3dqfNXEv
         PdUP+EiWpogx4HoCO+Kk99dRvYsAh8kStHsF4Xg/k5A/vj5d2gJJMkWIRMWnhvgid/wQ
         ID6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772031442; x=1772636242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOFZD4dDncjyTTf4CK7xsUk9kkt0EXLPHp2enm9+JaE=;
        b=Zq6A9kDzV7zL/odH+zH8a6J/e5ICIEZ9cmV7q0hZWh23N/fbLmrsDMNt4sSUu4z2FK
         3Mz/40FC0Qn/qad378JNorQciN0Bvt/ghmldvz1A/eY2352q/h4FsAOOQcOsxYX3ChOA
         sUF+AYHkM9K31f5wsowwE+MMHPXxJDMphRrp6e6QSM6uBEuAoP24hy9KRCdqIWBvhSb3
         tNYM1d7Pr2FYdFtWR3kHYPflTZb7ry05XK7t3DeIorfB1/Sd7nM3bN049YggrWiSK/mL
         LYbZGlMx0b1eJ8mzyEdwPahtzoqJli4wB0SnrH/pFHRFYSpMtkUFD7HWux8LuUIg068q
         5cpQ==
X-Gm-Message-State: AOJu0YzYLIlL8THs+bdAMyUPGD7pMOBO9rd0oRd//kwbddOp1JDOHl7y
	/CY63RdZxCCesQ1Zztxq94bEAZkM1jAlfS6/T7q7q10MdBkYUGdUmNE8xZk5w0aF89rAS1IpfAs
	oJcFM0Yb8xWhkG3FuW36cCfWsOvWF9Er40zJT4wf4mw7kq63GChEngaO/dQ==
X-Gm-Gg: ATEYQzyLLNCjKLo4tbFQPN6qyW/MB18B78CzI2gLP7JgoBENLChf836TcysHeICsjgY
	rnrW0YNtBIWBTHsdZjcD6f8ANsh6ut8tVFDqF/SSp4w/vfb7kXnHWB4sCFbxadgtO9dgpNuJDMo
	EdzPcFBohiH782ZqKgGHevn5skAMIjZDj3h3owxmdDP8VWjjTs9Vf0W368jV8+DkwNfhtzGJzXk
	cIJyTXwnUXLLyt5CnxSf8R0rBixrTqX9b69vb/OZ7EtjZZ/qnSQNZCAhgW6EDyS4XxDDAX7u2Cw
	AqEa6w/ZmE34Tnq5P0RFuBNQHfaTjQIigy1KlX8RLR+0VGPPRvtzB1uS6/XcocS4ooEVMSwjDz0
	3WuV7a9LhBF4zKT95fV4K
X-Received: by 2002:a05:651c:1581:b0:387:799:17f8 with SMTP id 38308e7fff4ca-389a5d4e7f8mr51094561fa.16.1772031442088;
        Wed, 25 Feb 2026 06:57:22 -0800 (PST)
X-Received: by 2002:a05:651c:1581:b0:387:799:17f8 with SMTP id 38308e7fff4ca-389a5d4e7f8mr51094491fa.16.1772031441579;
        Wed, 25 Feb 2026 06:57:21 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a770ecb7sm30766031fa.0.2026.02.25.06.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 06:57:20 -0800 (PST)
Message-ID: <6d93637e-cc59-45e5-9365-8140f53e4004@redhat.com>
Date: Wed, 25 Feb 2026 15:57:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] iavf: fix VLAN filter lost on
 add/delete race
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <20260225100137.383527-1-poros@redhat.com>
 <CADEbmW2WNCLuRYVs5FTKR6GR16yOMmQGyg0vYR98SQCCwb_5HA@mail.gmail.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <CADEbmW2WNCLuRYVs5FTKR6GR16yOMmQGyg0vYR98SQCCwb_5HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261001-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B063E19912E
X-Rspamd-Action: no action


On 2/25/26 12:17, Michal Schmidt wrote:
> On Wed, Feb 25, 2026 at 11:02 AM Petr Oros <poros@redhat.com> wrote:
>> When iavf_add_vlan() finds an existing filter in IAVF_VLAN_REMOVE
>> state, it transitions the filter to IAVF_VLAN_ACTIVE assuming the
>> pending delete can simply be cancelled. However, there is no guarantee
>> that iavf_del_vlans() has not already processed the delete AQ request
>> and removed the filter from the PF. In that case the filter remains in
>> the driver's list as IAVF_VLAN_ACTIVE but is no longer programmed on
>> the NIC. Since iavf_add_vlans() only picks up filters in
>> IAVF_VLAN_ADD state, the filter is never re-added, and spoof checking
>> drops all traffic for that VLAN.
>>
>>    CPU0                       CPU1                     Workqueue
>>    ----                       ----                     ---------
>>    iavf_del_vlan(vlan 100)
>>      f->state = REMOVE
>>      schedule AQ_DEL_VLAN
>>                               iavf_add_vlan(vlan 100)
>>                                 f->state = ACTIVE
>>                                                        iavf_del_vlans()
>>                                                          f is ACTIVE, skip
>>                                                        iavf_add_vlans()
>>                                                          f is ACTIVE, skip
>>
>>    Filter is ACTIVE in driver but absent from NIC.
> I don't get it. If, as the diagram shows, iavf_del_vlans() skipped it,
> then how does the filter become absent from NIC?

VLAN teardown            Workqueue           VLAN setup
-------------            ---------           ----------
iavf_del_vlan(100)
   f->state = REMOVE
   schedule AQ_DEL_VLAN
                                              iavf_open()
                                                restore_filters()
                                                  f is REMOVE, skip
                                                iavf_add_vlan(100)
                                                 f->state = ACTIVE

                          iavf_del_vlans()
                           f is ACTIVE, skip
                          iavf_add_vlans()
                           f is ACTIVE, skip

Is it clear like this?

> Michal
>
>> Transition to IAVF_VLAN_ADD instead and schedule
>> IAVF_FLAG_AQ_ADD_VLAN_FILTER so iavf_add_vlans() re-programs the
>> filter.  A duplicate add is idempotent on the PF.
>>
>> Fixes: 0c0da0e95105 ("iavf: refactor VLAN filter states")
>>
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> index 4b0fc8f354bc90..6046b93c7f3472 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> @@ -782,10 +782,13 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
>>                  adapter->num_vlan_filters++;
>>                  iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
>>          } else if (f->state == IAVF_VLAN_REMOVE) {
>> -               /* IAVF_VLAN_REMOVE means that VLAN wasn't yet removed.
>> -                * We can safely only change the state here.
>> +               /* Re-add the filter since we cannot tell whether the
>> +                * pending delete has already been processed by the PF.
>> +                * A duplicate add is harmless.
>>                   */
>> -               f->state = IAVF_VLAN_ACTIVE;
>> +               f->state = IAVF_VLAN_ADD;
>> +               iavf_schedule_aq_request(adapter,
>> +                                        IAVF_FLAG_AQ_ADD_VLAN_FILTER);
>>          }
>>
>>   clearout:
>> --
>> 2.52.0
>>


