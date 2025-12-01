Return-Path: <netdev+bounces-243084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3076CC995C9
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28E573418A2
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B76288C86;
	Mon,  1 Dec 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJN+CSLU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A7288502;
	Mon,  1 Dec 2025 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627401; cv=none; b=snptyPdRivubdEzbLOyDHx2/r65cFsu98MV5Jhs5vI59tmKr00KYZCpcooVtDBWcxNh3kfcZ84cduOG9kXbJ4LGlnF0+H5UcZ6IOHWcEQMCmL5iHvHg1U5tlpA5GX0ey5AcxE1Bzr9lKbHsWSVhsV55snX0AXSz0Mfa9ndJRZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627401; c=relaxed/simple;
	bh=Y5DXQhCcAA3uAQApHosfzKwCVgNUTGcLBLCzMK7rFYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sT+26wHzPw8jut84nOuSeyXUYUSFeQyLmLJfRNP+k3+3QHO82CXOARGedSpqDpYDb2l4xdjeqXmOh/DG88VvwNWz+0W5GO1JK4yVFODGTT/KVXiYx3Osbxgi0YQJ1uOc/Bzo+84CuiBZQbz1Hm+VR5KxXarfM4rR84Lofj55nAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJN+CSLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FB7C4CEF1;
	Mon,  1 Dec 2025 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627400;
	bh=Y5DXQhCcAA3uAQApHosfzKwCVgNUTGcLBLCzMK7rFYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cJN+CSLUNy5QDd3ER0bYvT9C4PV9ONNGYQdGGYyw/enTuSyOCUuL0O7Wfn9//CzT/
	 S3AzLMoK6HNzctpwqjHUAF8s08ygOjp4mSX0djPyeksLZQk+9nEWc751ScWHs6IMDi
	 d0/af/j1V0rBjo7QrPcQgV9c4cngItV5N2ekWOQ8N8j49Bg+0WlGTG7IF3mTFn0QSl
	 FeC3CleOEhgQhkdhPTa6eIN+W8TL2nsIRZnFXLO1yNdE6s/7wT9QwXypo218/2+C4G
	 erfzPuny75bfKIxfb38hiCt/f+oyFrpKIWD5Wcfu8DV3K5DzShAH2CETeEgn1ytiZ+
	 klW1xo8xUXiUA==
Date: Mon, 1 Dec 2025 14:16:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 pmohan@couthit.com, basharath@couthit.com, afd@ti.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
 mohan@couthit.com
Subject: Re: [PATCH net-next v8 2/3] net: ti: icssm-prueth: Add switchdev
 support for icssm_prueth driver
Message-ID: <20251201141638.00a986dd@kernel.org>
In-Reply-To: <20251126163056.2697668-3-parvathi@couthit.com>
References: <20251126163056.2697668-1-parvathi@couthit.com>
	<20251126163056.2697668-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 21:57:13 +0530 Parvathi Pudi wrote:
> + */
> +static void icssm_prueth_sw_switchdev_event_work(struct work_struct *work)
> +{
> +	struct icssm_prueth_sw_switchdev_event_work *switchdev_work =
> +		container_of(work,
> +			     struct icssm_prueth_sw_switchdev_event_work, work);

Consider using shorter type names.

> +	struct prueth_emac *emac = switchdev_work->emac;
> +	struct switchdev_notifier_fdb_info *fdb;
> +	struct prueth *prueth = emac->prueth;
> +	int port = emac->port_id;
> +
> +	rtnl_lock();
> +
> +	/* Interface is not up */
> +	if (!emac->prueth->fdb_tbl) {
> +		rtnl_unlock();

Are you not leaking the device reference here?

> +		return;
> +	}
> +
> +	switch (switchdev_work->event) {
> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> +		fdb = &switchdev_work->fdb_info;
> +		dev_dbg(prueth->dev,
> +			"prueth fdb add: MACID = %pM vid = %u flags = %u -- port %d\n",
> +			fdb->addr, fdb->vid, fdb->added_by_user, port);
> +
> +		if (!fdb->added_by_user)
> +			break;
> +
> +		if (fdb->is_local)
> +			break;
> +
> +		icssm_prueth_sw_fdb_add(emac, fdb);
> +		icssm_prueth_sw_fdb_offload_notify(emac->ndev, fdb);
> +		break;
> +	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> +		fdb = &switchdev_work->fdb_info;
> +		dev_dbg(prueth->dev,
> +			"prueth fdb del: MACID = %pM vid = %u flags = %u -- port %d\n",
> +			fdb->addr, fdb->vid, fdb->added_by_user, port);
> +
> +		if (fdb->is_local)
> +			break;
> +
> +		icssm_prueth_sw_fdb_del(emac, fdb);
> +		break;
> +	default:
> +		break;
> +	}
> +	rtnl_unlock();
> +
> +	netdev_put(emac->ndev, &switchdev_work->ndev_tracker);
> +	kfree(switchdev_work->fdb_info.addr);
> +	kfree(switchdev_work);
-- 
pw-bot: cr

