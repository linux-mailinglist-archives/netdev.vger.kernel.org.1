Return-Path: <netdev+bounces-39597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4F47BFFF1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF351C20A9F
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE4E31A94;
	Tue, 10 Oct 2023 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JTS5/L5h"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6824C6A
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:08:46 +0000 (UTC)
Received: from sonic306-20.consmr.mail.gq1.yahoo.com (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD9A7
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696950521; bh=E5myakTXP9lUZf14IRYstJ9Sm+3gzhO8mrwVo4uYLjc=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=JTS5/L5heGOhW+suoWsRx32UcCSp7y22GIQhWmpoHhYWND7Sip7KTkXwPWSHe584mRAqVoD72p8Vip5p5NOV1CfWYffacDGjLzpWR++YvRDb8UnFu434QHp0qtK57YZDIvruy18xvD0sl73xa+Q2gmGZbqnVTnbLUboFcLH0/upxJAcfaCMlHTdJX0w88LC2eLohul534eqy+VslklD6bU1edJG3HHKUPH7zZq06TPSVHfhs2T48P2GJ8FblhqxiRmAidzrQf1Wbqflifj+lkuq+pVJepZQ6L+WFWDmo6VUJDXdirRVy8gepPBiJohJoaooVHoKYd3TdW9jbtOAHhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696950521; bh=wlR9Jb9HYS6IamYYpSfA34u08jIUAS+VqM0x/zts3ve=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ZWrtS48ro3MzGrLTM0M1nr9tiMXisgULl2LDKdrx5+yE23SVU6G7ySyRKXmythu7RVjJ42pM8XaHR27ukUuoS3hzpgTkjxulmdTP8phWJkjYhMIF5efNwoUg+m2t8wHOJculvUm/Dm07wXy/QEHNjRDB1blwPHsV2jT9H63/jZduQlzXSlFH73/uWqoUkFQic0N5bkM5mUA3NYptS1USwZHk/+Xb7X/ks2v4Cfp5j2HfH9jsSeSXOQn2uQJJrUMOK8MOwjVaJ6wbPDyct1fyBFpGWxNbePXcgZxo87j94A5lrBLsJAtBR5LZGV+FuM/K5F5acjUZuF6YiHbBAkAA7g==
X-YMail-OSG: QmxjCu4VM1my9iChw0t.OVLXz46haDBMLUT98ZWZVLvLs2di0l4hvONrkVX_EGZ
 y3feiecgl3wpFD.bRMlYaspThRKEuNSo_HR1lEHekRF65JolBBZgZLARwCvvd7hDpCX6EYCF8AoF
 NF_gdTsSeWLkaEJvq0r46z2sv2cHRqiLemt9nlc0L5Rp3bXMm38mQQMOItFi3_p551iB16wgeRzF
 Qd6jq28qx6E5M26Z9OugfAEwT4MkeVh3z9DMC8MdWOg4pEYLkCSGyhc5TcUWom0Q8..3qeb15je7
 ocSzvT5ty58gcFIXhGEM63C70uZw1VECCgE7sVCzrYgE7JBbolGBSiCOYnda5IhTYAGzw5rxc1be
 3ewqQ4lhJpjXNGyFc1FI9tEFq9_6lQHWXv3CZrQIXM9vMmb5Dll043E9nBEwARndNPH9oL0wwH5v
 .C17t9D1CawdnVGLoERD2.Lg6AdOvB3Botck.Yg_L2WOeDMSPst9zUaMSbmsXqdPECUXY9VSLALH
 ul4eB6Aq1aI5IYOwvaUrFgTb7bHqoZ.FVv9m7PhtK_B74vuoWlOdYDgZV2xBUuPkx_q1d3JsbvDj
 B7KiD66ALni3a4AiY8fRdZ6eXm7yzoxDsw2UZ9n4N6_pgJbkheXQd2EjX1zM0N8VE.V0YYbKiU3q
 jvU4Uij30i.uGUnlpxnzH80mI6C4PQpUi.9Jq8X2bOLVjI2rV9NP8o.M73qPZqjL1Oe7fxGz0ohC
 YQw8DWkrzNCy.75op86VL7K_FHmY4db6GqaoHZUnR5TObsxEXeI9Pvz1RG4cIxqYlWgbQ2MnwKGX
 VvZvb1mNJeDJLLthflgzTSozCh5oKqufR8OarnOAmx_VPpr5te36x2a0GWOeT6pA13Q0FjIAJMgC
 3S6pRkglOrnXq07tHtGEpYB_MUB4NgeEzDb_RgS2_Oby6.0F_EHgBbS_C_clknInt_kwsSN3CHJM
 o230OfFj4ijqbcrOQLAOGiLjZ7zvmUwvo9iX1dypJbP7qWhax2Ftg4QcpXMezrwl3ovfjDe6kHGF
 kTa2yYOBei41wbxeS0RWqLQdp7yGLH1dEq2a0v48Qg.lPDK12XM_R5mGDjg6yRsdg8VaUasjRVoi
 rNe6xczItEUkD_y6kJG2t8CJn.IHQUI4DtD6v6j9rlA0Eo7KBs51JZzrkanbapQpE63lWTdOJ4VE
 k9vpyK7o11YS5ahyDikWV.TPuLpdzYNC3RkTT9DIrgnVwcyc2JIOTMXSmmlqOm1ikC3uh_.zTErY
 uRTy6eLbMtSGmggctFCM6FQIotJVSBh0Qg_2j_qRrQ5TiRpzfCSF82ltKadXDhMdSzdkUoB96bGE
 bZFl6bXN1q0gGZ9ipWS0JhU.AnW.vqN5FajSlRFGJxFgtOPwRxwN5mW_iRByJqq0WCDeUneP9tqX
 wpI2y_OjKR7czP20LxWrY25kHJikcp4QW9vOmgpwLBBUk_wmLFK7GZSZDfjZ8pglmfMlu2UmyLu6
 GSObk9QYrFrKAXXjeXeIFiDDNQ4PML77DL4LDcD_QfADUJOfNDhF3ISw.pWtihiWOuG7_Jc4SiWt
 2utt8lNRWdrH3z2bgK8z_vcgia1di4mFi5CF7ucapMonk.7R4WwKAm.daaDBH.82.yuHXcykfGoA
 LKGdqr0G5wbj8sqh_A_gtpyfUt3wEIUBNPpsXRzyTpPXfzgNW9uNBx46f_3e6eK3TRM9HUDPgJw3
 .Othg8E2Zl1d7JH2XCXxnJoEot2lI5RGoo264DW0uqGn9SgNSaRGbt8_Y_VRDvPx.Js2jeBclwAT
 MNISIPMNCcGMcPbgbrobRnm9Sl_Ip5ke0EARsXjd6kVwEbmaPZB3jlaGQWR6P1WMRzbuSlodnGEv
 pK1_eQKRsy2vlJQjnKwvdr7GN7SAFwcFX2hz6kRI2S3UFse2u0u7j0CowWFj7i3PgWB_Ypfv_Ooz
 2IxPd41_CVNnhWPMpV00F2XXaG_W.c12KjfUqFGX_ltBxE7zoRL1jYgj14JcVgylZ1vZ76DOvpRr
 ay80hoYuC7AfaCdhwMRtOUT6kHxXeXEc179BhXD4ZtSXgk8ykyz_6uKheVoybpLrXDBQ04RI4OJV
 dlURz_hMesmYksUK3ApbB6Cfdu_T2FseY0qGE0NH1uKOPm.rC7x_DIBebsb_L5a4aWynI2AlAoD6
 XgxvLuUj9W22AgoAaou0nXU1boXcOQY0yiDYNw75cugXa.JcM6W3kuo_B4W.oOOiAiUcGdO2.eSG
 9zxyHunBKdjoeRnhKuR0-
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 9e7c8eab-241f-4a16-b306-385267e1657b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Tue, 10 Oct 2023 15:08:41 +0000
Date: Tue, 10 Oct 2023 15:08:41 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Leon Romanovsky <leon@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, 
	Linux Networking <netdev@vger.kernel.org>, 
	Aditya Pakki <pakki001@umn.edu>, 
	Anna Schumaker <anna.schumaker@netapp.com>, 
	"ansgar@debian.org" <ansgar@debian.org>, 
	"blukashev@sempervictus.com" <blukashev@sempervictus.com>, 
	Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"editor@lwn.net" <editor@lwn.net>, 
	"esr@thyrsus.com" <esr@thyrsus.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"moglen@columbia.edu" <moglen@columbia.edu>, 
	"skraw.ml@ithnet.com" <skraw.ml@ithnet.com>, 
	"tcallawa@redhat.com" <tcallawa@redhat.com>, 
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>, 
	"torvalds@osdl.org" <torvalds@osdl.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, 
	Julia Lawall <julia.lawall@inria.fr>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>
Message-ID: <1687671323.3952954.1696950521091@mail.yahoo.com>
Subject: Can you help our opensource project (file formats)?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1687671323.3952954.1696950521091.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21797 YMailNorrin
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We want the unreal map file types.
http://sf.net/p/chaosesqueanthology
/tickets/2/
.t3d and .unr file formats


