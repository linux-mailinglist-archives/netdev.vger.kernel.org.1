Return-Path: <netdev+bounces-270198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCUNLKF0vmmZQAMAu9opvQ
	(envelope-from <netdev+bounces-270198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 11:36:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 589812E4C48
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 11:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6E073007E2B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8DF314D0D;
	Sat, 21 Mar 2026 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+CHKcvc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7402BD11;
	Sat, 21 Mar 2026 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089372; cv=none; b=J6mX7wy69t5sZyTXWd08qeG9qGKddMAcpTzyO0e6lPOGeNjLTuGTFERag+La8yjog9KcrMWn1+x0TjPdpSoVwOKmOjeqOrkHxkq6mHvyNkut9hbpmhqwTIF4GVmP4EMe7FhW0N3KRRwJw4MUN2z/XDNBvxXWJpaGMB6WzJbhKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089372; c=relaxed/simple;
	bh=/6eOLTSivq+etcgwBsYg5Tg2Jeg74Hgv+HHyl+MfzjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6OBKwRWfcAShTESWFyuEJ5Y2EzYWjTwhYSMQGG/04KuHMZ2FQY3mJTOdaCf3A0xBvKGW6p9RInvArNPuC/JeQgd2BP4GVi26+mIGhxz7ugD0y4DL7QBV+lWledomxrkGtIhCcjwv9XFZXRxYNDt3bvC7McbTv+95LuGfoAjigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+CHKcvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4DDC19421;
	Sat, 21 Mar 2026 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774089371;
	bh=/6eOLTSivq+etcgwBsYg5Tg2Jeg74Hgv+HHyl+MfzjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+CHKcvcxzfZXTvWuk0btSostGs112cEL/nkkDN4RiAwIvySyaTSS7YRsryeBytZp
	 10g2tQXRu0OXpBta3VDu6MBlQ8Ew22DDIC3NfZ7CTERkyAQRo7HXHDFps4/JeXaJEv
	 2sq/uoqovyZxLwpJ+R91aa/yZSMj1hieIS0/y/LTHuyDR+WhFP4OelAwex0A9Oblxc
	 d56sQMILsSzD63KAApDx90MN9HblHBgkmlSw7Zwgc/QmwD1ljixQkTfxzqyO/VAw3H
	 KLZEzYyO0Q/xtvjImgUVxY1MDJqVJRTQahkUm5ZF2HRhdjUHSuBqD5anUwKGk3Ob3G
	 M5MZu5Wf6P5zg==
Date: Sat, 21 Mar 2026 10:36:07 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] selftests: drv-net: add missing tc config options
 for netkit tests
Message-ID: <20260321103607.GA74886@horms.kernel.org>
References: <20260320-config-fixes-for-nk-tests-v1-1-1e20ec6ddc7e@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-config-fixes-for-nk-tests-v1-1-1e20ec6ddc7e@meta.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270198-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 589812E4C48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 11:08:35AM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> The NetDrvContEnv env context uses tc clsact qdiscs and BPF tc filters
> for traffic redirection, but the kernel config options are missing from
> the selftests config.
> 
> Without them, the tc qdisc installation trips on:
> 
>   CMD: tc qdisc add dev enp1s0 clsact
>     EXIT: 2
>     STDERR: Error: Specified qdisc kind is unknown.
> 
>   net.lib.py.utils.CmdExitFailure: Command failed
> 
> Add CONFIG_NET_CLS_ACT and CONFIG_NET_SCH_INGRESS to enable these tc
> options.
> 
> Fixes: 3f74d5bb807e ("selftests/net: Add env for container based tests")
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Hi Bobby,

Unfortunately this does not apply cleanly to net.
Which breaks CI.

Please rebase and repost.

-- 
pw-bot: cr

