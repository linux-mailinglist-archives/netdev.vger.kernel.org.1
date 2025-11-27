Return-Path: <netdev+bounces-242247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEA8C8E158
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2654134FA5F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40832C95F;
	Thu, 27 Nov 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHp8Wbcu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8932D0DF
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243902; cv=none; b=LOaorkGEfkOoghV3/GlVF4XWKAz/gwcCNOYIZEL+25Djv5JyMbTnrD6rUAov4krZ7/CIelTvtThkuH04/fQl/Agt1QZOYfhE76t8dCnsVSN+fWQf3phSMCdraFCb0maPtLzrFtLfBMz3T10BEnvhVz3m0YCgMlBzxNSE5C/5Svg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243902; c=relaxed/simple;
	bh=bhEiLZJrUMZE5RAfsENKBxd0m7eM54hwM9QpdUvUm44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWduPJyFMW5LRiAub4y9xllS7I5SXdbJhRMDwctRfpT4I0td2sMns8aJzmYAkaq7DHE/9HphwctSkFwd+K5o6zZhgKUCh0jxZtHdf9dElns5uj7RNiELNrk4Zre8O4NL9dwpynucHVd9U120YN5n+uC0pT+n5U1Sie1zMiOY9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHp8Wbcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18DBC4CEF8;
	Thu, 27 Nov 2025 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764243902;
	bh=bhEiLZJrUMZE5RAfsENKBxd0m7eM54hwM9QpdUvUm44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHp8WbcuOlkfl9aApJ2sX4htFuk9y4kYsjirnlH9RFfdwzGWCW5H+yTllSh1QQZAM
	 q+CJz8eiHUg09XWsp3N1R+iO+FemrSz9Azi3hPVHzsbNRTSZ2WWf/kX4vpfR0LYUpi
	 ZE3I4NtTABE98WcpfcMVwOe1wO/b3GflE9FY7y+Z4IGyPwCel29aX/7Sqj43+/ZZXa
	 R/NVh144ENx0Jgc+UcrAtWEsmHQu7YbqWx+0jd1eERRD4qB6Kd+10LS14JFGJClfql
	 RA62517drMCuRjOZqtRw+OHcUEeb+6SDJngBKajgmV4fAhtakpcLoxGIClo9pl2Mcb
	 OHl4PjlJUxAXQ==
Date: Thu, 27 Nov 2025 11:44:58 +0000
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH iwl-net v2 1/3] idpf: Fix RSS LUT NULL pointer crash on
 early ethtool operations
Message-ID: <aSg5uiOiAyRds6gM@horms.kernel.org>
References: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
 <20251124184750.3625097-2-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124184750.3625097-2-sreedevi.joshi@intel.com>

On Mon, Nov 24, 2025 at 12:47:48PM -0600, Sreedevi Joshi wrote:
> The RSS LUT is not initialized until the interface comes up, causing
> the following NULL pointer crash when ethtool operations like rxhash on/off
> are performed before the interface is brought up for the first time.
> 
> Move RSS LUT initialization from ndo_open to vport creation to ensure LUT
> is always available. This enables RSS configuration via ethtool before
> bringing the interface up. Simplify LUT management by maintaining all
> changes in the driver's soft copy and programming zeros to the indirection
> table when rxhash is disabled. Defer HW programming until the interface
> comes up if it is down during rxhash and LUT configuration changes.
> 
> Steps to reproduce:
> ** Load idpf driver; interfaces will be created
> 	modprobe idpf
> ** Before bringing the interfaces up, turn rxhash off
> 	ethtool -K eth2 rxhash off
> 
> [89408.371875] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [89408.371908] #PF: supervisor read access in kernel mode
> [89408.371924] #PF: error_code(0x0000) - not-present page
> [89408.371940] PGD 0 P4D 0
> [89408.371953] Oops: Oops: 0000 [#1] SMP NOPTI
> <snip>
> [89408.372052] RIP: 0010:memcpy_orig+0x16/0x130
> [89408.372310] Call Trace:
> [89408.372317]  <TASK>
> [89408.372326]  ? idpf_set_features+0xfc/0x180 [idpf]
> [89408.372363]  __netdev_update_features+0x295/0xde0
> [89408.372384]  ethnl_set_features+0x15e/0x460
> [89408.372406]  genl_family_rcv_msg_doit+0x11f/0x180
> [89408.372429]  genl_rcv_msg+0x1ad/0x2b0
> [89408.372446]  ? __pfx_ethnl_set_features+0x10/0x10
> [89408.372465]  ? __pfx_genl_rcv_msg+0x10/0x10
> [89408.372482]  netlink_rcv_skb+0x58/0x100
> [89408.372502]  genl_rcv+0x2c/0x50
> [89408.372516]  netlink_unicast+0x289/0x3e0
> [89408.372533]  netlink_sendmsg+0x215/0x440
> [89408.372551]  __sys_sendto+0x234/0x240
> [89408.372571]  __x64_sys_sendto+0x28/0x30
> [89408.372585]  x64_sys_call+0x1909/0x1da0
> [89408.372604]  do_syscall_64+0x7a/0xfa0
> [89408.373140]  ? clear_bhb_loop+0x60/0xb0
> [89408.373647]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [89408.378887]  </TASK>
> <snip>
> 
> Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Reviewed-by: Simon Horman <horms@kernel.org>


