Return-Path: <netdev+bounces-299023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0P4HN16qLWrXiQQAu9opvQ
	(envelope-from <netdev+bounces-299023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A4967F663
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j8DvUjUl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299023-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299023-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D55E0300A7F3
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092131E9906;
	Sat, 13 Jun 2026 19:07:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E883B67E;
	Sat, 13 Jun 2026 19:07:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377627; cv=none; b=dSCx/srJ2SAmr9ggqmD1SsqxmvZTu9eUVdXrQwRR36TxcJ5Nt6oc1WcKX++8cRatSs/Z9triRILrGKnjmBqZLrDy6xTeU8b8mwTiRqOMZWnQT9vupYD8fHciU1prEJsY8/IbU78FWIyiUcnOnRRIEqGZYfieOZjWO/Q/6tusZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377627; c=relaxed/simple;
	bh=rRamYDko3skFoXf/T8kTN2L6k28IYyl2C8pmLRKYw9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXm5Y6Op+7NT84CklQi7ccr9pQdXjVZ1MUvFUCQcoht5CBnXXpfhqCx8XnES7sfVWaRJUJZZewFpy3tLKwqDsAQl8EOAQeYJ/+e3YW7QowafbZ4Q2YjUsugaumDxZffKyqLf2XoBfFDpalPrn7Oj8Iw4dQQniB5JQbJm/NF9bqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8DvUjUl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86DA1F000E9;
	Sat, 13 Jun 2026 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781377626;
	bh=CuAWXykF7BQHKNBBvJx6xNE5z4keORn4vghIBe7B4U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j8DvUjUlRc+PmWW8KbjgMzQDsTWKNzrxE+y67B0BJpLV/QcjdeMxfliOnT48gAtIH
	 y+1oPJYuMsIiRuZIeJk2ybXbbrfqUp2JNUvqf7UT5jJ6fwnjt8PJtG22t2rsheH7Q1
	 VAwPiaFHOC+d+JTU9lAFqQJW1wyjnM3GiW1E7dvBx6i71qZNlNpyM7FHWtWG8KZqMl
	 Kg4UMxk4dGIEZjQ2TXMfyqdUSYfYBh0elzi2OFScgDXlbe5hbRa39Rjlm7pX7dKYNf
	 1RXOYI00xxnat+nvbWnoQNqC3AKRBuJxGEBJPXIqYG9q/xp+500p5klZySWkpI+n/1
	 FytWNybqU6Img==
Date: Sat, 13 Jun 2026 21:07:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, daniel@makrotopia.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add
 RTL83xx series
Message-ID: <20260613-natural-spiked-chupacabra-b2fd5f@quoll>
References: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
 <20260613112946.1071411-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613112946.1071411-2-markus.stockhausen@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299023-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quoll:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6A4967F663

On Sat, Jun 13, 2026 at 01:29:39PM +0200, Markus Stockhausen wrote:
                - realtek,rtl9302b-mdio
> @@ -24,6 +34,8 @@ properties:
>                - realtek,rtl9313-mdio
>            - const: realtek,rtl9311-mdio
>        - enum:
> +          - realtek,rtl8380-mdio
> +          - realtek,rtl8391-mdio
>            - realtek,rtl9301-mdio

I don't have that context in my recent next, but anyway looks correct.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


