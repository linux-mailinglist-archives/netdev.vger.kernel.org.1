Return-Path: <netdev+bounces-15417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE274780F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 19:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6C4280F40
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758B57466;
	Tue,  4 Jul 2023 17:56:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642446FA8
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 17:56:08 +0000 (UTC)
Received: from sonic306-20.consmr.mail.gq1.yahoo.com (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7020310D5
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688493365; bh=0DfIHrMwvcqVXTTs+26xn8HdZ+MgAX0v0mEQF509c0Y=; h=From:Subject:Date:Cc:To:References:From:Subject:Reply-To; b=kTfsinYlpBidoMTmnmK+FZ/qEGvpxXL8JEoI4dkLXkolZhIV2/8xriFWr2lpeNdjqyMUpR8XUtpl79qjEcYdGByoJVRBULXSWKV7HYw0t/DLrpdS2PFxlHW5oMAL+WzihiO+Lw9gdKCJwoM0faVcOllPKVZWp2gGChrIkArDS7txD+0/7UvoATDoCAMXjW+HLt6/FCGSZFtkPpzLMsK8GHXLOhVUYCSNDyh312G+rr4nvFzDw1Mp8BdjJvzNtdiSCtRdUr97Yc0mfniW/2s3TeIlqIjOtuxlNWzgaZTNEsRx2j1ZtS4pv5JmJayXdDe/IbyVstki+AlaXO8iy7u7Gw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688493365; bh=9C4Wp/yBq2rpZvOx9JrWrbkAijiFSeJ4hd+IQBGoUek=; h=X-Sonic-MF:From:Subject:Date:To:From:Subject; b=XulR8cmevlfOlwChaCSLFMIRbR2plieUIbnOuIbYFR/jJmWP1Bxpw9EFQBdLlksWw2V4lyeht10WYxvPLfWQqzfkBfmNySq1mKbRP7fsCVK1wALcXqpSU4ThLZV4QGBs2bxCXlz1Gb0x8p3RYwdTP/GvwoUwnGwwU+H4mseVnpQx+zr59+8X+CR6KfzfWtP9fSfISTO3LYMJ1L2LHPm6LifI9ADli08GSXiTbakYo+F6ZdfTxQnOO9UthBnmcCVeNEXxdvkne1b1W4Z2cxrGIKdqHwXoamooGW65BjTA4XHT4OfZJGSgf3acwm+MYLpGRe6hH/ruNWSbWUfP+RXP7w==
X-YMail-OSG: Ld_85tsVM1k4nsor8aQmWGiEKOa5zUN8Zg9NFnHHsyFP_rdbkqlrjo02faO7a0t
 R6U8jKqe9ggQ4jI_O7pdbhclBrhgrujaumGgVbLMMj9h2eZo7rewNXajvCNo_BfNPRT0rHnhxaAS
 yyzrS1zml5ma.zfkubbewn_TL3.J9yLS6wjtlsm4ulBYamcP.oWqAKTjHITeU3M6F_dvT5ivbCcz
 lPpm001X2fW75G2SnZS0w1maYto9b4TZT8awS7PNBa1y7VPamef2mHdDZBqXAjBZT0wqY8P39a.l
 rH067Ih0xsJmnnfJE6O4_lTKEMmbbHAoaEadxd.mbFNs_eZl1Fcf6OhFo0DsBOAOtTMaee3DHBFl
 erHf7EftXoqb00q22bDAW_JrwwW7TL_8XJs0SupzYMsMz7in6KQPmvyYVZZ_GpDJ4YdSEZxJJzk5
 MmptIBPkncZhEFpGRdBG09VhO4.n3y2ubj__MV62BgmDKyMQQh8F3M5QICKGf2Fcha3ySI6ZxQ4s
 WedG9Q1V498GSMRa6EkmbPtCRPmO0QsJgYwbN354Puo9ydL2ZGT4xNCkN2OXUYIdhPPtHz4jRz0U
 pP2rOAvh8OE_S2IBOTJfbda0QUqb91R2fo3LQ44y0Bl9S_XWD26ZQz0o__frb217yoTB29xT3Jhl
 MSDxlgbK3JCc9O_4bjNf0N9ejwlQwNnAHwxSkgGZEl.VvdyGTVlA_B_yHcuyCkYI.oq0NwRFS7Cm
 dpW3Y1h4Z1YQ15UMr2Hr9LNi1GT3IRH7B1RtV.wPDmX8rTY0DkIFR9.wLdqV8LC8iQ1NYFzsKt4l
 5UmESUoLEACdMZngncj04f2xFPU_CGua_cinsDHFPkTSOerL9gLnfyeUflLx6j.YbBERqS.gQ_dV
 dUGE1JHtpdvniOcdlQ2LZYs1.GW7xOw4MoOflowAjNoZb7J00vuHF5smqMbz5LaxNVNxAMaaoxH1
 09SyJ1MStRWWdNDJ.eiJ_YEYOZdKCGbIEv9SRsp1bxHJqq04.vnRkHP4RkNwB8k8bOaaZbffRLvN
 HF1xHjkdNU8P2rGadkPXe6syB0x5sLa5z5FPBLzQoTwABxOn2m1iUH3uavwdi.t3dNRgbj3XfGcR
 oo2YWPBSKqB8.3BXuaBH0abXygkGqmBfq5VJt81n2z7ibDiyTNB4ficOK.EpOyNGfO9bS_y0hGdq
 SBNnPpQcbVPgzXrBQybAjXg4XlR6rJDZjnsgV4d5GMq1DKES5Vx1KvZw73kWg77l5f7bpiyBoQo_
 .3T.p6zG8o42ONxb36fR.P6tGwuSFH74igNtsyBsx71R_o_EpLEilVJ8WDxqBLOtcOjZDc3fckeT
 .3aWqL7vOhDiqZQyktSROcdWACwHlAShPLnv3OYIEcZDyGijDI_YB2PmLIcAgGS8sLhRQlxuD5E7
 vmsEUrzgyjwcHmFh1PYdcImsbILTACSRBQN_RhIT2bD0BvCO6b_T3rNeL9JbqM1TFMuNgcTLUINg
 oSjP.Bp7MOVugXQRarmu2oTUBc5iaA852.wxlJ2NNF9L.P41ETw8tqbWloy7IC5Ac1kXIqX2Dg2C
 2uf_UlMHPtFw5nqK3kBi0WzLmSvEKtf4Mj36vNLDdqxdi8r8UQ_33mmAEehaidtuGOdAhKjq0IzY
 NdNVd7lRIS82g8BMJokabPPud.wd2eU9V5cFZrWdvedcnmO5YKg2AilP1PCFytXMQj5j7slM5s45
 LwG3C8zm9FAjOlbOjKgcA20RO69yaPFdKv6I4a6xxp7BzLSmVazMKyUZtEzxxYiC5y9p.FJNj.6W
 YjILX7QhRu96PyPQqmnbePirxzUd0B1y8ASfbUVFRBQCJNkb.WBEIrP5R0mZY7p1dMDemI.94Mb1
 egbWy2rH0L_Nt4TH3vtQyvLBFM7VL6QyTMS7JMpxS_Pwj34yVs6HhJ6rEOwRTkiAPAcACMEYQsMU
 hzYzD68cWj6KpfuGLRVxR_zueO_sKd92sjJFziLonTDw7LAG7FYyPPXyDExeqtukLIWELbAoHpCD
 6Sc8F1CRbf0GGI3wwoxqvKri2Cy80qTp31tmPLrPHQD9grvW3ky.TYToTkLeAyzvKEj2v796Smtd
 JqNh0mRG3T3Vjvtc6pjaJmFJ3CThHwBhNOzPCUBPfOEMx8FBD8LVJnMBJzF6SsFEcDfg7pWWM7UD
 neoa0VXNAJDengEWcOguz3rnXdoX.J.YMh.H9E9L6uYxofuFJ3QGdxdoBEJxLUmedPFRsRfEOjbk
 3t8TpXkHx87ksrr7J2s8gHPIz8.bNUTb5VFAcx1dL6lA.Vipp540pjsKTig--
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: 946c587e-fa93-4648-b89a-77182e6d74d6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Tue, 4 Jul 2023 17:56:05 +0000
Received: by hermes--production-bf1-5d96b4b9f-ngknc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 471369a57cb031f356e942fe223056ab;
          Tue, 04 Jul 2023 17:56:01 +0000 (UTC)
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
Message-Id: <F17EC83C-9D70-463A-9C46-FBCC53A1F13C@yahoo.com>
Date: Tue, 4 Jul 2023 10:55:47 -0700
Cc: Astra Joan <astrajoan@yahoo.com>,
 davem@davemloft.net,
 edumazet@google.com,
 ivan.orlov0322@gmail.com,
 kernel@pengutronix.de,
 kuba@kernel.org,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux@rempel-privat.de,
 mkl@pengutronix.de,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 robin@protonic.nl,
 skhan@linuxfoundation.org,
 socketcan@hartkopp.net,
 syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
To: o.rempel@pengutronix.de
X-Mailer: Apple Mail (2.3731.600.7)
References: <F17EC83C-9D70-463A-9C46-FBCC53A1F13C.ref@yahoo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Oleksij,

Thank you for providing help with the bug fix! The patch was created
when I was working on another bug:

https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84

But the patch was not a direct fix of the problem reported in the
unregister_netdevice function call. Instead, it suppresses potential
deadlock information to guarantee the real bug would show up. Since I
have verified that the patch resolved a deadlock situation involving
the exact same locks, I'm pretty confident it would be a proper fix for
the current bug in this thread.

I'm not sure, though, about how I could instruct Syzbot to create a
reproducer to properly test this patch. Could you or anyone here help
me find the next step? Thank you so much!

Best regards,
Ziqi

