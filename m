Return-Path: <netdev+bounces-274314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF0kEnnMzWnihQYAu9opvQ
	(envelope-from <netdev+bounces-274314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:55:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E2038262F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A244F3007AFA
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23DE2D7DD7;
	Thu,  2 Apr 2026 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1swSbX7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF61DED4C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775094514; cv=none; b=YJeThnVC/jBQHmSg9XNdJ7TK3F9koV49b+nz1m/c/c7BU1xmpEjZKl0rPdo3JMeie1Sm8UXaIJ5eRJRfY+P58+3PqU6wSXTWioD6KgfyoO15zdU26tE0na5oqaSlJewkx9xkdK/tPWMKtPTLRPIlUXsUSa8jZLdck+dWrwrlcxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775094514; c=relaxed/simple;
	bh=DoHovpe7PPxNQ4PNeKSK+bj8/w+Ykj6PSzvnnxzjxt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwD2PXEcUx4/gc+RMhHIEa3GytgdC3WcupsH48csZyrW7y99PvJbZz9YhIWk+b6t5S26CdX25YRLtGXFKNHhTWU3S+LFnGj8VA0QfuAeYzbMAWDkJMMZe8nY78Ubx/GhmRgj8VyozGFzoZRiwB3phqlf9BJQ2TXsR+xYZWvhHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1swSbX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D634DC4CEF7;
	Thu,  2 Apr 2026 01:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775094514;
	bh=DoHovpe7PPxNQ4PNeKSK+bj8/w+Ykj6PSzvnnxzjxt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O1swSbX7/HUSJkqAEa8voB9xv+R7X7sY1KJnT2kHb+P1jgmEAVsCTlrmisbROY8u+
	 HvuE1w/9TArkdyiD3ccrQFaNMXqYKCmPOpE7VNN8CMTWo94J/Xee5QvhRukV2A51Re
	 PWH0ZGz8bYefVBQC7xDoEX8sRRd79LDIV0BnIqSL/6SJmk7IViD9zB5yAWiQIAyaWN
	 dHwHMUKKOW0by3ONQLm0uL3s3H9ZBuDMoiUzwoOkWI/FnEYGEEUTim9S9kwqIgoO1U
	 eB9vSEalgqu+QnKa6usRaHFarGvMsBzT1FsPSDR2Xg0C2ZYPOXXrcRnCqApj/LOrdQ
	 REpZ58CbmzZuA==
Date: Wed, 1 Apr 2026 18:48:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v3 0/2] net: phy: microchip: add downshift
 support for LAN88xx
Message-ID: <20260401184833.024cdb7f@kernel.org>
In-Reply-To: <20260401123848.696766-1-nb@tipi-net.de>
References: <20260329224202.500229-1-nb@tipi-net.de>
	<20260401123848.696766-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274314-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1E2038262F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  1 Apr 2026 14:38:43 +0200 Nicolai Buchwitz wrote:
> Add standard ETHTOOL_PHY_DOWNSHIFT tunable support for the Microchip
> LAN88xx PHY, following the same pattern used by Marvell and other PHY
> drivers.

Please do not post patches in reply to a previous posting.
Add a lore link to the previous posting in the changelog.

You're submitting quite a lot of patches, it'd be great if
you could give our docs a read before sending more :/
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

