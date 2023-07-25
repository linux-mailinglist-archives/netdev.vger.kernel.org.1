Return-Path: <netdev+bounces-21053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8EC762410
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CAA2819CC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C8C26B6D;
	Tue, 25 Jul 2023 21:01:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD526B65
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:01:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B9B99;
	Tue, 25 Jul 2023 14:01:50 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1AD7180D6C;
	Tue, 25 Jul 2023 21:01:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 8B3EC6000B;
	Tue, 25 Jul 2023 21:01:45 +0000 (UTC)
Message-ID: <71070489e9fb57c341cea569042f837ce7c7ec9d.camel@perches.com>
Subject: Re: [PATCH] scripts: checkpatch: steer people away from using file
 paths
From: Joe Perches <joe@perches.com>
To: Jakub Kicinski <kuba@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: krzk@kernel.org, geert@linux-m68k.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Date: Tue, 25 Jul 2023 14:01:44 -0700
In-Reply-To: <20230725125207.73387bfc@kernel.org>
References: <b6ab3c25-eab8-5573-f6e5-8415222439cd@kernel.org>
	 <20230725155926.2775416-1-kuba@kernel.org>
	 <2023072555-stamina-hurray-b95c@gregkh>
	 <20230725101051.7287d7cf@kernel.org>
	 <2023072507-smugness-landslide-bd42@gregkh>
	 <20230725125207.73387bfc@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: y1u5u7ho4z8za3orkerpag88w5moqbhr
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 8B3EC6000B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19SYY1iThJ9rriAeSw3Esw43greG2YvKp8=
X-HE-Tag: 1690318905-503073
X-HE-Meta: U2FsdGVkX1940WfeGFQ3BuInvLpFaBTGC+8MpTuRyFt+50yWqolcLjiS6J69qNMoiRX+ZClvWfzH7Z5S6TgcOrniS8qN5MYSoSV3acVL1w5BxODFy+/JpavrwKlazvFM97iseS2o9UEUf1XeSk5db1xgOb9HVIyXI7OY5F0aZwRwy6CzvuAvdCSIK+/6Yi8TyxNUS1ywzIqWwzW1RjNdBS34Dlh10HE/DzG8bEbG06HF1ojgjFjtWES6H3xxomEbh/+IP7LVmqDSXfXafugzlUODnqxFzuF++nM50JgV/NRd5L/j0z9cUsukz2/LHPf3yieeHQD0pYrUWMvJ9mq56W3zcc2eovvMjc/nD4dUOo7mrYI5kCmDru1nr47AaSph
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 12:52 -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 19:25:09 +0200 Greg KH wrote:
> > I do:
> > 	- git format-patch to generate the patch series.
> > 	- run the generate_cc_list script which creates XXXX.info files
> > 	  (the XXXX being the patch number) that contain the
> > 	  people/lists to cc: on the patch
> > 	- git rebase -i on the patch series and edit the changelog
> > 	  description and paste in the XXXX.info file for that specific
> > 	  patch.
> >=20
> > Yeah, it's a lot of manual steps, I should use b4 for it, one of these
> > days...
>=20
> Oh, neat! I do a similar thing. Modulo the number of steps:
>=20
>   git rebase --exec './ccer.py --inline'
>=20
> I was wondering if I was the only one who pastes the Cc: person
> into the patch, because I'd love to teach get_maintainer to do
> the --inline thing, instead of carrying my own wrapper...

Now for that, you'd want checkpatch or yet another script to do it.



