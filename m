Return-Path: <netdev+bounces-260467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCnQJQaLnWnBQQQAu9opvQ
	(envelope-from <netdev+bounces-260467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:27:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCEB1863E2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20134308FBD7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2571737C103;
	Tue, 24 Feb 2026 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOMFvCfb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nvUGeYsV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA9379974
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932083; cv=none; b=kG3Kd4ob+aGBMoo5x65jtS1oXf7E8GMR6BurC4MDuFyYA/tlikZKvmCKA8gKmWZHzWDJqZwj8VsQy6qY/23dZ/jkA9Idw1hk/zMAbAL/ztCI9AiGl0FgXQrc9t6pXwZ82YX6ackOUNCoyGQs4XB9youVwZd2YRGW/XxDyLQfhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932083; c=relaxed/simple;
	bh=u8DFcZr6PrNIgWweTXks8B4ZPWysQUYeU0IhnqpvGHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5+EgrponVFaxUIKCNoHRPUoVdilEfJqzh5JPcyFzggxKLNRa3eRbQu7PmtwHNQ/Vy8zDUgBAS2eVpLdZe7U6vTYngpP7lbTgbRfcVBWpGYrJCzaHoATzy0x1eBBw1vlqR3/QSzx4fTmQAbaqLxqch3OTUWNi3a8MyleXfyyQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOMFvCfb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nvUGeYsV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771932081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6clpakBnI/FsH5CU8EtT8oTpZLAR4ADDoYBwMfYPgk=;
	b=NOMFvCfbx23tUML4j02pE0D7KyVVR/EGE87p9MfMI1xi+uNpyS5DcPokFeJtaCcFEQWTL7
	NGEQN9DgW2qWLvZWpK+3FvV8MrkaY6Du+8zJZz+DzDtv7SLiCMBCcOLoVdWSnuTdng6nRL
	4UaCe4cdrXmwfLf4i/buJ+6F76FSung=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-iHhQc_S_O-ij3HDeaXsS9A-1; Tue, 24 Feb 2026 06:21:13 -0500
X-MC-Unique: iHhQc_S_O-ij3HDeaXsS9A-1
X-Mimecast-MFC-AGG-ID: iHhQc_S_O-ij3HDeaXsS9A_1771932072
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso45130225e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771932072; x=1772536872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6clpakBnI/FsH5CU8EtT8oTpZLAR4ADDoYBwMfYPgk=;
        b=nvUGeYsVl5EdxlmA6RlvpMsQ4tPzikvY8WvsPkPij5tqsKL5NgQgkLUeZX+ERnpLU+
         0PGpUDh3h+O9pQ6Vf3X0dx0G6s1QsU+JpBYzOeCviENnXHhPLO9eZv3kcyXqnehl18gT
         zrJr13QUWXU+2WnKo5hi8k3ue6kucJJfwVRGda9yfW7nISYSJozXkcDR/9BflUNbO+Lh
         QhbFZ3Qu5O8T+/vh5EPN+doBwzwCksqNz6AW+5onazQTmmi00vydFj/2g2FDZd9pSTSD
         7dUfQCz1QN8e4qnXzKjvHOZCZXrNmLqb0ixfyYpCs7gvaySRWqCFlzpqyC0PxE+Bf/BS
         HOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771932072; x=1772536872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6clpakBnI/FsH5CU8EtT8oTpZLAR4ADDoYBwMfYPgk=;
        b=ACP+w43dyg7xVhis10PuyQladJk4pAju15zIkd+yobt4KS4uuR3DJtRxvYZydVdxHF
         F2y2yRPRnG4ALJs6vTNIOF0OMkaCjvuW+Y6NtEWrxndKdxuyGYoFaqgRxVtuTtJaJG+X
         AqEo0vNC0tSxpG9vWLfS03aENt6v04znIHfBqsdSl7i1hLBwzWy6Ym7HZQNULMKiKqm5
         KdFtuff8CcXaPuk7FabGeq/b5Gd5THX8mCrCh1jY4nOZg+NE3lvaug+7KoUBfuy2ABrB
         ZXfMZY8Mc74cjasL7dE7gb7YCp9MHA0N+MRcSiD61CZ9AmU5RJlubJFXLIXzm0a6JPhx
         QBgA==
X-Gm-Message-State: AOJu0Yy/a1vRwFuHt5FBz2iWe8rdSx0XoM5dp+crGJuGSw3ng0ygeKqk
	NIpJv8KY9g+yYrNityl2K8huTGB5cigWm0J7cqbRIu8OfyDhaxgY6jErmMehxPsLMUpEcRiyAL1
	esrMVjsicthUn8fjAHkI1Oc0ah8YlX0QMNRtKI2CjpQqxiLr3N10NY22M5w==
X-Gm-Gg: AZuq6aL1CgxIrsIa4gzyfdTvKWwLUC5vEG9M+LymXkk1feT90Tnw6sUwnMqse8aEzm2
	M8s7XQnXNYZLp2IouCcOJdtCL/pyvwta+vBp3J0//GIG3RiarZUu7/V76P4T0LMEYKUs3V+yvMs
	Z41eE9fr4DfUZB99m85iw6WUS+gZpRM29lrag03sUyX0X5YWZQWQe9DFagQFBFIdmqz0YVc/Yh9
	ORhG/IVBwHfzmc3A3nPe0T+QDAcK0z9Hj6j1w7hR2XBF7Ly2rB/W8Zjaj3deSYSPQxhtB+GEw5n
	Wf2/+BiqgdHXQxSSwjLydr8QZlWJf4x5p28qKtdRPtve66w0qJvvr27Yr+nZD1yn4KCJuHqsaQl
	hm2gWWohGqHmz51+eafKF
X-Received: by 2002:a05:600c:45ce:b0:483:a895:9d85 with SMTP id 5b1f17b1804b1-483a95b3e18mr211925245e9.2.1771932072287;
        Tue, 24 Feb 2026 03:21:12 -0800 (PST)
X-Received: by 2002:a05:600c:45ce:b0:483:a895:9d85 with SMTP id 5b1f17b1804b1-483a95b3e18mr211924625e9.2.1771932071750;
        Tue, 24 Feb 2026 03:21:11 -0800 (PST)
Received: from [192.168.88.32] ([216.128.9.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3e0dsm504628215e9.1.2026.02.24.03.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 03:21:11 -0800 (PST)
Message-ID: <d3a43f4c-1b6e-4cac-a127-3e297fd6d224@redhat.com>
Date: Tue, 24 Feb 2026 12:21:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: net: Add bridge VLAN range grouping
 tests
To: Simon Horman <horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com
References: <20260222085338.3143823-1-danieller@nvidia.com>
 <20260222085338.3143823-3-danieller@nvidia.com>
 <aZ1agwUGRt2Qqzv3@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aZ1agwUGRt2Qqzv3@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-260467-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ingest_mdir.py:url]
X-Rspamd-Queue-Id: ADCEB1863E2
X-Rspamd-Action: no action

On 2/24/26 9:00 AM, Simon Horman wrote:
> On Sun, Feb 22, 2026 at 10:53:38AM +0200, Danielle Ratson wrote:
>> Add a new test file bridge_vlan_dump.sh with four test cases that verify
>> VLANs with different per-VLAN options are not incorrectly grouped into
>> ranges in the dump output.
>>
>> The tests verify the kernel's br_vlan_opts_eq_range() function correctly
>> prevents VLAN range grouping when neigh_suppress, mcast_max_groups,
>> mcast_n_groups, or mcast_enabled options differ.
>>
>> Each test verifies that VLANs with different option values appear as
>> individual entries rather than ranges, and that VLANs with matching
>> values are properly grouped together.
>>
>> Example output:
>>
>> $ ./bridge_vlan_dump.sh
>> TEST: VLAN range grouping with neigh_suppress                       [ OK ]
>> TEST: VLAN range grouping with mcast_max_groups                     [ OK ]
>> TEST: VLAN range grouping with mcast_n_groups                       [ OK ]
>> TEST: VLAN range grouping with mcast_enabled                        [ OK ]
>>
>> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>> ---
>>  tools/testing/selftests/net/Makefile          |   1 +
>>  .../testing/selftests/net/bridge_vlan_dump.sh | 203 ++++++++++++++++++
>>  2 files changed, 204 insertions(+)
>>  create mode 100755 tools/testing/selftests/net/bridge_vlan_dump.sh
> 
> Hi Danielle,
> 
> I'm wondering if you could consider running running shellcheck over this
> and cleaning  things up a little.
> 
> I see SC2086 which I think can be trivially addressed.
> And SC2329, which I think would be best ignored using #shellcheck disable=SC2086

@Danielle: please address the shellcheck-reported issues. We are trying
to avoid them in the new code, and with time we will hopefully achieve
code consistency.

You can use the ingest_mdir.py script from
https://github.com/linux-netdev/nipa/ to automate the shellcheck test
before submission.

Thanks,

Paolo


