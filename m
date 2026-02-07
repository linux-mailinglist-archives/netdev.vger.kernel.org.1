Return-Path: <netdev+bounces-257734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHkvLZLEhmnrQgQAu9opvQ
	(envelope-from <netdev+bounces-257734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:50:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F1A104F23
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AADBA30090BC
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5612C21DF;
	Sat,  7 Feb 2026 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoTp65EG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD01A317D;
	Sat,  7 Feb 2026 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770439824; cv=none; b=YuivK56KWXs4oa2lKkXGqnW9cT8/AgBJ1q4U+Pwq6gsqANlWuYAR7QWYNuVK4ptvOXxxoR/r993+FFHRu/WhakmZuKKE7oxANyzUJH5JVkp0yJvYdT8GsR2enrwhtl2Q9LhePprAUrVMtt6QhaorBwcf8lTJuossO5fWNVCZkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770439824; c=relaxed/simple;
	bh=8BUHNHXcRIUcGqqu28h30FYVmahjZgT5vYnuk1eqUmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uBJcjgwJlFTVpY63J/VEZLkGuouMpeg/SF1YDmi2EV8LsaHssOjLHQ8tfKA+2e/goNhBc8eEs96A3VfeV9bB22ohviyMERg/8/Cn6HybLskfQtM5c+Uc+EGhhTTXLIFFWCjzLvgJBmqNYn3Q3zLv3+5BVT85hi5wU9Jdn6FMkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoTp65EG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC16AC116D0;
	Sat,  7 Feb 2026 04:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770439823;
	bh=8BUHNHXcRIUcGqqu28h30FYVmahjZgT5vYnuk1eqUmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hoTp65EGibeWydcRRCn9VHCsVCjjU2RHsr47QM7mAYBeSKAGqVmTHz6H3ttIKIk+A
	 u/zvDO6+wezcqnr1kF8boUPA1xx8pD0j5nYKHO8iAO0j33qp5bHlgiceeK/KTIDajw
	 h27Kj4UeOY0XGaqEeGkRXzb7qNqi8bCYer3dNeEG8DdhxXhEI8+o/G7GgkEwMfhiVq
	 f1yXsPaGLNqvDeQrsIWN2hTxkogbppJG6Rqa8db8stHTBqwH+kXXtOucGSYtWUWZ1M
	 XpBrZKDIkWn7c/BT1B32SAGcym92HaB9kJwtGg5KXn2xOq2GWTXXCXWPAnm42Tf4lr
	 8i9faElrkC++g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0B43809A1A;
	Sat,  7 Feb 2026 04:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] dpll: zl3073x: Include current frequency in
 supported frequencies list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043982056.1190979.9868517128248104306.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:50:20 +0000
References: <20260205154350.3180465-1-ivecera@redhat.com>
In-Reply-To: <20260205154350.3180465-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-257734-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82F1A104F23
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Feb 2026 16:43:48 +0100 you wrote:
> This series ensures that the current operating frequency of a DPLL pin
> is always reported in its supported frequencies list.
> 
> Problem:
> When a ZL3073x DPLL pin is registered, its supported frequencies are
> read from the firmware node's "supported-frequencies-hz" property.
> However, if the firmware node is missing, or doesn't include the
> current operating frequency, the pin reports a frequency that isn't
> in its supported list. This inconsistency can confuse userspace tools
> that expect the current frequency to be among the supported values.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] dpll: zl3073x: Add output pin frequency helper
    https://git.kernel.org/netdev/net-next/c/24e4336a87f5
  - [net-next,2/2] dpll: zl3073x: Include current frequency in supported frequencies list
    https://git.kernel.org/netdev/net-next/c/85a9aaac4a38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



