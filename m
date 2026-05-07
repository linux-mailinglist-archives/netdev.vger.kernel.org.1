Return-Path: <netdev+bounces-285451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDaOHMfQ/GlhTwAAu9opvQ
	(envelope-from <netdev+bounces-285451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:49:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F204ED113
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD595307D414
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103C44D00A;
	Thu,  7 May 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdXIvgOq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219D3AD513;
	Thu,  7 May 2026 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175809; cv=none; b=VX2H9+fgRCYlisXvzFqCn6e4uuK2TLFhy2qAMBMc7HoI6SLsvws3m0fCh3rhXW13878lDkoSGwZBeQa8veVr/iYRZG5LTzuxMlAepMHUVVcFgq9do89MTMe39UU1qIfv5Fv2V+U6gsZLg0EMR7Yb3tfe+jp1qAEqFJSSbCODZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175809; c=relaxed/simple;
	bh=SMdYQRbTmUHNSgw72fQY2mtJNLbKIl0fODZAtOCPwOI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c4hELfHLZZXVBjs0Td+Vb4kzBum0DRI1LMlX4GZw+jOc+ELnE3h3O4QvdVdWb4mjGZBiJ9fsFkgwTBelaa5rhvXd2ILoIBzFH7QQMpSEk0TIuiQ4sh/vj0UtdyoVpzRIhdezCMQXLs7Vf+8akOFNm2VLm84g6Lppubs09iuNu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdXIvgOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ED1C2BCB2;
	Thu,  7 May 2026 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778175808;
	bh=SMdYQRbTmUHNSgw72fQY2mtJNLbKIl0fODZAtOCPwOI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pdXIvgOqPYabt/fbel4KEUEU+qJa3T4NGZ59lDOk71YBZT3DohbnRs0ACWHsfazbO
	 BkjauWkXWCylxK4aswLSEjD3ogKRUP4Hkek3LuZyiOGh9jn5geHwjPUFeR5lNdVLVO
	 UaSeIlW4TGadc5DHKqQ4TvyZuLNYy1ZvrborUMVXaLo2x0x7qOBP5qUjOaFzgE1P2H
	 hdVwamP+rVzTvU3ddbyptOLtzyeZgPhbXVUyfzCamPW5ReDo9wETY89osTPKL6Lbsp
	 JeI6zdZ1VYYhuRmlShKcHAflz6lMeW29IVH4CHFnIij1efCZ7iiGAtzSsOhPuLXBlr
	 52ko6bLjD5hwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF23380CFFF;
	Thu,  7 May 2026 17:42:39 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260507172147.3509230-1-kuba@kernel.org>
References: <20260507172147.3509230-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260507172147.3509230-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc3
X-PR-Tracked-Commit-Id: 41ae14071cd7f6a7770e2fe1f8a0859d4c2c6ba4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcee7d82f27d6a8b1ddc5bbefda59b4e441e9bc0
Message-Id: <177817575775.4093859.4246355186175777971.pr-tracker-bot@kernel.org>
Date: Thu, 07 May 2026 17:42:37 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: D3F204ED113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285451-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The pull request you sent on Thu,  7 May 2026 10:21:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcee7d82f27d6a8b1ddc5bbefda59b4e441e9bc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

