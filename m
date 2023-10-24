Return-Path: <netdev+bounces-43997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89467D5C5E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918002819B3
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394D73E462;
	Tue, 24 Oct 2023 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HwffRNGN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581B323C
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:25:25 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CDAD7F;
	Tue, 24 Oct 2023 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1UXtNveQEoqW90tJOyIfMQP3SasUg49M796K2bciGh0=;
	t=1698179121; x=1699388721; b=HwffRNGN41XiFhHwjS8Ed0sap2p/6XM44sVy0BuJnQ0y2cP
	iTGHPpNe2t/wOUXopk6+zy0/b95GFgoX+XWwiaYF1fT7dHN1jTsGZqikp/MwI0cKQT97zSm1kkyd+
	TzgL8sifYZIQbFc71EGjhqvrWE0h/hJG8QXOwhqnCvChb9CU+cCIuxenZ4eLPGbCz+otrRoJ8PJqH
	xpRvKlNJtFUaxDvUG+5VPRgCBXm8pWElw8DxBOIEHmf7pdZsnZAmhqi1l4DqrxI0sH118GSFcoUy3
	4JpRSIi/3TP6ZSHtMGMCtKD6JRZLJZs9thtPqmsSYRDoDzyIGhEbyfQ5QbHsNmHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvNxn-00000001azr-20eK;
	Tue, 24 Oct 2023 22:25:19 +0200
Message-ID: <1020bbec6fd85d55f0862b1aa147afbd25de3e74.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-2023-10-24
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Tue, 24 Oct 2023 22:25:18 +0200
In-Reply-To: <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
References: <20231024103540.19198-2-johannes@sipsolutions.net>
	 <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Thanks Jakub.

> > Note that this introduces a merge conflict with -next,
> > which Stephen reported and (correctly) resolved here:
> > https://lore.kernel.org/linux-wireless/20231024112424.7de86457@canb.auu=
g.org.au/
> > Basically just context - use the ieee80211_is_protected_dual_of_public_=
action()
> > check from this pull request, and the return code
> > RX_DROP_U_UNPROT_UNICAST_PUB_ACTION from -next.

Are you planning to merge net into net-next really soon for some reason?

If not, I can resolve this conflict and we'll include it in the next
(and last) wireless-next pull request, which will be going out Thursday
morning (Europe time.)

johannes

