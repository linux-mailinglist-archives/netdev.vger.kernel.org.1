Return-Path: <netdev+bounces-294898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uvPfIwGGIGqc4gAAu9opvQ
	(envelope-from <netdev+bounces-294898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:52:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E055E63AF9A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:52:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IWBzKAVp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294898-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294898-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8411D305D86C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B57377EAF;
	Wed,  3 Jun 2026 19:48:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB652DA762;
	Wed,  3 Jun 2026 19:48:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516117; cv=none; b=j4eSh5Z4bHCeI/Ah7RvpMENcUTScD9U19nPSQTE5S5TNcNAQ7RPQq3Q8doSlW5nq4MMlNVTbIuhIy5APb248D+I+ileRzX15Rv2OxJwqFOvxmwZRtx37G89zporC5/I/XI/zMBCS/kJI2gN3HBZcUNFBmGarTQq77qAqDeKF8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516117; c=relaxed/simple;
	bh=ohDb1BiAf8JuFmUiI2nqvxsDHIrBOqvVs7dYkeFEgWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3bDD9lV1mYwnYJLbVxjgzvRKumuyarRE4PJonBC22B50f4NH+VhByJM50wEtM/RUa4ThgEmouNfSPkhoRAR3JXqdyXsgelGjy+/EH+2QTEhIZF7lSoBqGdd0r+4lf0989yrgxhom+hJ7fGtEXnWT+QiTTWrA2AFFiVVdidiehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWBzKAVp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB0C1F00893;
	Wed,  3 Jun 2026 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780516116;
	bh=LbEghkJhUmiZ/M+duKXpyhTR5e5wLeAq78QpWbWJEkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWBzKAVpUfrPgTVf5FgrU6UMB1yBNI6Tr0vNrWPWNTcj9q/A6lUdMWBldf0Et8D3y
	 PSCdcn79bPUbAydQMh6YPGnATFp7ZMWQayzj9SGY5YEw8bu9SN6dK6IaSzJYfrRrAa
	 I3IUigMOxdhbDihgfWXl5QJaPYdZbmqEjoYyVsXAkag56mNECI998d/4Kj/VWLgUKZ
	 IY+VK05RhtLmii6hFGUstEwS/8x6uKFAE0W6bU0fTthElRXb0cDegp1qAhcZ8nOGuo
	 pRBtbfoqLyBvbVTazrO6HK/tvj4A6v1jdSrwNJFPuMgaV5jr541B4XCijZ9h55qXrz
	 55SxtFiVorzgg==
From: Simon Horman <horms@kernel.org>
To: sbhatta@marvell.com
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	bbhushan2@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-pf: mcs: Fix mcs resources free on PF shutdown
Date: Wed,  3 Jun 2026 20:46:53 +0100
Message-ID: <20260603194651.3838741-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1780054698-17307-1-git-send-email-sbhatta@marvell.com>
References: <1780054698-17307-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294898-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E055E63AF9A

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/

Simon says:

There is also an AI-generated review available at https://sashiko.dev
However, I do not believe it raises anything that needs to
be addressed in the context of this patch that is not already 
raised below.

---
Subject: octeontx2-pf: mcs: Fix mcs resources free on PF shutdown

This patch gates the MACSEC resource cleanup in cn10k_mcs_free() on
the txsc_list being non-empty, with the intent of skipping the
mailbox messages when no MCS resources were ever allocated to the
PF. It also sets clear_req->all in cn10k_mcs_free_rsrc().

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> index 2cc1bdfd9b2e..f25809c9d393 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> @@ -182,6 +182,7 @@ static void cn10k_mcs_free_rsrc(struct otx2_nic *pfvf, enum mcs_direction dir,
>  	clear_req->id = hw_rsrc_id;
>  	clear_req->type = type;
>  	clear_req->dir = dir;
> +	clear_req->all = all;

[Low]
Could the commit message mention this change?  Before the patch,
clear_req->all was never assigned and the mcs_clear_stats mailbox
always asked the AF to clear stats for the single resource named by
id.  After the patch, calls from cn10k_mcs_free() pass all=true and
the AF will now be asked to clear all PF-mapped resource stats.

That looks consistent with the pre-existing req->all = 1 on the
matching mcs_free_resources message, but it is an additional fix to
the AF mailbox protocol that the changelog does not describe and
that may want its own Fixes: tag for backporting.

>  
>  	req = otx2_mbox_alloc_msg_mcs_free_resources(mbox);
>  	if (!req)
> @@ -1776,9 +1777,14 @@ int cn10k_mcs_init(struct otx2_nic *pfvf)
>  
>  void cn10k_mcs_free(struct otx2_nic *pfvf)
>  {
> +	struct cn10k_mcs_cfg *cfg = pfvf->macsec_cfg;
> +
>  	if (!test_bit(CN10K_HW_MACSEC, &pfvf->hw.cap_flag))
>  		return;
>  
> +	if (list_empty(&cfg->txsc_list))
> +		return;
> +

[High]
Does this early return leak pfvf->macsec_cfg?

cn10k_mcs_init() unconditionally allocates cfg whenever
CN10K_HW_MACSEC is set, and initializes both lists empty:

	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
	...
	INIT_LIST_HEAD(&cfg->txsc_list);
	INIT_LIST_HEAD(&cfg->rxsc_list);
	pfvf->macsec_cfg = cfg;

txsc_list only becomes non-empty once the user creates a SecY via
cn10k_mdo_add_secy().  On any MACSEC-capable PF where the user never
configures MACSEC offload, txsc_list is still empty at otx2_remove()
time, and the new early return skips the trailing kfree:

>  	cn10k_mcs_free_rsrc(pfvf, MCS_TX, MCS_RSRC_TYPE_SECY, 0, true);
>  	cn10k_mcs_free_rsrc(pfvf, MCS_RX, MCS_RSRC_TYPE_SECY, 0, true);
>  	kfree(pfvf->macsec_cfg);
>  	pfvf->macsec_cfg = NULL;
>  }

The same path runs from the err_mcs_free probe error label in
otx2_probe() when cn10k_ipsec_init() fails, so the leak also fires
there.

Would gating only the two cn10k_mcs_free_rsrc() mailbox calls on
the empty-list condition, and keeping the kfree unconditional, work
better?  Something like:

	if (!list_empty(&cfg->txsc_list)) {
		cn10k_mcs_free_rsrc(pfvf, MCS_TX, MCS_RSRC_TYPE_SECY, 0, true);
		cn10k_mcs_free_rsrc(pfvf, MCS_RX, MCS_RSRC_TYPE_SECY, 0, true);
	}
	kfree(pfvf->macsec_cfg);
	pfvf->macsec_cfg = NULL;

