Return-Path: <netdev+bounces-15492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE3748039
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 10:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF2B1C20AF4
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82881442C;
	Wed,  5 Jul 2023 08:56:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDA46A2
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 08:56:05 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E5171A;
	Wed,  5 Jul 2023 01:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688547341; x=1689152141; i=markus.elfring@web.de;
 bh=C1KqKjpxwKpbAikZhY1ncTEJ4kwvEy+fyvwih4CpeR4=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=kPvEaJoT1KtY1qzb8C5npOFy9x3bEzyOlkqEowDq0KvcI1MTfm5DyzVWlCBaioIHodonZxH
 BXzJdPtviDaZDFlvoEE5FJRfdO1OdICwvJFBbJAXDWOwgZnvZBgvZhlq031lIRVpIi1pXM/xS
 lyd2rzAYCBVvu5HlFJ/klHzlAceHiLPR9alL1m0jBs72yfVkuOdvfb8KhibDoqgvLT4iY+KK3
 bItP3V6mMaq6ggqAu3Lj2YlQXKilUqH59TZ/munUbJ1cZ1J1/bEdLNK6sU7s11W8mW0w7xByw
 y0U0dnUO0JRa5AGY1qrKMeC9K/+4+T6oJy+Ncmj3FxMuwDKOSQdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1qcCkM3I8t-00OAoP; Wed, 05
 Jul 2023 10:55:41 +0200
Message-ID: <91519789-a7b3-65ea-8b72-e39852ec4188@web.de>
Date: Wed, 5 Jul 2023 10:55:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Minjie Du <duminjie@vivo.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Ariel Elior <aelior@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>
References: <20230705080819.12282-1-duminjie@vivo.com>
Subject: Re: [PATCH] drivers: qed: remove duplicate assignments
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230705080819.12282-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UEtH/H5mM4MU9s55C3QB3TcIqKU8mKf4jOGhbI0vZ99pv2z3Do4
 36FPhISNFBAwzEWKcOiJxUX7rGP7buQZm/mrR8dF1NUrtnzH6ZMr5ndYJP77qiAH3uSS/Os
 A4+ZbiTDlpaL90jSKljShhNghQ5v5mGux2ku8mqgKqaGEdK/l/vt88fII9OuC98+WMiFWjU
 +GCufzVlh+cpYg4w3V8lw==
UI-OutboundReport: notjunk:1;M01:P0:YSB8ENFQZ2I=;BDYmg19FNMFO7TAWW1gX81BNiq6
 vHmCBbEeZSBKULA+w2i3Id0wIphZJ2nJUFUPOAKlbXgkLQnzUFXyOxX/Vj6H+vRr5vT3iWuzk
 hM0cJ2KaZsrLT74MkQigazpNDk7wdOy04842aOpUH0OBJXlAxExIxhUBnn84cCAZUumIEdn/V
 7EfjI3avAeWFfF26vtb+5QjEQ2lIQJUhPZbY6ebYexAzhFZCCI5OnI6+UGi8SomzL4FTQO5zk
 wb6ah1dWYGIX6PKfmqkBPWny/wb4uL02UT938nRgdEXhWH+hwAeScn9IvKhF8aQQKEmbJsjhT
 FK0dgWWgkzkmxyGcx9nMZRqqbdqS9fQlPvjtsfasVpwqyZsvdE6ERk22P0p59AwbJ1Zhpg5SH
 x3DoF7CaApz1YyxkboaBrSgPI8/hqSaKFqxxef76QNAScqnEXbdT8y5iTQ91slIP3LF6IvipV
 qcJfCQuuuCOcLJDdhFkE+XSON4Aqo5LzZvM4iyjc0H/VtTnmlmj9rZPePyIEgscQmSfD3DvYg
 JapPQGfpv9pJ8I/o45AW2/MgaEY4btvPTdSZ7vBx6PieYsJi3zfVV/6Q7VN8ZMHW+EBkixJDB
 o8ka87WOqHSesKsmRtZ3bNX+KrTV3QZdH8Xdp0lZgIWSg1t5hzc+zetbBsFSJFxY1aMQfBDrb
 7ypbDS3ga+Nq7K4YGSBfl6FZ0iZEtWMgK+zVHABNb1piMDCl622iEJeWDhuSxLgosnYYksVDb
 Z+fzTMFmgmc8hOadHCeaYOK0sOnLoPHtBib0tBW/l+6mGnrIrq6aEM6z6sdKpeP+AF2i1ORXy
 trO6JGM3KO50Kez7dlwIoqlhBUqD+Xe8Rx9twrlh3oN/yDx6KOyoTBYj4OPHQhT2heUIY6FB9
 MO9EX3cGMXrP1OOzJpABjiM7O8uJ7epgPqDKLvklCh4z9GIxem8cjBeTZ9zoz6yNwBD73KPUy
 91zfeQ+hCDFhtJzL2vxrhY8iB6A=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Would a subject like =E2=80=9Cqed: Remove a duplicate assignment in qed_rd=
ma_create_srq()=E2=80=9D
be more appropriate?


> make opaque_fid avoid double assignment.

Would the following change description be a bit nicer?


Delete a duplicate statement from this function implementation.


Regards,
Markus

