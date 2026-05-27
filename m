Return-Path: <netdev+bounces-292213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOMGHvu4FmqLqAcAu9opvQ
	(envelope-from <netdev+bounces-292213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:27:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C555E1CA9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC805300FB41
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F63E5590;
	Wed, 27 May 2026 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/SfWJ+Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCD2D3A93;
	Wed, 27 May 2026 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874035; cv=none; b=Qnyan0GgXr6dlHiKoLe3p6SPRkejdgFlX3jRKRSNz22mFOwKgDezZCl29R6vvMsSCfgYxMd5UXeSRX0Zt5NugtYX/sGrp73jX+4oqUMtcOeOcL+4Tp3QpdDuGvJKG316dVMow7fB5ic+o9f/FHoKRyrylfUHv2mZcVwc2rQR1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874035; c=relaxed/simple;
	bh=0tvDL2IAn62HZEC54ZsDshqEo5CwsGArj0lp2/gjcaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohoZi7vbTRejjqsRpshfwgaAgNW2oUMIZRjXIvidmiLkTQW3/NmreuHF9D5hhSPLeV1lgZ8bR+FtTM/IGJBL9ukP2V9wlnUc1Ho04qyc4kW5iIfPuzWMl7a0aIPEOMoWO4n0KWZnMGufSX1MuBgIlljBOcREmCc+cVrom0dFvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/SfWJ+Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD4C1F000E9;
	Wed, 27 May 2026 09:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779874032;
	bh=WryULfv/eGqjjGzDnG4q1WpI/mtGthnFt2FK5mweAgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P/SfWJ+QjANyOpFhdQ7fUuARfFFcqN/j0PWor4Z2U6vSFErKWGfwXRPfYMBunkSwG
	 uBvhmIZNoS5nj8uiXrHnCvCkJewT+vNMi5sbIhm6U3uI3q8lvu3l7n/ELPVW4aLdEg
	 XwW8eKTPPR2KvoY4dSLoAVrWVDL/3FDdyGknum1Y/IbiwTTyUMJcEbaZ9wKQOnIhHB
	 /9wT2N+3vlgLDMnLmeThLfD64O/2cIyds8YJkfhxQpvhA3CFDVxufv4BW/x1Da6Ovf
	 ROA9xJd8jPLXJj+qpvDAar9LwPIVFPlMbwGsOyXoLj/TQYCgCiRwjuUvOguC90nWf1
	 9f5JQSRancLfQ==
Date: Wed, 27 May 2026 10:27:08 +0100
From: Simon Horman <horms@kernel.org>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v4 1/2] net/ethernet: add ZTE network driver
 support
Message-ID: <20260527092708.GG2256768@horms.kernel.org>
References: <20260523174117467bbQo_yaI9XS_2nfd7pO6u@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523174117467bbQo_yaI9XS_2nfd7pO6u@zte.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292213-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zte.com.cn:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: E7C555E1CA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 05:41:17PM +0800, han.junyang@zte.com.cn wrote:
> From: Junyang Han <han.junyang@zte.com.cn>
> 
> Add basic framework for ZTE DingHai ethernet PF driver, including
> Kconfig/Makefile build support and PCIe device probe/remove skeleton.
> 
> Signed-off-by: Junyang Han <han.junyang@zte.com.cn>

I think that a better prefix for this patch would be dinghai

Subject: [PATCH ...] dinghai: ...

And I would this for patch 2/2 too.

...

> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c

...

> +static int dh_pf_pci_init(struct dh_core_dev *dev)

...

> +	if (!pf_dev->pci_ioremap_addr[0]) {
> +		ret = -ENOMEM;
> +		dev_err(dev->device, "ioremap(0x%llx, 0x%llx) failed\n",
> +			pci_resource_start(dev->pdev, 0),
> +				pci_resource_len(dev->pdev, 0));

For ARM allmodconfig builds, Clang 22.1.0 complains that:

drivers/net/ethernet/zte/dinghai/en_pf.c:70:4: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
   69 |                 dev_err(dev->device, "ioremap(0x%llx, 0x%llx) failed\n",
      |                                                 ~~~~
      |                                                 %x
   70 |                         pci_resource_start(dev->pdev, 0),
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Looking at Documentation/core-api/printk-formats.rst, I expect the solution
is to use %pa[p] as the format specifier.

...

