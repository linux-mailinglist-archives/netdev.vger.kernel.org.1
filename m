Return-Path: <netdev+bounces-229385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67DBDB9A6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 00:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DF2424760
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF212FA0C6;
	Tue, 14 Oct 2025 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KePzjVzV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706D2E9EC2;
	Tue, 14 Oct 2025 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480245; cv=none; b=Hb9kEQmT+4Wr5FRDuLTvDI2My7oJl6yNaeBLq9e2Pky1HaXvcZe7IbB2j9zOLALZLvdZWSR+ZczxjaPSzLcaaOUIo9PS3Nb+RaggneLOe6rAfzWAkfo4vNo0zIcHyC0jTjLpf5r9AjqjKLFYMBCIMS3qmW8/pYjnd5cRt0DS84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480245; c=relaxed/simple;
	bh=katvt13dVXtYGocpba3qf59z78OYCZZb5opiHayU8/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO6v6Zgoev9XSaPcDYcPhIyyfuzq4Yi3oMgQsUc99FvK0q8VXTOaKTKqAmP+KN5MDjnzNZMDFgED/18kqgb4/q7CL39JR4G2LoTr6UOrRXVmVO41YmvNcydkfDj+9DeHkO/u97YIQr1U2U/1je+63uW3ThcT62Gb0nvV6dejSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KePzjVzV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6apl9zwMRvC9w1MSyQud4IEH3rhHD5ExcGX4ewXJTBU=; b=KePzjVzVewfO8IGELrYbs2T5+F
	Oh1qgYg1Zfwt5FY2GboRh/APnHibBpV0bmoaZbgERvoSe0R6dJVK3LGi6hZGjsvZzhWoO6lsnbxyo
	sCAtIzy5Eg3mX22+ZRgZcZLQ6FUW1wTgOVzRjFxjj9N+js1m/W8snRKsW12O+/IA7XwE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8nKU-00AxTN-PQ; Wed, 15 Oct 2025 00:17:14 +0200
Date: Wed, 15 Oct 2025 00:17:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, basharath@couthit.com,
	afd@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, pratheesh@ti.com,
	prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
	rogerq@ti.com, krishna@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v3 2/3] net: ti: icssm-prueth: Adds switchdev
 support for icssm_prueth driver
Message-ID: <ce87a72f-09b3-4615-aab9-2be8648300f8@lunn.ch>
References: <20251014124018.1596900-1-parvathi@couthit.com>
 <20251014124018.1596900-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014124018.1596900-3-parvathi@couthit.com>

> +static struct prueth_fw_offsets fw_offsets_v2_1;
> +
> +static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
> +{
> +	/* Set VLAN/Multicast filter control and table offsets */
> +	if (PRUETH_IS_EMAC(prueth)) {
> +		prueth->fw_offsets->mc_ctrl_byte  =
> +			ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET;
> +		prueth->fw_offsets->mc_filter_mask =
> +			ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET;
> +		prueth->fw_offsets->mc_filter_tbl =
> +			ICSS_EMAC_FW_MULTICAST_FILTER_TABLE;

I know for some of these SoCs, there can be multiple instances of the
hardware blocks. It looks like that will go wrong here, because there
is only one fw_offsets_v2_1 ?

Humm, actually, if this are constant, why have fw_offsets_v2_1? Just
use ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET directly?

> +static void icssm_emac_mc_filter_ctrl(struct prueth_emac *emac, bool enable)
> +{
> +	struct prueth *prueth = emac->prueth;
> +	void __iomem *mc_filter_ctrl;
> +	void __iomem *ram;
> +	u32 mc_ctrl_byte;
> +	u32 reg;
> +
> +	ram = prueth->mem[emac->dram].va;
> +	mc_ctrl_byte = prueth->fw_offsets->mc_ctrl_byte;
> +	mc_filter_ctrl = ram + mc_ctrl_byte;

mc_filter_ctrl = ram + ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET; ???

> +static void icssm_prueth_sw_fdb_work(struct work_struct *work)
> +{
> +	struct icssm_prueth_sw_fdb_work *fdb_work =
> +		container_of(work, struct icssm_prueth_sw_fdb_work, work);
> +	struct prueth_emac *emac = fdb_work->emac;
> +
> +	rtnl_lock();
> +
> +	/* Interface is not up */
> +	if (!emac->prueth->fdb_tbl) {
> +		rtnl_unlock();
> +		goto free;
> +	}

I would probably put the rtnl_unlock() after free: label.

> +
> +	switch (fdb_work->event) {
> +	case FDB_LEARN:
> +		icssm_prueth_sw_insert_fdb_entry(emac, fdb_work->addr, 0);
> +		break;
> +	case FDB_PURGE:
> +		icssm_prueth_sw_do_purge_fdb(emac);
> +		break;
> +	default:
> +		break;
> +	}
> +	rtnl_unlock();
> +
> +free:
> +	kfree(fdb_work);
> +	dev_put(emac->ndev);
> +}

	Andrew

