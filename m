Return-Path: <netdev+bounces-36099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6AA7AD37F
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 10:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E886E2816C5
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC5E11731;
	Mon, 25 Sep 2023 08:37:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610201097B
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 08:37:46 +0000 (UTC)
Received: from anon.cephalopo.net (anon.cephalopo.net [128.76.233.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F0AF
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lagy.org; s=def2;
	t=1695631064; bh=MQw8bY5Eo07RQYw8wB4JMaD+LBlEH/x+teKJC4tWyrU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=ExGU3swD0CfPIWk7dWZSUruYXnrXxFK1+tdyKojAJmLrJ5hyiddlvIdBdlHBx9H5a
	 p2t3TmijI2emlOJPSICvLzbatza6xAv5CQqoswH9IlwiuP0RiWVc3bZqNgkmU+QGWm
	 cQEG9rJa/Kmxu9bhXNWGrvVJ66as59pbwpgb3OmWjzLux2FqB1yN4ZBRjsHmNmNogC
	 NqEDRlb+iGIboKz6FZohAvAnqACM+JRitSmHG+zS6XUkY/SZf0dmhFIB1+fU68yqUc
	 jObx7S7cgcncsb1dV6EW9BcmUl04Ccpkcj4hixPADCkPhcIAT6Br2n9NABX+3kDa3e
	 tkCWs+1vSksFA==
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.auth=u1 smtp.mailfrom=me@lagy.org
Received: from localhost (unknown [109.70.55.226])
	by anon.cephalopo.net (Postfix) with ESMTPSA id 7140B11C00BE;
	Mon, 25 Sep 2023 10:37:44 +0200 (CEST)
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
User-agent: mu4e 1.8.13; emacs 29.1
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 nic_swsd@realtek.com
Subject: Re: r8169 link up but no traffic, and watchdog error
Date: Mon, 25 Sep 2023 10:36:29 +0200
In-reply-to: <20230809125805.2e3f86ac@kernel.org>
Message-ID: <87a5taabs9.fsf@mkjws.danelec-net.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Wed, Aug 09 2023, Jakub Kicinski <kuba@kernel.org> wrote:

> CC: Heiner
>
> On Wed, 09 Aug 2023 13:50:31 +0200 Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>
> There were some fix in r8169 for power management changes recently.
> Could you try the latest stable kernel? 6.4.9 ?
>

Well, neither 6.4.11 nor current debian 'testing' kernel 6.5.3 solved the p=
roblem.

