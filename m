Return-Path: <netdev+bounces-269632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFWMDqhUvGkXwwIAu9opvQ
	(envelope-from <netdev+bounces-269632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:55:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589C2D1DB9
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59C2A300BE33
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B12389E0B;
	Thu, 19 Mar 2026 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3RZ7ji8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063032571D;
	Thu, 19 Mar 2026 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950114; cv=none; b=F/IYUy7ldlx4oJ9OHVDoOvpY0QmgRM0EMB68oH+tIp4naKtQ01DaUBJbSkBpXpNXcRRlJGIsKp6esLLlMhhKg51oCaf1R8U/avwrsAo7NIxs0SqeEBiF6v+bfrxCqyQdM9C0GZjaN8xa6nEsjbMmpGviV9j+Dl1GEBRDKTn1HHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950114; c=relaxed/simple;
	bh=BKVZIah/27SLYSlA2gUiVUQcfkViEh1zQPpjbR2l7E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVVyEfUAVqfHGDlTnlnSHKHX6j5/AueU5SkB+AKzeOleVgSIkjGEX1qEa1kAtcZ4Ju+hXPExgkrIfZAxEMy2j/eAPffacFpiWXaahPQSzT6DJPOL4Ju5FzuBR0om8mmB1s2vd7ypPCcGltjwhRX2uo3ajcoYsAbFFWZtKjZ1ht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3RZ7ji8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D42EC19424;
	Thu, 19 Mar 2026 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773950114;
	bh=BKVZIah/27SLYSlA2gUiVUQcfkViEh1zQPpjbR2l7E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3RZ7ji8vqCdCclzDcS8bxpmooQGTTnlKkdFQgEXQg1eZhvBRCr9f4qrNJ620yjUg
	 YXtywyDtB3wVVShkAOr430yMfXJiqfY3rfQ1InBq05TObVmEqtHm54N2IyAgiJtvOW
	 iKPvf3mUn/pmOYLr3WRNE9a2eJQ/ySMghE5TG76mi4z5rJtyWPdlt7Egf5zN+IxS6Z
	 xfQ7LaxJFhQw4Il7ujQAJneS9zlanA5TqyXxq2dxbOTEGDdKtnTe1CrvJgY3S/N2zu
	 wrBmDbvn+/z5e9BiWqOALDtaQKasCXlGI8VZEuZybeyU/2gPSvL0WXjLUzh5ckvJ4r
	 Ie4Y49eFc4y2A==
Date: Thu, 19 Mar 2026 19:52:38 +0000
From: Simon Horman <horms@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com
Subject: Re: [PATCH net-next v4 00/13] macb usrio/tsu patches
Message-ID: <20260319195238.GT1753385@horms.kernel.org>
References: <20260318-surpass-puzzle-f94b46aa8808@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-surpass-puzzle-f94b46aa8808@spud>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269632-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 4589C2D1DB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 04:37:31PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey folks,
> 
> At the very least, it'd be good of the soc vendor folks could check
> their platforms and see if their usrio stuff actually lines up with what
> the driver currently calls "macb_default_usrio". Ours didn't and it was
> a nasty surprise.
> 
> Ryan and I figured out that the sama7g5 stuff is not actually using the
> same usrio bits as earlier devices, so there's now more patches in this
> series to split them apart. I've not tested the split or the new
> property due to lack of hardware, but Ryan has.
> 
> Marking this stuff net-next, because although they're fixes I don't see
> any particular urgency, and it avoids creating some dependencies between
> cleanup items and the fixes.
> 
> Cheers,
> Conor.
> 
> v4:
> - deprecate instead of remove existing devicetree property
> - pick up Theo's patches
> 
> v3:
> - reorder patches
> - fix smatch issue reported by Simon
> - add patches reworking usrio handling of clken/refclk (and remove the
>   issue the llm reported in the process)
> - add a new devicetree property for refclk selection, replacing the
>   existing one.
> - drop the dts patch

Hi Conor,

Unfortunately this does not apply cleanly to net-next, which breaks our CI.

Please rebase and repost.

Thanks!

-- 
pw-bot: changes-requested

