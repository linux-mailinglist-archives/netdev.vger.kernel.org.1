Return-Path: <netdev+bounces-12853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62F3739269
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810AF2816C6
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466F1D2CA;
	Wed, 21 Jun 2023 22:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AE1C766
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 22:20:05 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FD1733;
	Wed, 21 Jun 2023 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cP+HR2GmRZPnSeQ8lcOfEZ7k5nuBFTrLSVTHUrZopt8=;
	t=1687386003; x=1688595603; b=BadH4QmJO0jxGMFzOXm+RhV89LkXMjHB0hoOxRuGYgfUbzG
	av+OdABdyK0I8912nMNYGlYwCqnM5nK3D7OnE2Qn0pqjI8TbUYgx9TtG/GJLmdFtPmKjqECxvno7T
	NNETC/vZErGTR5zfyAJx7alhIxudK0fjArwjPUTUhT3sPZcWuuSVSpFf4oGsHU4SjN5pz59oK9Ufp
	NQv9gDn72dULGVVJ6Olmr3YDQDGHgNE7aFtmrQ6RG4NeguZ8GQVcbHmfcUNfLe+LZLSx//XTFJd4C
	3f7V/Eyjmbj7EzROJn1nZWV+LGNP1O90ZLURxRQzYrp1OqAQcN3uSLVY7E/tzxzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qC6AD-00Duer-15;
	Thu, 22 Jun 2023 00:18:58 +0200
Message-ID: <3e337dc0482e16e2aaa4090b613dc8dea7803fa8.camel@sipsolutions.net>
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Lunn <andrew@lunn.ch>, "Limonciello, Mario"
	 <mario.limonciello@amd.com>
Cc: Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
 airlied@gmail.com, daniel@ffwll.ch, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, pabeni@redhat.com,
 mdaenzer@redhat.com,  maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, hdegoede@redhat.com,  jingyuwang_vip@163.com,
 lijo.lazar@amd.com, jim.cromie@gmail.com,  bellosilicio@gmail.com,
 andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,  arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 22 Jun 2023 00:18:53 +0200
In-Reply-To: <08dd8d17-6825-4e53-8441-85c709326f48@lunn.ch>
References: <20230621054603.1262299-2-evan.quan@amd.com>
	 <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
	 <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
	 <b1abec47-04df-4481-d680-43c5ff3cbb48@amd.com>
	 <36902dda-9e51-41b3-b5fc-c641edf6f1fb@lunn.ch>
	 <33d80292-e639-91d0-4d0f-3ed973f89e14@amd.com>
	 <9159c3a5-390f-4403-854d-9b5e87b58d8c@lunn.ch>
	 <a80c215a-c1d9-4c76-d4a8-9b5fd320a2b1@amd.com>
	 <8d3340de-34f6-47ad-8024-f6f5ecd9c4bb@lunn.ch>
	 <07ad6860-8ffb-cc6c-a8e5-e8dc4db4e87a@amd.com>
	 <08dd8d17-6825-4e53-8441-85c709326f48@lunn.ch>
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

On Wed, 2023-06-21 at 21:25 +0200, Andrew Lunn wrote:
> > ACPI core does has notifiers that are used, but they don't work the sam=
e.
> > If you look at patch 4, you'll see amdgpu registers and unregisters usi=
ng
> > both
> >=20
> > acpi_install_notify_handler()
> > and
> > acpi_remove_notify_handler()
> >=20
> > If we supported both ACPI notifications and non-ACPI notifications
> > all consumers would have to have support to register and use both types=
.
>=20
> Why would you want to support ACPI notifications and non-ACPI
> notifications? All you need is wbrf notification.
>=20
> The new wbrf.c should implement wbrf_install_notify_handler() and
> wbrf_remove_notify_handler().
>=20
> As to where to put wbrf.c? I guess either drivers/base/ or
> drivers/wbrf/. Maybe ask GregKH?

Not sure it should even be called WBRF at that point, but hey :)

Honestly I'm not sure though we need this complexity right now? I mean,
it'd be really easy to replace the calls in mac80211 with some other
more generalised calls in the future?

You need some really deep platform/hardware level knowledge and
involvement to do this, so I don't think it's something that someone
will come up with very easily for a DT-based platform...

If we do something with a notifier chain in the future, we can just
install one in the ACPI code too, and react indirectly rather than
calling from wifi to the ACPI directly.

johannes

