Return-Path: <netdev+bounces-21054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B68762414
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253FD1C20FF2
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC426B6F;
	Tue, 25 Jul 2023 21:04:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9F25936
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:04:28 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69354E3;
	Tue, 25 Jul 2023 14:04:27 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 2074F140EEE;
	Tue, 25 Jul 2023 21:04:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id D02C320025;
	Tue, 25 Jul 2023 21:04:21 +0000 (UTC)
Message-ID: <27446992c6fcc982a26085151988f7be3aa1e3d7.camel@perches.com>
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
From: Joe Perches <joe@perches.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com,  netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Jul 2023 14:04:20 -0700
In-Reply-To: <20230725125601.7ec04aa5@kernel.org>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
	 <20230724160214.424573ac@kernel.org>
	 <63d69a72.e2656.1898a66ca22.Coremail.linma@zju.edu.cn>
	 <20230724175612.0649ef67@kernel.org>
	 <d02a90c5ca1475c27e06d3d592bac89ab17b37ea.camel@perches.com>
	 <20230725123842.546045f1@kernel.org>
	 <4ce3c7a980be3ce9012ba02a5d9d4285cdf4fd07.camel@perches.com>
	 <20230725125601.7ec04aa5@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: npphdcb6o1xt7dirfqjttg8pcz5oi8tx
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: D02C320025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19edhjucITOZNxGaHNgPF8dnt2qV7nJGAY=
X-HE-Tag: 1690319061-31213
X-HE-Meta: U2FsdGVkX18KZrCWQEg3rXO6V8qyzoOYddB2+v5JJF+iebXEdolTvXazmweMGU81DZgniu1ckllN+InUEiomf3MJ+syYj5wyBrq5DxrJRD8ViLYWfN5kkhhwZPaS49ksU8X5NE30uTbL75CXi5/YjsQdeB9LCB0TE0vqfKRn6fe3JEd5TddiqlqZMhBz1c6xAm4Zr35dGjhQWPwfM++3RUrq5UT6AssZQsVHC5QM1cD1Zivo22hB51siXvr/sg+HvwtZ+NPPuhi6fBji3mzdW0F2BJQPsHmlNHTZDz2FKc8uUqIsVvadNaYiU6Wptosm
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 12:56 -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 12:50:00 -0700 Joe Perches wrote:
> > > > What do you think the "case" is here?
> > > >=20
> > > > Do you think John Fastabend, who hasn't touched the file in 7+ year=
s
> > > > should be cc'd?  Why? =20
> > >=20
> > > Nope. The author of the patch under Fixes. =20
> >=20
> > It adds that already since 2019.
>=20
> Which is awesome! But for that to work you have to run get_maintainer
> on the patchfile not the file paths. Lin Ma used:
>=20
>   # ./scripts/get_maintainer.pl net/sched/sch_mqprio.c
>=20
> That's what I keep complaining about. People run get_maintainer on
> paths and miss out on all the get_maintainer features which need=20
> to see the commit message.

Which is useful when editing a file but not when sending
a patch.  get_maintainer does _both_.

Again, there's no issue with get_maintainer, but there is
in its use.  If there's a real issue, it's with people
and their knowledge of process documentation.

It's _not_ the tool itself as you stated.


