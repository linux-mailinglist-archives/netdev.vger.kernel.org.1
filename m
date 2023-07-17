Return-Path: <netdev+bounces-18437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD15756F18
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 23:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50312812E2
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7B107BE;
	Mon, 17 Jul 2023 21:45:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA255107BC
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 21:45:44 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0712092
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U4kgFWUiyOop9/LPOvtACRxVwU7TyfHW7ZJ/mjJUpTw=; b=GejZw6Mh5LyPzZp905mKVGYmJ6
	2OpitAH9BdPk5NMdQDenyl0DSQxYEcKUNB01FSkJNyLcRF7lll16Om5GW8Rv5lRanWwGmJYbQ4ubZ
	nPtyX7+h8DdjewA5dJK0N3uvY7IwoNCbyzEkMd8yaiTb7/Pj/1G4WE5gCuBkV1qKFha0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLW2I-001a8S-GF; Mon, 17 Jul 2023 23:45:42 +0200
Date: Mon, 17 Jul 2023 23:45:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 4/5] net: phy: c45: detect the BASE-T1 speed
 from the ability register
Message-ID: <3100d5c6-b0fd-469c-83d6-90f953b5729c@lunn.ch>
References: <20230717193350.285003-1-eichest@gmail.com>
 <20230717193350.285003-5-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717193350.285003-5-eichest@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 09:33:49PM +0200, Stefan Eichenberger wrote:
> Read the ability to do 100BASE-T1 and 1000BASE-T1 from the extended
> BASE-T1 ability register of the PHY.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

