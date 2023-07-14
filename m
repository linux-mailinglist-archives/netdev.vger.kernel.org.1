Return-Path: <netdev+bounces-17869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CA67534FF
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486C31C215BF
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C0D30E;
	Fri, 14 Jul 2023 08:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B5C8ED
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:24:18 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9B09B;
	Fri, 14 Jul 2023 01:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689323027; x=1689927827; i=markus.elfring@web.de;
 bh=FylxkALCTFDYr1HsBsd2FrsiRXKuDOvJ87qiVgsYLpw=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=KYZs8Fr1aXXC7s+NHaXN9VZDwIiOhP3YQYpRtO7iHA8eFbK7L9hPeasFJ471bLB2F5VsSsu
 GJot6IBsRF2P1uQrfYOiKuaz+H02SZWT2KYKzONX3gcDl9SalK9CrA2xx5jZNae2WhBli+tHB
 xCG3AG7k5yF8T/fOD6qJOIjreNz/dt7RoiENwbw08peCOoxG+v3VTCFyIaVZR5aGPR/On2SoW
 BC/788JJRbWuXt+KdE5UEtNHpaM7nGt6VrMIFGgw89n2XvXfUmTf5tgpzi3eHUHWyimEjPbdu
 vEOWqMsIDIiNfConaEPgmNLQ4QEIn9IQvSAfHkSOVK+E146oWhdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgzaT-1pjoXX42iD-00gzgs; Fri, 14
 Jul 2023 10:23:47 +0200
Message-ID: <96729cb7-a06c-dc1f-6f91-22314e72b7ed@web.de>
Date: Fri, 14 Jul 2023 10:23:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Wang Ming <machel@vivo.com>, opensource.kernel@vivo.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Guangbin Huang <huangguangbin2@huawei.com>, Jakub Kicinski
 <kuba@kernel.org>, Jay Vosburgh <j.vosburgh@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Yufeng Mo <moyufeng@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20230713033607.12804-1-machel@vivo.com>
Subject: Re: [PATCH] net: bonding: Fix error checking for debugfs_create_dir()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230713033607.12804-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rvaDSOd38k40vDrfrRqCAdzFSCKQsL9SR6q9cVkFxw068Oc6xB3
 /fPQKDROKfue5E69s2if8X7ioHmO3JPTebhfrVF/6t1Wg4QqxbGnR3Esbz1EojsyniEGGRB
 fwg9Mjpe49ebySGeZ1C0Odfpqi3CE3abuTSPp/FhoxV2vKIhNkL+gyvXjqc7cJyPhcMJB6j
 wYRjuZoOZf9k9ie7qjIPA==
UI-OutboundReport: notjunk:1;M01:P0:D49xm2gm8wk=;A6MtDObYgwNnjfdGMSWlNZXEGNn
 xVVMaIUCQ9JgBilkU3G969uVjPLhGRiMvBaKpS1lqGpqCA41xtw1+9mBPtbDRscVaGUjH27sl
 k9jkydx/5aC7kGmKr9SHTDLQGQKUhWa42DisWvutWP8LOOq/5zm2aOXJ9gTVq6QxeR5NE5Nap
 qVEISqRgc52B44+ERiAZajBBLYe9IZ+/0rcgRce/Gs0oDZAyPGvi9TkgMCFVhPylN0S83zfzC
 kprGLqEvz6sivxTYKEG3d3ZBaKIwPL4XhsXd6K5KmmH/bPB9GM4prkQT4pBVWoPylgPXo8AhO
 cGEyypQrXXMLiQXXvM8yqX8rnGfLBIsN9zv1XWEVbb7ugp/bCQBStU+qyo6a0X7mQJ4a/2w/K
 F/PR72aYEkHLP1fcMfiG3vLxyXJEhrQY0A655GOflsPE/dGJ05YiRGX/NtY6MPbHL+dU2R3pI
 vSnql+lf741kDZuEDpfd0lpPuK9ZvKwT2KffreAwEa/7MwJqk+1G/XAsuBh1lOE6qeyRoPY0a
 aoR4OpJBz3Vtqk7QxSM8M9BcSWRr0HnfTkgS2HBTS21J9y42n1MBXoc0dtWGe/2PPY17y3Z3t
 CBeCAgjCPNnfqWRYY6PJlUKSK2mAJMxUOUEuUpXPj0+7a6AxA6bE6WcWfUHnhmAXcHeb0A4el
 flY8S2oiLJLGd6KSCKHHUYoCW+EIxg6Xf00ueGEmFl3FyLfRrnq6ha1vJvOam+bi7TQBubXv1
 5utFAplJoLMfALUT2aiDPOepd0wHIVFg1tV05PjvNHAeCDVHxSCiIimrM8ZPw0ct+SrbrG+Cf
 HvIBSvzotHszl7T13JMyAupnWgdt8lzANYFpAvxUV51RyAkbcUsiow3eb1tIWZk3aVZG2URT5
 NW4J3zcD34J9UckPbMVfeZWg3gIuygTyl61p1tkJeckI3bCIGpsR1LnoSFtrJlnDKz6D2iYhk
 fw7DMQ==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in bond_create_debugfs() was forgotten.
>
> Fix the remaining error check.
>
> Signed-off-by: Wang Ming <machel@vivo.com>
>
> Fixes: 52333512701b ("net: bonding: remove unnecessary braces")

Would any other tag ordering be preferred?


How do you think about to use a subject like =E2=80=9C[PATCH v2] net: bond=
ing:
Fix an error check in bond_create_debugfs()=E2=80=9D?

Regards,
Markus

