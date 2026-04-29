Return-Path: <netdev+bounces-282380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QATXEdz+8WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:51:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE9B494484
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B163003328
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550283F7AA1;
	Wed, 29 Apr 2026 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJ+Wfr47"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CD3F7885
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466949; cv=pass; b=jeomi5+rCoGD52+gPobqv/38DLSOoyXaIYQ7NN8oQ3odXpCfuQ4tM1KhVl6Y+d0QUC3FDChZmDrS547ojxseKu/R02A7NpsQXe+srIOfZPJccSE1yeG+X4O8cHR1oH9JExDrqut94cD0iAyv1TjqC4GfyChVEmeZNALSUrJx5QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466949; c=relaxed/simple;
	bh=BQppO1+d7Svtn0uv4mY2ZFJqwbFOp82PYhjxR3TEXmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBCXtwgn8zX4AlrqMX/JYHnJKPfcTt6AKYhR5le7Gwycffw5SbjYaxO0H0Ukhz/Jtz42eV4Sy6W3mKetNWdZz2a3l7eIwgZHiG6fbEMEpUNxkKeLl7kKT2EYH/h463s2u4CWsONZM5Cm4tV7umTmck/wOwVDvVU4xuAjVDIryL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJ+Wfr47; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d836552daso446411cf.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 05:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777466947; cv=none;
        d=google.com; s=arc-20240605;
        b=K9IT5+sPxBc/Gd/MbVEPttSqG87b+wyUyMslcH5/lxVHsxHy0nJY/rwf11dDwuhIkV
         /RtOYfzkGvxQ2bb9abflA3P+rWO/Eg4XlYNdyGIKaH4BKhp+nHF2wuizikuAgK5u82kZ
         oFKh1hK8VvzBszBhW1sVw9VPT9psJEcNdY4JWVm7msLgOJILF80eGmfKN3Oft9hyAQdr
         r9YrT20VC5ECJ/xxghT7tjw5q7Y0Tq6YagglJuf+9KybpRlyFtWrCWdJEcBmGZmHU1by
         0sxNTq7zMfrn0FsYBd4X/Gj6vuQ1QlcVCwkHX1ZB2pEFg0tB9hNNmT1BylcT9Tjaojm9
         xUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5vSoUH5GY7j/PivX0UBXQ9HtFKPC891zL7tVrdY+bLw=;
        fh=u5BidKb3MJM37hcxymDaFnZbx7kT22bwSAWCEUqvngc=;
        b=CoXikyrAjVRO2YpOi5ZYphNnUrO6NJ7v1BnPOb5qeR8nx9HeVCDQ5sDswT7NJDrq4T
         IiiUETXm5kOc11oOwzt4pLdKAFKH6s673AmGcwNc/71qEmIk8JI+xTfqlkdREoUO0HVt
         BDmpEbMKtlSikZ74dBk6DSM3hcp5VWmSyRPx/C+ezmZKLYw5ytmZHp+mQSXGjNXyhNIW
         9BRmtgjx7B0wPUCIsAhdjBRaLjNQ65sJyWXPJNYZ/wrhxMOq1wmUch4r7f1wySlmkRY5
         pAf/wInASCrruqIZyH6wlNpS9TZC5RRqTYvWYEQQ9BVMa1qqf7vfEC9wa8uH2O7m8yVY
         xoig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777466947; x=1778071747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vSoUH5GY7j/PivX0UBXQ9HtFKPC891zL7tVrdY+bLw=;
        b=uJ+Wfr47c9uYZcjIcvybz/kEoChFN94ejcik5pnvrDWdu8jTizRfMhF2gc8hZ2hY2L
         GSQLZHaDlQknWQUEKlxJ+g7698I1FfyYSKTeIKwqIJZjKqcMZ8d4LY50jJbL25bbzl4i
         2fS4MYlQJIIwjzKAQeBHdv5xqdmP68/lIzHZw5aj+jYe/MlRKakgdDnKChiKpoH0xGIC
         AjPHJZ8Z+HVd023WPIOcApTVXlFU31ghPs7UOshIF510mgN45KZqQ54tm2at2o7SMDm5
         +Psi3nNnA2pmdeAux6ob2FG0FPuYq+ampFLCpEwd75P6V0Ojb3LVwmxRm6JASjAzc2xi
         bgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466947; x=1778071747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vSoUH5GY7j/PivX0UBXQ9HtFKPC891zL7tVrdY+bLw=;
        b=Mh4EMSGAZ9dt3i/yL9MFLzYl5KbhY3gxGHrvE03t2EmqosdF/t5xoQ5Hu2CDp2ZcKa
         MUEhfwVOCTBbTA1XCXKITe6XwBn9YKeq1u7DwkAUxlhum7SwLtAv3YlXpit9kSpTrjZu
         l3Lf2zHWDoI43ZJ62dSVvRris2IisMFnLxbTLHW1mfWfPlW8G9Dzz4+CJEAvGWR57kHS
         46Pl4A4BCPc2/23H+G40pnqdZJEjSvMqWVV0lT6n79IM8uKCNpYiPXy9Pa1sJkD6Rru4
         o+LnyQT1ZLTrOSmgkkiLNYVf7bQaekQN2qqBsI8NpZ4FOshXd9m8dCz6TwscGiIpmkJ/
         xFdg==
X-Forwarded-Encrypted: i=1; AFNElJ+CUHMJsxwXzKMOUFWv4xgcvoYL9n02G72nxfjofHV5t/H/hXWDk3x5eyNeP7vvPFdVDeyS3Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx833YdMh6jLU0ktEI2WvQbvaeV3M0PGwnFOPJvL8MzNH8ZUpKq
	HvzQks9djTftFU6RYw6+SvVm8+bzXaU61w0sA0En9awW3D554VzpJc2yM1AmQO0ei7IlBHuPmAe
	p9GBihSQJOH9CAEAVxwj/5nxce4RIE3eRlCLA4W4e
X-Gm-Gg: AeBDieuGWzbnLuJfcpa25jPgSdrDzE4eg1LBF9I8DeVHNs36jhuWVaiF8My3c9HUiRn
	mEZ+91DbMKqkoTerqwKkH2rkWR3waWvZukWqv6GGlJW5034GDTDUYgjz7q6sjAd4yCBxn22C7bt
	kxBJDgbyNvJNaK544cxgIdTmlXMnELM1YWiDzpUhrKjiHnm6O5nEn/KDqQOWZmzC1r3R4+DlFwj
	A9E6U5un6IHHj4xqtMDyq0xGoVy2dgPldzlmYP8DoSgEGEVwGRgNE9GhLCsGKcCntxZlSmh/6Lc
	qNi+eFGxnUa/2tResZ/wIJ5f9NgxIfajZWmks2lrqQP3W8yGP0LeuvbFnIK62pjUUWXfYp3ePk+
	3YlSw2tTiTavQOfPhxeLkv/40Kmc=
X-Received: by 2002:a05:622a:4a8d:b0:50e:2be1:c2d2 with SMTP id
 d75a77b69052e-510194455fcmr2355261cf.10.1777466946290; Wed, 29 Apr 2026
 05:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429010809.784315-1-edumazet@google.com>
In-Reply-To: <20260429010809.784315-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Apr 2026 08:48:48 -0400
X-Gm-Features: AVHnY4Iv8wmUokZ0YgcujgNH3rxgP8AZreaf9eWp3Ip6Eawc71lFAYecBP1VQuw
Message-ID: <CADVnQyn93Fs=ZPGzdoMj+giNvKBPGQenTHDTz_3DtTjme7HoeQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add tcp_mstamp_refresh_inline()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CCE9B494484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282380-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 9:08=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> We want to inline tcp_mstamp_refresh() in fast path only:
>
> - tcp_rcv_established()
> - tcp_write_xmit()
>
> Add tcp_mstamp_refresh_inline() for this purpose.
>
> Add noinline qualifier on tcp_mstamp_refresh() for the other paths,
> to reduce bloat.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/4 up/down: 26/-123 (-97)
> Function                                     old     new   delta
> tcp_rcv_established                         2238    2264     +26
> tcp_connect                                 4027    4003     -24
> tcp_tsq_write                                152     120     -32
> tcp_send_active_reset                        476     444     -32
> tcp_send_window_probe                        235     200     -35
> Total: Before=3D25316710, After=3D25316613, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

