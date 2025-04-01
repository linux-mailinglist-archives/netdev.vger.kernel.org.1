Return-Path: <netdev+bounces-178555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A3A778D9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990B53AB98E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9DB1F03C1;
	Tue,  1 Apr 2025 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="oEEYVXpB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55E1E5739
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503470; cv=none; b=Fn0wKs/L87dT/im0O6GKLUxY3+DBXFG35M/LIrIn2OgVIcnI5PN/23SmMtowA6auhnuC+EwM0qywVlKBJ6CXZLRXOSzxmIs6p0NxBuWNhW/GCIZtlFKJqL0rA2wuZlaBgCQXBaXyzdwGj22i3XnEtigr2uVwNEIsWayNozLoUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503470; c=relaxed/simple;
	bh=k0jkI16LBZstDPKU8dQCTQj4mV4+r8DEKIbB6+W6U9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRkQItDd9VSD8UI8xP8tWQH5eLj5GHg5UlAzSHD8MFnxfEyCNyRCdpXmIee8kXsuBURT2lUcDtz9bCevqyKaO6bDDZ+KdI67R+K9PJACh94mVWb0vFt+7WHRM8O/P7ySBL9oTsFVmQ1z4G9gInLxd5UO5D8G8ntfRDmbxivxj4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=oEEYVXpB; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4ZRkmq4qxWz9vRD;
	Tue,  1 Apr 2025 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1743503467; bh=k0jkI16LBZstDPKU8dQCTQj4mV4+r8DEKIbB6+W6U9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oEEYVXpB66jMv6tXdpY0dVCe/rqP/JRtCZejLXCoeIjwqcN0l+S5Zl6zcMzyv0jk1
	 gpLZt43MReeeEVnQPn+R/zaKec+r8TXEtTxEb92hhvXeOxDnzPY3M6JH8TQhuw2qRs
	 sHLGSjpDalPn1KqwquSkOMghauLA/scjd19DqRzA=
X-Riseup-User-ID: 20374179322ACA9CEE10313516DFBDABA90DC67AF1AFE9F7BBBCD68D2832DCA5
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4ZRkmp2tg0zFx14;
	Tue,  1 Apr 2025 10:31:05 +0000 (UTC)
Message-ID: <f3bca6aa-eac9-4ffc-9f2a-f8672c2a6df0@riseup.net>
Date: Tue, 1 Apr 2025 12:31:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: fix omitted netlink attributes when using
 RTEXT_FILTER_SKIP_STATS
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, sowmini.varadhan@oracle.com
References: <20250331163651.9282-1-ffmancera@riseup.net>
 <20250401094246.GB214849@horms.kernel.org>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <20250401094246.GB214849@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/04/2025 11:42, Simon Horman wrote:
> On Mon, Mar 31, 2025 at 06:36:51PM +0200, Fernando Fernandez Mancera wrote:
>> Using RTEXT_FILTER_SKIP_STATS should not skip non-statistics IPv6
>> netlink attributes. Move the filling of IFLA_INET6_STATS and
>> IFLA_INET6_ICMP6STATS to a helper function to avoid hitting the same
>> situation in the future.
>>
>> Fixes: d5566fd72ec1 ("rtnetlink: RTEXT_FILTER_SKIP_STATS support to avoid dumping inet/inet6 stats")
>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> 
> Hi Fernando,
> 
> I think that it would be good to describe what problem the user experiences
> without this change - yes, I can see which attributes aren't dumped,
> but what problem does that cause? Doubly so as this is marked as a bug fix.
> 

Hi Simons,

In essence userspace tools use RTEXT_FILTER_SKIP_STATS to skip the IPV6 
stats when dumping the link. As this is also skipping 
IFLA_INET6_ADDR_GEN_MODE, IFLA_INET6_TOKEN and IFLA_INET6_RA_MTU, 
usespace tools are missing non-stats information when trying to skip the 
stats only so they cannot use this mechanism properly.

E.g iproute is not rendering address generation mode after they started 
to use the filter flag or NetworkManager not able to use the filter flag 
because it would break the internal tracking of the other properties.

I will leave more time for comments and will send a V2 adjusting the 
commit message.

Thanks!
Fernando.

> Thanks!
> 


