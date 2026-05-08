Return-Path: <netdev+bounces-286036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPkrDsdp/mmIqQAAu9opvQ
	(envelope-from <netdev+bounces-286036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:55:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BED4FC858
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFBC300E3B8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402C39D6DB;
	Fri,  8 May 2026 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgv6Q6Zx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370D3A4F51
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280854; cv=none; b=bWYQug0SNNnc93UgDrjT+8K5YunOohdYWBQL6j17WNLN1cZy4VTx64cGpP81kNsbFxBEcHAYWZ5cv3LhdNAe/WRZpnsh9tFrCWl1yFxrMW02NemAwA09zR/B2/lSn85reRwE5ID7nfOoJB/lfVKUouAKmjlcmelOlesmCch1EHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280854; c=relaxed/simple;
	bh=XJib6TBxDNIaKnuOW16rvYV0JwpYsbFVywMLOhoZMYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCAdHKKI1KhQ5tqzJYPY4u4PEgpLcHGr+Gk3j4MT9WQ6q+KJ6x1EKgW2ZeuZRi+wbfAazvsRuU9Rvse4wyyt7pLkVdhUoReMiu5mYa6jnTi8yQPytOAH0ABNq615LNdScrIDaaBlanrmoHlzqb1ghpKibVEmnqpw2YLvgcUqMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgv6Q6Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E82C2BCB0;
	Fri,  8 May 2026 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280854;
	bh=XJib6TBxDNIaKnuOW16rvYV0JwpYsbFVywMLOhoZMYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kgv6Q6ZxJ8qhWdl266dw6OuPg/h+QKsAEor4v3/iHgnhDpU9ltjS9GIf55fO+uCti
	 DoEKQ2sTsJDPWRkz2GIGSxCA+9hto/AIslrBbf536F5jAtu/8y+RFv9eu7NAcC1HLA
	 /2IdzD+QtQVa5G/h97TJjqcITQBGKttWoWEu7d66vqm60ZlccVIxiWDo3X2GQCPCQe
	 n2V5+QWRKGZTfqFsCuPa2HvCdk6LMQS64Zm9zIuKyAsstP9Elbbu3FRy+Fta8xV3qq
	 9NcpQclHt9NKH/WvIEyHUKTAjrUa+jbPTyyfqzk95yB+CwjD08GtdCTaayw8w8J1mZ
	 Z5W8a/52g4YxQ==
Date: Fri, 8 May 2026 15:54:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 2/5] ionic: Get "link_down_count" ext link
 stat from firmware
Message-ID: <20260508155412.57b28bc9@kernel.org>
In-Reply-To: <20260506043526.64301-3-eric.joyner@amd.com>
References: <20260506043526.64301-1-eric.joyner@amd.com>
	<20260506043526.64301-3-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A8BED4FC858
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286036-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Action: no action

On Tue, 5 May 2026 21:35:22 -0700 Eric Joyner wrote:
> The number of times that link has gone down at the port level is tracked
> by the firmware and sent to the driver via regular DMA writes to an
> instance of struct ionic_port_status in the driver's memory.
> 
> This statistic was never reported in favor of a driver-derived stat, but
> doing it in the driver was never necessary since firmware had been
> reporting it the whole time. Since it would be more accurate and true to
> the description of the statistic to get this count at the PHY level,
> replace the driver-calculated statistic with the firmware one and remove
> the driver-calculated one entirely.

missing le16_to_cpu() ?

drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:120:41: warning: incorrect type in assignment (different base types)
drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:120:41:    expected unsigned long long [usertype] link_down_events
drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:120:41:    got restricted __le16 [usertype] link_down_count


