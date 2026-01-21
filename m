Return-Path: <netdev+bounces-251960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DhZCNcFcWmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:59:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 601AF5A3DB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26E72AEBEF6
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67753D5242;
	Wed, 21 Jan 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tka4GMQc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE5342535
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009745; cv=pass; b=Ht3tgUXYP0vwR0rBvf8SQ9Ej/7NiZeycxzt5Xw1VI04pZ81wufV3+Uztmalws221wnCDAO7KkiWTLOHQrEqndpXbznanighrhC2cU4wSGjzLmoqyaHbQKIvseZQ6ikOMuBonLtLpxgPqX2Nbkh2SBL0EiDvEkrqEpB6ROZmTpwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009745; c=relaxed/simple;
	bh=3VDj/d6m2AaeF+Pitxz7VPmrL5IgnVCvzviY03eAHrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDfq7cWHp48VMNbsF3U3oPGlb2slUwQg1sPmYmOywmaXkDsJ+uDLzgFSj47tyCFqNuCqjQxArs2kqcq4ODoEKvILqdQg/MLEr42jMQSNWmZuQr8jGX3vdrJUkCDGTvrpamwFwMbaW6nhVxqDWKR+BxU1qkiA1eD9TZrgOeU9wWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=tka4GMQc; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81f46b5e2ccso20554b3a.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:35:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769009743; cv=none;
        d=google.com; s=arc-20240605;
        b=YuU4cvQ990lVCGA4STQuCT8sMteo7+V67nYDkAQP1Fyu1HAHiUMAPr2Ae6694dIZmV
         CdfKTj+ayxyRIzCN7ey7qFg0wOjNUbQq2AedRalUrnoe2U06Va/HI8khP2q/6Z05jcXx
         AShtX3iSXwCHM4BA3PF58ZAJMwlsAoJ/FwhP9UZnKnkf+DfpCF426LhiWOxMcM3UoQQj
         QCEwTo6jqgIA7DLpNjBxGt4KaBU5EwFr9tvPsq9GgKfHUPx8ge4oFa5ACuJV1Oosrsns
         Mrwmgr73rEHQGe4sBJOdzZyYB8IHqMRLW8gjMENDmnPYfcbQYlNl9pZs4BrMs6mSgdii
         TIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z+sqKfeptL4izZQgioKocgl/DhdK6xjlmp3b3/G+eN0=;
        fh=BflJfpe5ELarrPboJxIcq+wzqjK2sAFgzydddzJkoaY=;
        b=CVQNEZHE8HQAB7qsDNgCpagA3Jd0I9vwUkK+HUWQM/OpzEZ0NEc2T/CbgSrPxrvMbl
         hYbdrHG3mCEEzUSCjsytLKH4yEkOKLM80yEbhDfQfECEHSgBOwvGcuy5TfspmzD3nwUK
         kCmQ70PcdiNHka6WYgIaCrjA4GNfNoX9qnu0ntpYRNoMVopngybiRhFaLxCUg8yLq9Wm
         PhwXIPKbSxCGVGm55Z6oW6aURDovEtAJbFQC6ZLltRdNx0BsJuXbRxdwt9b4PFxxsVEu
         Qd8WY46Awq2pnFjGRh0RzcRuxyqPsSwkuzZLIZlkR/5Hq7Anv/EyilM8X3B6X9IwYBF9
         oPMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769009743; x=1769614543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+sqKfeptL4izZQgioKocgl/DhdK6xjlmp3b3/G+eN0=;
        b=tka4GMQcmVtmlmfYVlpbbQfbK3tzamBODAfQbgy1pZV21Afxf1C+ALp7aqE9BSU1Lj
         zR+6QNXaxBmyWVfKdzCIZzTIkK0Jux54kGhQxVK4VZBusL+LpZeNIkbAaYK8mVFiM8hY
         U/No2/z2e3SVvONXoQzOdslL4Ykch8tUMAWmT3j61JT9Epm6aDbNeNX4Qp8ltYsP7XH5
         aPfH1xvsLsFbc7Jd0bHdrSQz1zyhbsj/BfRqQ5jiAenRDG+qBuUfeVsr5/yVzq1S9F/I
         0UH2wwyoE5l8+D5VeIP2BtZ1S70Vt4j8tcT0nlEyS5rGf3WM5/HDMt3h3jvgu2mqLuLx
         FWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769009743; x=1769614543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+sqKfeptL4izZQgioKocgl/DhdK6xjlmp3b3/G+eN0=;
        b=P1Wamm0BPEpSHbKHTzhpsQ6O6bl+9PiL7U+xW5oSTWXVXBlfPiJTwQaJ3N5IIL115/
         PkrPfGOsdYJNJmOrGA3bfNxPV1yCOblRXDIcHdRk9QpB3f5zE53D+qzidJz8OAHUhvKy
         xSU1LqF4zuWYcY7weEGVWHhpPeDWPEN4+qaFxQ9FZfZGKsuoG68ERsjfSSQiclbrIeZa
         t0G8o3rCq6GH2U7pOicdnc6sf0n/x0xLMz/g7TyY3hNyySMMzym+QHgtwtLCYOaUaR9O
         tj+g0Vp1XMGp0qpWj4oVZeSmuRuNKumdFVK97+4rT0nRT2vMvBvcrRw7kFKdqYciK9fk
         iBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqRzwePiYDUV1detZiTcQRZejixorAIAz3gy0CrwKtvIS876/9lMsRotkiryxs/1PUXsSnkew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRktozWB9xSBXFZSRAgKkZWSNqjNeemOB/BX9Q5TUXSlScwRSt
	vUQoHhooQiCyCocMyPhTbdpzYsUi/UineJoYd81WBZNOEeElTsbTd0T1O16pkaR8sW9Muvd5xi3
	Fe7gSr4s9QLFjzPXWX6+lgh4CGWu45rwVeFHxqt0K
X-Gm-Gg: AZuq6aKWuIA0AAawcQwsoC7KZa/IOgGvLgGmmyiKgLWXbXoqW8pd9dhvz5Zz4ln7+AK
	Ollpki3AmbuwAeMhEBOtytFg4V5rQSho1g8c31fUc3/rC5tmsSzoiHBLJh+1aa1BnvwovXo+EI2
	jvJF45FGrupajNDoDFDYnhjDoTfmVyX1VkveB9YxQQqFMrUrb5oiR/q2Dhr+nofs1FOmZv9wHbX
	DTzh+BKmlj3xq68DqA8hZ+8fb8YBDo6LtjX+6p9MCVyV4gUABisdg89Sgn96G0yR1vP77/tWAnL
	jsc=
X-Received: by 2002:a05:6a21:b95:b0:2cc:acef:95ee with SMTP id
 adf61e73a8af0-38e45e21823mr4760532637.52.1769009742636; Wed, 21 Jan 2026
 07:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121133724.3400020-1-edumazet@google.com>
In-Reply-To: <20260121133724.3400020-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 21 Jan 2026 10:35:31 -0500
X-Gm-Features: AZwV_Qgx4fTgYv6QiB0o3EPHYhxuvolZc8SfwSK64VirVuohKVBLEiNhsbojxvU
Message-ID: <CAM0EoMm-_afeMUQXeJsnTVcAhaj056m2WVzK85+=6XuVYJXXwg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_ife: avoid possible NULL deref
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+5cf914f193dffde3bd3c@syzkaller.appspotmail.com, 
	Yotam Gigi <yotam.gi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251960-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,resnulli.us,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev,5cf914f193dffde3bd3c];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,appspotmail.com:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 601AF5A3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 8:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcf_ife_encode() must make sure ife_encode() does not return NULL.
>
> syzbot reported:
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000000: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  RIP: 0010:ife_tlv_meta_encode+0x41/0xa0 net/ife/ife.c:166
> CPU: 3 UID: 0 PID: 8990 Comm: syz.0.696 Not tainted syzkaller #0 PREEMPT(=
full)
> Call Trace:
>  <TASK>
>   ife_encode_meta_u32+0x153/0x180 net/sched/act_ife.c:101
>   tcf_ife_encode net/sched/act_ife.c:841 [inline]
>   tcf_ife_act+0x1022/0x1de0 net/sched/act_ife.c:877
>   tc_act include/net/tc_wrapper.h:130 [inline]
>   tcf_action_exec+0x1c0/0xa20 net/sched/act_api.c:1152
>   tcf_exts_exec include/net/pkt_cls.h:349 [inline]
>   mall_classify+0x1a0/0x2a0 net/sched/cls_matchall.c:42
>   tc_classify include/net/tc_wrapper.h:197 [inline]
>   __tcf_classify net/sched/cls_api.c:1764 [inline]
>   tcf_classify+0x7f2/0x1380 net/sched/cls_api.c:1860
>   multiq_classify net/sched/sch_multiq.c:39 [inline]
>   multiq_enqueue+0xe0/0x510 net/sched/sch_multiq.c:66
>   dev_qdisc_enqueue+0x45/0x250 net/core/dev.c:4147
>   __dev_xmit_skb net/core/dev.c:4262 [inline]
>   __dev_queue_xmit+0x2998/0x46c0 net/core/dev.c:4798
>
> Fixes: 295a6e06d21e ("net/sched: act_ife: Change to use ife module")
> Reported-by: syzbot+5cf914f193dffde3bd3c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6970d61d.050a0220.706b.0010.GAE@go=
ogle.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Yotam Gigi <yotam.gi@gmail.com>
> ---
>  net/sched/act_ife.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 1dfdda6c2d4c51feb3f9db4e26e72c8e4a515687..8e8f6af731d51cd38cb469e43=
51a7c861fc6754b 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -821,6 +821,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const =
struct tc_action *a,
>         /* could be stupid policy setup or mtu config
>          * so lets be conservative.. */
>         if ((action =3D=3D TC_ACT_SHOT) || exceed_mtu) {
> +drop:
>                 qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
>                 return TC_ACT_SHOT;
>         }
> @@ -829,6 +830,8 @@ static int tcf_ife_encode(struct sk_buff *skb, const =
struct tc_action *a,
>                 skb_push(skb, skb->dev->hard_header_len);
>
>         ife_meta =3D ife_encode(skb, metalen);
> +       if (!ife_meta)
> +               goto drop;
>
>         spin_lock(&ife->tcf_lock);
>
> @@ -844,8 +847,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const =
struct tc_action *a,
>                 if (err < 0) {
>                         /* too corrupt to keep around if overwritten */
>                         spin_unlock(&ife->tcf_lock);
> -                       qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qsta=
ts));
> -                       return TC_ACT_SHOT;
> +                       goto drop;
>                 }
>                 skboff +=3D err;
>         }

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> 2.52.0.457.g6b5491de43-goog
>

