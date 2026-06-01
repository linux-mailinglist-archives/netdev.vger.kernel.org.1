Return-Path: <netdev+bounces-293853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BRFNtjEHWq9dgkAu9opvQ
	(envelope-from <netdev+bounces-293853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E1623640
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AB4F301A518
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C023DD87C;
	Mon,  1 Jun 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGw6H8/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F429CE1
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335828; cv=pass; b=lFBni7Mu3QTe0Z02UXejO1DCaHKYRQD1wlFwZJnS1txcDxortsb1WW9GHQ2wIaWla/Ufh4g08KgVVMw+tfr+NNw3C1QxpjFDEk93gtMBCCO05ke9PCJPO2jJ2cLdcSzJJst1uK/wbL8KRZ7LqJddWuY6DkJeKk9zE8AslmJGEYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335828; c=relaxed/simple;
	bh=vLXM8xPE0000Ywk3cF/Lyt0JOqPAXIsoJJHRt/F9Z34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q21lNwy9pFOkj279srt+fpnYP+kKszPV/WvrW8KXtlHBFVrQtjdrRzi5c5+MgpLushYPh5w5ZljP5K9cv8cAsSneQ2kwOELI1JJZeG5+HC9KOsn5itrFR4BmmX01ENhVWONHtOMBuUmdDr1S3nmlc26yoX2PTuhuOi0PW84U8sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGw6H8/2; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso3252855a91.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780335826; cv=none;
        d=google.com; s=arc-20240605;
        b=flSrPodsLNWxnYeZIU1f2jGL/UV/0YlvTcP8PlC2AQqgPObfk91HYeZ8TiJoWVPv8x
         iflUrIya7By/aLilU/5ZXekz3ZPI0mIYKVSgfWsgQKcyjgK5nTITm+ntUN6/CxjJ1gl5
         DtvjJUMTMu0euFkM2h3oblOGy62WOvoWdhX+pl+bq8Fom/tEjwyOo2IX6x7NqXCBBe09
         vMIrCy+uoX+s9eL1DSGuew1dUY80TT9W1y1QMZO0PVHo9ZSAxe0XXPARuVnjOtlNHm7v
         EwyM1Xn1pnZbmF9vb9gXsC6FUavJiZ+FtmbDyzVVWNFVFN8L18Ekao1PESJFMKKJrf6Z
         4t4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=if4TjlSwdhnRq7L3EQXAnyNltlbHQkoc1jml1ZVRDpE=;
        fh=vpqt+cRvCgrFBwSRiFwD/JBEMHOYdIjhRkvlyh6lSQU=;
        b=akiLLDK3J+3io+iG9K+xnP+GI7PVBPmADelmNOgNnSz4A5FL6sJCorm5qBGrkI52iv
         ilsRiCpglBqrxIDEKqsYf5IZ0brpol02mUPiQoCpYyRBJF5fRxUwSRmW8cCLu/JFQD/T
         y7azHZEQIZbJ78OMgGXdhRsNkJWiCyI7QofrYiEtDAsTPqq/Lla0o92MZHITmN4ptGYy
         4RjiQn1U79olqqj+OwMW6ZKqlblQiQsV2R7Wadp2qNi7M0LFw/Gt41KRvr2GtVK5L/or
         Uix2WaDN6z/44mJ8u8Qr9X8OYxkAz/lNFnP/NXWzGbMHJPMXyoNjRDScWprpl84AusV6
         x/ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780335826; x=1780940626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=if4TjlSwdhnRq7L3EQXAnyNltlbHQkoc1jml1ZVRDpE=;
        b=gGw6H8/28j/FpPFFE4Er8tLQlYSyM811R6b8ATylwloH4ZcC6WlrihThylKH1yhJC9
         f8Pggjy55j/mKqnRoubYyAvilhBhLVnGqVb40BrnWrFD8H4UftOdN+qPMCOeZMXQLH2o
         9aH0PrbFT+OuJOdLj049aIwNvGbrX1xIB4snM03EvUhmcT4rWY2B0rxKNd+h1h42GT/K
         4qL8862O80OO7Ku7FJ2rVtRpFp1vKBxpGpALtiYCzSHNfbSOk6cw3sHyhmVIsfae8WRl
         xIjwbjJ+NLM7NZE+H8FvGOF4mSpqFH4KKa47a8OmeTyGOuNnsYVvP0hWYpOWWQ4n8Puf
         IXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335826; x=1780940626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=if4TjlSwdhnRq7L3EQXAnyNltlbHQkoc1jml1ZVRDpE=;
        b=kTYOnSD8s5kXAS0pKU6ZMsMKVr7P0lO47macORSkQnDSY/e7FxNMMOFf0CO7X0H1B6
         HaHPPEz1sUx+NpJdok3L9SD/e/nCf5+VRW3L9fh9X4dT9OHOMm7/25y+/V+PfAyYS5bO
         rOJO8vKvK/LS9Ryoo4SJopadESFO4XoirVeh3x5J3bnA00ye2exQNNhKwQGL0mJqgQ3G
         E+pj1adERnpg5xDCqXNHFLM8fSzNu21S/8sZ57aK+ipXva7UP5l9Slxwxvy3fKIsB+BU
         jlp+rFRl8Otx+Beq92hLKDvoolySdfRfPtKLx0VVMh/w8iZJZnCQQ+XKyeaeyEE3dZKE
         25Jw==
X-Forwarded-Encrypted: i=1; AFNElJ+4V0T+r1ODiHXQKcrlqxgPWn9WJHlGDIyk+7qH5ZkKsJ+lehVEA0jo4QwMZHjx7oBYOpubpJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgC7ZskC25h/7hg4jpvXrWWOBOdb9hQ1s3gYAAhfPvZgzqIq8v
	HQv/mRqTRjFuxDXrK7lK9silR5YF2dr9jLLGXnOz8YRHJNlQLeo6ZV6/tF342SrweejFsvjvExG
	gXiSUjfsgFft80OSCT0EXZd2h+Wk12aZitaS6
X-Gm-Gg: Acq92OHwDswiC5RsvOJrADBHz4S1gq9/OXuYWbwvLR8a77/XEGNHYLecxxempY/TZBq
	dcsFXe7oXGlYz1T8SG3CXjRPCWeBDigPvDC9ppOsdgn73cfsiAiNy8FJ8RZCHxDjArWotysRDX7
	1E90R4OUXApTVS087HecgFf2TeCpOjMA0cN5PL2LInvulgbewhYfWBasTY8ndmAjBk37jk/lAcX
	O7w9fERLAmZwhJqvNpUevS1Y+tdu+vqCMofCcwyhFBdajN+nULdRV2ELPDaTcn+J5rC45su/AEc
	E+a+E4PCsMj0W/kyCzJx1GgaGrTsk5YELt6srKhFuMb/pAop2t7UN5c2QUSQ5Qd7Wp8pzrZq85L
	nSydTvmcIJsAA+IXc
X-Received: by 2002:a05:6a20:7f99:b0:3b4:7aae:1ee8 with SMTP id
 adf61e73a8af0-3b47aaea4cdmr234461637.14.1780335826407; Mon, 01 Jun 2026
 10:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780113823.git.zzhan461@ucr.edu> <fac6043fa20a2ff68e12958c431836f692c51268.1780113823.git.zzhan461@ucr.edu>
In-Reply-To: <fac6043fa20a2ff68e12958c431836f692c51268.1780113823.git.zzhan461@ucr.edu>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 1 Jun 2026 13:43:34 -0400
X-Gm-Features: AVHnY4IJGYpBMa78OgmnxNoeJQuYyJzvWtUeHhrXHJwWjrmkFwW8vUX_jMUKQ5M
Message-ID: <CADvbK_cXhGqgEua975KuP+Vu81s7ZjYjE=kTiMrwxcBKLdb0VA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: diag: reject stale associations in dump_one path
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, zzhan461@ucr.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,ucr.edu];
	TAGGED_FROM(0.00)[bounces-293853-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 574E1623640
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 11:57=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhao Zhang <zzhan461@ucr.edu>
>
> The SCTP exact sock_diag lookup can hold a transport reference, block on
> lock_sock(sk), and then resume after sctp_association_free() has marked
> the association dead and freed its bind address list.
>
> When that happens, inet_assoc_attr_size() and
> inet_diag_msg_sctpasoc_fill() can still dereference association state
> that is no longer valid for reporting. In particular,
> inet_diag_msg_sctpasoc_fill() may read an empty bind-address list as a
> real sctp_sockaddr_entry and trigger an out-of-bounds read from
> unrelated association memory.
>
> Reject the association after taking the socket lock if it has been
> reaped or detached from the endpoint, and report the lookup as stale.
> This keeps the exact dump-one path from formatting torn association
> state.
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/diag.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 2afb376299fe..d758f5c3e06e 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -266,15 +266,15 @@ static int sctp_sock_dump_one(struct sctp_endpoint =
*ep, struct sctp_transport *t
>
>         lock_sock(sk);
>
> -       rep =3D nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
> -       if (!rep) {
> -               release_sock(sk);
> -               return -ENOMEM;
> +       if (ep !=3D assoc->ep || assoc->base.dead) {
> +               err =3D -ESTALE;
> +               goto out_unlock;
>         }
>
> -       if (ep !=3D assoc->ep) {
> -               err =3D -EAGAIN;
> -               goto out;
> +       rep =3D nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
> +       if (!rep) {
> +               err =3D -ENOMEM;
> +               goto out_unlock;
>         }
>
>         err =3D inet_sctp_diag_fill(sk, assoc, rep, req, sk_user_ns(NETLI=
NK_CB(skb).sk),
> @@ -289,8 +289,9 @@ static int sctp_sock_dump_one(struct sctp_endpoint *e=
p, struct sctp_transport *t
>         return nlmsg_unicast(sock_net(skb->sk)->diag_nlsk, rep, NETLINK_C=
B(skb).portid);
>
>  out:
> -       release_sock(sk);
>         kfree_skb(rep);
> +out_unlock:
> +       release_sock(sk);
>         return err;
>  }
>
> --
> 2.47.3
>
Thanks for the fix.

Acked-by: Xin Long <lucien.xin@gmail.com>

Note that the issue reported in
https://sashiko.dev/#/patchset/fac6043fa20a2ff68e12958c431836f692c51268.178=
0113823.git.zzhan461%40ucr.edu.

I don't think it exists, as sctp_sock_filter() is called via
sctp_transport_traverse_process() where sctp_transport_get_next() only
returns primary_path's transport, not each transport.

