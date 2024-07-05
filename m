Return-Path: <netdev+bounces-109519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257B928AD0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90ECE1F227BC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A7F16A938;
	Fri,  5 Jul 2024 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ASVRxnJp"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9B14B064
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190195; cv=none; b=mVq/RkrauThi4seGqDiK/d6aXXhtkm2G8CDF3MWFLdJiVu+/A7TqIfNE86bGEy7UiwDMRKaf6UK3FX343yGYYnqi2GxwiSOOnQurhfJ+8RVLlSxkF+y36fVZLG84zzm8LGCkvTqDV9r+NTgUhh7yrQwILf97vUjDNC+UtTV6ta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190195; c=relaxed/simple;
	bh=HdZ+1GtpeVEB7PJKiEGeEKokxiTgqpQX1WZZJ/llf40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QlGaTA3M0/3f2yKdpFBScqi0Ml99jA123R6aGGgVyNZ7ZN1pAwKAEZzBtNDYLANdtUPCDlLasMQrQXVBPkx++QltiFYlAOhRRr10tcpZbBmOscyzkNSe+mDyUGZdWVHoeu60CvuI2pHHzBuja79IFkBvCmdlr0z9QVCIci4r7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ASVRxnJp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IMzm+4P6VmvpM7WgOgiZIItVrF/KUjizhARcm2ETVbE=;
	t=1720190194; x=1721399794; b=ASVRxnJpd7Nnd/z5e4j6EIbCKcASzHKS/+i1LNg8WaQzcfj
	6iTGdNYNqxn4Cy/YzSxaJLM2BPwJD9UPshXIDQAApupGRyPWovqGRL/aonIZiKFo20HXv5SIfZOJB
	yIsVVHTZ4o3MphfkajuIBeCxw0Bb+GRKZ0bi2BC6kiqKIsdf0SonxEuQYzy5+Wx9FmZ7KH8HcHu7k
	i4uDE75/fmz/8OuodFKBQlx3X7QlZayqbJ3FGE6X6axeOY4H1WASYLbpO3lEDSjejQaGtiB1XKP4e
	QUo2bz72tAyIfolxt4Utr3lwJvdkGVdLlv48Gf3WBwxVy2q84sA/4UW05vWHbDZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPk33-0000000GmRa-3Egt;
	Fri, 05 Jul 2024 16:36:30 +0200
Message-ID: <cf5e8cf7c06b805fe354a69b306155a7f517d1a2.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
	 <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Fri, 05 Jul 2024 16:36:28 +0200
In-Reply-To: <98fe3c75-6916-4f93-ae7e-be80e60afebf@intel.com>
References: 
	<20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
	 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
	 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
	 <7eab05e6-4192-4888-9b6a-6427dc709623@lunn.ch>
	 <09edde00d5d44505b7a41efdfb26cb16d0cbdc59.camel@sipsolutions.net>
	 <98fe3c75-6916-4f93-ae7e-be80e60afebf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-07-05 at 16:33 +0200, Alexander Lobakin wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> Date: Fri, 05 Jul 2024 16:23:43 +0200
>=20
> > On Fri, 2024-07-05 at 16:19 +0200, Andrew Lunn wrote:
> > > On Fri, Jul 05, 2024 at 02:33:31PM +0200, Johannes Berg wrote:
> > > > On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
> > > > > From: Johannes Berg <johannes@sipsolutions.net>
> > > > > Date: Fri,  5 Jul 2024 13:42:06 +0200
> > > > >=20
> > > > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > > >=20
> > > > > > WARN_ON_ONCE("string") doesn't really do what appears to
> > > > > > be intended, so fix that.
> > > > > >=20
> > > > > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > > >=20
> > > > > "Fixes:" tag?
> > > >=20
> > > > There keep being discussions around this so I have no idea what's t=
he
> > > > guideline-du-jour ... It changes the code but it's not really an is=
sue?
> > >=20
> > > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> >=20
> > And ... by referring to that you just made a guideline(-du-jour!) that
> > "Fixes" tag must be accompanied by "Cc: stable@" (because Fixes
> > _doesn't_ imply stable backport!), and then you apply the stable rules
>=20
> The netdev ML is an exception, IIRC we never add "Cc: stable@" and then
> after hitting Linus' tree at least some commits with "Fixes:" appears
> magically in the stable trees :D

See, all the policy changes are confusing people, but not adding Cc:
stable@ for netdev is not true! :)

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#stabl=
e-tree

johannes

