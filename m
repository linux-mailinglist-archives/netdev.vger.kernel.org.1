Return-Path: <netdev+bounces-298096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id alDnBaycKmprtgMAu9opvQ
	(envelope-from <netdev+bounces-298096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:31:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D26467159E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:31:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IrhV8ok0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298096-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298096-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27ACB30D3C36
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B63D9DCC;
	Thu, 11 Jun 2026 11:31:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B803E6DEC
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:31:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177485; cv=pass; b=Q5dzYEIGCcbZ4SwUlhoAEIsbTy44OQls5cqbJVjrbO+Gw1YG1PjVXROhTiJhS3GPJiU7yhbemmWo91qMRGiUselxrbmbBhAa4J5GM/EGgXnB3w4TRGwIxwSYPJzdiuFZbPJiOb7jOQosPvvy+jxV+1ug4U8iJegqvAJYlXSws1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177485; c=relaxed/simple;
	bh=rkPyzTcsuTtCf2t2tLha6H3hi23Cy4jWEal7QvWBuvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXVi+uFhKQfFVzrp3ay/JghvvoQ7hc55PMUvnIxZ5rMoXrgDi0KSLMbwxxIIJCnbvdheb3TBW4wTrm4DsW5W9iMSaWFL7pqtAymxJfMXDOTONaBsOFHZ3TFsjHTIwr4eCwDqqTNUgc4mRQ0eAHZU2qG952zBVryYSUXte6XlvV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IrhV8ok0; arc=pass smtp.client-ip=74.125.224.51
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6626cd98209so333485d50.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781177481; cv=none;
        d=google.com; s=arc-20240605;
        b=FGarhCubhUx6awV1zIWXpUP6fELpMuABu9u6jOeIr81ouWl1uuC+xzIFvI19JibsH7
         11jiq1SZAtrVYknpnFZG8gCCHC+W6kXTYqZbHdJgB8c9IAkO8KJFMnxsSEVirJH70siA
         QXXOIZgFN0Qp0U65SjldFHMhmjUUdUeXId7zk7Gck8qzyyvMXS+aT6hg7AjAKWIj52Gd
         aLsBFYmOwWmzrsGkExwqiuTrIZ/vXTCw0SbD81M6oYthdK5KAhCifNE9mfpA6TFo95Ux
         iiEano7cxURr5Mz2AqgICjwJyUncaXBvlavMosH9/0BCxQg2hHdWrpnBi/tvaie8zToV
         UyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rkPyzTcsuTtCf2t2tLha6H3hi23Cy4jWEal7QvWBuvc=;
        fh=tzt+XJCgZgvvHtv6KnbSXVLIEujONp4s+cUXaRggsAQ=;
        b=TCPAcmUDAq4RJKlYO2ATlPwG24pJU/TliQ66WZP5DwxJ2PuuoRZ3w9PMNm13F6KmU8
         tD84iFwt4fGegHNCH+4GMCxxGcieFr9wGbH4dbpMBaUdggL/NGtccsLZXUCHxVSvKkTW
         jl3IQrz3DDSw+xPCTON66WepY8hSKYzukUAaaqSf/Y51gC+cUY9xQgC5JA5uPjijd13u
         FJh/+r0b27eZbiAhGOatIwTQiInrjrBaHHkmwV5BjMHLmbiXVW1qGNagLIbrHYpFWYbm
         DjEordVfGT3JCEJ3uwlSJ7XCfKxpFd08RE76s+7RqhVqnRdwLOPf91Zo/zUwOtGyb9Hr
         T8iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781177481; x=1781782281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkPyzTcsuTtCf2t2tLha6H3hi23Cy4jWEal7QvWBuvc=;
        b=IrhV8ok0IO0xal5YyWlaN+uyFvn4g0G0vtuiQyqReESLHAs+CrhaTXBmpUjMMu0knS
         0M9+tGBb7/PEAJpUgKGDTkn9n0mIc0HGNFo5WXZUTPvv+E0yyfCdItRwY7TRx8zh6T/n
         IF0glyElm3TbMfAiA0C0B4JEsolzL8svMcBIbKcbsU2F2vX6vBxCMHB0ofgUCg9TDq4m
         HKQZ2QT+AXdc+9/uSt7iBQZdXt9R54QDtj1eSeeymUDmKWZJSh2MYouumwj1HOL2r5DE
         pgi9OAijpq9n415cAh3azqjlgJ/akaAAx1vjx19glLuR7zYhE7RvxmeyviQ7XRHRgFqR
         wcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177481; x=1781782281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkPyzTcsuTtCf2t2tLha6H3hi23Cy4jWEal7QvWBuvc=;
        b=Ac1ylMbP8xY6Tz/yu5JXygwuYmlL86/nUK7FnFfndLU2emtIS/ZumZMy01+suoPkpe
         2U3PpExMIjHljoa6YaNaXtsY4mXwOn3jNghDvT5rOrxKfz4KjkaZe9ZArYl/BBm+T8RM
         BvndLxDWq+wQCsB1HZ1WOx4CUVYly7GmcmggXBBb9U8ioHDHDH1zpNTxojkbFgOlai7R
         D4PfJPLDTuWBybtLdHcuWiFPRL6KVpB+nx0qdSbQvUrSZqe8N8XPTs5d6pwMfqU/Z9vS
         sNa1YGjM4m5Maehr4IQA+EuGdOD2vbSG87hEKswhP5ioypa31AJPZ0buQ+e3EuFsDJT3
         9zzw==
X-Gm-Message-State: AOJu0YyModRGT9pUlZ1FIxKBmo+QNJox9h6x8u86pPp61XeiUz5584cH
	Yf0K4WDZY3IkGPTbtKQMen9DzZCOmrXIBVA+u3ysOiH5OUjmk9w3Telgg0deseNGoZassJUUHYC
	KQNXLvc1h/TmfX0EdacBoRdbqO0YzY0MMWFII/XFC
X-Gm-Gg: Acq92OE92DxHeKyR9jxrxWyel2vatr+2C1y/DJCAHZM7M3UXExM3i8Tjw67wcrikaYJ
	kM+JLLMXIIYp3b9LlUeq9gSq2vXv/jAmRn/fZ1g7qnIrSazSJxcBoBYean42KjqC5wy3PZz2MH/
	eZT/bUMaabTDrhW1PEo4bd47F9QGa0GLGabilsWQWut1VoOFUuKgFIuE5p4CxthdxXReZ/dXyK3
	BfsUsAlP34UiUxLH3FgkeULXypkQAprdxk4uicdEdrZH4M26RjxLpMavrvsER+/+HNbk60mZjfE
	elHxwUPY1P9KwzbtrOZevc1fBVXUPvolNiJtnIUxmcmnDc8RAOlpTcAXo0383+hGg8ZYQRWAD+v
	X88fwKkHkKFenOicGJa+Jjsv2thD1
X-Received: by 2002:a05:690e:400d:b0:660:4b21:6ca9 with SMTP id
 956f58d0204a3-662696bef78mr1797434d50.26.1781177480983; Thu, 11 Jun 2026
 04:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781165969.git.sd@queasysnail.net> <1f30e73275c07bf879f547589872d0916025a52e.1781165969.git.sd@queasysnail.net>
In-Reply-To: <1f30e73275c07bf879f547589872d0916025a52e.1781165969.git.sd@queasysnail.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 04:31:08 -0700
X-Gm-Features: AVVi8Cd1uuBY7qU7bTgjxyQo8MaoMPQFFwULSrOFCaHbtgyAmu9gW5waSPUt1q4
Message-ID: <CANn89iLhV+rJqZK7_A84VagVApz_D8GNU=0Y3NRVF7A=PhJy-A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tls: remove tls_toe and the related driver
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298096-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:ayush.sawal@chelsio.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:agordeev@linux.ibm.com,m:andrew+netdev@lunn.ch,m:borntraeger@linux.ibm.com,m:hca@linux.ibm.com,m:pabeni@redhat.com,m:horms@kernel.org,m:svens@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-doc@vger.kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chelsio.com,gmail.com,kernel.org,davemloft.net,linux.ibm.com,lunn.ch,redhat.com,lwn.net,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D26467159E

On Thu, Jun 11, 2026 at 3:21=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> The tls_toe feature and its single user (chelsio chtls) have been
> unmaintained for multiple years. It also hooks into the core of the
> TCP implementation, and bypasses most of the networking stack.
>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

