Return-Path: <netdev+bounces-284415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM8mDJTx+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:33:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8244CE91E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C89D33074107
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3959439007;
	Tue,  5 May 2026 13:28:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51136215A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987712; cv=none; b=t4+AoYuPOjtuH5xAAkOHpXH+cMRX3GeadC0etZDrkwQqjA5bR3SUYScKqSpSoMDFAR4Fd89ffgZ8xiLlOC+rx/1rMfGj+p3zQ9Bb2sQq5fpcTg2juOVfUXUXpG86hiHEoGK/qlXVGEVCZivvGu6LxYFeX1x/jyCjoCgFG930svg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987712; c=relaxed/simple;
	bh=x5TgU5SBySfoeXKBw0QL6h3y9dq2clju9sczVk0IMPQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qPtWsVYS99WJ0aopm4Qp6K70Eb3UZ22apUuJyCUxoxreLA9JttOmJzVs4JbElQob4X52+MzoTc4QVefbmn9DmKTm6bHRNu0g6OnasNXWjHyqa1ktcfmdDb2vUuEULsG0fTct5Tw2mqcSbCISzMK1QR2o57B2mdXehtc5FB35lkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b936331786dso623410466b.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987710; x=1778592510;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCXgMseI2sOZrSwXLdW2jyT6y6fLj2BxLcRv5Mj/3pc=;
        b=W5AvsEKuJ15jXx771ILoTYF8P6RYUBAyS5Hj5o3PVTDa5V7Kh82q2BbDhuBJXhn0vK
         B8vMB1t8M32XOWk1iwQ7yNsIsN60AAjNken+VMfm0pefqZ1rgXbCDVQfp8NHh8eq7LXa
         DlEkiSlCJAD0WELwGkTNIF+fI82zuWvFCk0kgiPvK6TO9N2iAEt+z3deTJ9AulimD9MY
         26dDvtKDqOFwx+98RdaBmbM30J9ajjennVgW8SVkghyYWLz6ZgaxYFr2J3jbNgnANi/C
         fIUuyAxUINrSRnWrBGcOsszvCR0V4y66l4JqPoLSCY4k8brPFfe2UsoVYyBa9VgqHDvl
         y1ig==
X-Forwarded-Encrypted: i=1; AFNElJ9zmRbKxg1U9V/xEpeG/6nJyh28G9qm1kXKN5oUybvU4EwiuS5nK3GY5LzRIINrDtp2PAyoy8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOeW6k8L7BBjn3i0BlbTh1APHYThbpvIOZKc9SeFIBapDMqVr
	9gZunZxa/H2Se/guitLbWyD+r3ftynGyV/7bQobtzeyzQijFCs9wIEyCAhUYnq0D
X-Gm-Gg: AeBDiesQKRCqK8UxVjmRaA4Hq7PorCfprQUH9NA+0zdk35JwmtBqutwMrnKdz4cMk7g
	JE/4votV9x1G0fznWaEoOg1hTlA5R0MPsTTL0gB75vVqjjyIMeBfo1IOBlmM6xMlXLagkaFVDLW
	J9O4ZYcy0vG5pTyBeXJZrdJ8jMIs2mvJGSzmdQX4yhLhRkCCdkUbK55GbbMWIHpZjcO+OPtq5eY
	BtWUZkF0YGMBW5sBjkPIhPQ54qcHFOCtEDbsXnnIW0IxLxBLCEk6nyJ0sbvvzSN1KI2Z1XfMfnr
	d5qrgu7CmHnNslBLt2AO9v7sQ9VfZZBb7ZzlIblC/2VlktrVNwCA923n9WMrRrezl9NEqkye0/P
	9STceNB/viyQDiFJrhDAkb2kEc+yeWKBjRzvsZJ8Nojt9hGufA0v3gvU8fxBrBQiTbZvGgq6BS2
	NSTYXCf1egnYfrt8Ou4MdTHAi/QYg/MCcb1JBWEiLOh5jUedHCSGfyjtwPxErT5i5PgQ==
X-Received: by 2002:a17:906:eec1:b0:ba8:28de:697 with SMTP id a640c23a62f3a-bbff8ed484fmr782134566b.9.1777987709601;
        Tue, 05 May 2026 06:28:29 -0700 (PDT)
Received: from [192.168.88.241] (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc17f1eea7asm263903966b.58.2026.05.05.06.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:28:29 -0700 (PDT)
Message-ID: <aa08ff00-ba0d-4f1f-a85d-8afc2c6fd11f@ovn.org>
Date: Tue, 5 May 2026 15:28:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Yuan Tan <tanyuan98@outlook.com>,
 Yang Yang <n05ec@lzu.edu.cn>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: openvswitch: add tests for tunnel
 vport refcounting
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20260430233848.440994-1-i.maximets@ovn.org>
 <20260430233848.440994-3-i.maximets@ovn.org>
 <0f5da49c-7ed6-4547-9f89-bb3c3d62c3c3@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <0f5da49c-7ed6-4547-9f89-bb3c3d62c3c3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EA8244CE91E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284415-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ovn.org:mid]

On 5/5/26 3:25 PM, Paolo Abeni wrote:
> On 5/1/26 1:38 AM, Ilya Maximets wrote:
>> @@ -830,6 +831,42 @@ test_tunnel_metadata() {
>>  	return 0
>>  }
>>  
>> +test_tunnel_refcount() {
>> +	sbxname="test_tunnel_refcount"
>> +	sbx_add "${sbxname}" || return 1
>> +
>> +	ovs_sbx "${sbxname}" ip netns add trefns || return 1
>> +	on_exit "ovs_sbx ${sbxname} ip netns del trefns"
>> +
>> +	for tun_type in gre vxlan geneve; do
>> +		info "testing ${tun_type} tunnel vport refcount"
>> +
>> +		ovs_sbx "${sbxname}" ip netns exec trefns \
>> +			python3 $ovs_base/ovs-dpctl.py \
>> +			add-dp dp-${tun_type} || return 1
>> +
>> +		ovs_sbx "${sbxname}" ip netns exec trefns \
>> +			python3 $ovs_base/ovs-dpctl.py \
>> +			add-if --no-lwt -t ${tun_type} \
>> +			dp-${tun_type} ovs-${tun_type}0 || return 1
>> +
>> +		ovs_wait ip -netns trefns link show \
>> +			ovs-${tun_type}0 >/dev/null 2>&1 || return 1
>> +
>> +		info "deleting dp - may hang if reference counting is broken"
>> +		ovs_sbx "${sbxname}" ip netns exec trefns \
>> +			python3 $ovs_base/ovs-dpctl.py \
>> +			del-dp dp-${tun_type} &
>> +
>> +		dev_removed() {
>> +			! ip -netns trefns link show "$1" >/dev/null 2>&1
>> +		}
>> +		ovs_wait dev_removed dp-${tun_type} || return 1
>> +		ovs_wait dev_removed ovs-${tun_type}0 || return 1
> 
> FTR, here sashiko laments that if the reference counting is broken and
> the del-dp process hangs, this could leave the background del-dp python
> process running indefinitely.
> 
> I guess that if reference counting is broken inside the kernel, very
> likely an host/VM reboot is needed, and the above does not matter.

Yes, I have a note about that in the cover letter.

