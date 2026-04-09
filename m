Return-Path: <netdev+bounces-277059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIJJIyXN12mrTAgAu9opvQ
	(envelope-from <netdev+bounces-277059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:00:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1F3CD435
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6B231550CA
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350BF32D0DE;
	Thu,  9 Apr 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riZz5TH4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792EE2C027C;
	Thu,  9 Apr 2026 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749928; cv=none; b=auf+v1XDLfCCU5en4imluXUH7GX/0OF1MhzpnMTxqrcJX4E4PFW8oKHTGxAbO4TaH05FymySc/YIfqmNqHdUpQjSKgR883RLSxYOGqaYHaB6IXEQoEbZv2Inzd8J9tbGWdPyD19uPFOkSSZGcbivOxsbshXxfElyuRLj7s4JxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749928; c=relaxed/simple;
	bh=XUnp5KXSWx68sIpIEYzrg3KYEexlITMdS0Ff00KI95k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LpC2zLpi4JBteAEqgkklITMovvNqW9EWxg0BozkwT8/kVlKKEe3Hh8AqUOOt74Iuk7zlx7Sh+MXyaOWHeg8jAvEMRzdLpQOe0FJLDrkXDzrcz/S5MzhALcd5pCuQbpzyA/uybgl7rsS2xZV/F5FKioMJgU3kaJclrlRyKhzEMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riZz5TH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA183C4CEF7;
	Thu,  9 Apr 2026 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749927;
	bh=XUnp5KXSWx68sIpIEYzrg3KYEexlITMdS0Ff00KI95k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=riZz5TH4+WW/JDo7DSk1mc+dkIHjWZIM6CbBD+VChOKfxz/cKGPKVMldgC2RkD6Fn
	 makr9yF+7lCLkuz7oDfUittdevGiqGXF39I6l17yZlL0Wg6kliQGsSVWcOX0eR7k75
	 JfQCnQb+kBnPmxqwCAkqr6OsjljIN1z449qMcbRE1Np4s6TF865wmPd69vVcd2y+lw
	 HIZMH7CENhI8wZ5J3TOyM1WBW5nP37/3WsX3oCHjW7VeB9lAns3KlXYy89BLWAckg7
	 jETvqSguzj4Uf3h5IX9kf/X2/bKcLiXdeTsbTjTxrOCdjNVySh4UZ5hjp2itj+rKzd
	 QfgpKYsd7Tscg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0C439308AD;
	Thu,  9 Apr 2026 15:51:44 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260409143217.456564-1-pabeni@redhat.com>
References: <20260409143217.456564-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260409143217.456564-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc8
X-PR-Tracked-Commit-Id: b4afe3fa76a88ee7d3d8802b43fde89aa02f8e0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a55f7f5f29b32c2c53cc291899cf9b0c25a07f7c
Message-Id: <177574990336.1627667.183796140525083179.pr-tracker-bot@kernel.org>
Date: Thu, 09 Apr 2026 15:51:43 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277059-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47F1F3CD435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Thu,  9 Apr 2026 16:32:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a55f7f5f29b32c2c53cc291899cf9b0c25a07f7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

