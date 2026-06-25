Return-Path: <netdev+bounces-301975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g6/2ONg4PWqizQgAu9opvQ
	(envelope-from <netdev+bounces-301975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3B6C687F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:19:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=d9h34WFE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301975-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301975-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D15308D403
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF5349CDD;
	Thu, 25 Jun 2026 14:12:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A72EEE65
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:12:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396774; cv=pass; b=K1aegNMaOxI28BifXfC41IrVishQs8oLSZxmKBEOZmSifbrDn1OENZY/DYKPRv7i5/lhzHuXhyvrqZ8l+tndZbOBdhjfVGBrYji9O6/sNtFDbMOcWLPvsxU9379cMFoZjMQ8RznVPLIhJCMKrX/KqflZoLi14TF5mFsW7z9IEug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396774; c=relaxed/simple;
	bh=933iqY0MeoNdLo0BcwFcmwnkY82X/f5hku8SHN4XI7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9t/8btOO6eROHLp3C12b8Fbsutd9DZxkjL/BPAcwEgDQX1a8hiqz0duL4OKfjFmxZjSvyCfMhi/fCJd0BWPPThCCEJSs1r9cSRg7rjz8LCNgt5hrRUWPOtgSB1Vjn1gY67+9McyalXmgazUme6X9n4Em5zhNv2UA/a3VG6V0Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9h34WFE; arc=pass smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84540eb70b2so1443332b3a.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782396773; cv=none;
        d=google.com; s=arc-20260327;
        b=VFe9+qE/rkq9RNBWdCue3d/NIv9l5RpQwPyKbXNzmKvyKw2yFcqcu49PRkSMFzj+yO
         cN05SL+We8mFLa5FGVb61uGv+KCVz1cKT92Ozh0+oZFkSpZAMm2faTGuRmtQKO5N2oVN
         8zjKo70Pw9q3PSyDAUFQYOlMbCFwLRZOjB6O/dkJCoY0LnaSy3mO6jS3Gtnm743ofxjY
         /ePXNcpOCjlT5FQUy1WtZYQdwyaanGmUNH5wNyOERy6PY3cdl+4hcrXzpUPiBwwHzN5v
         G9aXR7XbhePRlHPGCd41/DKYomT9CZQuOuwQY7S8cuPYYLHV8CNGh2s6Ur5BB0eiky98
         wZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=933iqY0MeoNdLo0BcwFcmwnkY82X/f5hku8SHN4XI7s=;
        fh=2EFaHG33VcpiIcRz9NuV05yrxRxJREua/o8wpPi6Jl0=;
        b=P/Rb5Rjmw2gm1qgXOFg9lx9VczNzS7iqmINcV3O5b4Oyi8VEZYf5MuWAyRffHqgrmp
         4CoPsIXrjrn7/rzmSKWwgBHTT0mDdabhCjjEULR5ZvrhdFGzpe98xbnIHziDSER57zxx
         vXLYzp8w+5onQ1+bGwp6D1/t65WzwFhjmWe4u0aryOLWdSpZajMid8YDTYml4fRd7ew+
         Aw44eFtb5jOXa9/R/6Kb35spCM7FxYcYtHQzR5NtcqpJELTSp7tABM9CwMalcBdUHnrj
         T8FGXkA3pwbLGKlpiR6TZ7lSb7W1E/2cPT6mgdOaMR6N58XGZJeS4+EnKCpTz0HELfbF
         V5pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782396773; x=1783001573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=933iqY0MeoNdLo0BcwFcmwnkY82X/f5hku8SHN4XI7s=;
        b=d9h34WFEbNocy62+AJy8DzyAoMYMFtpjHZjPQzpUmNzCCczOflHfk5ItZI2vALEZau
         I5PE6oDbr+qQVpLF4XS8Mg4FARJdfs1r1N6NvDmUcEaIiVIrmopNFMMinNhMPnW9+3+X
         /DQhHkn4CBL9wA8FaLW6FEXrVeV2l5uK7uOCwXTJM4RqNdMKw5tuPvuHlO8+Ran3r2M7
         ug1OYDY26R97f4VVJT9Bk0tnCDQ/T3MEUKHaZzvl8NO9uG/WFmutQIiV5ugpnoE1FVQi
         KbgCzKB2jI/iniiBZNWKgY4w+cIO62YmsjuI3HeMGxponZcbj488Jqm5QtFEmFZXW1zf
         jR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782396773; x=1783001573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=933iqY0MeoNdLo0BcwFcmwnkY82X/f5hku8SHN4XI7s=;
        b=hNCwVpTeyfXJKjkEltyvMIfHKV2mjlRiYd7cy1yjsEvr7G1bdIMFJL38njUMioym2C
         ufyZ0ng5XadpF7uFocrjz32MVHKAsFf2Rmp2pnaX6BNwnWiAx0x23QH9uJtytsNyju/0
         VqDI6GQkvDU4Gxe1wngHnV9aVMn1vTUlqkvltRBMsalZ6PzY8eJuoiQPPWBPhiNeuF23
         zMQvIHHwM6QnGKHJsI5zZir02FF0376kqwFVpN6h9CJs+nexHXXEZKi/pVs7hAi5oqrQ
         o8eScwT3tDha7/1wlMl1GEOYt8nu+OHHntYv4jGJVfW1sHTytZgIYk/lqeb+dG9YDZmO
         2ekA==
X-Forwarded-Encrypted: i=1; AFNElJ8s7EYYiF8Q88RaKvx5flEY7gW08Hlmvmtlk/a2kRS07+hwIekB5BzYJlW0/GP47bbdLvIwiOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4FwcqucRWhFl2TVvLiIiPUKtTtqxo1YOHnAqw4QS2JrIQ+vr
	cp0hoDwLmHji5xcvFysrDfLUrV0nXs3RevCDJhkkEq5BN87LCMh0sY4fYnLdIzkJNU58rYOkhFA
	nEGDyoWbu2ZHtBJ+6ZuqNp4zTrJQdYvs=
X-Gm-Gg: AfdE7clqhDE/BriIz7eI87Xf8CJVTqfcCq1D5AveCsrhomKM5WD68X8uLYN4G+y352N
	COBGB0ufl/wRj2kopCwnJGkjVCGeC3RjXZ3VGWptxfO7XoWmUfhT5UiANsIs5fhxCQiCucH6sqc
	IJXZa3meNZMT41aJBjNxDMOY65gfSHhjAmZ4MHCjqM0ErhV7ScpjB3wuvGmGAxkC4AyjsVNCk+6
	tmyDgb0prjcFl2HJJMv4E+/grBn8nWSrloVuruHxEoNDTIXOMseqkkz/bjTk1KbHM8g5VV99PiT
	Gagec6wbdQkgslljAceaazUih1OwKhKIjIg4GhTzG/g77SD7CqSKmRmdyFKNRLUaZ4ELGQKUHmQ
	Eae1DxOlEyDx9eRLFShdh9iDliwiq8g==
X-Received: by 2002:a05:6a00:6f68:b0:845:b6ff:1fac with SMTP id
 d2e1a72fcca58-845b6ff2223mr2236910b3a.4.1782396772755; Thu, 25 Jun 2026
 07:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624122213.4052-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260624122213.4052-1-alhouseenyousef@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 25 Jun 2026 10:12:41 -0400
X-Gm-Features: AVVi8CdHtH6SROInozA5Lodpp3WJq0v7G2r4ylbN0iKz2xUBvNsEFPjhRllOgKg
Message-ID: <CADvbK_fkiQtAM7A7y3P9p4nA==pJpRt3FVeGT0adcs4UoNnAgA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix SCTP_RESET_STREAMS stream list length limit
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301975-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59D3B6C687F

On Wed, Jun 24, 2026 at 8:22=E2=80=AFAM Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
>
> SCTP_RESET_STREAMS carries a flexible array of u16 stream IDs, but the
> optlen clamps treat USHRT_MAX as a byte count and then multiply
> sizeof(__u16) by the fixed header size.
>
> That caps the copied and validated option buffer at about 64 KiB, which
> rejects valid requests containing more than about half of the u16 stream
> ID range.
>
> Use struct_size_t() for the maximum struct sctp_reset_streams layout
> instead, so the bound matches the flexible array described by
> srs_number_streams.
>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Fixes: 5960cefab9df ("sctp: add a ceiling to optlen in some sockopts")
Acked-by: Xin Long <lucien.xin@gmail.com>

