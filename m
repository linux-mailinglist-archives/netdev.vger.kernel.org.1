Return-Path: <netdev+bounces-259641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GdaCtzel2nW9gIAu9opvQ
	(envelope-from <netdev+bounces-259641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 05:11:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F59164830
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 05:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD29E303A86A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 04:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2A02FC881;
	Fri, 20 Feb 2026 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAm4gV2c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064572F83AC;
	Fri, 20 Feb 2026 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560633; cv=none; b=QcZlK6PBOSer24S8XbHqCZxfownSzRmNixAyAU6NdJ0uIzbTYZjAvmN+7wudakYBMoz2110dqM8UmQ4IzqKzfDBs/xvR46MS/IXKJwPa/tnOg4jLaYjnCuX+GVBUh4xzhgF2Dm5ZcaezZM4A6Z8cqzR+urjtO8z8QRC2j/hjvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560633; c=relaxed/simple;
	bh=72mBwftCl+P66JkWk2D3tPM6F5W5fqiLlxhFDPCaeZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NNeWTOBXwd7qsFGH7SJzqHnjwAiFoqrm6aMNxoRWYOeWSEGyH/H/G06mB3c1pI+OwhEGtn3guQdheEjBwMCBlZ8c6+0N95ZAeq4EGkZncuR31YqVPprk5rjoBB2dD0Y+8+nijOAWSS2w8yf6HwJjAUiXvS7luMgLf54CZISMKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAm4gV2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05E8C2BC9E;
	Fri, 20 Feb 2026 04:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560632;
	bh=72mBwftCl+P66JkWk2D3tPM6F5W5fqiLlxhFDPCaeZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bAm4gV2cKvjN5GuYeDqOqnWaOQJnwWiubm5cPxzG0b1Sls51+3jb0M5jPJ1+SGZTp
	 BNMGuKF+rHUZyZkSemcZ7VP/pg7JHj2ZcfuVFKpEER40qLLDnHc+EVOwAimnPx17DQ
	 /jDJhzaTZP/JOxp36YKfDTewflsvr8lV3YbUHfUAOw4uyWsvqfoKgWsWEaQXJWPeS0
	 7yQWORIx1F33RSW37fCo4RiS84fyL5mrOB1bDmofqalUb0Xx4bXIumnN+Z2lzvlWAZ
	 8a+Io+IXkFA3DZOs/NEEJxN4KV44owP83FsMWAyt+2OmNLolEZfWlAR2gjA0OmJimN
	 kkoQWYIwgr7TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD913809A88;
	Fri, 20 Feb 2026 04:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] PCI/MSI: Generalize no_64bit_msi into
 msi_addr_mask
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156064078.189817.10457864568127488431.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:40 +0000
References: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
In-Reply-To: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bhelgaas@google.com, perex@perex.cz,
 tiwai@suse.com, brett.creeley@amd.com, gaohan@iscas.ac.cn, tglx@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, sophgo@lists.linux.dev, tiwai@suse.de
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
	TAGGED_FROM(0.00)[bounces-259641-lists,netdev=lfdr.de,linux-riscv];
	FREEMAIL_CC(0.00)[lists.infradead.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,amd.com,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,perex.cz,suse.com,iscas.ac.cn,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org,lists.linux.dev,suse.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92F59164830
X-Rspamd-Action: no action

Hello:

This series was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@kernel.org>:

On Thu, 29 Jan 2026 09:56:05 +0800 you wrote:
> The Sophgo SG2042 is a cursed machine in more ways than one.
> 
> The one way relevant to this patch series is that its PCIe controller
> has neither INTx nor a low-address MSI doorbell wired up. Instead, the
> only usable MSI doorbell is a SoC one at 0x7030010300, which is above
> the 32-bit limit.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] PCI/MSI: Conservatively generalize no_64bit_msi into msi_addr_mask
    https://git.kernel.org/riscv/c/386ced19e9a3
  - [v4,2/4] PCI/MSI: Check msi_addr_mask in msi_verify_entries()
    https://git.kernel.org/riscv/c/52f0d862f595
  - [v4,3/4] drm/radeon: Raise msi_addr_mask to dma_bits
    https://git.kernel.org/riscv/c/617562bbe12d
  - [v4,4/4] ALSA: hda/intel: Raise msi_addr_mask to dma_bits
    https://git.kernel.org/riscv/c/cb9b6f9d2be6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



