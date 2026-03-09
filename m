Return-Path: <netdev+bounces-265794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGJpFUZWr2lJUgIAu9opvQ
	(envelope-from <netdev+bounces-265794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:22:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA17B242A52
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 540DE304E0FC
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 23:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536538F627;
	Mon,  9 Mar 2026 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsEIJPpc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812222C237C;
	Mon,  9 Mar 2026 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098524; cv=none; b=XGSi7wai1oe1jZfh3hP5FqQ/sr4IOjSn0h+TzzcpqppQIJeCQaUnrJxLwpHMHVl684MrN5J7bLehQlPMF2SASDU22fIM7376zJuk4Zzld4eok1BnOy1SOp/Vz2iDfXHJlzSO9sbXlKpkJIfYvvD6Jkb9GcxcAx4/x15HU7/i/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098524; c=relaxed/simple;
	bh=VBoGik46nYs3fgztSgEGZwDZZW+twkpgJXmDsrR0VIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOVQOi7oImZqW1FvXDJuSMKilO2wPsR2ZWDpMFI5+dCxopmYJf6TbuarlAgM9gfaDe2sGpgcXju50umOiziuGNyy/Y66N7z9uxV9vdS5rNxLEO7N5NcYyoDU7qTxfcqy28yhzxeeBRefXWaodkznHAiSRfqLcr9KqfOflHr6hwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsEIJPpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52826C4CEF7;
	Mon,  9 Mar 2026 23:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773098524;
	bh=VBoGik46nYs3fgztSgEGZwDZZW+twkpgJXmDsrR0VIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZsEIJPpc3nQJ0v7Szjj0TjuffoWoe4H4mIqToEJVUI6SlP0/5rG1dKDnmHbNkjHzb
	 NjF9N4h8FGNL+C+lTMNc14bvbtI4DyUDlxn2DfJhh5khb054sfihYSvL5T83Do8EqO
	 3prubCtyLF4Tqil5wFCMJjkPjKnuvdla/CG42EhHV8v2Pjm9eSL7oCx9jGeW2om374
	 33Dnn2wBQanGf68f/SCQEihFmuhazrrNsIOgeUmyQZXuHbNZhoBLoIRlDRVPuT+DSk
	 Mo4g4FCxweEozOQqAolFSodJF0lRiLPn+Y624sN+l3cHQs+qYiIU0NRiUQL0IqYzH8
	 I4IRDpOzRjfDg==
Date: Mon, 9 Mar 2026 16:22:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Frank Wunderlich
 <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>, Cezary Wilmanski
 <cezary.wilmanski@adtran.com>, Liang Xu <lxu@maxlinear.com>, "Benny
 (Ying-Tsan) Weng" <yweng@maxlinear.com>, Jose Maria Verdu Munoz
 <jverdu@maxlinear.com>, Avinash Jayaraman <ajayaraman@maxlinear.com>, John
 Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <20260309162202.5def074e@kernel.org>
In-Reply-To: <8aebab4c4bffa7e756ffbad4e9c9c8160773dd1a.1772853341.git.daniel@makrotopia.org>
References: <cover.1772853341.git.daniel@makrotopia.org>
	<8aebab4c4bffa7e756ffbad4e9c9c8160773dd1a.1772853341.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AA17B242A52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-265794-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bridge_vlan_unaware.sh:url]
X-Rspamd-Action: no action

On Sat, 7 Mar 2026 03:31:17 +0000 Daniel Golle wrote:
> Add support for bridge offloading on the mxl862xx DSA driver.
> 
> Implement joining and leaving bridges as well as add, delete and dump
> operations on isolated FDBs and setting a port's STP state.
> 
> The switch supports a maximum of 63 bridges, however, up to 12 may
> be used as "single-port bridges" to isolate standalone ports.
> Allowing up to 48 bridges to be offloaded seems more than enough on
> that hardware, hence that is set as max_num_bridges.
> 
> A total of 128 bridge ports are supported in the bridge portmap, and
> virtual bridge ports have to be used eg. for link-aggregation, hence
> potentially exceeding the number of hardware ports.
> 
> As there are now more users of the BRIDGEPORT_CONFIG_SET API and the
> state of each port is cached locally, introduce a helper function
> mxl862xx_set_bridge_port(struct dsa_switch *ds, int port) which is
> then also be used to replace the direct calls to the API in
> mxl862xx_setup_cpu_bridge() and mxl862xx_add_single_port_bridge(),
> while removing the accidentally added VLAN-aware-learning settings.
> 
> Note that there is no convenient way to control flooding on per-port
> level, so the driver is using a QoS meter setup as a stopper in lack
> of any better option. This works, but allows a single 64-byte packet
> to pass once after reset. While this limitation doesn't seem to be a
> problem in practice, it has the effect that the bridge_vlan_unaware.sh
> selftest only passes the FDB test the 2nd time the test is run after
> boot (and any subsequent time after that, of course).

Warning: drivers/net/dsa/mxl862xx/mxl862xx-api.h:145 struct member 'first_bridge_port_id' not described in 'mxl862xx_mac_table_read'
Warning: drivers/net/dsa/mxl862xx/mxl862xx-api.h:806 missing initial short description on line:
 * enum mxl862xx_stp_port_state

Also AI has a bunch of endianness complaints:
https://netdev-ai.bots.linux.dev/ai-review.html?id=b924beb1-9dec-4afb-ae21-5585ec8e7667
-- 
pw-bot: cr

