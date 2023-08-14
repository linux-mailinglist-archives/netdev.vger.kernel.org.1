Return-Path: <netdev+bounces-27287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA6277B5DF
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4EE1C20A53
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91056AD39;
	Mon, 14 Aug 2023 10:03:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D20A955
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 10:03:11 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26713D8;
	Mon, 14 Aug 2023 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J2KANedUadXaYMFYELF3QAJcmMwnPhF0mdoeDT4tKH0=;
	t=1692007389; x=1693216989; b=hHkReWAbt42IF9MXIeAefNGCuOXVvNDK4LSEmciBDTE4Ibk
	ckDvGhPxakp2EOkDMSYS2LR40erpszugfpCu4pju+N8+Clm9irU4AKb77iucaLr0oOVdk63io9HIj
	X/qKrpXi7nDiC3pc2cqiAEtnEdwa/49R827X+jrrRlajHzdM7HePOWabNcFl2145CoTbbTrjbAgTl
	MTIwbzDFO08U6yYDgJl5p+eKWswcMt1nHVAoJiD5CEyGgm+C7YikaMVlJX77+qxban0J9oWPjr9xs
	vnrcMm4xfzpdDycj+Tafj+OfwhCgazJJcs1wSJFB5MOjixCK6t67MXyxobio2ADg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qVUP9-006dCg-23;
	Mon, 14 Aug 2023 12:02:31 +0200
Message-ID: <cabc7d0326e1169570eafdecef8df56369b4300b.camel@sipsolutions.net>
Subject: Re: [PATCH V7 4/9] wifi: mac80211: Add support for ACPI WBRF
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Lunn <andrew@lunn.ch>, Mario Limonciello
 <mario.limonciello@amd.com>
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "rafael@kernel.org"
 <rafael@kernel.org>,  "lenb@kernel.org" <lenb@kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,  "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>,  "daniel@ffwll.ch"
 <daniel@ffwll.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "mdaenzer@redhat.com" <mdaenzer@redhat.com>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,  "hdegoede@redhat.com"
 <hdegoede@redhat.com>, "jingyuwang_vip@163.com" <jingyuwang_vip@163.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "jim.cromie@gmail.com"
 <jim.cromie@gmail.com>, "bellosilicio@gmail.com" <bellosilicio@gmail.com>,
 "andrealmeid@igalia.com" <andrealmeid@igalia.com>,  "trix@redhat.com"
 <trix@redhat.com>, "jsg@jsg.id.au" <jsg@jsg.id.au>, "arnd@arndb.de"
 <arnd@arndb.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Date: Mon, 14 Aug 2023 12:02:29 +0200
In-Reply-To: <5e92b45a-d99b-4a8a-9987-46c75a5fcb3c@lunn.ch>
References: <20230719090020.2716892-1-evan.quan@amd.com>
	 <20230719090020.2716892-5-evan.quan@amd.com>
	 <9b1f45f9-02a3-4c03-b9d5-cc3b9ab3a058@lunn.ch>
	 <7d059aed-fac0-cdcd-63d5-58185bb345db@amd.com>
	 <DM6PR12MB26196A993B3BA93392AA0FEDE403A@DM6PR12MB2619.namprd12.prod.outlook.com>
	 <d4cfbbae-9cd0-4767-8c80-ec09d1dbaf9c@lunn.ch>
	 <6aa9061b-1702-b8f2-9cb8-982895b9def4@amd.com>
	 <5e92b45a-d99b-4a8a-9987-46c75a5fcb3c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 22:09 +0200, Andrew Lunn wrote:
>=20
>=20
> It could well be that AMD based machine has a different ACPI extension
> to indicate this policy to what Intel machine has. As far as i
> understand it, you have not submitted this yet for formal approval,
> this is all vendor specific, so Intel could do it completely
> differently.

Already do, without the host software being involved in the same way.
There, I believe the ACPI tables just indicate what's needed and the
WiFi firmware sorts out the rest.

johannes

