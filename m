Return-Path: <netdev+bounces-243876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA07CA930F
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 21:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E79B3018AB4
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D58340A69;
	Fri,  5 Dec 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UXqUMo42"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB71C8611
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764964945; cv=none; b=ruQKy1xGGsudQb4CuSxcOOJ/P1tjnN0idL0qWQ/j0FWZzhEqVHs50ZpBy1Gho+pA8qvqDNGsdjG5HcRy94WBU9kJC3A//bb+YI6Z23k61e0klfyz4lBQbPj71tlfAqcWFBuMV+UavVUjtnrpHSD4jFsenx+J6FzVaXeLdfqSRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764964945; c=relaxed/simple;
	bh=33NuVGjxUAu4dA6YjWBICF51tC00kHG2xVXcLXPXx5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqqTZgdMjDA8I3gCZTR8R9fcxuS5C7ZrwhnUTpjvTMX0nAWiYVmgceDdvCzc5jkooYWJoxUDtfSIsyvvG9QJ8/EyZHhb8X4EfkANLFxAsxZWpVfpDPpe9nIWP1/hZEQnHhQiyCXN9xRZ/R70PuankY0lKDyiFJ5u8SzlaD3DFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UXqUMo42; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+JZ72in1SjMzKDvghfOAGf8o/tTjWDZ4WQ8m82tFo1U=; b=UXqUMo42WIEDsDJvCdUkk1dtRF
	UoJLWi7t5qbP12T5A7DzL7xfeizNcyXqghe4kTNikJNai4O8RHeW8K941NOLrurvV+LrpobI4UZD2
	RDFuuIUtvArfR4kSqzmWqs3sPRPS5hUFAjTUxfXCOPcDd5alu62k8hAL37SSfNi8Eu/pdO/xhL6jc
	g4+Qt2jb3cpjNYaNxI/L1wWUW52eOsLdhg2ZQLs+yCCXP1ZNqElsNjlbbbg0soifv6SDnsjkpcWf4
	wAZVIxQ175XmhxH9GXRHHOlIizOGRvAVcsR6JkBDqHw2TYRXynKTzJTIaTJDF76WWMWG0tZjDAT8N
	thPU1Z7A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRc0Q-00000009zg1-34eJ;
	Fri, 05 Dec 2025 20:02:18 +0000
Message-ID: <ed1e07c5-0765-4868-9d39-2078c7c51e1f@infradead.org>
Date: Fri, 5 Dec 2025 12:02:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sfc: correct kernel-doc complaints
To: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-net-drivers@amd.com
References: <20251129220351.1980981-1-rdunlap@infradead.org>
 <3f391457-d43c-4bd2-bd96-a5701a08e9eb@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3f391457-d43c-4bd2-bd96-a5701a08e9eb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Edward,

On 12/5/25 9:19 AM, Edward Cree wrote:
> On 29/11/2025 22:03, Randy Dunlap wrote:
>> Fix kernel-doc warnings by adding 3 missing struct member descriptions
>> in struct efx_ef10_nic_data and removing preprocessor directives (which
>> are not handled by kernel-doc).
>>
>> Fixes these 5 warnings:
>> Warning: drivers/net/ethernet/sfc/nic.h:158 bad line: #ifdef CONFIG_SFC_SRIOV
>> Warning: drivers/net/ethernet/sfc/nic.h:160 bad line: #endif
> 
> Does kernel-doc not complain if a member is documented but the actual
>  declaration is ifdefed out?  Normal practice seems to be to move the
>  doc into another comment adjacent to the declaration so it's under
>  the same ifdef; is that unnecessary?

kernel-doc knows nothing about the kernel config (.config).
Inside a struct/union, it strips away (ignores) preprocessor lines.
So no, it does not complain.

>> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'port_id'
>>  not described in 'efx_ef10_nic_data'
>> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'vf_index'
>>  not described in 'efx_ef10_nic_data'
>> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'licensed_features'
>>  not described in 'efx_ef10_nic_data'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Edward Cree <ecree.xilinx@gmail.com>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: linux-net-drivers@amd.com
>> ---
>>  drivers/net/ethernet/sfc/nic.h |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20251128.orig/drivers/net/ethernet/sfc/nic.h
>> +++ linux-next-20251128/drivers/net/ethernet/sfc/nic.h
>> @@ -156,9 +156,10 @@ enum {
>>   * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
>>   * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
>>   * @pf_index: The number for this PF, or the parent PF if this is a VF
>> -#ifdef CONFIG_SFC_SRIOV
>> + * @port_id: port id (Ethernet address) if !CONFIG_SFC_SRIOV;
>> + *   for CONFIG_SFC_SRIOV, the VF port id
> 
> I think this is always the PF's MAC address, and is used by
>  ndo_get_phys_port_id.  On EF100 that method only exists for PFs
>  (the vfrep's ndo_get_port_parent_id also shows the PF's port_id),
>  whereas on EF10 VFs also have a phys_port_id with the PF's MAC
>  address.
> I guess the best way to summarise this for the kerneldoc comment
>  would be:
>  * @port_id: Ethernet address of owning PF, used for phys_port_id
> In our local tree we just have "@port_id: Physical port identity".
> 
>> + * @vf_index: Index of particular VF in the VF data structure
> 
> This isn't quite right; this field is the index of this VF more
>  generally within the PF's set of VFs; it's provided by firmware,
>  and passed back to firmware in various requests.
> And when it's used as an index into the VF data structure array,
>  it's the _parent PF's_ nic_data->vf that is indexed by the VF's
>  nic_data->vf_index.  (The VF's nic_data->vf is %NULL afaik.)
> Not really sure how to summarise this, other than just following
>  the pattern of @pf_index above:
>  * @vf_index: The number for this VF, or 0xFFFF if this is a VF
>  which isn't greatly informative, but we could add more to @vf:
> 
>>   * @vf: Pointer to VF data structure
> 
>  * @vf: for a PF, array of VF data structures indexed by VF's
> 	@vf_index
> 
>> -#endif
>>   * @vport_mac: The MAC address on the vport, only for PFs; VFs will be zero
>>   * @vlan_list: List of VLANs added over the interface. Serialised by vlan_lock.
>>   * @vlan_lock: Lock to serialize access to vlan_list.
>> @@ -166,6 +167,7 @@ enum {
>>   * @udp_tunnels_dirty: flag indicating a reboot occurred while pushing
>>   *	@udp_tunnels to hardware and thus the push must be re-done.
>>   * @udp_tunnels_lock: Serialises writes to @udp_tunnels and @udp_tunnels_dirty.
>> + * @licensed_features: used to enable features if the adapter is licensed for it
> 
> In our local tree we have:
>  * @licensed_features: Flags for licensed firmware features.
>  which might be better as it doesn't give the impression that the
>  driver can change this ('enable' things) — it's a bitmask that
>  comes directly from firmware.
> 
> -ed

I can just use what's in your local tree (comments above), or
would you prefer to send the patch?

Thanks for the info.
-- 
~Randy


