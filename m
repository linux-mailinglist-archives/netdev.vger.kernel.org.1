Return-Path: <netdev+bounces-177550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE096A7087A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7201765E7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F238C261589;
	Tue, 25 Mar 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0VoNwWF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F60823DE;
	Tue, 25 Mar 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925000; cv=none; b=qLaTg61EJnEpF2hxJ1y5J5i7TYzUszaD0Z0G09u4/cf4VYdmdSwZzP4YZlRmknrc/2l/bALLX7DBGSZQz+VWqpextnQRCHwocKR269zwdoNnPIY2Nw0pPsxnlEK0I1ivvnUVtcgnCiItVKVhLjhm/35nMyI+HAyHX5yoMaizeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925000; c=relaxed/simple;
	bh=EL3VnTPJo+P5z/KHMukRAuwWkDM/Ve3eT4OQHlZyvHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J4zI82Iu3kRgtLvUJjOhL6e5iTp4y4PnoVn+x6Ch/sU/tEtCSBQV0092tHWY1iIUXp5/VEUaSM4iqULgilcPvCE3S/hGbrFxxXndQ9vFZ85cLB3NXNCwOMAoT9/K0lzD7/Csj/y2DmnibI5RUTF7hkgyPMPIshDbIDKkP9ee5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0VoNwWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450E9C4CEE4;
	Tue, 25 Mar 2025 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742925000;
	bh=EL3VnTPJo+P5z/KHMukRAuwWkDM/Ve3eT4OQHlZyvHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V0VoNwWFYekJ6GE+Mh79Ye9r10xvX4kYy61L4qTDJYZ1lCE0NvGznWgAIfKpFL7xD
	 93yeRa9iyQKS0iQXWhRf4rTKrc48UDEQbIBtWY6q3w4dUpWn6P9CQwZJera0SBAvE0
	 +iSXQnrcIbftNlmdBBxtqi3q1IjsHheOyBj42UlEWxEinvkWqO9+h9IkNSJb2Fmocm
	 WpnfHJ+VbBj/x8zgx4vl11u0dcmQnoWX/HH6lbmAPrG1fiVVQfnbwP7I+XNqgaU/mP
	 OOtZzZhkx1ys+0Hd5tNPncbgutqCCn0S8r0zcXGa2Mrxlq+7SGv20faqTavfOwki07
	 3P5WJTPbkKqKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B061F380CFE7;
	Tue, 25 Mar 2025 17:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] stmmac: intel: interface switching support
 for RPL-P platform
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174292503611.665771.17143313687582113005.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 17:50:36 +0000
References: <20250324062742.462771-1-yong.liang.choong@linux.intel.com>
In-Reply-To: <20250324062742.462771-1-yong.liang.choong@linux.intel.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Mar 2025 14:27:42 +0800 you wrote:
> Based on the patch series [1], the enablement of interface switching for
> RPL-P will use the same handling as ADL-N.
> 
> Link: https://patchwork.kernel.org/project/netdevbpf/cover/20250227121522.1802832-1-yong.liang.choong@linux.intel.com/ [1]
> 
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] stmmac: intel: interface switching support for RPL-P platform
    https://git.kernel.org/netdev/net-next/c/cc04ed502457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



