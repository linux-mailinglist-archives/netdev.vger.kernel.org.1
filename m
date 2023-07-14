Return-Path: <netdev+bounces-17966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25060753D9D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B42E1C21330
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377F2589;
	Fri, 14 Jul 2023 14:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565A13730
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 14:37:08 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA430D8
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IVxnz3SsZvhBqdOnSCuFOolHoYJoaZMR3RVXll8Nh8g=; b=k8baPByjwgdZPzIyD9jGY0Tu05
	ZCA6U6vux/TI1np4H5a6ZQTRdHggtnETS2lqL8zGVu60apoWBlGG9Ph4VOdBzOfl/8A4uMz0ijLpe
	skcze3hB21WTVeKJAdxFNbpX6HxqEeKG23CWod3+yM9hWtFeKiRUCQbAxUWOW2wSUbAgjeTuVyAB8
	hYCEyaeTfwwGzeezAlrKuamFhmFf6r9c0TLSD0UaCAWrYwJ2LY8nOaU7flBYIB9Pbow28Trztvl01
	xxs/2xkRpL176Tk/BdgHkQPLDj4hEjJWg6+Xr/uEn5ciO38GBX/gTMp+UofmE4b+35XV1jU9GbfwQ
	iIvNwZ4A==;
Received: from [192.168.1.4] (port=23155 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qKJui-0003r6-3C;
	Fri, 14 Jul 2023 16:36:57 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 14 Jul 2023 16:36:56 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <andrew@lunn.ch>
CC: <ante.knezic@helmholz.de>, <davem@davemloft.net>, <edumazet@google.com>,
	<f.fainelli@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date: Fri, 14 Jul 2023 16:36:50 +0200
Message-ID: <20230714143650.25818-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <570d32ad-e475-4a0b-a6ee-a2bdf5f67b69@lunn.ch>
References: <570d32ad-e475-4a0b-a6ee-a2bdf5f67b69@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>> +static int mv88e6390x_serdes_erratum_3_14(struct mv88e6xxx_chip *chip)
>> +{
>> +     int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
>> +             MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
>> +             MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
>> +             MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };

>Please make this const. Otherwise you end up with two copies of it.

will do. 

>> +     int err, i;
>> +
>> +     /* 88e6390x-88e6190x errata 3.14:
>> +      * After chip reset, SERDES reconfiguration or SERDES core
>> +      * Software Reset, the SERDES lanes may not be properly aligned
>> +      * resulting in CRC errors
>> +      */
>> +
>> +     for (i = 0; i < ARRAY_SIZE(lanes); i++) {
>> +             err = mv88e6390_serdes_write(chip, lanes[i],
>> +                                          MDIO_MMD_PHYXS,
>> +                                          0xf054, 0x400C);

>Does Marvell give this register a name? If so, please add a #define.
>Are the bits in the register documented?

Unfortunately, no. This is one of those undocumented registers. I will
make a note of it in the commit message.

>> +     if (!err && up) {
>> +             if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X ||
>> +                 chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X)

>6191X? 6193X?

Errata I have available refers only to 6190x and 6390x. Not sure about other devices.

>Please sort these into numerical order.

will do.


