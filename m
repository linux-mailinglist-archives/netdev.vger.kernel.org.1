Return-Path: <netdev+bounces-18917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF21575913A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B86C1C20E23
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FFC111BC;
	Wed, 19 Jul 2023 09:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67277111BB
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:10:33 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927EA4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AoKJ8U7zqgVLphnsB4DDPWwdoD7ZYEsS9sz4gBR8PlI=; b=CKdWhiEg60VtAnvu47b7MGXSYp
	uHHwTIOppHcxfnwHNX4UeDrqOhLBdxhT83ThPa6NlJGWxGH5+sfKIUNz546s+30fEgyPV7rmXwpb7
	0EF9GH3OcPRHWCutME47EFxm724L4uAqN7AzTrirM4/dJqUKHyDoduqczvRDZBKj+iBtjv89rUbtQ
	af7NQYmbqNFoaJUP1NUQx1ss+Mj4YFTj/VjfPpMdw/g8lBpiYiwB+3Xabq4WugFEXNXtAjDgEFwu6
	guNlDeHkWIAnE1at3weA/dNCvVHp8aQdF4hgj9IUFTLqvHeDcfPHjqUubMFYCZqNiNYruvsGxGNpS
	fSRU/0tQ==;
Received: from [192.168.1.4] (port=15906 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qM3CS-0001FJ-2d;
	Wed, 19 Jul 2023 11:10:24 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 19 Jul 2023 11:10:24 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <andrew@lunn.ch>
CC: <ante.knezic@helmholz.de>, <davem@davemloft.net>, <edumazet@google.com>,
	<f.fainelli@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date: Wed, 19 Jul 2023 11:10:24 +0200
Message-ID: <20230719091024.21693-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <61e40941-5e2b-48b5-bbc4-fdd94967aaf1@lunn.ch>
References: <61e40941-5e2b-48b5-bbc4-fdd94967aaf1@lunn.ch>
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

> > I don't think so. The erratum from the patch needs to be applied on each
> > SERDES reconfiguration or reset. For example, when replugging different 
> > SFPs (sgmii - 10g - sgmii interface). Erratum 4_6 is done only once? 
> > My guess is to put it in mv88e639x_sgmii_pcs_post_config but still I 
> > need the device product number
> 
> You might be able to read the product number from the ID registers of
> the SERDES, registers 2 and 3 ? That is kind of cleaner. It is the
> SERDES which needs the workaround, so look at the SERDES ID ...
> 
> > maybe embedding a pointer to the 
> > mv88e6xxx_chip chip inside the mv88e639x_pcs struct would be the cleanest way.
>  
>  That would also work.

Correct me if I am wrong but I think we still need the chip ptr as pcs interface
provides access only to SERDES registers. If you are refering to "PHY IDENTIFIER"
registers (Page 0, Register 2,3), we need something like mv88e6xxx_port_read
unless we want to do some direct mdio magic?

