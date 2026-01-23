Return-Path: <netdev+bounces-252631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKfAD/bxcmlrrQAAu9opvQ
	(envelope-from <netdev+bounces-252631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:58:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16570382
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18725301911A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BFA38B9B7;
	Fri, 23 Jan 2026 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OZJRFM+m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D22F3636;
	Fri, 23 Jan 2026 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769140720; cv=none; b=DRs/h8TZit7iytaLAbGiPbgUqip1IyQ7QxKP4Cp6GejWfbphOZ2H4ZZ/Y5x6tzg5F0WXwNp9JMuH+XstGbpecmshkQyiH9wcgRfhoG5I3RbDrUfS3KGYjjdhQ2tHZz+QhThUlvQ8hcuyFe6Q3hcfMaECVusJI/S2xcaHmbqPWgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769140720; c=relaxed/simple;
	bh=BAI+EjaSfxcJvZxjB7J+YyaGw88SdVkkLWVtadPgy2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOM8Qh8NM/TU32YoNoRItqvUAw2fQcdLqMmRkoqw94sKhDlagFr/yQ37ldJxpf+8YacvPAw2WL65sDHxcTQ5xPdoB9Qe75qis+WXW+QMJMlvX3hm4fxrFcQAzY0k3B2KDO6dZMYvK5x4cLN/cxLKAcoaNENKCUHqFN4WbcgPKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OZJRFM+m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wyEqaKQNSoyNzMdCqVbM+n+7F7wWHIRNo+JawxvUS6o=; b=OZJRFM+mQAt3LONy9Cv72cYlIS
	BWltBftnBT1OL2DGpGa+QcXpGm/5sF/fMCX1tRXmfYgkv4fWwDR6ofDnUMmhrskaX8XfF15NsPwps
	mLTI1fjjSFlWznnhx4j2SHdmnEDHqSvy3m+ljVtXg63YyOhqpLAV8p4bo1aFSNuNStuY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vj8J3-0044CJ-Ll; Fri, 23 Jan 2026 04:57:57 +0100
Date: Fri, 23 Jan 2026 04:57:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, hawk@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, sdf@fomichev.me, daniel@iogearbox.net,
	john.fastabend@gmail.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 02/15] net/nebula-matrix: add our driver
 architecture
Message-ID: <c6d37ecd-7dc6-4f83-b76c-2735a5f116fd@lunn.ch>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
 <20260123011804.31263-3-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123011804.31263-3-illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252631-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB16570382
X-Rspamd-Action: no action

> +	NBL_CHAN_MGT_TO_COMMON(&(*chan_mgt_leonis)->chan_mgt) = common;

Macros on the left hand side is pretty unusual. Why is it needed?

The cast suggests your types are messed up. You should not need casts.

> +#define nbl_err(common, fmt, ...)					\
> +do {									\
> +	typeof(common) _common = (common);				\
> +		dev_err(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);\
> +} while (0)

You should probably remove these and just use dev_err() or
netdev_err() directly.

> +#define NBL_COMMON_TO_PDEV(common)		((common)->pdev)
> +#define NBL_COMMON_TO_DEV(common)		((common)->dev)
> +#define NBL_COMMON_TO_DMA_DEV(common)		((common)->dma_dev)
> +#define NBL_COMMON_TO_VSI_ID(common)		((common)->vsi_id)
> +#define NBL_COMMON_TO_ETH_ID(common)		((common)->eth_id)
> +#define NBL_COMMON_TO_ETH_MODE(common)		((common)->eth_mode)
> +#define NBL_COMMON_TO_DEBUG_LVL(common)		((common)->debug_lvl)
> +
> +#define NBL_COMMON_TO_OCP_CAP(common)		((common)->is_ocp)
> +#define NBL_COMMON_TO_PCI_USING_DAC(common)	((common)->pci_using_dac)
> +#define NBL_COMMON_TO_MGT_PF(common)		((common)->mgt_pf)
> +#define NBL_COMMON_TO_PCI_FUNC_ID(common)	((common)->function)
> +#define NBL_COMMON_TO_LOGIC_ETH_ID(common)	((common)->logic_eth_id)

These are all just obfuscation. Please remove them. And not just
these. All of them. Such macros don't help.

> +int nbl_dev_init(void *p, struct nbl_init_param *param);
> +void nbl_dev_remove(void *p);
> +int nbl_dev_start(void *p, struct nbl_init_param *param);
> +void nbl_dev_stop(void *p);

Using a void * as a parameter for something like nbl_dev_start() and
nbl_dev_stop() is a red flag. You should know they type you are
passing to functions like this. In general, you want the compiler to
be doing type checking for you, so you need real types.

> +struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
> +				  struct nbl_init_param *param)
> +{
> +	struct nbl_adapter *adapter;
> +	struct nbl_common_info *common;
> +	struct nbl_product_base_ops *product_base_ops;
> +	int ret = 0;

Reverse Christmas tree. That applies to all functions.

> +
> +	if (!pdev)
> +		return NULL;

Can that happen? Don't have defensive code. If there is a real reason
this could be NULL then fine, but you might want to add a comment why
it can happen. But if this is not actually expected let pdev be
dereferenced, get the Opps, so you can debug your driver. And i don't
mean this one instance. I mean all similar tests in the driver. No
defensive code, it just hides bugs.

> +void nbl_core_remove(struct nbl_adapter *adapter)
> +{
> +	struct nbl_product_base_ops *product_base_ops;
> +	struct device *dev;
> +
> +	dev = NBL_ADAP_TO_DEV(adapter);
> +	product_base_ops = NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter);
> +	nbl_dev_remove(adapter);
> +	nbl_serv_remove(adapter);
> +	nbl_disp_remove(adapter);
> +	product_base_ops->res_remove(adapter);
> +	product_base_ops->chan_remove(adapter);
> +	product_base_ops->hw_remove(adapter);
> +	devm_kfree(dev, adapter);

Calling devm_kfree() is unusual. Why do you do this? I suggests you
don't understand what devm_ actually does. Which is pretty scary if
you have such a basic thing wrong for a driver this size.

>  static int nbl_probe(struct pci_dev *pdev,
>  		     const struct pci_device_id __always_unused *id)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct nbl_adapter *adapter = NULL;
> +	struct nbl_init_param param = {{0}};
> +	int err;
>  
> +	if (pci_enable_device(pdev)) {
> +		dev_err(&pdev->dev, "Failed to enable PCI device\n");
> +		return -ENODEV;
> +	}
> +
> +	param.pci_using_dac = true;
> +	nbl_get_func_param(pdev, id->driver_data, &param);
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_err(dev, "Configure DMA 64 bit mask failed, err = %d\n",
> +			err);

dev_err() is usually for a fatal error. Here you just keep going, so
it is not really an error. dev_dbg()?

    Andrew

---
pw-bot: cr

