Return-Path: <netdev+bounces-203772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E8AF7214
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3629E3B98CD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ACF2E2EE9;
	Thu,  3 Jul 2025 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sysclose.org header.i=@sysclose.org header.b="wYWJlGcV"
X-Original-To: netdev@vger.kernel.org
Received: from sysclose.org (smtp.sysclose.org [69.164.214.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778462DE6E2;
	Thu,  3 Jul 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.214.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542019; cv=none; b=KCkIidX0288sPVdRlQGVr+VLLnmpapIMLvMqQkBuHJMbBi3Y4HphxLR1+zlOXT89qzpz5oo60XdPAeUqevG50a2SquDHjXxTvPmHsP2aowKWDiha5iEOriuXVBoPpec35Gux8cgYrx2lvQhj6hk2TIBauOw/Zzt1dVkDOmlngug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542019; c=relaxed/simple;
	bh=TOKohPTb4tBgw655yIcU3rQarBR23hyIWvaTujm58uI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2pjF5pKjFx1ga8B7pL1gIt0LH+VzH8Nif6AsEEPdkMNLf/ioAxMNjWmh9lKpWqx4naN+lY4igAdh1q64513w0080m+HN/5TQalazZMKJR5WQ6aEud5lz071nMZhRtDCQuxhWI1L8KDUCPjan78LAQ5BJCpXgWPESAPLUfHGYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysclose.org; spf=pass smtp.mailfrom=sysclose.org; dkim=pass (2048-bit key) header.d=sysclose.org header.i=@sysclose.org header.b=wYWJlGcV; arc=none smtp.client-ip=69.164.214.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysclose.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysclose.org
Received: from uranium (unknown [131.100.62.92])
	by sysclose.org (Postfix) with ESMTPSA id D6A56396A5;
	Thu,  3 Jul 2025 11:26:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sysclose.org D6A56396A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysclose.org;
	s=201903; t=1751542016;
	bh=mXYVu7Hi/bd/OSmZ10ajRbQ29ztcfjFGLXOdStiCgV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wYWJlGcVO6c+b3LEnfm74rOtDnuYmKjPDDlNH2VLdC7IrHYrhPuC6C/arIO3vEiqO
	 hE41Vl7ffjP7PcDOtUM/R8cCx3KK78hPqH2QUzVxQEQXO7RGFCY2ubUVS49uGY9ocE
	 hXWzbFQvib+ucXQr4djcWn2CZL4W9wtMaipOfHI837Yf1NHsGuYXZUQ+7PzSlsR9N6
	 jDu8d5U30Or0wTsS/wIBKuJ+nGsYSqa8vOID5KJe2UFc1UT/WreYT3zqF09zWUqfaq
	 mTFpE2uyUN+kd07cB1r4jtlsKl8t/XPgOV3KAVtM1JLqMIDuaXLdCdxNEte2m+KiwC
	 DcqCnhoNANZYQ==
Date: Thu, 3 Jul 2025 08:26:53 -0300
From: Flavio Leitner <fbl@sysclose.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next] net: openvswitch: allow providing
 upcall pid for the 'execute' command
Message-ID: <20250703082653.2e102d68@uranium>
In-Reply-To: <1039a336-5f4e-4197-a27d-f91c58aa5104@ovn.org>
References: <20250627220219.1504221-1-i.maximets@ovn.org>
	<20250702105316.43017482@uranium>
	<00067667-0329-4d8c-9c9a-a6660806b137@ovn.org>
	<20250702200821.3119cb6c@uranium>
	<5c0e9359-6bdd-4d49-b427-8fd1e8802b7c@ovn.org>
	<20250703080411.21c45920@uranium>
	<1039a336-5f4e-4197-a27d-f91c58aa5104@ovn.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 13:15:17 +0200
Ilya Maximets <i.maximets@ovn.org> wrote:

> On 7/3/25 1:04 PM, Flavio Leitner wrote:
> > On Thu, 3 Jul 2025 10:38:49 +0200
> > Ilya Maximets <i.maximets@ovn.org> wrote:
> >   
> >> On 7/3/25 1:08 AM, Flavio Leitner wrote:  
> >>>>>> @@ -651,6 +654,10 @@ static int ovs_packet_cmd_execute(struct sk_buff
> >>>>>> *skb, struct genl_info *info) !!(hash & OVS_PACKET_HASH_L4_BIT));
> >>>>>>  	}
> >>>>>>  
> >>>>>> +	if (a[OVS_PACKET_ATTR_UPCALL_PID])
> >>>>>> +		upcall_pid =
> >>>>>> nla_get_u32(a[OVS_PACKET_ATTR_UPCALL_PID]);
> >>>>>> +	OVS_CB(packet)->upcall_pid = upcall_pid;    
> >>>
> >>> Since this is coming from userspace, does it make sense to check if the
> >>> upcall_pid is one of the pids in the dp->upcall_portids array?    
> >>
> >> Not really.  IMO, this would be an unnecessary artificial restriction.
> >> We're not concerned about security here since OVS_PACKET_CMD_EXECUTE
> >> requires the same privileges as the OVS_DP_CMD_NEW or the
> >> OVS_DP_CMD_SET.  
> > 
> > What if the userspace is buggy or compromised?
> > It seems netlink API will return -ECONNREFUSED and the upcall is dropped.
> > Therefore, we would be okay either way, correct?  
> 
> If the userspace is compromised, it can overwrite the upcall_portids
> and do many other things, since the userspace application here has a
> CAP_NET_ADMIN.  And if it's buggy, then the packet will be just dropped
> on validation or on the upcall, there isn't much difference.
> 
> It's a responsibility of the userspace application to make sure these
> sockets exist before passing PIDs into the kernel.  From the kernel's
> perspective dropping the upcall is completely fine.  So, yes, we should
> be OK.

ack, thanks!
--
Flavio Leitner



