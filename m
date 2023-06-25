Return-Path: <netdev+bounces-13834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4014773D2DF
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 20:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557CD1C20919
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E9979C5;
	Sun, 25 Jun 2023 18:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB07487
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 18:12:36 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF301B9;
	Sun, 25 Jun 2023 11:12:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 0B5745C00BD;
	Sun, 25 Jun 2023 14:12:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 25 Jun 2023 14:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1687716754; x=1687803154; bh=31i4/cLai27cEU3wo5q8F0HfJCB41onkm1Y
	UiEZcKNI=; b=cw2USf+ZJ6ySckD7atco3SbscSOZruXo/B4RYIUbXfF+gUAt+f7
	2P/vuznegg+ZdZbVEfwGiZmAm354A8rKCgp5rwxM4oRzkIuWjPQQAeYOwevdxAaO
	DeQvxswmMRQadkcQcG7+bZU26NPqPwqmZjgAUUy3scpdbYHCmrWc07lWSegI6bX7
	j626VJzYUdZ5JrU8PnCaIlidcAgOMGNVpjSoMKNFraulE4gDIzEQgm084zzJhuMN
	iLz069XnVVJYFzyVbZMlLhCsHfng9BDOl/qIuVKr/jomPS4cGtGAhY5m08SDp+lk
	sBMNHD8I1Xn629KL1H5UU4l8vGihA2Pz/lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1687716754; x=1687803154; bh=31i4/cLai27cEU3wo5q8F0HfJCB41onkm1Y
	UiEZcKNI=; b=KELKCq/55w+dieagNoWTY62jcioU14sha76be1kwaR6S/lvsLsV
	FG3TRaHtCnBUFKzhNPthsUnPnaZR0ZNX0cNZH9OGAsSarmNSY6GIPSBpc+xock3t
	JvK1Cp3bPIe3ekK7UrYgYEqOTGYLY9LM1S2jQQoTJJM8Y61X6B1bGczfHjv5C4i5
	zA5Jobd5anKOZWQtu3MEGdBdnYYlmS360Wvg8xvkmnnvW386p5dd07dM2107yIQz
	58ENjKy3cNJd/OADCWzpESDAoqWZMpAAKz/A9SezJ05e5svGVOIhS7fTIBdIfw3H
	5fcZ4bQl9FWwRNqD5KnnsVLvdW/x3TKGZ7Q==
X-ME-Sender: <xms:kYOYZO5EghWyTnL-rNrvatEBcSldsWoTtN4rxaBhR1zMlVNJvegSoA>
    <xme:kYOYZH5Jw2l9x-p8N43UcJmUZbu8z0c3lNLaPtYp4ui7ABntxmQYpmqAHDQdNhfGC
    m90auYfd61RQcSNXfo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehtddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kYOYZNfWtXcmXS5d21Eaf3ZNWGCQX9jxiZZTuQMBlal1PhPpXid0cQ>
    <xmx:kYOYZLIPiRw3_qztFk0g9WsDOlUgtBs3O8pQLEoFYBMi5BvKLlmyYw>
    <xmx:kYOYZCJf0VpIMZyCC4h12UuRYTBvyo6qsaJkq1suRghnPTqN2m8-vw>
    <xmx:koOYZB8j9AFiaeuGKzWx-_LaXsVV5QYgaUvNu82XgF_ygOJYCluokA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 81C2FB6008D; Sun, 25 Jun 2023 14:12:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <e0a08449-554a-4a28-ac50-7051866eb95e@app.fastmail.com>
In-Reply-To: 
 <RO2P215MB193879B2D99DD0BAF59EFA92A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
 <RO2P215MB193850DDADD38492BEC8CC2FA720A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
 <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
 <RO2P215MB193879B2D99DD0BAF59EFA92A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Date: Sun, 25 Jun 2023 20:12:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sardonimous ." <sardonimous@hotmail.com>,
 "Larry Finger" <Larry.Finger@lwfinger.net>,
 "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Linux Wireless" <linux-wireless@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>
Cc: =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
 "kernel test robot" <lkp@intel.com>,
 "Simon Horman" <simon.horman@corigine.com>, "Kalle Valo" <kvalo@kernel.org>
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 25, 2023, at 18:58, Sardonimous wrote:
> I have been unable to get DMA to work in the past.=C2=A0 So I have bee=
n=20
> configuring it with PIO=3D1 (/etc/modprobe,d/b43.conf):
>
>  =C2=A0=C2=A0=C2=A0 options b43 pio=3D1 qos=3D0
>

I think the qos=3D0 parameter is what causes the WARN_ON(), as that
causes the use of only one queue, while the warning happens when
tx function iterates over all the queues and warns that they don't
exist.

     Arnd

