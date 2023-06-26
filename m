Return-Path: <netdev+bounces-13993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A0773E444
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2247E280D03
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D8DDDD8;
	Mon, 26 Jun 2023 16:10:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D91D525
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:10:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C261A2
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:10:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-190-znHz0X3HMcKVclPaaTyJRg-1; Mon, 26 Jun 2023 17:10:06 +0100
X-MC-Unique: znHz0X3HMcKVclPaaTyJRg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Jun
 2023 17:10:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 26 Jun 2023 17:10:05 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'kernel test robot' <lkp@intel.com>, You Kangren <youkangren@vivo.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "Adam
 Guerin" <adam.guerin@intel.com>, Wojciech Ziemba <wojciech.ziemba@intel.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>, Damian Muszynski
	<damian.muszynski@intel.com>, Srinivas Kerekare
	<srinivas.kerekare@intel.com>, "open list:QAT DRIVER" <qat-linux@intel.com>,
	"open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH] crypto: qat - Replace the if statement with min()
Thread-Topic: [PATCH] crypto: qat - Replace the if statement with min()
Thread-Index: AQHZqDgnNJK5CqqW/0m8bCwEEBu4Za+dQI0w
Date: Mon, 26 Jun 2023 16:10:05 +0000
Message-ID: <cac421069f384432a66c50701655f445@AcuMS.aculab.com>
References: <20230626091541.1064-1-youkangren@vivo.com>
 <202306262110.NCIrjtZF-lkp@intel.com>
In-Reply-To: <202306262110.NCIrjtZF-lkp@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: kernel test robot
> Sent: 26 June 2023 15:11
>=20
> Hi You,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on herbert-cryptodev-2.6/master]
> [also build test WARNING on herbert-crypto-2.6/master linus/master v6.4 n=
ext-20230626]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
...
> >> drivers/crypto/intel/qat/qat_common/qat_uclo.c:1989:12: warning: compa=
rison of distinct pointer
> types ('typeof (words_num) *' (aka 'unsigned int *') and 'typeof (1024) *=
' (aka 'int *')) [-Wcompare-
> distinct-pointer-types]
>                    cpylen =3D min(words_num, UWORD_CPYBUF_SIZE);
>                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

UWORD_CPYBUF_SIZE needs to be defined as an unsigned constant.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


