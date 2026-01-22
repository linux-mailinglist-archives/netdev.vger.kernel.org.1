Return-Path: <netdev+bounces-252195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC1WBsmjcWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:12:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC27061A1D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46116505C16
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB2428498;
	Thu, 22 Jan 2026 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYPqwtdU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755EE3D3315;
	Thu, 22 Jan 2026 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054886; cv=none; b=Ddlq58wuxXpn/FeYw+uaS2EamgNXWPQjXQYN1NfxYXAn9kAMgqO9CRMO2lxEUzNzmqcoAdOG58v74oRMvrpx99PQfGawvYBygwWl7aCFjYcWyaTQFVtPeubt4VDutNrS+F4EcU+nLbYDPKNXHpOxMEKX4bzPTvU8/FrAtRoM2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054886; c=relaxed/simple;
	bh=LE36d3K2cj+7soLlJGQ/xjkrrzO7MDPJoTe9cRZNWSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vExNWZalSy4pD3+27XYlAG8MtQKrW9rYddm+uTBDza5jJsAOqWhi34tyx7XYgOPrzKanRARHiICn4gYEVwd6rIpwedAKE5T7Cdbb3Hf7VZ92k3FgK3XDQvSWrk1h2vxCOpsxguqqrPLBeevTf3e28IW5xMBQf+wcPaG5accUQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYPqwtdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A972AC116C6;
	Thu, 22 Jan 2026 04:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769054884;
	bh=LE36d3K2cj+7soLlJGQ/xjkrrzO7MDPJoTe9cRZNWSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NYPqwtdUxOd7p3taS0GpjdA03lk2L5RA6lWkZThqU6gxOte5VSs8nPe5QpynZ6XQk
	 cJG0aoXU//osg6IfxPmheNnPuLZDFPV8TTl3OVVzRr+YXjV7YTpR6gxZ+JRAd1PAQw
	 mjbwA/TfV+cSlmDf0Af8kHf9D2enI39T8hefJlT4bs0apyfpJSxfKcxYB88pZM6n26
	 ge1UzLY3dFTBoWg6MMOYh9BP2G3Wae1t6OTQkS/1vSDBl2CTCVi1Rp92cYTIJPoJd+
	 WPAHDGpmddJxZPXvi2cwpS+P1LcIEXiBuSu4FOGKC39LDrOFf5a3X6ycBQspy0wfmE
	 oNyKMvetRsFCg==
Date: Wed, 21 Jan 2026 20:08:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Minqiang
 <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: Re: [PATCH net-next v5 0/6] net: dsa: lantiq: add support for Intel
 GSW150
Message-ID: <20260121200802.75753b25@kernel.org>
In-Reply-To: <cover.1768704116.git.daniel@makrotopia.org>
References: <cover.1768704116.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org,gl-inet.com];
	TAGGED_FROM(0.00)[bounces-252195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: AC27061A1D
X-Rspamd-Action: no action

On Sun, 18 Jan 2026 03:21:01 +0000 Daniel Golle wrote:
> The Intel GSW150 Ethernet Switch (aka. Lantiq PEB7084) is the predecessor of
> MaxLinear's GSW1xx series of switches. It shares most features, but has a
> slightly different port layout and different MII interfaces.
> Adding support for this switch to the mxl-gsw1xx driver is quite trivial.

Doesn't apply cleanly (any more?) Looks like patchwork consumed it
correctly but the CI balked :( pls respin
-- 
pw-bot: cr

