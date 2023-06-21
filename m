Return-Path: <netdev+bounces-12716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E37389EF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38471C20F53
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04D1992A;
	Wed, 21 Jun 2023 15:40:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6F19506
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:40:56 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBF1730;
	Wed, 21 Jun 2023 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OhDuVypSV/dK9LdiPPdtSdnbSPSPgh1jOUoeh6hEOp4=;
	t=1687362033; x=1688571633; b=qK4AD1Xxn32jlrmMMB/HAIreFL9d5b/h5egkCbFHFNG0ruz
	kmByeOsdqBcP3BzUnTSa+0icEutndYkWgktqVdsjEsUEz4bktmkzShIhgPBqMjr+r2NHEPWiqlHxW
	NJ+0KYQbWpoi9PoOLBfgYGXMATVGDlpVtrINoBkEbDnanItI6CLlMbY3Y5nIqWf08gIEzGPfgrNEw
	2LThYmPQcbQa5fW+9CNxDap9Yen7ugHYXCo6w3sY3pktGHfFV3z43aJq9PTn+QNbsCtsgS1rbyfUh
	Obvw1EYFDXaJ9IXId95QTyUwQF5zTrmGXZ3DM3hS2csrGa8wOPXyvv4zM1DQYhkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qBzvq-00DkED-2Q;
	Wed, 21 Jun 2023 17:39:42 +0200
Message-ID: <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Lunn <andrew@lunn.ch>, Evan Quan <evan.quan@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch,  davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,  mario.limonciello@amd.com,
 mdaenzer@redhat.com,  maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, hdegoede@redhat.com,  jingyuwang_vip@163.com,
 lijo.lazar@amd.com, jim.cromie@gmail.com,  bellosilicio@gmail.com,
 andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,  arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 21 Jun 2023 17:39:41 +0200
In-Reply-To: <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
	 <20230621054603.1262299-2-evan.quan@amd.com>
	 <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-06-21 at 17:36 +0200, Andrew Lunn wrote:
> On Wed, Jun 21, 2023 at 01:45:56PM +0800, Evan Quan wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >=20
> > Due to electrical and mechanical constraints in certain platform design=
s
> > there may be likely interference of relatively high-powered harmonics o=
f
> > the (G-)DDR memory clocks with local radio module frequency bands used
> > by Wifi 6/6e/7.
> >=20
> > To mitigate this, AMD has introduced an ACPI based mechanism that
> > devices can use to notify active use of particular frequencies so
> > that devices can make relative internal adjustments as necessary
> > to avoid this resonance.
>=20
> Do only ACPI based systems have:
>=20
>    interference of relatively high-powered harmonics of the (G-)DDR
>    memory clocks with local radio module frequency bands used by
>    Wifi 6/6e/7."
>=20
> Could Device Tree based systems not experience this problem?

They could, of course, but they'd need some other driver to change
_something_ in the system? I don't even know what this is doing
precisely under the hood in the ACPI BIOS, perhaps it adjusts the DDR
memory clock frequency in response to WiFi using a frequency that will
cause interference with harmonics.


> > +/**
> > + * APIs needed by drivers/subsystems for contributing frequencies:
> > + * During probe, check `wbrf_supported_producer` to see if WBRF is sup=
ported.
> > + * If adding frequencies, then call `wbrf_add_exclusion` with the
> > + * start and end points specified for the frequency ranges added.
> > + * If removing frequencies, then call `wbrf_remove_exclusion` with
> > + * start and end points specified for the frequency ranges added.
> > + */
> > +bool wbrf_supported_producer(struct acpi_device *adev);
> > +int wbrf_add_exclusion(struct acpi_device *adev,
> > +		       struct wbrf_ranges_in *in);
> > +int wbrf_remove_exclusion(struct acpi_device *adev,
> > +			  struct wbrf_ranges_in *in);
>=20
> Could struct device be used here, to make the API agnostic to where
> the information is coming from? That would then allow somebody in the
> future to implement a device tree based information provider.

That does make sense, and it wouldn't even be that much harder if we
assume in a given platform there's only one provider - but once you go
beyond that these would need to call function pointers I guess? Though
that could be left for "future improvement" too.

johannes

