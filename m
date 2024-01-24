Return-Path: <netdev+bounces-65411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B99083A662
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033A61F2A5C9
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985B182DA;
	Wed, 24 Jan 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw1AuBoG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507E18625
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090970; cv=none; b=EdFuAfALALw4CYVSxdGAYVo+cFMhY7jy6xRoRxgsXHJKpYCXSmJW1mwZ06/C1sst0D8nNqTtGW5JnQicESaCUUzeuDkm0yrnp07YHgNHt4ZL0K6pqGy+dgs/ijqx8C3a1LdwJ4kOVShV5BkgDkTcmhiY76B+NdOLA1CtPYxLF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090970; c=relaxed/simple;
	bh=IcQU/iHRRmZs5q1WZGwTEgJ+cEH88WdQGDANYi4Oc6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNlcaebxGVLPf9IxM2dCUiiJqvAQLaRZ+aG8PTJDjThoIK1JCmwyHo62OIGyt6N+ifqrLoh5FCFjodhS2UiEBG5m4DTOp4MLqkQk8Dl/GKF7gquVdI3eTqPw4WjYpo33o782WowoICWbenrQ44GpBqhzvsG6t9fEjiUwYZPFvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw1AuBoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D465C433F1;
	Wed, 24 Jan 2024 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706090969;
	bh=IcQU/iHRRmZs5q1WZGwTEgJ+cEH88WdQGDANYi4Oc6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nw1AuBoGaSUOYVTFWJg3BvwwhRZOejPNzVUBuEqzyQoZqbPoXno5Us8/WGJdUSXvm
	 /pPqLcuiN6I7nLCFXXORuLYRSpLuqiFiee47IB/R8ParSFlMyBV0v7Y54FaPpt0iMY
	 ra/ASlgBwRg0wqUHOi9Jjd1RrXVhQ575NnRNjZskeW2Dv9UDl4EYo8KUP8E/GSA0uc
	 sbjgCZZYlffYjSELoQzUDPWWrEaUH8cxTSUfpGzIAH5an61ge3GetPAJ0NQ3jtpaIc
	 rJY8qsd2d7aJF2Fdw069K0go6/XsyS0LaaxtsK1hZvbUCVdY08Gr7YPVDf1TaA6gbS
	 8s5GvryMGyghQ==
Date: Wed, 24 Jan 2024 10:09:25 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com
Subject: Re: [PATCH iwl-next 1/2] ice: make ice_vsi_cfg_rxq() static
Message-ID: <20240124100925.GS254773@kernel.org>
References: <20240123115846.559559-1-maciej.fijalkowski@intel.com>
 <20240123115846.559559-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123115846.559559-2-maciej.fijalkowski@intel.com>

On Tue, Jan 23, 2024 at 12:58:45PM +0100, Maciej Fijalkowski wrote:
> Currently, XSK control path in ice driver calls directly
> ice_vsi_cfg_rxq() whereas we have ice_vsi_cfg_single_rxq() for that
> purpose. Use the latter from XSK side and make ice_vsi_cfg_rxq() static.
> 
> ice_vsi_cfg_rxq() resides in ice_base.c and is rather big, so to reduce
> the code churn let us move two callers of it from ice_lib.c to
> ice_base.c.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


