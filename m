Return-Path: <netdev+bounces-257456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M2tI5RihWkZBAQAu9opvQ
	(envelope-from <netdev+bounces-257456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:40:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A69F9CCA
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90B063004F06
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BEC332900;
	Fri,  6 Feb 2026 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2kndpVAm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7734D17AE11;
	Fri,  6 Feb 2026 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349199; cv=none; b=u2KRTUlcKeG8p7u2KL8umUKBmtCKkTgnUu0Ei1mgZnwq2tm1N9WEXWihbiCtoRyiOuJyEc4FOrqx79Sody5x984PkOG9Ym88c26q2rfTq6brB1j4WHHlacbUkrsgq4d/wKRSRpDLznOIIKnPxbX90bvlFIlF7DRLG170bEZ4Dq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349199; c=relaxed/simple;
	bh=sKOevo7YviUtOU3HHFaP3lOHTIefeCIEb4wUYbVqhbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+Dr25iCADKmAkg5DuAxkhRQQd6Wl0HPjyjsKP3paKsaHMlLLpp9czax+pdykPuhwjKL0RYZnGDyKx68EP5cFrmjMt5UL40fSt5j+vUPsAEjdm+jj0Bgxv0ND5GrKQvZyQCy58ab1+mPd8AqGUDYE+YdgOizQY9a6AjAzIKS+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2kndpVAm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2bn5eppuQOnWJhnkPa9n20IGAzpQcRmjTUeWMTJnHpk=; b=2kndpVAmFgS5PO16kwELuWYaI1
	Dl/9jXLodCrgHGzENEdO3Tt+c34Q8odPRtzM9I0G7mDyuUjr909Pp4mL8QcpTM3YoC9InWXaocvvX
	970rbq3u4s+5vMLMr90HVMCtiXHVxGC+J/6PkGAzWHJI59Db0pM/7GJ6NMcv/Pd/ZI+c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1voCh4-006KxF-MB; Fri, 06 Feb 2026 04:39:42 +0100
Date: Fri, 6 Feb 2026 04:39:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 02/11] net/nebula-matrix: add our driver
 architecture
Message-ID: <769fbfa8-a881-403f-bc65-56c60c389185@lunn.ch>
References: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
 <20260206021608.85381-3-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206021608.85381-3-illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257456-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31A69F9CCA
X-Rspamd-Action: no action

> +static int
> +nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
> +			struct nbl_init_param *param,
> +			struct nbl_channel_mgt_leonis **chan_mgt_leonis)

It is pretty unusual to pass ** pointers. More normal would be 


> +static struct nbl_channel_mgt_leonis *
> +nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
> +			struct nbl_init_param *param)

> +{
> +	struct nbl_hw_ops_tbl *hw_ops_tbl = adapter->intf.hw_ops_tbl;
> +	struct nbl_common_info *common = &adapter->common;
	struct nbl_channel_mgt_leonis *chan_mgt_leonis;
> +	struct device *dev = &adapter->pdev->dev;
> +	struct nbl_chan_info *mailbox;
> +
> +	chan_mgt_leonis = devm_kzalloc(dev,
> +					sizeof(struct nbl_channel_mgt_leonis),
> +					GFP_KERNEL);
> +	if (!chan_mgt_leonis)
> +		goto alloc_channel_mgt_leonis_fail;
> +
> +	chan_mgt_leonis->chan_mgt->common = common;
> +	chan_mgt_leonis->chan_mgt.hw_ops_tbl = hw_ops_tbl;
> +
> +	mailbox = devm_kzalloc(dev, sizeof(struct nbl_chan_info), GFP_KERNEL);
> +	if (!mailbox)
> +		goto alloc_mailbox_fail;
> +	mailbox->chan_type = NBL_CHAN_TYPE_MAILBOX;
> +	chan_mgt_leonis->chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX] =
> +		mailbox;
> +
	return chan_mgt_leonis;
	
> +alloc_mailbox_fail:
> +alloc_channel_mgt_leonis_fail:
> +	return ERR_PTR(-ENOMEM);

This is starting to look like Linux driver code now. Lots of () have
been removed. Your aim is to make the driver look like all other
drivers in linux, by copying the common patterns.

I would probably also remove the two labels, and just due the return
ERR_PTR() inline.

Please spend some time reading other drivers. Learn from them, and
make your driver look like them.

> +#define NBL_ADAP_TO_HW_MGT(adapter) ((adapter)->core.hw_mgt)
> +#define NBL_ADAP_TO_RES_MGT(adapter) ((adapter)->core.res_mgt)
> +#define NBL_ADAP_TO_DISP_MGT(adapter) ((adapter)->core.disp_mgt)
> +#define NBL_ADAP_TO_DEV_MGT(adapter) ((adapter)->core.dev_mgt)
> +#define NBL_ADAP_TO_CHAN_MGT(adapter) ((adapter)->core.chan_mgt)

I would suggest removing these. Just use adapter->core.chan_mgt
directly in the code. Using macros normally means there is some magic
involved, but this is just plain pointers, nothing magical.

> +int nbl_hw_init_leonis(struct nbl_adapter *adapter,
> +		       struct nbl_init_param *param)
> +{
> +	struct nbl_hw_ops_tbl **hw_ops_tbl = &adapter->intf.hw_ops_tbl;
> +	struct nbl_common_info *common = &adapter->common;
> +	struct nbl_hw_mgt_leonis **hw_mgt_leonis;
> +	struct pci_dev *pdev = common->pdev;
> +	struct nbl_hw_mgt *hw_mgt;
> +	int bar_mask;
> +	int ret = 0;
> +
> +	hw_mgt_leonis =
> +		(struct nbl_hw_mgt_leonis **)&NBL_ADAP_TO_HW_MGT(adapter);

Why the cast? Cast like this suggest your data structure design is not
correct.

> +static inline u32 rd32(u8 __iomem *addr, u64 reg)
> +{
> +	return readl(addr + (reg));
> +}
> +
> +static inline void wr32_barrier(u8 __iomem *addr, u64 reg, u32 value)
> +{
> +	writel((value), (addr + (reg)));
> +}

Why _barrier here for write, but not for rd32()? readl() has a barrier
same as writel()? Should rd32 actually be using readl_relaxed()?

> +static inline void nbl_hw_rd_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u8 *data,
> +				  u32 len)
> +{
> +	u32 size = len / 4;
> +	u32 i = 0;
> +
> +	if (len % 4)
> +		return;

It is actually a bug?

> +
> +	spin_lock(&hw_mgt->reg_lock);
> +
> +	for (i = 0; i < size; i++)
> +		*(u32 *)(data + i * sizeof(u32)) =
> +			rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
> +	spin_unlock(&hw_mgt->reg_lock);
> +}

This function is a bit big for inline. Have you used bloat-o-meter to
look at the size with this and the next as functions vs inline?

> +static inline void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
> +				  const u8 *data, u32 len)
> +{
> +	u32 size = len / 4;
> +	u32 i = 0;
> +
> +	if (len % 4)
> +		return;
> +	spin_lock(&hw_mgt->reg_lock);
> +	for (i = 0; i < size; i++)
> +		/* Used for emu, make sure that we won't write too frequently */
> +		wr32_barrier(hw_mgt->hw_addr, reg + i * sizeof(u32),
> +			     *(u32 *)(data + i * sizeof(u32)));
> +	spin_unlock(&hw_mgt->reg_lock);
> +}

	Andrew

