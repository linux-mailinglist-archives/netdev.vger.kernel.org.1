Return-Path: <netdev+bounces-20954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E543761FFF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDA528186E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1BE25905;
	Tue, 25 Jul 2023 17:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E125178
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:20:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1101985
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g/8zDm/q6wlNOdte5Q1VkwxnSY3fBL8TU7tF5M1maUk=; b=yeBEbK4B4yRt7bzP+AkKwmHBsC
	rzYlYz2Lz8k1ykcrCBXYUu/yux+SCocyHG+KnZTj5bBB4gMmuggOzW4k9fViekXyKt0LlOZ4BlBkC
	udUzsyhvTuWurQNOd7pIF12CJetww4RWcdAS8b3qEsiK00cEdBb1+B/SI/XuyVwPAQ5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOLha-002I8q-A0; Tue, 25 Jul 2023 19:20:02 +0200
Date: Tue, 25 Jul 2023 19:20:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
	dongbiao@loongson.cn, loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [RFC PATCH 01/10] net: phy: Add driver for Loongson PHY
Message-ID: <5976e7c6-42ec-4ab7-9f8e-27568bd0dc73@lunn.ch>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
 <9e0b3466-10e1-4267-ab9b-d9f8149b6b6b@lunn.ch>
 <CACWXhKkX-syR01opOky=t-b8C3nhV5f_WNfCQ-kOE+4o0xh4tA@mail.gmail.com>
 <3cff46b0-5621-4881-8e70-362bb7a70ed1@lunn.ch>
 <CACWXhKk23muXROj6OrmeFna88ViJHA_7QpQZoWiFgzEPb4pLWQ@mail.gmail.com>
 <9568c4ad-e10f-4b76-8766-ec621f788c40@lunn.ch>
 <CACWXhKkoJHT8HNb-h_1PJTT1rE-TQxByd98qS0Zka5yg2_WsXw@mail.gmail.com>
 <24d49ab1-c2e4-4878-a4f6-8d1f405f2407@lunn.ch>
 <CACWXhKmwjXb_71hmGfKh7NCC3iAhFTB1uEVhY0qq8kz24o3TYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACWXhKmwjXb_71hmGfKh7NCC3iAhFTB1uEVhY0qq8kz24o3TYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> This PHY driver was designed to solve two problems at first:
> 1. We cannot force 1000.
> 2. We cannot use half duplex.
> 
> Now, we are sure that the MAC is broken, not the PHY, so I think we
> can solve these problems in the MAC driver.

You can solve both of these in the MAC. You can remove the half duplex
link modes after the PHY is connected to the MAC. And you can add a
test in ksetting_set to check for 1000 Force and return EOPNOTSUPP.

     Andrew

