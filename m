Return-Path: <netdev+bounces-263551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZhO+OheXp2nciQAAu9opvQ
	(envelope-from <netdev+bounces-263551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:21:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6D1F9D2E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93D87300B45B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DB8242D7F;
	Wed,  4 Mar 2026 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+6KA+dn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E945239E7E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772590864; cv=pass; b=nX7z1TmhXcHozf3jCGeWlVQfN2pYHPGeKKhg5X1Tet4tW3ETxzEtrs+NWBqS19Cq070LLNC+9JtDXavGOXRFjI/h4b/pgvRrYctP8LUF805pp3hQ6mKtHiJzAuIDI96FMh6WcW6PNMcbtOBFxPH3QYPnysGpVkH7p/rljMFAbIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772590864; c=relaxed/simple;
	bh=/YhKfILN2nq81SqVgJU1JFYJBOs6NO/CqZeM325g2+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrsZiWvEsuMGr+TW3NwQQADvOfghxJIWOLbl73Vq+uFAd384xztGIlSSJWnEU4WDrWnfLCjX7WgH88Al3Wxvf83kP1grsKY7B7/fLA0U5slsvWXSYwc1hW/odmHX2ia5gqSUx8a+Uo4M0b0MFQnzySjlnwuAJ8mK5I9yZTNyqPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+6KA+dn; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79868cde1eeso69798627b3.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 18:21:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772590862; cv=none;
        d=google.com; s=arc-20240605;
        b=K36nbxTc1yWuACc10KwJ+92SJ/hx6pE+4Sby6FHdYi8/xWIr42vxRdd9hz+nSNW5bg
         yqKnN4LBUqw2TOkVmiTfzhKZTkLmll1TeROAzEFvo40yNZ6VGcsDmCEnvmI8tN5hIgXt
         +0WDyzIjBiEGRU8/GdxFrWdZr7vKck1Gssi3sb38jGkhd+vmWh5xXanrXHr0hhWRxHkF
         sl73pbNSMzT0LjlTxcTa3nSJD/yJsv3RRIjHsTPwjOpV0bGj45Sc3t4jj9IjtW0xXASF
         eB25mRV9ypEJyKLp7bQ2xClfQZAxLv3UPB0YRiMWu7BY7UsHDAwg5B6h3qPNb5zbtFZR
         VRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LP5N1prkg8y6p5pz8xyx0msosYHN0MbwN+bilK3qRbM=;
        fh=r59yoiTyWWRujOgM9xonX/FKihf8daD1IIM9hASPkPQ=;
        b=S5I3wy6dzt526ymwB8zxEV1O9rYKce7vY3nCARG1uxgyoSHbPUZj+bchD/bCuZFkCB
         45cQa6A1B9Vk4CSTcg6q13HdAqI0NQzjbqkNNiJbj3fNsQjxj7Yd6FnaVecFfen/JM2W
         T4XCRz0I/docS0nWmNpax+EaYMZNbtJXHhBfSmgH9OULZpJA6FyNFfF+E2hxFJ/NgS/B
         C2bHi0yrFRfdWyqytOUo45hRnQ4VIN5Yx2b4OV8GlfQ2ELjokTv/CkiB3TM15E6QxSDr
         4QrKXjk7D1AHaSwzWC3wyq6wf40BTJn8BlSkunFuKKAmhiQ3lWpOt0q6ismn/5BsKjtI
         X2sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772590862; x=1773195662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP5N1prkg8y6p5pz8xyx0msosYHN0MbwN+bilK3qRbM=;
        b=R+6KA+dnR7N9EyaCl6r/ctDmVtYd2hj422JZVbSiIFSjqC8mm6HbTEQzZX6l1JnLd3
         lZ0KqTYPhGNH5pDEWXpn2/8Esb221HTpCidHBP7JxbGrK4HV3/+FP+4AuChLhVXtvaYd
         gDIf2BeCAtrZL06ko8ZcDA50m3uOhJQdm/mjRl/8NiYq6pNh5izjXxqxCOvTUAIKpVsk
         3RlbWtXKu+dlu8z9L8pzYRDYCA6oXfWGuiCjlVUdySVBU0ZPPA9uZAjrffvqVRAMXDj9
         VXIPq2eXfJu7XUByc3lLoSgsOu1eQJEmd5EpyvP1qODq27PKcm4jWXW81435mdfH/Ah7
         5x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772590862; x=1773195662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LP5N1prkg8y6p5pz8xyx0msosYHN0MbwN+bilK3qRbM=;
        b=YhYGyRGxANS/NnKQL4xfV/AqzxDfcOCN9WA1FI+367m0ILh8dz5M0OfnbIsjqCdnSA
         9BzgN8i5ahAtfKrn7Je95GkQZLayLBCaxY9y1e9op7VHbgv6rhxMAloLnStJX+dK3gw8
         Zos1gLj4Ai1f6JW2AA63l9c07GzEBQqW9r53+ItVpQOOhdIsNjogvBy9fyUzh0mccvon
         ae617rKkr16yMLrUwESXKaYsPRkTje3OyElD8RZfAx8k7BfkcAs7w0nCEjQ1RhriE2R5
         rMwWUg7o7lcOq38sLgM81PZY7wjGnElExRfRxzk3LUqtiXn3ug8Q6rfKicW+XswrKNVc
         eAFw==
X-Forwarded-Encrypted: i=1; AJvYcCX+QI88hdKUr1VH8nI8B2lDNC/S0NlLZwBUf3iuZ8xuZRTMx/X6ZpJbIrGRnNWmGCBIdgC4Jr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUwF7LxU4rGZbkNIL1XME1jxPC30WNot2uryzrBjCgjLSqJB3
	lPITQcthumZr2TYEE1pSX0zzdN0J1ZozT5pSEi8K8sW2Cp4rT9qwgHX1WsG5SacAvWGhgb2Dh2n
	uGlF5UtLtKmhA511VxHukLCvMNHB2uKW4DJgGkGXu
X-Gm-Gg: ATEYQzzKK+s1bNwlhUJ26+NxkkzzMLffqdthGUcqgUxwETJkYky6noh7T6buSD6p28l
	+NfySPJgelJuFNMzCnEwRh338KjJXT14yzQxYhy1/S6BpBsdIHUEnb08gRqNQHbxSFJNZJJX22j
	kxpFNQq7FnTDYI9FcA/V9JS8KUiCvgqBalDW+hof5M3VzJUUGDTg/STYD2cnJDIHCuNHb/CDjlA
	PBKZr+Feq1oohaUefNCUoWQxI4IAw310gY4eCodVL83+uZKFQmEYyOwkeOuxm+InWVNMWp/w74S
	tNzxOLPg
X-Received: by 2002:a05:690c:c50b:b0:798:730e:f01d with SMTP id
 00721157ae682-798c6ce4afbmr4346597b3.43.1772590862078; Tue, 03 Mar 2026
 18:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303235424.3877267-1-kuniyu@google.com>
In-Reply-To: <20260303235424.3877267-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 03:20:50 +0100
X-Gm-Features: AaiRm51kg_qn2w0AeSjg4Y736XWQu_MMjaHnob_KgwOJKp94QmBcAT94v0CUbss
Message-ID: <CANn89iLtO9xdyS3zeXqzfQNa7qnYv_vGQtouqpE_QOeJFRK1SQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: Initialise ehash secrets during
 connect() and listen().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9AA6D1F9D2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263551-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 12:54=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> inet_ehashfn() and inet6_ehashfn() initialise random secrets
> on the first call by net_get_random_once().
>
> While the init part is patched out using static keys, with
> CONFIG_STACKPROTECTOR_STRONG=3Dy, this causes a compiler to
> generate a stack canary due to an automatic variable,
> unsigned long ___flags, in the DO_ONCE() macro being passed
> to __do_once_start().
>
> With FDO, this is visible in __inet_lookup_established() and
> __inet6_lookup_established() too.
>
> Let's initialise the secrets by get_random_sleepable_once()
> in the slow paths: inet_hash() for listen(), and
> inet_hash_connect() and inet6_hash_connect() for connect().
>
> Note that IPv6 listener will initialise both IPv4 & IPv6 secrets
> in inet_hash() for IPv4-mapped IPv6 address.
>
> With the patch, the stack size is reduced by 16 bytes (___flags
>  + a stack canary) and NOPs for the static key go away.
>
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

