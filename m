Return-Path: <netdev+bounces-297813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ESxVLRa+KWpvcgMAu9opvQ
	(envelope-from <netdev+bounces-297813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9A566C8BB
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=rMMVO9fc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297813-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297813-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB756300A31A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F1361641;
	Wed, 10 Jun 2026 19:42:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E2273803;
	Wed, 10 Jun 2026 19:42:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120531; cv=none; b=QrOEnnMbByIPrI2xxSO12NHbgc5m4EUDruE/t+ExaUy9SaE5+XuS6tTsMkqTwRJF6jHKAktQmvzGKSzr51YJdkfN/WEFgl/UwhP0+zTBg2ziVlZ30wOYTJTeIVT19H4cmHX+mFjeSSCFCMEA/MKA7k1YxXFUTIlWNxD43vPfIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120531; c=relaxed/simple;
	bh=Tk46LmWTxBxLQKVvXgJqo7yAy+rDHpoj6T98QlGBA1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psdQK4LWqKh17JEuQDNpWSTVBabuRcbpMXQ/7cOwuZwbo5HY8yFjVynvqyh7scWY9ANcyCXIOXrjkamFBR1v+OrgKHPy3bW7iar5DDSLi4Iphaya0NljBLBEuklFdHf0PhdXBB4Z+aoguL3UBjkUGo9FI7ofHuMF0pjVf6LMly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=rMMVO9fc; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781120522; x=1781725322;
	i=markus.stockhausen@gmx.de;
	bh=Mt5PJKPLDy2YLhlggFcQY6pFt3Hb8C40rY84RcTunl0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rMMVO9fcDFBuZPHK7MI3xB9OaAtacUb5XtwZOazlgsoTspNRqrITyrwoLat4pdIb
	 D/SFCDWrZ36zwxxgGPG/OFUf32MOxEg5k89YOi8RfEc3/q25YoyOKOcZH0cL3+W1n
	 274sBwtjJxqgC8Y8E1hnlt90azVnN6/RJviyu01Cvtd9kCp8XzjbvQBkTetzH/sKR
	 HQQjoFv3/ZOANiPK72sq8xFCbbbyw7bPdwKYP+b/EN4aA07605H8eIFtCEBwstYGT
	 kjn8WAZ0IqL0Ie0SaGppOFKoS1OCwe9IvXaNzm529mNHeZGu4kIIBjpNkG2YWI0O/
	 Fqu9gU+fwF18jKn/0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVDW-1wmrII2dBI-00IxVv; Wed, 10
 Jun 2026 21:42:02 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v3 0/5] net: mdio: realtek-rtl9300: Add RTL931x support
Date: Wed, 10 Jun 2026 21:41:40 +0200
Message-ID: <20260610194145.4153668-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1UbhwGL4cf+Al41hbyGOTVA6DFFYxgzHtnOATPaJZp0OqGBGfaa
 WNmf8CMz2l2MHE2OR2M3x6McTn7FEIhGk28Nee88fAzercqxYDY6GZ/XPlGgStO44El7iO0
 hgZMKko1DhlP1QwCyav8leItLcKhUGtBHLS7LRcn4Hseb2bnNIAjO5XdW36nj7WdBfwyOX7
 SNaj8mVPCF4ma/9IlbWCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kE0zxELnV2U=;+OrHJx9sOMFSjXBBLaOMlNbrk0B
 d0xo2d9rgdeCJ23SpzXJu64aYHRQQTIvdsWKYfYKCJlSkBo89mcW4hyky5AWRvez+gm3IsF9g
 KasDx6pcrKqj+aqBHQgKs9HoTAWIriaFBJ637sck7ZcdhT/12KxBygonXgOL7BW9VWzSFKD3e
 iHyH9qKlFM6E0jPecYrwik6t5lsT2TSAzAEfcjf5coupLj0Vy6/b4dy14ZDa4dpFH6Tw5RsJn
 EBqv7ijNZfvNAq20F5qhMa0Q9GSlcXAgfwQfoFiuWdYO9FJqAOspL1yqHURyI9THu1dLjLHyX
 l9Gu4VK4ql8CihQKlb9oJGXmNP93jvEWscwXsbyB8pnPSPzCUnwThh+fvWS0nfC4LmasCHX/7
 DV+8NrPubeXL+q0IE212A7SvtEipLCE1EP2NslMSbo2Ap/Qa5L/DBXBficLBQ9r5XDBboTQ8i
 cA6gOcpWRrqU6TzITxJV5Wif9bsv1lt07ODJEMNiwWgSalfysFkwJEm10nBZpfZmu5Xy5uF37
 acDy8kCIshl88v2hfe9ysVCR/jwCl2wBQWG+7dgdPHgPudpELC7+sYEh8eGeyUBkY3q7H8dD2
 PsNq2YnaLVLoDVMpZyzy3BTsbQNT3cMLW1bu4ef7u7+vT92hPu7Ga+zDhjNy15cjxdeniuTRd
 1B96WzKi5fwY6KTFUHipwlaurfrwcTQG1T4luvOl3/jgYxMciO0ov/5+OqMjojDz9u9g4/1LZ
 spudj0eZ4xTfJh96TQLyzloPHtJ3PfUDjQwkfd6ygrmo9NOZNhPQ3C48HYNEGNt5THrq1/Dj8
 P/mQUpqi5gWNdfaoHIxcuSSobFtPNgu5/GAh21IgbiZB302F48yRObD+IycwOBX0GHjF/9sHc
 nMUQJ0JR14wJbYlHKgTQKfiR1LTY30nTiXeKe4+8Q/HIj5KKz25G19IFLImJEhmgXXW+ekUTt
 ofeS1gVrPzmGUNeSymoXkA+zakZI9jIhXflA511IVnj2J5HVzPDdz7PSQhyCQXt1xayug66uU
 xIFvwbzPcdEBy9ABDc6QxImY4FYyBizUa/PMUhK3xVKd/93HWN/e65/RrzrmKFMte4DMkSeUd
 RT87OzQVOQoJbsqcjRbI4ZAdWW1FOKf+bZjwEAebsWbG3YzUoAPgBc6bNGp6ALXvE0tlsKx9M
 RTAHnRs3SwQTodL6qnE83imyziAM0zON0SsFzkahwaVUs6/F3IlDZQaJeZeeMP4dH2r518ARL
 4bUT+C4hdxcxkXwi4QHvZjfFTRmiAARvsMyQj313ekFKknUKADN7giBwe4WBsQea9q6H0I3Gq
 5vRIRth7V1c58ax5u6tl8QtHgpMunEdw2eU3lbzFlXjzhevYxB9vlLF/7IwHC3MkgSPX9ZnrM
 iFn+H2IFQyU4MYnTYhppb3n3Ia3zE0JhGOktShYca9Ddy2eiq3yZplNQE6vEvQiS6/Afpv8r5
 BUSNHk+4I89AmoaWi/8Lv/t9b/WFHUv+ODzbKCQn6ZHm/S65tpCYPx0ZFDzlGafhx+lyFSXSF
 tVdAExCKTjh1UlhgsphOZn2gA0YzuIndvsZwLy6CKqCos15YoygqmY3E5+LrtrnPWvMJkg1Uy
 H83MnUiCBA7Pt2dBnCPH1MSLBVYdNVTZ+ytam3vldJyQUJT4YjIWwoKaE3ZFwQy+WfylMAmzU
 y8+yMsVQgSROF8eUoE7c3Fy84vqMvgjdDURcZofw/8g/4goFWqdvM7BC3EC5jLix7rhJrnxzJ
 ZBHwUTZumC0Y2OB+fFh9aVYqmHJ8HMcqw6JgFdURxaDE6CLFSJX4cJDo/IhK6ahMXBpuHgiEG
 hk7kKw2zzos19bMs70yyF8XbBvu7IPR7gziQIAtUjB3i4KnSvqIfPfdO/l4Sjye5h3G0ECYCv
 GMwMtaBLsP1xwk1DD5TBOU8fy1Rbuhk7PqOWtmkakH8bN2o/tBinqWzIIn6phKRsoDYGGYLLV
 DVeeSjvP3xJur4BSagC9XIfYfTIkVYzfULmHQXejL/nvzD8YVs0+J3kxOwsahnQM35pR7b7HM
 qO6S3Kha7aSGqfJ/wP0rgeNV2b322Bbm0tMheRjhHsIGYcJ1yeoJ9f8vd2z77Xq7d6SfAsZRJ
 9b3EMLJpNuDqC5/1ajAqdjgSYSjo0b+yCXqyNb1o+EKYDxwCOiiPUTOfLpJbxvVMmMfFoKztj
 dcXDHQPSFUFCrTiP7GMk3r0LcAh33x1e91Coj0MhgEyjSMVXBXYqPIq6HoRu2kRgtpSDx7Ohb
 DKiGP+dQNgClAXtf4ksCy3hg6kJTp1slUsgp6XZ7fP26ZKtuZsgJE4a6wafJC4M8FBinIHNLz
 DQ0SzxXBWeDKqv1kOn/cMrDa3mzMuPlNgbkHDyTAwcYLQJiBNhdD5Zr5QzFmBk91Q9uogBvE7
 nngk3uQ0Tt/D6/mRBZ2It+eNK6XI3MidT9csm3An5uFmjlk0a7607/6n87MpxV1WIFP9WPzA1
 ALHsxDgBvD4h4FUZDARaRnmaLXL3Bb8vM8LF0BqQwFxMBhcpy1p2lxJBFNyztS0LUetUpVcTb
 vS9a300QiWJAi5cFaY5UwP2KFlWqJ/GGzZx93Ec6+naRAaCz1a41iunFQfCACtAFnXSEXQt0e
 xALmambGEBEFClXey966PKZVjZBuj9nsPdpUz00OmMuuZY5Ggf0uOEM1GVWKV0MVQ259JSgAv
 Lltaptv1w/KaaSStarbGd4AOoY9wKKLrwyB+U4rz+sJO2ZOYj+xouRvxmrQhQwFMab7MUVRiq
 svvJ5mJ4bgNXBg+R2ES1aHETFeiCTMkl6A69HaSJDGQFMY0BULantSucxi4ApEtcczGfI3UXX
 u96Brf9t26+CrKT0y4lt9lXjhFnF43GK8C/i1OFFRSTHJjFOXlKsbMs5nIowF7rNPRL3aqLr9
 qE8mvnZe0o+WWC27+oWSrm8IT4J4PMMpHL8RwCohWm9xm4wEUx5crwO9T9PaGHLgczX6V+H/s
 WJbxSB9pyF0jWUe52iRXj3PHJJ/mLaCuQvcUJWXUhPFPGwPb+sEWjT7eq9SaLe6HV1StnloLm
 Yeb/Two3mO5/CkyjP8nqo+ZksQky8vaQaI45kJNvYLW6BzNrtEGzyGu8nGSJP9M5Cui15fPou
 omYmrO00sWrRAcenmKxo4prvZEo20S8SGzCRuKV3p2++IaOKRONOMV/MG4zCf4jgRnq5GR2aM
 E5AUSNfJo4bxOqu0VeJwjBOV7srXvQEMxPjITvDsKGfLhlJPF7Q31Pbo/wNFoR7PoVpuOpcsQ
 fIx5jH53OlroyDEqxLPmKto4WN0eTZMuimp3d/kaYk7oE8cPKgZv9q/FXQGZWZ6sOgkzD343X
 ccl4GfWTAjiS0Q/401JOeu2AJrZa+oxVDZoQbuNCz9ATXPRC6LOi4G27ujse/RC656iW1XfgL
 tzKBFu0RsvD/xgTG7W+UbO7Bsa9i1tVSK2IhSTfvwguVp3AXeURWgDNYj1I9XBP3lK1HYtmXU
 Wj2/8gPou0LZY6++4CgPi/2Zw9IWjZnz/7/U8F5m2YAU47JxhwJRSi8JtR/ouood9ATZS9414
 s47HlSTj9GLyTWVBKXDu7PF3a6jlJ0d5TOElZMLLcSeDfCpMYvwJJOq8uNZCK4G9CPnVv22XV
 97j1HeycLyqs/sLwBxBVjuhkGCPIn9q1yOt9fyusuJS1t1ZPUCmdE3uh2MdM5sOr+6C/XeCCs
 IGYaoiqa4auLUXLAwaHT8YsN3R+nmPwHB8JVQyVuiqxtSjjlM2tX9d1UWgZtk8S3aJgAvWVQe
 r2gDBQp1giTDxW6IaoTpXjJ3tLCQGqneOaxuE+1zWBL6MogV7hYkztVNS1cgr7Vxjy9zyhbCj
 ndUCZ2gsj4M85FMAT4VbdwjWc68WjW7EBWWRQownBl3D2CmBs1PMkqndNZkeFdrCC4hsX+0ld
 HfQ4rQL1s34CfKfh8GeuY0AMM5hHnE0fv7KZ7lDXeEe3HgNFw/yIas5CHtcUNDS1Pv9arPBzK
 VkQQI1l3rLneg2OadXbQnEeOMtFfTMlVhVCVlVuuETWeCO19b2FrqQ1hwoxwoi1aT1CgK6xGf
 ZF9Kru1ZnnwP0oUwC8kZ/7XWN1191uX4bv/h4fTRvKzvV3dqfUN5Ak5lTy/xF/mmx8JYQfY09
 Zg8EXLvubfI7RQ5dOWB/DLWoHIJ6/a4k2V9rRKULwBlEKRm/6mvU8tgNSnV+GgwC5ugvUDddq
 PSD2wNf2M0SeSmBJxCnho624Z5Nhh1Yt6kuPJY6ZHsiZMURhFrjMptnt5QmuC5zrU6w2NjfRz
 UKo0fShct/fviO3HCnf4Jp6OFZGKPbP/gDhuOHj1CrEYmTvggmZ6EELU9fUYTBn2L5kSOE9mk
 ZdXrqTvU6mAvh6wvuTNtd5F8KkfllTNTzpfAgd45Of9JvfjI7wZDceFK0U4msTMEStesgMdXm
 pZc9SRL4hHkw1sxxu/CMzzeIHoWGx8O//rYVZ5C9PPBKtGeGAFWzrpF+D15DmhVzMxUvPs4YP
 0t8MR9KmWyNsoNU7ayr4edw20YHpcdvk7KJUgPiANAMsGZmU8CBWa5YrWqBaSkwsVDBPfe4en
 3p7gSwdvOyxeoEAjcn58sIk8+6uWMz7zU8EsR4JXkzv7ZsJePw0ecGrL6E5yXA7piA82qYvbL
 +9mcOMv1s/9Vy5X57lxcgYiWF5MbqQ9CbiLMFPoZUx9q0tEQ38/jtQ3HmjvXJDdytJx49k9vv
 rJphZ20LAPfQJIg3qfjqSfjNuIOHx3If14QH14eezY3G5Tge4ObeAAucG/dm51Arxhd9MbW4x
 25FUGKmDw/3yfUSFalqZHALpX5BEKmkFfZdmH4IyCQSQgkQXxZRBomau3qGIMaXOsxpZq9p7w
 O1Vh6CoPkm/cBO5rGbw1SFQA5UObnV5hQdGHS3D69hNPi/IoUm6CRSee1AavENDoWayB9vgYU
 R2Uv475P4KY8p6947ALQdcM6F84KKv9Y/BuBxr3yXSLuL0bDB3mWMADcJNlz7ofiwz+Z5oPQU
 f68tE+wehW0av3SzRnESS7DOOOTELU46g9dkTrFnBJmXNZBDVu5IxQbbu5gCpWAAPev/zYDoH
 nnU5ogMzsLwXYNDv2W5gsh+NiuhJrDDosxITbmuMAyOhmLFTyEXK20sP4COIQrdcde0LKFMos
 vb2+eKO3nDE4UAOofZo/jnsl+xcKGDNAW036iEnBMR8u5yvHiEpgcb405q5s8HeMhCqdBKIjJ
 Ca7KCW2Iaw8wUfmnmDg5Bj0Xn/ew29zRonuJ2TFmcnb97yRPRkhHNGdLqpgIm+HaJ4i4Vs7SL
 jPlPD9RhQdciyS8m/bnLB/hW3sjmEiLpoOy2ssC0R5cP+iGU0XJ4w6jMDvdXLosbydKFdXZRD
 4OfPRXA7WvlV4IqE4CbCzgieLLQIx5HHnNLdlRTKa8he+qQ/PXnuEv5nrcBYGG5dWjEFkvxIA
 S/dYUJsQ6Xnbx9rGlQbwXIInUxJbSFgII5oo5jnj57GLOP0ScuYCnT7L98uaQnXZveobf2OQ3
 mV9X7LOAk53TTpGKey4pbU7xwivxnYZwmQ4AbWt+RTt1KmSY0ouSJkAjcizeC+8yQiMonsuWF
 VEPSXQMr/XGFVILSJ+2fsSMivcEhZMV8CYWTtRGPq7CWXvAJJ+IYdbKY0Num2t1tURecRQ==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297813-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C9A566C8BB

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

This patch series adds support for the RTL931x devices. For this

- Enhance device tree binding.
- Implement final cleanups and enhancments for the driver.
- Add RTL931x coding.

Remark: Instead of this series it was planned to bring support for =20
hardware polling configuration first. It turns out that more testing
is needed - especially for the RTL83xx SoCs. Instead add the lineup=20
of the RTL931x devices, that are known to have no obvious bus and
polling issues (at least from testing and vendor SDK perspective). =20

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v2 -> v3
  - Replace open mask coding with field_get()
  - Fix typo in patch 4 subject
  - Add Reviewed-by to all patches
v2: https://lore.kernel.org/netdev/20260609052856.3142922-1-markus.stockha=
usen@gmx.de/

v1 -> v2
  - Fix subject of cover letter
  - Convert const/const to enum in device tree
v1: https://lore.kernel.org/netdev/20260607125406.2853607-1-markus.stockha=
usen@gmx.de/


Markus Stockhausen (5):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL931x series
  net: mdio: realtek-rtl9300: Add prefix to register field defines
  net: mdio: realtek-rtl9300: Make otto_emdio_read_cmd() generic
  net: mdio: realtek-rtl9300: Add registers for high port count models
  net: mdio: realtek-rtl9300: Add support for RTL931x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |   9 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 210 +++++++++++++++---
 2 files changed, 185 insertions(+), 34 deletions(-)

=2D-=20
2.54.0


