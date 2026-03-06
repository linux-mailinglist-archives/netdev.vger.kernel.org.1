Return-Path: <netdev+bounces-264789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFgLC/XSqmn3XQEAu9opvQ
	(envelope-from <netdev+bounces-264789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:13:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EF221710
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B9D23081BD0
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C05393DCA;
	Fri,  6 Mar 2026 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hf8Cd95H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLkd5JUO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED884393DC7
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802752; cv=none; b=QiLRL9Jioh2rgIDnq76A1yvwzaeecJCk2cnFTSpEt29dd96zMb8OzfwbOo3nViWh5nqk0rW5KOqcXb8A8th8WVz6TLTqrEY7Xzrl13KvW4hPERzfMyEZZ6mpEhqDmI7JaFtS+2wpABNrrd4seai7SeLuB678wpjf1S0qyoFU5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802752; c=relaxed/simple;
	bh=bgR+u4X+EfGkHcGi9RUq+i16jPyWfF2EMadRRWpzyhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNUsiFOpCH1cN0W3Mghc7J4nVIR7wT/H9u+dEyYgep7YtDoV9R542lypztdDjRXbctDXkLb0uEutgb/iKjd0e3KeNz9DhdBcHYskl9+elFY63z7GgmHqQSf4BtsIA2VipWbuWlJ5Md+VkW8SepQuQwNGF4gBC1dESuh7Y9CHsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hf8Cd95H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLkd5JUO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772802748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXD46sZBbQ0HinTPPSaWF5tUOxdfFWBYFR/OarMz7d8=;
	b=hf8Cd95H9ucjoIYF7zmO5fFHltGQt35LRn+FSYYU5EjGUZ6U4+yL37K1YlvqtHsZ1Y849H
	xA7YItpj4DNH0xrHfun0i/tlc7jeKgHHVDhK8NTgXXsmmxMH8X3zBBTK9x1SkOZmUnuA9x
	yrulO19mufXkmdZlj/wEUaO85BvDtPQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-6b-ZDKINPD2h7DfeAiDylA-1; Fri, 06 Mar 2026 08:12:27 -0500
X-MC-Unique: 6b-ZDKINPD2h7DfeAiDylA-1
X-Mimecast-MFC-AGG-ID: 6b-ZDKINPD2h7DfeAiDylA_1772802747
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so94821585e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 05:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772802745; x=1773407545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXD46sZBbQ0HinTPPSaWF5tUOxdfFWBYFR/OarMz7d8=;
        b=GLkd5JUOp/9phdeCGDgzoSGyNbRFm4Ux68IfMG2ECCCHM+iH9tOhP1s572YSTyVU9Z
         SkVXK+JKvpQ9kf4E2yv2CmJIC62TxAlAGlJZUrOBmT9q8uuA5R38/2P1mXua67jEyzdU
         fZJYQtO9G3PjUzcyWReFDZES4lRuDgWBopf+UJ0iHpITuZMvGZ4MYCCRijZf/tq1Pzad
         W1RMApIiXKGtLaRhQIjMKIFxL6TUTCHIwU7gfC/7bZ6C1UV7Y3Q6i8ArcQSLcaQcdsqY
         6JVGQQNZVmWTok7gJW5KZJicsf6h91+M2Hzq3P3GGXCN1JnjVZVcDHRWyPb5n3R3/VUL
         ghyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772802745; x=1773407545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXD46sZBbQ0HinTPPSaWF5tUOxdfFWBYFR/OarMz7d8=;
        b=uGFJlV7rP6Nf9t39aHa49LLf57RNLBDjAkoUxKYl8i3+xs2QtwZeYN02dPXwuox5dG
         o4wumHP++Vb+PxuvE5nLohAaFnZdDYhXGqHzaMdjT94qxPAeOHzRMMIQL6kpW9omNlEm
         XQtlER9uACfoPNYqJRkSOmmsW2ZbuQSCcVzR/cwTHygCz2mU16BcnsxdxWk1p3qyRd4u
         Xg5PlAI8yxkybNZy11QJdKM8CnYg1zIVJAfYXmQjwYqlGb5VtCu/+obWquGfc40teE5o
         78QFrAijn/r3YThaHvfy1VWcVNCLH/BVxFJr4wf3Tqm9FJL3FGP7B4rZolA0/x4SNok5
         ykjw==
X-Gm-Message-State: AOJu0YzlbQBw9KcYdXrQi2aLkQ+a00A+67gOsnYx8tGn0VRJLIOOscVN
	S1Dd7cgRsQ8LD+ZkQHOa7EAZyihLBI9VD7vRPSAALBbVUTy6nGpoZlo7RI2Uv9BhOw0qOvxhLWg
	1hg8/PZhUPMyvTxvlLCnVYWeURUUhok6mCsXsk3lSyrnhAlzqQbpOptBH8uypBeqGvaY4Lp1sSQ
	URbQUB7ew+tq7g6aAvgoPphGH7hDyzg6sLcr3tz1ZP
X-Gm-Gg: ATEYQzxM+JKA5i+lRXlHotklY0mpPeNSwZJvoMxv/5vgMSy2HGy0Jq6vrCrrKCcX6N0
	y+SPzX0bU5htAjCTGStHD4+TlGoEOM2zgwlzG6F9V/nQXUaUGOODqUR61DL27H7Jy6Jr0fK2B0T
	YfiYbgeBG956FheVIMWRWrhuK8OBuPHQGDxqFv8LdfsnAQXnXoU3YNsi68mEUht9nYV+e32k4Zt
	h5PD8TcGXaZH2vKMMo1One19h6BefbFlR3OEfK6YDWcq1h6NyROiNaWROaMc0ExZwu0Wt9gSwwz
	jLrPfTyZlXTVeqQIq8G/HJ9OIlPV9x13MBi31P4B5SpPPt9m3io3sl3Xbtiikup//AVZJmsb2/n
	4TWMlyj7lEXeFjiXKLPlK
X-Received: by 2002:a05:600c:c4a5:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-485269199a2mr31101405e9.6.1772802744895;
        Fri, 06 Mar 2026 05:12:24 -0800 (PST)
X-Received: by 2002:a05:600c:c4a5:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-485269199a2mr31100855e9.6.1772802744373;
        Fri, 06 Mar 2026 05:12:24 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae00absm110527045e9.4.2026.03.06.05.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 05:12:23 -0800 (PST)
Message-ID: <76331edf-2963-4527-9f01-80fed3f6d49b@redhat.com>
Date: Fri, 6 Mar 2026 14:12:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC iwl-next 0/4] iavf: fix VLAN filter state machine
 races
To: netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260302114025.1017985-1-poros@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260302114025.1017985-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C61EF221710
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-264789-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

I leveraged Claude Opus 4.6 to develop a stress-test suite with a
primary 'break-it' objective targeting VF stability. The suite focuses
on aggressive edge cases, specifically cyclic VF migration between
network namespaces while VLAN filtering is active a sequence known
to trigger state machine regressions. The following output
demonstrates the failure state on an unpatched iavf driver (prior to
the 'fix VLAN filter state machine races' patch):

echo 8 > /sys/class/net/enp65s0f0np0/device/sriov_numvfs
# ./tools/testing/selftests/drivers/net/iavf_vlan_state.sh
================================================
   iavf VLAN state machine test suite
================================================
   VF1:  enp65s0f0v0 (0000:41:01.0) -> iavf-t1-6502
   VF2:  enp65s0f0v1 (0000:41:01.1) -> iavf-t2-6502
   PF:   enp65s0f0np0 (0000:41:00.0)
   MAX:  8 user VLANs per VF
================================================
   PASS  state: basic add/remove
RTNETLINK answers: Input/output error
Cannot find device "enp65s0f0v0.107"
Cannot find device "enp65s0f0v0.107"
   FAIL  state: 8 VLANs add/remove  (only 7 created)
   PASS  state: VLAN persists across down/up
   PASS  state: 5 VLANs persist across down/up
   PASS  state: rapid add/del same VLAN x100
   PASS  state: add during remove (REMOVING race)
RTNETLINK answers: Input/output error
Cannot find device "enp65s0f0v0.107"
Cannot find device "enp65s0f0v0.107"
   PASS  state: bulk 8 add then remove
   PASS  state: 20x rapid down/up with VLAN
   PASS  state: add VLAN while down
   PASS  state: remove VLAN while down
   PASS  state: down -> remove -> up
   PASS  state: add VLANs while down, verify all after up
   PASS  state: double add same VLAN (idempotent)
   PASS  state: double remove same VLAN
   PASS  state: interleaved add/remove different VIDs
   PASS  state: remove+re-add loop x50
RTNETLINK answers: Input/output error
Cannot find device "enp65s0f0v0.107"
Cannot find device "enp65s0f0v0.107"
   FAIL  state: stress 8 VLANs (fill to max)  (expected 8, got 7)
   PASS  state: VLAN VID 1 (common edge case)
   PASS  state: VLAN VID 4094 (max)
   PASS  state: concurrent VLAN adds (4 parallel)
   PASS  state: concurrent VLAN deletes (4 parallel)
   PASS  state: add/del storm (200 ops, 5 VIDs)
RTNETLINK answers: Input/output error
Cannot find device "enp65s0f0v0.107"
Cannot find device "enp65s0f0v0.107"
   FAIL  state: over-limit VLAN rejected, existing survive  (fill: 
expected 8, got 7)
   PASS  reset: VLANs recover after VF PCI FLR
   PASS  reset: 5 VLANs recover after VF PCI FLR
   PASS  reset: rapid VF resets x5 with VLANs
   PASS  reset: VLANs survive PF link flap
   PASS  reset: 5 VLANs survive PF link flap
   PASS  reset: VLANs survive 3x PF link flap
   PASS  reset: VLANs survive PF PCI FLR
RTNETLINK answers: Input/output error
Cannot find device "enp65s0f0v0.107"
Cannot find device "enp65s0f0v0.107"
   FAIL  reset: all 8 VLANs recover after VF FLR  (VLAN 107 gone)
RTNETLINK answers: Input/output error
Cannot find device "enp65s0f0v0.107"
Cannot find device "enp65s0f0v0.107"
   FAIL  reset: all 8 VLANs survive PF link flap  (VLAN 107 gone)
RTNETLINK answers: Input/output error
Cannot find device "enp65s0f0v0.107"
Cannot find device "enp65s0f0v0.107"
   FAIL  reset: all 8 VLANs survive PF PCI FLR  (VLAN 107 gone)
   PASS  reset: FLR during VLAN add/del (race)
   PASS  reset: VF driver unbind/bind cycle
   PASS  ping: basic VLAN traffic
   PASS  ping: 5 VLANs simultaneously
   PASS  ping: survives VF down/up
   PASS  ping: survives 10x rapid VF flap
   PASS  ping: survives VF PCI FLR
   PASS  ping: survives PF link flap
   PASS  ping: survives PF PCI FLR
   PASS  ping: stable while adding/removing other VLANs
   PASS  ping: all 3 VLANs work after down/up
   PASS  ping: parallel VLAN churn from both VFs
   PASS  ping: VLANs work after rapid add/del churn
   PASS  ping: VLANs survive repeated NS move cycle
   PASS  ping: all VLANs survive PF link flap
   PASS  ping: VLAN isolation (no cross-VLAN leakage)
   PASS  ping: traffic works with spoofchk enabled
   PASS  ping: port VLAN (PF-assigned pvid)
   PASS  dmesg: no call traces / BUGs / stalls

================================================
   PASS 46  |  FAIL 6  |  SKIP 0  |  TOTAL 52
================================================
   RESULT: FAIL  -- check dmesg


The underlying failures stem from a breakdown in state synchronization
between the VF and the PF. This desynchronization prevents the driver
from maintaining a consistent hardware state during rapid configuration
cycles, leading to the observed issues.

...................

Patched kernel:

# echo 8 > /sys/class/net/enp65s0f0np0/device/sriov_numvfs
# ./tools/testing/selftests/drivers/net/iavf_vlan_state.sh
================================================
   iavf VLAN state machine test suite
================================================
   VF1:  enp65s0f0v0 (0000:41:01.0) -> iavf-t1-6573
   VF2:  enp65s0f0v1 (0000:41:01.1) -> iavf-t2-6573
   PF:   enp65s0f0np0 (0000:41:00.0)
   MAX:  8 user VLANs per VF
================================================
   PASS  state: basic add/remove
   PASS  state: 8 VLANs add/remove
   PASS  state: VLAN persists across down/up
   PASS  state: 5 VLANs persist across down/up
   PASS  state: rapid add/del same VLAN x100
   PASS  state: add during remove (REMOVING race)
   PASS  state: bulk 8 add then remove
   PASS  state: 20x rapid down/up with VLAN
   PASS  state: add VLAN while down
   PASS  state: remove VLAN while down
   PASS  state: down -> remove -> up
   PASS  state: add VLANs while down, verify all after up
   PASS  state: double add same VLAN (idempotent)
   PASS  state: double remove same VLAN
   PASS  state: interleaved add/remove different VIDs
   PASS  state: remove+re-add loop x50
   PASS  state: stress 8 VLANs (fill to max)
   PASS  state: VLAN VID 1 (common edge case)
   PASS  state: VLAN VID 4094 (max)
   PASS  state: concurrent VLAN adds (4 parallel)
   PASS  state: concurrent VLAN deletes (4 parallel)
   PASS  state: add/del storm (200 ops, 5 VIDs)
   PASS  state: over-limit VLAN rejected, existing survive
   PASS  reset: VLANs recover after VF PCI FLR
   PASS  reset: 5 VLANs recover after VF PCI FLR
   PASS  reset: rapid VF resets x5 with VLANs
   PASS  reset: VLANs survive PF link flap
   PASS  reset: 5 VLANs survive PF link flap
   PASS  reset: VLANs survive 3x PF link flap
   PASS  reset: VLANs survive PF PCI FLR
   PASS  reset: all 8 VLANs recover after VF FLR
   PASS  reset: all 8 VLANs survive PF link flap
   PASS  reset: all 8 VLANs survive PF PCI FLR
   PASS  reset: FLR during VLAN add/del (race)
   PASS  reset: VF driver unbind/bind cycle
   PASS  ping: basic VLAN traffic
   PASS  ping: 5 VLANs simultaneously
   PASS  ping: survives VF down/up
   PASS  ping: survives 10x rapid VF flap
   PASS  ping: survives VF PCI FLR
   PASS  ping: survives PF link flap
   PASS  ping: survives PF PCI FLR
   PASS  ping: stable while adding/removing other VLANs
   PASS  ping: all 3 VLANs work after down/up
   PASS  ping: parallel VLAN churn from both VFs
   PASS  ping: VLANs work after rapid add/del churn
   PASS  ping: VLANs survive repeated NS move cycle
   PASS  ping: all VLANs survive PF link flap
   PASS  ping: VLAN isolation (no cross-VLAN leakage)
   PASS  ping: traffic works with spoofchk enabled
   PASS  ping: port VLAN (PF-assigned pvid)
   PASS  dmesg: no call traces / BUGs / stalls

================================================
   PASS 52  |  FAIL 0  |  SKIP 0  |  TOTAL 52
================================================
   RESULT: OK

Additionally, interface up/down performance with active VLAN
filtering is significantly improved. The previous bottleneck—a
synchronous VLAN filtering cycle (VF -> PF -> HW -> PF -> VF)
utilizing AdminQ for per-VLAN updates introduced substantial
latency.

Test suite:

https://github.com/torvalds/linux/commit/5c60850c33da80a1c2497fb6bc31f956316197a9 


Regards,

Petr



