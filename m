Return-Path: <netdev+bounces-278371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D7UKzYL3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:39:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42D93F80C8
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DABFD3011529
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629293C4569;
	Tue, 14 Apr 2026 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTdHq9mb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34A395256
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159536; cv=none; b=Ej+mxWTGS0A1fM26ERjGxd7MGT0tl2X49swPLq9A4vaCXYiym/8WPF+0eYh0k7tyMNxNQr5JJbzZtO/xJmiR40Te/noNHI3kEbgnGBjFUUcpCvTM7+P136kZRNBp7BACqSntCBIZd6SPLFHcT8ojJiuHgwoxSlNTMExSDLox0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159536; c=relaxed/simple;
	bh=V0Twrt94RMQHR87PARXsvnrB4lobZx+97fuAAeeHGfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+OuBEAP36u/ijjzoNO8F1t4sNvyQm3RaBtUpoRo4xj+BvVqXsZz9h/tCVp6s1pV0i7k4Mgbb4VCNr98I3kaZhsrmjMgDV9lWlb3BNRgEPJzxT0tTHtwE4Ez0amZXTjmjfLp9MrpfbeiAMhbqSuLfGkxYfyFbEaJXNCNGhz90/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTdHq9mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A32C2BCB4;
	Tue, 14 Apr 2026 09:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159535;
	bh=V0Twrt94RMQHR87PARXsvnrB4lobZx+97fuAAeeHGfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTdHq9mbrBoCjTJQZ7S5TZYU/IpPVc6NmfIQcdb2pGBVtfNAeBxJUq3ee44Q2JUaY
	 tXrQS7kEa+DLy4KJ94kICM2Kf5WBqDVJdd9EF2js/0iqld7WrStkcuhOYrpdKFS+k6
	 pfNf+tvAsS9CMMFR+ilvENDVwFx8Z+ERLlXpqb1UF4ZQVXynmQj/b/oXJDYaxgxWoM
	 V24+no4uU0uTmuTMq3yXeHUVHz27zFy2m8vabdYusciJMXYaaTqS4mK+BtOvGXnRa5
	 LeMp1J14LbYTZ04i+uZTAMPa7L6bfNSh0JnKTO5gI4wJQbRAF785U/zgMAYGBgZKvk
	 kWa5cRbllyzmA==
Date: Tue, 14 Apr 2026 10:38:52 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 8/10] ice: move ice_phy_get_speed_eth56g() from
 ice_ptp_hw.c to ice_common.c
Message-ID: <20260414093852.GA469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-9-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-9-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278371-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: A42D93F80C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 09:49:19AM +0200, Aleksandr Loktionov wrote:
> ice_phy_get_speed_eth56g() is currently a file-local (static)
> helper in ice_ptp_hw.c. Future users outside that compilation
> unit require access to it.

FWIIW, I think it would be slightly better if this patch was accompanied by
such a user.

> 
> Move the function to ice_common.c, add a declaration in
> ice_common.h, and relocate the enum ice_eth56g_link_spd from
> ice_ptp_hw.h to ice_type.h so it is visible to callers of the
> new exported function.
> 
> Suggested-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


