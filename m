Return-Path: <netdev+bounces-262165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNpeCBkWo2mJ9gQAu9opvQ
	(envelope-from <netdev+bounces-262165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:21:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EC1C4429
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1BDE302D9F7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B842D8762;
	Sat, 28 Feb 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2nBv6Xq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61291990C7
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295701; cv=pass; b=dlaoF/rWI77PYQutFlJHJE3gew1m+pQexz6XDKscK2/MQ/OOBoLaeiewCDki9PJAnNcd59PIqG+G3YuYBzXxO731ug+f6z9HFCuDU5WRAXvlRX4mdQ7mL233D7OaMV/qX0esloMeqGHNyQRjHelfHzMP2g/Yr+ygIID/p73Auqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295701; c=relaxed/simple;
	bh=8vszMC/tNE29AjjjqliRwCBdj8FqS3DQIErLRdkaAKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ6MQkp95QhRuK9VVUel72D5EshKVhB7yDXf2CS/HaCeBk1fVZd+TfjuBIUQe5DVJvFk30a9hh6cBXNT49TVJIJ1OOda0bIHi812ZKnt5U9e8aSFLQOUdnoZoD2LzCOKj1YQRqKoLYtKzskcLlQ/nR4BsI3zlQlWXMxQaSFeyHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2nBv6Xq; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506c02ec1b3so36572281cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 08:21:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772295700; cv=none;
        d=google.com; s=arc-20240605;
        b=QlL13CFZ/REKrDbms9N+atB+V6E+X6oqUh//qXTmuedJg4hQHzuwPRUWZo1hTQUfrv
         YDt6sYvEC0ICfmKWoxqDocI7UuYsbSPCyuVDXGjdqa+kMXjV3+FJix1ZNuZtRziwZL4o
         E/xP0nk8PO1SlXfRLIGrN/y5FlxA7NMkWtNOaDmtI31RE50cFBlrtau7H7HiOmL7vTW0
         oHKjejXJM1bJghbTt49LyxL39JpIrry6webPaEN+Jj3DZPzSxRmdpjiRPlbtxuA11VQw
         85I37Hv/Svj5+SOZLjMsfh189EcOlFDY/W+CxHhBbyI7ywrcAhTj6CIMSuYXMjW5PK/S
         zAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W5mLj+pLtkTzA6GyChvSJed7J1B3Xrd+bqRa2amHCyc=;
        fh=beXE/gRaEMEWLNtwFWPDVGb/PeGfsmJHU59S2gV2ii0=;
        b=U1L7jyUfg6e98I/d4f0OrmK07UfLx9BKYDYt7F5TtCfGLfGABpGDf2MYQ6J/cPgv1r
         Pk0ezHMUYWhNDyaXdw+ma2Xs2SBGQmc51zDY8Yv06KB3gWBtuc5wIOwlHc2ArnmtIbNr
         zKGMaM1FIcSU0TMXff4jkZpevjJtwGRAhXLSlQGVOn2/cm73C7P2qlwiAQBLSW+a0bIY
         CNlOKGrB4THm3I4TIsnWj8ATkYgAXmLShHytTp9jJdRps0FijIGPFC/k1TGKeyIfJ3nT
         iYWYo/7USIGFASGnyFtnpH6dY2Q7BiN2qquJb0rGHnzIHO7RAIVJcuSMZLbXtBfuSO+Y
         Wsrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772295700; x=1772900500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5mLj+pLtkTzA6GyChvSJed7J1B3Xrd+bqRa2amHCyc=;
        b=Q2nBv6XqC/h0HyXYn0JWVFJXPBMnc4ibuN9AqZTq4bGWj/hJcA5CKuC085CFY9whi7
         XvWQWcexPXduS1r2+gyKMdF1GNC6uoPUn5MUiLftuQVYx9wCgPUAIHNC4EE3oS8EcE7z
         +n5TgMkY7f1fHw4nL3F0UVYogq4k5X+TkXnjeJMqWDXmw4vtvH4+8C5QIjKAALT0Uyp1
         Ldun6t8Te8RR5lTJdKnBhpGfQuUUQExMsVg2qr07UAlk3MCL85fbmpgJfc6fc+LWbrfr
         7wEtFV4sNNbVMylkGzH4v3pe/CEDWBNYD5Hr0/XEaw6m0AhNAxPPZM08cq0b7gIRhOVi
         olJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772295700; x=1772900500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W5mLj+pLtkTzA6GyChvSJed7J1B3Xrd+bqRa2amHCyc=;
        b=LHrMjr401lo6EPYbM3GYOQJWEpWqy5h1DVTR1Ga6MpGlpDYblPR5l3DSrzAcGCCgyD
         GhaPGw5eCEEf4gX9qCwlJOLSaa3PWGizlUQO8phDX1zq5y8QcipWg2LTw9Nb8IaAlED4
         M4TGeYE3JM23oS/mNyJr5ElD9PTGnbH3eM49OK0kOJXDf6Le3ZN/juR+UDq2CFyg2Mej
         cEJw3LsTxSOifGXIzr9wdNCNbrsDm7HvXcRg5E1YV4Qif6ZG1C/uGY4AE+ygDpmmMcrQ
         aE/xuSZg9bkvqe65NOUUj2++HcLqhhHzGfX1X4bZk2t5KgklK+WdN2A7bMzBV8K0BOiN
         kFEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwbm0OrkIgW14BgVBPxr0ObABPYkFhrqymAr2TW11vdcBeBdt42giqcWhXGn8GcjicJOmwP5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37CN6ggOlyLrCkIvXe2yUHKJzSBcC/QeOjf90SPcZH8xo9bQ1
	XKcsGlpTHo2PDFxcqHLlDzMZOs/qrIgpYjHQ5ulolEVyCiX+o+5s9LOOiJCzFocrs0aHOOB11h+
	o7mzINapXC/+2c74i4jbYzcVOkf0eV4fUMug51B4V
X-Gm-Gg: ATEYQzxq5isL3vokkG6I2Ez38C5DHk8T6tsZlQYyVItmxHHGzyafNHTH1DNzTwEp5sS
	rV5y3y7Hlwm4N4KPUwMAVh59i2sM7zKLLSNGh9U3s4p3vSCAEtO6yE5j7HP5sRy+ZKxAumC7b4l
	sws1GeHKswZ00x++oAy6I+1iC2HnQGdV+s/rU3kP4XJ9Xu4O/QiDZBlZXU7ey2cvXlpNOfLUacA
	ULynLw5FJ2JNKp2fBX2dFejbC9orH/3s9x/+OL5/YiGyzjwJs/5S9a4OLUPq7m3fbeykTObMsJT
	pxBSC8g9
X-Received: by 2002:ac8:7e95:0:b0:506:9b3a:2198 with SMTP id
 d75a77b69052e-50752306246mr85965251cf.10.1772295699249; Sat, 28 Feb 2026
 08:21:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-14-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-14-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 17:21:27 +0100
X-Gm-Features: AaiRm52bGMmgXHeGpea4W-mTqAzjwPt8ATR-iIdIItVEZmoKGzfZXH2pmx3Dseg
Message-ID: <CANn89iKdx6Sj-OJUPsFDWS1iVOt6wzXLbXeA+PcHBrUQ1CX2Qw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 13/15] ipmr/ip6mr: Convert net->ipv[46].ipmr_seq
 to atomic_t.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262165-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA0EC1C4429
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> We will no longer hold RTNL for ipmr_mfc_add() and ipmr_mfc_delete().
>
> MFC entry can be loosely connected with VIF by its index for
> mrt->vif_table[] (stored in mfc_parent), but the two tables are
> not synchronised.  i.e. Even if VIF 1 is removed, MFC for VIF 1
> is not automatically removed.
>
> The only field that the MFC/VIF interfaces share is
> net->ipv[46].ipmr_seq, which is protected by RTNL.
>
> Adding a new mutex for both just to protect a single field is overkill.
>
> Let's convert the field to atomic_t.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

