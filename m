Return-Path: <netdev+bounces-106638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68734917142
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A962287F83
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4D179206;
	Tue, 25 Jun 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rKucC3el"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC92146A93;
	Tue, 25 Jun 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345062; cv=none; b=qRJVUdFEp1gdr12wz7ovrDe5itmhh6l2YTIcmDFa5h3Yo6W9sZ9xkFOt4hxJk2zANXddU7eybDbEvcEQMoy/GRbtZzdRnKodAZ4bF2FWOoWIeMddqGRrA+jQslY6uVBQb6YFxeu/72ylep+aXCF614DV89zUyyqKcYZ5IQNJtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345062; c=relaxed/simple;
	bh=q61SoAdox/WBBhi8gn9DCoq2ivzhK0IMMq8W3Jhug4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab/HnTOdElvx5r+6T0YsRURcScFApsmFKMC3H2BlW9syn4ncs/UYSr6TG8esLaJIwGwuZ9G15a06QfHE7bM774a8sCODmgHJQftXdefJ9ZP4CksRVsc7mpG/0ZgjMVQZpBGbFhMXr53LO+oUud16Nt2GgUOB5oLoyRXzw02AaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rKucC3el; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719345035; x=1719949835; i=markus.elfring@web.de;
	bh=KcJwEYMmFuTXnPbYkFDyuXTVqSseTQFqloyrkEmiI6I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rKucC3elPTnFm33WhFmEvn77UdN2AdhtvKJ/QSTSf+OsE8BGiOexImvt3c22h6TI
	 +c6frwvGTp3BYZQJAFQTy3vDIfl39aYcxzMRF6A06MblBeD660Jd8p7XCM338atco
	 wCZF5ZCojaWfbKmpp05t1tO5qWSPf6TWS3V0zsQUhvQWTUIVnPstm1P5R8VqWE1KZ
	 aJ7Z6hI5YfwBD40CFrwtzgT0dt5/6CEwvE89Px53rnF/T+ng0M6NCAx28VtZ5cbBY
	 ayqKrNSLlDjmYRF3cNjZ7ZYV+uG6fy3wL6Nm3+dTLw+CwE2tC9FSvmEnCAsjzsskD
	 hierygOKjsFwXKhSOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1ssUfA1PwZ-00iCyu; Tue, 25
 Jun 2024 21:50:35 +0200
Message-ID: <f3514471-9978-4aad-af40-e4970827a61b@web.de>
Date: Tue, 25 Jun 2024 21:50:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 0/7] octeontx2-af: Fix klockwork issues in AF
 driver
To: Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jerin Jacob <jerinj@marvell.com>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>
References: <20240625173350.1181194-1-sumang@marvell.com>
 <8fd713c2-5b85-4223-8a06-f2cedc2a1fb8@web.de>
 <SJ0PR18MB52166806AA7FB13ED3DC3E39DBD52@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SJ0PR18MB52166806AA7FB13ED3DC3E39DBD52@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GE+CfSs9XOZOEKhKPKItjAxMU1YqSmDmV73dAO3WNcpIb+msumA
 HB9eLZ1/qRE1GRMuB/2cb9/lkBTx21yVC9wJ0fubxaqpEEjx/rtCxNdteybelAeerQvaLZY
 0XQji1v+inv2MF6cDtI6vkK5ZyKj8S3aP36PKssc3StNPAofLP2L54YA27O2smLE1+IKbQj
 QB71lTvUafbidldjaYsoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8K86JjzKEYA=;hjqg9zQBQB/0YIEKCocP9JVCGAb
 a0Pmlxui+B44I+Fpmzx9+VWv4xUi34CThsb17ByT9II5ASayUBtJYSWGP0lakI/ASabcf1rvR
 QBs/dOdXYmx/LuwywWf0pwe0+q0/uW8ZwLKmVBe3+hVWoxc2jr1yrOd7psir/bQSfA/0Xaqy+
 4xTyGfoB5vr7MVvi9wuFQ9NQmfMri+x8zdyhpglBh9/NpJIs/f6ruryqlDrYXmfw18t3RgXia
 GxbbuaiCU9g7tUbFSy4M1F0qdwB+xz47qsZvbHsnerLazcD8dLnOulFGfChO42IN3qRu9v6DK
 rLqX9IXRIY2cV+vI6P8JRCpFMAdDKS2KYaRba86BZKb8jBvO9utS2UsEeQJ1oAulyQcn8S4na
 yXz6yHySadXT9gk9U8/iDXLMQZ2PfkdXbNbTGwWVbOiWn9xhYVNHwqxTFCH/Xqw8fm5LeFzkz
 IbvUIMAX9IKZjA+E0qos4LY6uf4Rh3SHbplNAkSGlEn9Wol14PKSgEaEEM7X4r+hou+h6NxEv
 jKzqFt3eNGDKIuHZ5CHiWV/FkwR/ox458WuLJ+iDbSDqaUg9CsuwSsICp4ZCTx/QYk6Pk88rg
 PndbA5hTn53Dw2BPoJv9ohKJPV/AcG2qjiIExuAgf5b+wOtPjDd5O7s7+cnWSxaGEQookHxvX
 9xUy6fVqbMxXVQ/HENyf86NAqn6F4Iaga8lp9BET12x6IZSZnqOoeGELV2aAk7ytsqx0iclxH
 mbteoDgW1XwyXryi07o/vuMRH241/pl6YFldMERXIKJze/x4GgEaDLTKama99sxRdIFsAqieh
 AyE7fVuKKFpzDRmnl28SAfVkXOT1c4aAKf9hw0+qZfkEY=

> > * Why did you not directly respond to the recurring patch review conce=
rn
> > =C2=A0 about better summary phrases (or message subjects)?
=E2=80=A6
> [Suman] I thought the =E2=80=9Csummery phrase=E2=80=9D is per patch.

Summaries are obviously important parts for patch subjects.


> The cover letter is mentioning the reason for the change

I would like to read an improved overview for your change approach.


> and each patch set is adding the summery for the change.

I have got understanding difficulties for such information somehow.


> Since it is not some actual =E2=80=98fix=E2=80=99 I am not sure what mor=
e to add other

It seems that there is a temporary conflict according to expected explanat=
ion quality.


> than mentioning klockwork fixes.

Source code analysis tools can provide more helpful information.
Do I need to remind you for the published software documentation
around =E2=80=9CC checkers=E2=80=9D?


> I am not sure what more can be added for a variable initialization to ze=
ro
> or adding a NULL check.

* Common vulnerability enumeration?

* CERT reference?


> Can you suggest some?

* Please take another look at linked information sources.

* Can you get sufficient inspirations from published patches?


> > * Would you like to explain any more here which development concern ca=
tegories
> > =C2=A0 were picked up from the mentioned source code analysis tool?
>
> [Suman] =C2=A0Development concerns are mentioned in individual patch set=
s.

* Grouping?

* Outlines?

* Taxonomy?


> > * How much do you care for the grouping of logical changes into
> > =C2=A0 consistent patch series?
>
> [Suman] I thought about it but then I was not sure
>         how to add fix tags for a unified patch set.

Why did you not ask before sending another questionable patch series?


> Hence went with per file approach.

It can occasionally be helpful for change preparations.


> Do you see any problem with the approach?

Obviously, yes.

I hope that you can take several patch review issues better into account f=
inally.

Regards,
Markus

