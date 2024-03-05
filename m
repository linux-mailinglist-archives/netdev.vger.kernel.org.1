Return-Path: <netdev+bounces-77438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17274871C62
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EC21C22E68
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF005A7AB;
	Tue,  5 Mar 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqF9/xoM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="paLKKPEk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C2548E0
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635943; cv=none; b=otcaznEQ5dVwtmW0NRaEXQy6wL7m2zdccm/z41k9nxtQCFdT2Zq5OOn0gsMCkxu6jye7r/IOppNsRuzzTaLIfjyGJ7zt9sP9Ptfn1osO0E68J+D20SQfxrlm7BhwsI77uGfvXCfYxv3zw2gVvBXLeKNl4Yjv2BnTCYQ7/L7rp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635943; c=relaxed/simple;
	bh=+CWpj8hSxweKYQpRCiiTkJ7pSgFocksRY7eEEu7g4sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmG3KriOCFOmIC02Lmm9q3pEKGH9PAtpQUmDhDOlZHrFM5ktHLVz8Dsfp78I4dkpdCLttIV4URkDCGRBO4y8WNqfZJzspNS1bmsleaul+QWupg/Gem6/9W1sB86erTQ78+q8hSC4UPFijTrcs4c1Pd/ug7UPwopg5b0Vu2aAYVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iqF9/xoM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=paLKKPEk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 5 Mar 2024 11:52:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709635940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CWpj8hSxweKYQpRCiiTkJ7pSgFocksRY7eEEu7g4sg=;
	b=iqF9/xoMLoQx6Q04pYaL7OPwCuaOZk6nuLWu6s/mSyEFIKxdy3ieACWHP/DIwwPwoNw1mH
	csSNnh4H+XpuAzG07wZvDKp3XHg1b48dgwuTwf/wgSedsl5dNIqQILeW9K+xGceOOPzGIY
	E/0eS6muvmhMjR1VUr1sqTwTTxzKvB55gXU5NjWHsQQR7QXF1a93uuRskVtFa57Z4wux56
	cI8trfBKZv7v41qWiJuci06REXNEZ7wCClLoXb8/LwLiTuf9KK+22JTh30Xb29FzvrSEBj
	AAcEzuo7lOmApGyA2f1xQJZlyGN07g6bTMpL4u4t2uxxf71IU+oRZY5fWywZFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709635940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CWpj8hSxweKYQpRCiiTkJ7pSgFocksRY7eEEu7g4sg=;
	b=paLKKPEkY/U6oSINtmRKYrkFkYX/k/FWb0d8PJzEkzvJU75F2kYtKdWaS7AVgmv1hy2UKE
	rww4dosyJSakktDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v3 net-next 2/4] net: Allow to use SMP threads for
 backlog NAPI.
Message-ID: <20240305105218.EXitUftO@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
 <20240228121000.526645-3-bigeasy@linutronix.de>
 <c37223527d5b6bcf0ffce69c81f16fd0781fa2d6.camel@redhat.com>
 <20240305103530.FEVh-64E@linutronix.de>
 <ae886b7975751a2c148fa4addce26c456678c735.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ae886b7975751a2c148fa4addce26c456678c735.camel@redhat.com>

On 2024-03-05 11:44:06 [+0100], Paolo Abeni wrote:
> > I am not aware of a perf regression.
>=20
> I probably inferred too much from the udp lookback case.

Yes. This was real and is gone now :)

> > Jakub was worried about a possible regression with this and while asking
> > nobody came up with an actual use case where this is used. So it is as
> > he suggested, optional for everyone but forced-enabled for RT where it
> > is required.
> > I had RH benchmarking this and based on their 25Gbe and 50Gbe NICs and
> > the results look good. If anything it looked a bit better with this on
> > the 50Gbe NICs but since those NICs have RSS=E2=80=A6
> >=20
> > I have this default off so that nobody complains and yet has to
> > possibility to test and see if it leads to a problem. If not, we could
> > enable it by default and after a few cycles and then remove the IPI code
> > a few cycles later with absent complains.
>=20
> I think this late in the cycle is better to keep backlog threads off by
> default.

Sure.

> Thanks,
>=20
> Paolo

Seastian

