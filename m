Return-Path: <netdev+bounces-17807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E71753199
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E22820A1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349B6FA4;
	Fri, 14 Jul 2023 05:59:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D86D38
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 05:59:04 +0000 (UTC)
Received: from sonic316-8.consmr.mail.gq1.yahoo.com (sonic316-8.consmr.mail.gq1.yahoo.com [98.137.69.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02F430E2
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689314339; bh=IucuZFC4twdSE0wiFurhHfuChGoft8hemvnGyTnB2oU=; h=From:Subject:Date:Cc:To:References:From:Subject:Reply-To; b=PkM+mJcvXPYLqS1Kb5QbjkNy8YUEYamtSmNGZ64qqE5wWhBieeCgvkN7lXldF6BnzbdZUJE3U9kYGoO3c5DaGdfXObdlRPULcVOgBym+/RyW8d1W2jcrDZWhbxguWQA3lkNHZ6aJFjvv+s/7NpAXuiZ61g0kKUOfnQgWg1x3AanYxg586ae7FYCWE/ZQ+5dqflxQ03HMQWKCjeJSjeUr9Uwd7geQ8stcnFEA49NXYWuxEZ8tCIZQAOHat8+ePuNm4Lhbs7bwmsfRMecMCez5i82U190PaDty9k6u8ihZWueH5Tsk2yRklNV1H4QcF7mYYLoycuLbNoIKmLUeUYfp1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689314339; bh=EYutmTr5xLMic+ccPGr8jCtBSmC1tgx2kSGW2fCXHRW=; h=X-Sonic-MF:From:Subject:Date:To:From:Subject; b=Wc1az2zb5ZMoIY/m4k+jLKQI7mq2VOY++e/OMdeS6qyyTkSIzFKe0vxg05BpI8EOMCmZZuZIl0Ix6dL8et727Bfg0YS2eBmLRHrlG2BvBP9eL4B47xhl/HwbhbvAGWpUSnauoEBMwf4U3mPkPUYD1RjH7G7v//VUl6BnuWqF6oC0BICL7AlQRke92qXHCHO1AzrCe3Rw8rNNIqbBoAoZqbVRszgQLFu/Ly+SP0FM3IrrqB1TO2P1zwhcUnFPf/RsWoPeCHI2DX6mTuktwfALQV/aLRAf/7NV6Iqjq+rY38x8CByA5PVCXCy/ctV1E5KceTZesB429dJCOe0iwjXjKw==
X-YMail-OSG: vDeTvmQVM1ng_IzF.D0Kw3rwgtmHFjowLY5VZQ0ZWQCCmfvuQC8YMAG5uFCpUZo
 uQKZBqsQq.X5_4FKiGxa2LQQbpQIXvIos8HC9KOwakE2EiJItSxKgUSOiKjeItS5L3_WC4jlZbRO
 egh7PzcST18cHmf1HnA2wYwqoJBXTg.gUBUZl6e_Ws1AP.gQIGDhWZYCdzAAJ1FmVS7BiN_NCyUD
 pV.8qYEoelUep0hoBmaIF1HL50WbMM64Hhr7TpbubRT5JAjKtvPgyX6sEDV0Gx.Q.5wY.nG7XD_X
 Xa3cyUJhRku6pc1_ORN7GptC31HrRnPu9QUidLTEiBDr1MhaniTCIZpRfC99BpIHDBW7SOD18DjS
 d7dyrsytzUZp5V_LW0.W1J4iuIOCUCn.ku7bvSbT.CjdmOcEmYgpNy1vxa8J5i1OcK34GnEI2kyj
 QqUEpK0q1XsTtUl158D9eE_dqgYVc7GpFF1aeB_ndS6TOYFWL7A6EhXh_uuEnb7gbyT9t6CT2S9n
 4VWP9x7r0ALX_5HWmZD5PF_5avE4mfjTfbDglVbQDjl1lSKRA9uJ5HCN131Rn1CBi6UjZTRsV.CX
 WJJ7owIF9UUQ1GqBsgHKT.82GHgR7lm2wK1H7YBnrxF38YIsd0qdg0ZwbzxAuAF.jOSIOi2wlaDB
 OYerjAg7eywZWZrelkKXYOX95zEQePoPicr9hLyOz8PPnKU40J66Pw65GqnWccc87wBAX5HfUy.9
 omE.r.IuKJllf4ixLSigE_MfdUZjTRhtcTxkRWLepUjCCS57rRNeLI9eCDHrnOx6w8PuBNbnMWrw
 pEGwMjsYa_PhuAi4O.2u_r_ZCFhlIOqfD4hGgkZzKoSiWsn4QBP00uhEeGwwUlEjM2ssbhYGZa5W
 T9Qg9hLxd0YIngc6umDaPcm6AvpqYcCfOVdHz21nxfIzXcpU3IW5A3SJtctVrmpXsHUo1mTfUDBv
 HXHtE3WxgS1jelr6nQLyriA.x4e_vrV4YSokAyJr2UHxPjEQ9NuHxcOPcBHOWcd0fOqJ3LV_sHzQ
 05dR2sxvrwue22S2YGhC7W7wqDRbqEbPLAE0VMcalYG1L2Hgjx2qLM5JqpXHywvYa5W6396ufZfD
 x_qpIYEFCm9crEEqlMzkfG5vwzfdVt6BVIGIGKk6quaTZVi_xE7njqDjrtUYCVzLIy6Xot2DEY.E
 3oRrdek4EmB9zSMRViCSHzai41VkScDw7b45xLcrjB7XVxjGeV9OcUaXnFKBY1nI3sJ5gj45EpV3
 OCjF7YHP3nBw6jmKBHdFRtlBWw1G9W1nUZjNAYHcZuwprE5uG3qeNEf0hLL8kncmAgSRtxwYWpE4
 BhwtWFEAzJNyj7qpNG2sXntO.bwoTsus1iYx7DSijygBmZU4frtxlCcjOasTiKAS0CpCLMbRg1eD
 ZBPxTejkE.POS3c4FkK99E0MHEQ14F1BfraFF8yqwvMQPVq3EfHeiWeMQCg8k6omHH6ROE6Q5lVX
 x6eRKKv3f2aj6StO33VmYD3B3aeGmvClzN.JNZJWsgAWKJG9.H191e3C_BiJF6fPBSg09c3RC8n0
 30isxIJtdwtE0jhyG_NM.1uqvExX32HgV3KIyCfD.YoIXzuhBpDEud1x5KvFSWAPuuWHS_lCM19j
 RMXrawBFm.el4EEgmKz6Z.fhH8ljAeUx_iN3uNSQDrf4qojCcF__Xf9UB3mywbTr73vL4mSH4Uc6
 6NWKyrTVXeJHR.eBybnJzuQ7.IvwYDSScQxD_02htxCoWWq.uHgIVgu4az2wA6kou17HQrT.I5Fl
 S7b1OwTTCfiao_qZh2t5ZBRkDPty5.7eh2ywPhOIUgMMQodSTpqdVZ39kegaopBZuvKFNE1uNSvR
 YRPq7PbUxnG07_s3hl4JKqQL7S_R5cyIzDhCNAdl3.AobTOkWCSC8u.XOSZple_qkpoG_gE11x.X
 D1bS6aPSVM1c8SHASc8aaIMOZljrBFYfvELHvWNQteN0lJVczdH_0IMqJ0RRtiUmMQYsXFd8kKQo
 oGxVVK6tdGaDCsQTNQ5mefMNFlLPsXrzwNp1Gq6dSQ5nEOb3hHVO6QIZLOZDH_PMiXuQJ41wy7Kg
 BxFXT90S90CgQ8kBrzf8xvNwoLh4J.nVad71V8RbVVEyt3Hn2Tqpw9RWCtnbibuYkA3i4VljZiom
 8D8sgUBZamk9F7yVOUjsOrejMLof8WNm958Ul1KDLu4O0VkS6uA.49QJaMEaD62LSmnCm9zle_VE
 vzLYBLIg7FExAN9drmpX1x1YoP_5KF7LNjSua2C0-
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: 144bfada-3699-4667-a0b5-1e3a9ca23a61
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Jul 2023 05:58:59 +0000
Received: by hermes--production-ne1-6d679867d5-lhbf9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b02638019f85d059c6e11f64349b2a8;
          Fri, 14 Jul 2023 05:58:55 +0000 (UTC)
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
Subject: Re: [PATCH] can: j1939: prevent deadlock by changing j1939_socks_lock
 to rwlock
Message-Id: <C29A816B-6E28-4A36-AE59-F446180C910B@yahoo.com>
Date: Thu, 13 Jul 2023 22:58:42 -0700
Cc: Astra Joan <astrajoan@yahoo.com>,
 davem@davemloft.net,
 Dmitry Vyukov <dvyukov@google.com>,
 edumazet@google.com,
 ivan.orlov0322@gmail.com,
 kernel@pengutronix.de,
 kuba@kernel.org,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux@rempel-privat.de,
 mkl@pengutronix.de,
 netdev@vger.kernel.org,
 o.rempel@pengutronix.de,
 pabeni@redhat.com,
 robin@protonic.nl,
 skhan@linuxfoundation.org,
 socketcan@hartkopp.net,
 syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com,
 syzkaller@googlegroups.com
To: stephen@networkplumber.org
X-Mailer: Apple Mail (2.3731.600.7)
References: <C29A816B-6E28-4A36-AE59-F446180C910B.ref@yahoo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_B,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stephen,

Thank you for your reply!

Changing the lock sequence may be difficult here since the function

- j1939_sk_errqueue

has may call sites. However, this function attempts to hold the

- j1939_socks_lock

whose hierchy is pretty high in the given code logic. On the other hand,
this function only reads from the

- j1939_socks_list

which the above lock protects against. Therefore, it seems appropriate to
lock the above list inside the function for read access only.

The RCU approach makes sense here, but I probably need to use RCU in
conjunction with other spinlocks and rwlocks in the codebase. Would that
be okay? If not, should I be looking into replacing all the locks with
RCU? I'm actually a mentee for the bug fixing mentorship this summer.
So please bear with me if some of these questions seem a bit naive :D
Thank you so much for your time!

Best regards,
Ziqi

