Return-Path: <netdev+bounces-133174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1139699535B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425251C253ED
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE501E0490;
	Tue,  8 Oct 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d5rmxPWE"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1F1DF73A;
	Tue,  8 Oct 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401155; cv=none; b=NJTdBX6wIva7bYHXDsO6Q7O556smmc1ZOe+C1pniFaolA0zP1gGTU1NtdaXlN9Y0RYakwXzoAD69eBvQjbAmzE9Ds5c2B0ScRmrZtVmVYBSVvVLPQFxwhOdoshZnYluZtRPDcPnN63Xlk6lebz+cnkMMq37aSeCgQ66huhTddQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401155; c=relaxed/simple;
	bh=U6xjsviuuR0pgvkjEMDMUpNLEHGTOTQ1nZ34SCNH2XM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=alLFozny02e3Icq4z9oMC9TeRiTHlKr2dL69qJAAvmUHcJhQMFT2cnUr8hgRx+USRlKzhlnBL43RRTBiwPNTwA+K2FUGpeTDx94RfUyg52ii/0IRn7xL9ltNOaZ4Sv/85PGCvHBnS127JD2xfV2AA/OdsCInglR4MCzVsYbOZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d5rmxPWE; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728401116; x=1729005916; i=markus.elfring@web.de;
	bh=U6xjsviuuR0pgvkjEMDMUpNLEHGTOTQ1nZ34SCNH2XM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d5rmxPWEaNDJyYsF9k8keCl+35OxgtQq2OMdHtL7MTbaVgY80YQ0ypmBoPB/susx
	 a05VZu+1WZ7/s6GyKK9zigQyLU4rEMYL6IKFXP/Pc2c0edXRxGBeo0zBSimyTokTu
	 XhZnQ7Ujykm94KIYwrJrc3yl3tpsCe5qMW+vrI8saYMOQMGuNquHOi4x+kl4mnIGc
	 3sCPgL4JFhOLjc03HtowWYh40p13GmMW4Yj1eYYPVyvCeN36lPVuk0A1KcXXFpyE5
	 PFzEnbPbUZns+uhZ1RSb8yMvD1SEt3s5yKUsxMR/9LxImeQZVUw5qwgAOFtdc5dJ8
	 NWmesyi/fE8VerKQwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCqb-1tm8lH1i4V-00mqLv; Tue, 08
 Oct 2024 17:25:16 +0200
Message-ID: <8481e803-a2bf-46be-b5f9-a39570ed330f@web.de>
Date: Tue, 8 Oct 2024 17:25:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Christian Lamparter <chunkeey@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241007235711.5714-1-rosenp@gmail.com>
Subject: Re: [PATCH net] net: ibm: emac: mal: fix wrong goto
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241007235711.5714-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3GMogz2CLho5gDLcT4FBTlDDaPDFTju7aFd9F4ipDZyTOka+X8s
 En+yYpr9ci6OuHYaziLciWqGNH3Fb2MZpTQTq+N40PRgclzX4JhXEoND4ptEpz36TmVah3e
 VZtFwGLMRQPVg47kIH6UCJISxJmaiBu/Vu2uaFXShuf8qwupkIyaVNM9DYlI8XtwP9NEeVO
 qnw25HFF4KfCOK9IYfjJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eIe9Ahons8c=;3Iv7q3JSYwyYxD9KHmwuRhgb3xb
 2LPnmjYRqogTAzOrV8et2dAFsIEZb8/iT4N2ncL1n6PUkTbUAtY2jkV4ldzjISe1hORnF5DMS
 miHobOmEbWc50xs/f0JBfOvMYhCgu+uP0w0MP0W2SJgAkehpJ4kPl5SItmEBUYsU9IMDaOrfb
 r5/YxmtjbdGU1lyqMisl0ngUC6Lep8ZDUod3F5D+bJu/d2UL0F91TthE+PjCSUHNkGma8NH2N
 G2VYK/7lSmRz+B5Z8N8bo9o71f1oN1+/CqDA/imTsKQjHZ4knm3HM5ycNmnMGhvhQop3s5XjX
 NKJ/n6i4DXGMxHYG7Y6Jcr9FED814lT5LpXSToLvYhrGS5mcSA8KbXnE0O9BON4QmJVQREofu
 tJ1aGAEx2wQ04N7CNEg8IEppGNWcpw2/zurMVRO+CF8iKfAwAKuFgYlN0M3dc30cJN2WSvHd0
 UHhMXWMx4aOfbadtzIlFXpHXbnsbvhEEXeSeYWrXUbcG8xvzwAQnruLN9hNidOsfuEH4UPYH1
 g42fyS5E5yW3eJxNyMeowoCmtsWM5aPZv6lLIu0pMx/I7xX+jWH15ONFCNUT8UZvNmPth9Tut
 1xjZ7KORDeyRHOU7KEFchK2Udr0YfhSYyS3FCf6b8UPy8TYLcJpbCjp3r9qFv9UVoE/QJXZPW
 XUcdIjcZHBvtudt3Htmlj7KAlJS3S8H7ssP5pR+NF1lxCD3DqmpRw42uHiYh1uuRBnE/SVhdr
 oQswphJjKfRMbszTEHknb6tsJc8f1OjvGaYbXnGqgaTsZ10S8UL5EW89LvJcov+XMEnFqUQsl
 EIdTUU5Tl76kEeTo88+l+lQw==

> dcr_map is called in the previous if and therefore needs to be unmapped.

How do you think about to choose an additional imperative wording
for an improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc2#n94

Regards,
Markus

