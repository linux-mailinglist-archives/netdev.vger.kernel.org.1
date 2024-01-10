Return-Path: <netdev+bounces-62804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F9982947E
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 08:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A4B1F27523
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB239AE1;
	Wed, 10 Jan 2024 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XZfwa0Oz"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A43A1B9
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D73C1C0004;
	Wed, 10 Jan 2024 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704872994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRpgDsAkap+Ra379get7yvz64kB2ZV2+3U6XFZsKpKs=;
	b=XZfwa0Oz+s8wjcEVCFVmK9Ne5noM7U4fO0ITwIMfDjoDMnoD+8E3W4KbU5QxE93564wlpj
	JkeD+I5ZfELrULvfnQ3fzUHaRbPX/uw6KtBCoArtlXyea1aKkkOEhLBEtPOHRdcAXK5w6r
	vSW2yQCE8KxtktmQnTpeW531C258PL9Nb8YDaHDJG9hQUaBIbpEzeao9anbY9xFMn3qUvd
	b+Wj/E67fiALpYJi+/l7FT4jfxHDEQyBdhRI5H/ct6G2Kd345FR3EKYPL4st532LmiC1k9
	BWp8dK65HpRLfnCZS1MoUXr7H70VMzmSD4Z7hpBXF5CWrewtB7NFnd7KvYnDDA==
Date: Wed, 10 Jan 2024 08:49:52 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net 3/7] MAINTAINERS: eth: mvneta: move Thomas to
 CREDITS
Message-ID: <20240110084952.6e8d95bc@windsurf>
In-Reply-To: <20240109164517.3063131-4-kuba@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
	<20240109164517.3063131-4-kuba@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.petazzoni@bootlin.com

Hello,

On Tue,  9 Jan 2024 08:45:13 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> Thomas is still active in other bits of the kernel and beyond
> but not as much on the Marvell Ethernet devices.
> Our scripts report:
> 
> Subsystem MARVELL MVNETA ETHERNET DRIVER
>   Changes 54 / 176 (30%)
>   (No activity)
>   Top reviewers:
>     [12]: hawk@kernel.org
>     [9]: toke@redhat.com
>     [9]: john.fastabend@gmail.com
>   INACTIVE MAINTAINER Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Indeed, I no longer have enough time to continue maintaining this
driver, so:

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Best regards,

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

