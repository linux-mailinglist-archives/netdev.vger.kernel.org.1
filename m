Return-Path: <netdev+bounces-289025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAIuG10DC2q3/QQAu9opvQ
	(envelope-from <netdev+bounces-289025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:17:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3DC56C740
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D1C30379B1
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1053F9F26;
	Mon, 18 May 2026 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu7vYbNa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96D3F8EBA;
	Mon, 18 May 2026 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105861; cv=none; b=bXzcoy+s6RPWQX2HL8z6qbYEN5ypZRSJDvcD5B/7Hb8Qoad2+viKJEnoBboqOWjT3smWXod/hf0hQUNzulHz9bs8PuAcEQUJK1VCPrFlukBcGdQuaDOC9Eu0K3edJAV3jiRC6QqSvSZtJkrICEikSDz6rY32mbmtnHEYgo1ByD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105861; c=relaxed/simple;
	bh=BJ+dVmdctWlNDf4FxLrax2LS0TPJidUPUoHpRQQ+xy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNVNEXnYtmVvfQGmkclaA6fbtEUVNwYH3uGh2MAIfXCaOsTEK/NBsuiMMPlIYSNms2gv/vOpgY2VXpQFxxk7Cp8iZ4/64uxZrXTy+/P0UVJfFQiPx8NjWyN3qlA0ct+YSECOqiZ1b577fH6WX6muE+U+ceEp8D9HSrM3Y9TfM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu7vYbNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55071C2BCB8;
	Mon, 18 May 2026 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779105860;
	bh=BJ+dVmdctWlNDf4FxLrax2LS0TPJidUPUoHpRQQ+xy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qu7vYbNayaB/gjw1ZJNz4Q6wmI52LwzKCkT/zJTCuslmWmMAxgdblGEKHFxupOr+A
	 ipJu+6BzEQcnqa3ooXWG0XbQ27XoL7iGQH+/EiVegk1UM82ndnNREOG1oRXlUrQw3B
	 OQi4wfpOnPMLDbUGomcyScTZK4kLL45JLu5w1ORZbf0vswluOLtAEfEfqNTF5wy0NS
	 UPQuu+fl4ztIypraKncQNiEm4eYJ1trSH9HG1o7OjIgWFqtbAmpvvcfQHMMQfDYCpZ
	 doNii1C6E+z8hA1wYHgOw77s3KtSErMhNtCHKT8wsNGOWHalVepTi4Sc5iAjFbs5Nt
	 bF2BVNTL/vjhQ==
Date: Mon, 18 May 2026 14:04:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Chen <peter.chen@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: net: Document Infineon/Intel XMM6260
 modem
Message-ID: <20260518-loutish-colorful-earwig-12dbc9@quoll>
References: <20260511135703.62470-1-clamor95@gmail.com>
 <20260511135703.62470-4-clamor95@gmail.com>
 <20260515-precious-ginger-lori-d1fde7@quoll>
 <CAPVz0n3mvBLracMWGNuJ8kKUvAVZ+JRTJVkZGyq5MkuSobd8NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPVz0n3mvBLracMWGNuJ8kKUvAVZ+JRTJVkZGyq5MkuSobd8NQ@mail.gmail.com>
X-Rspamd-Queue-Id: 0B3DC56C740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289025-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:39:49AM +0300, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 15 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11=
:18 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, May 11, 2026 at 04:56:58PM +0300, Svyatoslav Ryhel wrote:
> > > +  ap-wake-gpios:
> > > +    description: GPIO connected to the EINT3 pin
> > > +    maxItems: 1
> > > +
> > > +  cp-wake-gpios:
> > > +    description: GPIO connected to the EINT2 pin
> > > +    maxItems: 1
> > > +
> > > +  phys:
> > > +    maxItems: 1
> > > +
> > > +  vbat-supply:
> > > +    description: Supply connected to the VBAT lines.
> >
> > This should be rather name of the pin on this device, not the provider
> > name. VBAT suggests the latter. Please double check.
> >
>=20
> There is no documentation on this device from Infineon, I have used
> schematics of the P895 where this modem is used. According to it power
> supply is connected to pin with name VBAT (and yes, I am not mixing it
> up since supplies have different names)

ack

Best regards,
Krzysztof


