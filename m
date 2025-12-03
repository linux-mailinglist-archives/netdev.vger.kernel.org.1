Return-Path: <netdev+bounces-243447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 879FACA161E
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 20:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861EA311A13D
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 19:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE1F33506C;
	Wed,  3 Dec 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ6cXCBV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258C314D0D
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789655; cv=none; b=JHi+u+gnmuMWQo4heEQi1Wp72z5/skRjQKFoFcGNj0e0KSrr4zgD+tIp2YUxQf0PAntRA41E7V7l5BzaGksizFE/PMsmWuWNKMv5/oxuxj9QcMy30Fo1pJVL5kSYrxpdUjYEiBaeN+9aQQ7vICgi92FjmMp0CfOTjPp715oFjI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789655; c=relaxed/simple;
	bh=ZnPbMo3fPG4x1Tmo8aoqCCJpO2A0R+NRhXVuFJuqh4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrupL5xuO9SqZmxGUk2hT5q3XnZ+wd5fraQGY73jPJNjaGGSPW/iHLgPK/8NfENd6g9wW45ev34OwWsuGRAc5prXZAw4K5JwJb6eCegf5DLDbs9HsQ77E0WoGsTjSKdscK9pUQOG7imMPwTDbmVNvlEGQj+cPDSej68AWgWfzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ6cXCBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C62C4CEF5;
	Wed,  3 Dec 2025 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764789654;
	bh=ZnPbMo3fPG4x1Tmo8aoqCCJpO2A0R+NRhXVuFJuqh4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJ6cXCBVqjY2+oXN9hqZg9KWj8ALzbqjVqpEjWKOEPcyvqw7Dgw0EnvuZdHP3veZL
	 36jIjH0V/3XO1eTtsgbH8qkcTsYW/otZ797EztJb4KQFIZVdOrCkhXIakkCUh9QifM
	 uujEziK1QOYOYExqKgW4+dGe3D9wsViYDPAMtL7INARikfSt8ZNXoERRB0LVRNuiVT
	 1noSM1f+8sogcU5PVdEoUaOoSoZIeQfSquJ82LVQdblRv6a0eAHt3Zan+BbGAYj7GW
	 9TKGROkD0itNqh+P9lmJFjwmOlg7V0jTKgF6zpEdxDPPqULNjIasLX9a9rzvm+Ui+7
	 nbpqs0LcEBeEQ==
Date: Wed, 3 Dec 2025 19:20:51 +0000
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net] idpf: Fix error handling in idpf_vport_open()
Message-ID: <aTCNk9wSxcNQmSSE@horms.kernel.org>
References: <20251202231246.63157-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202231246.63157-1-sreedevi.joshi@intel.com>

On Tue, Dec 02, 2025 at 05:12:46PM -0600, Sreedevi Joshi wrote:
> Fix error handling to properly cleanup interrupts when
> idpf_vport_queue_ids_init() or idpf_rx_bufs_init_all() fail. Jump to
> 'intr_deinit' instead of 'queues_rel' to ensure interrupts are cleaned up
> before releasing other resources.
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


