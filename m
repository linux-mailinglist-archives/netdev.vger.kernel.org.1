Return-Path: <netdev+bounces-293915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGwwI/sEHmpRggkAu9opvQ
	(envelope-from <netdev+bounces-293915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 00:17:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D98625D6C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 00:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC64030097D0
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743F3431E3;
	Mon,  1 Jun 2026 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0WBuz+d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5B1E511;
	Mon,  1 Jun 2026 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352238; cv=none; b=qEcz6lKm83/D4FF5XrNevoOWIf9v5oeIZrnHOPcaxguH6vBngWhWmLMqKokCDd3iyO46eS1Fvy+vzym/Huv33vs8RHc9+KNeuD0DcQxp3vkCTA2TOxbRQ72tKDAHAWbYm7BDy5tt4sbL9i0tbIqX3Ih0Q8VV1Jno4BD+hLxLc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352238; c=relaxed/simple;
	bh=jeN9QbwUvs0491WL7WGf73Mqix9yzh0RIpAzhH97zt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQItIlWZafTx0pGfWWkPorCE7seNWZCbskPdBO+YhwqC26lZBNDyieft88FiNHzqeIGPZiIvcrm193YaBVvgTsSnVmLoMiDBwqhxw58uB+qt6tHpyHDkMt4En/r5KddLEHixdiggdleNs4h01EtBMMiHTh14A6admD/GNpn0+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0WBuz+d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7081F00893;
	Mon,  1 Jun 2026 22:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780352237;
	bh=1mbiyeaSsKLt0leGo7e1qkrPrGZ3cp02co/bhf0omZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g0WBuz+dgxiFsc4KdqstjcJFwerUWdAF78Qwx3fFonpcbp6NXPgBEijgBYV4RuH3u
	 tFYehRLGxdA0asT4fVB4aeviFDSmLidk7+Rsb6LZ3Yh24BMm84LGysqKPqtHqYfExE
	 0iGF9AhjUVxHEfOB3pJ+ZnAW0Arny+X9eP1oXzcSvDEDX1+ASiK0bOjEWOLzStXUPG
	 WbYJWbwwtJ5feXgR6/f2plVSkxPFh/cY7dLZYm2iP68T3lbT+XEnnv+EscxloCaivA
	 /e93fezq8e3zrnXkSCjseb5cGdTdujOWxqqoPg9vwAYxedl+NTVoufvgtqzc6Se34i
	 mY6HZyUHqH6tw==
Date: Mon, 1 Jun 2026 17:17:16 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: Convert lan9303.txt to yaml
 format
Message-ID: <20260601221716.GA79467-robh@kernel.org>
References: <20260512214704.1084890-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512214704.1084890-1-Frank.Li@nxp.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-293915-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[2.250.240.128:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,53fec000:email,nxp.com:email]
X-Rspamd-Queue-Id: A9D98625D6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 05:47:02PM -0400, Frank Li wrote:
> Convert lan9303.txt to yaml format to fix below CHECK_DTBS warnings:
> arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dtb: /soc/bus@50000000/i2c@53fec000/switch@a: failed to match any schema with compatible: ['smsc,lan9303-i2c']
> 
> Addtional changes:

typo

>   - rename switch-phy to switch in example.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/net/dsa/lan9303.txt   | 100 --------------
>  .../bindings/net/dsa/smsc,lan9303.yaml        | 123 ++++++++++++++++++
>  2 files changed, 123 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/dsa/lan9303.txt
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml

With that and the doc reference fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

