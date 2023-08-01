Return-Path: <netdev+bounces-23071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5384676A97E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C61C20DB4
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07B611C;
	Tue,  1 Aug 2023 06:49:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0073D9E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:49:34 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A03395;
	Mon, 31 Jul 2023 23:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690872541; x=1691477341; i=markus.elfring@web.de;
 bh=yYAOwnUp0FVhwQuXit1qBWt/wTUp0s5MCrJU7XEgoUM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CLbhlAT3gTbq6bf8v/O1dCqSNuzRB5D+8NyYHRHHjaC95LMMqgfXMgQ+h2VxNM3gnIrl8xk
 Erid3ppxF1g9NvNrbpFh/w9qlnX8XPpwGyNZzMnJxSHqNr6tuxYFSItj81wwg7M6t49A6syh0
 wrnK8uaxajkttag+etIG0SsNHZoOA1oPYDNnv1pXmE8fCiiVIERWTZd6XRxYg4wkVMFzFQjhs
 oiWvFJWDfv9MCBcmrGe3lbBkxP/JdnJbQVHz63j9tWROnlmOEMmcLw+P6yDwo1kDPpkLSpYBE
 yhkIAVYRrf2hkIV90b8AWxxwHqHhsbDdO/DjJ9mMdgSX0f5AjRhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14ta-1pgxy31sGw-012RY1; Tue, 01
 Aug 2023 08:49:01 +0200
Message-ID: <ed7020cb-cee5-16af-55f1-f1adac08f1b6@web.de>
Date: Tue, 1 Aug 2023 08:48:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: net: dcb: Communication challenges for patch reviews?
To: Dan Carpenter <dan.carpenter@linaro.org>, Lin Ma <linma@zju.edu.cn>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@intel.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jeff Kirsher
 <jeffrey.t.kirsher@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>,
 Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20230731045216.3779420-1-linma@zju.edu.cn>
 <fbda76a9-e1f3-d483-ab3d-3c904c54a5db@web.de>
 <3d159780.f2fb6.189aebb4a18.Coremail.linma@zju.edu.cn>
 <d29e7d32-1684-4400-9907-f2f69092466d@kadam.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d29e7d32-1684-4400-9907-f2f69092466d@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uBtieeYhpAiinhjXHKebJXqZBuKTxvsctq6VMnYsHxPTrqnCSjl
 29yF7D9Zw+8PcVIjwqXU02kEYbdZqPVV77Jnlc/iYD4gMXp9kQII4cCn7JOhVjNO6H1HHKn
 Kr4xLogvpTTfHgDME//Bl7viHdLBNFY0h99yMNp9cFbUFJsXj0I5FbbZBrUYSpLbIi/kYKu
 k6O6XuSZEUwO6Mp/5hdcQ==
UI-OutboundReport: notjunk:1;M01:P0:Q4gNV18J9Q4=;muQi3WbgL1A/WvYcgiyNsUoXHeH
 HDEwZUbJry+lw4mihPhTKBJL5QRCJH2m/dUYPeBraATXYbEhpYuUC+NJSF62IFuTQ/tTp2iSM
 4GhUp+FVtfN5LZ3HEKJG8B+56/kRB68icrpXZCVTg1ex8+F7LVKPjBsW/CSKY3q4p8uhrb4KF
 6T/rVQmUyGInDKXnBekHwLJXHS/FOxDYsMJIVL1Q1KtMoygsDZMRzLyQnf837FOZld54XC8yK
 6PJVhzTyez3O1sluKJvLPK9eX+QJwFcGPJvAYFz+lLioCyAW3yTHkbUZEYULpbN3FuiJTn+Yq
 gH+J2y9bmuVPeI/rhrqXkgg3yGxa2/RE5DYN2mWJr5vlzH5ObDZc0iSiuE0mcngYNn5y+2U5u
 OCeZfUQZCPTDMXRNDvP5JI9oIZw5ZVb28j4yGalvYKKkw9CI+HoLeP70/0rgh1/V4VkIyPhma
 w0XEikgbRikTySOyko9NC0Ggra1NJAPadFA9ZbOgAHqbdK8v0fT74ft2IgVD5wsx7E+IoN42a
 GjUX9By9tgTx+BKz1ieE1qqiZt4ZgG8IQBXnrczoz5BxkHfE92F9GpQ5qlHoKBHT7gwhuMWGo
 BimRASJwDivgl6l/yESe22xX/fR2cuHBsD1UPFCIMgPrpd85vELsYv720oFHjTVvEh6aXHgto
 6V+Y6wj192GoUARF2wU2mJ4ErFBuuaUONYmLxShTtO6kvuwnxG8TlM12TyaNLZwsCLxScOdHs
 wvOJazFLG1RY74a1QM7FuPlEA7P6y47h4kd5hJNC9Z5rqfF0ZcQLEcs/CJ04hTYFF43udAaGI
 e1oOxbl1v32uwnflPyiimFW43xM2Q4Tnj0AgmUM3Z7A4b2LrezcdIGxtseVtFZQp/n2cH4zqf
 vVfvniN6IjpmVp/djLtYjmSd8ya7s2HA9m+xqCXblExeZB8m0ffW968BuP3EFfl+QGMtHZm8T
 1ThIPGof6PPp8+1Yyj5jFOhe8wE=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Simon reviewed the patch already.

It seems that some reviewers do not care so much about the recommended app=
lication
of imperative mood for improved change descriptions.


> Don't listen to Markus.

I hope that further suggestions (including remaining patches) will get mor=
e
development attention so that the change acceptance will evolve accordingl=
y.


> He's banned from vger.

Is this historic action a questionable side effect of known recurring
communication difficulties?

How many contributors are blocked so far?

There are also participants who are still more open to some change ideas.


> https://lore.kernel.org/all/2023073123-poser-panhandle-1cb7@gregkh/

I imagine that the =E2=80=9Cintelligence=E2=80=9D can be improved also for
=E2=80=9Cthe semi-friendly patch-bot of Greg Kroah-Hartman=E2=80=9D.

How =E2=80=9Cnonsensical or otherwise pointless=E2=80=9D do you find revie=
w comments
which remind requirements from the Linux development documentation
for a discussed patch?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc4#n3

Regards,
Markus

