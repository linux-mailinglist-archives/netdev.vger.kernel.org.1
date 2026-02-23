Return-Path: <netdev+bounces-259982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JyjHtUonGl1AAQAu9opvQ
	(envelope-from <netdev+bounces-259982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:15:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0159D174B05
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3727B300BD83
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193ED34C140;
	Mon, 23 Feb 2026 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRR7Ywqh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2134E74E
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841735; cv=pass; b=EH9iU7tN2Wy1sJUfx1ZFAElHKNWKFqSdL6lsgFrWYPHyqDSvyHrZaqJcaa14XODxh5dkQwoLxLUlxlvS0hzmOiiHGY5sHeKPoKqGMK6DaJmiag88BOe5BVlh416Ni4B4fh4LMpKaUQcUoBjYU3kAlIL8VJUFXQOPkdbOBIE+DWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841735; c=relaxed/simple;
	bh=tT1IX54np3nCCLOVUsarWcI5BkDL7PCUUkw8ObIr6Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVTZo/SuVjsKHvJHe+fOQKS9NNJl8af8PRIxcj8GFPVuxrjnm7QToZjN/G+HR0HcREOR+eGYQ5kLuq+PjwT5/bdhob34atx/h18Ek2/S5ZUg46xJh6ABYiVL7olnqWTxbJTYYnx1p4SQ5kaDbOoZWy9FOmAICcWwPLPz994cHCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRR7Ywqh; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a93ba42dso47019951cf.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 02:15:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771841733; cv=none;
        d=google.com; s=arc-20240605;
        b=VmtlrsWfmRZydgu2ytXXQn5Yjdvy05DHl0DYpW7hiZQlKDNWXAowqpn0ao1ASzP+QS
         rO28xsTV8Yfr3/uH/6ALRSSvy8fdrvefhzRkvKMZOkL24pfFMbRNPSBsSLQrcsMcWTvK
         +9wKE9+Qg9ZchDinsvBzAeyzEBs2ipN2GbRGf3Zj8G8egIdOnLuqaNl/G2IGMwXxx22t
         wx9378Jt6wBXa9MPU8N7dyHsdkoJYkICUWHkEfRwAjTExZo4YuA0oOgNFDvF00HDyhZ5
         RkZ7sHLMfh17uZwWcyN/Tg2A7gfigRsFf07cd75CE8TnS83AOyVIHhOLJ9ZmAx/GaBvM
         Mgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gQ4dbnuhk+OWNK19ldMf5wrPTv2TEfPmr5gq3TdAiog=;
        fh=bWlWrrLRMvWlQZLRSihhb99SM6QBJUHzD+Ucb6eHHjk=;
        b=fMZVW/Hx0lx9POaxJ+r/C5E+BeHaroC/mtTiOZ8yH3rQ/14gFXMVRjfjI/eRUbXSsu
         5M2CA8iLGSGg/icjW0LXsEd5HOgsIGetrjaz0gYTXFtSVMq32WHxTBFPkcHRXqJNt0Eb
         LOQAqT8B7LKqb5c1lmAGrCCTjaB2kK1iEIwyTjyZrmCnY9jueEsh/Vb4teDANrx4+aUD
         8zETqBBwnfDlcnmSg3CE24sYexncfPfVCA7fnWq+/S4HqWMsp+cXAGY7f1dwQAdn1JHS
         qi5bHDtf03SzIAIn0XDE9CaWFEGEytR6D59TjEw2tojYNJBJBN7+kivBq1FVgYt7/DLA
         4Qrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771841733; x=1772446533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQ4dbnuhk+OWNK19ldMf5wrPTv2TEfPmr5gq3TdAiog=;
        b=SRR7YwqhdIsXpwn32/YS06lrqgdG6HJDYetUypHlH9jjORpTNNIF4ZCXR5xxIKCU7K
         KGjD+7ZfzP/znf2ZUeE31oGxgiio1FO5lpda+Digbp1sP99sEDTrwncOyx1k/iRTx0jF
         MZKgAldrWopPU+aKQaep1uKQvu0mS2oADMMQzbcT1cr5LemBVxY1bobSxVEHjzu5H5Gv
         CBUtORNvkrGGvFaVMAmymOKzQ1HiKCjlp40T3bv4az+vxIWs1xpwOR6LE/FOYBz0FN1n
         CMji4LqJ2w5/d1hlJWSuhyMKpBNULVWe3LTVl6DB/gr67GocMKMY//qsnnBBSHtGsodj
         9Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841733; x=1772446533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gQ4dbnuhk+OWNK19ldMf5wrPTv2TEfPmr5gq3TdAiog=;
        b=I/aPwdDYmHv2USZrtz9MNrk+6DQe3TfC3r2fJVhmedm5Wn4TdfpuFgUjL0GVp1g8QV
         TVYCyvp4q5i96VS7hpqlVfuRxNArcufhKBSPsE51YD08d3ricZ2bcu+eizc25hGamXV8
         WjHF7w+tB90K4jxzWqPvcnnWyxjET5tMxzumKNJLbadOgdtcBjw9vIMhuq0Ybt6ghZpy
         XCeSqSQr3WqcTnT5F59+PsVDhjFnqUDtoj0mPaXkVC/6G0LB1HEQZ3EVsrjaPk5Khk/h
         VtCk43ZS4UfsMpMCdCBSU2gd4jJa3cvTvKGjF8CZwFVhai41ODWycbVwSdrdIROv+laI
         GuYw==
X-Forwarded-Encrypted: i=1; AJvYcCVENgLNsZp/ht4gvQf7XMZ6csBr6EjDE7ebJWmpa6rXpogeAnXpVuhhpqT5xVHElJJp8zIWcEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpkhKjwZ12JJXz57CMKw4TMo1zV/6na1BzhCAUY4TKHgAwiPY
	ZtB2rjFg8KeToR8yfRCbiaMdpR906wK1g5APZhYfI1T1FMBjAnWy+Qj8hD2h6PmnDYCChLsnJpB
	nsJSoKwHAQ0Cf2FwBmnxmmNbLeUDATHKMvmlTVtnZ
X-Gm-Gg: AZuq6aKu355x12zLp76AflBk/lZlaxGfuZ+LoXr5q3Iv/r5irl9POz+EQly0b9+M0KR
	+CkK3Ja4ytBGAoFUVoVtljmYaymAF0RiBSUh1qL8I4iDXC0JMfg1R7XkQfLaWfHZjWptQqeNLwp
	MLxleXosyddHYo662EhQJk/hrP8VKn35aPnIBQkcquHlEYl9FNgPccAD38mJIxhAUU9ly96JHnW
	4OJi53foM/OmlqwhiD74g9N/U0jzj8ggKQBbjfgVt/rh+vOabUT5+1h6/R+wfnl0QwMo3Yiaati
	zH4kurs=
X-Received: by 2002:a05:622a:41:b0:506:6caf:3cab with SMTP id
 d75a77b69052e-5070bbde3d7mr123833351cf.26.1771841732087; Mon, 23 Feb 2026
 02:15:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222195016.705157-1-kuniyu@google.com> <20260222195016.705157-2-kuniyu@google.com>
In-Reply-To: <20260222195016.705157-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Feb 2026 11:15:20 +0100
X-Gm-Features: AaiRm50CWftVY__YEx7F2LGtT8m_snuZERVWmYRUSDrNIkFBeAtCYtMiwf20NLI
Message-ID: <CANn89i+vRqFU9RL0cbvczxVcK_x8sMVDvr-wDeszPirmaDHYgg@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/2] ipmr: Fix mr_mfc.unres.unresolved corruption
 in ipmr_cache_resolve().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259982-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0159D174B05
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 8:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> mr_mfc.unres.unresolved is filled by skb_queue_tail() under
> spin_lock_bh(&mfc_unres_lock) in ipmr_cache_unresolved().
>
> ipmr_cache_resolve() is called from ipmr_mfc_add() after
> releasing the spinlock, so nothing protects the queue.
>
> Let's use skb_dequeue() instead.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/ipmr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 131382c388e9..62fe54cf7705 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1002,7 +1002,7 @@ static void ipmr_cache_resolve(struct net *net, str=
uct mr_table *mrt,
>         struct nlmsgerr *e;
>
>         /* Play the pending entries through our router */
> -       while ((skb =3D __skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) =
{
> +       while ((skb =3D skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) {
>                 if (ip_hdr(skb)->version =3D=3D 0) {
>                         struct nlmsghdr *nlh =3D skb_pull(skb,
>                                                         sizeof(struct iph=
dr));
> --
> 2.53.0.371.g1d285c8824-goog

Are you sure this is needed ?

ipmr_mfc_add()
..
    if (found) {
      ipmr_cache_resolve(net, mrt, uc, c);
     ipmr_cache_resolve(net, mrt, uc, c); // This would still be racy
  }

My understanding of this code is that ipmr_mfc_add() removed uc from
&mrt->mfc_unres_queue
under the mfc_unres_lock spinlock protection.

