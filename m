Return-Path: <netdev+bounces-192121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FA1ABE951
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4AA1BA74E5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1AA1B983F;
	Wed, 21 May 2025 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVUcL+kE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750791AC43A;
	Wed, 21 May 2025 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792200; cv=none; b=HvyI06d4eC+wSAo2B4fcQrFDA0NOMZTNrGhXQHmPnGJMtvzJiWPKVDuAMJJO44GwABlUJKJFCuUi/+oVqYqLOiDOjWT/QUa4Z8FqLna5Wtckh+ll7ImrW5yPyQkwO9peJ0mbMY8z8LuFMPKkfRFI71eCSjTOaIZA9LZ03LrzsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792200; c=relaxed/simple;
	bh=dRWvsaYGYRWrcyvlu6C9BPSvDpDDZnOCcNdOY/cneHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NgwrrB4YBByuzBC80alfcPeUhXYO9cFw8AApCONlV1yakyJ70IyKssrdCZyucDP8EQ01K55vdLMfcsyq6FwzKAtoqoTHTmq+/FvfbKjFvs9WXEnXhS5i2IhxhcPISJjCgVgR1H4+Jk/hcHnesthrtZRUDhT1PwiLTkjG06j8a4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVUcL+kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9526C4CEE9;
	Wed, 21 May 2025 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747792199;
	bh=dRWvsaYGYRWrcyvlu6C9BPSvDpDDZnOCcNdOY/cneHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gVUcL+kEVcd1NY16muInO5FqJa4/AuOELDCX+Cl6eYmsbyT6oJpr5O+WcQVx/glOm
	 RZ6B8DrjmsgCtpjhFUdP6159OHzvrFXwRtUyGFzJV5szEMKXfL0FQkjEPGCnmWVGrA
	 yAq69DhpAMbfu3wh3cX58pDLI8z/xRDYUaVzU9nxWZSMRgabSkG2vtI248N6jwJ3wX
	 qp5oL1rhthw/bfZ81iOCjsQRHr/zfx3D8VF4NSWFh5rzRWIGh2j171W8sA40qNKvVJ
	 xlG41mWVPgwbVz8OsMkNxTD/oQoC7gLtnwMrD4AGJ+wpmuxi1jyux5Zmrf0XtzS8Qp
	 2SC5/grOIz1kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC6A380AAD0;
	Wed, 21 May 2025 01:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] net: bcmgenet: 64bit stats and expose more stats in
 ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779223573.1533629.605506624462580045.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:50:35 +0000
References: <20250519113257.1031-1-zakkemble@gmail.com>
In-Reply-To: <20250519113257.1031-1-zakkemble@gmail.com>
To: Zak Kemble <zakkemble@gmail.com>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 May 2025 12:32:54 +0100 you wrote:
> Hi, this patchset updates the bcmgenet driver with new 64bit statistics via
> ndo_get_stats64 and rtnl_link_stats64, now reports hardware discarded
> packets in the rx_missed_errors stat and exposes more stats in ethtool.
> 
> v1:
> - https://lore.kernel.org/all/20250513144107.1989-1-zakkemble@gmail.com
> 
> [...]

Here is the summary with links:
  - [v3,1/3] net: bcmgenet: switch to use 64bit statistics
    https://git.kernel.org/netdev/net-next/c/59aa6e3072aa
  - [v3,2/3] net: bcmgenet: count hw discarded packets in missed stat
    https://git.kernel.org/netdev/net-next/c/e985b97ac1b1
  - [v3,3/3] net: bcmgenet: expose more stats in ethtool
    https://git.kernel.org/netdev/net-next/c/bbdf9ec61053

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



