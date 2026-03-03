Return-Path: <netdev+bounces-263005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNPNLtlOpmlCNwAAu9opvQ
	(envelope-from <netdev+bounces-263005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:00:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C11E846F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EADD0303076E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FD11E230E;
	Tue,  3 Mar 2026 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KefNJvQU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B754774;
	Tue,  3 Mar 2026 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506837; cv=none; b=j0KgqHelRW+gYsvXd1k/Yp62ERvokD5DvnQ2nt47SN1rfhW6dpclYq5e8B10n7l4OhQTO6q2eTZhil7xwg7P0dI9DDttT7uCZbcXiejAwEvjJ/qzbtMmkn7t3AQa8mM1Sz0wH9Sln8aQOm9W7a8lsnmclHzUrkP7j4DQxhXmaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506837; c=relaxed/simple;
	bh=zPukW38N2MFw+LkvGEaYWXndDILva7h4ZIvuUPZI44U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kw4mR+/fsJ67mfXmuAESkPB2oXL6fjMuhjCctRJbNDj2z1FKQPJqzId4kBX43nianlW/Nph6k+GCIEBj1KRQ5SBhab+RDqF3UYf1Gg/2yx3x4Viw4ya8kGbjwUqqkSV1iFdHhUWiYXWCEh2HJFfb5E6hZaNDwWpoCpjdMnSZw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KefNJvQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E3DC19423;
	Tue,  3 Mar 2026 03:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772506836;
	bh=zPukW38N2MFw+LkvGEaYWXndDILva7h4ZIvuUPZI44U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KefNJvQUajaqtb8qeufHBCbt53fmBWNAqDMikxiceE9bIOemxsz85iKuKD/VU+G6C
	 8nyDID/qj33L2oESNvkXtb0r1teSX5o4cnAaTt7Orp0wjwfD+Qc2PThZUgIX0b4GR/
	 K2RJvk/kpmER+QcTPmDzwWXEWCszMYJBkMc4k2T08KSjEVBfH0FgTX8AKZURjQGST3
	 HkBID4MbgZVMobNEjIvgJ8FZj6E8Ej5F4PTBJBw9LNrWdwwewaFUATE41GFnCNfqvi
	 o34fKOsnP5V207O+7LCUrbvnY3YnP344/IKcWfuYDr1QZptX+bz2UBbIRPcTeCzmwS
	 wDUDNfo+Wsmxw==
From: Jakub Kicinski <kuba@kernel.org>
To: bhargava.marreddy@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	ajit.khaparde@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	linux-kernel@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	rajashekar.hudumula@broadcom.com,
	vikas.gupta@broadcom.com,
	pavan.chebbi@broadcom.com,
	rahul-rg.gupta@broadcom.com
Subject: Re: [net-next,v3,3/8] bng_en: add ethtool link settings, get_link, and nway_reset
Date: Mon,  2 Mar 2026 19:00:29 -0800
Message-ID: <20260303030029.1884718-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228072715.1632280-4-bhargava.marreddy@broadcom.com>
References: <20260228072715.1632280-4-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3C0C11E846F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-263005-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bng_en: add ethtool link settings, get_link, and nway_reset

This commit adds get/set_link_ksettings, get_link, and nway_reset support
to the bnge driver. It implements speed reporting across NRZ, PAM4, and
PAM4-112 signaling modes and enables lane count reporting.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
> index 83ee4749cc70..e9b83c0c64b6 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> index d96fe662bba0..c2b3511fc913 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c

[ ... ]

> @@ -458,3 +503,755 @@ void bnge_report_link(struct bnge_dev *bd)
>  		netdev_err(bd->netdev, "NIC Link is Down\n");
>  	}
>  }
> +
> +static const u16 bnge_nrz_speed_masks[] = {
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEED_MSK_100GB,
> +	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
> +};
> +
> +static const u16 bnge_pam4_speed_masks[] = {
> +	[BNGE_LINK_SPEED_50GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_50GB,
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_100GB,
> +	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_200GB,
> +	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
> +};
> +
> +static const u16 bnge_nrz_speeds2_masks[] = {
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB,
> +	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
> +};
> +
> +static const u16 bnge_pam4_speeds2_masks[] = {
> +	[BNGE_LINK_SPEED_50GB_IDX] = BNGE_LINK_SPEEDS2_MSK_50GB_PAM4,
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB_PAM4,
> +	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_SPEEDS2_MSK_200GB_PAM4,
> +	[BNGE_LINK_SPEED_400GB_IDX] = BNGE_LINK_SPEEDS2_MSK_400GB_PAM4,
> +	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
> +};
> +
> +static const u16 bnge_pam4_112_speeds2_masks[] = {
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_112,
> +	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_112,
> +	[BNGE_LINK_SPEED_400GB_IDX] = BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_112,
> +	[BNGE_LINK_SPEED_800GB_IDX] = BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_112,
> +};

The bnge_pam4_112_speeds2_masks array is missing the sentinel entry
that all other speed mask arrays have. Jakub Kicinski's AI review in v1
identified a potential out-of-bounds array access in this array.

The v2 changelog claims to have fixed this by 'adding the missing sentinel',
but only bnge_pam4_speeds2_masks[] was fixed. All other speed mask arrays
include '[__BNGE_LINK_SPEED_END - 1] = 0' to ensure any legal speed is a
valid index, but bnge_pam4_112_speeds2_masks[] still lacks this.

While the array currently has an entry at the highest accessed index
([5] = 800GB), the missing sentinel makes it inconsistent with the other
arrays and may cause issues if the loop or access patterns change.

Looking at bnge_set_ethtool_speeds():

drivers/net/ethernet/broadcom/bnge/bnge_link.c:bnge_set_ethtool_speeds() {
	for (i = 1; i < __BNGE_LINK_SPEED_END; i++) {
		for (m = 1; m < __BNGE_MEDIA_END; m++) {
			...
			bnge_update_speed(&delta_pam4_112, m == media,
					  adv_pam4_112, sp_pam4_112_msks[i],
					  et_mask,
					  bnge_link_modes[i][BNGE_SIG_MODE_PAM4_112][m]);
		}
	}
}

Should this array follow the same pattern as the other speed mask arrays?

Reference: https://lore.kernel.org/netdev/20260224001201.146384-2-kuba@kernel.org/

[ ... ]
-- 
pw-bot: cr

