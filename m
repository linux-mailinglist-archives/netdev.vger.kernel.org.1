Return-Path: <netdev+bounces-193901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1EDAC6365
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1C84E01D4
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C67224501C;
	Wed, 28 May 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/lvZouP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616121DE4F1;
	Wed, 28 May 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418753; cv=none; b=iTlOamm3sIOP63/UbOVIOUvvKHCQ8lKS+YtZnSws0q/7fZu7jv7b07IVMzj3VGtS2UF2JfURjzvp1FIR+U7ZqyNUZ0NkGRWn++GZB9J925MRZjC7ZhSTL30urHUJjmdjYDa5P9ePz7ur6gtk8cFHHlclss/XtyA/a6bPaXH+0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418753; c=relaxed/simple;
	bh=vOIZMb5lEDF1Fh0DsUBC/oFFOQgqXuEgzjSZapxTDuA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rw0JUVHNzL0hkHx8TsSITHx6bM91nCS6gtyJgXwaKNzWeBsMjiDBU1MhZeKFJNhxJ2y+3kOACCNzvuu9ttT5NQVAfnTzp/qlIYR1A+P8t9nOT0rDPqOZ93v3yBRHTghaMwPtMWk3W6pI+0YUThl/yFAyPwtTlzGaBhTI5Wx8tZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/lvZouP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D21FC4CEE7;
	Wed, 28 May 2025 07:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748418753;
	bh=vOIZMb5lEDF1Fh0DsUBC/oFFOQgqXuEgzjSZapxTDuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i/lvZouPKufeyVtJyNLJAmoqQ6Kn8IJe8SDM6Fs1LgC/1UlKE+lNSluLtVjRebt6x
	 aYnHwguwdqLi0I2wyFYwof856+u+DIYfSY4W2xXDAjWEE0+J8FlsfupsD7S04njyOj
	 +6TaRLjBHiT3MPAD33HrD/obUFzKDeKjbgV5i+q9SFHbVfLPElKAmJAyN5AIkvVrt+
	 TdLLLhhNJ95cRk3V4qaquytjpI5lVrua7WwxmmYfn6plIsqaDDj2bQjvM/j7stw7+c
	 B7nlwljKmyHO4Q6HzENrm1qXYVi63x/aezIN4auaR7rUSy8lbDhUEgiVEXx1aYLNFn
	 qOzzzGzpMcY8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC239F1DE4;
	Wed, 28 May 2025 07:53:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: mscc: Stop clearing the the UDPv4 checksum for
 L2 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174841878725.2284365.16902969225916201562.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 07:53:07 +0000
References: <20250523082716.2935895-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250523082716.2935895-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, kory.maincent@bootlin.com, wintera@linux.ibm.com,
 viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com, atenart@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 May 2025 10:27:16 +0200 you wrote:
> We have noticed that when PHY timestamping is enabled, L2 frames seems
> to be modified by changing two 2 bytes with a value of 0. The place were
> these 2 bytes seems to be random(or I couldn't find a pattern).  In most
> of the cases the userspace can ignore these frames but if for example
> those 2 bytes are in the correction field there is nothing to do.  This
> seems to happen when configuring the HW for IPv4 even that the flow is
> not enabled.
> These 2 bytes correspond to the UDPv4 checksum and once we don't enable
> clearing the checksum when using L2 frames then the frame doesn't seem
> to be changed anymore.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: mscc: Stop clearing the the UDPv4 checksum for L2 frames
    https://git.kernel.org/netdev/net/c/57a92d14659d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



