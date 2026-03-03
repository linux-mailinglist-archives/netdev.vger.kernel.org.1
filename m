Return-Path: <netdev+bounces-263141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJyONzDGpmn3TQAAu9opvQ
	(envelope-from <netdev+bounces-263141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:29:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B71EDCFA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 225B1317DB3D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DBD426D1B;
	Tue,  3 Mar 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NynQZo9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF33421F1F;
	Tue,  3 Mar 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772536825; cv=none; b=tnEIkI8hfxKqvlF5KkFr5pSuZjFnY6SWJhflZroaEbmUvNlYeaVGOyGk4ogttjK618WOigy01qGKOYxYCxYEUO/x+yD3FKvTBUy2QGf6LrtkJDkJ8WWHOprG7mqxpHguKPgkmEyf1zAeM0xAPKHGtuEoZbAmsHNHTqGQBudZj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772536825; c=relaxed/simple;
	bh=1zLBoayefsVujzmUj7FVehNCVB9bIfkKRDeMLwRJTN4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cpF6/TikIe5QQ4bVb51wFcoLCQf9BSnIe79F4ST4aYnH4epTUJR3zoYrWSsCRhY+GAWHA9KnUb6YBlQ4LVVhHr8+uBR7SGP/uYSURCRg2wOAypogOCedSZmVNJaqpCbP+GJc013u/bAghvxXfdjsAkqgsd0fJoeDi2zr0dzk4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NynQZo9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58457C116C6;
	Tue,  3 Mar 2026 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772536824;
	bh=1zLBoayefsVujzmUj7FVehNCVB9bIfkKRDeMLwRJTN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NynQZo9lgeBykP6uMG0Ik5hVbboGkvl7AWrjMFuBb0l8exZrX5PWAh1koKuB6b0Q9
	 bjPxchTtDq9OawqNPO615XS+OdnyimjKIm2irJE0ypyZVyM7ysnmiS50ikHRhmrUdG
	 uITah4icqwx2O6zyyECQLP+WuWmKXUbofTV3yMg6bEzG3E5pfY/BYJZr+akpsJQ/+e
	 J/VupnLV3g4Kuw+n9a3piX0C20MXf5atmwKsfglyBGZN0JQ2ejQIjmMYZiIlpUUTZv
	 XYdN8yJDnObFTfel8Ot6Eb/T9jEoVjKZMqHNRABNBZSc3ockk0dKT0fzoOhPa0h5vL
	 zMirJ3QD4Zjww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F13380A964;
	Tue,  3 Mar 2026 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] dpll: zl3073x: consolidate chip info and add
 temperature reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177253682580.812154.847436671148185282.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 11:20:25 +0000
References: <20260227105300.710272-1-ivecera@redhat.com>
In-Reply-To: <20260227105300.710272-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 poros@redhat.com, mschmidt@redhat.com, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 336B71EDCFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-263141-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 11:52:58 +0100 you wrote:
> This series refactors the ZL3073x chip variant handling and adds die
> temperature reporting for chips that support it.
> 
> Patch 1 replaces the five per-variant chip_info structures and their
> exported symbols with a single consolidated lookup table.  The chip
> variant is now detected at runtime from the chip ID register rather
> than being selected at compile time via bus driver match data. This
> simplifies the I2C/SPI drivers and makes adding new variants a
> single-line table addition.  A flags field replaces the hardcoded
> chip_id switch in zl3073x_dev_is_ref_phase_comp_32bit().
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] dpll: zl3073x: detect DPLL channel count from chip ID at runtime
    https://git.kernel.org/netdev/net-next/c/4845f2fff730
  - [net-next,2/2] dpll: zl3073x: add die temperature reporting for supported chips
    https://git.kernel.org/netdev/net-next/c/3a97e02b3e91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



