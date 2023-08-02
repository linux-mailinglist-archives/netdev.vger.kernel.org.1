Return-Path: <netdev+bounces-23505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5819A76C3A9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D461C2119D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 03:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC0EC6;
	Wed,  2 Aug 2023 03:45:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404F10E2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:45:51 +0000 (UTC)
Received: from clt-mbsout-02.mbs.boeing.net (clt-mbsout-02.mbs.boeing.net [130.76.144.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7419BE
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:45:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by clt-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_MBSOUT) with SMTP id 3723jkp7006069;
	Tue, 1 Aug 2023 23:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
	s=boeing-s1912; t=1690947948;
	bh=/nHf9NxBGW23Fp6Y5PeD4ZkfKtKauHk4FoBOYk3h8rM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jOIIq6oCpMXtsbn/iTX/oHR3rZwD5CuvZfL7tHu7nTwVqTTZaHgZbi9icd2eD+IU9
	 rhQISVRXeQ/aSL1+7xXeKRNWsBzyODEh7a/YZEDQj0RCxM1GGNPcw7lpzLu+lhxFvM
	 NvG+R9UcFGPsTPEhxazwVMngIiCsPtbvvzS/jqkHhV36dWaDeioOUnyKxiFJrjc4fn
	 CKnX0AbwXr+wL4SHLePDdloy3/x8SG9p+fvMoRoircMucouN4J3NEbt3WZe4NHTVz6
	 1PybXa5RIugZAmOZz6Sl1/9+osPIAfCEpNyNdIjepi89eW8vGY3cgGYQs7wtG+Iyek
	 9ysG2w56du33Q==
Received: from XCH16-09-12.nos.boeing.com (xch16-09-12.nos.boeing.com [144.115.66.161])
	by clt-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/8.15.2/UPSTREAM_MBSOUT) with ESMTPS id 3723jfVo006047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Aug 2023 23:45:41 -0400
Received: from XCH16-09-12.nos.boeing.com (144.115.66.161) by
 XCH16-09-12.nos.boeing.com (144.115.66.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 20:45:40 -0700
Received: from XCH16-09-12.nos.boeing.com ([fe80::c591:b386:9cff:58f6]) by
 XCH16-09-12.nos.boeing.com ([fe80::c591:b386:9cff:58f6%5]) with mapi id
 15.01.2507.027; Tue, 1 Aug 2023 20:45:40 -0700
From: "Hasenbosch, Samuel J" <Samuel.J.Hasenbosch@boeing.com>
To: "bugs.a.b@free.fr" <bugs.a.b@free.fr>
CC: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nikolay@nvidia.com"
	<nikolay@nvidia.com>,
        "roopa@nvidia.com" <roopa@nvidia.com>
Subject: RE: Re: [bridge]: STP: no port in blocking state despite a loop when
 in a network namespace
Thread-Topic: Re: [bridge]: STP: no port in blocking state despite a loop when
 in a network namespace
Thread-Index: AdnE8ssxH5pBaxffQ16ZpDApu/J7PwAAPX9A
Date: Wed, 2 Aug 2023 03:45:40 +0000
Message-ID: <0acf2133dc8f47d3ac40e718ab014b59@boeing.com>
References: <b1b77fe134e64bfc85394050bd40dff6@boeing.com>
In-Reply-To: <b1b77fe134e64bfc85394050bd40dff6@boeing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [137.137.12.6]
x-tm-snts-smtp: BA7F4C8CBE87D13CF4800A97BF790E4B3AA32C9E69320DE025AAE4A38B35210C2000:8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Forwarding related issue:

https://lore.kernel.org/netdev/20230711174934.3871fb61@kernel.org/T/#m4d530=
64313393cdee86f12ef9313523aa734d681

