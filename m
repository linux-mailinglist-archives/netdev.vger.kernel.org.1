Return-Path: <netdev+bounces-262168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK5lHR0Xo2mJ9gQAu9opvQ
	(envelope-from <netdev+bounces-262168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:26:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE42D1C44AB
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4033B3068080
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9642DE6F8;
	Sat, 28 Feb 2026 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3QBjszg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E82DAFAA
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295962; cv=pass; b=f2DUTwZpZF/kPOX7Mx9RJ1ID49APYyvNCMKU/igzcYQO9MtbZZQR6c4z5uhbdh0DzAMk7JerJkYa1VOM4dZe/6tcteOpoBruillLYyDWVGlLL/FzPjKHsms5CkIvsw8flshDHquAbXvm/4q/ev9UH7ZIaVP71ACYppq0pL2Pcws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295962; c=relaxed/simple;
	bh=3XrjgNuTrHF6U00ITamnuodTV2zJ1C5fZJxOau0+GPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brMsqCKn7WeXR8Vbtzy/soq6IUc4tjnmi1HSSupHhk8cYKvHgVePpKn8BEmiyERsNiO+EhGHILsSrEaueFlotdvh8mjeYu0MtS17wlOww5qK0AX9Czo26Sl5TCK2WWE+W2Whp2YQFG+M6aKnqbkEq9pH9ixSlQeYvDbcUGz5L0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3QBjszg; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5033387c80aso53500871cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 08:26:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772295960; cv=none;
        d=google.com; s=arc-20240605;
        b=a8e27k7J5S6Qjm3CCV82OrMi9FH8krCFG3eLMlJJzGEDCN0Pt/owQBIaSwkfe5cyDS
         1cp8Myh4XExaGuaKpj/FJSOdoniIEBxZtuxiUo11zy/Z9Y2ZljZVLwP8c8onyDM7fQZm
         z90ip5j64eVKUPIYze2ej6zjt0/Xbb4hJRM9ZpM88CKlPA9mVUx8LyNjpLp5EJ4P5StB
         Oho03uxmAL7YfAayDk2JdGvESpuqXYu9hoE+7uGZxC2vdPo0CeqKQ7hZZQYgAL6Nj0ag
         eOZ86hRSkU6WaBtiBApBtW4soCTRyWmo/K2QKp5zQrRqEHoqlN4Gz8n89oFuqwW+8TDT
         mg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIGP7bFTU5cYRYgY0ojII5Pu5ZHxKOGv0xvGWDPUex0=;
        fh=x1bpevH/N3/Iw0sHj9GhW3wEkjYbtTSHLkOdCsRaKNg=;
        b=BCfHcEtOx4ZGtVeh6l8RJEh/REGmCYMflUWG2LMshjjX95Wlr5MRZJvTAMuapoWp1X
         tdrkKpeOTT7LfIJ8R6T9U3ditqk5XB5D9Rn4Klo1e1PIT4GXPCGVZmOl+TID0cUq6GOv
         y8HPd5LWCG9dmc1eq9Ra7CThv9hoIPHVrFrjFj45vzp6O4fR0PtffswtbtOVE6U7YrVc
         x7uJOzFplGDysgXOFPAqCYfRwgAmjD8MdF8mk/JPy8XIdZ0rRwdx/+DNWv+LfNcz+6D9
         enFg0El9yMzOmSKZah4uqv3PScG7zFaxqZJLyZDMO8cCTSdOAqGlhmPHMWsvBnWTSL7g
         LakQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772295960; x=1772900760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIGP7bFTU5cYRYgY0ojII5Pu5ZHxKOGv0xvGWDPUex0=;
        b=z3QBjszgV36TyZzlBsCOuJi9ZxYSLO965T6YyngxdpG+LLyyZiLpmHpFQaLx0TSK6x
         EbrXnIdI50/Hdc1o+kWYA5sFiKuO8ZMAtZTxaBCSByYHjnjk+RScM2ftCjZutYrA8dWl
         SB+Nnx9rw4OVqtVzvviMa/Rn9EZbqT5QDwIvBe9J9bAiqrgEWzErXTAmMC38nYFaKoSs
         Qp8RiLpUVLXCvaHZk2quVbLUSpnZBtXQP3hAvC3Cn0UGxiyEAj6+78AsOHHPUKEn98Vq
         CbzIGZvs6mEIbhziBF8GfQT5ytZmlcKoAVY7pFx4uW3yE3xXhTRL7kImoB419u6yd/PC
         KDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772295960; x=1772900760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIGP7bFTU5cYRYgY0ojII5Pu5ZHxKOGv0xvGWDPUex0=;
        b=XfFlA4+nt2aDRVkDTNXx+cCU208YYPuNB0UNyGJWu6qYoC6eyV02xtzFy9nYwCOlyq
         oxQztMJhqiNzhHxAf6uhSr5ZOXwRsUeDJomZ8IAtfR9vjRsn9SgAtdNiNwmTA2qkVHHZ
         rhQpWOxFExEo+bkDlCL5GtbMQRPv/tM1zGNJ4D8Ri2GeTAjBNdiQp9JqZiTQfyLTav8c
         JLpkIMm7WrOK5qFm2TAr+MKPmQQTbB1GhybHaosoCjHcHR30Xw+WHBE2GonBiRE5zue+
         6856oDjTgIE5B9Zu250ScQFPzqKEXyUZSR5kMuCka24a2cj0wGhE3ecJ6dfqrQwPyfyf
         aLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5/0EQ70Ebb/kgVag9mynaltIuUFjYHg4DyS/xkZQwuZ0p+DArqfSgDgXCsl9b609qgMauF1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFivVv/lG2hyuuw+JGwhCrdTMOef3LdK8U6jwRcLjRDjkAz9Ce
	MPQekG9qohVy2B7LQHlkx33RKPH6jidLQFZQqvINWJiZZ5ui16qUXQfROw2RPJ5zSQp88b7n99N
	KkOJIDfo032xJPDIsdqwT1jObGEqCFbImGkyG+6Yj
X-Gm-Gg: ATEYQzxiPCZUEShy9WVffV20MGS1COo2oEHdGDmK57eJueJZ5b64xjJTnhZ/j9W6hXa
	Cht1RVGHrsV7u9I5JeEjgYBb8IAyl09RcLZH+12yQew0Ir5WkdL2Zkjxz85Xee0JBHWTqtC/IZZ
	vPq/HQTGqhgEhG9sAixYvk1GOahwvNF8an+8Iaztq/2hTEVYxD+9dXv9LcFAnf1cmdBGupR4RFZ
	ZmlT0AQlkn/cyLV0SDBPo09hWkzWiXeVrHe94VYj6QIanipM7bWUT5XplSx4QSACbyP9VOeuRYS
	7BXjUtW1
X-Received: by 2002:a05:622a:346:b0:4ff:b32b:cdf9 with SMTP id
 d75a77b69052e-5075231eb25mr82013831cf.14.1772295959826; Sat, 28 Feb 2026
 08:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-2-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 17:25:48 +0100
X-Gm-Features: AaiRm51txgt0zxgSWV-jgRLe9QTZwuQnrRDR48kZ-96wNRqE9PlPPTeL2lLWRv4
Message-ID: <CANn89iJxZEtieqZPdioBb5boX4=UKJEt-zPVEZsa2mGCKx964g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 01/15] selftest: net: Add basic functionality
 tests for ipmr.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262168-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CE42D1C44AB
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> The new test exercise paths, where RTNL is needed, to
> catch lockdep splat:
>
>   setsockopt
>     MRT_INIT / MRT_DONE
>     MRT_ADD_VIF / MRT_DEL_VIF
>     MRT_ADD_MFC / MRT_DEL_MFC / MRT_ADD_MFC_PROXY / MRT_DEL_MFC_PROXY
>     MRT_TABLE
>     MRT_FLUSH
>
>   rtnetlink
>     RTM_NEWROUTE
>     RTM_DELROUTE
>
>   NETDEV_UNREGISTER
>
> I will extend this to cover IPv6 setsockopt() later.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

