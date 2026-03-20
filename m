Return-Path: <netdev+bounces-269892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAR+DwsvvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:27:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0B2D987F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CB703013445
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A469839A064;
	Fri, 20 Mar 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hldu/2t6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9A3A7F59;
	Fri, 20 Mar 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006017; cv=none; b=QeEy1ytu+5a6UP6xgBzfPK/7smgTp53edPqK/ENg0lVuurrw5wrsw0o1vHS2KfdKnnorn18S2CMTCuY7mqp/QqjvfCeNr7AgV/8U2LXqYlD45l1BYQRvex0V0Vv7rl/Pf1n9EOksMAEzOWjDZ26TJACSnKeOiTE5sVFwoxgN/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006017; c=relaxed/simple;
	bh=dKHuThexIZh2EfJn752S8JnW9cnPIlvA2UWYcKs78OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqZPeuAGUU8frnPBEMxcAXKYMRd3ZpgnvGKyEl6elyeUgGEcfT4DTqU2dzvf681HJ6Lu5vfMNwKsKOvIQz+/2bdFgHGkJfYvOPTld9bqJppfoRRSMn7nkyP5j2Sbo6fZCG1UuTlImRhZ9Xh1g3mznFRk8l6PKZO2AXvXcNlgFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hldu/2t6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A305C2BCB2;
	Fri, 20 Mar 2026 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774006017;
	bh=dKHuThexIZh2EfJn752S8JnW9cnPIlvA2UWYcKs78OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hldu/2t6MG8S8vuTAfp8ByIxdeZxoRw1n7OSeLZMxAx1jXj2X0iIwydt8bFrusLzU
	 qGHsiugeJMBAiHFZav0LBJRLoggddtAZfOUX97zCeY/ra98teDmj1bVEYm+fl0P20R
	 KwWT2cWbWcL/ws3cMvXIdMqCZrefxRDKjHIW1CBj6hqJXobmD4Y/4j8pJwiDlBN9gG
	 tMoFNktkQxTT25xqlcIOTsSiRbPsnBVT9cCr9GSm3nefT6LBZWMIBc564H3Ckw99Jv
	 9/jV6B98TmOI2yuN4OY930+9PauJOU6iPGyBkXKEbV+LzeLIR/ho0Anz/Oau3yWlEa
	 DzwhwN95q18Aw==
From: Simon Horman <horms@kernel.org>
To: vikas.gupta@broadcom.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	bhargava.marreddy@broadcom.com,
	ajit.khaparde@broadcom.com,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	rajashekar.hudumula@broadcom.com
Subject: Re: [PATCH net-next v8 03/10] bng_en: add ethtool link settings, get_link, and nway_reset
Date: Fri, 20 Mar 2026 11:26:30 +0000
Message-ID: <20260320112630.2065132-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319055124.1350670-4-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-4-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-269892-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.967];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D0E0B2D987F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bng_en: add ethtool link settings, get_link, and nway_reset

Add get/set_link_ksettings, get_link, and nway_reset support. Report
supported, advertised, and link-partner speeds across NRZ, PAM4, and
PAM4-112 signaling modes. Enable lane count reporting.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
> index 83ee4749cc70..e9b83c0c64b6 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> index e5a7b48f6a3f..03beb5593069 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c

[ ... ]

> +int bnge_set_link_ksettings(struct net_device *dev,
> +			    const struct ethtool_link_ksettings *lk_ksettings)
> +{
> +	const struct ethtool_link_settings *base = &lk_ksettings->base;
> +	struct bnge_ethtool_link_info *elink_info;
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct bnge_link_info *link_info;
> +	struct bnge_dev *bd = bn->bd;
> +	bool set_pause = false;
> +	int rc = 0;
> +
> +	elink_info = &bn->eth_link_info;
> +	link_info = &bd->link_info;
> +
> +	if (!BNGE_PHY_CFG_ABLE(bd))
> +		return -EOPNOTSUPP;
> +
> +	if (base->autoneg == AUTONEG_ENABLE) {
> +		bnge_set_ethtool_speeds(bn,
> +					lk_ksettings->link_modes.advertising);
> +		elink_info->autoneg |= BNGE_AUTONEG_SPEED;
> +		if (!elink_info->advertising && !elink_info->advertising_pam4) {
> +			elink_info->advertising =
> +				link_info->support_auto_speeds;
> +			elink_info->advertising_pam4 =
> +				link_info->support_pam4_auto_speeds;
> +		}

When autoneg is enabled but no speeds are advertised, does this code
correctly handle SPEEDS2 devices?

On a SPEEDS2 device (bd->phy_flags & BNGE_PHY_FL_SPEEDS2), the fallback
populates elink_info->advertising with support_auto_speeds and
elink_info->advertising_pam4 with support_pam4_auto_speeds.

However, for SPEEDS2 devices, the firmware expects speed masks encoded in
the SPEEDS2 format (using support_auto_speeds2), not the legacy format
(using support_auto_speeds or support_pam4_auto_speeds).

Looking at how this value is used in bnge_hwrm_set_link_common() in patch v2
(c367afb6b104):

    if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
        req->auto_link_speeds2_mask = elink_info->advertising;
        ...
    } else {
        req->auto_link_speed_mask = elink_info->advertising;
        req->auto_pam4_link_speed_mask = elink_info->advertising_pam4;
    }

The firmware will receive legacy NRZ speed bits in auto_link_speeds2_mask,
which it will interpret as SPEEDS2-encoded bits, potentially negotiating the
wrong link speed.

Compare with bnge_support_speed_dropped() in the same patch series
(c367afb6b104), which handles this case differently when support speeds
change:

    if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
        link_info->advertising = link_info->support_auto_speeds2;
        ...
    } else {
        link_info->advertising = link_info->support_auto_speeds;
        link_info->advertising_pam4 = link_info->support_pam4_auto_speeds;
    }

Should bnge_set_link_ksettings() check bd->phy_flags & BNGE_PHY_FL_SPEEDS2 and
use support_auto_speeds2 for the fallback on SPEEDS2 devices?

> +		/* any change to autoneg will cause link change, therefore the
> +		 * driver should put back the original pause setting in autoneg
> +		 */
> +		if (!(bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
> +			set_pause = true;
> +	} else {

[ ... ]

