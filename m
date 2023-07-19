Return-Path: <netdev+bounces-19013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB2E759526
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1BD281821
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06C12B9E;
	Wed, 19 Jul 2023 12:32:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1114AA0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:32:17 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D49136
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1z4UMtFUS+UMq9pCbej0PTan3ZjiLdHvyY77ZjGpLQE=; b=ZDAdE0ZDjk9+g9wDhOb4YushFa
	FqFmcKw7APWOqanWS0Wp50YoI2mPE7XSoouKkWvsTozvTGpmxMqd3C36xHEs9kFSppVo++osxQhL9
	EjcqqYsqVjCGiXsOQW4n8wB2HLNXHxjounl5rueoGd0DVDCtCMViL6FGqmJpIhUaZ9E6jg/LdETSs
	WIzu+BFGQatHr1nBEyRFcQoRxq6sehna+jGkS92Q3vY2H4aZQw10OroLBsj8c5dGX4g/irU3IC37F
	LOUPRn9rL6bxkmDJ9OfF9KCGjQ9c9GIlErf9Khphp8z8EGRA7+aX5h96tthWP4mzIzYbP6jotZOr0
	/C83G/QA==;
Received: from [192.168.1.4] (port=34992 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qM6Lb-0003nx-18;
	Wed, 19 Jul 2023 14:32:03 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 19 Jul 2023 14:32:02 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <ante.knezic@helmholz.de>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<f.fainelli@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date: Wed, 19 Jul 2023 14:31:59 +0200
Message-ID: <20230719123159.7099-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20230719090853.21509-1-ante.knezic@helmholz.de>
References: <20230719090853.21509-1-ante.knezic@helmholz.de>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > It needs to be implemented exactly as posted here? After mv88e6390_serdes_power()
> > is called on any port/lane, mv88e6390x_serdes_erratum_3_14() needs to run
> > for all lanes? That might be a problem.
> 
> Actually, I tested applying erratum only on requested lane in pcs_post_config and
> it seems to work out fine, so we might use something like:
> static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
> {
> 	int err;
> 
> 	/* 88e6190x and 88e6390x errata 3.14:
> 	 * After chip reset, SERDES reconfiguration or SERDES core
> 	 * Software Reset, the SERDES lanes may not be properly aligned
> 	 * resulting in CRC errors
> 	 */
> 
> 	err = mdiodev_c45_write(&mpcs->mdio, MDIO_MMD_PHYXS,
> 					 0xf054, 0x400C);
> 	if (err)
> 	        return err;
> 
> 	err = mdiodev_c45_write(&mpcs->mdio, MDIO_MMD_PHYXS,
> 				 0xf054, 0x4000);
> 	if (err)
> 	        return err;
> 
> 	return 0;
> }

Unfortunatelly, above statement is not correct. I managed to occasionally replicate
the issue when applying erratum on requested lane only. This happens on occasion
only but it looks like we need to apply erratum on all serdes lanes to ensure 
proper operation.
The Errata document falls short on this detail and does not clearly state whether all 
or only specific lanes need to be written to.


