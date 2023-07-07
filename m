Return-Path: <netdev+bounces-15969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C8B74AB46
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3C61C20F48
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 06:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9A51FCA;
	Fri,  7 Jul 2023 06:43:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9E15CE
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 06:43:53 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D24C9;
	Thu,  6 Jul 2023 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688712189; x=1689316989; i=markus.elfring@web.de;
 bh=jTIP9I6rWbUs/Hss3zABBVYfjElJVbGQrPrUHvE9qqI=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=Ec7KoXvKhidJ0YFi0thyHVHR2+0YEtgfHQhmNPIyVq19siSl9+NRjRsHzFfyupFMB3vSx7R
 isn99VpC07NPE6L4gILNEJ1C5IfRugp65rmzQGkL+yRiqPmnEy/lq6kWkNDChhKgHtQW6eIpv
 hQYQqsHoKywdiFJk/h2OfPNDbAZOyR/uwLUBQYv72LGuEOs1uPosS6g2lXFDnRRoIv392eaSt
 JQHtJptZLNlhtJimWx3r7T4gQw/T0Rdc29ZAAHgAqe9LIgxxdShLf4Y2WkNW24fOU84d8hU9C
 21QvMHIEZQewT+3xYAAwDFd1+z+w23H982HgYEeY4zgem2cYe69w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGQGH-1qE34C2Ueb-00Gagi; Fri, 07
 Jul 2023 08:43:09 +0200
Message-ID: <4aed7411-a567-c6dd-3ff1-3622b7eb7369@web.de>
Date: Fri, 7 Jul 2023 08:42:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>,
 opensource.kernel@vivo.com, tipc-discussion@lists.sourceforge.net,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Ying Xue <ying.xue@windriver.com>
References: <0d8a89fb-b1ef-9a15-8731-4160b1287e14@wanadoo.fr>
Subject: =?UTF-8?Q?Re=3a_net=3a_tipc=3a_Remove_repeated_=e2=80=9cinitializat?=
 =?UTF-8?B?aW9u4oCdIGluIHRpcGNfZ3JvdXBfYWRkX3RvX3RyZWUoKQ==?=
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0d8a89fb-b1ef-9a15-8731-4160b1287e14@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CAMlEzw4KfK4fr0NozUWhSQRSCgVIti5cxrCWPNRVCmGzr5KAHm
 cOpEiVpasved9LnwvZujNVIxmjjHRqbE/xbnygZy27yH8gWBa9T26C89lq0DauJ1H4sCN7m
 IMoFvxlKbbVhVHQX2O4g4G9OO4Ul/anj9Oa31EJjlXsknfPmBAtIQhMsMbrkT7mZB+C8VTw
 K508qccRoeQvtlgAYVr1g==
UI-OutboundReport: notjunk:1;M01:P0:7kUolwNMoHg=;0AkHhZ8zOLFJP4VIutaSsLCNI70
 Ym085t+P/RUhbvOk+a4sN+NxOC3DRUPTm+feksOM4WxqGheiMxla5lb1k9EtoyXdK6uJDDp7w
 dtmlgHIpv+yNRByUzNn1M7GEzkMHuSIDCR7WYI0auYtFh2/16A5B+fbG0TVtXbiKaa5wDNWHD
 9eI1AmPUPlPH+O7CXxwIXMQwFfXf3fyUg+tFL8oNLZhUcFU65nvNqFj1KBKDDN9ofqZ5Ss780
 h2xgSpQFOGclCMLDrRQv/4JiOw20O4S6K0tBf4cOtv9vzUFzVRgGou3uDR0CUIYjRuLLUyRgM
 /zorLPhb8fKTrfpJ6F3uZpZPsrvk1Fs0PZqeoUeAyeVcLQUvHHJgvsJr3c837KopY+S9XGbYo
 eYjtJLJRxHauFCIkJQkHakvpeLlkEbbZ/zT+MPjFL4PHxI5pjxPz4cN/WcHtr0beVvw5ZmE08
 wIr7Kuwze/9BXLVHkwRg9bp6ZcSpXoTx9u17wkQ67Lutbeo/0EeyYD/+JX0fFVtB0RgFK43NA
 TVYKD0MYgrgCunIsdN0PV58UWYGoo5emby4Zp1EPXsUd5o+HYlTPs68P9jFpd+0y5bJVDbdbC
 poe7wNK/ZgIqlpcFrHpei7zwpL2vTIUL+hdaNjxGmLtBwkdx087jIIsw+iKuFGkS92lc66L1H
 ZJyBUzNe574Fyqt2OH7Hv8WS06F07kKBHHgxIMRj/A3Cy8XSji0uKr1iHyW+QjakXBXIIpzoz
 CbcRhuyrSbRrkIMVwiFpt6JYPY+FkqZKEfnf33Y0NIvpYy4dchAbBw+o0ZtaigIHKs6qBZXaO
 9cYc9PQ/eHqoaTAAAPi4M2MPhiwPIs4ggCycBWD6CnRNX/jn28Xi6mfB+dPmTfpMl+6gnedLG
 rohM2zWQ2qwJjXDBSxAl6qsyygp0L4lJxDIDjgEdctiRM+yJLqIFEm7s3SUFqDOiNBzFsr7fe
 CDLCng==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The risk of breaking code (as you un-intentionally did) is higher than
> the value of removing a redundant initialization.

I find that it would be nicer to perform only required data processing ste=
ps.
The application of variable assignments can occasionally be improved furth=
er.

The corresponding efforts grow for proper code review.

The discussed change possibilities might belong to the adjustment category
=E2=80=9Ccode cleanup=E2=80=9D.
Some contributors have got difficulties to integrate presented ideas.
Thus it seems that more attractive incentives need to be offered
for potentially desirable software updates.

Regards,
Markus

