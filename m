Return-Path: <netdev+bounces-20876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75DF761A40
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A949E2818D7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C08B200B2;
	Tue, 25 Jul 2023 13:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D01F196
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:43:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A72116;
	Tue, 25 Jul 2023 06:43:13 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id CDCB9140DEB;
	Tue, 25 Jul 2023 13:43:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id E7B2018;
	Tue, 25 Jul 2023 13:43:07 +0000 (UTC)
Message-ID: <03ace72f8c8796e2a2f24a86e089a617daef9688.camel@perches.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
From: Joe Perches <joe@perches.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Geert Uytterhoeven
	 <geert@linux-m68k.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
  "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 workflows@vger.kernel.org,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 25 Jul 2023 06:43:06 -0700
In-Reply-To: <d2f7d5dd-cada-a3a2-2962-9c93d847f491@amd.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
	 <20230721062617.9810-2-boon.khai.ng@intel.com>
	 <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
	 <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
	 <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
	 <20230721185557.199fb5b8@kernel.org>
	 <c690776ce6fd247c2b2aeb805744d5779b6293ab.camel@perches.com>
	 <20230724180428.783866cc@kernel.org>
	 <213f5d2b13225f9ed4bdadda3c492ffc79940b13.camel@perches.com>
	 <CAMuHMdX0DpNSDRSJ7D85NGV2ri2kFHjTtXJE5aOaTD3jNoyc-w@mail.gmail.com>
	 <d2f7d5dd-cada-a3a2-2962-9c93d847f491@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E7B2018
X-Stat-Signature: oxbgr3f4rd3fg1e6zpibxmmc5ciegdj8
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18wdtKr3aNOfnNyDXaVoLwAoce/fhhlCCU=
X-HE-Tag: 1690292587-167240
X-HE-Meta: U2FsdGVkX1+Y9nPufLkIKFs6R140MyMZ6yNsuIeWyO9KUf53UnGvdhs1zPQe5xXNXlAXO3nik9YXD/E1PbCPqu/qWqHA96WR93i/1bFSFl4MpZIeaAZSknR1HPlyrbzICILGv8Sg+fTfyu2yrquE+aotMTJ9u8DH1rE/CSktb2Jz6/4TmJ8akzHSSNjpkPu5nxcnTAcOeuo2QUkHB3C3DavA62BapO5URXgQlyJCuqfkDq04TCkFz4vX+JT4vBXUojQB5z62L02msepI278WRp77mnl2fei/9scA22EKylu915veXAcmCP9Qf+rzc5poaj4UvHHir5wLS+IBOlfxp05516rsJlhH7q2W4HkqJ2XRRmXusBFkZ3qfd1rTipLWbNFy0n0dqjbcrP+ItQJYfpJjKxlTRtQhldoZgN6KoA8jT9i66I5T+DHePHD4sS36Ancg2Ws6Sqa2AmJ5cVd/1Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 08:19 -0500, Mario Limonciello wrote:
> On 7/25/23 02:33, Geert Uytterhoeven wrote:
> > Hi Joe,
> >=20
> > On Tue, Jul 25, 2023 at 6:22=E2=80=AFAM Joe Perches <joe@perches.com> w=
rote:
> > > I do suggest you instead write wrapper scripts to get
> > > the output you want rather than updating the defaults
> > > for the script and update the process documentation
> > > to let other people know what do to as well.
> > >=20
> > > Something akin to Mario Limonciello's suggestion back in 2022:
> > >=20
> > > https://lore.kernel.org/lkml/20220617183215.25917-1-mario.limonciello=
@amd.com/
> >=20
> > FTR, this is more or less what I am using to generate a script
> > to send out patches:
> >=20
> >      OUT=3D...
> >      echo git send-email \\ > $OUT
> >      # Add -cc
> >      # Wrap comment inside $(: ...)
> >      # Replace (...) in comment by [...]
> >      # Replace ] at EOL by ) again
> >      # Add continuation to EOL
> >      scripts/get_maintainer.pl $* | \
> >      tr -d \" | \
> >      sed -e 's/^/--cc "/' \
> >          -e 's/ (/" $(: /' \
> >          -e 's/ (/ [/' -e 's/)/]/' \
> >          -e 's/]$/)/' \
> >          -e 's/$/ \\/' | \
> >      tee -a $OUT
> >      echo "*[0-9][0-9][0-9][0-9]-*.*" >> $OUT
> >=20
> > After generation, I edit the script to
> >    - Replace some --cc by --to,
> >    - Add/remove some people,
> > and run "source $OUT" to send the patches...
> >=20
> > Gr{oetje,eeting}s,
>=20
> My script is great for single subsystem patches as it gets all the right=
=20
> people but I've found problems whenever it crosses multiple subsystems.
>=20
> Many subsystem owners want to see the whole series of patches to=20
> understand how they interact.  So the group of patches needs to be=20
> treated together which would need the wrapper to look at all patches=20
> instead.

Which can't really work all the time as vger has a recipient limit
and subsystem spanning patches frequently exceed that limit.

bcc's don't work well either as the reply-to chain is broken.

No great solution to that.


