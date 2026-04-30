Return-Path: <netdev+bounces-282816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +qR8CiFC82nMywEAu9opvQ
	(envelope-from <netdev+bounces-282816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:50:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24A4A25BF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DCEB300D94A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD6F3FA5E9;
	Thu, 30 Apr 2026 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieIk+6hd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB43939AE;
	Thu, 30 Apr 2026 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549852; cv=none; b=qQzOmY6PVEoVLkCV4Vs6advRYxiw+x8m1S7ssisneqkO5LHeCKR6MDM7TzmSlf6mcC+SsfC0Er8f9GlRl0CZ97KgduODXR3GeFn9OTnZzrcncS47LxxB+EGUJZe+ypIk0ul8j0YwEEroIRryEQUQn4PKHhXoQigMVEN/WJ/HWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549852; c=relaxed/simple;
	bh=VIAfUup26I6cErjUOkTtT5TkyQe3WzQ20MIgx9ZsKb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JSxz2HkrPR+vfEG4En8GVdVkJcKMrdF/NzfOePhngsXdVIvfh7OZd6jEEp9OQqD7tSQl65zbVSQllDOXhvuQ3K4fG91oYGIRNH58Xhhp8imP/Pxz/vS3bxD1bE7sYvS6Ag2tVnr6mtrrutlOWW+1HT8moCurA8OXgZcWBRoPRc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieIk+6hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1192AC2BCB3;
	Thu, 30 Apr 2026 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777549852;
	bh=VIAfUup26I6cErjUOkTtT5TkyQe3WzQ20MIgx9ZsKb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ieIk+6hdz8cs7jWFE/1rMWSDzl6bC4wCwTZa+6xgwplLrpOSvvyssESB4CAo71sM4
	 8i0fyWEX2vZvgp2tC00SaZGadEkfo9c3jkLY0GQc+1pEzBnTsUZiTc9Vou6VAVGpAt
	 62j6Me060ocZk4S6yDLnlEZ03kDegS6OxqH8EE+tG8vGK3qxH48Rjq9ia9T6k6DgQ+
	 NtJmDS4KAWNYoNCaNiq/ILa+xbWsI2LLRv4ZS2xU2Ev/HVt7CaJVww5kJ23kYJD7oW
	 St/2QpBa9Nwtpjxs9fLe/7t5F8GCgF1xVOG/dWFg6zNUOOTsOaZA7GuaM7CVxRArBT
	 7GIGIabzzoTkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B7F380A97E;
	Thu, 30 Apr 2026 11:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] sfc: fix error code in
 efx_devlink_info_running_versions()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177754980680.2967170.14222555807417200923.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 11:50:06 +0000
References: <afGpsbLRHL4_H0KS@stanley.mountain>
In-Reply-To: <afGpsbLRHL4_H0KS@stanley.mountain>
To: Dan Carpenter <error27@gmail.com>
Cc: alejandro.lucero-palau@amd.com, ecree.xilinx@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, habetsm.xilinx@gmail.com,
 jiri@resnulli.us, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Rspamd-Queue-Id: 5B24A4A25BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282816-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 Apr 2026 09:48:17 +0300 you wrote:
> Return -EIO if efx_mcdi_rpc() doesn't return enough space.
> 
> Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> v2: Originally I returned -EINVAL but -EIO is the usual error code
>     when 'MC response was too short'
> 
> [...]

Here is the summary with links:
  - [v2,net] sfc: fix error code in efx_devlink_info_running_versions()
    https://git.kernel.org/netdev/net/c/051ffb001b8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



