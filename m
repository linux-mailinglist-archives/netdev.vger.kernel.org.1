Return-Path: <netdev+bounces-271779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK5RCU5wxGkszQQAu9opvQ
	(envelope-from <netdev+bounces-271779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 00:31:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E0532D5D2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 00:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DACB303F451
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2343976A7;
	Wed, 25 Mar 2026 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShEB+kj9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED538F25F;
	Wed, 25 Mar 2026 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481375; cv=none; b=O6Fv9gCbWGvijIfw2X8IYmYzAsKbBDMufahWIXISUBnLmCi5Xnzj+ZlWSAwx+oIEGGA/PpcEwlPSet2HHJ2rv65jufcYBRYPiXgjrpeX52M2r6yKvWy9Hl7cEtdrLXZEeDn9dUivfd6VvwVYsXqn7CutoYvxmJS2Bz+nESO1VBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481375; c=relaxed/simple;
	bh=cPGQTKdSkqCCJhF7LPA0QBVYRbPilBNc9gD/d+3kH24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTL6Ft8IEbogP2sFd0OqRuHYJoL0Gw1Hiq9rkYEWzuELgEY1sCyDS/THg0ixSnHaC88CTInz7fiCEOKGhtbUXZLXoa5BbylS7yc3LvnF48daiHJgk0h5TGC3fu5uU6CcCaJbcCetdJoOkC3b4oqUG+r6o/M9qmA4oqfVkL0YHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShEB+kj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5349C4CEF7;
	Wed, 25 Mar 2026 23:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774481375;
	bh=cPGQTKdSkqCCJhF7LPA0QBVYRbPilBNc9gD/d+3kH24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ShEB+kj9XTZhRfHE5LuZU0kA9Z+29j3fyVYECXrItz8MK4Yuk+y9PKCLEklwjIwLN
	 +uNaQ7+bZoGTNS40ZR3Z62Y5fLfSFezHm5fwkMDalbrJDKhriV+zL7Q3d+nV+3JNC+
	 xoC1hsNH+ioxSisCqL9u7hZ6WZoaaqDu32Wp0S9fnrvBkN85RLofI2p1wd+C6f183j
	 xYu9upIHhzhXewpO7U6HMuDQPmBfnnRF6Vp1HnRaV23lrfPK6NYAdMiJocc0zFF9GH
	 xVmgFo2FRz5BLA4KiuQKtBzzJvZKWqhyoFfo4Byw901VNiAXUda3jn4zWMg0kzs0Pc
	 qevh54SuDLLlA==
Date: Wed, 25 Mar 2026 16:29:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, linux-doc@vger.kernel.org, lorenzo@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 lukas.bulwahn@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org
 (open list)
Subject: Re: [PATCH v9 net-next 00/11] nbl driver for Nebulamatrix NICs
Message-ID: <20260325162932.652abf89@kernel.org>
In-Reply-To: <20260325040048.2313-1-illusion.wang@nebula-matrix.com>
References: <20260325040048.2313-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86E0532D5D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 12:00:32 +0800 illusion.wang wrote:
> This patch series represents the first phase. We plan to integrate it in
> two phases: the first phase covers mailbox and chip configuration,
> while the second phase involves net dev configuration.
> Together, they will provide basic PF-based Ethernet port transmission and
> reception capabilities.
> 
> After that, we will consider other features, such as ethtool support,
> flow management, adminq messaging, VF support, debugfs support, etc.

Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst:3: (SEVERE/4) Title overline & underline mismatch.
    
    =====================================================
    Linux Base Driver for Nebula-matrix M18000-NIC family
    ======================================================
-- 
pw-bot: cr

