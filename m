Return-Path: <netdev+bounces-32830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C2079A82F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B63428110A
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55FF9FC;
	Mon, 11 Sep 2023 13:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6B291E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:11:17 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED5E9;
	Mon, 11 Sep 2023 06:11:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F5A21C001B;
	Mon, 11 Sep 2023 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694437874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeifM5Ih+521Ky4D24H4As0XME/ed4hRcIxhZQ8/dgE=;
	b=IOKTk7Bo1joFyMSyQQe9dQCAEqfFrfp5mky8/tCsgjXhAwX1NbApy3lWmjMyKfVf8RCZCQ
	CGIYWseGm0QD9rNS7e6zmaXdHsMZgAEAGru4DdTxlIuSyCrIkYym91+tdOLpve2xjcxxNK
	nGdKKh/H62C05+iTtX52jI8yJ5iB4512pF9LLsT7DZsfmAWsZVXAFwRFV94BRbiyyhoHZe
	oySapmD0ydh9xZB4RfJUU1PdKO7FE75sRYd9zH3Gmyhr141wVtO6tKZKX2b5WFpmoiWsLc
	v8EhHsisx91O2t8iRBxtRWQEZu643cdSQB/2Rcb7qDoGHdflI3izj+UrHwFv0w==
Date: Mon, 11 Sep 2023 15:09:31 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Oleksij Rempel <linux@rempel-privat.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Message-ID: <20230911150931.2832b266@fedora>
In-Reply-To: <20230908084108.36d0e23c@kernel.org>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<20230908084108.36d0e23c@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Jakub

On Fri, 8 Sep 2023 08:41:08 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu,  7 Sep 2023 11:23:58 +0200 Maxime Chevallier wrote:
> >  - the netlink API would need polishing, I struggle a bit with finding
> >    the correct netlink design pattern to return variale-length list of u32.  
> 
> Think of them as a list, not an array.
> 
> Dump them one by one, don't try to wrap them in any way:
> https://docs.kernel.org/next/userspace-api/netlink/specs.html#multi-attr-arrays
> People have tried other things in the past:
> https://docs.kernel.org/next/userspace-api/netlink/genetlink-legacy.html#attribute-type-nests
> but in the end they add constraints and pain for little benefit.

Thanks for the pointers, this makes much more sense than my attempt at
creating an array.

This and your other comment on the .do vs .dump is exactly what I was
missing in my understanding of netlink.

Maxime

