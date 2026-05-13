Return-Path: <netdev+bounces-287737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIukFI/7BGrxRAIAu9opvQ
	(envelope-from <netdev+bounces-287737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:30:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8653B72C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67C863019892
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3438395DB8;
	Wed, 13 May 2026 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4TH6LM6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B137FF58;
	Wed, 13 May 2026 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711435; cv=none; b=NF8q/tpRcUGa6EoH5bllFibOPr94vTwsgFPzYlvg4JVM0SpbedZoTPysJbAupF/37MBKPvb/1U8pq764urJc2zfCHhG904hFV7lztO1RX5GFuaWCz9+ml1GetxIv6BJeSyNOWeB1xOE6dwn1dk29YfwuKCXhOuIZv3ULGUeNo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711435; c=relaxed/simple;
	bh=NXP84lvtAJkBs5OOdZdw6bPQK+75PbJWLaGmXLWSShY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSd6Rn5O3/ML2mN9ZzISggOqXyCspQzTAvgXfcEVVAbvR/hZh7aH+AQvSAGss+wp4IE2WQwrEAV+IOQr76DDiTX6Sr54PDRgZ4jcoOCPdlxnSogR7z8rogy0/4dat8b5XgQPKfVbgNKf5Vti4qpQ3EcIIY7k7ctKU2CXQYc0JP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4TH6LM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13150C19425;
	Wed, 13 May 2026 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778711435;
	bh=NXP84lvtAJkBs5OOdZdw6bPQK+75PbJWLaGmXLWSShY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4TH6LM6bGmxdAlgMIZO6VtcI8hx3CftdRZ4aPCbeOlzQVExWwd4w3Evu/R9yMCZP
	 wcSqjdkQNDxLABPVTng9+/ajTM4dVa60LMhRK+tURkrti/gZv+33zORrnQJd9LhXE4
	 U0N1CkfPX7eBHjoezWnrSsDRpj+uaS6/kMxgKS7SdUjyfpzDDpJ0OvlZire4CxVWAl
	 4fqp0nb3SZq1Ix5xCceW5a3i7tGfZEN+UGyzjHE73jTb6ljm4paDQkSkRZz3jzKRD0
	 WU1ucSQPSKM5GgSsWyXXumIjUxfHqRhsyIhSNNoZQ8xRFAkV2IY0xg2npe8KysmCtb
	 DaCr+iYJ85xcA==
Date: Wed, 13 May 2026 17:30:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: edumazet@google.com, o.rempel@pengutronix.de, pabeni@redhat.com,
	devicetree@vger.kernel.org, kory.maincent@bootlin.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, krzk+dt@kernel.org, andrew+netdev@lunn.ch,
	luka.perkov@sartura.hr, conor+dt@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd:
 microchip,pd692x0: add port disable GPIO
Message-ID: <177871143033.2145977.6127255354690890686.robh@kernel.org>
References: <20260507104720.262641-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507104720.262641-1-robert.marko@sartura.hr>
X-Rspamd-Queue-Id: F0D8653B72C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287737-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Thu, 07 May 2026 12:46:54 +0200, Robert Marko wrote:
> Microchip PSE controllers have a dedicated port disable input that like it
> name suggest, will disable PoE on all ports.
> 
> So, lets document that GPIO.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  .../devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml     | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


