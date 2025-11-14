Return-Path: <netdev+bounces-238554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB034C5AF06
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9070334EB1D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0226E173;
	Fri, 14 Nov 2025 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7I/BeJi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE026CE11;
	Fri, 14 Nov 2025 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084446; cv=none; b=nKCUTAoGOmqyouWa/49V382AKwU1bG1Niz1akIHqvJ2K0NSNWFHu96qlsOTApyDXDv/SFS/Kdk52Ac7VBO4TuAB2e+lCkSUFZNGsm9Gokd0SU9GjQ5NgNQ75L7Hodzf3oOPIEBvu4wsGHsJN7VVRKpE6HiPqF6v7lIH4xCg9I1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084446; c=relaxed/simple;
	bh=LaF+FboAeGrVapEztH66xcfvLoTglFWcOUFkPFL/kKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fHN4EoKIPr3dSOd9SYGUsemgST6FAxWlT1ALlVD4pGzuXfMf4+eN2G292yPfacrF3j93jaT7p3TZAZV9g0sqaDEjzKP9f2m1HJs+G75TteoWADgH3kaRmwd1Jv9m+f62d7pnlzzvKqmS+afYaKa53eXkj+lASawxxN6Xge5n7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7I/BeJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B25FC19422;
	Fri, 14 Nov 2025 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763084445;
	bh=LaF+FboAeGrVapEztH66xcfvLoTglFWcOUFkPFL/kKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I7I/BeJiOyyl3K3SRcVHytvREoci11kW0ci9iOJE9YESZTeitF2NUZWrwpCxm5G5T
	 3FNTfXA1V7IQIC/7UYGvIPn24ncJ6bTkrhq3z31pD3fkMlMQf8j9qYM1QxNzYtXU3m
	 D6z/CD8hKR0fn26vJcwYnR9fua8c4FZhWmgCr7d59CPMvrWcugDCBTKnUZ7ZCIvJrx
	 DNd+7oykd0l8SJJGNCByUwVkn6K/QDKqJzc1VCYKd6iJVjydeu/Cdk5AYsPOU/XiKU
	 y5iPhdMWp/C9nxKIhWJ8RdKJHm9EJ2eEt1a0r3m4DER+3Ro9E5V580Bto5SrBONUoa
	 mL7ybTult0d9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFE43A55F84;
	Fri, 14 Nov 2025 01:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dpll: zl3073x: fix kernel-doc name and missing
 parameter
 in fw.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308441424.1078849.2137986445668378761.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 01:40:14 +0000
References: <20251112055642.2597450-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20251112055642.2597450-1-kriish.sharma2006@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: ivecera@redhat.com, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 05:56:42 +0000 you wrote:
> Documentation build reported:
> 
>   Warning: drivers/dpll/zl3073x/fw.c:365 function parameter 'comp' not described in 'zl3073x_fw_component_flash'
>   Warning: drivers/dpll/zl3073x/fw.c:365 expecting prototype for zl3073x_flash_bundle_flash(). Prototype was for zl3073x_fw_component_flash() instead
>   Warning: drivers/dpll/zl3073x/fw.c:365 No description found for return value of 'zl3073x_fw_component_flash'
> 
> The kernel-doc comment above `zl3073x_fw_component_flash()` used the wrong
> function name (`zl3073x_flash_bundle_flash`) and omitted the `@comp` parameter.
> This patch updates the comment to correctly document the
> `zl3073x_fw_component_flash()` function and its arguments.
> 
> [...]

Here is the summary with links:
  - [v2] dpll: zl3073x: fix kernel-doc name and missing parameter in fw.c
    https://git.kernel.org/netdev/net-next/c/992b7d5fd8a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



