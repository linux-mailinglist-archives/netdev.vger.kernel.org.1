Return-Path: <netdev+bounces-21606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A948876401E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A4F281F57
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEE219887;
	Wed, 26 Jul 2023 20:05:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E54CE7A
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 20:05:32 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11041BF6;
	Wed, 26 Jul 2023 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690401917; x=1691006717; i=markus.elfring@web.de;
 bh=QHIphQkrePx2Ff24N4T1WpAsD8SkqrGeg1lXHy2wMS4=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=kZjkcUH5gwe+QFWOiYyndgdEFQX96nKLXYI6iFPdxF6/j03WmA26hz+Pr+42uMHOl76Uul3
 E8ya19JpVadVRHoCwC0MzYie0Rf4QB5oMXeSBW/a0mbD6LTG/3M4I12OkXM1RoEl3DS0AO9EO
 xpkHo+QtKJEy4Ag68DkUhdPH32vNyhR53hXhjdK40rZYxRZD0lSq1jdd+7I8k8sbiuMuFdiO1
 W3MpuILZTFWDB4C2QyEFwHaVLgiUcCfvrJ3YPv4JF0FTCRpymUSW64jHrHTkVZ14ynEeN8DpC
 gP+CB+V8D4hBlR3sWBpWBhW0GaJuKI5Xl5FHaFfePB/Q1C53dbiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVacq-1qGwhd1WOS-00RiP8; Wed, 26
 Jul 2023 22:05:17 +0200
Message-ID: <662ebbd2-b780-167d-ce57-cde1af636399@web.de>
Date: Wed, 26 Jul 2023 22:05:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
To: Colin Ian King <colin.i.king@gmail.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Lino Sanfilippo <LinoSanfilippo@gmx.de>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230726164522.369206-1-colin.i.king@gmail.com>
Subject: Re: [PATCH next] net: ethernet: slicoss: remove redundant increment
 of pointer data
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230726164522.369206-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FvM7TXWQjFRQtt4f1AzjJxD1tUVIrmog5fSh96H6/FIc363VHtT
 pjBK+efMJleDt83AwLda4ohVHNcmm9RqT8r08FLX+GKTwoZrwUbJ4BpEcl/poRgTepdBr+/
 C3VDi8JuxU1vOzbmJz/C+s+XTpgY/eBVptKShKXYApbaNTQM4O9R+USCnW6MmTL6+MyrUOJ
 8Pc5HJtWlsvNJ37y2z/OA==
UI-OutboundReport: notjunk:1;M01:P0:PcT9UpwjRms=;gBO91BwF8AMDqwz3HtBO3sAt36O
 dPYZzQLq0IvHYinNncifRBWZel3fvO4faHU3Q+Zd1oG4MGIOrMZoppHxyKz14o686cSiV69qH
 YX6FlryQkY7WHEesyGTWRGUmeQEHHQw1HQCcvQaI4zqRfsPBxngXRvwGOSd1qlCquUYHr7VeE
 mBTHB8NgKev7+iR8APrfvGiAVlrXrcCPYDkkXKjgIl326AkanNBKaTbhi159oagCTJUy7mrKq
 K7SPhVEHVGC108OHVaAXxsp6wT1FAwlZqmWQfogZo1Y7zUsmEzRSUJkIK8NMkrR1W1sds2Q+T
 n66FLJZNm5f8LXYoe9PnWvWcIM4Vop2NemeoVLiFAE2ICbwIZOI+cVvfiJ9O344f2lE3aIs0N
 2LtDEpzt/ftqS0qFGqW5ROXKAbREPSA48+xWX5myFhfIz5fSmcmJTlKYbSALZzOnqrdJqAg+W
 oA/DZoJ5Oa1Y4jQ/h7luYl/0D2TgBY66GxovHRsiyMKDW/fn17L9RDnkdrhKrQehGSIdM6eAO
 quVkKDsxRl3Pk5GHRjS2VdytRnxFfJCpvL94xJUrVNM6iP+GtdG/pJCrKqWt95sDfj2BRjE80
 CBRkYrZbSqUtbQ694YlxfJI0cQwMVN9NvY3RVu7aiXA/I3zmkgp9wHtcRA3ZoExtYJEKqAeUr
 Mml/LEVfIj0Qkya1ZBLW4OnJQ/BCAUEmY69Xef5Xds5IYJEQv1nnbnzwAA3RoVlv5pZaItCU7
 NpuqE4+6P818BqUBS9fRxVfC75ZttytnZ5N4X3usOwJ3wXCpzDscsiaAX3v/gQzOrBwfDOR0u
 JTsxyAUNgiiyetUxhjsj2p5MoNrCRzFX4fxRN3PFfOEQF9zRFAnattCdZpnl7fQGB1a5GONMO
 hgcm0WmLEiZIAuiTg1QWwfHrZm9jEqT5lDYX5mYnqPqxvaIErzs80GyU2b7JRfnKGt6PE/urv
 99tJhg==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The pointer data is being incremented but this change to the pointer
> is not used afterwards. The increment is redundant and can be removed.

Are imperative change descriptions still preferred?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc3#n94

Regards,
Markus

