Return-Path: <netdev+bounces-254522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Id/L77NemnU+gEAu9opvQ
	(envelope-from <netdev+bounces-254522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:02:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50430AB4C5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42C3301495B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86021357A47;
	Thu, 29 Jan 2026 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHVAFwn8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A91DDC2B;
	Thu, 29 Jan 2026 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769655736; cv=none; b=qiDMKlVNpfRpBFThryEi2jH2pFKf3LoYoyJTw+roundXkqaMNOORgEc455iHVtDYBjQrRTasqikuaUhmW5WlkoQQzwPe39uIx063mHpbawCesq/1sLaC1LUWJBZGdYGdrOJeQhLyjIkquWcPNPzUtnkkw7KCp1Z5PWQLOhqz1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769655736; c=relaxed/simple;
	bh=sZXzZUORgER1FQba0ZuJiqC3ZW7WCueOrEIcbXq6PvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPFgNXyFC8eseQqFVX3LQUek8nyqe+YKA/irddwyd+ppq2QKDqa88E/cYbcFqVkCGISDFnue9rp5Qoz/v1XHUmCOQnC5iqt7iv64gnTaFmkZu4rN4hGj4c4mceSGYNrVSxsCpq0uH27A+u7en1IVq3LjJS+Bf5GmmchhA2dZRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHVAFwn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC94C4CEF1;
	Thu, 29 Jan 2026 03:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769655736;
	bh=sZXzZUORgER1FQba0ZuJiqC3ZW7WCueOrEIcbXq6PvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KHVAFwn8JWTGLqSOicvCiyCuUAp0lKa54atCZ0qcvKPrdIaSpRUL3oER4UZth2oqM
	 sBkBxIQ19wS+YRcgrpkNMp6nqqdItIjwr6bZfRMptX0+fQNmQtY0tfq3+aV9ONZ8lS
	 T/WaIxL7/H+qxbb7YGp35YEXq8zGp8yIF8hRITHa1vS+3TipM1oMQ79ooMgTqb3TFN
	 FinVrW9SUE/0BeRJbAfKr4XJduo6YBfG/rT159LWtIUi2zOXiG3gKEWLXQ2345h8hv
	 N/uVqO+GLuGchAEzhBAwRHbGTIL0aLWR9x2VKjRKNw3rZYRGf4iha9+NKSY4kNWr7w
	 g8J+hgD21VJ3w==
Date: Wed, 28 Jan 2026 19:02:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: andrew@lunn.ch, krzk+dt@kernel.org, robh@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, hkallweit1@gmail.com
Subject: Re: [PATCH v3 1/4] dt-bindings: net: ethernet-phy: add property
 enet-phy-lane-order
Message-ID: <20260128190213.57f89092@kernel.org>
In-Reply-To: <20260125200259.2903271-1-dam.dejean@gmail.com>
References: <20260125200259.2903271-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254522-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 50430AB4C5
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 21:02:56 +0100 Damien Dejean wrote:
> Add property enet-phy-lane-order to the device tree bindings to define
> the lane order of the PHY. To simplify PCB design some manufacturers
> allow to wire the pairs in a reverse order, and change the order in
> software.
> 
> The property can be set to 0 to force the normal lane order (ABCD), or 1
> to force the reverse lane order (DCBA).

There are net/phy patches in here but the series does not apply 
to netdev/net-next/main. Please rebase and repost.
-- 
pw-bot: cr

