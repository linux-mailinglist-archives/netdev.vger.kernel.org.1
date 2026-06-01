Return-Path: <netdev+bounces-293917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDovLq4RHmrugwkAu9opvQ
	(envelope-from <netdev+bounces-293917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 01:11:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45E6263B8
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 01:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1D213009087
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 23:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116513672B1;
	Mon,  1 Jun 2026 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGL4zNAt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFA34AB19;
	Mon,  1 Jun 2026 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355500; cv=none; b=Y4d02kVZ3teFN/KrFwxXg+Y+1Gfck5kTmN81efMmWJfeKgc9AFq+vzwoCilpkw8j4++k3w+JiDmV29nZ99jqHODVW3tFycvIFDh3IntA807x3LA+zrkKX1AtYFXyRGBaiKMUq1MdbAtSNfR7yS/AqUqGDcUqbLOvIhMNbbJ3pXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355500; c=relaxed/simple;
	bh=tZ/FyU6BTe1l76oQLhf/QPSnjO6j3Wt4thVE357l+lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpgEF8iHk+plltUAfBnaYl563A3PXCbxl8tcd0Yq4btdJktZOcy12HACzPbJqbOiVeidrYTZ3NTh341REsGhD1HS7y6B28q7RgKNLOM7aDg+JdnCivW+0IcZpHelrgS/XiDeRABym2r5pHvUzH2dW7e6mzW2I+eRZ1iFUDHlwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGL4zNAt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7D61F00893;
	Mon,  1 Jun 2026 23:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780355498;
	bh=u0uVl58P/+LhtePaVxc1OfDLsvpS/SYXpeqwBFFbzSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fGL4zNAtKMHnY544PXECwX2aMFMp24rQEYuUfQs+q21l93HzpIoRz52ZpUN9uwl/c
	 QoiugUZR1nUBv6FmnjvfYpNQH+WM0id3NatUQeZS7gmM77UqWgWCnDgloXPPUM+q6b
	 EqvWD8Iwdz2ig7V078bAd9ClTS2Rwhnq0K/E82D/kLa8WxO3WtTvzDE3hW7/NV4hn3
	 0fwhsepFhBiUJjLnTbY2PoJcanlPDjS33wSP7UO3Kkfl9U+T2Qre7WgeccSvtYofEa
	 d1hYkbXkCDdi9kkFX4q+1PJfxHkP0OohnKITG8PZ8cu5VfqakCLak+bmY4a6imtF52
	 ZQ5pS14t8q1/A==
Date: Mon, 1 Jun 2026 18:11:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v8 01/10] dt-bindings: net: airoha: Add GDM port
 ethernet child node
Message-ID: <178035548342.162634.13411632527297449694.robh@kernel.org>
References: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
 <20260519-airoha-eth-multi-serdes-v8-1-6bd70e329df6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-airoha-eth-multi-serdes-v8-1-6bd70e329df6@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,genexis.eu,kernel.org,vger.kernel.org,lunn.ch,lists.infradead.org,redhat.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-293917-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5D45E6263B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 19 May 2026 10:57:44 +0200, Lorenzo Bianconi wrote:
> EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
> or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
> As a result multiple net_devices can connect to the same GDM{3,4} port
> and there is a theoretical "1:n" relation between GDM ports and
> net_devices.
> Introduce the ethernet node child of a specific GDM port in order to model
> a given net_device that is connected via the external arbiter to the
> GDM{3,4} port. This new ethernet node is defined by the "airoha,eth-port"
> compatible string. Please note GDM1 and GDM2 does not support the
> connection with the external arbiter and they are represented by an
> ethernet node defined by the "airoha,eth-mac" compatible string.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-eth.yaml | 56 +++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


