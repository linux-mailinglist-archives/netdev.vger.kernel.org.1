Return-Path: <netdev+bounces-266500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOIHBocTsWkZqgIAu9opvQ
	(envelope-from <netdev+bounces-266500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:02:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B0C25D24D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 193CB3026419
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F40371899;
	Wed, 11 Mar 2026 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icwXk+JQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F54301701;
	Wed, 11 Mar 2026 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212543; cv=none; b=bmrchYf2K0nTlnY5suQ67okNuIVDf+cGneeS6ujHemjTX2TllXJT/XcejnY9bA3UxDtPc5nrPlk1vccsbQZQi4+JCb1iuQFHgABujllkWF9fPHN64kyyTlTzHEaypShpj3mkg2lcjbX3D7WNxQAoCm27RIBChdUsAUSUXOpaFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212543; c=relaxed/simple;
	bh=oEp0zagVz/EKP3oxg1isMpE3fIGisB1T3dXsWTVrdpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq8suxz2FULl4tHXwTdRvRb5ZoilemO3v27H+V0GoCjNwFyHR7czNXDP0stUHKnRtISEErX3ZQjtflxNbkYn457b8xJyJSlmg2O+ePJazr2idUsTdOsHKb5VxJ+lm34puxKfEyGh2giyyDl4M9G/etPHXBu38cx3xEmEwvEHiTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icwXk+JQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B533EC4CEF7;
	Wed, 11 Mar 2026 07:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773212543;
	bh=oEp0zagVz/EKP3oxg1isMpE3fIGisB1T3dXsWTVrdpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icwXk+JQMwQUrKJOn6jtJCSJkbG/Y3cGfZTlZJh6uzdoYw+WWSE6ZeMJd3UamP8uc
	 JK4WOJw+3i4pNSkCcTB6L1EujwAhmvMQQC58vuR9aCiDvdbCB5buitTXA90WICPnQw
	 WaA0O5VLCtPRTWDPgfIbzzXXNWLl73U7KMeBfrPnr8QbYhSaMCwpcSkKsj427MkKGb
	 TUDvITYa28rpmTrWEvAS8dCT2P73+87rEPHBhr3xhgymWDSn3azdTsJWR4gd/HVCwD
	 g3Qm78MEyXKPvUA/QLL1T1ojsKTzydSe8rILiD4zGRUolu819EmLdeAGMJFa1EIBjG
	 PqURs1aPe9B4A==
Date: Wed, 11 Mar 2026 08:02:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Valentina.FernandezAlanis@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Richard Cochran <richardcochran@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Sean Anderson <sean.anderson@linux.dev>, Vineeth Karumanchi <vineeth.karumanchi@amd.com>, 
	Abin Joseph <abin.joseph@amd.com>, =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, 
	Ryan.Wanner@microchip.com
Subject: Re: [PATCH net-next v3 09/10] dt-bindings: net: macb: add property
 indicating timer adjust mode
Message-ID: <20260311-uncovered-paper-hog-e32fcb@quoll>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
 <20260310-aviator-upswing-80e8543a2300@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-aviator-upswing-80e8543a2300@spud>
X-Rspamd-Queue-Id: 11B0C25D24D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266500-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,microchip.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 05:17:16PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The GEM IP has two methods for modifying the ptp timer. The first of
> these, named "increment mode", relies on software controlling the timer
> by setting tsu_timer_incr and tsu_timer_incr_sub_nsec and performing
> once-off adjustments via the tsu_timer_adjust register. This is what the
> macb driver uses. The second mechanism, "timer adjust mode" uses the
> gem_tsu_inc_ctrl and gem_tsu_ms signals to control the timer. These
> modes are not intended to be used in parallel, but both can be possible
> on the same device and which mode is used cannot be determined from the
> compatible on all devices, because some users of the GEM IP are SoC
> FPGAs that permit configuring how the IP is wired up.
> 
> Add a property to indicate that gem_tsu_inc_ctrl and gem_tsu_ms are wired
> up for timer adjust mode.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/net/cdns,macb.yaml        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


