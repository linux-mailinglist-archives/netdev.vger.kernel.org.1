Return-Path: <netdev+bounces-290974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKRuHODyEGq2fwYAu9opvQ
	(envelope-from <netdev+bounces-290974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:20:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D22045BBD7B
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8798303AF28
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA01A76BB;
	Sat, 23 May 2026 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka001qVo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E085175A8B
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495403; cv=none; b=Z2L344eXIJ/lSIDHrtSJTxey+h8p9z/uzdxxxuYn7tAo+yn8k6d7TD63OJTK41CBS3VhD+AGG6bkmcSQZnG7ajh1ol/VK1ZenSFZ3dD/VrFvCaE9IYs+0q1lU1rb10SCGOA8nOsTro0EF9wkyPg49EbmbtdJnOpaIehOp0oRf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495403; c=relaxed/simple;
	bh=EFshqdGKcOex9SxHvftPPXygU9a7IK/CYyQXagfkQ90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fy+HvtAQpnRByztDX/Q9J4HZx8YKjfMcSIGpB0TCEeW7M3y/f7IT44pNbdgEXijsiBp2lgmpqcohXjpqPGVT7od0zQgoByVwMNsQTKm9eAwmJKOopfotyx8QRYMMRph5sziKBYSdgl7/87qd5Eqc1GsXCp/Tt0/CrG7vLdDViCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka001qVo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EAE1F00A3D;
	Sat, 23 May 2026 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495402;
	bh=3/wEjF0yxmdtxvE+uU3bNB7OOPS2eK8Sj/XrckH6+H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ka001qVoWj0iS+KKX1zBaPg7yVv9x9wsmHzt9+5IsltCUt85T9nv234/lZldz1MQe
	 3c9q3PgM8meOW1g7S1JH0LTnBx7rvXsBhRfNrVhmW8Mv2LpjiGDRf4Rp98fHd174a3
	 zn2LfvfIIoadSll3vBC1y2wHD5vzB9Kazlf1pG4kJlNOurTEU3bE2xcmkac5CwSaui
	 CP8rTzQj+aMdfGXekYzC6AUHREd8KDMUXlLbjrn6C+5enj41SbSb62VKJE9rVpO1sA
	 hYVarAWErbPL7eBmZ/mUuiH2l2XYa0ehUPv1zA7bFp+3iPVpGJbdC8DODgP5vtai3H
	 fmzj86NqFIHzw==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	vinschen@redhat.com,
	alexander.nowlin@intel.com
Subject: Re: [PATCH net 7/8] i40e: set supported_extts_flags for rising edge
Date: Fri, 22 May 2026 17:16:41 -0700
Message-ID: <20260523001641.1758500-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520183501.3360810-8-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-8-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290974-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D22045BBD7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
i40e: set supported_extts_flags for rising edge

The i40e driver always supported only rising edge detection, so
advertise PTP_RISING_EDGE, and PTP_STRICT_FLAGS to ensure the
PTP core properly validates user requests.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 7d07c389bb231..c4525bfab09c0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -1344,6 +1344,8 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
>  	pf->ptp_caps.n_ext_ts = 2;
>  	pf->ptp_caps.pps = 1;
>  	pf->ptp_caps.n_per_out = 2;
> +	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
> +					     PTP_STRICT_FLAGS;

[Severity: High]
This isn't a bug introduced by this patch, but does the PTP external timestamp
event in i40e_ptp_extts0_work() incorrectly assign the PCI Physical Function
(PF) ID to the event index instead of the PTP hardware channel index?

Looking at i40e_ptp_extts0_work():

drivers/net/ethernet/intel/i40e/i40e_ptp.c:i40e_ptp_extts0_work() {
	...
	event.type = PTP_CLOCK_EXTTS;
	event.index = hw->pf_id;

	/* fire event */
	ptp_clock_event(pf->ptp_clock, &event);
}

The PTP core API expects the index field to correspond to the requested EXTTS
channel index (which should be 0 here).

Userspace applications rely on this index to associate the received timestamp
event with the requested channel.

For interfaces where pf_id is greater than 0 (e.g., dual or quad port NICs),
this dispatches the event to userspace with the wrong channel index, causing
applications to ignore the timestamp or misbehave, completely breaking EXTTS
functionality for those ports.

>  
>  	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
>  					       pf->ptp_caps.n_pins);

