Return-Path: <netdev+bounces-21015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4DE7622A4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CC6281A08
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC7126B09;
	Tue, 25 Jul 2023 19:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09DF2516D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:50:09 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF3710D4;
	Tue, 25 Jul 2023 12:50:08 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 92CE3C0F0F;
	Tue, 25 Jul 2023 19:50:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 6D7F52002A;
	Tue, 25 Jul 2023 19:50:01 +0000 (UTC)
Message-ID: <4ce3c7a980be3ce9012ba02a5d9d4285cdf4fd07.camel@perches.com>
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
From: Joe Perches <joe@perches.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com,  netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Jul 2023 12:50:00 -0700
In-Reply-To: <20230725123842.546045f1@kernel.org>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
	 <20230724160214.424573ac@kernel.org>
	 <63d69a72.e2656.1898a66ca22.Coremail.linma@zju.edu.cn>
	 <20230724175612.0649ef67@kernel.org>
	 <d02a90c5ca1475c27e06d3d592bac89ab17b37ea.camel@perches.com>
	 <20230725123842.546045f1@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6D7F52002A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: iafnjui4t1dsw8jioq5af4htufncp3q4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/1BwcFPMc+exIE8tEWXVMCn8VrkCjkOTc=
X-HE-Tag: 1690314601-210224
X-HE-Meta: U2FsdGVkX1/hJEPKF2zr3TJgtWEyLqffK/2NfpekyNdd1d2qPBSjNPF3zb/rolffaxdixAJchpDFZMz6ez43RrK2pcoLUdXJwfWmA3omsXsKY8hZcPV90QuT81iUJziDwfj+9MTNCMk5RD7EmN7QBAkC59majWbDNr55FxvrBhzaRiGJR4ZBo1eL8ESRle1EDGuRr/mc171zFMBT+HGuvp2Vh+JOrqAEOj3VqkonXb8rCD7Jk8UDmx24njhpVn/yz/U+tkb2YBy75Ylk0kumbY1I4+amn7O+ZDkLUcgzS2UOuMGcqQwZipwBsnXqxOs7hxF63acs4rRt2TzSCYQ6zyFjDUh6Y3vKR2+yLqSRGXbR8+NSFZixcHvIY2FPysOZ
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 12:38 -0700, Jakub Kicinski wrote:
> On Mon, 24 Jul 2023 20:59:53 -0700 Joe Perches wrote:
> > > Joe, here's another case. =20
> >=20
> > What do you think the "case" is here?
> >=20
> > Do you think John Fastabend, who hasn't touched the file in 7+ years
> > should be cc'd?  Why?
>=20
> Nope. The author of the patch under Fixes.

It adds that already since 2019.

commit 2f5bd343694ed53b3abc4a616ce975505271afe7
Author: Joe Perches <joe@perches.com>
Date:   Wed Dec 4 16:50:29 2019 -0800

    scripts/get_maintainer.pl: add signatures from Fixes: <badcommit> lines=
 in commit message
   =20
    A Fixes: lines in a commit message generally indicate that a previous
    commit was inadequate for whatever reason.
   =20
    The signers of the previous inadequate commit should also be cc'd on
    this new commit so update get_maintainer to find the old commit and add
    the original signers.
   =20


