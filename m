Return-Path: <netdev+bounces-284583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL1YJ3Jg+mm3OAMAu9opvQ
	(envelope-from <netdev+bounces-284583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 23:26:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 124AA4D3E38
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 23:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81BB302ED49
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 21:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CBD48C3F9;
	Tue,  5 May 2026 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uDSBtltR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD9248BD49;
	Tue,  5 May 2026 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016361; cv=none; b=WyqR4SEPu9UEd4DUlHrOSjhDJVGOr+an1pivGRSDqUV6t6xQss5mv19DsrLz6zU100bLros68Q4aTkp1B1fEADUWaXC4nAQjeYurMA+BwTtCGLTRmg4Oh9oUHgRyiQhOuhSiW1DapiiuF54G1aNOrTy0eVz3HZNjTGVjp2Fthro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016361; c=relaxed/simple;
	bh=xZnw39K/DeQf2sm1hoSQLMbfqfeFzMjBH3G9OXw8fqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CP+XyqJOW4hYa9j6AvHMHHORa+x0lYv6EqaZAY9DE0NcSrPtX2ARRZm035/XZT5UxTpuySHmQh6Bh4uLKibQt6E55Z0uYY2Q1Lz76wSyTN7fl5JmRTxIM8JaMuVvqIEnkM56Nj3Qa2Kf7cmGly4VKtM6xyGxMUCWmQKa8/hjcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uDSBtltR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=B6ObEsvrwmrpQxTdDdXD3hOMgpbD3e7Bhld15+j07/E=; b=uD
	SBtltRLTP6fDU4pXeIDHTD0IeNoAjMrZQO0avYldgd07zFR0VEEdUlEtaM7PojFqnjNlXIvraQKIa
	u9NZ1ERQ1OIqt039o08TebuESvgp7jNlx8FfEuKBCjqvGASnYKtgj51w3+MPOhKEFXKkLaAprYLHz
	J/pepskGSEcdD80=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKNH3-001XQ8-DO; Tue, 05 May 2026 23:25:49 +0200
Date: Tue, 5 May 2026 23:25:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	Rob Herring <robh@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Message-ID: <8fb3a66e-28cf-4db7-a0eb-308f477d3945@lunn.ch>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260505134434.GA2493310-robh@kernel.org>
 <CY8PR02MB924915930E62AE03DF05C2DC833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <7fad56ee-88c8-4e0a-8411-eeb5c0ab4a38@lunn.ch>
 <DM8PR02MB8021DB41F30E52D3DED9E7329D3E2@DM8PR02MB8021.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR02MB8021DB41F30E52D3DED9E7329D3E2@DM8PR02MB8021.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 124AA4D3E38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284583-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]

> As far as I’m concerned, we can remove the 15 MHz lower limit, but I would
> leave some note somewhere if possible.

A comment in the device tree binding next to the maximum speed
requirement would make sense.

	Andrew

