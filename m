Return-Path: <netdev+bounces-12491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C665737BE3
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE3B2814FA
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 07:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EB5AD55;
	Wed, 21 Jun 2023 07:07:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E542575
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 07:07:17 +0000 (UTC)
Received: from sonic306-19.consmr.mail.gq1.yahoo.com (sonic306-19.consmr.mail.gq1.yahoo.com [98.137.68.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500E910FF
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687331235; bh=+8YeTsFFP4/LcuYhuxZ+DHkGB6oZ92zKrQG3Mx2GKvA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iFBz9k93bLxeObcjQPSQijwRLngwpAPfSOOSajG4tB0zM9jwxRZ23VYYZZY0FwUxnc8kMCynzefm7nYq0Yd1dm16jGL+PDxUANmJJgDRN+CMmfZCp4oIjjGr53XY2/vtqzUieZeDvhaBMJDkVv5xmKjDVCGal+Pa0NAVidh0mXhKqK6TSCEo/ftJFj91xZ3Gr/FXzFU+nTb82yBkBABtOU4XOEcK6Sl1drH0+VgUDiONClkP25R+n1ckGhCVDhQr+wjJGtkmpDfNvsbnwIIbmlPZI3H9qIpJ8dvPZO4RerxG7f/mgjO83xndhZUoiq/NIZxI6DT57SGhkpgmvtKYbg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687331235; bh=G+7r7T1k6aM8bdiOz4EXqTKFClozmMPVGPFTKtbhuXx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WRJWMltUNevxYB/HmbryFqKy5s1bK4ZXkm+05yAeeOeHmn68HvYIGGlkkErvD6d28X7cDZ2I1hgO0PFVyBP1Wl+MKmmgDdTNLOrEcTAL/H5KPydCGiOengeZGULHwoVPeVJ329ENqojRMe27q7mcU2qlmG9KGRCGd3tFPNW2G/LziBxTeZD+kp5arbHFrmO8AZ2NNmuHKMpnztKyeR8bzm8cW3r6M4BPwEpGE6IG1n5LVt1S60WEOZFzzW5lz8AgQND+Ejbfvyug7V1HqHDCteLvNifAXdf0MIrefP2N932ehUl0I7IVORpto3/uv70Qb3gfkv4ydhLwLOy8kKX21Q==
X-YMail-OSG: RU66A8UVM1lLZ4MTKmiTXVYn3v.AfJOxwnzpn2lisNOekNTECJ8Qrhn4Xy9FR5i
 sb4IJa_3ieErBVAABIJPJ8b0hg7q6RMxnF3brCJhjApxuTQEZj9TOu9NfmjV0p1Je3iLy7kZrSKf
 17kbTu1kMvug.IwszsUsPWwbFMsJi6ke4BxCFrq5n2XNWNwZ_8C857xxct7A50C5LVZ8ye4lHZVf
 _6eWuKutdKuPKQWSZZHW0BEzzAalzXgXy.va.Av0MgC.kUH4jF4hNLlRGl12quZ8eQKOUIctPlio
 CIxT48xwjlTkCjF.2y0ItxUb53VmlaqIyPhZ3M61cmAU3y_aFjyGKwfKE4N_BLFZWPDCs2jXkj1s
 ZQz5ukwgQMrWlcdpJbVTiIxa_HnxQr9Be3WM_qfwYdKY4c5VdCAoWEW_18HvIbvPDvqNSViC2S6D
 WdsczdVzpElQVbiPoP5ylzhk1UBtc8JfNQtF6Jhmn3Vj1U6VvlphujgZdVnFtn.E.JI97VIG1HSC
 zEC99j6Tf4EU_rxS6THeaIueIPzLeg3m5a0CIyEem8jzVEavJCa8T6RI4P_GUofIUHDk0Q488O3_
 uzU6n_dUGu5I37vcBEcO2bJZJZdr2HrXhMuutbyLaX5Al3mTuz9Ak9dVOobQ8MVNS77OuD3kl2Iw
 BLkcOKtX0Gt2ajjg7caC3tS9tP65dl8g0nIhQhX.CG8UcQ2s96RVdaFjwwpxe9USCgGz7FjSeta1
 Ssu2MK9oThxUrh9IluXZ4.1TEtzYkT3BJeMcvRkW.W_qNm9zKeFO6leRGgp3ziVYiWjtkXQ0HEjA
 0GEgk_0x98kS2todpRVpBK3rAD_hqehUBYO3djYPgZu1br6GyBvrpMX.MzGrFyx.hruKDnwCzwmV
 a4QmMShq5HX4J0sPIAOHEJq2_gxmV5mlbxnZDRXsarUM_6ork0dPTRmJpEpIGDf5uuHNhE3jUsnl
 DV6W2GKSJL4V_bZfWXK7sivUnEf.t73T9ZKtiG_dw7H4e790NntkvhKiGV_oD9XEljfLzQz07H34
 Wc11LD9gWJpfhtaCeg.YFNitEKdg9j9WAZW_vteKIXbiVf4VzetgrX4N7HE.cjKSipG.HEqr2.fO
 4_3hEa8aTG8HSdO6Z1UjAfczCbbHjg6uqmFqm1hJ1IQUceVKr035pQNdA1xDMEeHHyUTOYSyz9Fy
 Iu1smSE_NnOca42.lADk9YI1pclxT6ENIGjEgGQumG.0Rnc4qbQAy5fgKWZXKJagSGPA96hLFHQb
 oFaECjjmm9P7uKkc6H089rHlgOoj3nB_c1vdc6AdfIYxqFpd.rLslnhyHEigV68vgQruRCkkk7cH
 11eCix3j4JgBrBiZgrkmBQ3QaD3Pv1WnBocYOlE5_kvkg6o3sJnQx9ltZnC65dXcs2vxXQihvboH
 ENhr3J4fBz_2C198uyshT8s.Z0udrje_LDD9n.s_ajlVD_mM.it0XbwX6iz4eRrxTqh.Ihy8p9Lf
 nMnYC4tsQfVGQPS_zuuWNoIqUjHmnMIuymnvJ4pc7XGAUDifz0XW.rWlVwdlkrPLDgI1BnINgI5g
 OMzm6NDLDDp1tTemyTX7urg6DPdLjEFKN2a8SCBx0Ja3UI9aHNJF9Zo7_fxx2ZWujmv9soYSmF_4
 vcLftfQeX5oyuqDhd6VaYwfsZJl1xJOkpGXGplw.Z5UA5jVzG8d.vrAjCtvf1Rz3zIapQCmmgMfA
 sfz6jZaHrJ6zzbmxmlxPhjA8LeOiN46scw5lFOx8I2kaRsTB3y8tIhgyw2n5hXUHBY2yiBoLOL9k
 sx9T0hkfX8r0vEQZjpO7Z5oE5S2dO.j5anwa0OvO9AVtOJfuGtnJGn2fxa9M9RgCAP8c0DcMtOm0
 t3i_.561JnS2_3GwY1Bactay5KsVJcBYdqF9jPxAFDQyEKQ789dixnVmpI.Thkgwdk3zQiNaCEwv
 RbUVBlkYF_2OP7b9Ta1835HAE5oz_aHFelDOxjeB_FucUpdWvNV0irY2E2VSfbyvqakP7DJfLH_o
 _17aTowAMZR5z8I3NrIAFHeR.2KGiWM9W_z8FP6rwq9JKQb0kr4sN_4uZbg3M_ySUmEN_XX3KXT5
 2Utby.8_0TIFqei1hJ.yqentDyyu5zwLZbfU64_ftDpW0pxjeva9FNwA2aG2mZ_2SQlfaV5AAAuQ
 LtCumY.BCDU9ju4EJjFQ_znzaFPlfCF626shVRPPodOJZ359onGnKzMU7uy3zraK.F0HQWQaZ4_1
 F5Ahtw2wdrkmgben3ZDtKxHZZ4XpTUkPwPT72ghpUwjLlosGe_PyBV_.L9.QHd_NjkEIKOqOnuUd
 j.1J1Gv3brvt1asEilqBL
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: 0f5b861b-537d-450a-b31d-92deb4316dbc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Wed, 21 Jun 2023 07:07:15 +0000
Received: by hermes--production-bf1-54475bbfff-5bcbd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87614d617bd85691c90b35a1adfca9c4;
          Wed, 21 Jun 2023 07:07:13 +0000 (UTC)
From: Ziqi Zhao <astrajoan@yahoo.com>
To: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Cc: arnd@arndb.de,
	bridge@lists.linux-foundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nikolay@nvidia.com,
	pabeni@redhat.com,
	roopa@nvidia.com,
	syzkaller-bugs@googlegroups.com,
	skhan@linuxfoundation.org,
	ivan.orlov0322@gmail.com
Subject: Re: [syzbot] [net?] unregister_netdevice: waiting for DEV to become free (8)
Date: Wed, 21 Jun 2023 07:07:10 +0000
Message-Id: <20230621070710.380373-1-astrajoan@yahoo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000051197705fdbc7e54@google.com>
References: <00000000000051197705fdbc7e54@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

I'm taking a look at this bug as part of the exercice for the Linux
Kernel Bug Fixing Summer 2023 program. Thanks to the help from my
mentor, Ivan Orlov and Shuah Khan, I've already obtained a reproduction
of the issue using the provided C reproducer, and I should be able to
submit a patch by the end of this week to fix the highlighted error. If
you have any information or suggestions, please feel free to reply to
this thread. Any help would be greatly appreciated!

Best regards,
Ziqi

