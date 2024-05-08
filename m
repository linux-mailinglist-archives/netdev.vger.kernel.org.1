Return-Path: <netdev+bounces-94542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B068BFCE2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A0D1F236B5
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C37839E4;
	Wed,  8 May 2024 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MlCVQ+rl"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5581ACC;
	Wed,  8 May 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170069; cv=none; b=fBC+SIXIjgcWhigaJKk39i6K7+JJJiofCVAKSVNQM813LdGBjtVZNmtwZijLUT/NVedBMeTKO/ktBSHUapOr0EoX3LFC0w1jh+6hy9NAPOC4GGAU6mxeTbU7uN+7tkrXKAhCRhnAoNAI5kgxQZMOOS3+alpJF8DmoxfJGjB+m8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170069; c=relaxed/simple;
	bh=ktcidu+FHa+WtZ/ugeKJFFvB5nUAHpFhqK+OYz1rTOI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uyD5tu2h0DGP2A5J3s3jkwUq5IuJjlrsp1Le3magzZin4pRvJGtLMgeiF+Qq66YDyRhvp6kuypZfflwDkdj9T8dR7jUwKGvZvLFMEnzl6s2ndwpqN6IkWyh0yFHtoohIB8LcRlvyz5UgqW+MnelAR5CTFTE7C6IR/fpDPOQKvMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MlCVQ+rl; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715170047; x=1715774847; i=markus.elfring@web.de;
	bh=ktcidu+FHa+WtZ/ugeKJFFvB5nUAHpFhqK+OYz1rTOI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MlCVQ+rlY8lr8z1PVLklKJH0zc1LcmooWgSG3eywkoYgEPjGfpCPZOdhMXvZcOor
	 YNzniVuKXdwO7OlI8wHAjYTBt3fET8srJO+Sfr5KEBRzfZFvgZPMRWfad7vSllnfC
	 vfz4NJ6JVCjHQtVrrlEw9kCwsYHyWFHY5OsJ05sLv78CiDO8XGp9/TKgflL3BHWPH
	 t207QCfkMi4fkjjVnJ0JA5CKqrHF4Xdq4axZHHCpSZCL/J5abtFz/JXYq/HdIhorb
	 8btcy+JUCRkmj2jmLwOFLPRF+ooXKlswHHTyfgVYZ9HPQBOns//uv6H664blPnNM0
	 n6Bu6u8biYQrwOncXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6pf-1spEHY1yCF-016g89; Wed, 08
 May 2024 14:07:27 +0200
Message-ID: <f10e8993-3b99-4fde-b7e6-cc459b7b6021@web.de>
Date: Wed, 8 May 2024 14:07:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ziwei Xiao <ziweixiao@google.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jeroen de Borst <jeroendb@google.com>,
 John Fraker <jfraker@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shailend Chand <shailend@google.com>, rushilg@google.com
References: <20240507225945.1408516-2-ziweixiao@google.com>
Subject: Re: [PATCH net-next 1/5] gve: Add adminq mutex lock
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507225945.1408516-2-ziweixiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FOFIB3IXAeSXdWvJtGDw20e63TAhcSPqs2ZAKkOBk0aJPgwCJJx
 62wjyB0bWpmuWgKAdRcSFAcTsBFz+QxTjdheKq6I9PWn4iVCIafKdyUMPgYDtiv5osRNvqL
 0x6KT2x73iXSvLv2lj9XOWcuIwZ5JnguGaVrDZxxzqFjAorNkBKJeOLIOEF4e+t2UiJmyEX
 3OjAC2pZoXBvX0Gpi3I9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZezT6UXmAkM=;6PZqZF92EhoPAFXEZwGOb8JPglj
 yBAvDsZVMfjWy7n7LevkqvPrc7s6pT/uw9BQ1Zm5ghTZBasNkSaJaNSYh62p/Q75zBW2xzFEY
 VMQZrcKo6ASRdBgdk3roQSDTOAbGtHV0ZCFKoyXv3I1sbB4noClijgGf8nXYmukEj5488v/uR
 KfkTiODu+qposlhyd1dHjhqJAwJPQ7Ygjn8rU5SMdscYRoflSH4bqLZ1WlOEYcAlwmYbKePxx
 +rzLXFjbT1pToNyBt0d1UXfyRjdzf0bag+FQuIhQonQx/lFZpdX3nt5eFepJ5sC9H8BYBAYlD
 6Xjx2daR7VpnFTlxZ5GN6EYZt3N8FyQ3unBXGHgUa6UCGXN9jLSTOM3gLLOkJ+I+rTFDFAglk
 qVx/b/+eCj5Yq8Wd3JQdrHW1Q3XRD0+jEZKLLpv92wWU4cYqMLs5agvX88h4i+q9w26YqG1lo
 cS8jmZe1ATsnhB+/DCij/CxBvX0tpUhH1yP3V8YKRH+EiGdJ6Mgj4U1Knl+XjDmf7MZ+3tnNf
 TC4H3YrwL36Vce8yMpGYMeX78Mjx+/qvRjBAFqIHE9EXCNdBqphb0Pgnm8RwbKEtpq1KUxTVb
 Ik2Gco25ZoW8EhSWGQQB+xloDOeiN1HqlRkhBGyii40J1eTW1+Az1jJzkJm9jFjXmCHkbqCa6
 oP61e8iUACXY5quT/W74GjPCI1T2BTClX2/T9wkaOltdDVoTikNmfb++ke0oFFGkXzlHgI+Ff
 Vc9P6lkwWpjl6yq5RhdtAAZ3Cb7O3PUV+o/ehDpR6fbFX8Uyqk55ThqwuvdcoLh1bW68aXUNn
 YFiIXYOsSVICdX2mGFOJvaqL4a7o7VihWzQxdkGWjsh94=

=E2=80=A6
> the rtnl_lock, such as the upcoming flow steering operations. For such
> situations, it can temporarily drop the rtnl_lock, and replace it for
> these operations with a new adminq lock, which can ensure the adminq
> command execution to be thread-safe.

Would you like to use imperative wordings for an improved change descripti=
on?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus

