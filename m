Return-Path: <netdev+bounces-18638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD5975818C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983B51C20CE1
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B511C8D;
	Tue, 18 Jul 2023 16:00:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49726FC06
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 16:00:02 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570BA9;
	Tue, 18 Jul 2023 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dJdVI+HJD2/UVgoLMR8qdH9UF1GM2w8otTeZ/dU1gw8=; b=F/Po9REBvbRL8oamvsvOjdMTa+
	/5gQ/eSypeh4nzLeD+6rPz2aNgis9Y4MDFKRVvj8E4eF1JdgRg8HW8+wjzCdn+eMSrpGhtQKyWz3z
	4/+z1JrFiJY4Yo4dfZ8dD4+4hlGo0fJQN0f9udkULxqujJf+GNpXpSZ8Opp29jtKE1hk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLn75-001dXJ-Ef; Tue, 18 Jul 2023 17:59:47 +0200
Date: Tue, 18 Jul 2023 17:59:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <61e40941-5e2b-48b5-bbc4-fdd94967aaf1@lunn.ch>
References: <20230718150133.4wpnmtks46yxg5lz@skbuf>
 <20230718152512.6848-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718152512.6848-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> I don't think so. The erratum from the patch needs to be applied on each
> SERDES reconfiguration or reset. For example, when replugging different 
> SFPs (sgmii - 10g - sgmii interface). Erratum 4_6 is done only once? 
> My guess is to put it in mv88e639x_sgmii_pcs_post_config but still I 
> need the device product number

You might be able to read the product number from the ID registers of
the SERDES, registers 2 and 3 ? That is kind of cleaner. It is the
SERDES which needs the workaround, so look at the SERDES ID ...

- maybe embedding a pointer to the 
> mv88e6xxx_chip chip inside the mv88e639x_pcs struct would be the cleanest way.
 
That would also work.

     Andrew

