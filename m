Return-Path: <netdev+bounces-17588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DAA752327
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DACB1C2139E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E9100BD;
	Thu, 13 Jul 2023 13:15:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B2AF9F7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:15:49 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED4E4D;
	Thu, 13 Jul 2023 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689254124; x=1689858924; i=markus.elfring@web.de;
 bh=g/+7FGJEf8D/y95FiqFl7dR1JXZ2CRP2aHpyTYP8JGo=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=HIjJAXeZdwEJUtz1ia8XUFiW416411g3VFQi/nZ8N2+OQmCyeuuf+S+AcKPLLLIQWwveIXQ
 DAF2ETVNBmItEe6mpRaW+gahGtcGFTw+aAPxcBG1ziF2/KnRAZBZLlDb0r/59KgDe2lWo6/fx
 b9MfFM9pKe7gLEduGcvL2j86gEGDy6WyJlpmJXSS6mHRbJ9qqGUFMTVEIviXaUP9jWPvPDZUQ
 cOSrCbvs6MQHSn5Qda59UScR/+Zb6o0V+GX1wDtl+yzVegED2Cf3IZUrQvVB/xOvugs/v8lhf
 ebANzap4thrmA+TAXJARVxeT5sOSwy12XBMjMZt7rRYjlH9YUqPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9qgz-1qMwyP1ZR7-005dRU; Thu, 13
 Jul 2023 15:15:24 +0200
Message-ID: <0bf902af-ee7f-bb44-49d7-db96c0a5c6ea@web.de>
Date: Thu, 13 Jul 2023 15:15:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Minjie Du <duminjie@vivo.com>, opensource.kernel@vivo.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230713085908.12113-1-duminjie@vivo.com>
Subject: Re: [PATCH] net: lan966x: fix parameter check in two functions
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230713085908.12113-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+hDf9FfjCXoHJ4UIzLDBWzavVB/BPznPVQ2lcVQl8GABWJ9y9P/
 BJVyllorkpp6/wztKLpH8KVzI3VBUfv2N4cg4uVklz5faVewjh6C0FeSQUxjB6r8YDdAhnk
 egbOVxKrfIgfpQWRjGPa4eE1exYuuEncPlaxE4RYSoqMip7s9fmUqieB4/K8MBfpCZoGITI
 zLNyR3RVbttDxDbnvZtRA==
UI-OutboundReport: notjunk:1;M01:P0:ReBmP0mKPx8=;ogMR+y8ECncvX3QfsTZOlcAckUs
 iELOD0j2DZ+m7QjwEXTNb8l18XvraW9Vg+D6fdsR2o0dL+z4TtUYPs/f10dXbmo9n7VfD/BsX
 Je10Du8RN1tHHwN3rNbggV8Ufjc02EgUIoJ2Xy6kW+5NT9l4AOEBypnxeAYegmnfE2Q2wVCjy
 zQSpLxwz4LNvCdDv3DPuhoahn4gAC/WGywBFe8Y2pPI6YA+uRT6vv0jJ7WnZXwtNzinX/NfAw
 EuBf1rHv6b2afBG7xeEajOo116/smvShLRbq44Zy0+KM9WjwVqRu4GpaL1A8ENwY/gWrLIM8c
 2wAFBwkir54Wb6s9ZvR2lRbS5qp+tinpwqGGLCN9zx8nWbpxx5MQuM2xnj5C0FDMprBsYshAl
 V16vosyqejXoVUXRQGV4wMw2We1gOlThLFzUrSVtz1xw9FYiDg9a8wOKwXaVWHoB7BPOI7rhQ
 UzXF2/amGv8DZIC7TPxNW5w3T1R4hDmN189D+ViPqpTMEt5Zofte34pHMrstEGdZKUZd/cMkX
 9idP9pstcGOrngDBkev8Csxrc1hK2n+585i2mCEaqgV27AEAKlmqnwJbgg8x6UuMKnjVw+YyK
 gN0qSdAyCDgEjWGZ29q1g5KiTSm+3QSxO8uiEA2wTayNANWDYcimF4GR3AONSXDm00B5/mzNh
 GhnMPXBprdVbgTZOkIzA/W0iV/UFd2zQByjHl7Y2iT0ds/An/8ClJ7xh4qSeW/+O2H0kqrl83
 zp+ltK8e4mNFFJdidJoqIqf5eXL3Y48qH9s2Q++ZS5d2M+Y8j14thjH0POy+XJR5Jisl0O4mh
 xnpZ0D1e/tpvgBFBiKIiIjniDvNItznXYWjo6G6wNmBLk7WIHICM/nAXddN26UsZBDKWXO5Q/
 E37X8ZQgEhbILtuwpvSITadWJK+5Bfm/q7ghYyJ+sBnj7rJvcwvgO1OnCCzT8/tcyLSvtwnWO
 ndKrxQ==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Make IS_ERR_OR_NULL() judge the vcap_get_rule() function return

Would the term =E2=80=9Creturn value=E2=80=9D be relevant here?

Would you like to improve this change description also according to
review comments from other patches?


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because of a=
 desirable
source code adjustment?


Would a subject like =E2=80=9C[PATCH v2] net: lan966x: Fix an error check =
in two functions
be more appropriate?

Regards,
Markus

