Return-Path: <netdev+bounces-281206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGBaAOTE7mlfxgAAu9opvQ
	(envelope-from <netdev+bounces-281206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:07:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5383546C089
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165D93009CFD
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6222D63E8;
	Mon, 27 Apr 2026 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm0wrPeF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93A26C3B0
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777255649; cv=pass; b=A4iN32ApSr9iOsbYlX97SPAxJS6jCE1LyjkK1dhqlP0hpyv5mLzglKZokZFMy470K05qG1FaUCKDlKGPyXkkXt2iGqAUPyOulMyTI58GTqJoC0lZqUHP57fx6tcwevCSoto8Xfv1AmArw0VgrPLeWQspxzP7mGVhgoHYMHmhwjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777255649; c=relaxed/simple;
	bh=lOZ8mgwQj60s/PZ30yLs17tPHrIMpiV7JXxWHZRBYm4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R4syQK+aFrPG6l5Bs5yZMSeivE0dcvTlozOdpDX255M4OT1X+wgjU7Q6F4SfwWdvM7AW0cu6PNMh16Rzr0bR6tZw9vaktNAa2bcVLFWQy1bd0zPSMgvKWls509//GETYx9e02s2LJ2koTEENKTK92ESvpl2bhFyselnmDhjtWLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm0wrPeF; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79ee5037d44so128127347b3.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777255647; cv=none;
        d=google.com; s=arc-20240605;
        b=Lj6RaJM3p2/jgfV7Kv2XTyCDJVektZOhxPPKHtW0Ef0EXjv5xfoBoCFX9kQr87JHif
         uxi/MqRDHkGHAblY5WybqV2NXPglhLM7WuLm8Su+9EVI5+jmBA2qKxx+TiNRAlh8lyMp
         /EFonuPnIZ5FYgOVTHmOI11HAiSRd0BovBSD9xf3VN9R5SPamVfvq8M23cl9GeJ+c0us
         XZkQ7TDT6Dr3L2BUfYZdRGFjhnypLNAA5rRFYEnMkqlIaMuPSCQ9ephUZDmnMPCjAnvi
         1YKBZ8FOYyYr4Hyzx8c4KzEUlnUfZdwnDaUEAg7GStVmRCc7MtkAErhJGY1eKtKz0nZZ
         8ahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5QRAM60M7FQyWzpAzP+yy9ZMIOoe2TTzNNomx2JrlZc=;
        fh=npa0BSUydD0TFmm+qshoGcf61QTgah13cB+4JnpImWU=;
        b=QTjlZH2jtllJhQ84/7ieTobaf01kQ6c9a0eitPsfGNm2yMXnyDUh0uozGBizw6Eiuo
         a57o3TsDwFtQ9s/RkJ9sqtVp5ZTqQ5YaVcl3lLbSwHTCYA1qtC16nfWSURVrTWPFAqZw
         e0A5jM7jLh++/5lEAHI1wZESymevUag3O1heUGxs8Axc9CLFaCiLrGptW7c+fVGTbjoS
         FWIVAzn4uXncQVd51ZoKC2sinh3pL6caxBBaULY5ewA7xdk7aBljTZvkxYBoihjO8GiI
         ew3uqa5jAl/OkSqOLej9qLixnYZg0WQYd7k1Q5BaxmrzzwlPyA5V7aOp4/KNqb/35duL
         arQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777255647; x=1777860447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5QRAM60M7FQyWzpAzP+yy9ZMIOoe2TTzNNomx2JrlZc=;
        b=Tm0wrPeFvE3M1JdbjSnW1Yy7SV794DMRFltSYoY/YMfHkb/z+0SmHr3CylZm9CB8x/
         Rv7/2AAHlS5Ek/Q7DtbR5+KjvWftLqOlxOql7xfRogLXMUsJkNRBRIFvbFz1K4QAhnjs
         MTHi04gc7LnSJyIbkpXD6lzPwDSW5dCrty0neAxXiIAE/Otm78n7gQQOAfVGS/QeDwfz
         z2fvPVYL6YmSSs5TEfvMfSDQbv1kppBA67cZF/JD5kOrtpONt9k8Sp9FASQbuRPNcuD4
         L286SlrNjUYvbiuNOBNKNG5rhG3rCfwlula6wjoH3zlkPws8Krvl02Pzd5/j7/QGu5iJ
         Shrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777255647; x=1777860447;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QRAM60M7FQyWzpAzP+yy9ZMIOoe2TTzNNomx2JrlZc=;
        b=kEFBJ2ataaKB/V9U/peKFsQEyiQ8SYnrNaaBkKsGLCEL1LqX/JclmTS9aEgCW0InH8
         YqQPt+Djo7q8J5t8QxPBzdX20tewCWav9vYhE6ZPGRHmlZX56Mz+zxa+2DWQGk2gBAnv
         XBE+28w76Gnw69B3+x/wmqdqEhpTSfNUoLIWoyD+UISRpuqy/789OqOh8/tXeIi3lUb8
         QTfJ6BQft5HvBXsxU6FDZUZ8Gp4uszAtGDH/WfViDzEFXxrGG/R1WEc1gJTU/VqR4oFN
         EzDoibJM1vPpwhHGiaqbpv39kfIjuXlu7vODHX+Q9Xti8oCektbXXSx+dfITpl0DDD/S
         TkQA==
X-Gm-Message-State: AOJu0YzSs6dEwBB9GmPdx4zchHGHlBh1X1N06tZohMWvNGd/7qlmORkT
	wjAUUxg8k4hE+GVMVqOjrvxuAn8Q5o3eQzAl50UUeRFyqEJItv76FR4n3UPIH3wipXQgVIuHFCJ
	wICaYM0sFUL9cKZWvXRZrQeT91Spx2Sc=
X-Gm-Gg: AeBDietfK44mVo0pokA/5rnGbP1pguuUQIErhrT77qVyt80oQbwD/hIGkJ9FnysXapq
	XNKtwETt1oKSInoqVlB4mETVs/EJRHECa1UHrjapNGBtBFU7gF9pzaysH9ysgqRcL47AhdoOWC/
	2anAQblkfvRYrd7aicw1MRCCWF2Fp54Jde8NcixpDeb9SPif0Zpd5zDfCoh6xBtKpVay7kEAnAQ
	EvAOgXJr/4an6FXS0dp1z8t1Edar5V0ua2ONfyRTGLYxDHaZAQH1h2hxuD4rT5bhvR7O1y12clG
	US8uE3ViuMWM7doOzqwT
X-Received: by 2002:a05:690c:e3cb:b0:7a2:ce0e:8641 with SMTP id
 00721157ae682-7b9ed4195admr320557307b3.18.1777255647230; Sun, 26 Apr 2026
 19:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Mon, 27 Apr 2026 10:07:16 +0800
X-Gm-Features: AVHnY4LVq3g8RkFr-vwDbp0lR7Xw7F23pwSb-LP4dwusSK120OTyjqceI9TbG_I
Message-ID: <CAGp+u1bdbe_5Xk6icnDcs70Krbr_6M4yXjhs0HVo8T4953wNSQ@mail.gmail.com>
Subject: [bug report] Potential refcounting
To: tariqt@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5383546C089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281206-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Dear Linux kernel maintainers,

My research-based static analyzer found a potential
refcounting/atomicity bug within the
'drivers/net/ethernet/mellanox/mlx4' subsystem, more specifically, in
'drivers/net/ethernet/mellanox/mlx4/cq.c'.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
mlx4_cq_tasklet_cb
     --> if (refcount_dec_and_test(&mcq->refcount))
     --> complete(&mcq->free)

T1:
mlx4_cq_completion
    --> cq->comp(cq);
        --> mlx4_add_cq_to_tasklet(struct mlx4_cq *cq)
            --> spin_lock_irqsave(&tasklet_ctx->lock, flags);
            --> refcount_inc(&cq->refcount);
            --> spin_unlock_irqrestore(&tasklet_ctx->lock, flags);

In T1, the refcounting increment on 'cq->refcount)', although within
the protection range of the 'tasklet_ctx->locl', is not synchronized
against T0 because 'refcount_inc()' does not check whether the
refcount has reached zero in T0. This case is potentially problematic
because T0 decrements he 'mcq->refcount' and can enable the
'mlx4_cq_free()' to proceed.

Thank you for your time and consideration.

Best regards,
Ginger

