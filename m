Return-Path: <netdev+bounces-17635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389775278E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E311C213F4
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABA01ED5F;
	Thu, 13 Jul 2023 15:43:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70F1F160
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:43:39 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105B2705;
	Thu, 13 Jul 2023 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689262992; x=1689867792; i=markus.elfring@web.de;
 bh=C6qd+tEJmMjC3NuPKVEamQZVj/fmkYUNuap8hQNtwWs=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=bk007cZyWdqfZuts4ANy3WWLZa4g2W1ztsUSShhBrf39TDvsEJ4W/4RmIbx3o+8qZED0+Vu
 ayJ60c836MYNnPLPHxHpSF784qQjqyf8I//0BXDd5qE5yhIGIWz+dfWD50+DWeyv4OfHzly78
 KlN8tZrmsxH0qHj4KiD6U/Fe2QLRJifm0VoNzK/Es/mGnqAW4jC9NBgpc2vwg9O7CwoqUdLpv
 oQykpPNXety8zg5zuOBwy5N6SJS5/hxTpkf8i8lt+pjrNjZn0tG2FWRMPAYJOEpNo8z1K3gG6
 XPusKoZW+AsMlOsXwoq8R9BfXbMFboM64HbEJG0C4pWdZyfJyPyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtPvm-1q6QOP3lD4-00uvfN; Thu, 13
 Jul 2023 17:43:11 +0200
Message-ID: <03a2b8f8-7215-1d4f-5b4c-f523be693a4c@web.de>
Date: Thu, 13 Jul 2023 17:43:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Minjie Du <duminjie@vivo.com>, opensource.kernel@vivo.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marcin Wojtas <mw@semihalf.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230713044507.3275-1-duminjie@vivo.com>
Subject: Re: [PATCH] drivers/net: marvell: mvpp2: fix debugfs_create_dir()
 return check in three functions
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230713044507.3275-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rJpqoxNXGlKxtzq7N6tRqVybG3yQOrh774oM5IYtlSE9rqI5Otn
 oZbpTnEV/eE/5jIOOXXkw/FqIUq0zvCSbv/THzb8JxheGSUZk2AuI4C0XTnZyIjTcL3o4AM
 Os1/jzP1ewdbTlsGhBwL6rUUyY/hdGs2R8N7YNRor92YL4QF/VKfhd0BMgSO79BHsmsWwYJ
 /T7qtJMKXnWABvcmICKog==
UI-OutboundReport: notjunk:1;M01:P0:csWlBxhmnsY=;tKC01ypB2+J/RcsXoIq5Et1NQyX
 RbpNRFsPWaN7Bi7QDG05mjTzOi0l0rJd+4FOe4goQIUxOJNPQiNIaJg/Rm67ASaGk7oHFKohd
 3NCAoD9ITaGdkhFGccxONRBv45SoN1a+3sDCbg5WFoaCpZtU4rTJqiYwEMdZUnu37YlqD4Y7B
 aecCqdMNkvByiWBxYtGOUrzf1vWqN4hSocHDBN94tD0oAGD9HPYCJW4LxXl4L8wFwGmyAiMEW
 48Kq7N3Qrz6dqq1VNkfZFzwjkqT+Q4P9d07xhpinvQoXPMldw0QIPeE46cao2e5V+k+b8v/Lp
 pItKM29L2j5Dbkgtcta6RKq9EfCaZYPP6a41hbC4AVTAbiepNn3vQSUgUV950tJE55JDri6io
 dYeklGitQ/s07oYUeykFunqAZOMj8Pqx70VxGyFHGQEmbGmvXObWPaQ26TngRMW/8qcvUBchV
 A6LWhYn4zJTDbGpuu+08F1MAaeXuYj+q5CiXvS5cOS6ueL5ay1+X6Cw7g4fOn1YNzF0ifwnRb
 6LLWrYfyHH3H7/Rdp3G873uctXtDYR2+A3t5pDvjO6fZaD7WRZ+IhbGCveI5IeHdqxC//KZxe
 Eqoa8FgRLbFYhvXF2ODQ5oSXda0+6UmZN3unJE96nQ7XDiZSLdi0V53d3IFGAckOwmyyJBWTv
 K2F4ievTfKjLu8p2n7pHPEmg9ytfIWTT/SQVDjzRqZQU7gmE5IHFBLunJm0HdETlJOvatr4WG
 1p7xU6DDnfLd4oAaggau8zgU5n4SvESx7VTTUQFBtgGEQAGHDMpLJ7sUWl4V8n255x/Vu5GtF
 BWBlyxCjmSbixvQdOoBNbF/87Lq156IXKiYUk6nLiJgzkaJOeV3ugoxeAkFhlKB6FzG3BCw8b
 CjUr/7E014X7QHSVTtU4F+O0D8X5SrZJhfZO2Z16rhAkdJmjJQqTjOAnDPRyHKpefBkfCtPno
 VzIFcrg67721z6aNrb8/ZfzkpN8=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Make IS_ERR() judge the debugfs_create_dir() function return

Would the term =E2=80=9Creturn value=E2=80=9D be relevant here?

Would you like to improve this change description also according to
review comments from other patches?


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because of c=
orrected error detections?


Would a subject like =E2=80=9C[PATCH v2] net: mvpp2: debugfs: Fix error ch=
ecks in three functions=E2=80=9D
be more appropriate?


> Line 562 deletes the space because checkpatch reports an error.

Please put this adjustment into a separate update step
(also with a better wording).

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc1#n81

Regards,
Markus

