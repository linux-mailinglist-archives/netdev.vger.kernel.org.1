Return-Path: <netdev+bounces-181855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD2A869C6
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 02:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968FD4C0D5E
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 00:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E50211187;
	Sat, 12 Apr 2025 00:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4FD53C
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744417785; cv=none; b=MxYMzVtsmM3yLESaOUx/hnE51dB/Z+v0zGMdo+S7oEapQQ5S1MwXwr60dkcSM5OzQeA1RjeeqoPpX9hDifP80UMD/OUA6bC9n3NMAbrKisO5+O+SpMfeLal6ae6S77yuJkjgFAv7cqcHb09Wt4rJRQ0WTSTKYJxdNzIMvqwaTYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744417785; c=relaxed/simple;
	bh=q/WNaC8JMaxpVcSLHJ6jk8SLdTDJJaX+OAGJ3/8lFCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRSPxSDBCVfND4TX3FPfdyowUFiKCNex/HXrNVsvrbdRobpTlozpt/WY+piGgIWZJ2bC1GbLN0RTRbKZyjDEYFzaJG/UYpux8O5fs0EKApswZPFEyQlePOM5sliBpfdTH0BxVLRN+XgFYmZKZl3fB0op0P0jOf+OQffnumBMpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39129fc51f8so2056562f8f.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 17:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744417781; x=1745022581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLyxTPZziZJjenm9clOE4/jhWpOlz18mNb+pt4FVQTA=;
        b=bDUoKQgFUlt4L1D+UtWjRHziRaZU2Q7GeQ7h0RdgQ+KbBM6V0eszwSuS2T0E5vnv6g
         6COMTemylvtefzAJ+K8jufV1DD3t4RL3v3gdSk+tk3evNnweOElkRISIrmDGr/obC6Hp
         2JrJMzTfdf6RDXzcjPyS1SsOBhuPluebCyXYIDgq+bTpZLyJ02mt7LGGC914qMdWIWVE
         BjkuyI7mANFAJJawAMCA5H5oUyE1LauigaEO1PxG+fd/teuAUG2O0RxP+0dPivtjYLd5
         9P/iT9/SIqYItabV5f2qKKcn8JLzICrYb5RV0jzwK+CAV5xkvBeMQerviJU5++0dc6j4
         UapA==
X-Gm-Message-State: AOJu0YxUCxWnrQeJ3UiVOZu5CQT50OmMoT0YrabPv2hdhF2bKty80uuJ
	zqsMeCnNV56TeGWlxYZfzvEMt1a75acfZIwN6dajKHp3P790e9Fh
X-Gm-Gg: ASbGncsk1U5BE610IS9F6gV/OQYdwFqbVhVOJnEFGW08sVXpQYzC3XuRXnIcSLQMJJM
	3GegXv98WvFcdZQbs3IdsHA+v7n4OqC3lhnVaDmAw0RaYKz9B9yDcvWR6AEWPr5d3peEb8ubM26
	7YWH3OwDGC9JQyafrz5vlNQsQsbdmYL4C8xZzaEpHC/sifcwVJCsyoO5UmxM+x7bB4klILmpSjB
	4zVv3s5uV5mTSBl47Nxo5iCmAtegUYGPjNpJUtC8rjr1URzwCjSMNUzEXkZW9Xq2mT03+Rib/m5
	rNMyo585SLQ5DI36t170kmkf3QQ3SGHnh07cmSbcKA4bGScMgKPIGfVF/0yooZorRn3/SWdzcjt
	atDNFrKqb
X-Google-Smtp-Source: AGHT+IG8S+QoRT3hvXmq9oTW/w5RRYT4vGIpOfDoMKbSkTN3dwVlm8yI6kErxZ1uPvtCoUm4rrSmrA==
X-Received: by 2002:a05:6000:2481:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-39ea51ed3ebmr4206074f8f.1.1744417781035;
        Fri, 11 Apr 2025 17:29:41 -0700 (PDT)
Received: from [192.168.0.234] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338db88sm100358045e9.6.2025.04.11.17.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 17:29:40 -0700 (PDT)
Message-ID: <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
Date: Sat, 12 Apr 2025 02:29:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP
 monitoring with ovs.
To: Jay Vosburgh <jv@jvosburgh.net>, David J Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 Adrian Moreno <amorenoz@redhat.com>, Hangbin Liu <haliu@redhat.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com> <3885709.1744415868@famine>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <3885709.1744415868@famine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/25 1:57 AM, Jay Vosburgh wrote:
> David J Wilder <wilder@us.ibm.com> wrote:
> 
>> Adding limited support for the ARP Monitoring feature when ovs is
>> configured above the bond. When no vlan tags are used in the configuration
>> or when the tag is added between the bond interface and the ovs bridge arp
>> monitoring will function correctly. The use of tags between the ovs bridge
>> and the routed interface are not supported.
> 
> 	Looking at the patch, it isn't really "adding support," but
> rather is disabling the "is this IP address configured above the bond"
> checks if the bond is a member of an OVS bridge.  It also seems like it
> would permit any ARP IP target, as long as the address is configured
> somewhere on the system.
> 
> 	Stated another way, the route lookup in bond_arp_send_all() for
> the target IP address must return a device, but the logic to match that
> device to the interface stack above the bond will always succeed if the
> bond is a member of any OVS bridge.
> 
> 	For example, given:
> 	
> [ eth0, eth1 ] -> bond0 -> ovs-br -> ovs-port IP=10.0.0.1
> eth2 IP=20.0.0.2
> 
> 	Configuring arp_ip_target=20.0.0.2 on bond0 would apparently
> succeed after this patch is applied, and the bond would send ARPs for
> 20.0.0.2.
> 
>> For example:
>> 1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported
>> 2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.
>> 3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not supported.
>>
>> Configurations #1 and #2 were tested and verified to function corectly.
>> In the second configuration the correct vlan tags were seen in the arp.
> 
> 	Assuming that I'm understanding the behavior correctly, I'm not
> sure that "if OVS then do whatever" is the right way to go, particularly
> since this would still exhibit mysterious failures if a VLAN is
> configured within OVS itself (case 3, above).

Note: vlan can also be pushed or removed by the OpenFlow pipeline within
openvswitch between the ovs-port and the bond0.  So, there is actually no
reliable way to detect the correct set of vlan tags that should be used.
And also, even if the IP is assigned to the ovs-port that is part of the
same OVS bridge, there is no guarantee that packets routed to that IP can
actually egress from the bond0, as the forwarding rules inside the OVS
datapath can be arbitrarily complex.

And all that is not limited to OVS even, as the cover letter mentions, TC
or nftables in the linux bridge or even eBPF or XDP programs are not that
different complexity-wise and can do most of the same things breaking the
assumptions bonding code makes.

> 
> 	I understand that the architecture of OVS limits the ability to
> do these sorts of checks, but I'm unconvinced that implementing this
> support halfway is going to create more issues than it solves.
> 
> 	Lastly, thinking out loud here, I'm generally loathe to add more
> options to bonding, but I'm debating whether this would be worth an
> "ovs-is-a-black-box" option somewhere, so that users would have to
> opt-in to the OVS alternate realm.

I agree that adding options is almost never a great solution.  But I had a
similar thought.  I don't think this option should be limited to OVS though,
as OVS is only one of the cases where the current verification logic is not
sufficient.

> 
> 	-J
> 
>> Signed-off-by: David J Wilder <wilder@us.ibm.com>
>> Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com>
>> ---
>> drivers/net/bonding/bond_main.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index 950d8e4d86f8..6f71a567ba37 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
>> 	struct net_device *upper;
>> 	struct list_head  *iter;
>>
>> -	if (start_dev == end_dev) {
>> +	/* If start_dev is an OVS port then we have encountered an openVswitch

nit: Strange choice to capitalize 'V'.  It should be all lowercase or a full
'Open vSwitch' instead.

>> +	 * bridge and can't go any further. The programming of the switch table
>> +	 * will determine what packets will be sent to the bond. We can make no
>> +	 * further assumptions about the network above the bond.
>> +	 */
>> +
>> +	if (start_dev == end_dev || netif_is_ovs_port(start_dev)) {
>> 		tags = kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
>> 		if (!tags)
>> 			return ERR_PTR(-ENOMEM);
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net

Best regards, Ilya Maximets.

