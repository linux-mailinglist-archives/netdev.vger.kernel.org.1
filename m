Return-Path: <netdev+bounces-301701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AYI0MNz6O2pXhQgAu9opvQ
	(envelope-from <netdev+bounces-301701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:42:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64B6BFBD1
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:42:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=w9F4ID5o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301701-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301701-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B67B301C901
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627813CF05E;
	Wed, 24 Jun 2026 15:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48C27587D;
	Wed, 24 Jun 2026 15:42:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315738; cv=none; b=UgyiApsZ+WxPlvLZzc0KRjWqGrNAR1UYnkV5PKsANRh2kKKrxmmUIDrBgu3Ijk+vUmCL90RM1tnIYK34Zcx2ZM8v8E/5SP16lmcFzIpNAOA5dFTLS1YfPZFbwfYPAGakV4nRi7H1MWFJdc4Jzp/rkBfHJFJpN1gVD9EV4De4I3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315738; c=relaxed/simple;
	bh=kN2I3dJmoVQZjR3TJQ6W+Nar4GAWVqOl0ck9Gy/7Sn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BognCABlgWUlLAUOijV58U+ztMvLKB1CTJRnoMLk8O/56CJHkkTADjiUewxLO1j81pLlj1x6i64Nby3cxu62SkPhsenz+8CsIPNTW6nPRSQ8Ve1tb0IefV/V6bcPuQ2k2zFyTER3uagoqOBPctlRR3NZvJGnlglbZgxx8Gt+rac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w9F4ID5o; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xPpByjy7W5L7XpVcP76WXAwInbwRDBlAjul1A4H6MFE=; b=w9F4ID5ojrpJx1Mc3AY1BPTJS0
	Y5BQyHlaR0t1aG7fVvGNnP1lQ45Mw+Pjq4pqi2GQg0gr+VtY9lkQe3rrNDymgupHQWD1MTmLVLTNZ
	s9aMhTef0+LCMRs+rh1lSAw+ELiw2UoO87AomQx71ltMD20iNUrwlcSSVh986rFQeNSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcPjq-0096u7-99; Wed, 24 Jun 2026 17:42:06 +0200
Date: Wed, 24 Jun 2026 17:42:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 6/7] ARM: dts: rockchip: Add RV1126 I2C5
Message-ID: <1d1d3618-b73f-4c38-a817-b7d053687497@lunn.ch>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
 <20260624-rv1126-alientek-dlrv1126-v1-6-5aef608a3f64@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-6-5aef608a3f64@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301701-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:grumpycat921013@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E64B6BFBD1

On Wed, Jun 24, 2026 at 04:44:43PM +0800, Yanan He wrote:
> The controller is present in the SoC and can be used by boards for
> external peripherals, such as an RTC on the Alientek DLRV1126 carrier
> board.

This has nothing to do with networking, so please post it separately.

What i would actually like to see is the patch adding networking
nodes, because my guess is, you have the RGMII delays wrong.

       Andrew

