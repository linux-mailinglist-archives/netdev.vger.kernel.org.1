Return-Path: <netdev+bounces-258848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEOHNcbnkmlSzwEAu9opvQ
	(envelope-from <netdev+bounces-258848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:47:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F1B1420E6
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A32DF300382D
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8CA28488D;
	Mon, 16 Feb 2026 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9qL6XNd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6B1DDC2B;
	Mon, 16 Feb 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235268; cv=none; b=f2bCh2v6mukAVjAMCUzjJ6XQ71oNpDUoUpsTtsoxdpB9K4uYvi5CF8pg3Fo7pptzX8mqf+8IHVXEt+1THvOaBD1gjQAL2utAnEBkquJogFG53+6aV9dpmawBAVTLOV0Q52wVR6IQztkPkKOpqULaJ9z69iJhHai9+bDiSY4Mmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235268; c=relaxed/simple;
	bh=wOzCpVa225o/E2DQ8JgXBffBPOyh8pXVFlmCX8wSEAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9xJIdtpn4yXvE7ISm9xDCX4eDUDt7jsXHUO+xDKCG6guwd+HVOkOcMBMY0f2nvymi2JhyFOl729csqJEEbtK3/77IkhMcrudhRr1xWt7bXL7ZYFVo6FNqXH3kJKTsclbFRyWYaa5YlaN79ZTFEG/T8LcU94s8QwUC3KDdvDx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9qL6XNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55CCC116C6;
	Mon, 16 Feb 2026 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771235267;
	bh=wOzCpVa225o/E2DQ8JgXBffBPOyh8pXVFlmCX8wSEAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9qL6XNdb55e1YOqsK6B7oN6PeKJ7m/VDyuwE+Dt7YL9uEruqJ9HTvzWJsVXK/VJ9
	 oeqxLegXfw98TyHVs3zBI7ZpQ4hsQpsaiFGt8DyMBsf6vrvq/vZJWY7pPFkqGGyWMX
	 2TFwTuPm98gJvZ4rED+uS/hGJsipJSiXhi9tJL9H0n8p6nkV1U+0f2MR1uzSw0oUwJ
	 PGolnpS08HdrRxmN3qGHldGvXCjo6Px27/O0zFuJlNraJ8q6RoI5Rdega1gw1OmZYx
	 TsN6Ox0GuPF4+APwo/46fKtw1VnaA56HR8LVjuXOb17yMRi9784p2lBvWu/Cwh8KCY
	 5omz+c/aU6cNA==
Date: Mon, 16 Feb 2026 09:47:42 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Breno Leitao <leitao@debian.org>, Arnd Bergmann <arnd@arndb.de>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: add CONFIG_PRINTK dependency for netconsole
Message-ID: <aZLnvlwMJ5oOypVN@horms.kernel.org>
References: <20260213074431.1729627-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213074431.1729627-1-arnd@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258848-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 45F1B1420E6
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 08:44:00AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'select PRINTK_EXECUTION_CTX' line now causes a harmless warning
> when NETCONSOLE_DYNAMIC is enabled but PRINTK is not:
> 
> WARNING: unmet direct dependencies detected for PRINTK_EXECUTION_CTX
>   Depends on [n]: PRINTK [=n]
>   Selected by [y]:
>   - NETCONSOLE_DYNAMIC [=y] && NETDEVICES [=y] && NET_CORE [=y] && NETCONSOLE [=y] && SYSFS [=y] && CONFIGFS_FS [=y] && (NETCONSOLE [=y]!=y [=y] || CONFIGFS_FS [=y]!=m [=m])
> 
> In that configuration, the netconsole driver is useless anyway, so
> avoid this with an added dependency that prevents CONFIG_NETCONSOLE
> to be enabled without CONFIG_PRINTK.
> 
> Fixes: 60325c27d3cf ("printk: Add execution context (task name/CPU) to printk_info")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Simon Horman <horms@kernel.org>


