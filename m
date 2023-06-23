Return-Path: <netdev+bounces-13400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC43073B711
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEB91C21193
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E42311C;
	Fri, 23 Jun 2023 12:24:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0323119
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:24:13 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100BB1FCE;
	Fri, 23 Jun 2023 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687523033; x=1688127833; i=markus.elfring@web.de;
 bh=Wlv+XOhNkQT3fz051q7kVZTnAzFjg8f6i61p7Es+b/o=;
 h=X-UI-Sender-Class:Date:To:References:Subject:From:Cc:In-Reply-To;
 b=rxI1jJkS7O8wbQtAYraaxDP2gTD2agpuM2XnEhdumeO7EQBh6oK6hOtzq6LMUKnEcjSD0pN
 5HjISyyJzt9U93evRKSg9j4FSBYedwXCEVncD9aTNHrUCrIkMe0tG45HSjXQW3FulLh61yak8
 SEg4Y3jahn6EJvatYdEVN2RF6xXD79zNI7iKBdKrRm6pYByzZ2awsH7f3bIrPdIo4bnlU/+k+
 PqRhCmpedsFCR2O2lLmNUyB4CL6AWYeWsXQiNPo0PIMxz3RDF41EQIytxWx8T0uyF43zKgzS+
 1uL1GTHOzrKV+vpSVLgfnVmqmaE9a+tDUoVtpC+sS+dI7atA55aQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JF8-1qFPeN1QmA-002wg0; Fri, 23
 Jun 2023 14:23:53 +0200
Message-ID: <1bfe9150-d27b-9541-adcc-70d2095addc3@web.de>
Date: Fri, 23 Jun 2023 14:23:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20230623074123.152931-3-radu-nicolae.pirea@oss.nxp.com>
Subject: Re: [PATCH v2 02/13] net: phy: nxp-c45-tja11xx: remove RX BIST frame
 counters
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Sebastian Tobuschat <sebastian.tobuschat@nxp.com>
In-Reply-To: <20230623074123.152931-3-radu-nicolae.pirea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aOBHyxsKrS352E2mDrJvmpxbgfJGLgaMiyWGnR5B8JZhZznDEAM
 X2we3i8a/ycxQVXGlJp1ll5zJLRex2w9VjXVyDqIJmc5SM/4pqReCaA4xfXS9XBnefJ3/Ri
 LG/q+4NMllHAzAd3ruROEV/JTxeIgxZ7F1yRHeMnMMtStRpKcrvXrF/hpG3hxJJW5Y1SxcY
 MYM0w3j69fsDCjfNjh/Bw==
UI-OutboundReport: notjunk:1;M01:P0:RgxsYWCoLeo=;19zlArWw7IQcb4Bq5EqtzGlcgAc
 UIZKVCWnxMCDt1HEW3ECAZrvy2ac0Z9Euu8FschZcO3E26Pp5qMXpkXE7h31LE+rXkwNiDtAt
 XoJenxZMSSVHzwKrSlKh9FqV60fiVjKEpRAeFwB6UxXAwfHuhxrT73UMZrL1MVJOt0zl6eXgk
 PMQQTpofV9DaszgyKAcDdx1mV5hVv+rZGYrn6Ie/+bkoMfBLN0NLRbxhf2iND1mRpfO+pcRQZ
 RMUodVOcFmK0oV5omOdEJWandO1qG9L2vrk9hFKj4BUmrTtmYMUsQ3rdlhdnncDkvk/A0ue1j
 FpgL3IygXIubCdfdqhLQvamc/Bb1UPjsUvhTvs/P76ECnzyC5YKuRZTZu+D0Zbu5n0Pg469eV
 mfk312oqIaAGXfT7NH4xVI3ryjeI3dlBvNWRk+XhXqr4/adKZNdWSlaZiPhrwpJLUswd2H7Qb
 WCyVmTqDpJfBEaV4ozYsXXCJq57CNriGJLd7iHdnbgu3J7O8YsNIqnlYW5PbkPq5+S3P5ZgrN
 f/GGJwt9uMSols11dcyV1qH7Abc/vetdoeAbjg9Ih3W/Jh0KLSVCRkuYPddZa9ayPavcVEi0J
 cCL9RN4W79BotWvBkmYVu2+Y5NmaWrH//dSoMCMWFfimJS/ljC/ORWZgA5zm1YA6m+5Y/u0Cj
 infnYurRzgstatFaA4wZVpIVDhNzAzeXWLjOKRjyQyZkmkvKGfqu2jB4EOj715yjR8NY80b96
 VkppYDnupHKA0XldSQkLkgNxk0wZ3nXeqbn5YsFucHMJPal1GVruIkm7laT8KwHIPppk2O7Lo
 C5cxcReyOBzYrYGtjiptTHCG3Cm0AaI3X1sIcHDg2iwEEEZowuQuP1KvJLhF07Inq7sJT9a2T
 zThmeomzK6uA977OA1mChuQnwMSvKJoJ4YB6y083njKLiAWKeDaa9MoQAXtHLMS6OBiR46pGb
 R1qdIMnW6MpJ9tLu4qxpeF7gVVM=
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>                                                       =E2=80=A6 So, they=
 don't
> provide any useful information and are removed from the statistics.

Please choose imperative change suggestions.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4-rc7#n94

Regards,
Markus

