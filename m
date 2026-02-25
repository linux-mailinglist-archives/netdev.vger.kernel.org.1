Return-Path: <netdev+bounces-261042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMjqHYQ4n2nyZQQAu9opvQ
	(envelope-from <netdev+bounces-261042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:59:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D31C719BEC9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD26830459DE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849A3ECBDC;
	Wed, 25 Feb 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmNrBKbX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD613D3498
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042252; cv=pass; b=ro1yI0FWS5crBgg5tIgrs8I+WB2pFJTK+elhX4lENnHeaossXLJWzdurgEWkUqITH1ltmsocpM8ngmJdbdT9Up6nkU1v1/xI2ibPs3cYL+ZYtXV4/qCUF0dA6CcP+3S7zWeyjhxlqlxMPl84rJc7F87Sjg7ZPYceuVUL+QWDJVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042252; c=relaxed/simple;
	bh=RfpExGJammZbpKVHCDHyUsPNDozKMq43E5upG27Qk/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/XBb/7dkrFhjBmZa2Kv+KzNBdZXCucFPAKpQZV6Hv5VjNXQjSMnRc99lOi5TuhQf8cs1dmNF4i+IllQKrZLxSrcHKX4hSG+5GnnhNQK48mpzP4CO5R+V5q+NeNA6IbWJnEwAm9IBmJMUGMpEJvEyCd11PnJT9ITSy34cvn2XZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FmNrBKbX; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1270f10a774so237c88.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:57:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772042250; cv=none;
        d=google.com; s=arc-20240605;
        b=czhK1zxLX3F0L6T62tHbXYbRe1SQtFN+y7FxjfsU5I3sKD+NATlj2/AACoF39ebL9G
         0isTc7AJ8TtRwj/mPRxlTepcd6GLMJJe5lHPNHMdfTgy43O8oDUBSqca8uf9IDA4m3iS
         NX3bwKXOYAKUZ2cuq6Ti6WhoBkWwxtqtjYGw/sYoKi4EganUaxHEV/dbsOUNJd7Ajm1G
         IhGxd8NIi87Ce5xq8B/4l+Qp23j+vNBt05KPFJ7TZw7mbKOVhgTQQz0zpNdgs0xTPtJ0
         q63ZTJ+2KhxMcJhb5xRknnvMXuJT+A310FNET9uTAbhQ+I1LOGA8SRtUUSwUtENkonxe
         jcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Om7WA+0rDJMCyh+EuthvxH1P/DwUlMRij1gLg5qOqPQ=;
        fh=KjayMOiujZCKYW5IGo+V5yAPVh/DdOoFfeG1I/BKb8E=;
        b=Gk76aljngijuVZu3JQFRENefzCYyEFtXmYChfXG6w+I+FHRFBvZ7nz4XYjAcBmSus4
         SDfvgQscq/pCkvkFC/wpvLGKAzt8QLWxOXEguDnQua7FE/FtMyfAkey61U0SRHu+lvOy
         LgE1GlQshFMRuQUgBy/ShzNo5EkXV/pLqU6uvHexTJtTLOX6mun6vKyZBHLcL6DhYtxd
         Mb5nkBtC4B5TiY83RQ+JIuSS8NmsrFXSoI6oUAoX3vwRS56IyQWoZ47xczZpeTMPjL/q
         VbV1jIA8tkhNi82Bm9PZuS3UCeP4tqtVi8NxYNzrTNVfwI+zsHmm4MtkUScGH01w63nA
         vLRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772042250; x=1772647050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om7WA+0rDJMCyh+EuthvxH1P/DwUlMRij1gLg5qOqPQ=;
        b=FmNrBKbXKgagz9dIZmKtrpC/1ec4UhjpsTh+62ISKnkacPtBlVUzdR8Yg5PRzIp9Mm
         5Rzviq99gQoW/OevItlRp82HLlHb94ci0wBYEGGeA/v3RSU9E6zBGvxUN+AT0Cv3IdjN
         ome3PS9mdqvgLQ8nTKHdkcpZWsxL8y0qTjo4DhA2a6BvTT2nFtaRotZufNQ0yw4FhvwP
         F8efDLl3ec7H+gzGI70ExQ/rC3s43EnBW/wPwGLNxBeUBEHpFOGsTPA6jxd9IrRFK8dj
         s3yXm+lovd8t2D/rk6KPD654FoplSjjEBzJ025bKVgtSMT0bEa1YETBSZF1gmXPUBIBS
         ECaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042250; x=1772647050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Om7WA+0rDJMCyh+EuthvxH1P/DwUlMRij1gLg5qOqPQ=;
        b=U2xsA0qmgOFyo6Q18Xyre78sJZTklUyfjXM6Pdbp93nSZrSINb7wlljhBh+yV5x5fn
         23ELCE7pyb33Whs4uSZo/GxXmB29rMHSOxWDat1IMhyUSoYQfg17A3qjWAYOtDixThgV
         y12ZbEAhadqfmaSCHJ9JG+ouH38DMAXxs7KSiyp9uz/iy2niE9coFoGO4EVWD3d2IIJe
         Npqr2sfOn3/SDAx0TaBJMPf5oZFW+jDTtM+8e/bdxzhxwpUd7ECd9Ea0L1T9mdGHWH08
         yjC6T86e7rNThoAcd9feARoVh99vFITnhv/qECsHS8vWpNKAKfrY4PmBQeG1SV6OFNxP
         NNdg==
X-Gm-Message-State: AOJu0Yyum+JCOMpZMkOnwtzHM/QdzxuP2YPQ/akneJsDthLDS22O7xk9
	xGf8srfG1ZPFObbTUhVOYgc82YlyhX9X8Dz/mlqCvUEX/7KAEaUdUuCCFhQHxZ5Z/oFVyD+L+Rc
	xCzrBDdWnHZlgjGib9a3oSjzeaqWb+KlK+hr8vef4+yqS7yE8pDxUeRax
X-Gm-Gg: ATEYQzxW7kfrJwEeHZvb2GloApHSj3OY3ZMfrzrmUk2Vo+PVh8ezPW/7zBeWBiRufI+
	bnDcCPFM1uVbVpBs5JjnB5jHhjxwEf9bVKA/6J+8kfoQKCow8HOorA+fv7toNvdAicv9QA8sbUl
	x1v48pUX87q9Y0d2wrbGCPY1Y5OpV4Ow6+4NB9aq1C7UQy+4LBNEFowkMHZMYx6mCpRfH9O1HzW
	ympxewNniysltDB5Z0vJO7hIiXJq15fl2P2oeNT93Ht1L0AYQKuTCaQhFf9fSXnFJWV9kGrFw9O
	N6kE+WO16Sx3Fxab1Lxn36gP2HyptlHNg4H6oFFp
X-Received: by 2002:a05:7022:229:b0:119:e56b:c1de with SMTP id
 a92af1059eb24-12781cfd467mr170045c88.9.1772042249674; Wed, 25 Feb 2026
 09:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224061424.11219-1-byungchul@sk.com>
In-Reply-To: <20260224061424.11219-1-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 25 Feb 2026 09:57:17 -0800
X-Gm-Features: AaiRm52vhIdwB8NdZd7JgaIXodcRDphEOHqkxN7idSkBUfk5IzYKeF_O7pMnx5E
Message-ID: <CAHS8izPjfrKFNtvkyODY7HXSsAuQuPhzy3+fMyYTFuWKQJZ0Fg@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next] netmem: remove the pp fields from net_iov
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, harry.yoo@oracle.com, hawk@kernel.org, 
	andrew+netdev@lunn.ch, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, ziy@nvidia.com, willy@infradead.org, 
	toke@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, asml.silence@gmail.com, axboe@kernel.dk, 
	ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org, sdf@fomichev.me, 
	dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com, 
	shivajikant@google.com, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261042-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,skhynix.com,oracle.com,kernel.org,lunn.ch,suse.cz,nvidia.com,infradead.org,redhat.com,davemloft.net,google.com,gmail.com,kernel.dk,fomichev.me,davidwei.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D31C719BEC9
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:14=E2=80=AFPM Byungchul Park <byungchul@sk.com> =
wrote:
>
> Now that the pp fields in net_iov have no users, remove them from
> net_iov and clean up.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
> The original post was:
>
>   https://lore.kernel.org/all/20251121040047.71921-1-byungchul@sk.com/
>
> 1/3 was covered by Pavel's patch:
>
>   commit f0243d2b86b97 ("io_uring/zcrx: convert to use netmem_desc").
>
> 2/3 was taken by Jakub and merged:
>
>   commit df59bb5b9af3f ("netmem, devmem, tcp: access pp fields through
>   @desc in net_iov")
>
> Now that io-uring and net core changes converge in one tree, I'm
> resending the 3/3, which is what Jakub asked:
>
>   https://lore.kernel.org/all/20251124184729.7e365941@kernel.org/
> ---
>  include/net/netmem.h | 38 +-------------------------------------
>  1 file changed, 1 insertion(+), 37 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index a96b3e5e5574..a6d65ced5231 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -93,23 +93,7 @@ enum net_iov_type {
>   *             supported.
>   */
>  struct net_iov {
> -       union {
> -               struct netmem_desc desc;
> -
> -               /* XXX: The following part should be removed once all
> -                * the references to them are converted so as to be
> -                * accessed via netmem_desc e.g. niov->desc.pp instead
> -                * of niov->pp.
> -                */
> -               struct {
> -                       unsigned long _flags;
> -                       unsigned long pp_magic;
> -                       struct page_pool *pp;
> -                       unsigned long _pp_mapping_pad;
> -                       unsigned long dma_addr;
> -                       atomic_long_t pp_ref_count;
> -               };
> -       };
> +       struct netmem_desc desc;
>         struct net_iov_area *owner;
>         enum net_iov_type type;
>  };
> @@ -123,26 +107,6 @@ struct net_iov_area {
>         unsigned long base_virtual;
>  };
>
> -/* net_iov is union'ed with struct netmem_desc mirroring struct page, so
> - * the page_pool can access these fields without worrying whether the
> - * underlying fields are accessed via netmem_desc or directly via
> - * net_iov, until all the references to them are converted so as to be
> - * accessed via netmem_desc e.g. niov->desc.pp instead of niov->pp.
> - *
> - * The non-net stack fields of struct page are private to the mm stack
> - * and must never be mirrored to net_iov.
> - */
> -#define NET_IOV_ASSERT_OFFSET(desc, iov)                    \
> -       static_assert(offsetof(struct netmem_desc, desc) =3D=3D \
> -                     offsetof(struct net_iov, iov))
> -NET_IOV_ASSERT_OFFSET(_flags, _flags);
> -NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> -NET_IOV_ASSERT_OFFSET(pp, pp);
> -NET_IOV_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
> -NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> -NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> -#undef NET_IOV_ASSERT_OFFSET
> -

Probably better to retain an assert that netmem_desc is the first
field in struct net_iov, no?

There technically is no assert that netmem_desc is the first field of
struct page, but it's generally well understood that the memory
descriptor types should be the first field of struct page. It's not
well understand that the netmem_desc type should be the first field in
struct net_iov though.

--
Thanks,
Mina

