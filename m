Return-Path: <netdev+bounces-247557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D3CFBA28
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4425730024CE
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4A227BB5;
	Wed,  7 Jan 2026 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3Ixfkp+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5C7FBAC
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750914; cv=none; b=OYvPmp4IX/QC8b7/HAJA2NNWcHBDesH3FkTn7gUGkIOAqDZtWHqoOcwfWrHiP8HyExJh1ZjGwqg5wS3iJGoj8SZXFnJLFL/QFY/bzGzODuIxw+aOBR5we27UwW4jZ36FvWw6x3btihgF0Af6Re0Ip2Wi3g34qR3xPpEVOOnUZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750914; c=relaxed/simple;
	bh=qAI4csMNxttSzmnZpNq47yk7hRMA4yeFSXnheb/BCTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKirRu2Mj0FAmjBAl/NbkCrQrhqysh4V+t87Yv/T+qZ4sIZz60mRebUsrknwgbCrrtiy+bwkgwxpvKWHTRJ1M6zE9L74ynqRMtHKOEIrhNkT+/IJr+PZy4/cJx8Emoonqm9Bzzvllfqj9eBrhJ8VMTcuoRMiw0XPwldidq5RbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3Ixfkp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77EDC116C6;
	Wed,  7 Jan 2026 01:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767750913;
	bh=qAI4csMNxttSzmnZpNq47yk7hRMA4yeFSXnheb/BCTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c3Ixfkp+wgIiCgWAVRBrMWqgJcu6Ra+jSHeS2sTbfodCh+G+wNXFGu4gpgWt4n3Hd
	 08R9xcwAdRqLvu7ox3ZGDWl3Yxy0b/zQh+2aZfqReexDpjH+3wqN1c1W+bAIQPWgYI
	 NgOge1aG54YPU4KiSm8DktWscgCF9KKX+pF+VjDq9fLW1cpUnhJccg1dk+kVcZ36AG
	 MFspfbotkcNGMjyLOrQI6schkMPjO4Cikuc3e6tg9FgCgalL6LiPfK0bV5A2A0vsZG
	 uKT503IM/oKRG8nV9UXGYF04DHKw6m1OKS6l4nrCdrkElES8XFnvMpJ93dEYb/JiPl
	 EJd6eqoiT0dvw==
Date: Tue, 6 Jan 2026 17:55:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, "Stanislav Fomichev"
 <sdf@fomichev.me>, <linux-kselftest@vger.kernel>, Nimrod Oren
 <noren@nvidia.com>
Subject: Re: [PATCH net-next] selftests: drv-net: Bring back tool() to
 driver __init__s
Message-ID: <20260106175511.0f01340a@kernel.org>
In-Reply-To: <20260105163319.47619-1-gal@nvidia.com>
References: <20260105163319.47619-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 18:33:19 +0200 Gal Pressman wrote:
> The pp_alloc_fail.py test (which doesn't run in NIPA CI?) uses tool, add
> back the import.

Nice catch! It does run on NIPA FWIW but HW tests must pass for a while
before we start showing them in the main reports, so I guess this one
never reached stability before it got broken :(

