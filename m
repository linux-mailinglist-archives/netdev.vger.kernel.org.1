Return-Path: <netdev+bounces-27400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243B877BD27
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA228115F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29CC2DD;
	Mon, 14 Aug 2023 15:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83821C154
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:35:42 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944BBC5
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:35:41 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-0QcCinrKNLmPciCBeNQiZw-1; Mon, 14 Aug 2023 11:35:37 -0400
X-MC-Unique: 0QcCinrKNLmPciCBeNQiZw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE7A81C07583;
	Mon, 14 Aug 2023 15:35:36 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA80C4021B9;
	Mon, 14 Aug 2023 15:35:34 +0000 (UTC)
Date: Mon, 14 Aug 2023 17:35:33 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 2/5] net: phy: remove MACSEC guard
Message-ID: <ZNpJxca6SE4Mii2L@hog>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-3-radu-nicolae.pirea@oss.nxp.com>
 <056a153c-19d7-41bb-ac26-04410a2d0dc4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <056a153c-19d7-41bb-ac26-04410a2d0dc4@lunn.ch>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-08-11, 18:59:57 +0200, Andrew Lunn wrote:
> On Fri, Aug 11, 2023 at 06:32:46PM +0300, Radu Pirea (NXP OSS) wrote:
> > Allow the phy driver to build the MACSEC support even if
> > CONFIG_MACSEC=N.
> 
> What is missing from this commit message is an answer to the question
> 'Why?'

The same question applies to patch #1. Why would we need a dummy
implementation of macsec_pn_wrapped when !CONFIG_MACSEC?

I guess it's to avoid conditional compilation of
drivers/net/phy/nxp-c45-tja11xx-macsec.c and a few ifdefs in the main
driver.

-- 
Sabrina


