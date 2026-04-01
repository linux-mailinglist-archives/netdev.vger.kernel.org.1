Return-Path: <netdev+bounces-274174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jj6NwtNzWl6bgYAu9opvQ
	(envelope-from <netdev+bounces-274174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:51:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C237E303
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7B8830856C6
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF8647887B;
	Wed,  1 Apr 2026 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E05UbC01"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB7472764
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060819; cv=pass; b=q2CA3lyAhl7fu08VPe+TyeTg8tkVLnOr++ANJdFCTaDiw15BKbbd0NTfzN7u/PdSHiI3Tkz2383Rllt+tHHp+vVQ21DpKkdEEZ1iToiq/aeMy/m394yOe78DEGDbZRQBJAu7jRb2OspJOVgyew+YCcBPsZtWChnjwC9qyxSEF+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060819; c=relaxed/simple;
	bh=aRnkEa25gfmVdvPFf+5MkiWXV/I4OmCVvJh9nqR0Y8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vr1lMPCtB9iuzHLaQNzxTh9xZFx6EigVWRmSWQF1ZjsyeLMgAqrvFp2410VVCTgXlMfqKa8l51Sg2C5smVg5SE18ugUiC9muU18g5qjYNwwKx6m/heBAEqttjkxmVHIppxA9PrSalXsUwA0DhpzcQ5A0WoMwbiF/JZtUGzskKo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E05UbC01; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f97c626aaso1279882466b.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 09:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775060813; cv=none;
        d=google.com; s=arc-20240605;
        b=N2+ZkamQdEBeHIrVBmiZpjjqYsiGw/xdbXLpS3na7PfyrDiForzQs1N8NFflh9N/Ia
         4jXsrXBC9vGs+C1FtEIQRT39jX3JY0DcBnXFZ7WRa2gAwQqO42uWCc3hbnKrx2HnF2b6
         QlWKLwtH3Mc9/8sqPpf/LE53tafpUzETTQo3d2QejQ6xGtiE6ZR2wQFRlfmjjFLniA/i
         nqwXPN5SV34L/GPL/aJL8b41rnQhG7mFAYHl2pvLdNBsfp6DBkNGMX6v+Uv9V+CmK0NL
         u7mVWqjhAG37pTwYtZkN16g2kcFG6ErVv6SYOQRa7A/LJBbK/cuwILbZ9aQKLJ7S9UYJ
         gphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kxzG6nqvRd5o0MUgb1a8DsaU/+sSmmJoEEk2DEGOW88=;
        fh=PVmNIy0A5AZkRSKSdwam8trLeJ3H7pr+mRbFQ3/VIV8=;
        b=a4pTYWrcBI0goocaE9dgoVczul5JH6xofm1+WFuPnhS0vLoAtZR/d5H6KSQ3hzUdmN
         Xy2EwqN4l21FbZh7LoyrS7r/wntIaPAV0TXhGsHe1Kg0/zmw8b7OB/+krqXuHGKZVhB4
         KNr3rHI3Fq9SX87Ff6KVSFvxNaia1XHR7KLh5rGEBppcbMgZC6g3G53+X3Jq2alawemF
         hRND5IuLRPaiLG0458o2bPcNNSlS8CI1ndgeOJ8SJWFz7FM5N7RksCPQWm3IxrD/nYkA
         c/QptqCOlClfR8vpZKCrvoloHD0mVxSw7qRv7GlJvVrituRc1FXk3ZIcXkQcmROZlOXg
         XwOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060813; x=1775665613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kxzG6nqvRd5o0MUgb1a8DsaU/+sSmmJoEEk2DEGOW88=;
        b=E05UbC01dvR0hXuKLJo4/RG1Gqc5LcrN3vlvUAGELbgG/G0Nb3RPD5uUGEpN0CL6+o
         jIOAcuNyPNVluNCEuCF7aR7PMMhzM2QgRjtkCTjBt88XIxNnyUh0+O9elny0adx7TpAV
         dYiCzJlWGoEtRN5ZMcwVZike1XMA0rYuxyQbm7SiXSJdcYwN+CFSRQtx+TYBR2fMCMh1
         OPWXjsp6ylL2HGFWVyHnar3XEgdrBabuWpRxKkCBhI0jXVP3U3pqusF5dtumlhSitLbO
         JpuswJgLy2BIVvJ2ZAksTjREj4LYApvKbEULwjrpqzzoru+LWrFetsB2ijXY6hptMTyr
         MDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060813; x=1775665613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxzG6nqvRd5o0MUgb1a8DsaU/+sSmmJoEEk2DEGOW88=;
        b=PbgdfmeuKfzE/V1gT+MDchgSqcgvgG11vH05tGfLfCP33v1PoyGwtsGKwNfifJ/sFI
         H0pWCmCv5Ptv2WLoMCfeQm0UCGSeUxa1t5udHl32XpjTRORK2YZtqmI369CeLASDtYFB
         cxSbuQ2K5L5Bw/nbz6bXRynjQD/xZ2XqESG2RJ25zGJWDjnWDC9Pix0edcd0FgRlPLY9
         4Tws8Fz4LCOOLgC+eJTMaH2VE2YDe65gqqAZqyKuOeQzlUz4XvGwSfrZ7w/a2+/sUeiL
         SRbCpiVXzCzv9lGxeK5WHmBBeXsntTPJRpdRGczGlY84UvY+cP5JM1rDAFn2slHfMI08
         E5Wg==
X-Gm-Message-State: AOJu0Yzdfp5O/vK/uDtTKmF08IGALmHkCmJNhd/yP2QjTSxnRUAkHHMV
	0MVtKh74VLl80xukoTUv/mhkTrJ47va4/HXALUs15sHg2KkTGI0MaeFJFpWJmrZ/zZuVX/9mWe2
	tjV7XqDqlI2++ch/hAA2W8I3RWLV0M0g=
X-Gm-Gg: ATEYQzzIY924yfhYzL1BNz3atbTxJTIeC4fC96QlPmXjHEq55q3sPReyyMsJUGeC7aZ
	gnfcCTkB2Veu7vq7NOV/ZHiXbV7lpbHQC8fRp52UoaRrN1D6Qp3JtvJNNuapSE6x3z4OceuY6Xj
	jfbkPyL9ap+FrmutC1IuBTv2Cv/Ett9Kv3/nFyAjvMrT0zNGmg4nhjRTkV2vqOD5RxqG1/vaLqd
	8hadvaAzv+t6+/sGYB6erPv062lvAGVWcUlnjMyrq+7Do8qycXeBzQIyXRbhW6rZoOm9Lp5MC2R
	iPbRMsaUDpdtPum8po7geqX49Q9tysAB4KDMM9w=
X-Received: by 2002:a17:907:a604:b0:b98:1129:51 with SMTP id
 a640c23a62f3a-b9c138e4238mr302325566b.17.1775060812773; Wed, 01 Apr 2026
 09:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <act8zZGYpN9DJ4-w@secunet.com> <20260401045652.1807999-1-nicholas@carlini.com>
In-Reply-To: <20260401045652.1807999-1-nicholas@carlini.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 1 Apr 2026 21:56:40 +0530
X-Gm-Features: AQROBzDWT2XlmBMeGQpas9U4Q_ShuQKK5Ui1C2yCXIWERyKl-doSNdd4GhAvh_o
Message-ID: <CAPrAcgNbbcLrJDBs03=CQU0VzbqaEGi_h4gsrWY693ERsuTE1A@mail.gmail.com>
Subject: Re: [PATCH v2] xfrm6: fix slab-out-of-bounds write in xfrm6_input_addr()
To: nicholas@carlini.com
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, 
	Milad Nasr <srxzr@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274174-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viswanathiyyappan@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,carlini.com:email]
X-Rspamd-Queue-Id: E94C237E303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 at 10:26, <nicholas@carlini.com> wrote:

> -       if (1 + sp->len == XFRM_MAX_DEPTH) {
> +       if (1 + sp->len >= XFRM_MAX_DEPTH) {
>                 XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
>                 goto drop;
>         }

If you look at other places where sp->len is incremented, you will
notice the guard condition is always (sp->len == XFRM_MAX_DEPTH). This
bug exists because in xfrm6_input.c, the greatest valid index is taken
to be XFRM_MAX_DEPTH - 2 when it should be XFRM_MAX_DEPTH - 1.
Therefore, The correct fix should be using the common guard not
changing the guard to use >=

On a tangential note, There is no guard present before the increment
in xfrm_output.c which is probably another OOB bug

