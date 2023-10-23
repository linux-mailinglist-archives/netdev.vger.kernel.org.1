Return-Path: <netdev+bounces-43658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78A7D42C0
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE99A1C20995
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5577B200AE;
	Mon, 23 Oct 2023 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0zauZf0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225F257D;
	Mon, 23 Oct 2023 22:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563EAC433C8;
	Mon, 23 Oct 2023 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698100783;
	bh=4MMwk1MGS+QvG9o+2//TcaIEs3XEz2JeL3J8WXT1PHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A0zauZf0PKXqqw8gZWBOViZSv58zByDUvpwSgHuWdtgnSkA7vGuPkC77wrQYEwYBa
	 8LrnPklP5WlTq1dPvwyo8YDZIdnIyRHUBAdQB0EMBUnfGUuURhiCiKgdBryjuaO1zC
	 9o2RMOQq5IZh6hHKiNnFylTwvJgdODfqhCNx/bBaVaifU42FecyFai9iGcyzX/o7Gy
	 TC9zcSfUVu4IqdkuxAP0b1D0z7JckdHcGBN5lxYbv311tDNeLvloDmjpcCehvVegie
	 jIlnI2rC9JLmO/eoac83STE3DeezPNToxhxD/Zk7FBebo+tivVvosLiOlKPLejzZ9S
	 lioHqyBATSAzQ==
Date: Mon, 23 Oct 2023 15:39:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: Philip Li <philip.li@intel.com>, <oe-kbuild-all@lists.linux.dev>, kernel
 test robot <lkp@intel.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <20231023153942.29f6851a@kernel.org>
In-Reply-To: <8df14e3a-7eb3-412f-89da-69c9e4dee7d4@intel.com>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
	<202310190900.9Dzgkbev-lkp@intel.com>
	<b499663e-1982-4043-9242-39a661009c71@intel.com>
	<20231020150557.00af950d@kernel.org>
	<ZTMu/3okW8ZVKYHM@rli9-mobl>
	<20231023075221.0b873800@kernel.org>
	<8df14e3a-7eb3-412f-89da-69c9e4dee7d4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 12:09:33 -0700 Nambiar, Amritha wrote:
> Just checking if this series is dropped from the review queue because of 
> the build bot warnings...
> should I submit a v6 with the single line fix for the warning (legit) on 
> patch-3, or
> should I wait for more feedback (if there is a chance this v5 series 
> would still be reviewed) and address them all together submitting v6.

Repost please, I almost never review stuff that doesn't build cleanly.
I'll have to re-review before applying, anyway.

