Return-Path: <netdev+bounces-285969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d+mxORtJ/mllowAAu9opvQ
	(envelope-from <netdev+bounces-285969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:35:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAA64FB84B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99162302C6DA
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A021B3ECBEE;
	Fri,  8 May 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfcIzSak"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BE3D3D12
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272536; cv=pass; b=nJjUrSrb3VnkgXe5HPycQ7pTCLWX/fPtjKRh1ucezgu3/OlJTF65JB0R5SJVCKHMbce2uNoXQcqe2tpYjW7gOCSlWUfof/X+hvDd6c0K2l8EjjkSVItZ/Tvb+x+6nYfYaPBsHq/nVi0PI0FcWE7MlgKv+EesdywEJQsCga2NJl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272536; c=relaxed/simple;
	bh=tGkZvwR3HBJnT2gUAjQAFsWKSQlCDycL90ho1SbjpNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDociDwk79dCxenESvv4XXqx/jt5eXX+qs+ep2yiUNlj0BkYkV96rWp/CJg+UtJYQ0YV7rB8J7/m7hgC58gYF7XGDgP9ad6scS8sPC37q7UDQ/lzXi7oVq5Ps203TMOnVyjfuDwFY538ZpX21NwVKphkBf7c8dIwTIfOep/uG2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfcIzSak; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-834f1075805so1688684b3a.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 13:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778272534; cv=none;
        d=google.com; s=arc-20240605;
        b=R4VP601sNvwV06ChF+bTTEUcTlCLdFofKupiMsANKCDDyMOwRsED/8RaAHtu5rJvPU
         hbI0UovxyqEK2BL7qsxFTw4iefCmTXTwrIqqEKvP7VSCmr/bK2vpu/w5IWIbSfDBuD5G
         c9IqR5b12WrkDle/YV7fL06WyZa8oSYZ5BmL2KXmNKPiGBzWzNU4bSn3Rgb6yRE+3Pns
         87EFVZ/BoTlArLFSo4pBD7hljm8sm1TusN+ycvKi/dtilotXrcBmdkG20zy/gsgDaIiq
         mln6SpBXgNyyRNyOhlTUd4y4hN2GNC5V1INGOqijifUbpK+K26Ek8JWbPWjPbW3CmivX
         lqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+c/Q06nALG4Vh2ue1fjeqFlO+UJffdvyG7yKiqYuccs=;
        fh=JnUQZmqA4+nNtZcj0aUkFYb83rfRk4z88e5TURdPzvc=;
        b=gtw2BbMmB8PqWngJm/tpsZFXEq86IL53CMCXNmYbIYxYme6lBnS3/f+c3ESbhfEwnS
         7ltV/KnHAEYvehz8PhMyo1Xzi8vNqtw41zHiSK8rBgSdt8D7VPjbQi31UgFjvXx1xAP7
         qyRaD0IoQfoLZIm7KjYV9ya5C0mXfDlYZqi35MCNMSYLsZFA9OQhf0RPpw/EoZ3SraJu
         G0vxNYN1xoxS9EYms/9rpJ1qg8eXfgHdGDOWTrcKmXkxV0plc8CHHkD4Nj9Wke5JFav6
         8v1tP6ZgAQmIaRSaJ9Ffa9tXLOmn0W+e6wv74DaQRWo2BT8av4Xe43iQVCAKdF8wJKhB
         TE1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778272534; x=1778877334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c/Q06nALG4Vh2ue1fjeqFlO+UJffdvyG7yKiqYuccs=;
        b=dfcIzSakxh9uQBHhVv1tj//DWz6nTK22aaUQAxyEckytckZ/SHFzUrMFvixsX3IwtZ
         EslM2G4S8cDvB5LFrhUhCdALObKjr/xIYRds4igKxR6mKeGTIWi7jvxQ62aax1KBkZPN
         DcF8VxdUCJRlPyjuBi+Seum4+dEnVMGSpZHgnrZ7P1ix8UU8UtoTn3SzHKTApvhmF+fe
         MT5giEPBUM3hW/69N2QU8wGQVtFfV2XxocXmcsWnLCyTrt7QCKQgSRuUaYg7w8Et+ea3
         bdcjyn0hUZkbtUHF1Hi/LQWoUI5pgfC1pLWHpwP/mvVZZv7wXDYApvq4c8KHIJwkQNNM
         UmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272534; x=1778877334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+c/Q06nALG4Vh2ue1fjeqFlO+UJffdvyG7yKiqYuccs=;
        b=Yb8rMmmFBlwDiTrPGS0PTFdfIUhHeg2XNRVyNLUnYIyySeGDpexiZzIwPczqLrsRAm
         +xvLkXlNBes8L3G++X6AZtITWAq1/cq8UlUAZS7nUt2cpfKQYnoP/9qh9qz54aOANekp
         HItRkQ6OpAtNdsVOz9ow3Qgp+l3aRYsQmVXSvV56dg1nQsIcoe/6lpTnfMsPrfo+pyTl
         ibyZgbdIicb6ZY3VheSWr24duCypGQPatZBuAJfSjqF1/SaJ6wcR+qMM/AaUjM/9zrZY
         FGWmdj25mJkPvzQ4APLWOEhYo4D2pYG8LLzRqSQ8IbnwdNNKaG3uduzGApax8W8/AWB+
         lKMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SoTi41NAd/jfZvJnQjUUap8x16qtwdw7C0DMTLlY/D2m9/YImYTObGr5KJMqkb4k7N5KASUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KnKzCmhlf7mOQmH0P9XFr/0DsDyE/sLHkXDzFqlBVghiors0
	JIhsqYdQE96ywXj93abcTlN4Rk+6FTgIzMerrADXz9eXqWu61qsNYSl/E27j5wIiZGP8cZoYFrS
	LHa+0Sl5AttYC95tlSBVt4VNZRHIE2a8=
X-Gm-Gg: Acq92OFv80/WWIXC3W27eZWmYulNh0UdO+DZmyR4VgGAD4viu91et8QW30/u4/Siiuw
	JpPZF37XGpZPi1MWZJi4DYZuB063Qg4fe7AjKSIMESkDXX01+ergHiOyOw7XGUEhWyvHKgH3vtF
	HvmQUTNYVPixe326/7Co0l0bzvUYWwdoaKsQhDZYM6NmlfFi3j+jenZLHIAqY3zbvLxlIAgoy5m
	CjGe7rcqf/q4N9PKU8dX1kpONkDNseURXO/oB+0Bqk67TVVxkbHQi2i3KB0d5eQY5hA1tFoHOWv
	cLNagPGS4kPeXJ1p8+jievG0S/KiWxxv5iwwArIM/iczYCcan7DgrCKzP9iR67iMMSp3m4MetAQ
	WhoYS7bF6YEIhPG1FaPUo81iKmkagOpJLvuYAlrgQLgiuXAeKhc4=
X-Received: by 2002:a05:6a00:2347:b0:837:7e7d:3c8 with SMTP id
 d2e1a72fcca58-83a5df4b883mr14060988b3a.39.1778272534439; Fri, 08 May 2026
 13:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508001455.3137-1-joycathacker@gmail.com>
In-Reply-To: <20260508001455.3137-1-joycathacker@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 8 May 2026 16:35:21 -0400
X-Gm-Features: AVHnY4LqanISktwmN-weO_GvoUqdGbL_ndw_WJ60yora6lW3wrSNlyT6YeLV0Ts
Message-ID: <CADvbK_fOduqbZSx7xefbDhDi+=eLmgN8k=Bm+J0tRDrFj6ZYmQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: revalidate list cursor after
 sctp_sendmsg_to_asoc() in SCTP_SENDALL
To: joycathacker@gmail.com
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, 
	Ben Morris <bmorris@anthropic.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3DAA64FB84B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285969-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,anthropic.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,anthropic.com:email]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 8:15=E2=80=AFPM <joycathacker@gmail.com> wrote:
>
> From: Ben Morris <bmorris@anthropic.com>
>
> The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
> list_for_each_entry_safe(), which caches the next entry in @tmp before
> the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
> drop the socket lock inside sctp_wait_for_sndbuf().
>
> While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF the
> association cached in @tmp, migrating it to a new endpoint via
> sctp_sock_migrate() (list_del_init() + list_add_tail() to
> newep->asocs), and optionally close the new socket which frees the
> association via kfree_rcu().  The cached @tmp can also be freed by a
> network ABORT for that association, processed in softirq while the
> lock is dropped.
>
> sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lock
> via the "sk !=3D asoc->base.sk" and "asoc->base.dead" checks, but nothing
> revalidates @tmp.  After a successful return, the iterator advances to
> the stale @tmp, yielding either a use-after-free (if the peeled socket
> was closed) or a list-walk onto the new endpoint's list head (type
> confusion of &newep->asocs as a struct sctp_association *).
>
> Both are reachable from CapEff=3D0; the type-confusion path gives
> controlled indirect call via the outqueue.sched->init_sid pointer.
>
> Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
> returns.  @asoc is known to still be on ep->asocs at that point: the
> only callers that list_del an association from ep->asocs are
> sctp_association_free() (which sets asoc->base.dead) and
> sctp_assoc_migrate() (which changes asoc->base.sk), and
> sctp_wait_for_sndbuf() checks both under the lock before any
> successful return; a tripped check propagates as err < 0 and the loop
> bails before the re-derive.
>
> The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
> loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
> the @tmp cached by list_for_each_entry_safe() still covers the
> lock-held free that ba59fb027307 ("sctp: walk the list of asoc
> safely") was added for.
>
> Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL process=
 in sendmsg")
> Cc: stable@vger.kernel.org
> Assisted-by: claude:mythos
> Signed-off-by: Ben Morris <bmorris@anthropic.com>

Acked-by: Xin Long <lucien.xin@gmail.com>

