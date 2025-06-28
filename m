Return-Path: <netdev+bounces-202107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FFDAEC3B5
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 03:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAED1C27FA8
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 01:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1419F461;
	Sat, 28 Jun 2025 01:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHEZ5xZr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CEA19E992
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 01:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751072602; cv=none; b=gGwWqP1pxmKS//PUkeqkNC1YYIbOtlt3d75fWpsvQuorbKOqcoIde8a90wUaYw/d36sz2dPJgcripplUyzIkv1zgR5ZohZRQx0hYfDTNxgVbJZDHoQLSEqwPZYg0Mxz+XmABaXiumlbczWEtgNEgJcAAFIm5soZ/iLsO9uY1Gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751072602; c=relaxed/simple;
	bh=hT995olCCiK8O+OrX2pV6hMiJU2+mfjhkM9/pNzUN+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8ySza7RDlFXGdiE4w2or1dOlWp+iF/PZ+tbjCDBUwFmekb27AAEuNpDJCpzdwCkZPnwSPOyLLoayZgXV3a9Ww2lPZ6oTY4ZW2tK/WNtoycJjyhB+LwDEJbGRT4sONUHtlO9ULbSJXJGN+vwcwOFJhwPjsnuuh1lds1CuFOJKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHEZ5xZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DABC4CEE3;
	Sat, 28 Jun 2025 01:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751072602;
	bh=hT995olCCiK8O+OrX2pV6hMiJU2+mfjhkM9/pNzUN+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GHEZ5xZrZXV2rfKFbXpo7AwJuQNjJ78RBrMxczzIg7cGxCo0C1KIxihLEPqzLW3VG
	 hkTn+mQHDRd9beLQbcpN3UfpeEr/S/uwEIrVwUmbX18qajRdRhrQt4GM35GefQoXFF
	 JknGwbzDDDghOibfsjYJ4VziDE1X/3ouDTZt2Bj6seoKeNmarY0BdMYV2oJyqnXGVT
	 9XEeaBsXbZbwCaKZDyOLxfzPKAxIdDRzxE2Qqv4lhriLHPKxz1mAnxYMQlyboxS6qa
	 tFRN8B1TVjiaiBXS63zjQfWNniMrJ+oprWdbMeTL7vFyGaJCMjE0R9dJYrerexxB+x
	 OqG7bvqp5fr5g==
Date: Fri, 27 Jun 2025 18:03:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
 pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
 haliu@redhat.com
Subject: Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <20250627180321.57f4da7f@kernel.org>
In-Reply-To: <20250627201914.1791186-1-wilder@us.ibm.com>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 13:17:13 -0700 David Wilder wrote:
> The current implementation of the arp monitor builds a list of vlan-tags by
> following the chain of net_devices above the bond. See bond_verify_device_path().
> Unfortunately, with some configurations, this is not possible. One example is
> when an ovs switch is configured above the bond.
> 
> This change extends the "arp_ip_target" parameter format to allow for a list of
> vlan tags to be included for each arp target. This new list of tags is optional
> and may be omitted to preserve the current format and process of discovering
> vlans.
> 
> The new format for arp_ip_target is:
> arp_ip_target ipv4-address[vlan-tag\...],...
> 
> For example:
> arp_ip_target 10.0.0.1[10/20]
> arp_ip_target 10.0.0.1[] (used to disable vlan discovery)
> 
> The extended format of arp_ip_target is only supported by using the ip command when
> creating the bond. Module parameters and the sysfs file do not allow the use of the
> extended format.
> 
> Changes since V3:
> 
> 1) Moved the parsing of the extended arp_ip_target out of the kernel and into
>    userspace (ip command). A separate patch to iproute2 to follow shortly.
> 2) Split up the patch set to make review easier.

This appears to trigger the following warning when running the newly
added tests (BTW please run shellcheck on the test, too):

[ 1315.127007][ T9889] WARNING: CPU: 2 PID: 9889 at lib/vsprintf.c:2802 vsnprintf+0xa76/0x1050
[ 1315.127471][ T9889] Modules linked in: [last unloaded: netdevsim]
[ 1315.127908][ T9889] CPU: 2 UID: 0 PID: 9889 Comm: grep Not tainted 6.16.0-rc3-virtme #1 PREEMPT(full) 
[ 1315.128709][ T9889] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 1315.129070][ T9889] RIP: 0010:vsnprintf+0xa76/0x1050
[ 1315.129378][ T9889] Code: 01 89 44 24 50 83 e8 01 89 44 24 7c 85 c0 7f c2 4c 89 f8 48 c1 e8 03 42 0f b6 04 08 84 c0 0f 85 72 fa ff ff e9 75 fa ff ff 90 <0f> 0b 90 e9 f1 f7 ff ff 48 8b 44 24 28 80 38 00 0f 85 a7 04 00 00
[ 1315.130388][ T9889] RSP: 0018:ffffc90001227970 EFLAGS: 00010286
[ 1315.130749][ T9889] RAX: 0000000000000000 RBX: fffff52000244f4c RCX: ffffc90001227a80
[ 1315.131233][ T9889] RDX: ffffffffb80db4e0 RSI: ffffffffffffffff RDI: 1ffff92000244f39
[ 1315.131654][ T9889] RBP: ffffc90001227a50 R08: ffffffffb80db4a1 R09: ffffffffb6e54d12
[ 1315.132073][ T9889] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[ 1315.132509][ T9889] R13: 000000000000000c R14: ffffffffb6e54ce0 R15: ffffc90001227ba0
[ 1315.132937][ T9889] FS:  00007f554d21e740(0000) GS:ffff88807bb4d000(0000) knlGS:0000000000000000
[ 1315.133437][ T9889] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1315.133794][ T9889] CR2: 000055c1198c67f8 CR3: 000000000ca1b001 CR4: 0000000000772ef0
[ 1315.134244][ T9889] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1315.134968][ T9889] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1315.135406][ T9889] PKRU: 55555554
[ 1315.135626][ T9889] Call Trace:
[ 1315.135843][ T9889]  <TASK>
[ 1315.136005][ T9889]  ? __pfx_vsnprintf+0x10/0x10
[ 1315.136310][ T9889]  ? __pfx_bond_opt_parse+0x10/0x10
[ 1315.136602][ T9889]  snprintf+0xa1/0xd0
[ 1315.136823][ T9889]  ? __pfx_snprintf+0x10/0x10
[ 1315.137133][ T9889]  ? bond_opt_parse+0x32/0x6e0
[ 1315.137414][ T9889]  ? bond_opt_parse+0x30/0x6e0
[ 1315.137696][ T9889]  bond_info_show_master+0x84c/0x1140
[ 1315.137977][ T9889]  ? bond_opt_parse+0x32/0x6e0
[ 1315.138276][ T9889]  ? __pfx_bond_info_show_master+0x10/0x10
[ 1315.138625][ T9889]  ? __pfx_seq_printf+0x10/0x10
[ 1315.138917][ T9889]  ? __pfx_bond_info_seq_start+0x10/0x10
[ 1315.139218][ T9889]  bond_info_seq_show+0x43/0x50
[ 1315.139507][ T9889]  seq_read_iter+0x40e/0x1090
[ 1315.139805][ T9889]  proc_reg_read_iter+0x1a3/0x270
[ 1315.140100][ T9889]  vfs_read+0x75a/0xce0
[ 1315.140324][ T9889]  ? vfs_getattr_nosec+0x2c0/0x3e0
[ 1315.140608][ T9889]  ? __pfx_vfs_read+0x10/0x10
[ 1315.140896][ T9889]  ? __do_sys_newfstat+0x7b/0xc0
[ 1315.141201][ T9889]  ksys_read+0xf7/0x1d0
-- 
pw-bot: cr

