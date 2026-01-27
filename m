Return-Path: <netdev+bounces-253707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMoBH71IeGnipAEAu9opvQ
	(envelope-from <netdev+bounces-253707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:10:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F78FF7F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7B903032DF7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773CF328B5D;
	Tue, 27 Jan 2026 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ/s5gg5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52196328B41;
	Tue, 27 Jan 2026 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769490613; cv=none; b=FJf4zTIqfDunqRsRp2p7fTlhh3aLA1VhJ4k1iY0ftckP9CkJr6xKLt9uNNg0yaBISPqEFRQIe2mtDYsWVqMd8Ga6PZIoc1bXE1GNieKsQB92zxWMSRYyizrzHK3dEJOCaD6Q9gIC0mWgtpWM3pHTpKhqjzw4+KggH15FwUUcUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769490613; c=relaxed/simple;
	bh=dFMjlaqBDCMpuScUpOCYTgf6gwlnHRXkbqdrLFSo3kc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YkYvKmnouzplKPCei0oXvI7pSgxkvSLjYhEM00CqUipg0aGoKxiTz3jvIGx3Qda/nBYor8zRHRqwTql1+OBaV5/y1Dz7dJnWDbCZKj2wZjQqCMS/aNIstyLbJryOQJXqCRFEd4NZOHT3WobWZ9Z+U+XkLWm5sU94xCFkMjAox2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ/s5gg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B31C116C6;
	Tue, 27 Jan 2026 05:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769490613;
	bh=dFMjlaqBDCMpuScUpOCYTgf6gwlnHRXkbqdrLFSo3kc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qJ/s5gg5kaqAtjA7biZ3z1SrIGEjD9OR6HEgnnUqv4SXZJh/teXsWsRjt5xLHrRs9
	 u+0Oz8xpKbCC/0ldv9fgm2E+GX7nukDygIZgPap7E9LRXQ1J6Kt3owZPrBe6yNIYpL
	 TIby8ynuzFhcEQWhh+anOWzVMWhtB0rJuwr12/f91izxDJsJz30g0T7EHhoki6Yte2
	 Uf6uLKMAENb66+PCXwdoqiMnpFIu7a+AQRlywKSuH9G4XZXer04QIgeaGUnwVicrQe
	 uDPB9Q7EmcDYAA6ucmDP5twi6/1bgI07UEC5QLx0iV7rISxzRryRAJ1TmpcLtQJnxZ
	 HDgzC4ERfWPDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBBB380A961;
	Tue, 27 Jan 2026 05:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: ti: netcp: Use u64_stats_t with
 u64_stats_sync properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176949060734.690573.3564112889209838707.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 05:10:07 +0000
References: <20260123164841.2890054-1-mmyangfl@gmail.com>
In-Reply-To: <20260123164841.2890054-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, kory.maincent@bootlin.com,
 jacob.e.keller@intel.com, nm@ti.com, linux-kernel@vger.kernel.org
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
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253707-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 350F78FF7F
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 00:48:36 +0800 you wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.
> 
> Note that does not mean the code is now tear-free: there're u32 counters
> unprotected by u64_stats or anything else.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: ti: netcp: Use u64_stats_t with u64_stats_sync properly
    https://git.kernel.org/netdev/net-next/c/3eef6c061f97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



