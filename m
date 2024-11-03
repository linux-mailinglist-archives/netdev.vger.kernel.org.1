Return-Path: <netdev+bounces-141272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBB9BA49A
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 09:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C932818C6
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DBB158D93;
	Sun,  3 Nov 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CgI1LZcR"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5119433AB;
	Sun,  3 Nov 2024 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621403; cv=none; b=pTrXUdD3zsOMqDIRUmxU97H/FXvyY5AMGAV+ecs1HSrcpyMl63g9UVjojpYb3zulQ0/NnLvJVEIfBan7PphdC8N+ioCqIiFCTwnjgggcwYc7TMqNOOKvSMGU2G2BKiylK6M8mbuGnjP1iyjhNYjKFY0KnsWKzg8vGyqREgq0gF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621403; c=relaxed/simple;
	bh=M1GK2JY9oVx4ESMtyQ/YXDJe+0LB9ftRIsPgz0wFA+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/1glvBeCFrhVvQmfEdYpBpbpDQo/xP9zAi1ieoCwEAAWoBESR31eqIwPf9V0dVly7Gt2ke3czal5RaVToYlinbb6ggVQtb1EN03JpWf45EQf4JZiSAYhcN2fBuwXTjpypDEdteaYL+AaC/SK4j/1UD/btgboVdeQ0vcSpbM72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CgI1LZcR; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730621368; x=1731226168; i=markus.elfring@web.de;
	bh=M1GK2JY9oVx4ESMtyQ/YXDJe+0LB9ftRIsPgz0wFA+g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CgI1LZcROhmUVkfJRhxQB67YuqafTXY8nTAw8272jNgt+VqjWlYVoo0I/RVvhphm
	 bAtnqe1ooVlrZYR/w+s64DvYIyW+ZmfMpGDfkoQPp8wfDorjGByTNNYo2qWxbVrRz
	 HoYldpdKLgr3NgfYDOB6RubU7ID1rS3iFJp2nBLWqXoGoesTW64IBjSnW138Clzpt
	 px7e9kr60INuHAlz4hKOPVGMIzhx/Eh1FBUwrdjAnLlAB8mc0vYneJArcF3q4n4xo
	 /dZ5WSjXbwMmiuv9Y2YwPHfAlrm4+DSC5CxZVjQAfxbi7GlwZnE75JCruC1xH2t9C
	 sc4S+QUNGHM5lOYyYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmymz-1tW4ul0pmx-00ghxn; Sun, 03
 Nov 2024 09:09:28 +0100
Message-ID: <a9f875ac-d09d-400a-b3f6-140a5792a76d@web.de>
Date: Sun, 3 Nov 2024 09:09:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4?] ipv6: ip6_fib: fix null-pointer dereference in
 ipv6_route_native_seq_show()
To: Yi Zou <03zouyi09.25@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 21210240012@m.fudan.edu.cn,
 21302010073@m.fudan.edu.cn, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <CAH_kV5G07_ZL9O41OBYR8JrtxJsr56+Zi=65T_FkaQDefLU_DA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAH_kV5G07_ZL9O41OBYR8JrtxJsr56+Zi=65T_FkaQDefLU_DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z3inRgbsQFRfZM16WvDp4h6Y2+3rPmJArCE6C7YTaRzNivTdFcs
 K6b7CQmOXpe2AQ9EyEGuRakQe6bke2moI3/qWdgxA6sGCtnl5fN4nXlo5WByaqaOkXleGc4
 APdO4cK/TentlLOKC95X7OlQNOIv1jFGYTaL/fY+/P87kp1QbQYO5ThVe/yfBQdhNUylWVC
 4IdVDd/zZtUdt81r4vB+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k1QiRippD98=;JZaivw5RoOT26aUGzRN51jO493M
 42m7Xz+zoKsz1m2pi3cRs8CQRcvX6R/onEv+Cr9NoiRCFEPOw6hr98ehTsVzlBTBqpxemd/+2
 AvADl/W/TOTNE7EVBH+Ky0gzV4r5uQddAz8MXw2rcilPSjI/BfQAaBKCORa7JpjNRB8zSAQIH
 GS1uqhix6WoE5wyGfmUdY4vfe446qs4oi8bt4Rd8TzR+HVz3NQA2GJs1r6+qTr4TeBRbL9Zzq
 CuCrga6z6sCD5LgIomnXo/qAVNx8x4AnvWn9xcAB4FC/MzUGW5XQz3LGuPVezMYeL8uaR45cf
 f336zmN8dlq0wo+m1NOI8/khd0N9lT4XBlQLxclQEVhypqHleap60PDzYiTjWT0kHq4ku94D9
 zCDlbiygqUiXPO5XcMJE/JzcjPfuULTGOiu4RBfbJHFqK7iTvdTv+gJv/8ZHu1hVLm/twnISF
 EZu1Y06ALXPvkjeULYiVqTI6oqPMo4TFq/RY18Gpt2ZAL0T/3FX75O6aI5dI+QhtvFIkCRgpM
 ATumfRaG5SQ/T8L9Uy7v1gcI929Gx+RnAjflLgMUV22ibFW+K7V6cPejCY5g39do2F819VeoL
 Bajaj1PFtwAn4iCfQHgU6FI1A/hdzyowhp5RUKsYSs4RYZz0AZgJowGZuYwHa9xxw5SFLxjZM
 GPnWB6GpSEj7ZWxtrPEXg6pxpZfLm5ote43GrSjNQG4a3d4Bv0Q1k0MZpAN3U8Sbniqphumwo
 fIMojiB89tPKcGEE9Fpife0R+76JvL/Yuk+A88I8ELJpjSaLzzAuanTqE+BH/pEbpOSK8+9TK
 sOAAbtyS9zc/+CEIKzMUIPFQ==

> Check if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
> in ipv6_route_native_seq_show() to prevent a null-pointer dereference.
> Assign dev as dev =3D fib6_nh ? fib6_nh->fib_nh_dev : NULL to ensure saf=
e
> handling when nexthop_fib6_nh(rt->nh) returns NULL.
=E2=80=A6
> ---
> net/ipv6/ip6_fib.c | 4 ++--
=E2=80=A6

It would have been more appropriate to add also a patch version descriptio=
n.

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n321

* https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+p=
reviously+submitted+patch%22


Regards,
Markus

