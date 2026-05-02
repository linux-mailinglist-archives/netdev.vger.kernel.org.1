Return-Path: <netdev+bounces-283447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NR+CXwy9mn4SwIAu9opvQ
	(envelope-from <netdev+bounces-283447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 781084B306C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E088300A4D8
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74883822A2;
	Sat,  2 May 2026 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVIVDJzB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA73101B8
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742455; cv=none; b=HRf1s3/Sc/69yYSllkLBy1+9pc6CGu+l4tEQKZ1ifpB/AI33bdx3ORmyyO+A5UdUUXvw9cdACz0SXs7QNlwf/9bzbNIsPFm1SZ+yC1GNeT2twG/l7qVSw9lz0800Jrkicn4fnaFJ4cG0PhwJDHtpOXVezy/XCE96oyLJ1Gbf4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742455; c=relaxed/simple;
	bh=fJMB9rpalVmvEP0NZbvjq+09U7J9jbfyWWNlpFKbOuM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dIqmjRBYg0B3PIz3sD97sXckpJjowzVTPntW9BnpCckjzFMjQchoeVSheOlg9y3e29/zv1lbXh0lPqd2cQiXp4mv0NeRDxCuiM8AaI2Q47ILaeyDmTrSy8gXU/QbdzvvbjqD0Pfi3L1m2SUVHYDyoCFofiK2UWzG+abeIZu2/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVIVDJzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9B0C19425;
	Sat,  2 May 2026 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777742455;
	bh=fJMB9rpalVmvEP0NZbvjq+09U7J9jbfyWWNlpFKbOuM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tVIVDJzBSrHYgrbj6fMqiz8mGotRv51gwLZQ2iYwAsZIq0LNpaiPJ/MUY4QeVtTOt
	 pL/mhL1qHxvhoqLyu9Buyz9yUZAIg0Ay4MJpdekYhIEbVdA/dpE1pYwHaHCHL8QeTg
	 cujzzke1rBoL2mTkLqg1gwZWyesz1X7sAtSkS6spUDOEfk7KaMpaLcUni83GnfeBdf
	 cE6+y4DE6/avSoZe0PXjBJI27LU3AFsErBKJJlMKjbBlTYODSKId2OcgbbACQdSW58
	 fqkvsHh+U+67+ssDzt3tCMANTsIoNazqRRONvejXV0xKeBIrshAKTqbaRoGn8TM59F
	 pEa6AAY9w0mGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D69380CEFF;
	Sat,  2 May 2026 17:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774240731.3889878.18027662275547205090.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 17:20:07 +0000
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
In-Reply-To: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com
X-Rspamd-Queue-Id: 781084B306C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283447-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hitachienergy.com:email]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 13:42:07 +0200 you wrote:
> Unmapping of uf_regs is done from ucc_fast_free and doesn't need to be
> done explicitly. If already unmapped ucc_fast_free will crash.
> 
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>  drivers/net/wan/fsl_ucc_hdlc.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
    https://git.kernel.org/netdev/net/c/1a57efe250a1
  - [2/2] net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove
    https://git.kernel.org/netdev/net/c/851bba8068d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



