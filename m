Return-Path: <netdev+bounces-279169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB4gL6Za4Wl9sQAAu9opvQ
	(envelope-from <netdev+bounces-279169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:54:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C64151E0
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22790303D0B5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351BD35DA75;
	Thu, 16 Apr 2026 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6NcH3kk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808434F46D
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376481; cv=pass; b=a4+Dc4BOSizbid2ywwoAR9rU2V8WfuTn1duEHE96DHyXw5xDBujwMCWUCy/pYCW5QYeLdKaoo760houW/OkDTaWpRrWzmZqXFgh8VjNaOeOhI1t4h5Ktllebew5XqOGbiKX9Vb9VxdzrVdJ5K9nvD0VX3P5E4TgwbkzRkXgQftM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376481; c=relaxed/simple;
	bh=17pPcPgXgxDyr4Vx4IWg1VDKFlJ+ntuKpXQMKn/dWSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbhf3LZ7iY/ol3yAUKosggifjMgF4GrDb+wVBQhrMjB0RTlKDGl/ARNXNossAFym1wIno7aiqeZiCiNU4snqVw25nNHzXidm4KvlKcTaZSYn2heiotSGu7BlVCmTzcZmjnGY6h0QyxjG0cbyop/wdsCj0+X/exFC3qqd0Pix1gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6NcH3kk; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so3840a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 14:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776376478; cv=none;
        d=google.com; s=arc-20240605;
        b=fkkLZBAGWRCVExBU+iAi3KsIUQMZlQzq9xqZrdmQkw/kr9L6whrWLNinSm2XriIdLV
         NgiAxVlhaa8JpZ8Q/vahuRVte4u8SUqmhYpJGCxs7mgc7CLTPDgw6n6RQABZPn6FRZc+
         LWceCK4GVYCFoBwPfP3UpcBdw8fJVAI5xbG4rD8hoVCe/OKRNx2n7xCiPnjlT5QJBrFV
         WA8d5YRI3tBdUH8O1XkiiWo2/JwLhmml6ezANueaZs2SyQMVcxCP7NwukkUIslto8tvP
         lMTeucPl2ffwY943uIBfYGXogPOxoN8uR7fvd1RLQziwyyjS5U265vdW8Rl4VRlpnsOX
         3ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QqIoomE1yKiiwg+MicNqQNuWN7E/azhqG3c31W0K1QY=;
        fh=eQHYNchWL79OFs4EYWXQuUeOj0vN/UDLzXzsyW2Pn/0=;
        b=DqXI1zNayUv3bnZqJBh4aeSM9ESmcQgtVtMHfEjUN6ZI+pi0LhbLd1B/BnPd5Ukc1O
         Wz99BeT+dTOAWXQmN34bI7EcpGR+dUHFtTqdXyXyHjBROMhec5ojJcSTZMu52NwPBzV1
         EGsfsyNSCNy4DBhIinbrrpldfSsuRcdkrNOgSzDTkwel43pYdHtkT2Dr5AjTFErFdpOv
         uZU4JMamlTMp9RRVfAfngKXT33KawpcMGUsjycAJ3s6kF5dj2D65wwcy1KnGV3G7Ru1G
         aUL4/q73nYr5rGXO5gQwIssjiqdoFSd27XYqT2n415mbkZzkj9a1Ya0Qm0V6ajDxsyjz
         i4Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776376478; x=1776981278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QqIoomE1yKiiwg+MicNqQNuWN7E/azhqG3c31W0K1QY=;
        b=Q6NcH3kkNeD9s4ILSHGZWJAIdMAjDV/7burOLar6MojIGfUybyQZi6LalRy088GuZp
         khcNqiwdlcKqNKE2mxnDvCVBIb3nCrr9oXzaKho97x8WIUzIlZAA4e9Y6GXKSkH006/i
         EzB9idGhVB59Y+j07a4gRGxWzVLVTx+VWfzXUBovGDf8MNiBYXUD6KRPJk0/EEjdDc3X
         KchTrkZsyaNBRf5/94voWnsNLrqOGib6ttU2Y81sCRR+C5buG+7UpdEwsmLKP1tGF2xd
         mnZP+mkC9N+u2Mcn5qY2hKO8cnbZi51dYuPcq8BeJdu7VjXNotJYfIW2bNTLlnwoOcpT
         LhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776376478; x=1776981278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqIoomE1yKiiwg+MicNqQNuWN7E/azhqG3c31W0K1QY=;
        b=IArPkk//qiq857OiGL1sDK4YcoUWk6MPwxTBLa7ov8LcUzDyErBeuhoI+3T1pXKdvG
         SKrdqQShzdUJLlWWaV3XAj4BfPWZGmn2roh0yhU8P+5Hp5SbWNmzC6B7v9ByT1RQixRt
         /mlPo3h6t6RRphGTBWs96Orj8WatkvZ6RG/3yN0hvRhw5q2AbYKWSjUMGKlLgstnGutO
         803ZkeKWm6qm0anO2QdOxvJdpj9XoC7gOQUYWjC/jp1tXhqPP2bP+qt1OzHFF9u7cD+N
         yHq8Sclh+l8dikUNVHMwAvqr1LXfWdU+qb9pAqon8hQJcQcPIQGcFoVA4iEBUglC4Axx
         XmYA==
X-Forwarded-Encrypted: i=1; AFNElJ8pKqe6Fvq4Tj/paDs84AZSbK3XCCnTRyYxRK6bRRO1DbEd6gMn91SlK/aD02+lLXFn9rTxVYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOD54UabhoAVNMcZOFPVEB6WgiNUvjAuiP2Kxo5IiTdiFEjKa
	o1bgk7y6pTkqolppb0MGnB14T52WAbX4+K+xovYpe9g8WEApGG/GrdbnIMV6Xm6sflM8JLKAbYz
	GaHp9q78EPSQyjeCwiL17fj5gwR+rhbClcYJx+S81
X-Gm-Gg: AeBDieuXq3aYcgmMeRU6My/BbZD0oBHUhydkW04wezUPBp6gInC8KyhsS5gRlaXezAe
	ocBe8xyXZ/vYNgArG067IRHmX/3c16XXhX/TBLpdiqHK0mD3svSf+hWU+SuvoC8R+2/uhuPs8gy
	DVXeURBqHQusi7QtWUIEg40/t12k1uJit8drV48pSTRCiubudWaWE1mswZB58MFfdAr4zarp3Lx
	ZocS8upiJ5r9b419qAwJnXGCs7EBtqPNU3YrTEEdYHAO3SzoHDQH7VwDU5HtT1++gR5MWpHbI4J
	EqoYHo+PQMQiGmlyfMkWH+VNWoxsFqIqohJZ71p9c3nKMjp1ZNGU0gg+MKw=
X-Received: by 2002:a05:6402:461b:10b0:66f:f414:7c21 with SMTP id
 4fb4d7f45d1cf-672c07d1e93mr2732a12.12.1776376477750; Thu, 16 Apr 2026
 14:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
 <20260415-binder-netlink-v3-1-84be9ba63ee2@google.com> <CAGSQo03b4tTQW=bXiRrmjvF8NympD_dcJX=2jwPdMmguXLfifQ@mail.gmail.com>
 <845b36ba-7b3a-41f2-acb2-b284f253e2ca@lunn.ch>
In-Reply-To: <845b36ba-7b3a-41f2-acb2-b284f253e2ca@lunn.ch>
From: Matthew Maurer <mmaurer@google.com>
Date: Thu, 16 Apr 2026 14:54:25 -0700
X-Gm-Features: AQROBzB20J3vX4qdtl7SVpcpXlie5DrozpgNn37YBFnMFgsik0yvBybZBJqMXW8
Message-ID: <CAGSQo03hxp0PSMK0rCvMKnpUCnktwL09ao2NSvmQLHjTsfBWaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rust: netlink: add raw netlink abstraction
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279169-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaurer@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 569C64151E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>
> So i would agree with you, freeing it on error somewhere within
> genlmsg_multicast() would make sense.
>
>         Andrew

If this should be fixed separately, then for the rust part:

Reviewed-by: Matthew Maurer <mmaurer@google.com>

with the caveat that documentation is added to the two `const_new`
functions to indicate that they are expected to panic on error, and
should only be used at const time.

