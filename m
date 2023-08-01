Return-Path: <netdev+bounces-23275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED1776B765
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C05F1C20F37
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47AD2515B;
	Tue,  1 Aug 2023 14:28:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938622EFB
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:28:04 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9E4E9;
	Tue,  1 Aug 2023 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690900054; x=1691504854; i=markus.elfring@web.de;
 bh=4h6ZiPFm8V8eFIVQF6tEWqaykBRBuewqKwVq0TXcyHA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=eWOEQh3A5R57yhW+n/3dg2nRtKZcV8cq7L5tMrq1/yC3/uoDX9XqUxaasIDlyZDPulWj+hH
 1hrZLcTVErTAcXRNXkVL/adVR+PJa/6jJVqFTPwrsP8cRePHstSE84VRXQ+FUE4zRKJbZvOeD
 qbOajYl793jdqLRBtp20UhmuVDwsioUR2SDthVbEBC3FHEAMfl/eBwg4UvJI8oolopzfmlwu8
 C3xWGCJ77f7C5KcsR0nNK0gG/Xwgnvn61pF2BtnLm3rg2NAhOG9cHwUhZ1FKxx/2roB0ptOKR
 x/J8PFk86Hz/CoNOc90ENOcYSlphLA/9Dpvdvh5h2/HnNSYMcAlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QQD-1pm6GW3swn-017etA; Tue, 01
 Aug 2023 16:27:33 +0200
Message-ID: <d1f12cfa-40a6-fa73-308d-260e867b0034@web.de>
Date: Tue, 1 Aug 2023 16:27:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: net: dcb: Communication challenges for patch reviews?
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>, Lin Ma <linma@zju.edu.cn>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Daniel Machon <daniel.machon@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20230731045216.3779420-1-linma@zju.edu.cn>
 <fbda76a9-e1f3-d483-ab3d-3c904c54a5db@web.de>
 <3d159780.f2fb6.189aebb4a18.Coremail.linma@zju.edu.cn>
 <d29e7d32-1684-4400-9907-f2f69092466d@kadam.mountain>
 <ed7020cb-cee5-16af-55f1-f1adac08f1b6@web.de>
 <a03f4f45-08c7-4b7d-8f9a-328dbfbe721c@kadam.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a03f4f45-08c7-4b7d-8f9a-328dbfbe721c@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:G3d75Sxq7ddaxCd7jLG+X6g7RxBjJzzBf7byPqoF7GDgCmX2C2g
 5JMc0BGGHjIpSL3rH6PXw4EXpo+rOBb4y7dks+CsdBUnaVvq1XPQyYyA0Vjuy+UuhdFN/Iy
 WdmF37/AOWyI9bWiGMrxiGXTIf1cez6SbsHeJdb70WYX2VtpYKHNZfLF/bl5YLPKp+HEqN8
 rJ6fr6CeEzVdXoxtCL+sg==
UI-OutboundReport: notjunk:1;M01:P0:uSxxx7NHl/c=;VOkgbRT+4Tv+k/wMI/clCBOWYf0
 /bQsOrt+nGRyyNqJ3yD9KeuPaCnSFwYbdHqylpQV5x2Qu+bYW5W/+Z+Ga0fXa/54G1W/hjXte
 bHoAnYIhZmIU3Kt0cQsaSPyo+xE3XeTtv0zdZ88sCma1Gkg64BVnsFT2cL8ghDjCMRni8oeQf
 qG2A1Pg+TmQKkKQUu59aUwYoS39drztS/Xe8qU9vNX3ovNuQRz1rRfDPH2A9TeaXyyiojlccm
 UzXDUWs93QsnxkN5hcsg4z5vW66SuWCvGWSahhm7hzxEopja6ejatOhz/W4/wz86u5sMhRSZn
 33YtO1EBP8yvnCNu0Q8Mm0RM241m9JMJbq+FgWkiI9Ln76HOxyLyisdbUbA/+b1QUibu1DDs+
 aLI5HuIHNB1lZQ43BIlueWlJxYWCKDBw1xGC32cWqXEyQhr5M8nrH/MZQjJHYLfT2in7ZlORD
 3GNoFzG1vvIkSuSvAkHXWqoHQu1jiOp/EiXPPYCMmAIdM8lsnPOb6bw9cwG2r7gxOIFk2rwlg
 VQ+rQn3esp321oe6w3TB6YjFEKfzMWsTrG9CbKt5g3u5x0BD1mWUGo4tjINgzaMsRq6IAiPto
 JB9wADrsxvp30kr+4hCsrIUoYyWjheUAoo6ssBq9Gnoq29vF5LAWdR2OjlsaYDj0fAh9XDj/S
 feaG3eYgSxMAYG7Y6vpfD7hqWlgwJp6/h2w+QtglE3TIJrm24c0vwwtHJqAm54cw+PrsqUvcK
 myaL4xNDkSj+4bZ8n3HjnJ0xPH+bwtpZmPalwO1mD0xCCih2OHtx9xgt56xywLKmjVPfNFi9G
 UTdK4VX7adjJYPfjsoN3SlqUWrLVcxNQzk8pzy0NKtr7uBz7RSmMh+MmvKk5R18DET1714B1A
 nalEnadrsE2V96Q60iiGW97iNge+vbXMZ4KsAke6iXrLvQjOwNPYbusmbjEClaO4NfYXcHh4b
 NLPhBg==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> In recent months probably seven maintainers have asked him over and over
> (maybe 20 times?) to stop with this nonsense.

Strong responses can occasionally occur if you dare to present special
suggestions for patch reviews according to components in several subsystems.
I tend to interpret hints for improved adherence to Linux development requirements
as helpful so far.


>                                                So he knew he shouldn't
> have asked Lin Ma to redo the patch.

This contributor could just pick another change idea up in a constructive way.

Regards,
Markus

