Return-Path: <netdev+bounces-283046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAEyO2H882m29QEAu9opvQ
	(envelope-from <netdev+bounces-283046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:05:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC74A9745
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62C4C3012277
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA3284693;
	Fri,  1 May 2026 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLRUBNWY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A031EDA0F;
	Fri,  1 May 2026 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597523; cv=none; b=jbLxryGuTEEyYGU2X2sXfxmqd8UAGnW5J6Pznow+NEkesQINKm5zMvmc1mTY8V+gjeH4V2hhRDz96nkvXbRQsMyx6RPOauwbO9gZai0PHFoRkvbZkyWC/ev66VfOfLDple4e5ucCvitKxb2nv+m2Uq+rJ4YOQ9OocAlSi8xTvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597523; c=relaxed/simple;
	bh=b8pav57Em2e0X9Ta0t21MWc81dYGYOc3cbq4TjKjGuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoiecAQnXyyaiyWDJtIfzvhnpgrXcAkKhEVDPbEjNEb/33NXByj/DCRV0bkVdHOuo9MMtEfNRgyeN1GslwqMhQu2kSq5yR4yUV6SuNl37dM4IOmyRg/LeQ6XnZjnBuQbPkT/70Ou3EN8CSRr+qHe9vdlLLDzdNu9gkejsYO40R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLRUBNWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD87C2BCB3;
	Fri,  1 May 2026 01:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777597522;
	bh=b8pav57Em2e0X9Ta0t21MWc81dYGYOc3cbq4TjKjGuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XLRUBNWY7Qezpiib3lX+QNnGdAkBOzSXs44jfSP+l9gDv4p48C+Cy4EUT/+b0Bxma
	 48LlTnywqcB9wYwfDpxbLdnGUhRZonUsnW1wu+tLBLy0s2ezlZaa0uGzhSRI+xep6P
	 bTtomv18F3j8KpAVoAZxKQ1bBYvJuk6wogTf/j9uHqKEvQWmF1QXH27S5s4A2JKz1F
	 RBH5bDSXtcd5BTVk5GnDtJFEGZaOabVOgpjLSGIYp8AfjoplKLwEnkA6n+gXE8MB/r
	 mt3hcVzMXaG6UxUg0uANEPu9xGwzC9a0X2P1YCknXJA0F2TwHJbt1XbknsjEHxuKm0
	 Nj+ZFix1vOmig==
Date: Thu, 30 Apr 2026 18:05:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, <eric.joyner@amd.com>
Subject: Re: [PATCH net-next 3/6] pds_core: add PLDM firmware update support
 via devlink flash
Message-ID: <20260430180521.6457e61f@kernel.org>
In-Reply-To: <20260429-b4-pldm-b4-v1-3-394fafba526f@amd.com>
References: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
	<20260429-b4-pldm-b4-v1-3-394fafba526f@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 51CC74A9745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283046-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 08:28:19 +0000 Nikhil P. Rao wrote:
> +#define PDS_CORE_FW_COMPONENT_LIST_LEN	((PDS_PAGE_SIZE - \
> +		sizeof(struct pds_core_component_list_info)) / \
> +		sizeof(struct pds_core_fw_component_info))
> +
> +#if defined(__has_attribute) && !__has_attribute(__counted_by__)
> +#define __counted_by(member)
> +#endif

Please don't redefined kernel-level primitives.
It's a huge pain in the rear to deal with when indexing the code.

This patch also adds a bunch of kdoc warnings.

Last but not least Sashiko points out a number of bugs

