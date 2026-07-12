Return-Path: <netdev+bounces-306965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C3a+JHfeU2rtfgMAu9opvQ
	(envelope-from <netdev+bounces-306965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:35:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68AC745A3D
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:35:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=MDvRgzmD;
	dmarc=pass (policy=quarantine) header.from=web.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306965-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306965-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E97B6300B84E
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F693B2D10;
	Sun, 12 Jul 2026 18:35:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7173B19AC;
	Sun, 12 Jul 2026 18:35:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783881332; cv=none; b=SjsIHmVTrh2uL0tZ6s8uMVygSE96RwQ2BSlxezE4iN01RmBVRPKo0SaLkwDDfsv2COZaMNoehGtBHQaUWzYMPKuQD0tWkSk5qoAQT9AntCmsHza1cYDYSOz0sswVGgM5kO8qqfUr7duLeSCd5no9+mbU8oheJcappoCI+1PGWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783881332; c=relaxed/simple;
	bh=cuEvobqeT18L3ik7iyb7PK40Fg/TvTVSM1/DZd2tC7A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EVvqLJE1zGDu6Oa/JwqhNvxrHiEqdT0B7km6cMJIyN4V5bVqQzlFwhQZPT+M1UGoWl6JySdtQrpra1Bfo+6AHQ3qIPBTG/sSdkJZU+14zA2A/4cxF5/bkG+Ly0cnf1fQPHf2bDCCHZcTY2G9ugGwUvA8AU/4R1TqXjm80PKQDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MDvRgzmD; arc=none smtp.client-ip=212.227.15.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783881328; x=1784486128; i=markus.elfring@web.de;
	bh=hbUEczp4KsJi39poKqaYaUbduvNtMguZWWI/pkL2z+I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MDvRgzmDAqHDeSPo1GHFfv2V0OQU/FtA3vAhr/FOzSHo+Y0IPqmtZsQaGmGsNpmy
	 JJMjYfTkNGvkGCuNzjXMThLDAKbJKpOsDohkOlHyQbvGObrov6oWFr/zqgDNKh8IV
	 /7hvGnPwAO2B8yYagNDs5oyjhkpuFAkac5kIUk6k2Kk7v/1LfbFhAde1qpZ5DLHsM
	 lo5v/oYYYSwkAdSr3pqyjbvrCaPGLVjqEMLx+JMluwj6xEkIxpdnC+GPk9MY6VDhs
	 1ITq18vaX7CdIK887BfrjrvCAVX/V3BtjJlcZugJhQYZrDyApis21F9wSrTXrq5E2
	 asO9r4B7pZKQ9mCBww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5bV-1wYkG51LLR-00RZg0; Sun, 12
 Jul 2026 20:35:28 +0200
Message-ID: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
Date: Sun, 12 Jul 2026 20:35:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH net] net: rnpgbe: Pass an expression directly in
 rnpgbe_rm_adapter()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tvaKAH4390uOvJz93ZD75OkNUUQX4Q3Q8VpmHxbudXDlVU9c+JC
 fUt32AiwWPHqOXRsRArVihbdyMPgnlea+HE+0KMtITkwLdx52HJHrYzirKoe/wu7eAye1PE
 XdV8mAzhlLAJG13EnLZUeeN4JGelwZZHUcZAdg4xwBdq+FdOsYMvLeyABOxby+06mAh7+92
 BRDX/Z30WUaZ8iHtoZK/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xct38FPHCys=;i/DvmYohppi6CmqdCyGv8ISwjDv
 zevs270eRj3fm1OmBUWzk6Y3tCnFCzNgh7epg8kSqc7e7+RDvQE79ccJrJlXgk0z2PiyTMG8w
 70xSk8P0c0Q3R3cD22tfD77raueSuzBOKpCp5WYw9sW32frUkg7ygg7VIGytc2/thu/ULvxW1
 rB7ULarEqbiGDMsKNOjNuMMyzFgk8L9VZD82VRFZ7gFA12Aifro4ibh/0IZLgC4YMOgZmaR6q
 jkbgudvRB2WfdL+XAEFUrBRdY9JDRinEChwR0D6docgYClk7Dj4u1JxETN+78xIABKWDXoEFd
 FAziSyA7Rbor9G5FQHQTP9uhh5afleOAB7We/9nq/rOA43Yz7lBVhozqnjQ33LTEffwWqqXJv
 L3ZmTYSiG2X8ojZckv76jV6jM9JsjvQg0/tg1wz+v7M9f87iUATJgcamKUlnIXNoJesBYOhyL
 +FYM/w4DJWfxa3TXwsR2iIZN7KmD7lFwWLaHxAHwdu/AS4ym8fK3iGnCauP+VWBTT6r4Xedh/
 Pf04QG79zM7di5NjeT35pDAGZBIokWRSM449Mw5/RsN9AOCxSGga7csNrZxl8td4aYV4IV2DV
 jL6y4h8VOgSi6OswYy9B/BSviju7Hb6FnXSfioaE/hVmUJEx69yATps1AQLJlNO9BjpaQkpWi
 /7f8A9aIaO1lttxZ2yS61wIX2bgOdQ78yxyVsgQG1iDCXncl88dvipTtQBdZabptFos70obp4
 QSovEywQuccSPOdTuCdOV9+J1d+kM0/i2/E/G52NUJHm6lHRl+rjvQIy2jTXYW1CDA1CtYg7g
 gibFiJ43vLXO+LQ2Vdtvbl6fPsWJLTYpePELjRkpGnOBGnjuT+H7szGKHfOxfBTqlvj3ADMRD
 NPxU0rTrIGK8bLFXZ30wXQlKAyEvcL+0V22j3theEgjivtdcIlb+PGFM/Knbxcw1mie+iSoXn
 np/EXfTK0wNZInIeUZmHVyaEnWqAF+nbtw3K1F6A3womZWwHIF0d8gjrC0vbpm5tFwjZKFKWU
 X8vf0EVG/sF8BODKUpxS002nEN/yrEIbgRopNDx/GrBuq6gzuWRjEj5RV+3SZCnj79ntxZv0d
 GlbJ1nu3Y/TsXIakjO7UAZcKbch9oq+16xmGm8BvJOTtU+LRUsiFslC8IoL9/AFrmIGxJSKY9
 Q2lz7WSljAG3dGyUgLx4Oc4CpQ7TY9roI/auK9dU8o5LYVec8+QFWkSKabu9OUEpbOkCv5o1n
 tcz2GV5dj77y/5twcx1+uyt/6DKSoqG4UJoHPRruMQGJJ3srgnVttULlyuwzRMb2ycwJ8BDky
 d3zVCJuRgd6ZhQXUFNhQUWfhE//mVDlKxHcypWAhOvKg/juceZF52xF6QsUDI61QA8TSvd2Xx
 e06ylD4u5q8oRx8Zksurd9xJoKZZdG2dB7qtklI8XmgPq7ezMmxMmWrurZ2sDJNWZTX4FPcJW
 5ZcelNEzSb5ufWvBBPOQSXkpUHf7yiJjK7rma0tbTmfGsbaAEH+1A6Drw0SEAiFaSsdPaP9EK
 NFlcRKj6QpZ9JtP/V0g18KFQnlv0FUKiD3lWrf52+89GsyoXXOdo5GXPDvioGjHyx1M8yfN3E
 GPWKVNX/MGFKuWlf7hUEHwk5V7QxIzPOiAjL2ewY4SB8Ou9Bdf6m+5xDWuX27CvyIwNVh5QYz
 p51wHsrMM4xzWKzecQasMWjqGP89qZ0diPRSp+0Z2mImrUvpXcB7Oaah3tA7WXWxP7qzAL2Cz
 wZb5LMdzGlxvtDgYNrUMk4B3xUDn/RocRPMXaaAdgAvDbQHJwYdmDvwKA8Hzi4jmqFpGI8A52
 Z8s31fMg9yH0kcVEqTofRrr5MAEUydo8vYxRsfT252ekkeThfYnL9NdRCWXuOSFkmyP81uJ0Z
 CO13jxpy943sreQ+tBhPTlPZJhMHrtRfNAAt82sISyS7D5G8VOm7AyN6lVNY+wV2ReGfSAR+9
 XKhKOJkbswVrrUIRWG3+O4LWXZ7sSsOwOTIVgzKNmm08G7RdhWkktqYKm+CBaBLRBrjdr/wD0
 I7ZlHCBXtGnLcZGKwAitb81RtTsD+UJVUhVJO1Ey4PGZVSe26I/4E45gzkFu3rKUkJ3MnTVEc
 om/gitDKPIVOqRpTEVpDVoh/Qu63URGB2zEvocLM7TmK+Er6YiRhJe8kzmw0ltyLZeobEUoLa
 n4PB1OjQWsxI8nfCd0SlczvUPZRGbYa/iBfiSm06GKB8oj5no8Bv2Ajo1V5BPZ7pDVR6c+Qr+
 r1I8lSyZ+R6y8geI8/GSY2cgXG2Z63StO3XEQR/lkkp+jA7IPuLbqR09T8Lfbl0Tqkdk0yjSd
 RJSfALHIji8owEkA/KFyUIqzCE1zSRRj8xzTHyIm3nS7Bt63de10puUchPW4eQM0NUS6KsXFl
 pVMJy9zDHj8t4Z9XVfp7S4u8Qinw1zIhEDhzrNQCd4vKCrXrrGe1PCg5mdvaACHIaxkeiSE9W
 2pJj2LkI0xj4Ev83QjpiC8DxBKfEL/skMvFYdV764HhRr8cBMTNirjKfjZ4MfurFNionJSCH7
 CfXPAf8hyQHw06rTOTSs1hqdhzHUm7U6khVXUFJG+S4fvhNxZJD87qp6DMOP9xWswa8vyeGr8
 Ib9+SNiYUYm8jdSYVyMRY4LIdmjfOfpNJh/caphY18jXY+vHvuCFPYQXEHtj0jmn6/qCj95K7
 iedIVrNiRTayyEP3hWbU1u7f4YNzpaImtYQT0LLj2g+USm7FaxpB4TZstwn09mjPu6aUY8rlD
 QJr19UzHFNZVgWkJ5kBJGA8HGyhg1Fb8jw9GLI8aUcrS2i16FMkdkOKvH9VjzPxRwpI3EPNSS
 famT8DqNwoaKb8WY8F99laknYG5ocQRKszdaZe8EJFuLv2Rgxy8VDuH8QV1bDu/Dta66TPnj7
 0j5rFD2CO7QxXTHE3FJy6jyhXEw9oecEeYvKKO//Jc5XQm9WpV4bIPnfMez/fKTWj/ftXaEcO
 ySnueEtdFqyYxJXIKgthoWRNvjverv14+Ch/dD32vi2WoSlb5Ydo9W1QZlrOv7PWjEPQtdIt2
 +3zu9V2rZsQsSNVVjcRc8HMMnbAA4R5zO836tWhl07SJ+BJHwYV6V2+pBlsTt03bKgmQlmWL3
 LWCInEBFc5NBCzWVp0LU7cLAB6S0B5Z6u+y1WzTmg9vz6U6CrMC+KnpS6QUUbdJ/nHNR09sxO
 RiCBVOQKlMFOWFdo8nroqs1kNUKP9R/clVljZ2JXanDL7tppWYjbItlc6VJbd3mAyawaiC7eA
 0WTKP/tMThxkZ//z9qDr9zqxmxcz3fbMU88sjwQrYZ5k7nwamZiiznzyYnsrwZxxAhD4thylV
 kSwmihBmnP9ttpkwUNnKRI6oMiR46xFMQVEGG0WQG7+KGM3YYmsrSlxub7j8r9RMlBHH+t0RW
 hPs/DIqFx2qNACuOd7SYF0Cps0CMG2tfI6ngott2USUkuFo4bz6D2yHaOvlTo4l507VGJntT7
 9zwgNci3geIOJiYQmdy2pactBZRScyxYFAeyfvErH7Rp3IMlcdl5EmObppO3blzrR59gcjBkA
 7F03iv8sYPlzvbc4j/0oLHh0jKrQhNJh/xzQunZR96CzfvK3p4lFXsqc2PXz2dpEPmCMqRgum
 PS1OBhIVicaY0nMQfisMCoFKRRlEwCUK+jKgxv1ISj1TwhuvlgSUPx0lHsHXgzeNYmMiJ27iJ
 9UENVYIzuAiFjO0aSFbAr0sO4YAB0ikNk2HnCI8peWleK/dz7um7pWeb3pi+qDHQXzOh3/uk9
 66UVCc6zANn26ahCMj5dlcgs/7if+xk1W3weXPwDhEnkfu6HQs7o9u9xMVzzaACALnW5j2evg
 6zfr8VnyHkEh0ZlDsOWRjKy6JfF5e6oEWriERHLr/kl+CcuMXIo6jc6nrBjY1fJm7YSn+hSbb
 CN/EjVAuUWsViGS676fELhnxuv+3UlIFAMab2nOzqZK96YInJBPiI3i8BrHviR077z1FYjfPG
 31M109UyvVer2IZBs2rSH5sDK4RbBWZ0UHPgOiLMKeQM8jMUF5QG494ZD/AMj3PGMX61oPeyD
 fPtx3xbHpYzfyE5ZBc5CL4A7cN0Ha96/UCK/fq/74EFd/PZF/1KJQJZyR2f3OUTAqt8zRsOL4
 gOLQnfi2FO57BOWCzdVZWeL7NXOSuQ05NTOGmMuxQXcWfBwxn9IDsDy1AGmOVFbbO3oNhM1c/
 VDED7eiw3WyKAQ0K/O55tLdqTvhAOesbuxvm7RRIvN1Fy3xT6xWCTJlWUkVddSluh0j+zUNPQ
 fpcr5Jc5O4OkhRFEOOL4szWWOXFDfSF8MfqdLijPLjpVtrv2VDk7LLfWFEG8NnAk/EqiIV+JJ
 ZZpo0Za4yTcQAttKWFE/DAJ0EKilGew3wWXq9pA5GLBY1QjtMH2A5cZUb5BgqltWf47QTdeMg
 j9krJgaxdXL/hP7Dh/yxXetY4AESUj+lb1lFeVKh8tRKdC7vBy8K4c1igj4+Az/U69x7SrEF9
 5o6UidUW3X3Se9zKWgv53fArOdnI7a5rssTQyQvxHxd0uyCLD8nG0GnVBB6hJUymrCoLE8Fmb
 9prS8YpTtdEq2aMoUSdbI4YYCyH2yOJPpZybUBIvp8eNWiOkvaGQo1hm1pc6Cb2iu2cIY3kMB
 w7TXa7zdaVKc54A3pugB7WjWOiQEh+peYGoWb/3ime6OZUNMyBRPO/gWZKCw8t8vKtf7AJ4eb
 EuCoLTrodONC7viEGBsMCSNz/gKg29JJMoRuiClWTTAAMr3ZgTcmSu0RNeknLp5133fNmusO7
 J6oQapVzDLj3+cFhoYWrv3xcCjc7xebXg7eSLHwNkWLNRo73oRCHvxwv67Z+x4d1LM8aBPeMt
 T1jvofqa2C04/YkA4xtZWFePnA5FBJZuAbTdf08I9uhVbh+DUs6fofBxqRUH0HA7pxCzMY9o+
 o+tNIx1PDmTeQmtoxJpDtWfCLitz4rOKAYvhTYEBsyNnuJwTW04px7o//qtDDS3EC/Gkmai89
 GOKfze8Ka+0J+H/QV8ssakTKc68coLwEtRk/owhK7Kv3OnDgE71lon+nR/mTP0EhuMZHcqF36
 KMlSqfxSQxXK/Ny5JKZ8MvWqDa94UjRkvSBd5gGnWTG1Zj8lHNFWY5Qm6CZuyhTYsY3SfUcQL
 vR4sZVYIThEz4HuImUAS4Hk+ZX06w17r9gggtzUjpZMvn/2/U+XQOKKdIDF9cGsM6/5oXyuuI
 7xgA7bzzJBIAGJilU2Qe1fDoWiqymJuosYaOYt5bLp4QBAqYrJlO3OOK5v1qNvDArTETlptBb
 LPZqdCcGu3yFPvAoUPoRq005LFsbmff8qo/9XBXtYqX2apsTFLCx26dVZZ6DSe3pcl1Gi+6ef
 KiZcBdCM1GfmZKHeKxp7xzh2O29HVWhidC/YAwInFAkoxFTlK7GweF+7n/MjY/AEO70+zipN1
 E4d56m0Elegylfs+jqK2lEKevAYw9DxvDcjcwUG4SYFTW+z8EqchpH2T5FkbLSfwwUhOC7Ag0
 aBE2mc+YiloaJngm3W5RwG3RmzdgsjRoYZ4VBf4EYopDdj50T56LCxxKgJmI8R+haI8z4iw1/
 /i2ydKA/mHSPmt01+r/8JTUxYptM8fuuSTctRFR6JyLxSZKznQox4H7jkHGrR9Y6QENKi9wjs
 hiStvC5Kv8inPViFMg06xe/GDeYkJFrC3rUsYjQiBE3U+Ww/z/91iX7dyxYmAOU6/RptjguPu
 mpXfyJibFVKTfn8IfPenWqHcFrFUV/ga0NkFwV6O7vBeEE9qJ1ng==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306965-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:danishanwar@ti.com,m:mgr@kernel.org,m:pabeni@redhat.com,m:u.kleine-koenig@baylibre.com,m:vadim.fedorenko@linux.dev,m:dong100@mucse.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E68AC745A3D

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 12 Jul 2026 20:25:10 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Crnpgbe_rm_adapter=E2=80=9D.

Thus avoid the risk for undefined behaviour by omitting the variable =E2=
=80=9Chw=E2=80=9D.
Pass the required address directly to a function call.

This issue was detected by using the Coccinelle software.

Fixes: 2ee95ec17e97c58b65e978a08b75fa8cb6424e4e ("net: rnpgbe: Add registe=
r_netdev")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net=
/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 70a2b0082ba8..93cf757c951c 100644
=2D-- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -245,7 +245,6 @@ static int rnpgbe_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *id)
 static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 {
 	struct mucse *mucse =3D pci_get_drvdata(pdev);
-	struct mucse_hw *hw =3D &mucse->hw;
 	struct net_device *netdev;
 	int err;
=20
@@ -253,7 +252,7 @@ static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 		return;
 	netdev =3D mucse->netdev;
 	unregister_netdev(netdev);
-	err =3D rnpgbe_send_notify(hw, false, mucse_fw_powerup);
+	err =3D rnpgbe_send_notify(&mucse->hw, false, mucse_fw_powerup);
 	if (err)
 		dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n", err);
 	free_netdev(netdev);
=2D-=20
2.55.0


