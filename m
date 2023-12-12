Return-Path: <netdev+bounces-56602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB980F95A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347CE1F20F3E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6E76413F;
	Tue, 12 Dec 2023 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcEo5PtV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F83D6413B
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 21:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDA9C433C7;
	Tue, 12 Dec 2023 21:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702416532;
	bh=7g23NbUaG9IocrYKtfcJQkcARBOL/6cB9B3IBOO179w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RcEo5PtV4dcAiaQiaiYd9nV1ggHqQ2IfUnP05wzeW+Exw/eoKMP0vUwUlK+ubJvFm
	 D7kgFLDhvfVL3xvjQzuFVEDI5tENiXmEq6M1OxK74Y+wAh/DOuK4XPs9a0VpSGAIUD
	 i5IF/Az+XIJYBNC9C468l2agnMAnC8MrxjHg0h6riZL/zzzKFtO58KCnhPa1M+FkWm
	 O72fM02HcAHtEEmUIzDrYIiFJzKVwvVmc5xd9E0gmajxplF6jVUAlHY9I2GmfQkAZ1
	 yGOsAKJjb/MtAJNIkGIpIb7pPD+2DwJXDOTrr3EE6r4MxjJ8C9BI/YIT8t5zkNRkRQ
	 8/rovDm3IMRZw==
Date: Tue, 12 Dec 2023 13:28:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] iavf: Fix null pointer dereference in
 iavf_print_link_message
Message-ID: <20231212132851.59054654@kernel.org>
In-Reply-To: <20231211025927.233449-1-chentao@kylinos.cn>
References: <20231211025927.233449-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 10:59:27 +0800 Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")

No need for the allocation here, print to a buffer on the stack.
-- 
pw-bot: cr

