Return-Path: <netdev+bounces-182593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBDFA89440
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837C07A67A1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D6275856;
	Tue, 15 Apr 2025 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Bvxww/GV"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800E27511C;
	Tue, 15 Apr 2025 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700177; cv=none; b=Xb7op6o46AVnGWSvKnI+cXMj7I/UmL83B0IoXEV3C2czjeEzSuCzuDEV57C0Vbvjgd1rKAcb+xsWW8a+nb3LDktsdDTVJ1nofF6vjvjqEVbiQb/RxAjGAfGmrjHFBGLgk8n/g3/gGuoMuINq+66vsCHfJ0BhITnmurUlFR/qeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700177; c=relaxed/simple;
	bh=kY17k1KX7khNMb73gd5C1a3E1u6kiXwt9bs8wpFBoxY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FtyZAdPtgZKjctG7w/anO83Fr0FCo1ll4tYDio2xjudf2A7VO54WjBM1/3IiNYVN9LXgSl65yPsLLEQUngodGtKlQNfiHeCj+wrFD9UjEFyAE1eiBQxZ1s4XiEGqqGRuCRUm0jTe2ZVsMni/cOA9f49raCwVS/9w2FOHJLrfGPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Bvxww/GV; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744700153; x=1745304953; i=markus.elfring@web.de;
	bh=kY17k1KX7khNMb73gd5C1a3E1u6kiXwt9bs8wpFBoxY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bvxww/GVUKfibmXtaYV55Yx3dRZQJgbiq/ANLgxXpwJaoZHKRWJYQLg0KaeXVxcM
	 a0gqbcgOecmNfAAuDr3Z6ZAmGpRdq6U7mSSbVfu3KWqtMX/kc5AaiMnW2HWuZXwOg
	 hja4lN0eKoWAEv3iDxB8uz2oK5kVsiU2QXTIjbFBadwGJ3xo0dKOOz6HDvK9KR4U5
	 TpfUGUjwPFJEOlOhed5jYaUcafbUXgsN8+0VDUYPzmDQ4kaKuQJROcvlCAZTMyG33
	 YeG9NS+wRcDTAmI4I7IceQDpBcCsjCk4fsLU0NkF/UEpc0PV9mYD+5jr1jYIGXd2n
	 05L154a0HqibxXW9cg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.24]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHSb-1tZ5Lg065d-00QHar; Tue, 15
 Apr 2025 08:55:53 +0200
Message-ID: <4f1187eb-ba44-46e4-89db-56c305aa9a83@web.de>
Date: Tue, 15 Apr 2025 08:55:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: 990492108@qq.com, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Abdun Nihaal
 <abdun.nihaal@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Bharat Bhushan <bbhushan2@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
References: <tencent_20ED8A5A99ECCFE616B18F17D8056B5AF707@qq.com>
Subject: Re: [Patch] octeontx2-pf: fix potential double free in
 rvu_rep_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_20ED8A5A99ECCFE616B18F17D8056B5AF707@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xk/lPr3vTTyp/KZAxdyo8lBHYBHlHqHxLLMF9WOLqkN9m+pvoEf
 /6ds4Ut+P/9tESOhkSPHQC7JNfyrthfb0NVyiYSys9Me5eGKpmSQf/OMc6DQHMswqlFo7xa
 EQmparSXUrURBz9FmeJD+Nwk1+GuNw5r4Q5wymVJJDBzvh5KHGvmJKdtWgJj+kk3UZNvKY/
 MO9HoZ+WRQSzAu+HtUP8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kKiQUx1c+e4=;GTUxDezLCMlbhahin7+Lx4vuvx7
 K+Mj5PwXl3avDfh/UfvKVpd62DOfJyXDy67gLY0/ttORFezbXqsGuerXnW0sj4IB5AMqojvZF
 WLsRWgM0R3oie8KQAwvbG958l5nIPlhZsUEiY4I52IS3+/cyjKjS4EdbZ+5T8iavW8nWEubQn
 jQ4Saa61H+EF1nDLG9aULcFoCTusWul/9pz63JtgUjXaGVSvyPI2VjRIZwEI1/cFI7DE2cuOz
 ZLnIZE3yblEHUTL6oMag3r0VilKFTjrJgvlQkT0cMTTZQ6a2ps9mhN8JRMgM9hQlRljKYs/wU
 TiXrCQJSuDTGDdb/Si+uye1TMxd05zO0g2A0INNdgBmIhUjSb50jZVSrazYN7cCILY7mNnu4j
 gvmOsh8XEqg4BF9X4PSAVV+emYn78R//zfMGMEOnehFXTPqBOAWbtw99Qg6lI43NuIYWXBF/3
 vHspPPvX19JWtUGvpjs5TXj3NyertEJid0pS3ZXBLyDnhBfSQtep/UyOprmCbgO6zGl/1lZtG
 bT36ox7/bkhutqa6ESboWmTTKn74gPix0vnZDOZjr0j5OW3OpjJb6HMPtohGHxTMNjSynAMV6
 sfDFIrhYIVeSdW/inRrPGtxywmPa92O9y1cuupxxnmudr9UOpirJRGmvipCuZM5Icg3QkZZ8l
 KQ6KvO6W/BdylhnYhQvQCT14FUw3jRSEp+gpC5LCpqpzjIiuEm+p9msOhzRt6galQ/4tGgWp+
 8hqTlrQwWfEnXXeJGRPGjdxHWHTKTY6fbc3UWocEyOZ+Qz49p4uJW/esIi9uw3Tu07/UscgI6
 TLvq8kCIwpDxmO3G6L5waEoQlD0tcFLh171yNlvGI5M+COx8v5+9vpnJYV4AsYRoUSDATGrVA
 UTmH/kXJsgs17x/DbmORjNygTLjqopv8At9x0DqtLhf24MSq+OtvpZDGyWMwkINOADgoLHZqU
 9NMBpJNe+bZw5jBdUUs0AUrXTq+HjgAXXhJK/wHY/W6JankV3LGjpyefrIdqmzyjfQCYVQQbs
 XnhAU3LUXB4jI+vtYV5xO24erVmYUOlQDBKUuOKYe4628NJioK9J7t6Y9ZoswxjY/N7yX8M/a
 +EIfMUISdtwkqh9nzkj/Azh/m8EnjzakufprcOGn20ohN2XIV4t+gwxyrV7PFTG1JbM7kI8KS
 60T29EE8bJtIN3jZk4gFE7LJink7MffQW+x5OQ7P8DztqOfiIRAyZ6Gv8DbqRt0YwgWEptGLj
 zlSWIfXXd7wHzIQUvCiQQ6I7B4rpONPGUtGAKFiZFNwtP2LKv8EgdlXKcrLddkjR+7uHOvrN/
 9ndHtv6gLZ9n3Mhcn3DAfhEkDjLtjjiuupuX1BHcZSVjowYMQIYc6VaEnOb1flwdC8N+C0s39
 jJUlXikFpKbVHya1GbTA35OEsr7B90UrWjrle4K5/JAUx68YUhskRieOVVMJrfwPW24jufaFe
 s+e8FzVmMQQtuYejQ+N8ba6t6lBQdaqxNJ9+jM093AOZGi0fusdyrYZWMrTf3PnQIzWH2qw==

=E2=80=A6
> Signed-off-by: cxxz16 <990492108@qq.com>

I guess that an other personal name would be more desirable according to
the Developer's Certificate of Origin.
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc2#n436

Regards,
Markus

