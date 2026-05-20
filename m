Return-Path: <netdev+bounces-290135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKIzGG5HDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:44:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308559CE18
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3695C302A672
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC43CE48E;
	Wed, 20 May 2026 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn9BhmOm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB63C4545;
	Wed, 20 May 2026 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320676; cv=none; b=smgLQxZ9WXhLP54rLZenrIPfvseqVYS3HgQg6IPccHDtHGnHDUieNlgnv7DYGS9YrA0v6fvjvEbNxFgeePKN1E2AYLbKrRIXvbUAjd5YiOkIcIpGQXT2yF5WheDjZIksEBjGIpjGKCOM6n4f+84l2NfFQAZYIsXTv1N6BFEsBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320676; c=relaxed/simple;
	bh=EKSjvafpnttCExXk3XPWFaFdxfiX8mcA8XBb/AN0ptg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlQX2TF7SRe3G922QhE4OdYRjhcbh7R/xiW54tE4CdKxWA/7WoKq3eEWpvEYnUfXMptgSI3nwZ3u1pcdiMCsb0C0LcBLPQUEi44oJ6rqi3gNz4Robpy0h0gqk/a588kv28g6QS9XeHQvEYe/TKdp3T3bsS2mfKUyiyES4hWRciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn9BhmOm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3521F000E9;
	Wed, 20 May 2026 23:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320672;
	bh=8eh8kfoTChhuW8TFXUq8NY1zVm9yQEPbKToE5hIRcMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bn9BhmOmfUURWFQYH+TObvOssSRG865/ciYM8RTRC/DvTgOzBX2M3BK297/WnLgdd
	 05Ni2QMde85P14Z6IwXnUtE66TIS+IYzZj2RFKuzj+0NriX4R+uG6hZEgLkaBY1MDR
	 Ue4KswvwMdXcjVersGrnXYp6Mnlp+TFGPCZwTw/39GNXw+/c9rbvmWTFbiCJeWlat/
	 /esNFy/sxTGEVHpsdbeytCsK3P7FhKPeChUwnLkY5I+GzH5y3n+sAueBrezaRpOcYJ
	 bL12EgaM2T+enWnsqzMPpdReEmhS9vdTMpjJ14BHRLHhFHby4xnKD0F45QQc+l1nxh
	 VqtXjvWh+IoRA==
From: Jakub Kicinski <kuba@kernel.org>
To: nikhil.rao@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eric.joyner@amd.com,
	Vamsi.Atluri@amd.com
Subject: Re: [PATCH net-next v2 2/6] pds_core: add support for identity version 2
Date: Wed, 20 May 2026 16:44:25 -0700
Message-ID: <20260520234425.567020-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516-upstream_v2_clean-v2-2-7e0d66bf4020@amd.com>
References: <20260516-upstream_v2_clean-v2-2-7e0d66bf4020@amd.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290135-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4308559CE18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
pds_core: add support for identity version 2

This patch adds a new capabilities field to struct pds_core_dev_identity
and bumps the identify command version to PDS_CORE_IDENTITY_VERSION_2,
falling back to version 1 when version 2 negotiation fails.

> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
> index 5b86d6cd0ac3..c9abea9b2eb1 100644
> --- a/drivers/net/ethernet/amd/pds_core/dev.c
> +++ b/drivers/net/ethernet/amd/pds_core/dev.c

[ ... ]

> @@ -327,6 +334,21 @@ static int pdsc_identify(struct pdsc *pdsc)
>  	return 0;
>  }
>
> +static int pdsc_identify(struct pdsc *pdsc)
> +{
> +	int err;
> +
> +	/* Older firmware rejects anything but PDS_CORE_IDENTIFY_VERSION_1
> +	 * instead of returning the max supported identify version, so retry if
> +	 * firmware doesn't support PDS_CORE_IDENTIFY_VERSION_2
> +	 */

[Low]
The macro names referenced in this comment are PDS_CORE_IDENTIFY_VERSION_1
and PDS_CORE_IDENTIFY_VERSION_2, but the macros defined by this patch in
include/linux/pds/pds_core_if.h are spelled PDS_CORE_IDENTITY_VERSION_1 and
PDS_CORE_IDENTITY_VERSION_2 (IDENTITY, not IDENTIFY).

Should the comment use the actual macro names so that grep finds them?

> +	err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_2);
> +	if (err)
> +		err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_1);
> +
> +	return err;
> +}
> +
-- 
pw-bot: cr

