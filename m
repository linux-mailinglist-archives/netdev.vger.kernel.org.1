Return-Path: <netdev+bounces-205989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BC2B0105C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4435E189E415
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0BD7482;
	Fri, 11 Jul 2025 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmE3w3Qc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0552907
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194765; cv=none; b=MLeMDVXgXzz+QNOrS+ZgmV3pqTrt3btNDM+tmKXrJLqpsNMdbqRKKE04RVybKa5ksFp4ltMYpGQ4kQZkc1UP/rUwuQtDufwsmiC6sInaAWI+XHr2H+p7t6PlIRGWaMVWG+cl4xGfbo2fIPmq3ccLvW3WFJ/b6N/peKe5t4opOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194765; c=relaxed/simple;
	bh=iWBWwDDdNhlEVcrCL0hu9vVcCGjLTG5dQ13Tgu+MU8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGp3753IkHuO5mDNIyb+tx0dixP0fp5rqSu0Z+vjrlnyvTSGcJaZJ7p6/W1JrtNwKhvAHT0hmm2qCflIjgYHmHMvSe45sntL1WMHyb/bihAwkiBKXS1Gby08P9p2uupHmRZrJumB/Ql8scxw/zwFFvXSfhuSpI+C+e6LTKA5Tuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmE3w3Qc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2355EC4CEE3;
	Fri, 11 Jul 2025 00:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752194765;
	bh=iWBWwDDdNhlEVcrCL0hu9vVcCGjLTG5dQ13Tgu+MU8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pmE3w3Qc8MbQDqJrj0w2eAsTIcG4absILhJDJLdBotRRKgV0MSMVRN6AozodRojJp
	 4a3pKmaHQf0PkOaMVr3X/ZNPHndZoXop6SJtXGfwZe7nv8Yr2MIBwLw5brf7Pzxkew
	 GOG1fkddskcxj6M77Y0GQ+dTpLsAGs77gtw42XaG4fqOSW8x/sEUbxEtgZq+8dbldj
	 eQmZTvbDhF8mYHDJQ4iOIgr7wRIVDJmtAu3pBivy5LY8adotcY46nX8ga67QR1hh6y
	 R4QL/gjcEEVBgn7xUzBvzhOvDnAidTjQ2OHiwYLBAVt++UmF8j0aB9t8CqWkGVD6a4
	 ltWdg0xpq0jNw==
Date: Thu, 10 Jul 2025 17:46:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 1/8] net: s/dev_get_stats/netif_get_stats/
Message-ID: <20250710174604.5745276d@kernel.org>
In-Reply-To: <20250708213829.875226-2-sdf@fomichev.me>
References: <20250708213829.875226-1-sdf@fomichev.me>
	<20250708213829.875226-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 14:38:22 -0700 Stanislav Fomichev wrote:
> Commit cc34acd577f1 ("docs: net: document new locking reality")
> introduced netif_ vs dev_ function semantics: the former expects locked
> netdev, the latter takes care of the locking. We don't strictly
> follow this semantics on either side, but there are more dev_xxx handlers
> now that don't fit. Rename them to netif_xxx where appropriate.

TBH dev_get_stats() is neither locked or unlocked.
Procfs calls it with just rcu lock. I'd skip this patch.

