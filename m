Return-Path: <netdev+bounces-287112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIsjI84SA2r20AEAu9opvQ
	(envelope-from <netdev+bounces-287112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1E51F89E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FA383003BC2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE6349CEC;
	Tue, 12 May 2026 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL7UfvCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65604349CE8
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586313; cv=none; b=rMtBD8Dcp20KwtggME6+wnxUfw/XwhFBebU9QvAv7NoR9Q5XkRaAOODkhvQW/r3lDD9VcFf9tmCAlQF3mjrxp9wOaAhW/OoZHvly5T/qopusOaL4WrDrOODHr3UnNhc4Sq17oZKJkSeVnEpBmiiDQ06IN+HuukUzlNpv3aNtdK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586313; c=relaxed/simple;
	bh=jP7rpAaaRmEue3I1LYG0dyLesrRQsMAvT38J5HBqEwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zyz62K3QwV2cnijBMqWuTfreg56S/hd5aqjKrZQr+dNzubmeZHWDC++YVq1BCWXDyvSKVl9L3kdVMLpN6g/vw/sHabbZ96Sty0zV/xFpL6joahPVNENPXNSKxBc3RYVgpr3aD04WVWjlM9wtk7eGmw9BO4qEHH77ZNrGXUzfaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL7UfvCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150D4C2BCB0;
	Tue, 12 May 2026 11:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778586313;
	bh=jP7rpAaaRmEue3I1LYG0dyLesrRQsMAvT38J5HBqEwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bL7UfvCZDyr2+dZUbfIoPovt7UiTYBYtp6CF/djqws7TCfe9ckq7HtPy20CybMjlW
	 0p+a62P9/OB0hbm1yCKr4GXj3gz3sF4mBZKIjW5Zg1pByMnTiKuKifFGGCLBmR359z
	 8xWnQ9fK+VMJtxPumTWeqW6qnxuY8P+tWwfOcKGiOXCCimTmdIkmApv4K0Yrz9iQk1
	 YVTGGFU+aDZmt4+naHTSnS3GmmPytNJQhwO/88N4kBfuMy47Q9vvsUGpNVVRSwNZVC
	 ec3NXiXsUsPNnkm2xFVpzIqOnD7oGtO/0FncOy+5IrTmjFwZPmbaZ9QtCCUnklJA7w
	 i2DL0hLHsWlew==
Date: Tue, 12 May 2026 14:45:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] rdama: sync kernel headers and fix build
Message-ID: <20260512114508.GS15586@unreal>
References: <20260505181045.748088-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505181045.748088-1-stephen@networkplumber.org>
X-Rspamd-Queue-Id: 75E1E51F89E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-287112-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 11:10:44AM -0700, Stephen Hemminger wrote:
> The upstream kernel removed the 'RES_' prefix from RDMA netlink
> command and attribute names, but the rdma tool was still using
> the old names, causing build failures.
> 
> Update all references to match the new kernel header names:
> - RDMA_NLDEV_CMD_RES_FRMR_POOLS_* → RDMA_NLDEV_CMD_FRMR_POOLS_*
> - RDMA_NLDEV_ATTR_RES_FRMR_POOL* → RDMA_NLDEV_ATTR_FRMR_POOL*
> - RDMA_NLDEV_ATTR_FRMR_POOL_PINNED → RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES
> - RDMA_NLDEV_ATTR_FRMR_POOL_AGING_PERIOD → RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD
> 
>   Fixes build error:
>     res.h:203:26: error: 'RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET' undeclared
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  rdma/include/uapi/rdma/rdma_netlink.h | 30 ++++----
>  rdma/res-frmr-pools.c                 | 98 +++++++++++++--------------
>  rdma/res.h                            |  2 +-
>  3 files changed, 65 insertions(+), 65 deletions(-)

There is a typo in the title: rdama -> rdma

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

