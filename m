Return-Path: <netdev+bounces-204984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F5AFCC51
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3FF4200F2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96872D94B0;
	Tue,  8 Jul 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stgx8gBQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5C25B1EA;
	Tue,  8 Jul 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981983; cv=none; b=Lor5CYJL1kT/6nR0sR+z0xXWPinPxoWODxNSRQkxiT9A+NVVyPHyVDRh9J3nE7O4sM0gfLWHIGWB8h5fX62QTtWdaG48YDqQ2XKnYZR4iEvxDTviUMUyzd358TEf4bOLiXAN/iYvXF7s21ZOCQccEK8A31fbLUf8IQqQTGxUrZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981983; c=relaxed/simple;
	bh=xUYeTqdgGuIPtzhnkxyjtlIMKo+gWD0tDCSakGRaIV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FZlqMQdFNagcxQgUmF3WMNcJAugY+LXuQMBoXFYclkTppfFQrwGk/VxBz2vH9iMlutpm0lFqylOBT6+PWFJ/qYJdxWBtv1MWn5qVywWRqANdBW/yN6fxN6y9yDXi4cpZZeNqE1Gw3Z/YLDkjT5InmkimYpS+tbr3hFvZgMZ0M2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stgx8gBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADBBC4CEED;
	Tue,  8 Jul 2025 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981982;
	bh=xUYeTqdgGuIPtzhnkxyjtlIMKo+gWD0tDCSakGRaIV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Stgx8gBQcWOqgEFtTRWF6iePu7WjE8GvPlJCnDO39uXBQNf+nMNqQllJzHbvJdYNU
	 707dQc+2uwo2r3QS3A2xhyxKQjNvQGxzPCCbjdUP/t/EDKd/7urJ+C6t6NlUdHLkXn
	 3s8DwDuaNa0MQUryMmWqBHPq8ja6UA+S9YkwAdUyS839QZieU9ShNBR3pUGRSb8xdf
	 DOI72LbDNEgNEsNv7ThIAJ0UdRfMizmA6sRgaWPqfmEZ0/I2c2PFE4Z0ZSl8SxDJWA
	 JuewIrP3IuPIQrHwWKe0TGZuAjcI6JkMxxb906iS/k6lj9Q0bC5UwI4ef8w14XzPVG
	 Bp18n2zOBRVew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB171380DBEE;
	Tue,  8 Jul 2025 13:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/handshake: Add new parameter
 'HANDSHAKE_A_ACCEPT_KEYRING'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175198200581.4069866.2862653090267173213.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 13:40:05 +0000
References: <20250701144657.104401-1-hare@kernel.org>
In-Reply-To: <20250701144657.104401-1-hare@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: chuck.lever@oracle.com, kernel-tls-handshake@lists.linux.dev,
 kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Jul 2025 16:46:57 +0200 you wrote:
> Add a new netlink parameter 'HANDSHAKE_A_ACCEPT_KEYRING' to provide
> the serial number of the keyring to use.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  Documentation/netlink/specs/handshake.yaml | 4 ++++
>  include/uapi/linux/handshake.h             | 1 +
>  net/handshake/tlshd.c                      | 6 ++++++
>  3 files changed, 11 insertions(+)

Here is the summary with links:
  - net/handshake: Add new parameter 'HANDSHAKE_A_ACCEPT_KEYRING'
    https://git.kernel.org/netdev/net-next/c/e22da4685013

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



