Return-Path: <netdev+bounces-151296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC39EDE84
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA180281073
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE3D18A6A9;
	Thu, 12 Dec 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0xuEAuP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A316F84F;
	Thu, 12 Dec 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977831; cv=none; b=EIU1Oh+9WGhUqHHN3pChtT2F7WPkl2w8+zO7U4tH/EgF4NrCXWMxSkUJWGroyyKMYOteuzSEPQ5D+xl3eNzMNvtF5Xouo+yQIB2dvsTuI+/3x9Zy5r/8bj72Stse7HqXttPE+/0dheBjQMnpfwiugg7rKtltdfzP1E/u6hj5sOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977831; c=relaxed/simple;
	bh=gpxYI5EkYQXrsi3Oz/XM6sd//CKsf6du/9t20rriTt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d471m0LmXYftRAjer2rsFLCYqCd1GMezHRj1u4MohfwoniMuWt+3zYnE/fZseHGOwEi+Ge8F0WXzZ4j7CtL85ORjDRmjXC0fBkhZA0AagEWSPM/w7UITt0Ihg8J6Ck0edsVCNgE+o7Q0B2gyKTcYA8sn6rn0lrT/fi3SSvrzFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0xuEAuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4A6C4CECE;
	Thu, 12 Dec 2024 04:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977831;
	bh=gpxYI5EkYQXrsi3Oz/XM6sd//CKsf6du/9t20rriTt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V0xuEAuPqekBwt4zZ1Xo+9aUJ5+uSPQluZG23g64qlK+NbJqhxUX4H5iWor9Y/y4U
	 +/dGcByDlZeCddi3eac0UJX4Bmp+dmIUGsBJFqedox3BwPmKNgDYOjH5ZyLyntIOBK
	 OfuVnMfWsxDR3yXORHp13mbeYJ7jfd0bCOQXHpGrfb2cEp34BnHcAEbI35gLfBqNUZ
	 L8R3R4KiQ0wxaetev6VFydaRTEWYASpFoPuqPAe10ZQKDVlLeCU7O8zTJuO7weVw6l
	 kY0a9JghPSEwXf1Uh4Hz3F9fyeuWJ6YXHLXz5Jq2/iAk1KsNFf0+ZW5zWqHejc/7W/
	 lcPEMZh8QWEpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC774380A959;
	Thu, 12 Dec 2024 04:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] isdn: Remove unused get_Bprotocol4id()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397784776.1847197.7905130187502801190.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:30:47 +0000
References: <20241211005802.258279-1-linux@treblig.org>
In-Reply-To: <20241211005802.258279-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Dec 2024 00:58:02 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> get_Bprotocol4id() was added in 2008 in
> commit 1b2b03f8e514 ("Add mISDN core files")
> but hasn't been used.
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] isdn: Remove unused get_Bprotocol4id()
    https://git.kernel.org/netdev/net-next/c/ae7837bb3d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



