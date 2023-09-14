Return-Path: <netdev+bounces-33814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FA47A049D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0942822AC
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173351F5E6;
	Thu, 14 Sep 2023 12:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C9241E0
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 12:55:35 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D581FD9;
	Thu, 14 Sep 2023 05:55:35 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:55:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694696134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htrMaiejTh0NCWIA4lsUSbyQBotus1EU2EjEuE1IjMQ=;
	b=B2cdxhY5MODOkjUpu/FECoTCBXswScZGKl5DeCWcFdY9QGHAJWsT6IBIkohIIruwGe7cwu
	4Df1UL22/8WgP0Fo2eFF2GQ4v7FIvbwpeXWH2mW2ZaFT8w7AY7o86U2fjzT7AshTCyfG9P
	pZFZKImGo/0iovt9VhcYlEJp8TV3vU7TZDS4snubmVd0MBvgiK9I/n9wRKEUTwqFK9dwWh
	R8lnZESlLSSq8Lncj/bK3NJUHQnU3Plhlt5atrDdyC7fD3Jo+13IkacV8UhRQtgnQ7oDVV
	j+msPSuvqnRTxrEl9Q4a5jRd/hAf/Pd3AjnmNFYcCZngq74qOfEeE990DiF15Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694696134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htrMaiejTh0NCWIA4lsUSbyQBotus1EU2EjEuE1IjMQ=;
	b=zlEeyNOVXw1ZeLzl/iUubXijuy2gw5jA8N/vTrKiMrHmtmnXFyg3RomNtAKa9d7Br7iC4f
	dZbpD5XNB3olTJDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: hsr: Provide fix for HSRv1 supervisor
 frames decoding
Message-ID: <20230914125531.Svewd4AN@linutronix.de>
References: <20230914124731.1654059-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230914124731.1654059-1-lukma@denx.de>

On 2023-09-14 14:47:30 [+0200], Lukasz Majewski wrote:
> Provide fix to decode correctly supervisory frames when HSRv1 version of
> the HSR protocol is used.

I'm going take this, reword the commit message and send it along with
fixes to the test suite we actually have=E2=80=A6

Sebastian

