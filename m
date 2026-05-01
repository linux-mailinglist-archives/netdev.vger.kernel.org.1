Return-Path: <netdev+bounces-283307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMmLJeg59WmaJgIAu9opvQ
	(envelope-from <netdev+bounces-283307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD664B0568
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 130A23016C8A
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 23:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4AE37F011;
	Fri,  1 May 2026 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAgNsDne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8637BE63
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678793; cv=none; b=hS+jxUYsF/QKrqEfbla9N9nMm1FCL/XhGv+ywZwfzsSIp7ME8MFFUnlgeZjmgmhITd295OCDp05WPEHZfw4Q8SYrevGKcp4ZkgTxIGGg5wTx0S7h9RuMg712fHoApE42rGggDx+gO9ZiJdfZqOcPAVHTH9Wo0AK/+sB7coevJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678793; c=relaxed/simple;
	bh=5YfV8VWWq8mP1mXXNvrdgKeiDjy+CGWkFrkox99XJck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfxRUKg+Xh5YiC4axx88LpFuvRfYMkvsiCOSeXx9DVS7r08aVtfWUBpmvng+dyovJYpTNXIK8XsKW16WgAvvjAfbl4+qL3JrESQmXy7lzHnQckPNJIlfc5g9+DCaDcEJez66FELUHsISxO2OgUNYEkg6iNJ8G4TU5VzoowjON64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAgNsDne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7783DC2BCB4;
	Fri,  1 May 2026 23:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678792;
	bh=5YfV8VWWq8mP1mXXNvrdgKeiDjy+CGWkFrkox99XJck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CAgNsDneFujRciAaUIdCtKGL6CrRi8wYWx5cwpnxY7oGUvYO3vCN+h0Jf4PI3RPXp
	 oN561LM6o5zpIzP3WJp/h35+j7SeM/vena62QxfVwh6PaWerB43+rngp4uakU/ybOL
	 JwkdGyZdpgNfrtlduBK9i10Z8TMMqic+csWxFHpPyPtIkw8zyLelDBMH5yTCKNxwvZ
	 hIWz36cYa7IIfmwWnSwx3ywzqFaH0PPzWP5EiPIoU6zfza287rQY1ireZHeveV89ND
	 abUL4ADCE5kprgcEEmdfmIjtz3VXXlKPLPnx0umAw5b3xEa3opynKt7IE+e2C6ABek
	 u59z1vShx14RA==
Date: Fri, 1 May 2026 16:39:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/5] ionic: Report "link_down_events_phy" in
 ethtool statistics
Message-ID: <20260501163951.0e0b7e97@kernel.org>
In-Reply-To: <20260501031555.43259-3-eric.joyner@amd.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
	<20260501031555.43259-3-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EFD664B0568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283307-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 20:15:52 -0700 Eric Joyner wrote:
> The number of times that link has gone down at the port level is tracked
> by the firmware and sent to the driver via regular DMA writes to an
> instance of struct ionic_port_status in the driver's memory.
> 
> This statistic was never reported, but it is useful for diagnostics, so
> add it to the "ethtool -S` stats output, grouped with the other
> port-level stats that are contained in struct ionic_port_stats.

We have a standard stat for this:

struct ethtool_link_ext_stats {
	/* Custom Linux statistic for PHY level link down events.
	 * In a simpler world it should be equal to netdev->carrier_down_count
	 * unfortunately netdev also counts local reconfigurations which don't
	 * actually take the physical link down, not to mention NC-SI which,
	 * if present, keeps the link up regardless of host state.
	 * This statistic counts when PHY _actually_ went down, or lost link.
	 *
	 * Note that we need u64 for ethtool_stats_init() and comparisons
	 * to ETHTOOL_STAT_NOT_SET, but only u32 is exposed to the user.
	 */
	u64 link_down_events;
};


IOW the definition of this stat is - ignoring asymetric link faults
this counter should match between link partners.

