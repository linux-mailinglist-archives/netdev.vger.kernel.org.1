Return-Path: <netdev+bounces-269247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MYMKNROu2lMigIAu9opvQ
	(envelope-from <netdev+bounces-269247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:18:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 365152C45BA
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38A40302C36E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650BF2701C4;
	Thu, 19 Mar 2026 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVOs3Vqr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAB13959D;
	Thu, 19 Mar 2026 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883087; cv=none; b=FV/pfFdHMpHlMedcNyv4ZfoZqyaIpTomXdkq+DOHpCtCRPMtdO5JXiOvgnDPmAdA54dCFKbCW/FnwWOO93RfZTFRRdOhljnSGRPsL18LVSWDOd8QcPDZCu5OfPuCms5pRaKN7MZ6Pg74Pqcr/aiSoC0i/r3LM3n+exfxutUoMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883087; c=relaxed/simple;
	bh=1IcHSe1kx32yk+/lPVOb3amCp9k9O3DIwnwELfiCgeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fa3YKvdgtcco67Wwvz01P38HMbK5nzzoikfwgWJ1ytGTDBc+pZ/C0OJMPDG6Mf4jtoC9mV0IlgqnFsaVysmRaxfW9TTW9OGyn4/UhcVjUsWyT0h1THYhBF44PfkyZzh/5XDH8e9pKgtWJBoy+UwChy4LWJ0aaE2Z5oT9nQy12t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVOs3Vqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41B2C19421;
	Thu, 19 Mar 2026 01:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773883087;
	bh=1IcHSe1kx32yk+/lPVOb3amCp9k9O3DIwnwELfiCgeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HVOs3VqrZaQjaYHiut5itf5b5ueLkxSDuyzf41TIyVsXI5w8ilsETv6B2dpmu8w4r
	 16Uzlii/A9Und3mfRTym08FtbczeEmFEW5TdYlmHmRiexTTiPvYtdI7qJqVaopPGGj
	 QKYKFjcM8BAF0O0WQOjZugQMGt8N8ng8cIPVPWn2D5AFI6fXYWMQ8asWgdjRIDAj57
	 QdKHY5wU+T2IvfnV18eeeFEW12iGATAp4j4U/YYZDIbfvOFIjtO/xXubjCy+2QPx3G
	 YH+8pzIrIQLsL0blrl5xEel5cLL6Hq4v/LJ/Ia6SLj/GRC2w6lU+Oj4ypfDwdX85X0
	 39KA3LMTPbwJw==
Date: Wed, 18 Mar 2026 18:18:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, Jiri
 Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: team: add non-Ethernet header_ops
 reproducer
Message-ID: <20260318181805.397dba97@kernel.org>
In-Reply-To: <20260317124606.157035-3-jiayuan.chen@linux.dev>
References: <20260317124606.157035-1-jiayuan.chen@linux.dev>
	<20260317124606.157035-3-jiayuan.chen@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-269247-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 365152C45BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 20:45:54 +0800 Jiayuan Chen wrote:
>  CONFIG_IPV6=y
> +CONFIG_NET_IPGRE=y
>  CONFIG_MACVLAN=y
>  CONFIG_NETDEVSIM=m

Again the sort :)

Please use the validate_* scripts from here:
https://github.com/linux-netdev/nipa/tree/main/tests/patch/check_selftest
they take the file name as the only arg and will tell if you its sorted.
For whatever definition of "sorted" we adopted...
-- 
pw-bot: cr

