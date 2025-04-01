Return-Path: <netdev+bounces-178536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEAEA777C3
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E5E188D917
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39E1EA7C1;
	Tue,  1 Apr 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="sbzjVMRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F91EEA32
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499773; cv=none; b=i5xByLWi9VztiMGUU13W0E+udZAb8fW7A9WFamEUE/nOXPDDznE8rtWbph4AF0BcCc9Ym6fwxJuLu7Xw/buWL9WpoGU6m53Uz64oNO+LDaaQlR0QyK4ewLHoWXE8a5GB7KHUgjDAfB+tOuUsq6/aiRD1URcQLRgfKFTKKztm0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499773; c=relaxed/simple;
	bh=Cn+8sT/QYsmCGl3JUXA5V0dP2PcIq6LhyefrNj0pcfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv4qpQg8yT62ukuvWkNEvGnWX5iWX57vA6suxLHbCxObeuWyN7mHYH3p+UKSkruJU5QEMPGIRDz7HBnCKCUAFdg/ZI3vp1JO5GN89By7yuiaZH3V7bBlms6a7iobXANTN8lmMBOS7a12q+01qXRtZpbGz9Lf9zCtQw2pbKlHDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=sbzjVMRZ; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4ZRjPc4tQQzDqMc;
	Tue,  1 Apr 2025 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1743499764; bh=Cn+8sT/QYsmCGl3JUXA5V0dP2PcIq6LhyefrNj0pcfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sbzjVMRZUuOxHvvFDDwsbYCPovyushHcjb0evHAJqnd9vJfWJlya1BDV2qrfFG2tX
	 wSLyph40VRMjSPO7lABW+Eg8CohfnjnlShZhfvZ3LX65QLAuKDp/g1k6VCW8ryavrg
	 LRq+ang8BExjrGWUP1/ur57oTjE3Ve0rDr6shwUc=
X-Riseup-User-ID: FAD0911A4596008EF27214C2572370FE5068751742FBCCCAE64BC93A15C63CD3
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4ZRjPZ5SS5zFx0d;
	Tue,  1 Apr 2025 09:29:22 +0000 (UTC)
Message-ID: <0a43df40-cbf8-49ac-9266-19f354c1f8ea@riseup.net>
Date: Tue, 1 Apr 2025 11:29:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net-next] net: hsr: sync hw addr of slave2 according to
 slave1 hw addr on PRP
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: lukma@denx.de, wojciech.drewek@intel.com, m-karicheri2@ti.com
References: <20250328160642.3595-1-ffmancera@riseup.net>
 <05c4da9d-6701-48ef-b80b-a28646940be3@redhat.com>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <05c4da9d-6701-48ef-b80b-a28646940be3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/04/2025 11:16, Paolo Abeni wrote:
> On 3/28/25 5:06 PM, Fernando Fernandez Mancera wrote:
>> In order to work properly PRP requires slave1 and slave2 to share the
>> same MAC address. To ease the configuration process on userspace tools,
>> sync the slave2 MAC address with slave1.
>>
>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>> ---
>> NOTE: I am not sure the call_netdevice_notifiers() are needed here.
>> I am wondering, if this change makes sense in HSR too.
>> Feedback is welcome.
>> v2: specified the target tree
> 
> Please respect the 24h grace period before reposting:
> 
> https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/process/maintainer-netdev.rst#L15
> 
> Also please note that net-next is currently closed for new features due
> to the merge window. Please resent after Apr 7th.
> 
>> ---
>>   net/hsr/hsr_device.c | 2 ++
>>   net/hsr/hsr_main.c   | 9 +++++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>> index 439cfb7ad5d1..f971eb321655 100644
>> --- a/net/hsr/hsr_device.c
>> +++ b/net/hsr/hsr_device.c
>> @@ -706,6 +706,8 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>>   		 */
>>   		hsr->net_id = PRP_LAN_ID << 1;
>>   		hsr->proto_ops = &prp_ops;
>> +		eth_hw_addr_set(slave[1], slave[0]->dev_addr);
> 
> I'm unsure about this. It will have 'destructive' effect on slave[1],
> i.e. the original mac address will be permanently chaneged and will be
> up to the user-space restore it when/if removing from hsr.
> 
> I think it would be better to additionally store the original mac
> address at hsr creation time and restore it at link removal time.
> 

Yes, probably it makes more sense to restore the original MAC address at 
link removal. Thanks for the suggestion Paolo!

> Thanks,
> 
> Paolo
> 
> 


