Return-Path: <netdev+bounces-43353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D47D2AF5
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3222813D7
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65522883E;
	Mon, 23 Oct 2023 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="nIRJ+lnG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A541FAB
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:12:47 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E4D5B;
	Mon, 23 Oct 2023 00:12:45 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0A3D51C0050; Mon, 23 Oct 2023 09:12:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1698045163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWY9IhwyIhCeVdCcLJwPKSHJpNtnV6qmnh4HjGO9q7s=;
	b=nIRJ+lnGZh4xqfEGSQoJhUb5cpx+RBavjKyF3CYORizYMoQXK0RsgXM3qMKhfbZn9daw+1
	B9nMOzlZQ4XDA33mXpM93Cf/k0/IAuhv2CWpfYLzKgAD/GeUXQXbokSXiBG7Bp/CjNJqvR
	+6zuRJODzNzADmwRhy122wHuWjWRj6k=
Date: Mon, 23 Oct 2023 09:12:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: Use conduit and user terms
Message-ID: <ZTYc6l2ZpLeGRFj9@duo.ucw.cz>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
 <20231011222026.4181654-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231011222026.4181654-2-florian.fainelli@broadcom.com>

On Wed 2023-10-11 15:20:25, Florian Fainelli wrote:
> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.

Note that by making it more "inclusive" you make it incomprehensible
for users where english is not their first language.

Plus, "user" already means something else in kernel context, so this
will likely be confusing even for native speakers.

This is wrong.
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

