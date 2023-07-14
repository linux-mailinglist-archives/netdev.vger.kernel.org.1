Return-Path: <netdev+bounces-17806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1483753196
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C94C282073
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BAF6ABB;
	Fri, 14 Jul 2023 05:59:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5096AB0
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 05:59:04 +0000 (UTC)
Received: from sonic316-8.consmr.mail.gq1.yahoo.com (sonic316-8.consmr.mail.gq1.yahoo.com [98.137.69.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCB330DF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689314339; bh=IucuZFC4twdSE0wiFurhHfuChGoft8hemvnGyTnB2oU=; h=From:Subject:Date:Cc:To:References:From:Subject:Reply-To; b=PkM+mJcvXPYLqS1Kb5QbjkNy8YUEYamtSmNGZ64qqE5wWhBieeCgvkN7lXldF6BnzbdZUJE3U9kYGoO3c5DaGdfXObdlRPULcVOgBym+/RyW8d1W2jcrDZWhbxguWQA3lkNHZ6aJFjvv+s/7NpAXuiZ61g0kKUOfnQgWg1x3AanYxg586ae7FYCWE/ZQ+5dqflxQ03HMQWKCjeJSjeUr9Uwd7geQ8stcnFEA49NXYWuxEZ8tCIZQAOHat8+ePuNm4Lhbs7bwmsfRMecMCez5i82U190PaDty9k6u8ihZWueH5Tsk2yRklNV1H4QcF7mYYLoycuLbNoIKmLUeUYfp1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689314339; bh=gDJtLqCmwB/b5UnrUpzqw+I7MiQedvdQ1kpudJY+5Zi=; h=X-Sonic-MF:From:Subject:Date:To:From:Subject; b=HRLWvAw1CxOmKQ9Uq/QJg/hdj25Apcr78L9aBSRW9ByFfvCTCyf40oefrte2viTFOAMZA7ya7g9224Hd7heGjNPbcAo/PTPOYVQT4rInHQA+Tk42mVi+5O+pPxWKsFiHG/QxBHzDFfV0wsy9zkzhy7Zbo5W4cTF9QSDqcQJnJJHvs23ryQs5JWpAlNlvzvSnv1oSYfkqnDC9EP9shiWN96golhlX0CTaMI0l/1hEIh6x9S1KNhNZre2u8yhTRJQjqrewr1Le2Z+xZIHHOyc1B4N03kLMgKKXqIbT45RF7xzcLSKxCpBmsqB+KcApIQfqSEqr6W4wDNijDfRf9Ws7LA==
X-YMail-OSG: 34PR9ggVM1leORt9Do80bJelaPt9qlzbqFreflBLXJYofAOjhSr0GDN6xjBj1uN
 6ZGx0sv4kDCrTeT7qwkCQqN.6c5IdGSobx1mpXu76yQSLfH6pZUSIrhgA9IQlff8NMBUJ5ddFeuq
 k4D6H6SIpwUO9i9rrUH2vUEJu7R3xtvf.fY4Ppj6ykSZX.nmoFBnws.CG54dv1ZdWWcCDoOiXu3H
 fUUijARxPFrgEFK3qFNygya.xCxGdOMrcGJtqZgincgFZOSYjrFhf0x80OEQFPgJvVG_trCZvfg6
 GPJPrKLV6tWG1ve6RzywjyhQOUsQeGr2NEJmautxcjseG9x0bYGLLywzyz5M3DFsqTpjROBaWXkG
 kEyhtEJI1q2fS3ITdikIOozGdTliZlE.iztUa3QcSnZGiYddGZlVAf3j3VipL1eI1pB8DzZGALir
 Js4DK3bqbkedr7yFBH6T2qFhiMy_D9J_ewphiub3fTG6_VHvLg7MOKUG8CtqkRtGltlDfK6b1tJx
 bPOROCtFMxpAjkNw7eGjSPKSLs.AYWDXoT7ekEO6ERO6uL8YvQbwEFHy1jwe1MMM2JXD50AAdZ4y
 .h8UZ3Ed_pMTKebr70xIQ_ErgmVZ7Rj4DuwggJSTzBF0pNKAzOa4GoAK_RJZeWlv7wdQ2R7p9utP
 vpheuMgaSH4P482BM4ZJ9Vg0oBe7rw1lNPUPtZS4TrhkwVTAPmb_V0Sm6CGAN3Z2bpIvMsVNY5gv
 RU1mfEjuMK2kiEikBcMYd5vlwaE5QXMCZ.BWSM7fpCjMUGhY3E6jYFJcKKwk.saHyWmA7G5udox1
 F86L6EmvUNfhXRCFRDZSSXbWWEVe41cpf5rNo4tFDUjRjmcqD2XQMmRerT8QT4I_HuCBct9RGcf2
 lgsbrwrrPSGh6Xmkzg2_eT64zOvHmsDASDnSeZIdT1KGcOd2zJryON8Pb04egrE7pIEDKK0huvq.
 Yl_xbQeB5yA2cogt9qT_hzrXTAUL0nVCfo1ESQ78zGr9XqfqVry8sw_M_8j2fnMFci5O7_h1NMBb
 VZUZwyM7UKQmBzYAEYtcfodiToQ_RUTRBgNxTNoi2eWtC2Vw2CW_cp8ZaA1e81HcpdjUuAnbMxfe
 lsyWWh0gbq2_PIodg6iOj0NDu11sVHFwlhrRF9CO8y5.BZcFRoKfS16_PX_t9PNuZEZcNbno_xtQ
 PrQpPUYOxVWzjcc0BTmKTtvGHD7KOnrVEtQmTNl7kfMHAm1RVjy4etJrrIMAZW9Gheqt0kMwr8e8
 PbbHkRtvTDJ5LO2ZzGAcTvqJg.5x3PTZyVY9dDcEV1cBJeeMHXj8pAnC0L9L05Ao4GZPAv6mc_Oa
 PyC1XP0BzhOMvpkwDnwy.MkQiLOGwLYJ44BiRupIfjKCMnVPqIys3dbNCZp4Jbk0BeAE3vhgK2ZL
 O2sCTQToFuFqulqf7Jv2Ou0xQZh2ApKrjyXjb.nL2hCrNn7jH8hCMtzFFGyq5oTY7ETfGkGx34HW
 PFNIjiNKcYO.XrM5vjXlrlzeDg6.NmKGnnz__tkoHmgYaaX_g5lVBl0bTya2fBa_ZRXGn4bONb3L
 x8VVmzQdE6LxAetwrLgwzQEUKQmmqyrSENvFZwubAlmbtGoIvri3xAiNb.0bwfqYS.jZ.UHnvfpH
 _Nr8XrsYPlbRL6E0opC3CP7jWT82MVcr1OxWIoYAADNxcUuvV30lOaeaY.Z5R2bJ3y8prxr4TKdu
 WwGamtdkyOHyuMaqpK2e.klGtSKHgIOJPFYfplIbikGoePbOKQksbOF.ec7RU3cKGxulYKSGSHy.
 16Awl6rC6g70JxzeoMzCPBWDb2FiUGWKMm5Rk1Sdu96aXlYJFDmM8CWNJ0e0mucInZMza14n1iQR
 .IKD23pvjIvtpqujAt5ua2rk5hlWZoftjpqCMIfSFrJzeZCyP3EoB8jPJ0Pyio9FjgqjvN3J7siq
 7lG6EK7h_VcNM3fewKCfdtPvZa3JcMeYjWNcYSxE3_HzLoFtPGDoABc6EQic37gU_wV9rCwoynI3
 220NXzqtZdgYEijJEPSgG_QgFGYGeMPJuXs0mogVM2Bb1Aw3IpRxUjpH97FWnkazpGFelntF_AVY
 5ncY_RzQOqjKFYW8CnUMO_TmnDgNc.9VJGXZEu4uJ1N2r0JgYrSaUjDjtUj0px_f0pf0VOq0anAn
 pD0wJuIuYm1df9sqQ6CdKQCFdHzHKIK0F6UXntFegYKjy3uWgdX8r1vpJJWhC5EGSkW2uKHuwkIj
 eq60FWjZZUT3gnNVFjPeZvdUl3tCy3Dl5sZN2YjA-
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: 1e113b65-0bf8-4b14-9874-4d35986be21d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Jul 2023 05:58:59 +0000
Received: by hermes--production-ne1-6d679867d5-v44lc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bbdd96f8525c35c4842d0f43644d9042;
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

