Return-Path: <netdev+bounces-254546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJpXBPHeemmf/AEAu9opvQ
	(envelope-from <netdev+bounces-254546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:15:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F09DABA3C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FA83302837F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11C12D193F;
	Thu, 29 Jan 2026 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPm6YNwr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5602C21FC;
	Thu, 29 Jan 2026 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660103; cv=none; b=gEuSCb5aikTd6xamF5fFsxa96C06OO8lXugySTSKaKwaLLPE2s4pQf36DyHVXmvMe+QnfSseQGX/7bZw84jUo4CqLkNrzzSa32FnNzrgtx5FkgivAAjsJJJh68axCZ0bLKVTwZYALyvv9eqFVrmZV3R6wam0uCW1PBEevqRCKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660103; c=relaxed/simple;
	bh=tklfjJ2fsw6uvBg8OT9edwP9ZXz8vD7PiMJOH17oFwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWvip+BoPX/AhPAZ9oEvRFvwmundxKaAo1tcg/VkXvPXtNKrDWfC/f8xiajI2fyCyyOytkQV0IBE4YZ81jH0pTJTQi7nFBzWh7l3BqT6WI3kaWLs5ilCqsh2IqhP0MHHmAOHBC5e4DW94ms/odFL8kPm5CtbFbSKvjqXciTS2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPm6YNwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B6DC116D0;
	Thu, 29 Jan 2026 04:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769660103;
	bh=tklfjJ2fsw6uvBg8OT9edwP9ZXz8vD7PiMJOH17oFwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FPm6YNwrhyVu4qvkXirQXEIjo23t4WhbcqQV1KUXzGn6TGgUkAT2pELakGRoof5QI
	 TB9oRDx5QD6a0092M6LsaNZHqBXxM0maNTE3ovPyVmjBbbnKfN3ofla1xypfzB71/I
	 OpEHsTIhrpdAPwe+gzENCIRjbDKk6qccCUjoVULX0g3E9iG27p7Qak+OYEjjeJ0bX6
	 1vpcBYZWarnJ6J1R7ihYTVC8zfnMyf78KGNcpo+qHS0nGNFFbbMUOw7JVxZIwO52en
	 fel99emUpyGtmIntjGwZBqXbQNXqU6o86qwrHq4X+5Vha3CAxORvmtc0mRugABIY3i
	 qL9RnljkS4jjQ==
Date: Wed, 28 Jan 2026 20:15:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, xiaolei.wang@windriver.com
Cc: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maxime.chevallier@bootlin.com,
 quic_abchauha@quicinc.com, quic_sarohasa@quicinc.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Message-ID: <20260128201501.04bb6e5c@kernel.org>
In-Reply-To: <20260126104409.1070403-1-wei.fang@nxp.com>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254546-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,broadcom.com,windriver.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F09DABA3C
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 18:44:09 +0800 Wei Fang wrote:
> The commit bc66fa87d4fd ("net: phy: Add link between phy dev and mac
> dev") has created a device link between the MAC and the PHY if the MAC
> uses a shared MDIO bus (The MDIO and the MAC are two separate devices).
> Sarosh Hasan tried to change the DL_FLAG_STATELESS flag to
> DL_FLAG_AUTOREMOVE_SUPPLIER to fix the issue [1]. However, the solution
> does not take into account the hot-swappable PHY devices (such as SFP).
> so when the PHY device is unplugged, the MAC driver will automatically
> be removed, which is not the expected behavior.
> 
> Therefore, to solve this issue of the shared MDIO bus, we create the
> device link between the MAC device and the MDIO device, rather than
> between the MAC device and the PHY device. And when the shared MDIO bus
> is removed, all MAC drivers that depend on it will also be removed.

Anyone willing to venture a review tag?

