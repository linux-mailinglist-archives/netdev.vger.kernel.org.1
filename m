Return-Path: <netdev+bounces-182613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD4BA89529
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BBC3B8794
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E224A043;
	Tue, 15 Apr 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="esTZfuej"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951F200B99;
	Tue, 15 Apr 2025 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702360; cv=none; b=MkjyP+KBiaJuDt/cBlnEIXULWA/UtzP522wfCMoYSLtNboiXxvGUhf4/iCWC2vHLI1vmfpnIdNpR/acB/0wo7Y1LXCvbVZzeHJHoOLSKybJfp6EfWqaTL2WpEDkk3z888fVPNS9ORpZ/Zq5JMtVUOjmLaQQG5zBzCB7EAT9/tfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702360; c=relaxed/simple;
	bh=KYTW3eRKBGe8a7exnVkjZ0yTk1fcE+hKlVewCIxqYjc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sIvJxLNRsXhymZlF6n/vq8Zc1A9jG6AaBvCfuWMGO6i6LT1dAKzKIISlUUGCSbiW3PWZTCjOntv3DaQERXZnURkVGjU67onvG2PhmUukaQgu/wRHPI/m/rvwm9xHH8DARH9Rkbxq9Ayf/+q224pfk65YqfnED9GZdn0oS3EtbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=esTZfuej; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744702330; x=1745307130; i=markus.elfring@web.de;
	bh=Y3hpFMbH2VqFPkSv+RSyZUNBufHp4grv4jlfXWwRjVg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=esTZfuej/4JfgdaNPozd5RAGY60D4UaT387c0TJjV5lBM73CrPZFu09oGmS5za6+
	 aT+C6O3V9KRqFDzRZVEq3NCWNf17PoiM/vXSO2YtQBkpr5YgwO/O/qqul3OFVakdu
	 PnDgFcE9R7Z1nuA3EXSynHx0+P3nXCq7JSLkSzy21Ik35LSzVGzzU9Xyv+iyCMzOk
	 cmnjXXbloWNavyvwnOJP0Ye2eGtXoL3edUvk1P7AXLCtZ+RdrhXN/mFkB5oht6i+C
	 E5TAet6rJZ17wbN/w2GpCqyXzTcVOkekB3eXVcvB+lR4o6snzcWmBCkwJM4DiFmq/
	 zmJGjwXWU1fjgQoPdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.24]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6pf-1t62Mf11SR-013iOd; Tue, 15
 Apr 2025 09:32:10 +0200
Message-ID: <777db8bb-89d2-46ac-b7b9-0b5f418cc716@web.de>
Date: Tue, 15 Apr 2025 09:32:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: 990492108@qq.com, Abdun Nihaal <abdun.nihaal@gmail.com>,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Bharat Bhushan <bbhushan2@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
References: <tzi64aergg2ibm622mk54mavjs6vbpdpfeazdbqoyuufa5ispj@wbygyurrsto5>
Subject: Re: [Patch next] octeontx2-pf: fix potential double free in
 rvu_rep_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tzi64aergg2ibm622mk54mavjs6vbpdpfeazdbqoyuufa5ispj@wbygyurrsto5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cn3lN5yfy4QAQCRnUGWu6QbWruHRdZjJEumDRw/aCQiwvzl/oCf
 IhLeeQiIHR3ZvOL5+XdXVVsPW0kEDlMyhr39IKjdxHPPrFUtcnJP6T7y9jJutrhzFoptrEl
 mOVz6Vwsi9TuJS3pjpfbrbt1S0zAF78Ev5TqlDB1f+BjFusOBJbadLLpo/J1HIJpcude3rV
 e1q3n3EYTfVLMPPabD/cQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+6t0dhHJyu0=;VpHcaffIKrlzhF12K6Jya9HChVp
 9uuCJlAyYrijuDHo/zsjMw+9vSk1Pt9Qbodna8kmecSsxSBzFwJNHIkWPwEo+EAKADTfrgs5u
 8d/JBpNWzm6EJt0v0whUg0B6OnPswCGvF9rhIpbgfHhjqQTznlUuUevCaoPHlh9X2rKptUpzX
 RWHaHZX+Tg0eoS2Vo41043y4mWj7L0/ji7yIP72RhbkNZvPWxmqTXAR5YrfHxA2eZSIS90vx2
 uSldA/yC9iKplg6oZCSZ9mrVP58yjg1BNPaQs4VmHrVsjJ2khe3a5Z4e7LWrIdtyfPhgN3rL8
 5ek3RJ5kAx3Y9Ch7E5INukQEHie63bt5lPcNyqb9S9bfN0JB+eMBu5Z7UvqkkHIKhAK8Q17Ev
 uT8YbiIUbBVkvXh/VJUBMTl7Wpr2h2THTi3Li+PBCQo8sVW88R8JR4+peWkZP7brQvTa+Q936
 /PXEpZXvm8oXrGqggV+kIzQ3Sf9xIikBVz9Mi3bFA39nyoIodlLzTN2E5CrB5dLMDy/UGLcZc
 VQMVivL6HawaQ1kW3EFhXH2FSp/d8oJhfwuCWFk15YjBOFp3XgKRKgDOooysqboTCKLX1nXZo
 LQpXul+algKzCgd9JqW0/eDSerdJEe5MFOQiq2W+IugzxwpRONF2S2XLYG1XcM5cSj8WsNF4U
 Kp+uGIz9bX88vWzNJv1nEzI0i3hzLUBWd7uYrdlcBn6Ax43pmt+L3ddttqPf/hmcSIv56OTgj
 PlBIApQ/njyL7d7k0sgxTsvRMgMGEIPhwtZDk7J6brB4LoF4Dd6aXwTYoktokQahVVntpkfo4
 pJX3KpSc1SZXZQnC/sTXMVM090XV5B3rza63S9G+NZ1Lk5qQEDdfiZ3LB39Grs98W23bvqbF9
 /Zm8uBl1x4DyzD2F1Fg2AUyb8FQM2caNty8NgjUd2rcIb6hylpiRq3MK2ZKTf5pvpmq7L03B1
 g9ZkV2zLvguVeV/kOKWcvLJpW4nruc7Wg+/X6HdzhyJOoWlJThFtNSlRo8QVnHVbKMnTYm2iH
 Wqu4kFNlbQAtwXTgX2lAdpFdvIz4nSKshgno2wFJxkRlKiL+TyR+1/JXPY5EcxQ1F79dh+mzT
 Tr0wmCR53Bj+W/QVnp2J5sJYxkUKpp/CKalHNlEh+EXkzNq5oiOCNXf7p6LPRa0hn2g2Xm8LX
 Z87OO5T9cDrKWh+tECrfTGmsVFbS+PIscyPa+uY4axEbNY1p2tKSUe8mBe4wHpVQI42bU8qmd
 kNcZS60IsSzwvfOvAXo3w85IABAzGxF0GmPLAzrQIi+GvgfgNr7Kgf+G5BR81ZOGyKvQnBoxY
 4KwwxvPOFItr3/u0DMs9wvA4yAJbeCjLDoSWDrsV4LJt/owqY9PBLTrsm8CoEVWjgzjOcfn1S
 gySFYxN9DuiiZ3c+EynLtE8MWFZLfWyeCgXO447DNc4U93LAMopN8sUGREyMpS5znh8QhiAv6
 VcJCNIB+SXtNcxlzfrGUeqth+nBlc81RXPwe23C4PaPRej0WSoAPAgrz2jjBzoTlrP/swzw==

=E2=80=A6
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
=E2=80=A6
> > @@ -691,7 +690,6 @@ int rvu_rep_create(struct otx2_nic *priv, struct n=
etlink_ext_ack *extack)
> >  			NL_SET_ERR_MSG_MOD(extack,
> >  					   "PFVF representor registration failed");
> >  			rvu_rep_devlink_port_unregister(rep);
> > -			free_netdev(ndev);
> >  			goto exit;
> >  		}
>
> There is no potential double free here. If you notice the loop at the
=E2=80=A6
> (De)allocations in loops are quite tricky.
>
> Nacked-by: Abdun Nihaal <abdun.nihaal@gmail.com>

Would you ever become interested to avoid a duplicate free_netdev(ndev) ca=
ll
by using an additional label instead?

See also:
[PATCH net v2 1/2] octeontx2-pf: fix netdev memory leak in rvu_rep_create(=
)
https://lore.kernel.org/netdev/8d54b21b-7ca9-4126-ba13-bbd333d6ba0c@web.de=
/

Regards,
Markus

