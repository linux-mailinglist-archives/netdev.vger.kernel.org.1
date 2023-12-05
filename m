Return-Path: <netdev+bounces-53862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C6805030
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9965B20C48
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C504F1E1;
	Tue,  5 Dec 2023 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dqU3Ocle"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FAA4
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AbB5Qz6GWkg9LfVnIfDvDTd0sO23x3xghZP2VmY5NZc=;
	t=1701772116; x=1702981716; b=dqU3Ocle2H0o3M+R3amrk42vq5lUjnpdhDpXS53T+Jqst5k
	BqiNIyx313s860kOUVvbhlLCGuqxjmS45ktmwaYLgRKBlOLzh+0d27tGFbwiCodTmtEB9SJt93XPM
	f+CMsi38zxYZ+O3W3Lq/HhSTqFp8BTomMZ4UmBLA2OM/4Fpi45c5ESFQaelukk9tmvSoIfEDettjO
	UnD9Gfxlpmoek1bHw3L73whMre0t3ALGw3zs4NPsr/MtjqhBcBha2c8N/0ramhd6wWLB5gM3jywBH
	zw+AT7snzhbHUnwdwV6as9PvYhZgaC/HquXTEsh62PpB3yUrL0C5KEqWOYGP8X5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rASfI-0000000GECp-3u17;
	Tue, 05 Dec 2023 11:28:33 +0100
Message-ID: <48f260af66acc811d97eb64ff1b04ecce5893755.camel@sipsolutions.net>
Subject: Re: [PATCH net] net: core: synchronize link-watch when carrier is
 queried
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Date: Tue, 05 Dec 2023 11:28:32 +0100
In-Reply-To: <ZW7gMO9YNjP7j4vj@nanopsycho>
References: 
	<20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>
	 <ZW7gMO9YNjP7j4vj@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2023-12-05 at 09:32 +0100, Jiri Pirko wrote:
> >=20
> > +	/* Synchronize the carrier state so we don't report a state
> > +	 * that we're not actually going to honour immediately; if
> > +	 * the driver just did a carrier off->on transition, we can
> > +	 * only TX if link watch work has run, but without this we'd
> > +	 * already report carrier on, even if it doesn't work yet.
> > +	 */
>=20
> This comment is a bit harder to understand for me, but I eventually did
> get it :)

Do you want to propose different wording with your understanding? :)

> Patch looks fine to me.

Thanks :)

johannes

