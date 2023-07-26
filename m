Return-Path: <netdev+bounces-21301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BF763315
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3021C211A5
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2475DBE5C;
	Wed, 26 Jul 2023 10:03:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885FBE50
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:03:34 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE9F1BEF
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=idDRzgK+CuAVwOo84T4Kfcz9Fcy1XpgH5njbuHuJvqw=; b=IPzJ1A2XZvWMYZrnXRo5MDNvMS
	9XFLUmoz0c2+XNrPFY+e2cgcPhuyZUppO8hVf9dMoOfqB8mdx5kvjhkIeTpvXDfaRTtQxvJmBk0YX
	43l3ViCyltEOjYC6WiZ3nLPp1ai7VNMAhAjr7rOT6uHu5nDMGoFy1YahM0W0nW/J4Uh9Igj5MQ/Et
	Kp0l6porWKdkWvwzfDPCcjaGV/oR9QMAh/URywzbImsb8rJAKpT4FYWw8X5If+vD0VHYYmAcoidcg
	ANMXpResOCPqyOcH2v0lKeiJr3fWSJpEQPSjzGHCiAwkOXKZpWJcvar8s5npB0qsuk6400fPTGDOF
	FeFF+JpA==;
Received: from [192.168.1.4] (port=38008 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qObMb-0008Oh-2m;
	Wed, 26 Jul 2023 12:03:25 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 26 Jul 2023 12:03:25 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<olteanv@gmail.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date: Wed, 26 Jul 2023 12:03:25 +0200
Message-ID: <20230726100325.20185-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <ZMDtDXG4Xj94F7vw@shell.armlinux.org.uk>
References: <ZMDtDXG4Xj94F7vw@shell.armlinux.org.uk>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 10:53:17 +0100, Russell King (Oracle) wrote:
> As a longer term goal, I would like to move the pcs drivers out of
> mv88e6xxx and into drivers/net/pcs, so I want to minimise the use of
> the "chip" pointer in the drivers. That's why I coded them the way I
> have, as almost entirely stand-alone implementations that make no use
> of the hardware accessors provided by the 88e6xxx core.

Understood, I will adapt the patch as you proposed.


