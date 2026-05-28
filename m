Return-Path: <netdev+bounces-292674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAXWErIxGGpwfggAu9opvQ
	(envelope-from <netdev+bounces-292674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:14:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A58745F1EDA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 184C03058FF3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530FB3E3C41;
	Thu, 28 May 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzHSRI5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8373E6DFF;
	Thu, 28 May 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970208; cv=none; b=rZ/DHy4m0Vf51DOpJaPsPh5J6Ri6tnxFqgIVZUF9FBXx4ybUoby1f2b07eh1S8E/KPZAY4fpF7f8HHU2mrIZNjH76kaoksZzT/faUmXdJ//oMbALJ18XeW69+TDNmlNJdoVEAerAvZ8CSVtoTZ1Ivw77KN8iyGqAk+NVaiWQiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970208; c=relaxed/simple;
	bh=TVND3weqO/ezorBMv+MStKOLuAtql5QehanWRuvaN0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FWDKzfSJyNxM4Q7JNZ4P+67uIfW5Xj1tgy39k/NzSnTOoyV78fU8NJqZG2GCNqEcgbm24ati9JIj833ghtfcgoo27OO2NJ563/odz/Xrxe+01xnwxWSr3KYOm7G1cJqEM8IJlTEHsiU8C4BQk2KPPkwRiacG2/aULKdxy/jFTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzHSRI5L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51691F000E9;
	Thu, 28 May 2026 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779970205;
	bh=XLefspTyUq2ENk2eCHPO4osggyiWCnNLmQ3O8qctyqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VzHSRI5LQUycSzVqSk7LeMLSWbdlx5SxjPNqSFJkbPVoaDGT8CAglRCXbScTNVMB6
	 BBQ0IQYGdRQNhn6Uz718dt/HbFRp9/JUNCdF87SNR08tkyVkF6AV6jYK/nf5ovvXbc
	 CiiciJpA2/ECTUqP1OTRGPkzQLueEx/jOW2aD/ENje7VVG47pcsaA+yJw+VT79JwLR
	 LbKs3O8rUcgUyR/XOE6UrrvT5hNKi2958k2VdPGEKAle1rvlr4UjRgq5Pud4//w7Si
	 P4kdovuFcmifvNegcQwy7RDLuCoKPVtkUU/EdOWyljBTxlZ1GYdISSW+NDrrJpB9IF
	 2wmC6oAy1bgUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93E3C3811959;
	Thu, 28 May 2026 12:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] dpll: zl3073x: various fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177997021014.896679.13961850181494298795.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 12:10:10 +0000
References: <20260526074525.1451008-1-ivecera@redhat.com>
In-Reply-To: <20260526074525.1451008-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 Prathosh.Satish@microchip.com, kuba@kernel.org, poros@redhat.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-292674-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A58745F1EDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 May 2026 09:45:22 +0200 you wrote:
> Three fixes for the zl3073x DPLL driver.
> 
> Patch 1 exports __dpll_device_change_ntf() for use by drivers that
> need to send device change notifications from within callbacks
> already running under dpll_lock.
> 
> Patch 2 replaces the change_work workqueue mechanism with direct
> calls to __dpll_device_change_ntf(), eliminating a race condition
> where the work handler could dereference a freed dpll_dev pointer
> during device teardown.
> 
> [...]

Here is the summary with links:
  - [net,1/3] dpll: export __dpll_device_change_ntf() for use under dpll_lock
    https://git.kernel.org/netdev/net/c/20040b2a3cb9
  - [net,2/3] dpll: zl3073x: use __dpll_device_change_ntf() and remove change_work
    https://git.kernel.org/netdev/net/c/d733f519f644
  - [net,3/3] dpll: zl3073x: make frequency monitor a per-device attribute
    https://git.kernel.org/netdev/net/c/c1224569cef0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



