Return-Path: <netdev+bounces-288221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LgLFiPXBmpjoQIAu9opvQ
	(envelope-from <netdev+bounces-288221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:19:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8754B312
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BAFC303527C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226CF3FE341;
	Fri, 15 May 2026 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVGcqc32"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC73FBEB9;
	Fri, 15 May 2026 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832910; cv=none; b=dKDOadpnqdpYyc97kH+Qcfech3+tSOza/ZDbrcsaATAxbryCL8eODyNO4wRU84PH1g2JhDBjOrVgtHw2VDJKrX0B0DqkZsPHnoKhPw8Jx0P8iOcTD7cGwQZmrMz5wxlytaQvoCC9uSLAcuCwPH+wfTnVAfXfD2kYFM7ftx4yrhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832910; c=relaxed/simple;
	bh=6PzZRQQ5+7QSrGyWy5bFF5fda83Kjv6ZTXX6Wia9FjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVJBvAltAJ4I95ewEbv05UjAzJDt5w9DcaRB4bH4cJ5cGdwR8awvQTPB0xmaoy3PvIf3FGrBxK8uUOHM7G3UtGifE0KNan6vdnSkm1N791MWRrBH8z/eP61GryzrKeR+f2IE0/dnbZW7wDAlBQdj5mLxa/LuKq0rZf85RLB76MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVGcqc32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B31C2BCB0;
	Fri, 15 May 2026 08:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778832909;
	bh=6PzZRQQ5+7QSrGyWy5bFF5fda83Kjv6ZTXX6Wia9FjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rVGcqc32DQbYkM2eHRST48q5KUv4gN+fFt8r4bzXWaxWIKkSuSpZ/aD7beLPoNrF0
	 YU1qbLtvwuMHuUtxZePgtmZHN2rLU4eCFHYkC1sHDgu5k3IytkaSx098P2TJxNu4Sy
	 +QPQyKp7fX5Ccvd3gGsDmZ/9Lml3KEL8Dq1WPCvMiC96cTd4C/wcITePQ9mHW8a7sv
	 7nhEuyGJoo+S44vkfSUnrpeNUlyr4/4vA4VH0ON55zW5gsMc2uUlSXCg8VtCroXZ4x
	 cjhMilV5lp9oFVFaZqm53bF1JDLSce8A1JXMdtr6YQXM5DdgU1w5pLjXFlbY65xr2P
	 ltGRK+M1luQZQ==
Date: Fri, 15 May 2026 10:15:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 1/6] dt-bindings: usb: ci-hdrc-usb2: Document
 nvidia,external-control property
Message-ID: <20260515-lemming-of-enjoyable-blizzard-d32ad9@quoll>
References: <20260511135703.62470-1-clamor95@gmail.com>
 <20260511135703.62470-2-clamor95@gmail.com>
 <CAPVz0n2GkucfHqvgusF=K_KakqaJmZSLP=8VYMyVT5HAVDD_XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPVz0n2GkucfHqvgusF=K_KakqaJmZSLP=8VYMyVT5HAVDD_XQ@mail.gmail.com>
X-Rspamd-Queue-Id: C5B8754B312
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288221-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 08:34:45PM +0300, Svyatoslav Ryhel wrote:
> =D0=BF=D0=BD, 11 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16=
:57 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Document the nvidia,external-control property required, for example, for
> > USB lines in HSIC mode connected to a modem, where the modem requires
> > precise control over the USB bus to properly enumerate all its stages a=
nd
> > intermediate devices.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/=
Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > index 691d6cf02c27..a13c1ef49a57 100644
> > --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > @@ -75,6 +75,13 @@ properties:
> >      type: boolean
> >      deprecated: true
> >
> > +  nvidia,external-control:
> > +    description:
> > +      Indicates that the controller is configured externally and that =
the host
> > +      should not attempt to touch it. Usually used by a modem which re=
quires
> > +      precise bus configuration.
> > +    type: boolean
> > +
>=20
> Would schema maintainers mind if I create separate schema like
> chipidea,usb2-imx.yaml is handled? At the moment ci-hdrc-usb2 holds a
> mixed properties of several SoC and can cause unwanted/unsupported
> node combinations.

This is a good idea. All nvidia devices and their properties should be
moved there.

Best regards,
Krzysztof


