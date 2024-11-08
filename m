Return-Path: <netdev+bounces-143321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A49C2005
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6234DB2170C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D329E1F4726;
	Fri,  8 Nov 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WMfNLYFx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CE1D0400;
	Fri,  8 Nov 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078404; cv=none; b=i8icngcNAmh+uV/lqa1CmH3L4Zd4fRUqXCMsALJ+kfwg4g6WERTlzKLlCXvIMcqgXV7YFyuyLsI7n88DTRSeDt9ox9jfU2Ht/DpfsZeS3iRy3I0aX7zfkJZm6jQWYSqPFE9ClNZNbVTboW5vMRpsB+nwcF/9KfHZ7cXF0Ci9lv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078404; c=relaxed/simple;
	bh=vF2G2XyACIvsSkulftA7rR72gJvegVGLforyIY18JvQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=M27MEtyikZrnaOX4jrD/cfGiHbueZ6d4MUscm2P0c/v1EuGpYQSMk3ba6fmKuVnMJyYZr0Csk7bHXkvc8LPGAHep9mvMrt4l3JL+dKzjsdmZF/qz+LJf99jJxQgM9o/U9pLWsQJG+QRqRgZGFJYmAKZ8lvUuZ8ESF/wgn2XpsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WMfNLYFx; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731078400; x=1731683200; i=markus.elfring@web.de;
	bh=JOfARLVE38xdD4X7k3gE07eqaFjFkpilj720vzhEGcA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WMfNLYFxJt79OBg7HkwD9xCYTn7lv8QV5hpwi8JBH9mnCYTkGy/Nha5thIlnVow8
	 fw8hg6aEa5OXrnRj6eJtKVSWGJFpBsgevFzWVZp5KzDx06eaE+3Hg1/gkNxFQ6hT7
	 wyzFyjKM46E3/n+EnMJAJoBpqU2rI7HUTwyFtOX2i6+tdk5hNgAhH7nEKM2mrCEgh
	 GU6q+2HLdEq6nwwydz2iqHw47Zh9y/6B9ga8hB+f0Z8fF07oGVQqrY1e1/tsStpf8
	 yneLqv1cyKVC4rx60XjapTqw/+meNrM/uO5v/mABe5SLiVv3GK/M6OMyoeAYWXgiG
	 ZUPrsuIleKKbc7Cjxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3ox-1t3cv40MOF-002hgR; Fri, 08
 Nov 2024 16:00:37 +0100
Message-ID: <55a08c90-df62-41cd-8ab9-89dc8199fbfb@web.de>
Date: Fri, 8 Nov 2024 16:00:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tuo Li <islituo@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Ayush Sawal <ayush.sawal@chelsio.com>,
 "David S. Miller" <davem@davemloft.net>, Dragos Tatulea
 <dtatulea@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mina Almasry <almasrymina@google.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20241030132352.154488-1-islituo@gmail.com>
Subject: Re: [PATCH] chcr_ktls: fix a possible null-pointer dereference in
 chcr_ktls_dev_add()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241030132352.154488-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kRizR2CE4fCzYtaFmdK6fWkzWaTNaKl5lETEg6b12oEuk2Qc7YX
 zHg7YkYxYUEQaWnzrVwDHRYaChkBWMzsOkpJ2ZgP8tsas765caPMtTbVD0haqetVWJlndUr
 GxtixE/xPVEWW1Jq56bxRroXjmvbbprn50/89r/e2U7cL9ZgUgfOUt36zIpGaBq9bacMUrb
 FMeV0kvgi3G0cHAp2EIOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p1ayU724K4s=;MI7hy6W1jp1yuzGTwEYRVY4vKga
 AzQ09Bs+nlaJnb+4CgTdKZSSDE2pdqCi9fvCgT/RSv86UzRLOwlveKI3YdDCK5OigTT+i1M8a
 UWCmi5708lmqigm+o8ISJ5bWpBQmLCSywKRXoBzJNckyldLWLACV6swOnTmZ2RusY6dMmb2Ma
 ABlGDjW17Wf1X+mkkKOm2haj0wJtCvyZbwHxYct/d0nRw1BI8gRLsXjb75V7fTXCpAwna3x5u
 76cN4uGmZ2ItCc+3hVO6JShk5PnbW8tLhbnGcV58YqIkH7zHlIwhmwLKNJzkMwbYxF3oFlpOU
 PDGbet6P5r3MRy0Hz9qnVogFeJZPHxZ9WfauwpYspFFL/a1Z2zWI0R7TEuqKhJvVEUyq6FOZV
 Iesw9fwQIWyo942WRMXBDfEdqQao43jVlruM+5zqiKXL3QiJnoyrfp1aBOhGgenv37TN5uVgq
 zj0VdC5uqX0dY3YzfqKdQqsx+nIdCwDlGgZfR1qniChUj5pryZBg/rGAa39o+2hVjG+HvOIhO
 7FeOu5kKpmwMtRHihQigc2Mf8rYelKPMoozjQJMQWWwY5AZ616Q9gnU1ZpsUMGmwfIpXJ8vod
 waPmSZAwP0cECbMoM19WaJp3Veu5aQys67n5avnPWlAZAQ5gCdpnJrtzHTvQaAWRrTSZ3P6Xo
 HDDqFzvShjPepU6hCv2XR/id3Beqg0GbzoTfSuqitXdU7yDzsljFVrX4vt6lDrtlfWXPN1sjr
 tjON3rwZjsNu7y+dLBYEPHBtwOUNC7eaTOJVanCIbc/TndB5eo1ch8n8D8GcHyg16LcLrVU4V
 P7XY7cfT4k5ZGYlAA4zvp/aw==

=E2=80=A6
> Consider the following execution scenario:
>
>   chcr_ktls_cpl_act_open_rpl()   //641
>     u_ctx =3D adap->uld[CXGB4_ULD_KTLS].handle;   //686
>     if (u_ctx) {  //687
>     complete(&tx_info->completion);  //704
>
> The variable u_ctx is checked by an if statement at Line 687, which mean=
s
> it can be NULL. Then, complete() is called at Line 704, which will wake
> up wait_for_completion_xxx().
=E2=80=A6

To which software revision would you like to refer here?

How does the presented information fit to a statement like the following?
https://elixir.bootlin.com/linux/v6.12-rc6/source/drivers/net/ethernet/che=
lsio/inline_crypto/ch_ktls/chcr_ktls.c#L442

	if (u_ctx && u_ctx->detach)
		goto out;


Would you eventually like to trace the control flow back any further
for the data structure member =E2=80=9Chandle=E2=80=9D?

Regards,
Markus

