Return-Path: <netdev+bounces-102487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4F9033E5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EAB1F25F6F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB87172790;
	Tue, 11 Jun 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UjndKFr7"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5AD42ABA;
	Tue, 11 Jun 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091612; cv=none; b=DTITMEZL2kBUGY+A7MAu+r74oH0F6aUTVSeBmI7+k8NX9ia9o1bOPZmTi0VtwpSrW2S/zkqAgai3Zc1A697KbFqBQmQAMA0hnS/FWiQWPUhs9XXnkqWtgsaUHhSwyXzmpmmHbsv/cHqkldWfQlMatIqrQ+Ve4DWVBcLpdAqAWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091612; c=relaxed/simple;
	bh=0swJ7oefZ0XYQf1W0sRTgx9AL9YWktm9DAr1gHajTPM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tMyHXixAogIHRKINCgd9/wLv8oQOUMrhFanimaRz+Dy2ulpTwzq7ARchjBrNetl+6+JahDfHJ7M3W4KZwWRsD6F6Uooa4u8te7e9gf8OgrvszF0bSMuqTG6YVmcx/KOMyxoA8tQ2FuVzf131dhxtpTiONSVhwTtG6evF2F49WGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UjndKFr7; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718091589; x=1718696389; i=markus.elfring@web.de;
	bh=IYe0QuucfsKEN4V8P0EKM9YqkQpxlrZscd9hQ6V7hDA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UjndKFr7MtX2Tk4ugkcY4fHSiqYCp1aPy+pVQXDT0PhuCdNVqONEzMGqZB2oFedM
	 7h3GVsuOmnW/aYLfDB6XMRv3T1qnlO3dMuIPqdDhs2nrmMJMO6e85lJG5QisVfUxM
	 3935rklHO19sf3H6KWgWo78cXLI6xz6ctHulhrIq/Fw4KVWTc/iVuotO+GRuoG2my
	 lOyXv1ENMbSUw5pnYLFqV0IiHbgx192oWBNc5fPUU1ZSR4rAoGzl8L+EFsZgpoz2e
	 Bk/1o2BvNCBVcJtAYKBkkLQEGSmFA3ukYQw08Q5cXpg6Nd8ZtEEPNeRQOvu41fXBV
	 YZu0YbRA5GY3RkL1rQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xw0-1sI1VJ0rPg-00AojT; Tue, 11
 Jun 2024 09:39:49 +0200
Message-ID: <2ed41eff-284c-4c44-8090-d2c1765ab6b5@web.de>
Date: Tue, 11 Jun 2024 09:39:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gui-Dong Han <hanguidong02@outlook.com>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Chas Williams <3chas3@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
References: <ME3P282MB3617E02526BEE4B295478B1AC0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] atm/fore200e: Consolidate available cell rate update to
 prevent race condition
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ME3P282MB3617E02526BEE4B295478B1AC0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PqiipKOL74c+X+TwSvXlaX8DmpLwvd+tBTxwPu/+b42CG5TF1pO
 1w+vyWhpMZ2jnlmvVSu4ZjeRAcBg7iZkBDyjr/shzRlev4H+hhso+VhjRW3tvKhyqIoX3OA
 E1TGt4AN6Pp13xtO6lfXBgK/EtzQMqj0Asf7Xmcjw2uWtUb2WTnwnSSdLr5rIqMkzUfvlam
 2hnsoaOn+2gGyWQY+ukfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KKCreMyY098=;JxyQK6L5bAZizRDrwVNSFFjK2Du
 KYJ9acYM7pZh8kgSwJHGjwNTdQ2RsiF1WQoaXn7d9kpW4vVKGemjIrsgXtg6jVzmADW2j0BNw
 XRiijZFS/KoiIR+f5Dq9xjOeyX0vlcPx/lTXilme0xNy4nqLeFTYEPoSPLLzFcyX+1MAnRm05
 moZLU4FFkOPK7gIGDky9mKHD66ejlin0FQ8FJethiYuKQ1ehKYbawBTQP7zrGiVvmMqtSmia0
 LinDFoCGuZrhw4hxJY32nIkU6vjBh5rBVdFkV1ZVhkdi/IYhWhgfO1U9RqnTqolBUe/f5aMx1
 3otFxXdo/4AXokK0TLdsCkhBTe4XYwwq0672TKiIrpn6jyzpj27p7K/Pu6adjXFlfYWP6jXZL
 Uu/c6RmDyYkQOB3W393qnebNJEs6WTzQib7vF/hS2a5m9KYb66XlL405XfNOdXRmbNkqFpmUO
 Bm5bqFmzh8TqprQWOK90MbFjI6pkWNI5npOFMAIimA0ktS8m4Wc6ERi1zN4m3J9+TN6FDy1dR
 N8ViB2GdzlsJUGlC78CchVP8mVwyYI16o4JqAUIeuBUzSiexHMFrNdDmz/n9mu9AWu8qJ+5KO
 isXAkdcrhVk+vVXneRyttwuxNT+i/9yKAv+s+Pv2j8v7zTAx/P/+pGFchQ3YR1rkWkVhxiofK
 SO4X8WEG67EmJmHkztdh+gWxh446E5VbhePe7e70y/cK1l1mltl/ngBi281BX47HFWZ8JT5kx
 koqUbxOoXwhLjbliAzsHWTO1rxJ1gfrLb1X/rb0AF/v8yTdSwF///TpgFFSq2M9q1bNG1WBjR
 wJ/uMKAo3/W6mfQ4yUbCg2PqdewKqSVoxtq/IOsMRPdoA=

> In fore200e_change_qos, there is a race condition due to two consecutive
> updates to the 'available_cell_rate' variable. If a read operation
> occurs between these updates, an intermediate value might be read,
> leading to potential bugs.

* Would you like to explain a bit more why you find the applied mutex
  insufficient for data synchronisation aspects?

* Is any special analysis tool (like =E2=80=9CBassCheck=E2=80=9D) involved=
 in such a contribution?


> To fix this issue, 'available_cell_rate' should be adjusted in a single
> operation, ensuring consistency and preventing any intermediate states
> from being read.

* Please improve the change description with an imperative wording.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc2#n94

* How do you think about to specify the name of the affected function
  in the summary phrase?

* I would like to point out that similar source code adjustments can be ac=
hieved
  also by the means of the semantic patch language (Coccinelle software).

Regards,
Markus

