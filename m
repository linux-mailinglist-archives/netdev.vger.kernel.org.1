Return-Path: <netdev+bounces-31850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E694790D3C
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 19:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8871C20446
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ABE567D;
	Sun,  3 Sep 2023 17:24:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2123AA
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 17:24:01 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC0DD;
	Sun,  3 Sep 2023 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AYrmWvrywzU6XzsiQz3YKxMoTYo13x83URdEgOb+5hI=; b=vUfBwyLnvb/dJD4Nf1mqMusk56
	XV+xAv+Xi0f94nHq7bHctoU0JF5Mgm6LxaECOqDJh886W4DnBhtAyPVjGu/semR41wJDAFJjsfmXi
	MpY3XFsAxSTLEBo6xAP6T+L0vMYpKvGaoJGYzSTr5AGiGQnY5SzSn1Qvg6xKTbRLWOlQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qcqpD-005gyX-7b; Sun, 03 Sep 2023 19:23:51 +0200
Date: Sun, 3 Sep 2023 19:23:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] net: dsa: hsr: Enable HSR HW offloading for
 KSZ9477
Message-ID: <3e8975fa-5e10-45d7-b46d-982540fc297e@lunn.ch>
References: <20230831111827.548118-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111827.548118-1-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 01:18:23PM +0200, Lukasz Majewski wrote:
> This patch series provides support for HSR HW offloading in KSZ9477
> switch IC.
> 
> To test this feature:
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ifconfig lan1 up;ifconfig lan2 up
> ifconfig hsr0 192.168.0.1 up

nit pick: ifconfig is deprecated. ip link set lan1 up, etc...

	Andrew

