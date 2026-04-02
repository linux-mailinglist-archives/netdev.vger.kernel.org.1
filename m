Return-Path: <netdev+bounces-274460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPZqOLJGzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:36:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E7387C87
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C34330008AB
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE4390202;
	Thu,  2 Apr 2026 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PbCvu+Qj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C5385507
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126023; cv=pass; b=DP5HgQKxUhrN/bLUTEvpFwjmFnv1fTmZPSESltl233snoDHUnKnz47WAP/Rbv7dV0usJ8vpiWjcvzkqqsEEPzzq6zuc9kAYcLNeM6e2+CdtrWH/Zdx4DaidrvnkjHXhs68pkgmPvxTxGISF8klpoRqIKepD+FW/GBPF4p9k2/uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126023; c=relaxed/simple;
	bh=cYiFJ5IAn1xL22kMNza+mh8wQUvCAjM6dWSnh7ijrbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBOR4N2MiKXZ2ijOykyFIWDYxkS7foWbm3bKzhPut4ItL14Xy96Ul9XOGg6qAMy+CxExrXUrYxCnz2KUCxtKK8igf8l2onqR6sn9gYTYzM/966OTlYBAg6pN+MYDpEilJdjhlROkSnJHdN/ObhhVygeceBHp02tFAlrhWabXnao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=PbCvu+Qj; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a74765703so5687577b3.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 03:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775126021; cv=none;
        d=google.com; s=arc-20240605;
        b=S0K4t7V9CMb0RCI021cHSnJhYm4KZ0tfFqVbkd2VIIFe++RoCqmP2PoTN7ER7SMlbZ
         gEagoaTtblFs5/VxrbDQb2ZqXrVGSAdyDCujJuhcNYShrO5pxLegbUqsFEQJ2vPQ+W8U
         fMe25/V+d0UbVBZVL+ijHPaseD7S51sVxTbwLGD/EEhj+LHr47kBLBctCic+1rMeGVUy
         TyS9jMk8TP2CERTdBL97WXIRt/sxl0DfAKgmtRPzrw1QODezPUZFpUZguFeUDzmoqL17
         e9SGp/XkQtJ3dUlpSJA7gvVixdSbY+PVayHFxXmjdlr48sH9XQBzya6zBkwY648WhfS+
         2uQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k0y7P8ONRxYDgeubmKK1zVK2h7S/DN+NyAtfzcNBNTU=;
        fh=nYVvRJn7C0FHwv+zL8foIgb8fRUFEmEj4NkKRgmpwPk=;
        b=CzrzYFL992HuPq0D8M9CRcJ+av82kHfp4pIJ9CWlxDokCw4uwWLtdkwUYr/6luFtK+
         woOapBcpbFH+Pcf8bS9IE2DbtvXqQtk+DFssyXpuFyf7t8UOAcXNJmYnSXNY3sYtFTCb
         jJxYLboeyfz+zKakAx73TjqwFqi8mrYRCO4SM62Mdeh9pWs5KnEEqk2RVs6ETk/4dekZ
         /YG8AAuEKcyK6pkibw5MPuwJWKOoDWpskpfZKRnIcRbe8bKGkP00tsgz2z99QWtNYTHl
         zZx4TaRP4v/s2yyMJEwWiiFXnuiWOs4Ap+W5zXn16X+WdCCECf7AbHwENf/VvwNvxyR/
         OKSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1775126021; x=1775730821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0y7P8ONRxYDgeubmKK1zVK2h7S/DN+NyAtfzcNBNTU=;
        b=PbCvu+QjhI+OecW4Znixhp/wycHbOQQY3lmRLsJ9/zkHH/m6byA1wC/ybIV5gL+0G+
         Uoku1rPCKB0o3J628iRi7NFTPxI3sau5SK323dVUX0b301Gg+35KQjcWw38qjSUmKYOX
         0w12zUXHeFnS2PTX9a6qv3FfwMkPUWXdtebP3PSATmLGMF5/nbn1VhBrMdF3bMKbIAS1
         i6fYBdbIkFPmJOlVPejwSdqq8J5XggXcxiO85jtFcIo59CfpJzIDQehISFKv/U8d72B2
         O0PAhcPsO6ujOgzaSoI4/lBAcmVDtijutxIXev6Wr34j+dY+7G2zQ6XUyxnxRXO/Os2r
         sBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126021; x=1775730821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0y7P8ONRxYDgeubmKK1zVK2h7S/DN+NyAtfzcNBNTU=;
        b=SdzrSiwIvKuUAXD4RQG3IGK0obNVSp3R83yWCUVTxwnuO/H0bQ7f5A9+rYyi2TjJYJ
         Vx4j+I2tRzxXQusu7pQC7PldyLhloeXaaDUbteDiN6BamQatIT+ArfFtv58uL8Gm+w8s
         gRuGyRqf5r0zRy3pVsEg5AjrVkHTdHo+odit0e3JWQ4/3NHas2zMZq18UY3n7/FAL8HP
         DlV7ivBrVxU4UapnTfKgBRX/viBHnLn9S7jjPrR6PEUs6WqgUEfwWkJL6PKp+w93UgjR
         0Ol4xuO2/iPidLisUnMAsaV7JoxuS6Uzlqw+eQyw0R1PQ2CAol+WTVOwl5Ekr49uYRXd
         POpw==
X-Gm-Message-State: AOJu0YxI5GVVu9DuBakIz8vZ3u5ihi2Ek58DYVSFSQbMweZkA3vsxLaV
	FZCt30VhlDOKwr7k40LuJ13MHhdgvOhvS7q5cUqCo+g7I7mqNRiJ16vyEFGmgMMLkEGEXwcIbCr
	je6aZIzjX6HGgZ0D7rkX2RpMj0LW8JtHyNILbQJtq
X-Gm-Gg: AeBDieu1s9t9BA5QuTE4pGatnK4MqhYN1WcJnCbXnWxHkFPYVMWylyu+JBF7oK1iUc4
	AKFFWl7hp0ldEGWQdX1Mcb4xuK2tX5mpyuw9DwuOWyfWF4ZEZd0AiGlB7UMMEU2K78T7HwX8zL3
	zONrLWKg0xxc081a7g3mN5sOZ47av/ICgUdLxeLMoh1+h35YoZlPa5t4kRHnRVznmQ5hRKPcsGs
	xwEnUdOPVv4QYqFqgqYDwxXQ2fqoBiEFZYn6i8L9dj3fLcuJik/5Fs1s2M0FVTO+mbzcaNbhOzc
	BTIq7xvA+ARr+5yjqdM=
X-Received: by 2002:a05:690c:8d10:b0:7a2:3d38:337c with SMTP id
 00721157ae682-7a23d383815mr51212857b3.32.1775126020971; Thu, 02 Apr 2026
 03:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331050217.504278-1-xmei5@asu.edu>
In-Reply-To: <20260331050217.504278-1-xmei5@asu.edu>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 2 Apr 2026 06:33:29 -0400
X-Gm-Features: AQROBzCUgqrFKfAGU9pLsCnmWIwe6-3saoX-hLx0UsUY9hZDjNwwzR7PpnVm4Tk
Message-ID: <CAM0EoM=e_Nr5i7x=Zv0Yw2=p7HyO7teOVEt0LjS53OWAqOCMSg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/3] net/sched: cls_fw: fix NULL pointer
 dereference on shared blocks
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274460-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: C60E7387C87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 1:02=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> The old-method path in fw_classify() calls tcf_block_q() and
> dereferences q->handle.  Shared blocks leave block->q NULL, causing a
> NULL deref when an empty cls_fw filter is attached to a shared block
> and a packet with a nonzero major skb mark is classified.
>
> Reject the configuration in fw_change() when the old method (no
> TCA_OPTIONS) is used on a shared block, since fw_classify()'s
> old-method path needs block->q which is NULL for shared blocks.
>
> The fixed null-ptr-deref calling stack:
>  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
>  RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
>  Call Trace:
>   tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.c:1764 n=
et/sched/cls_api.c:1860)
>   tc_run (net/core/dev.c:4401)
>   __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)
>
> Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q help=
er to get struct Qdisc")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> v2: Correct 3/3 selftest case
> v3: Avoid the bug earlier in fw_change
>
>  net/sched/cls_fw.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
> index be81c108179d..23884ef8b80c 100644
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -247,8 +247,18 @@ static int fw_change(struct net *net, struct sk_buff=
 *in_skb,
>         struct nlattr *tb[TCA_FW_MAX + 1];
>         int err;
>
> -       if (!opt)
> -               return handle ? -EINVAL : 0; /* Succeed if it is old meth=
od. */
> +       if (!opt) {
> +               if (handle)
> +                       return -EINVAL;
> +
> +               if (tcf_block_shared(tp->chain->block)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "Must specify mark when attaching =
fw filter to block");
> +                       return -EINVAL;
> +               }
> +
> +               return 0; /* Succeed if it is old method. */
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_FW_MAX, opt, fw_polic=
y,
>                                           NULL);
> --
> 2.43.0
>

