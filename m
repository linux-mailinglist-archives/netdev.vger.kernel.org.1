Return-Path: <netdev+bounces-20667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B447606F5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 06:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D2C1C20CD5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 04:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAD85385;
	Tue, 25 Jul 2023 04:02:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC61210F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 04:02:32 +0000 (UTC)
X-Greylist: delayed 542 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 21:02:31 PDT
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FFE10C9;
	Mon, 24 Jul 2023 21:02:30 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id EDCA5A0B62;
	Tue, 25 Jul 2023 03:53:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 814C02000E;
	Tue, 25 Jul 2023 03:53:23 +0000 (UTC)
Message-ID: <213f5d2b13225f9ed4bdadda3c492ffc79940b13.camel@perches.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
From: Joe Perches <joe@perches.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, workflows@vger.kernel.org, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 MarioLimonciello <mario.limonciello@amd.com>
Date: Mon, 24 Jul 2023 20:53:21 -0700
In-Reply-To: <20230724180428.783866cc@kernel.org>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
	 <20230721062617.9810-2-boon.khai.ng@intel.com>
	 <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
	 <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
	 <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
	 <20230721185557.199fb5b8@kernel.org>
	 <c690776ce6fd247c2b2aeb805744d5779b6293ab.camel@perches.com>
	 <20230724180428.783866cc@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 37jea18epuht184zet55g6s35q97sqqu
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 814C02000E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18+FjLmqv1VbLLAJ4qTw1T9TPUMl64Yxwo=
X-HE-Tag: 1690257203-186802
X-HE-Meta: U2FsdGVkX1/GZmlbeTbRJ0aqq4uYE+tsx7zMwZMrqofshd+G8To+UWG5CRcNPI/bOYUgF1n9Mcq2FRTuPIkiDh1sA5Xs9SdGICjOtSyfYQRkUefxSqi1IaOJ3X2APXXMfgDCisj+7wc4NoHEXBKC8RIT7vwGpb/DSq9EvlrXiDQISqJjsbw3LP6t45hbR8v801SKjjeBGadgKQrEPVU+kxYqlatOY4OJEbjTxLeb3D8o5uE+hTX85oIj4OHaCg94p1kCXRlFGVhQkHGGTVT+KiuYiGmysa+744Lcq87YLsepiVYmpQlx5DEDoVILFJ9ssGq3Ao1e11FHHq9UjhNfNe1gsT7vOebAIu/Zoa+vdzKWvMCsKqMrEo6FPeW0l2K67xe/Wt9xGdLj6Qu0w84pNeonkj50/f7kPxos+ma0jhRiaZxGDV26QQcuT/m5hQZZFDooko3qdAk=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-24 at 18:04 -0700, Jakub Kicinski wrote:
> [clean up the CC list]
>=20
> On Fri, 21 Jul 2023 20:32:44 -0700 Joe Perches wrote:
> > On Fri, 2023-07-21 at 18:55 -0700, Jakub Kicinski wrote:
> > > On Fri, 21 Jul 2023 18:21:32 +0200 Krzysztof Kozlowski wrote: =20
> > > > That's not how you run it. get_maintainers.pl should be run on patc=
hes
> > > > or on all files, not just some selection. =20
> > >=20
> > > Adding Joe for visibility (I proposed to print a warning when people=
=20
> > > do this and IIRC he wasn't on board). =20
> >=20
> > What's the issue here?  Other than _how_ the script was used,
> > I don't see an actual problem with the script itself.
>=20
> I just CCed you on another case. If people keep using get_maintainers
> wrong, it *is* an issue with the script.

Silly.  No it's not.

> > I use the scripts below to send patch series where a patch series
> > are the only files in individual directories.
>=20
> The fact that most people end up wrapping get_maintainers in another
> script is also a pretty strong indication that the user experience is
> inadequate.

Not a useful argument.  Process and documentation are required.

> To be clear - I'm happy to put in the work to make the changes.
> It's just that from past experience you seem to have strong opinions
> which run counter to maintainers' needs, and I don't really enjoy
> writing Perl for the sake of it.

Does anyone?  Knock yourself out doing whatever you like.

I do suggest you instead write wrapper scripts to get
the output you want rather than updating the defaults
for the script and update the process documentation
to let other people know what do to as well.

Something akin to=A0Mario Limonciello's suggestion back in 2022:

https://lore.kernel.org/lkml/20220617183215.25917-1-mario.limonciello@amd.c=
om/


