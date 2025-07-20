Return-Path: <netdev+bounces-208387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0906FB0B40A
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 09:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F363C0205
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122A1D5174;
	Sun, 20 Jul 2025 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="knBJ3QYq"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A550A94F;
	Sun, 20 Jul 2025 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752995162; cv=none; b=TNIz4sfRlMxfVbRlvpEUHd1+PrPumH0hYlMb2AvusDtz1kbIepaH5CR1QdalrP9OLlL2l/fnXLx/bsu/BQMihdU53y1oLHtOkZUKAPux/KnLAEpdThH5OBIO3M4eeBN/ylMUao0Ms5uah9fiF2rwcfyJJCZOam0k5xpY364DThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752995162; c=relaxed/simple;
	bh=xbrxdgEcaa8StLL2+13BzeetTvnTRigL/BwhEUENsjk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=G7xlNu9qcrb1ti/ZKgePqANVLFr1T9twJBXPS9LgFLR8xz1r6JMohcJGsNuXzVyt7G+twCHtXV3rioO+fbTIgUkeUm6CNXj7TzOO8xJ+XAimb0sRRUC4ZfBmCZ5+BYvpzC0bInZnEZ+277GREMyrNRNpbZjz0uUSXWKV60A5344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=knBJ3QYq; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752995134; x=1753599934; i=markus.elfring@web.de;
	bh=N/G1mTB4XE4GHnlRILlgsvMvdK2OMJWJn6zxeu3/G4M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=knBJ3QYq30pLbAIB6STbUflzL8q/SmSSbXACCKW7r844sr/ss1xzAvngzA86B1ry
	 tv77XL1oqYUle4WlQVxDVpXoKXMTJNVVb9AjzoF9reavDx2kQphZK6MH2djrbrgSh
	 wKS3adWzRkmq2XKOe85tWLGuPVIojV9TRTZGaZt6cXIMJwIeObievJQ/782PHNP59
	 90Q4udVil2ikadqNDnBEkFArjqpLK8Gd3OjaGwBYnzPktknGEgg53pQ6WfE8pbUuK
	 MQxg3MK4SZBnXMI8OMlm3QNgLtdUxtSXInDTZ0DQUPPNgTBKtcS/DkXjc6jbZoksn
	 nJI6AOwYDFoe3usEsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.216]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62yi-1ufXsL2ica-00u5wH; Sun, 20
 Jul 2025 09:05:33 +0200
Message-ID: <fd88b13f-c660-4736-8b48-cd1146360c32@web.de>
Date: Sun, 20 Jul 2025 09:05:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yue Haibing <yuehaibing@huawei.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20250719081551.963670-1-yuehaibing@huawei.com>
Subject: Re: [PATCH net-next] ip6_gre: Factor out common ip6gre tunnel match
 into helper
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250719081551.963670-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OFZTCYgrH5/KLkwOPDgUqbwF6dcGRh0RqtrcvubQl4rdZZJFFOI
 Gl9tNoUogQm1ynNI/Wrnpbdzf09BO+n9tvQdTaGY7JDXABfDPS1dsE3RAje5wZuy+KttO2+
 AEJ18z+39gU7aZxdWmIbNo1qwz/nZjjkP5vmgylfwHY53uZMXKfuC5ap9Z0us9TuwThLnzX
 jDQuL2BcB4HY0oUOdXYDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KdXXtVhF1Pg=;gEDXBctP/fVXHXioRWWtq7NzVZI
 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

> Extract common ip6gre tunnel match from ip6gre_tunnel_lookup() into new
> helper function ip6gre_tunnel_match() to reduces code duplication.
=E2=80=A6

                                           reduce?

=E2=80=A6
> +++ b/net/ipv6/ip6_gre.c
> @@ -111,8 +111,32 @@ static u32 HASH_ADDR(const struct in6_addr *addr)
=E2=80=A6
-/* Given src, dst and key, find appropriate for input tunnel. */
+static bool ip6gre_tunnel_match(struct ip6_tnl *t, int dev_type, int link=
,
+				int *cand_score, struct ip6_tnl **ret)
+{
+	int score =3D 0;
+
+	if (t->dev->type !=3D ARPHRD_IP6GRE &&
+	    t->dev->type !=3D dev_type)
+		return false;
=E2=80=A6

May the scope be reduced (behind the input parameter validation)
also for this local variable?

Regards,
Markus

