Return-Path: <netdev+bounces-17883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D00753629
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129D61C2160A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8180EDF59;
	Fri, 14 Jul 2023 09:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F51DF51
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:12:23 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5BD211B;
	Fri, 14 Jul 2023 02:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689325923; x=1689930723; i=markus.elfring@web.de;
 bh=PK+tT2O0klt3lbWE+219Vt+0kQnH0vSbrbizGnf0Vl0=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=plQPeS81pqpvPjJzSzoOO9pCqYKqzoAue7Q0Q1VCqTIykQXQ+rq/h8s5Bd4IKmXKVj4voqg
 SVQ+Ky6shJxgipm4Ix47FYNNL8mW7Ro1+KdwxJJHrnJwfZ1rYyv6uYcxUgc7Lb4lnkOaxWCQw
 OCpLCzGSIscb6sVRse7U36hcQXLE5RAktw7r8ULFby9wHXWFh52e8YPG343z85s/OkAL9yOiV
 mGiqLTQS/sumxdaF84zA69tZWpgLLaOgIIVp7rsCZ6A6Oefx4FKeAtdrDGQRo/us8KkWL92Up
 GonSQ9eoT5dl73nXCXmjUraVOTRPpcibrfZHjphIoP3DUtf3mXmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1qflq03kNS-00LrwV; Fri, 14
 Jul 2023 11:12:02 +0200
Message-ID: <2cbc583c-5501-0c26-086b-b4dbaa2e4416@web.de>
Date: Fri, 14 Jul 2023 11:12:01 +0200
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
Cc: LKML <linux-kernel@vger.kernel.org>, Wang Ming <machel@vivo.com>
References: <20230714085115.2379-1-duminjie@vivo.com>
Subject: Re: [PATCH net v3] net: lan966x: fix parameter check in two functions
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230714085115.2379-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UJiVJEd2VE2SkDONhHIdK/i1Hi1JESAQgln67Z3CH6JcZqBnjo/
 +WXqeZ2qBsORf4126t1HRFRcPX0SREFxGdK5IQOgvww0yo8WikFWC47BeLEQPwbaA28o24v
 iW3dxjaPcfl5u6wZuCSECeOw35xhcfMubdHTMp/y0lqsZALCRbMhLoCKpglAUkMBSshJAJ5
 qa5jR4ob/y0X6JZO6NP6Q==
UI-OutboundReport: notjunk:1;M01:P0:oqyYoqcUSYc=;fIEsHw0fH82TaTdHaYCNGy4S3g8
 Vos7xNc0pekXPlPG78OWH8JRnl6S3tnhYM1/BkmLr0+VhxXm7zTkPQikT/ZZgC1CytXY24r7B
 jQpaHwT8Z7G7gzGTqnimN8Net2egA3VsJx6dXL9s4VocfqVe809RF5JlCi9SoZzX5TtWN+niE
 Ee1/pkkwzpW5iot01WDRbTpmlGyxadvZLq88w6IoGXUcQmKR5isar1wMmue3bbuTJtLT+qaeN
 R/c3vEYtleBGnb9t/aCHxfD4Q4OxsJChSIKd9b8Dn9iBuHx7Ganu4pQZouk9skkvF2+ixF+/3
 3o4Vt/9UMfly8OoJIa6AcOmVcCUvnbuEe/kq60Uyz3OFjArlSy7o9MWwD6Gf80b1/cUYoYQTJ
 9bdZDjNV8FO9isFozrPK4LrLJsCuPuo084rISHlH/mga7ilVH7uR810sI9qDLQVzdGPTCr388
 7geKDtELAZ/gtPO+ClV/P2a0WYk6bICFXN/HXNoXn+C58jYFirA+Tx2FPEpLBCbQQrvEdQ4X7
 hCp0lRzwQLr2lGRPrDoMO2r1hVjHEwe2ErZMlUUc1QvSfpfB5UNnmZULW8Obhfw8198WhUPun
 M8w9wzkqzGqfT3gcY+Me5RsvdjgPHkX+/nksK0GbnCP1tDnL65uIugAsxydUc6A/05INIYSXH
 rm43ofu4d8Ym7gZdMsSw+mQ5mHTabn76GwDuFxoZUy53oNR/opE7S0KKfUqMSbycV3YHH7cQf
 VQt7JED775nEeQBu6Jz1BcrzIZcNbaJ56noUOm1adU0xQsnfLyZjLOd99jyi3/i5lky0G+7Hx
 K1gxqvCW5nQ4inyDS7J2AVtdUb545rTMt8/CPUXvZnHudJlWyPXUDx2hPEjM7y3BEbTKOqz0q
 Ia9bhypQfVVSn+YvZLOH5nBbEKekBJJ+aPqjIKcteGpZTcxZE8RCMCYzGmJu5WzlMz0s6ClLc
 QeQqnBI98DvH7ibP06PCOuVvSI0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Make IS_ERR_OR_NULL() judge the vcap_get_rule() function return.
> in lan966x_ptp_add_trap() and lan966x_ptp_del_trap().

Will interests grow for another improved change description?


=E2=80=A6
> ---
> V2 -> V3: set the target tree in the subject and add 'Reviewed-by:' tag.
> V1 -> V2: add Fixes tag.
> V1: fix parameter check in two functions.
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
=E2=80=A6

I suggest once more to replace the second marker by a line break.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc1#n711


Would a subject like =E2=80=9C[PATCH net v4] net: lan966x: Fix an error ch=
eck in two functions=E2=80=9D
be more appropriate?

Regards,
Markus

