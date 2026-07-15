Return-Path: <netdev+bounces-307744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U9WzExN+V2rXSwAAu9opvQ
	(envelope-from <netdev+bounces-307744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:33:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7097B75E2CF
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:33:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ibWP1me+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307744-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307744-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555DE3041BBC
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDC644C67C;
	Wed, 15 Jul 2026 12:29:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA675424D41
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:29:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118557; cv=none; b=MYihab8PH/Kvo1qAw3FiFrPXv6kHqkYm7O5Af35tCdA+NqOaduW3qy9agFipT5CklplR6IDYSgTJUwL1i5QlvBN9lQyavok5nj18BEOlwgY5Lk2uDUEXfcoHL+M7iXYpz6xlhJABk7H7NKtAd4dYOlGeqrB8BnOPZ2yxnT+4ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118557; c=relaxed/simple;
	bh=AVCeO1AiRmislj+12l/4ZjCvshaxkwNvXHhjCpyQtEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMaJoFyY9+hzdD0QGLiFH9DGxCSUEmmzWYgBZJIGvIQZBItnOpp07uHVbjgkt4K8/kSJI66dS8RxHRVEOQyhfPtVHwI+cMSJvS6FKpuFqSYVf6+db+9njsIgeaRhW+uZMgas5v7lwuF1OG67vtbmbgbIPRdMa6oHelEgjGDNVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibWP1me+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DAD1F000E9;
	Wed, 15 Jul 2026 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784118556;
	bh=vCwQnp8htPs9Eh/MP3qfpJZkYwRAjQYwif3i4a2+SwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ibWP1me+C9M2e4B3J9HI6qQ9QDBKE7obHJnMhklhtLq72Ybk1GX2dMAkKHnTV/kyS
	 Zql0VyMkW1z9lIrcUmfWXZOJwU6G4dbEC1icKFEseTjUuiTNbxTKVEs9VKB5B8TzTM
	 DRRvws0FniLRxa1ei0fHlgkUALm7H6DFlhX7WAynb09XbzRschrKbUXD09fR9aW9eo
	 0yX5DQxrde8Vq1F72MH7goOubyyWPIBiTRB6VDU3RNRI6AjsQ3Lz8lsKSPglC+o8va
	 UfHQFV6VoM7NemgeICebjEfJYxqImB4BuDshnQ7qIPWjQjGyPjKrKlueNT7HVEyy5j
	 G9qlIuT/wmEyg==
Date: Wed, 15 Jul 2026 13:29:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, pmenzel@molgen.mpg.de,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v3] ixgbe: E610: force phy link to get down when
 interface is down
Message-ID: <20260715122912.GA1922694@horms.kernel.org>
References: <20260708100609.331976-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708100609.331976-1-jedrzej.jagielski@intel.com>
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:pmenzel@molgen.mpg.de,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307744-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7097B75E2CF
X-Rspamd-Action: no action

On Wed, Jul 08, 2026 at 12:06:09PM +0200, Jedrzej Jagielski wrote:
> For the E610 family, similarly to the E8xx adapters, the default behavior
> is for the PHY link to remain up even when the corresponding OS interface
> is down.
> 
> Add function setting down the PHY config IXGBE_ACI_PHY_ENA_LINK bit
> what leads to disabling PHY link.
> 
> Now ixgbe_close() needs to share some of the ixgbe_watchdog_link_is_down
> code so move the common part into the separate function.
> 
> Align functionality with the implementation of the ice driver.
> 
> Let user to configure link-down-on-close enablement through ethtool.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: apply Paul's notes
> v3: use e_err

Reviewed-by: Simon Horman <horms@kernel.org>


