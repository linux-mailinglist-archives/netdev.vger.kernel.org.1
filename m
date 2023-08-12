Return-Path: <netdev+bounces-27049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F64177A06A
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B15281028
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B90379C7;
	Sat, 12 Aug 2023 14:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F06FCC
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 14:23:37 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006E91BD9;
	Sat, 12 Aug 2023 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mGhCfsKTCAw17aBN83mrqCXe0PHdInRyBw5uFZzJqIU=; b=zTNtCKKGn0ciVKvFl1HBaqBG1P
	3YbdMBpq5OegOytW6hGLi8WBDl2dsvC0u4zh1VUidPpbeKGAkmkF07Q7Dwff9p+/Bc1NqH/v1HqIf
	dFWOZRsXdO3NA+wVa27O1OIYnJ7gmMruz8PoWHfMbwGXbiKZl+UrOWXq9c0AzvvuQzmQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qUpWb-003ujp-3N; Sat, 12 Aug 2023 16:23:29 +0200
Date: Sat, 12 Aug 2023 16:23:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: broadcom: stub c45 read/write for 54810
Message-ID: <c72196bc-eda0-4af7-8b7f-1b985420b59b@lunn.ch>
References: <1691796578-846-1-git-send-email-justin.chen@broadcom.com>
 <87e4f794-669f-8d43-793c-b8c1878cbd15@broadcom.com>
 <CALSSxFbo1jbNyxF-imfd32wsKC+Z6U2F_qL-iXeXbmrLVp=HRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALSSxFbo1jbNyxF-imfd32wsKC+Z6U2F_qL-iXeXbmrLVp=HRA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Hmm agreed EOPNOTSUPP seems better here.

I was thinking the same.

  Andrew

