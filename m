Return-Path: <netdev+bounces-51412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1B7FA901
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279481C20A70
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CEA3C46F;
	Mon, 27 Nov 2023 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FVV6gLct"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE661DC;
	Mon, 27 Nov 2023 10:35:56 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C97DBFF803;
	Mon, 27 Nov 2023 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701110155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pc1dK8aGf5N+ZGXLXuYK7yI/sgVAfECJyWAgPuDAf8=;
	b=FVV6gLctHTH5WH+azA/EbdLUT+joHm/MLfPtZF+xvorcvbC1VSUnSLTgggcgTEilKRBR2d
	ztEbOXNXAtGbGwnwpJMGKNfSKpI5Znr62hBkD8A7s/CKbcdAw9x9HkQv/8sedfKFn4/ERM
	tjapWIdiiYweHJs8HRGXG+R78EkuEzVrPo0bEIXlsTVD1p02zma+bd0L/Tys/fU4gbaVMM
	rHJV+6I35gzldItprm/Z90xlnYZAFCsQq9oarolikTB8IeqUX80PrI5D4K4YUhQZdi/Mux
	eqwVGE3FfEZHEHboMirN9BSrpx+E0uMzj9GGI91hLg6OfptF2iPbFDcZm8bqAA==
Date: Mon, 27 Nov 2023 19:35:52 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, Conor Dooley
 <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231127193552.1bcfe0ab@kmaincent-XPS-13-7390>
In-Reply-To: <20231124192407.7a8eea2c@kernel.org>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
	<20231124192407.7a8eea2c@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 24 Nov 2023 19:24:07 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 22 Nov 2023 14:52:43 +0100 Kory Maincent wrote:
> > Jakub could you create a stable branch for this patch and share the bra=
nch
> > information? This way other Maintainers can then pull the patch. =20
>=20
> Tagged at:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
> firmware_loader-add-upload-error

Thank Jakub!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

