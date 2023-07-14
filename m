Return-Path: <netdev+bounces-17946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D5753B7A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE0A1C215C8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12213738;
	Fri, 14 Jul 2023 13:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0313731
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:06:48 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB430F2;
	Fri, 14 Jul 2023 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689339970; x=1689944770; i=markus.elfring@web.de;
 bh=IMazx3l0r+WPi+xzUemFv1ZnT9qAVpQ7h87A8lCXAyw=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=nKBROcW8DdLLaWfad343tlaLzz0PbugMYTk6fZv9kvjNjRKFvbI2jYS3lfDysAoRPy3hXI5
 yevnJnhtR38A//AtZqLfBumSe5CmlmY47ngKuWGFnweCmB3zmhJfM5e6+tbUmX/Kmc2GG9JA5
 ZnyR353RxysCEg17CBZYbPgR867Hyi5xHNDEGBp+hFDlnvYi9MhTh5Uhl7U2ou+wuqX0WtO1Q
 Lfwb1cK0Rf4cDTHnbwkSwiEWKlCOE2OZlbcmHSplXx6mvHYYk27010o+dNMlmVPsn03NGeVvV
 /bK4tH/1E/T7um2ko2jW+p29d7Tr1uTm88PHg5TWukGF5A+BKzNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5CQT-1puphX07z3-010jPk; Fri, 14
 Jul 2023 15:06:10 +0200
Message-ID: <be87c113-f975-9607-1f9d-5db304e0b1b9@web.de>
Date: Fri, 14 Jul 2023 15:06:08 +0200
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
 linux-arm-kernel@lists.infradead.org, David Daney <david.daney@cavium.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sunil Goutham <sgoutham@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>
References: <20230714100010.12035-1-machel@vivo.com>
Subject: Re: [PATCH net v3] net: thunder: bgx: Fix resource leaks in
 device_for_each_child_node() loops
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230714100010.12035-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zn4pWRNvcyoinnco/eSvUkAjSaR494TzNyPsCj75/i8bGUjC/Tp
 FcE/xx0DwZe937F1ncGXuC1RellkpihQkE2ukteP/iN3lyg0F7+xlY4N9ezMUNd0rv0Luje
 V14ewzNMe0H8f4HqIctHWrjn2PSEUEFiHjIodokVmzoSil/suvrvCsrQI8Bk4msxLlKyt6Z
 VPfYBnKbXSxhDEY8SVR5Q==
UI-OutboundReport: notjunk:1;M01:P0:q90NtNL1VAo=;V4CJKiOCeDjoIjIxbHL3f6e7L80
 QMD9UfCjgi/bJsxO+rdEATfX4GE+D/l3X7Lj3S+gJkMq4UlIKVn+kBmD28iUjfVobZs+MgEMt
 ujAbssYm7qsivAH3VsIjTivX2roRcNLD8wY6sba+u/LRYGNPn6nMb/7ytKSb3wZCe/Sif8Wqd
 PzF6XFPW0EzwEggWt1b7XS7G1v/W7dVjyRVtz1G2mtNPnqZ3jtxJ5Fkndyw3qwjC3A0UAWMa2
 5adbCYcQtSbZc6u8WvLAWrfgo6o8SdrpjK8X4ySM1666Da8r6LXy6CU/3ob8sQWDzVDuhMkt5
 D7rQYL/5dBJrYIM7IgSvQg8S4ynkPgCdtlvE955sIHWEZcHMaMvsdSNb+E+a6/atSysUrLYmk
 cAyz9XuwPnWnkuBBAUToMFwtuB0mkIuyQLrNvzua9m0POnlPAGWUMY72Gl2b2E6AbbJGCWgRE
 He5uNWYzJGe1rCgLABdnEI/hyou51Av91CxvXTAEQsuZteXdHikeYB3r7hlaOwIXQoTVWP52W
 DW2DfCzYc1aqhL7QmOuJlgIUTCQcffqbEF5bUR5cQ7APxxBZF6O7fTRgjg2zvzGr3awgGjp1f
 XhQ4qPXZC9goTkX/bRJA7/3Jxw1ZFiZzSww/GhPZOuPYAScML8O8lVSGTb5kncKuGDUIzRnRR
 J3sktadvwWIQG5LIOPUxCUzKs4GxszPhGylfxkhWDoQ8rN7ARXKdfp3DqnU+Ia8qWSr+4SdOJ
 L7/J637YSUzMgHahj1lymr0nkTX7s72ly6dnIJu1XHacgoASxsz5K46gfDmolBOHCU6w+PSqv
 U8wrkkYESxmudSrUZEZ3tyJW50BP4JAC2mSGCpjNjjlrzg9DXMKQbA5M20i6SV3L0lA2/uHnA
 sApibTkSuZcbXvdfJiz7wfM0sSLlTMGwYUjhsFi0B7njQb2FuQurvsPt7NN/AbUvB+Vyk9cj9
 hRPFgj1ch4UwNoedah6SckrJJZc=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The device_for_each_child_node() loop in bgx_init_of_phy()
> function should have fwnode_handle_put() before break which could
> avoid resource leaks. This patch could fix this bug.

Are imperative change descriptions still preferred?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n94


Regards,
Markus

