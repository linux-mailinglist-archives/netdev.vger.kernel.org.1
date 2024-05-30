Return-Path: <netdev+bounces-99400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7148D4C23
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACCC1F21754
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F917C9FF;
	Thu, 30 May 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M6DNy06I"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E217C9E5;
	Thu, 30 May 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073915; cv=none; b=VR5h7ZPxMsGKapHFEX1h1D3YD0+LH/tM4gpeMBvPqB7qtmahrH40YV1wNzscd/w7CnfVKAw48btW420GFWTOG41PaaX20pM/TxinjwuuQ4EeJgh/dOep5YxCp7fa35h0XPjADfAm4n/KyJ3ZQK2xQEgNLVb983UaERPvJ4tSrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073915; c=relaxed/simple;
	bh=C2iRBYTREzdjDlGihekO6DW47GYkbW034P8nLnt49xU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsDg1zR23ZiI50uhGzicE225ixVo9ui5mWyaHad5rXRvgObJu64bW+GsKRPVBXqxjqwBI+FmgrdHZeIfxjZTNhOHnsVH8GmonieAX+RqEvrX/NT0FohUeCZ+5Y2fDkIEMsfWWe48Y/XW+XD+z6F3A8565Rw1Vhv9vtxWuGrDURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M6DNy06I; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEF5060006;
	Thu, 30 May 2024 12:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717073904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNdDLnGODJuYqniJ7vxj1Vy7TfXGXcLGyL2rV05KoB8=;
	b=M6DNy06IKXgNAxMYAL78NexpTNF8PxuRBkBNcwUiXrj0pg1Vrd7AENMVLaljvnjsDVFtxz
	S/xp4H5PdPtzss7LrfMpO2SiTkEBtZi6FtTJNmMR/otKBrocVntMn8pCEJf01Tn+aubpnW
	vWl4HQ38Qv5TBJ7xfrD3+4dperuV+Vf7D+FyXrSaxG6C/jAJNx/dA2xrddwgDI6U5e2hh9
	u4M+fRZR3W3RcRku5Iz88iI/TiVSw+m2Hh/bvN4m69v8jyszfj7tIe2K+jBPf0uBF4XXE/
	sH8oefz3ga0jpnGtfJO2P276SVsTvrY6G4AB6AP2g5611GRbGg5TtN6WZr6mUA==
Date: Thu, 30 May 2024 14:58:23 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH 2/8] net: ethtool: pse-pd: Expand C33 PSE status with
 class, power and status message
Message-ID: <20240530145823.5f6fc44e@kmaincent-XPS-13-7390>
In-Reply-To: <m2jzjbd1zc.fsf@gmail.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
	<20240529-feature_poe_power_cap-v1-2-0c4b1d5953b8@bootlin.com>
	<m2jzjbd1zc.fsf@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 30 May 2024 11:32:23 +0100
Donald Hunter <donald.hunter@gmail.com> wrote:

> Kory Maincent <kory.maincent@bootlin.com> writes:
>=20
> > From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
> >
> > This update expands the status information provided by ethtool for PSE =
c33.
> > It includes details such as the detected class, current power delivered,
> > and a detailed status message.

> > =20
> >  /**
> > diff --git a/include/uapi/linux/ethtool_netlink.h
> > b/include/uapi/linux/ethtool_netlink.h index b49b804b9495..c3f288b737e6
> > 100644 --- a/include/uapi/linux/ethtool_netlink.h
> > +++ b/include/uapi/linux/ethtool_netlink.h
> > @@ -915,6 +915,9 @@ enum {
> >  	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
> >  	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
> >  	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
> > +	ETHTOOL_A_C33_PSE_PW_STATUS_MSG,	/* binary */ =20
>=20
> It looks like the type is 'string' ?

Yes, you are totally right, thanks!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

