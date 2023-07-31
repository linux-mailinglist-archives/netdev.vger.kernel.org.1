Return-Path: <netdev+bounces-22833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E002F7697DB
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CD71C20865
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42C182DE;
	Mon, 31 Jul 2023 13:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C58BF0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 13:39:39 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176051709;
	Mon, 31 Jul 2023 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690810750; x=1691415550; i=markus.elfring@web.de;
 bh=ttvtMSuPAlYyqFYQK2AIbrnJr1ZUEi8CEmpm3DAIRqA=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=C6LaAhV9xqn5hWkFPGhB1KMz/rRDveri8t1SnGzqgzWLTIPyJzbAD8mslnTaKCWY5nJUFeS
 PKY/2ZRdNjt2tA/J+6kTwIIz42OmzuzgS2rw0DnjuaTYVeEZiIGhL2Y/Uw3rMnq0rl01TML1F
 oZgDLARQ4mpFLFUI7wJ16JD0o316kOmHaU0x8dIdYgVNTHZauPu0xcwqW2E5JseOg4/tkqZE3
 pm5Zw8KKGmYvahBP1il72/dnJ9TAwKSAV6AjVRhfeEgPJytMYuHaBU2w4zLg4Av+6deNrkAUr
 Pbd5w1f0B6WzFqPPxXi62d/i7k7fcUm66HPYuJkjLGzbOszIFKhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIkg-1psEHy1q7I-00cWHJ; Mon, 31
 Jul 2023 15:39:10 +0200
Message-ID: <fbda76a9-e1f3-d483-ab3d-3c904c54a5db@web.de>
Date: Mon, 31 Jul 2023 15:39:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
To: Lin Ma <linma@zju.edu.cn>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Alexander Duyck <alexander.h.duyck@intel.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jeff Kirsher
 <jeffrey.t.kirsher@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>,
 Petr Machata <petrm@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230731045216.3779420-1-linma@zju.edu.cn>
Subject: Re: [PATCH net] net: dcb: choose correct policy to parse DCB_ATTR_BCN
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230731045216.3779420-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0OfJ9W+77jg2PGV8ovoagdm+xbveR3piNs2dZqrQpSkt3kJQJRp
 zeyRikEJK7X5bqSf2AXDaaezzKVVOr4ewNLuPm6cXfvE6B9sbZmPQixnFEa6puJhGg4j8hX
 uIktx8/tol18hLActb0k3pm/B7mgHFWh8RP7Hs7bGt7gl5XbJo3OVFrxT8Lgn/RgK/bCeII
 WASDzGe0Sp4eUIwbMNz+g==
UI-OutboundReport: notjunk:1;M01:P0:7zGnNaXZgcA=;j5WkJreH4B2tNvWLAh8Ev2hKDU9
 aFMI01eJNxomBWc0tEBBMkzgoV1eDWEqiCYXV5mfuFmhR9e1Nz/RKhzBSU+VnKDQ7+owq/Cwt
 TOWTeKpkfd4ml1bvQkx8CZTusnX/zrzSsP/yYK+N6Df0VcFIG7MbBCm7OZYxevj6VejKanMqq
 MlZiKN9IFJODFPQ41BwMmkeyUKjcDJ1C8Wx5ceycL//guV3tl0CIpBYXlvlV5XEfgsEuSyUm0
 XC2TR0VmYiJJiyOomD0TxsxcbE/bd9rU9TrZDwOZ9BvjR/AGehlm+QEEggN6PWuDDmTRAP90K
 lXYcprpC+urgs5EuDVRAjVLtX0KbqDjceKguk9jvD+/E6Wvk6EC00ZQpX6gcaqnKoKlAI9vqG
 d7yoGcaudjuIR9KKszm6Uy2r5k86GclEvW5w0dgBraSMNmHCmXztwE4Y2nInzu/exEkDDPHNO
 bj7o23O7x37j3Ck/qESM8bEpp/DkbzBVsNGBzhd9llPm4qN7RYUJ0SQueb2e29lXI1OuLmyjp
 5xd4t5bjCDN4sZ/WJm4mc9to3o+FH9qUIPXTkn++lizYCeyxzTxEN24e5IbBFO8kH/BSLXIVA
 fJ482B5tm3sgnxjGMbazgSfIys5Q/e6Iqhasel6Rfj+TBFtR0V50WWC1roaBuPtJ181fzhLuG
 xm9+umEXJA35jOsrUt7fl92gz1kJstElW1yKS0dQ0L3yFvm7ELUegBWlJyUs2iFZPswLNoTCK
 BmeRkTeSVZfEhfrtCxM6P74t55G8Dd/XNP7fejdE3am3PCikSpxIyWzf9NYqYuuX/VGCMfzLd
 bNGlGqDfNl35+0AgxLAK6ifcExTx7G5TU6gN57X+RVxGfyoDmMzCBhw8jkGvCgV6zoguxFySF
 MmPdmCXrAm/K9mvUJsgoGZ9t2lhOI3Ij5RJ5T/pKi9XeOp66F+BXYgO782UddQTldK/ogyfAY
 Rzq/fTIiJuTp4pzSv62lFEzV8y4=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

=E2=80=A6
> This patch use correct dcbnl_bcn_nest policy to parse the
> tb[DCB_ATTR_BCN] nested TLV.

Are imperative change descriptions still preferred?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n94

Regards,
Markus

