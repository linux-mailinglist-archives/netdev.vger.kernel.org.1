Return-Path: <netdev+bounces-203381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F43AF5B01
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50531C40332
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D82F5308;
	Wed,  2 Jul 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl+gbvA6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38E1F5820;
	Wed,  2 Jul 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466183; cv=none; b=gEVzZM9P/LKPgXGiBat9R9ItkdaAj5/PtAGIBq+nob7eJQnxuTiJVcWD61RyARlpjH/d4SF+ZDBKMD7Ry8BeAJB8jVK2m+naXtEKsrYQ1zqHfuO5xqfTk5btF7AABX7FBA/xQBYz0g3zAJaEWLQZzFYfQzgCsx+8npbbXitMNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466183; c=relaxed/simple;
	bh=MpfCbVO4W0VVtHSdd8YbHgo+NQbHc9Of4ZYZeV2J2zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0p6p4/IyIku2at93kJduzj0T7Pc1r6IdaaG+/2N387KLRoexDPquYVolnYygs6416jiWQMVmetx6IWjYGMCwtubCgkgHPy+ScioJXVyt6MZfkUd1cZcoq95jcHw10c1F6FtZS8i5sBtweiH2WgfAk71reh8VGw+FXBofVmcaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl+gbvA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ED4C4CEE7;
	Wed,  2 Jul 2025 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751466182;
	bh=MpfCbVO4W0VVtHSdd8YbHgo+NQbHc9Of4ZYZeV2J2zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rl+gbvA6CfCQSBwjQ16wrT3SLKHGUqVW0d+NkC78yLIZaEmYRZFl0FUjjASWzSyzw
	 LCUAwUb6rbNuVWpzV9miT+MQxYG4/IVFIboB0JbuREEWayEZ7gkundKQKdFkM1oCYb
	 ro5hH2/7R2fAREHlaSlqb2aDAeh/S0kmPVLUnIocKrx7A8cCwnfWCxeEvr7oY3jEMn
	 q4apu2IO/DoJVuQA+VRH/hVuPaPPFQKVHiHQwFonUXID27H73SPgMgIRcC1DcRnQ2y
	 Nol38j+1hmM2j4MUbWwLqIDdtYq+3TYAogjLj3795PwE8N25cieGKpsrGwk9MeoqT4
	 39xe36hW6EytQ==
Date: Wed, 2 Jul 2025 07:23:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/4] There are some bugfix for the HNS3
 ethernet driver
Message-ID: <20250702072301.51deaf72@kernel.org>
In-Reply-To: <f3994ddd-9b9b-4bbb-bba4-89f7b4ae07f7@huawei.com>
References: <20250702125731.2875331-1-shaojijie@huawei.com>
	<f3994ddd-9b9b-4bbb-bba4-89f7b4ae07f7@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 21:07:19 +0800 Jijie Shao wrote:
> on 2025/7/2 20:57, Jijie Shao wrote:
> > There are some bugfix for the HNS3 ethernet driver  
> 
> Sorry, ignore this patch set, they should be sent to net not net-next ...

You still should have waited 24h per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h

