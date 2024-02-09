Return-Path: <netdev+bounces-70413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9AE84EF04
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E6C1F21E7E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 02:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66915D4;
	Fri,  9 Feb 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSTEHBQi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A214A33;
	Fri,  9 Feb 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447027; cv=none; b=csCtVQ2nYd9Ozzihmkl40GGzc1XuhGl46O6C7F5BXFqWR9OWqCGfPpCLV2GpuK8G0ebhdnCzqaS3G0wn1VOd2DEC5n8DwBscrK/pCvxVN38MFo+V1dwjC9YF9m3UsB69XQ2Rt266wpQCEXwkZSeghq+tIjoCGI6Dwf4Egf6alZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447027; c=relaxed/simple;
	bh=XAtSgvJCPmP+Dns8cYbiou/MdVl6ZjmIQyC1c3QqZKI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pNyvNDznLizVigo6nfASASJGCJNWk/7ITTIyCCsb2fskPp5NORAYe+e4+fDzSoQWntlwzO5I77WfDg11oHidfCs1z4TD/wS+Y4wXLGuAFdW97XdAYIpFem1QpygKLZT97+/hyg0dfMXZglOVZd+doD4raNsHx+/Gqtno3lKq5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSTEHBQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2D48C43390;
	Fri,  9 Feb 2024 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447026;
	bh=XAtSgvJCPmP+Dns8cYbiou/MdVl6ZjmIQyC1c3QqZKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TSTEHBQic0dz6zXJXeW+yETnM9EtYiX4tVtFJSkVFL4zssRaKrub7iM4SiaWeGVBF
	 rynxGJRR9RUE0TeDFwmMiGHcQbDLeaD0BHjN1r1gUPaRNSFJoqd7JjpWMGv2kUVljS
	 wYzbpOsDW9JQgQMJyhjiCWYXc8uXoR6JwqfA4hBKt19I0hzejvW12rmn1N0aW1VgkL
	 RFGoMW2hwNm+uGby8SRlGJonsQ5mGWBDhvmVTbmabtboO58QrQmJKxmjpzxMpuM2NS
	 2aQ9G229CBX5j+VQaehO23tJkzMN+jNt/wLwZPqIYEuJZbQZGh0/JDfx/jUG92hpoW
	 SefwrcReLsvaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8DBAC395F1;
	Fri,  9 Feb 2024 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: Fix command annotation documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744702674.13594.683989807642475006.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 02:50:26 +0000
References: <20240206161717.466653-1-parav@nvidia.com>
In-Reply-To: <20240206161717.466653-1-parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, jiri@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 6 Feb 2024 18:17:17 +0200 you wrote:
> Command example string is not read as command.
> Fix command annotation.
> 
> Fixes: a8ce7b26a51e ("devlink: Expose port function commands to control migratable")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] devlink: Fix command annotation documentation
    https://git.kernel.org/netdev/net/c/4ab18af47a2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



