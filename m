Return-Path: <netdev+bounces-264248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB1FLFdNqWk14AAAu9opvQ
	(envelope-from <netdev+bounces-264248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:31:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE7C20E6CE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A240300BE06
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449AD346AFB;
	Thu,  5 Mar 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqvccO2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266A18A92F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703056; cv=none; b=MMUUzWvb3fg5Ww5keqGidteI6+zJJunK7CynLF0Bv0jVt0MGqooFp3MjZKlymrRYL6PkDRalY5RTL6bmfjSkblxIe5bygERKPxVG2aOTNa6sMLfUWfPfVZ7kISeryNkbB+P/CA2L/FdM33BkHfqzYuzI6df3cLxd7eYWMWGIRzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703056; c=relaxed/simple;
	bh=2b1eWPC49WnzEkK2zp9nESZ7FeyXoj/88zwhNB7MJhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF3TLl87z1UHWrH0+Xeg3+wttTFRV73PbahPUrNyWedYf9+EfWtf4KzzAvA+7T9HbVDRLh03BroEnjkvhvaVr3gliPlzZerKcNgKSVr/qAp4jffnCfxldZQYPos210FsxOrab41wwOkOVA+a4VcpAAm/BuqkoDz8f2eByTQ84N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqvccO2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3F0C116C6;
	Thu,  5 Mar 2026 09:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772703055;
	bh=2b1eWPC49WnzEkK2zp9nESZ7FeyXoj/88zwhNB7MJhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqvccO2V4yW8Qla55RUDyFGDyZ4LlRg1amcoSpYDapttyd8FJxEJRoe9pyT/IXm2C
	 bEGzA/cfV9lI3JdP9jIn8H1RihSY9YtyWCZUdxINykMUk7peDOxtuvDo8IRHJtZMVL
	 bwwbgKLw10BL9JsqKjxeC400LG4ZScDj2zz0fm0xWNwDFk2VUK7HQsHWjFdLSBokNx
	 BzB/3oJ96sNFv4jpI/3DjJHnfi6ETBPfPzWxZ3u7kG8gYcwU966sVL+1WjojKAQyVY
	 TgFTXaRq4/1+rqpdqOo4IRZfdvT81XYItsU2nCJIEHuyUT4VNbW7O/1zOHWYxjFKR7
	 dfS9Ras3aHQYQ==
Date: Thu, 5 Mar 2026 09:30:51 +0000
From: Simon Horman <horms@kernel.org>
To: Joshua Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: clear stale cdev_info ptr
Message-ID: <20260305093051.GB90938@kernel.org>
References: <20260303012831.662492-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303012831.662492-1-joshua.a.hay@intel.com>
X-Rspamd-Queue-Id: 6CE7C20E6CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264248-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 05:28:31PM -0800, Joshua Hay wrote:
> Deinit calls idpf_idc_deinit_core_aux_device to free the cdev_info
> memory, but leaves the adapter->cdev_info field with a stale pointer
> value. This will bypass subsequent "if (!cdev_info)" checks if cdev_info
> is not reallocated. For example, if idc_init fails after a reset,
> cdev_info will already have been freed during the reset handling, but it
> will not have been reallocated. The next reset or rmmod will result in a
> crash.
> 
> [  +0.000008] BUG: kernel NULL pointer dereference, address: 00000000000000d0
> [  +0.000033] #PF: supervisor read access in kernel mode
> [  +0.000020] #PF: error_code(0x0000) - not-present page
> [  +0.000017] PGD 2097dfa067 P4D 0
> [  +0.000017] Oops: Oops: 0000 [#1] SMP NOPTI
> ...
> [  +0.000018] RIP: 0010:device_del+0x3e/0x3d0
> [  +0.000010] Call Trace:
> [  +0.000010]  <TASK>
> [  +0.000012]  idpf_idc_deinit_core_aux_device+0x36/0x70 [idpf]
> [  +0.000034]  idpf_vc_core_deinit+0x3e/0x180 [idpf]
> [  +0.000035]  idpf_remove+0x40/0x1d0 [idpf]
> [  +0.000035]  pci_device_remove+0x42/0xb0
> [  +0.000020]  device_release_driver_internal+0x19c/0x200
> [  +0.000024]  driver_detach+0x48/0x90
> [  +0.000018]  bus_remove_driver+0x6d/0x100
> [  +0.000023]  pci_unregister_driver+0x2e/0xb0
> [  +0.000022]  __do_sys_delete_module.isra.0+0x18c/0x2b0
> [  +0.000025]  ? kmem_cache_free+0x2c2/0x390
> [  +0.000023]  do_syscall_64+0x107/0x7d0
> [  +0.000023]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Pass the adapter struct into idpf_idc_deinit_core_aux_device instead and
> clear the cdev_info ptr.
> 
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


