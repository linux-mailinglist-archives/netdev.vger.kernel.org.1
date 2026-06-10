Return-Path: <netdev+bounces-297728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VCSGM1+BKWqZYAMAu9opvQ
	(envelope-from <netdev+bounces-297728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D5466AAC6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:23:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="U/zA5YJN";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297728-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297728-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 102CF3270FE4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2C423A67;
	Wed, 10 Jun 2026 15:14:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489C40B364;
	Wed, 10 Jun 2026 15:14:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104477; cv=none; b=CU2qGZuBv+7TVziboiAbZ5bfSmRFMBY/zeQLbSY1cS2nyybEcrotZ/vnKr7rhOxFo09QzoaDoGcl6br4FSOFZXji73MKsTpY/u2A4cMY8M6pT1AVPRWE1UtkhBrTe+YMJSnDtqoscakcHEyVStwRlyDWNzuotS9QnlTIzLF3Yh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104477; c=relaxed/simple;
	bh=O4ESASxXJTBkmgS2eT0NxJimSSFVGnXuyGlnizkC9/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkH/2ozQTZxRbSCaQv24sotak37vm2rgCyVaHY1/hE5Fk9kdn0l5Nqk9j/LNX4zASDAsh+ytJDooamS3OTTuPIP9+fi2e1C0DwdJUYYpkbaIDr/PnGmY5ELdF5kq+KrLUZPBbwjJ+50rqV2zC2QkM+nh5Br6LmIXQtfKcEx1EKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/zA5YJN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C72C1F00893;
	Wed, 10 Jun 2026 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104476;
	bh=GLeTvS7KTUFpD6LfplzKEmpJrqfI0Ec5tYBniK/zx6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U/zA5YJNyG0v9Tkb8N08UsOaggJjv6nmcfJyFhhIdvham0SugCTVlm3E5AJNz3q4+
	 0ChixKfe8/i7aTSwKD/adpyDvqRqMZi0FOIBDJK56qYMDjMsyHqTtZDIQXUMI5pyoi
	 DKnqCnpdWdBUW1ycIHiQ4D6c9VZjwuLzIjDAszVX7dKvD/2VddHtwVhS6/9XZeMSH0
	 yLb2SvaB8bq8yJVt7x6RLHlJP7qkqRPmO+hvELQ/oygy3N7+MHqhgLiHoEsd4/eRg8
	 D63LMbX7OgbAdOdlML3jU2mrqMKRAVUiW8tiEYj3GBur/Zr24n8DCu9ShQRDE7LVH2
	 hrcfTkY4YzSEw==
Date: Wed, 10 Jun 2026 16:14:30 +0100
From: Simon Horman <horms@kernel.org>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rkannoth@marvell.com, sumang@marvell.com,
	kirankumark@marvell.com
Subject: Re: [PATCH net] octeontx2-af: fix IP fragment flag corruption on
 custom KPU profile load
Message-ID: <20260610151430.GN3920875@horms.kernel.org>
References: <20260608095455.1499203-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608095455.1499203-1-nshettyj@marvell.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297728-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nshettyj@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rkannoth@marvell.com,m:sumang@marvell.com,m:kirankumark@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34D5466AAC6

On Mon, Jun 08, 2026 at 03:24:55PM +0530, nshettyj@marvell.com wrote:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> npc_cn20k_apply_custom_kpu() overwrites KPU profile entries with custom
> firmware values and then calls npc_cn20k_update_action_entries_n_flags()
> over all entries.  Since the same function already ran during default
> profile initialisation, entries not overridden by the custom firmware
> get their flags translated twice, corrupting the CN20K-specific values.
> 
> Fix this by extracting the per-entry translation into a helper
> npc_cn20k_translate_action_flags() and calling it as each custom entry
> is loaded, removing the redundant batch call at the end.
> 
> Fixes: ef992a0f12e8 ("octeontx2-af: npc: cn20k: MKEX profile support")
> Cc: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


