Return-Path: <netdev+bounces-26149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FBA777028
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF955281EED
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACAC1110;
	Thu, 10 Aug 2023 06:17:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF671100
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:17:55 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82374D2;
	Wed,  9 Aug 2023 23:17:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B87F5FF806;
	Thu, 10 Aug 2023 06:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1691648271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCIldS7LgLkPH6J7rOrlaq8d6ZCqBahmrHWXhqMCqrQ=;
	b=Jo6v7fsauFxEg0pgDs7l0RyOUOqAr1TIKTgcHJZmAD8dsHY0cAKbYXbcXKj5t/V+1feTy1
	ZHeivWFlH8RBiM/9sCPF+vzuQBeIBuL40kfYZdiHUuVAS98ocnGZzFY+7vPD/huMvuql6U
	A3iXMVmAB6X7Phi7XdbhXwH4SqdMCttpIDAqxHzYUFzNeW6dW/NsWSLiiw+BH9qlQQHwAe
	8mnrvYJYkyn3ZPvBW6YLfMpRLtfPLyxy98cMQRZSXt5R7XsUiOoixoP7P0xFLWp2jWNgRA
	3Jtko+zPAP4vjS4Cttq4iBDB1Ai1NmGjdMNd6ynYX0/U1EdvDtcV9YOWzs9LNg==
Date: Thu, 10 Aug 2023 08:17:43 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, johannes@sipsolutions.net,
 Jason@zx2c4.com, alex.aring@gmail.com, stefan@datenfreihafen.org,
 krzysztof.kozlowski@linaro.org, jmaloy@redhat.com, ying.xue@windriver.com,
 floridsleeves@gmail.com, leon@kernel.org, jacob.e.keller@intel.com,
 wireguard@lists.zx2c4.com, linux-wpan@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 05/10] genetlink: use attrs from struct
 genl_info
Message-ID: <20230810081743.567abd78@xps-13>
In-Reply-To: <20230809182648.1816537-6-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
	<20230809182648.1816537-6-kuba@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

kuba@kernel.org wrote on Wed,  9 Aug 2023 11:26:43 -0700:

> Since dumps carry struct genl_info now, use the attrs pointer
> use the attr pointer from genl_info and remove the one in

"use the attr pointer" is present twice

> struct genl_dumpit_info.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

>  net/ieee802154/nl802154.c       | 4 ++--

Otherwise for wpan:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

