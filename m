Return-Path: <netdev+bounces-285477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J+4EPvu/GkjVgAAu9opvQ
	(envelope-from <netdev+bounces-285477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 21:58:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B00284EE331
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 21:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C35A3033A85
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F9E481FA0;
	Thu,  7 May 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="fowFJ6Ps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DB37C105
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778183910; cv=pass; b=uUbqgltD7gTzYNWcZZYpLoHwYt0a2g766hmchcBPR7JKObFJNb6MRA3jnv6FpzOfUy5+PPz5kPdp2z/feeGgLzPV9WqX2VIrBEdRFtnN1oI39DzTJhO+umDK7Yv9VB5zb+Cgto//01yNABqgAib4sjsFZPtJaRveMCytErTLUoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778183910; c=relaxed/simple;
	bh=1jSX07oYV5nmDbjBLzM5NXog/gi/Cj1GqnNGlLxkTrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2WDKNkwb59uc2UsAQa7oOQqHIh7ibsFRsHSDTnEXjopMbA0+D4IFmouG1kPvsX8qzTKl2yse4iewTXNJX6dNbin/N2kx2ZZDyEYddFLEomtxRdurD/zd1MXcG1447eK27QTmLA1+o+Dx8fdo6xyMMnB8+CrNcurRyyqsUf9RA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=fowFJ6Ps; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8891f0c88so784701e87.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 12:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778183906; cv=none;
        d=google.com; s=arc-20240605;
        b=jRyoyoyy/jaqlDg/Ny9Oe4RvkJwL8AmnbmzQ+nPfXztbkubHyfVynixQYxhwE89WO7
         DZ1oVHj8yVihZJpsfXYHr8E264rZgFH5loUY8D51oH8gpFkN/Wkeg6ufKpN9wNVMGlNN
         mp/o55GWn2NZQtn0Xrcffxb1I1vJQ52I7domQ9LrFtEdnSswZHxFgl2cfHTeDS1LgKOK
         CuVmyDGdwcNdtadARz+GfaP75xZK6NsOBUMF3RKAsHEGufwjHFQti7uXioDcgv/sIklC
         X1nfweBAm+e9kjZr6Eq3ZCMjX+DARpMnQG+u9FCRAy572E3QWmeiFDErJpbhjK2Tn//E
         bb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C85H7yrmXDgU6/+EUppOZ9UDQs+w36vgGUBxNcUwSfA=;
        fh=Fh5HGqQ5RT6IoYFE289tC4uwSimL8pKfxP29c8AhlB4=;
        b=YABQVfIiiyjicFMWpgSR9Rw6JZMTs3i79YGZhFiX8RN5QZza213KMvd7NcVylvW3xU
         UhV81uY35rIwG0U/OKBQcqYelh5u6CwB9oAMqdOmQQC9RXZlg/zNP8Lnbko1tOh+BBKP
         7fQnpB/vjd72gBGCcBYYaWHSbwDv1mSYb0xd/aVUOEYCRHaRVozd3EGCo+AfHEMUqoh4
         emrHKbtkEqxJtIU+K2/yblDhUFM6e6Li5D9d1G4SdcTdMWUO/e18Un7tBlCgCsOKJFUE
         7DtvmNb6Zs8ZqvrjZlgD86y33bmxM9d9YyHfegYcnlX1tICDRTdwOyv0WPOeNWp9f2nc
         Chvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1778183906; x=1778788706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C85H7yrmXDgU6/+EUppOZ9UDQs+w36vgGUBxNcUwSfA=;
        b=fowFJ6PsFp9rOzFF3FwhggMrvlKZTEkumnuDWCcDfjCouzrMa0HwwzeojkFQg9F9nP
         G/goXyTPanvIqY3oyKXtSuJJ59ACfogaRgTd0zexpBiWeKRg3mlt8xkiUam3uk/7XC30
         6EThW9al2qA4dTEZRMecl+ZRgSwRpBJwtVkZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778183906; x=1778788706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C85H7yrmXDgU6/+EUppOZ9UDQs+w36vgGUBxNcUwSfA=;
        b=WRk2IQaZKuh5PZlC4e/w+vvKuOHzkZaaPeY/J0rO5UTubq3lof05WrRWtBkXD6Wd4U
         OosgIlqJ9PtXAIUOYa9YrAL8BLfYrAgMfhyxY1z8nCXpzP0ZI1yyYZ32xT/J29FdNX1+
         9GWvx78I4tsIHWCGUq/nwDqhpuBaO1AsBWjLX3ti9n9VJdMSrxQKVzOSKZab7RCr/LPZ
         s0Fqd5ZF9zfgUqyGMG+gi6Fg7Vi9YG4PgsfA2SN+Lc+9yxL3GgspubTOVwER6fHCqBzJ
         aXnyeKpwCyP9A1Do0v/8Gq55/qPydDLk/AKQ4qd0td+6fwdqaZHsJ77gQndJ9VY9aZkb
         Pa+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9duIKYa/JNv9Gw8aoFf6n9jt0//UK89a5MLVZzn3NT0HB4qDMYc9Qv3RsrCPhcel0m6D31ZwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0qIaKK8qztHA1KkVy1OScGqOn7PLH0I3TdUn87L3wNUBUY21
	8tjCnMILcwdOxZluj0TnoD1W/6VmILwwStorkCPzYz5GEft+H6F/nfyvAad9lN0Ym86fKhgizoH
	/rXRIa2nQjuC93JpQDt+DQfccL+1+Am1j61y8zAEE7g==
X-Gm-Gg: AeBDieuJ4hQiVlsKHBN5Z7CkS+jYCSx5jtB6SP7dyQamAJ5E5+ZRBLePhJB6/c1ym/t
	Zfj7d0uPslZkQ8A1p7LGeRDzSMUzMJb0sxwRZdy6mcPyePZtupSDNpfK3bSxktffn4y1FPYDq94
	lPYMRsUT+QJES/UQpXJ8Nb61uBLqT8WVlkqJ3QSxL9oBqCtcInN3CDnfvc4UB1hXMgDhqgyA8C1
	uLDh07dWP7Jm+ucWryduLNMfBWCPNORiNrLG/gT54eD+qJ9A5NigIFFtXl/2hmLeC9foaacgGoP
	jOwyZBRToNTRyb94lTGOESzoCduzvWkU8i5QEG/Xgp4JkoAWNO2H9snvviC6v1c=
X-Received: by 2002:a05:6512:15a3:b0:5a8:837b:3d80 with SMTP id
 2adb3069b0e04-5a887cde91fmr3430288e87.22.1778183906018; Thu, 07 May 2026
 12:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com>
In-Reply-To: <20260507095330.318892-1-tariqt@nvidia.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 7 May 2026 12:58:15 -0700
X-Gm-Features: AVHnY4JV4VWIWLKVs-gDS5YcsOQgok0n9OUPOC15YHITVJSjQyfs1wXaBTMWrbU
Message-ID: <CADg4-L-K=PYju3pRYxxzH7yDTZY8Qig7ck84K_5PQxKh8SqV1A@mail.gmail.com>
Subject: Re: [PATCH net-next V6 0/3] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Amery Hung <ameryhung@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B00284EE331
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285477-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cpaasch@openai.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[openai.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 2:54=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wro=
te:
>
> Hi,
>
> This is V6 of a series originally submitted by Christoph.

Sorry for having dropped the ball on this!

Thanks for pushing it forward!


Christoph

>
> When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
> copies parts of the payload to the linear part of the skb.
>
> This triggers suboptimal processing in GRO, causing slow throughput.
>
> This patch series addresses this by using eth_get_headlen to compute the
> size of the protocol headers and only copy those bits. This results in a
> significant throughput improvement (detailed results in the specific
> patch).
>
> Regards,
> Tariq
>
> ---
>
> V6:
> - Rebase after Amery's changes.
> - Address Amery's concern about header length after XDP pull.
> - Add a small optimization to memcpy the header length aligned to cache
>   line.
>
> V5: https://lore.kernel.org/all/20250904-cpaasch-pf-927-netmlx5-avoid-cop=
ying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com/
>
>
> Christoph Paasch (2):
>   net/mlx5e: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
>   net/mlx5e: Avoid copying payload to the skb's linear part
>
> Dragos Tatulea (1):
>   net/mlx5e: Align header copy to cache line for Striding RQ non-linear
>
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 31 +++++++++++++------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
>
> base-commit: dacf281771a9aed1a723b196120a0de8637910b9
> --
> 2.44.0
>

