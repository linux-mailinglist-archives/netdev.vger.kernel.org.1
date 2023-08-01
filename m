Return-Path: <netdev+bounces-23451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F676C029
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A640281C0F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45F275BA;
	Tue,  1 Aug 2023 22:10:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5F253CE
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:10:04 +0000 (UTC)
Received: from sonic307-8.consmr.mail.gq1.yahoo.com (sonic307-8.consmr.mail.gq1.yahoo.com [98.137.64.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC24526AA
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690927788; bh=Qfs51uYu+80oXZtS8CxdHr9jbs9U6glCQawRyyqAHRY=; h=From:Subject:Date:Cc:To:References:From:Subject:Reply-To; b=i762upk6Pjb9Wpvw7x2Iq4C2wSUWB1MfCExVC1qCGsfL93XSQtD/J0WL35NFU+4zPjIxURK2TVeW72K+pDIVkokoekYBe74QLwjGgrlWR/8IlGiWxkOX8TrCT4OrWHzGHzA0mW03PZgWGZlVNqQDxaUkSqet4nTsaY9Tka+H7d5x5q/FH+20X57Rs9dH/qihfN/qj+hAPTTP4fMWW/SsJUuH4ftIgbK7taFlxzb0ZZxNhDasewJFSMVZVnIl/R7EoamLpDr5ISZ6AlUCzj/+9GcNaSPEbMeGiQ8JYIvFJOKFmvMePWmTIPfdvkjiUC7rwZOZZuGdpH4DFKkN78eEeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690927788; bh=EXRwWKEC5qdzk+j/RZmwU7ZTgAi+zEYK75VHsAGkjpB=; h=X-Sonic-MF:From:Subject:Date:To:From:Subject; b=J8oJT0pIQN7LPM3Bvb++nQaVWU/LQrGnTQ5mhDW0deGDDb4hil7JPcgNUSbbkO+oDt9nIKxaz1tnp5UXC+CP0Xaj9eJpO/9QPjWKNgujt9EhTkLsqGHEfPqOOqWr2gDh3hRYPYI6Dzm2ITigK5Dgna+YRm7j4NBkXNygIdfmlChMXjjiREK4BHcE23JnNAmuTXFAXAhLSlP31Mj1MbvbCgiRv5BUlmNuNS14NKdlG3xC/RaNUFBAo7ge9RaSRci4zG2cwmmEPc5OM8V50g5SS+rQm+/XwfzZi7NFZwZlNNxgqNFnKdohIeuk2TLajPeUsJ0Ag3Xt25f6B9aEMiYlfQ==
X-YMail-OSG: wBGB0ZgVM1lwbUzecw48rmA0DF8s7S0qZTcGD1u4FZn_YCWPLS5hxILLehEulQx
 f07baQr5VRrqPw7dQ07by2paDH0jkq916ALDUQqCaxgRWDVgujFjOcwjwcsCnlvGs0NiqoPhVESp
 MLCF9hyas4YCnEJ4b7wFoLot1OMYAPCzgVJ1mz95SOAqGl3hDXpOQm7gRJZ_oqfIj4GTTi2Tq54u
 _gkiR2XoBG1kZk6nDMS1kMnh8Lm_Keg95kYWEoSTkIVgO8bJG8R2d.zSY30yvF7abd0SgsJPLg8u
 YHvj7Redy84quJrG.pBuroBLcBYKffnQ.J28WjzHqrx8u6ou3gQxAEsaiyRYn.GFOKU15cheIiRR
 l0j9b9i5tY.PVrlD9UEOkTeIK52.NEjTfOdA2yaHCySFKaJe19XDMfxoxKzvtVLroEMFAQJ5X.03
 nWwpjwZdtURTDThp9cxrgtZU0zAv5lpAegaLuKCAwmsj9Rzd6Fxg3uKX1NKnmw9zIr0sYCZj.ZV4
 24LEEJLyauDg.XsQJO5COQ1RrmQFQCTagPmeyTu44Ftei2rlIkyCBTvcCB9UmWmRd2LQXS1o0i8B
 .qhQ86gYoBKpDuMITrJSapCi_r9HoWeygPkO5XEJSlzeaRXrdWezoy5l8.cViaVJhB6BJWgz3wjI
 5Ty.03G_yJbYUUAEiLXvcWigLpjHqb2cH9Z5tZKnNr876ca6YAyMFKAU2aXhRcXUDg2Re7GVTLuS
 rsN_X3kh3IN5s2lFkkmBfhajuu23mMT3lfQApQMr9Jh8NO65MPJGDJsKwDBPPS0Ut1Q8_9xJZOYx
 F6HuEcgpsMHyXFdg3gGPKRyHy5Sn488WNgkpFHaI8ETlF0BXryD3v4lrV4yeLEuGrIPc3l__jOEp
 XTGFgmsj4ftumed98IJKn2oXLwGNjZWE9fntgPAdVHNVcavs3eC7nP05wZ7ROR0UNWCCEGKio4zu
 0pJ6b7t1c0Za4U_LK8o9GZ95IUPn0jRyiWvu0IlasvwRdsxHM.oyyqkr2qwOqbllQ_AbyH07.qXh
 P3eq4RwuLG1dcsB_ya6DVX0qKHjHzNoFAZB_yw2zqkAw5oUPM1RKmrlmoRcsgMmeNhnO_IW3S66B
 yVQzhM0jZcsousTRqErMS.qRhhQ6cZ7wLhWhB8ZVIVOfsp7mw4FE7F2ctwyicdCwNMIWno3LCfVT
 QzylZ4Ssb8QqcjrPKzyu56qTB0W1p.ebTSw07uytDd9dTfNM8aZCkf3DtTmIItaB8lLbGVXcgG2e
 irwzz5EfT2dCX9rMtR9Cg5KmdfeWGBCDMgUpQ4fBWKQ8EOj1qWRTpGIEiWx457s2N1dCu0m.s7zU
 sNsHwlo2Pdg83yZIotm0p9TZaPCUQU.dfFCpZG44EfktianeAhIGEicS2rCdiVv6eZPOdiO.d7Zc
 GZNzq6oYyT.ALfr9_q.UgaFPdn9D62ec_qC91kdNKhS00omFdDN38xHB7t2oVGB.o6CNYYmL7X__
 Vlwq1x4SaZwp3ydILBc_7YEe9fN98XJNH6tZKN7dL.MSguhGubWxJuN0LR4oBjNEPKokqU5FsQbx
 pkFhHOCgKO3qmcscXg1T5xbxy7ZjzrwVwK6_rT6y6bJyg46OUWLc0PdY1xCNS2zg9tZnowcwBNE8
 ZRGqj8QOLsM65NZA5hbots6Ydb1ZSywT6s_Vpo_l7N4RCo3aXszmAMg32tAPzhBrqeuoNz5BbDwz
 WdcLnDY3FO2AjCpqyJ7kSTq6HiHHOt_jCBult_IqRKXTU7AuS2E0AguUBouLLKjsHC.Np6qLZcjl
 Ji6uXjdNiRUO..kwlvfIwTPMW.oAsUMfX7oB_jAcwfPoogGUl2k.QkMwOt7wge7lOqo0kRJVakU8
 xZ7eckG0kf36w2NeUr.cr8VSITL2cTvLiIvglBEgREeSUiMOi_z1BQGfuym4v7nMQjMQcWUyiC9A
 YAPywd473nC8eNyszvvmJ392G2_FIEg5evZyJDDxgzVxCUyauB5eMWULKpv6NeI5szrSYuFBm488
 vAHDKktzQJRO6UvuhEaSrcOGFJZTnxIDNlG2DhSAOxP_528gd_pDMQr.fjuckgQaA8YyKuTqXlpg
 CU7uR9dDcvE5e_sPSOqeq7nOZndJo1cnnY_WDd0qYN9zv1d._Qsv7PkovgMUcA5QNmMJ1q5_aNQm
 4ial59Iiy9EuaXF02UA16RqafQam6mIhInvKT418_o3IrhjiU77oLJcdIy8pEMrEeAchfaBDrG62
 THf21WiunuA11i8kPp1UsygyHnC.3fPw-
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: da23da57-081b-4d47-adbc-85879b8d9cf1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Tue, 1 Aug 2023 22:09:48 +0000
Received: by hermes--production-bf1-7c4db57b6-6jtqd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 36cb2fc05ceabbc59e58a7be4fe4bf35;
          Tue, 01 Aug 2023 22:09:46 +0000 (UTC)
From: Astra Joan <astrajoan@yahoo.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH] drm/modes: Fix division by zero error
Message-Id: <84C84E4F-28DA-4DFF-B2E7-83C45F54C061@yahoo.com>
Date: Tue, 1 Aug 2023 15:09:32 -0700
Cc: airlied@gmail.com,
 Astra Joan <astrajoan@yahoo.com>,
 daniel@ffwll.ch,
 davem@davemloft.net,
 dri-devel@lists.freedesktop.org,
 dsahern@kernel.org,
 edumazet@google.com,
 ivan.orlov0322@gmail.com,
 jacob.e.keller@intel.com,
 jiri@nvidia.com,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com,
 mripard@kernel.org,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 skhan@linuxfoundation.org,
 syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com,
 tzimmermann@suse.de
To: jani.nikula@linux.intel.com
X-Mailer: Apple Mail (2.3731.600.7)
References: <84C84E4F-28DA-4DFF-B2E7-83C45F54C061.ref@yahoo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_B,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jani,

Thank you so much for the suggestions! I've submitted a V2 patch with
the updated code, and also a patch test request which should come back
soon. Please let me know if the new version looks good.

Best regards,
Ziqi

