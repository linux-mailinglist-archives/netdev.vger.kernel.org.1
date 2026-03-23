Return-Path: <netdev+bounces-270775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLh8D/C8wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:21:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4292FE2F1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25DA7301828C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0137DEB2;
	Mon, 23 Mar 2026 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsRkOhn9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD735CB7B
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304417; cv=none; b=q6IgLhAUkXXVt1OnVk1sG/QNbpFC2OlBmWskGMz5KV/yOTIt3PdHMx0tI06SvhNOTkHltFbDnugFoBkq8wKhGeJYM9JyIsv0oPAL0dIL8ap0p7Q81qUVaQcq9vlqO71OSkFNIfNG3H7f9hhmq2+bBGtZ4cd2x7FL4r6Fau8Sy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304417; c=relaxed/simple;
	bh=bYXy3LdMj+0XWlcZO03oYQc6uOT3hzveDRqcIhsWjcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KHKi3Wv6DxBzGIka4jVsJVC7Hzf6HgNi3xjC4ZHulfdW41OFAHqJ3l46gDe6+2wyUy5TlTtd2IGkATfklyWlDFpn5y+KL0HiD3nAZ2gqPZjHGp1E3wvWwbnEGiFTwy/Y9Bij83BcdBohzLLo7up38nv2t4EZdeIl2QN9J2XjsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsRkOhn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487DEC4CEF7;
	Mon, 23 Mar 2026 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774304417;
	bh=bYXy3LdMj+0XWlcZO03oYQc6uOT3hzveDRqcIhsWjcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LsRkOhn935rAVUXAN56mv/yfOFeKXpBNOFK4iU+/i2v8bp07rTM0BMVN6sn4HTdqS
	 7DDYTJcitjUK2j5ZUiNusRiD6VmkHr1dVk3eMT4rts8b58IFwhMQoRrPQdcsS70Yo/
	 YB//i7jAxXWTPXuUhf8JLgWPE3WNeGkNOSTx/ROrCYDnEdl27NmaqAGikhVlVvJ/vU
	 JEPONe4rHQFREY1ECd1qsiZ8W/dbhJ+SqXXc6wRlxTQ3TPUPPyNK6BDXz1ebuI8YXO
	 LDiEnBgtXLqt3dgjkQAKYkdOrhHNGiaMVZB8TwsGnV+rf1sAHxMHgbJO+iXLwFlX2n
	 WtiP6dRz20ttQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3E3808200;
	Mon, 23 Mar 2026 22:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 ethtool] cmis: Fix incorrect LSB field used for
 wavelength
 tolerance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177430440554.345009.8468557542937446046.git-patchwork-notify@kernel.org>
Date: Mon, 23 Mar 2026 22:20:05 +0000
References: <20260321153905.644959-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260321153905.644959-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: danieller@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org,
 mkubecek@suse.cz, alok.a.tiwarilinux@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270775-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,suse.cz,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 9C4292FE2F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Sat, 21 Mar 2026 08:39:02 -0700 you wrote:
> The wavelength tolerance calculation mistakenly uses the nominal
> wavelength LSB field (CMIS_NOM_WAVELENGTH_LSB) instead of the correct
> tolerance LSB field (CMIS_WAVELENGTH_TOL_LSB). This causes incorrect
> values to be reported for the "Laser wavelength tolerance".
> 
> Use CMIS_NOM_WAVELENGTH_LSB -> CMIS_WAVELENGTH_TOL_LSB.
> correct 0.005 nm LSB scaling for the tolerance field (per CMIS)
> 
> [...]

Here is the summary with links:
  - [v2,ethtool] cmis: Fix incorrect LSB field used for wavelength tolerance
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=40d272752bb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



