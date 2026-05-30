Return-Path: <netdev+bounces-293325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HbfMxW9Gmqq7wgAu9opvQ
	(envelope-from <netdev+bounces-293325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:33:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43460C232
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2BB6302EE9B
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823ED374722;
	Sat, 30 May 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/FthUzN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A422340410;
	Sat, 30 May 2026 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137229; cv=none; b=ukgb9xax9dmyImjQACO9FcSNLIw+snnlFuJiVYFmIfd5kBTPSPgd7MBTLEVoKmPJndwbgbRLG1pixGl+xGS4I0mzXRhqLk72wUtsQxjG9fHO+c9sJ3aoUKhXkKCQeWYe/OHmlvMIvIMpylrudwjJwgXMuFbabDWM7MPSIlDNBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137229; c=relaxed/simple;
	bh=Sz9UDZGoH533C6exdEntmlcgPhaugluaUFoAmDbYsQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZeQEGqCNQj2G5FUp3Gblc0Ub+RqrD3YLKj0WTYfOntSH5B0kJuXez2ZTHIUDHZTXPaAaRolGTMbxD5dlh2PnLRQs+Ci4wZDO5CC+l7h0CVFLFDijDxIQYcWHZndjEVkhLeiWUJX3RRtWFs/jMmUBWjkDMV0hZcrLRZac8GRwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/FthUzN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4031F00893;
	Sat, 30 May 2026 10:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780137228;
	bh=7cTF2sNwkWL1PB8RSdj92RnKGIQ4B3IX37CljurqPzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/FthUzNx+risgYRmeJfX0xQ9/dKsxAkoqryiTKMcECrl8hjJDvTXdmY8nF44k9XH
	 0XqWtLg5671Wpl5xtHeduek0GwSTZqbJW4DUvv7Evz2BsTdADFXz6wPDnK944+G82/
	 lISesLZYS+6TVBOXKQvziPKkih6pLUipao5NqA0UsdZrV2Ww8eEqyK+oyCpuxdAPds
	 zsDwXIEt4lSgs8ikL/K1YHlq5VSr/oVtO/tqGWqT1iTBEWrj/a135iVFl9XLYJfkHg
	 4FmoeTKKxzQII6kwed1Wi+JTupa8m1YMXjXEFz/87N9pnZTWLFZlWvMjqfpqu7B3GB
	 OotAnfbWCGMhA==
Date: Sat, 30 May 2026 12:33:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Message-ID: <20260530-brainy-azure-swallow-9c8e1f@quoll>
References: <CY8PR02MB92497E67D5AB4C72E7A4C12683162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92497E67D5AB4C72E7A4C12683162@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293325-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A43460C232
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 08:04:55PM +0000, Selvamani Rajagopal wrote:
> According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
> specification, interrupt type is active low, level triggered interrupt.
> 
> Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY")
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I downloaded entire thread and see no patch #1, no cover letter, no
changelog here. Where is the rest?

Best regards,
Krzysztof


