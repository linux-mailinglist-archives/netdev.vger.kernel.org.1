Return-Path: <netdev+bounces-297629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OwBLIEVFKWqJTQMAu9opvQ
	(envelope-from <netdev+bounces-297629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:06:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102666894A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:06:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RGutkHeZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297629-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297629-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5651F319BE9C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4580E3FF1D6;
	Wed, 10 Jun 2026 10:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64A3FBB6D
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:57:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089058; cv=pass; b=L0vp6JUpx5ENWCdM18HKTGaOlhlhYBYWMUho6uv2CDtMAtUVCIaRwJKWjCQH1S5Yfe6xIYjFEy/ZAuGAQvOAu1xk+RX47Ny+9C8neRfMfrR94nC5FnULAKXjY7G6SxaNXZ1ZDYeqk4KpohUsvjyI8Jmj7nhX47+HRElhGkJDFTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089058; c=relaxed/simple;
	bh=NmrU/ezdQgq2JgqB3pCfJqj0tBIXZud1W7fCR0zqNCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqYwRnnekbVQ1UogtehWm2YZWhjL+s0zO8STylfX0dVGvfIbj1vodTKiYbg3mpfUmB8ZajoSov+NhgzUsH9c/7tYAmeyujzALUrcZXZa0mvEddt1NM0PPdXin6Qxjy+zRqX2QS+2qWHhZEKMd84Un/h7ZZ2qR3+sgcVVXBXW1TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGutkHeZ; arc=pass smtp.client-ip=209.85.160.169
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51765531803so324241cf.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781089054; cv=none;
        d=google.com; s=arc-20240605;
        b=NANbQWqqVXtg7NrGl5FnCbdzIQ1wrFYxx7yCoJqUayKTI42OyOgNeMPnzGTakX9cmv
         Gf12HcoSaEhkI0YtJ+LXD3BbKKCefHrrfTZazQISPafSZQ0FLtiIdRiR8SSEucr3m98t
         D9EAQs1yAFCZrj5QHRKjr6WrEddF4UsiYaweWh8zyCwn5ROFNergMoDRA2yUER7zIkTq
         Hf67dO3CFfErsUCDqfo7yVp8ZZKHAeQxkR5HgaJCHf8hhSlYzcPIcB7o8dbp0Xne+9D/
         +rh3QnO1i7lAcsrPRyxfJl5CWDvy9ErA/12le2+ypbtUHkWCeZTw0d1xuzxuk5EHiMqq
         IbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NmrU/ezdQgq2JgqB3pCfJqj0tBIXZud1W7fCR0zqNCY=;
        fh=t1LcyesLO3dWTirHYbl2EoWHGAjeHOMFachBmkCQkFs=;
        b=EZzvPz7YprMVTOGXpszhyRVvJ1URx7ILM1Su+mvquKGQw6O8rS6XYPKOQTqWflGL/w
         E9v2cvr4PsivqbxRHXVzhSaonz29XPaP2rnYsMfatSKMrxa7qzGbQfZk4Dm5hM9Fv5kH
         qIQfKrbxmpRQ4xl8+va6lpmyNG1YU0z2KeYhShEru50KC5WjRbz2DT8sO8tHWaIpveMy
         fGN091vi5gK13zEr9tHnXau9jB+5Vq/JaGKCokiRxiSrjl80ffRZxUTwDtsauBnsO4Ve
         JgfoCfWC5pN64YipzrnVCu/KRMNH0+Rkan5rOCg3xgmmMz2zWSXnAvPPviHzdodfCP78
         5c+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781089054; x=1781693854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NmrU/ezdQgq2JgqB3pCfJqj0tBIXZud1W7fCR0zqNCY=;
        b=RGutkHeZMULqw7ff5P688e1Tmgrw8b7XBV/BZmdI7FkJgCus69n5u9gJEeFU92Xp6l
         P/4sRxL1b8PuCCsyDzXNwws5Zi6CBKPKZzZ2Hlutli/XBRejhLVad5vqS0dr7tzdDwnk
         3OtUA0FO8tDVJ8gXly1a7KusR21evuDnJfuQlSwHcZmMPstqt0DiISj0VcEkX/CJgZIK
         qPCuO00axWZqE8e0OBfYzpsTLbgA6xmXb+uwbnmZCJhk9EchXO7F7xATpvKAhGyE5P3M
         Xmwlq3U+TPJNSsw8xObJJ1+/ZjzIzB4vbIsphATQXVW+1SvrSVB45bpcAvSFb3AMXNr5
         Fk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089054; x=1781693854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmrU/ezdQgq2JgqB3pCfJqj0tBIXZud1W7fCR0zqNCY=;
        b=UjR0/tqcUcRo4uQQuQsrXSB0zriXvHejACSltuCbpo9+/Wrq1hGgDbBC+R7RHdSfx4
         3UhOGS3Hpj2vqLzAOiN2CuI13F9dk1bcAzfb82v2LGpapIL/eavrKHzVEdyCXs6dJp2l
         TLt2WMJN9puj5bC+9xoHsJCobi/MBUNuRPkghfsCx1vyVQDg6nyLMxNwhyCNJ7NQ0Fn/
         7q15CLEeHbUERg1lGxLRCDGQ2piFevqH5bMnYZOlKdG4wLiHm8tQ7u6sMkPkBOqNjzRd
         kJhYFl2RTe6xtr81dpGr8OpEUM0hz+YTN+ESqe7BrliH8xzLEeka/MxEdif/P9Hg0KlF
         2Fwg==
X-Forwarded-Encrypted: i=1; AFNElJ+6+CQYgWfY2E+jjDmap7Im2HZXj1yhnNikhNDmX7iAo2TO+sWNwAUIrFx+lXQmUUJFZONCTKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vpAcskpa9WWKrBQmzgZWPqmrLqWC+AmjKqPv6GIGZzVyPwpT
	Nbab5wjHzV4/Uj6TPEVf+EFLL/6dcPZMHbxjCqbaiYVgE5Q96nSFD+tesN9DUD6AOXwRtv4s5c7
	rqww6ZIdyIDe/xG3zscG0Rm8sY5vyAXbiJ2dOvT5Z
X-Gm-Gg: Acq92OGiwZw8FEzpZAdJx/V2wrW5f0BJJShdE6wVhtaI1qLLQqqalSHpHaoJ9B49lkN
	pgE2fI+dj3qs3fxiimg5rcKKPvWC0Z+tWRMWshggZzO+wp+9fBlmDfkz58YeKxagyt1MLZ46Khq
	D/PlAMO2jG/WiDB9tPkOlo+xZFnWEp4aAdvIT3NB3FwiAIEC1Wn7nKmlOfTLc6l0HWMorASSQsV
	LEYrAgtuZx8ce4sE+OD+Bx48Rj9d2Gxda+TAEG9TPuz6jqOAMg8PZA0XqbT16DnlLcU14sbkbfa
	8Z30Pc//ZXdugRsWr2zxggt1E18OJxEEneTKK3AZq17wa3QN/fc+3wj8lFjcYctWSb7wXF3O4vw
	2vkqIFw==
X-Received: by 2002:a05:622a:253:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-5179808dea7mr52207171cf.9.1781089053790; Wed, 10 Jun 2026
 03:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609122646.2297540-1-yuyanghuang@google.com>
 <fdcc6f4b-6f81-4422-bfbc-7376dd5cd19f@6wind.com> <CADXeF1FaYn2sDyM3Kfic5eyP2oQO9uQE_rFbwwRZFrOqyWSJcQ@mail.gmail.com>
 <5224a3f8-16e9-4967-9fce-14e1a0fc5205@6wind.com>
In-Reply-To: <5224a3f8-16e9-4967-9fce-14e1a0fc5205@6wind.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 10 Jun 2026 19:56:57 +0900
X-Gm-Features: AVVi8CeUS1i6dFx02NHhZSMVwz8347OtRL41FD1InF_vnTe8LjPnjf7xXzDznx0
Message-ID: <CADXeF1EtcaMaA0DseoR96R7Ru0Fgu9YTrOX_y887MajN7kw57g@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv4: igmp: remove multicast group from hash
 table on device destruction
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nicolas.dichtel@6wind.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lwn.net:url,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0102666894A

>I probably misunderstood the commit, but you are talking about a
>'use-after-free', which doesn't seem trivial for me.

This patch is a follow up for fixing sashiko's review comment in
previous patch series:

* https://lore.kernel.org/netdev/95adff35-ee56-49d3-8567-382ac17810b3@redhat.com/
* https://sashiko.dev/#/patchset/20260531030705.3754389-1-yuyanghuang%40google.com

This is a long-standing bug, not a recent regression. Given that my
previous patch series fixing the data race in the igmp/mld code path
did not qualify for a 'Fixes' tag, I am unsure if these follow-up
patches warrant one.

In https://lwn.net/Articles/1074171/, Linus mentioned

```
So people: start looking closer at your pull requests, and ask
yourself: "Is this really a regression or serious enough that it
shouldn't just go into the development pile?".
```

My takeaway is if the bug is not a recent regression or series enough
bug, the patches should goes into the net-next instead of net.

Thanks,
Yuyang

