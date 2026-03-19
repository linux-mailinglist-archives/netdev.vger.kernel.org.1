Return-Path: <netdev+bounces-269584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOqELwM3vGnGvAIAu9opvQ
	(envelope-from <netdev+bounces-269584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:48:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A82D0459
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECA0E30166C3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF493F0745;
	Thu, 19 Mar 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR7OMMM5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344D343D60;
	Thu, 19 Mar 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942449; cv=none; b=oDDOl9TCOsZitKRLhkdVKIoEhIhv+jIkHQKeCk6bsHWWAoshhZj9Iff0NJlDbCaTcRRIK2oC7+P82w92WtFGN/j7PQurZc3hleBPhk6c7re/3bjmyelk1n6ZFKL/Z4m85BtvCOxq8zl2qhkTKseMk4KEnKKLLVnueVZIItZ/Yvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942449; c=relaxed/simple;
	bh=jBtwDxapS/ldGHne92uTwwnuYAOPprD19b/w5AV1sWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee57h7V3wQOsZaANFTnN5VRT1SWNeDG10Uezaem3g/XDnmPihvxIIIvdahpavqZa3jc0kW1hVumqjNOiBzyDq6VAMlRuTggNqxxHzmM/nJ8QrAyMmV6jk+zE87FHiXQe5/lglp0LIBXG1bGAzGb7/1cS/bmXfOxrjoia8HEceRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR7OMMM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFFFC19424;
	Thu, 19 Mar 2026 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773942448;
	bh=jBtwDxapS/ldGHne92uTwwnuYAOPprD19b/w5AV1sWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RR7OMMM55EO4v/3u8XxMB/voq0HEg9AE7/fUIenj8El977pXs1A7KNitHHxynljOe
	 ttl3LjHxps1dRIDbD5rJ5FuM6iaa8NAXWEn39KKyjiTMcXu7D01YFEDFTKwgmd2Ykt
	 BC0NsQhl7YpTL6Gw+CCQJg4khFdCofTWQV8CIL2DUg+JZ7ImP5uXZ9YqFRYLBaDuko
	 8bOByy4/rH/PT7Oz+JMpnd14JovY1+OyyZk5zvgriIrTM8stI7dtmKFL0+LE3hlx8j
	 2GdWUQnuRPeBAKWs1257cpsjjImQTKjS0vO/t0yVFkbg4BMC1B17EiGCVxk/rE4doP
	 jd3krTZHn2AoQ==
Date: Thu, 19 Mar 2026 17:47:24 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2] bonding: remove bonding_priv.h
Message-ID: <20260319174724.GP1753385@horms.kernel.org>
References: <20260318-bond_uts-v2-1-033fe0d4e903@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-bond_uts-v2-1-033fe0d4e903@debian.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269584-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 2F9A82D0459
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 05:22:48AM -0700, Breno Leitao wrote:
> bonding_priv.h only defined DRV_NAME and DRV_DESCRIPTION, but caused
> unnecessary recompilation: it included <generated/utsrelease.h> to
> define bond_version, which is used solely in bond_procfs.c. With
> CONFIG_LOCALVERSION_AUTO=y, utsrelease.h is regenerated on every git
> commit, so any git operation triggered recompilation of bond_main.c
> which also included bonding_priv.h.
> 
> Remove the header entirely, as suggested by Jakub, given the macros on
> this file can be integrated into the C files directly.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Remove drivers/net/bonding/bonding_priv.h completly (Jakub)
> - Link to v1: https://patch.msgid.link/20260316-bond_uts-v1-1-428696ea79d5@debian.org

Reviewed-by: Simon Horman <horms@kernel.org>


