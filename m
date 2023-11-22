Return-Path: <netdev+bounces-49961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8737F415A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B8CB20D3E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E92136A;
	Wed, 22 Nov 2023 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZW/ci6WZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9F1A2;
	Wed, 22 Nov 2023 01:16:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD0C024000D;
	Wed, 22 Nov 2023 09:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700644567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pd8P94KReE7rtC9tl5ie2LKIkhmNIUEsbYj4grCZU0M=;
	b=ZW/ci6WZHSFyXWwK4JmihGUwbWHjWUTjUBhA/E8IZ0w3FE/PJmx3QB7CPbJ3ECb0G+E5bQ
	NlM5N7gLomjSpiCVQHJPvrx3oXoUmr2L2nQXlMhTPq7SSpFhaMnC/bXdsz7WQNJT4y5axb
	60mpTFTDvJMLu4t6jmwG5miPll28wiuDyCXymKKwmtt5ZwhcCcBdLC2vljYmWsoXW8+Z21
	ym15nG/lJC0hd524C44lrBMk6roj2wgzMZ0fDIwSkGRqraj1+cugpt76P3yNCqRePg3AcT
	eY+urbL+FEQy7PClrqeSzREUKsgBZBkC9caSvAxLsukJUy5yURXKmtpZMJ/d/w==
Date: Wed, 22 Nov 2023 10:16:05 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, Conor Dooley
 <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231122101605.0786440b@kmaincent-XPS-13-7390>
In-Reply-To: <20231121173022.3cb2fcad@kernel.org>
References: <20231121-feature_firmware_error_code-v2-1-f879a7734a4e@bootlin.com>
	<20231121173022.3cb2fcad@kernel.org>
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

Hello Jakub,

On Tue, 21 Nov 2023 17:30:22 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 21 Nov 2023 11:50:35 +0100 Kory Maincent wrote:
> > No error code are available to signal an invalid firmware content.
> > Drivers that can check the firmware content validity can not return this
> > specific failure to the user-space
> >=20
> > Expand the firmware error code with an additional code:
> > - "firmware invalid" code which can be used when the provided firmware
> >   is invalid =20
>=20
> Any idea what this is?
>=20
> lib/test_firmware.o: warning: objtool: test_fw_upload_prepare() falls thr=
ough
> to next function __cfi_test_fw_upload_cancel()
>=20
> My build shows this on an incremental clang 17 build.

Thanks for the report.
It seems I have to update fw_upload_err_str accordingly.
Didn't know about this test_firmware.c file.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

