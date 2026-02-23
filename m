Return-Path: <netdev+bounces-260159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCY+IJihnGnqJgQAu9opvQ
	(envelope-from <netdev+bounces-260159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:51:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDC417BD6B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97FF6302F73C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F25369234;
	Mon, 23 Feb 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBnZHrqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3859366DC9
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872662; cv=pass; b=pFYdGJgm/kCBy9FIp3HRMK4N50UnVvyizJNOuFXhnCdHUeuJZLYzTDKqgKYblftfVcPSALKXjPtmHRtx+pK2S0sMi7QjXIpM5mfSgyjy5Qffxv1slCqsSKqU8sKD+CMf666qfuDJnSZThJNgXL9W7Jshrr8yWfkuncKNh6HTe2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872662; c=relaxed/simple;
	bh=Q3ntsvWtzlxd2FqjlsEsaCYoNPspJk/VzbtQ/EpeEE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaEWxC24aPRc+5FjsADVoboxoKjWIZGoDAxsKRwNdEK000Jdg9jkpAFajSp8cu1Bokp3qW9lgcjJhnFXzYYCwJ7BQav1djgCcsDgLP6lM/tjskCEOX48rwdwaqtETmxHvTPaMQ9+I14IoVBJ7e+hmXBvrbfgXISdprtI+hrzfh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBnZHrqy; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12721cd256bso5340880c88.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:51:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771872660; cv=none;
        d=google.com; s=arc-20240605;
        b=TwNi+wPrjaBW6iDPZiIBt8N40ZJDStbQzyQE843y60tNjt6NFqlUk0tlWtto1ze/qg
         TNxL4kqTOZ8a3UwiK4NQeqTEEMuhmcAbi5FMOMI3zxJqbLK1//gDKfR8ZKZP8zwPT6P/
         g/0EMdo4Ye74kxei8QAW4vPoa/8ne7FuLvx6aSignYqyagoku1rDxCylMicc46goSBgF
         X8VvxdlTTCoZo6C4Ek1b9J03qkK/MT7JFd9NH662HYOezLqrR94O4kcs8fFx9aiadMA0
         JOlnu99vaWGWgfxorOiEHrIPdbEiH8kgSrzUDKo2D+ZhePm/8w7tmGm1kZC0MHxF7iHc
         +IFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+IWzvGtNHjTUEFq4FjMxPOzC5Vi4HpDFoHCAgiC/kMA=;
        fh=QlFks0R2aVtnRi5IEolq9Rf43jn2Rtsa/Gq/z6VSMzg=;
        b=W7s9MOkuzfudyIzmEBINDl7PkAlripx/jDAYBmG2XGEcwyxh8PIrYm8stbGhEGtWfT
         ziJk5Z2wEYQ1n65JlsP3rf8XYXKuXGTfUKhXtWzmIKcorpFpQgGYQLBTqTWWOW+L/n7N
         l/m9a4fhSONzYouA91EA/w9+AbFuFxDKyJXB0AOyYAnUq0KyEnCEJtHd3JvPudlqhWFO
         /V7rMkK7wxjkPvrlzry09gK6aQXBU1AlT2pJclXehOeqgJBkAbAIooqhR14qU/mQTs8s
         EdMmTw+/BE/e2a3Q0EQHRAFhvIj69TFj4Yv02WGUp9aFqxT33eE9RTml0RlmCdoIJVKB
         fiDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771872660; x=1772477460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IWzvGtNHjTUEFq4FjMxPOzC5Vi4HpDFoHCAgiC/kMA=;
        b=tBnZHrqyA3vGEALmMVlzN3DcsHT/v1bEv3DYqMvhnJhWODN/0+mz9e3dXFHR5ShY3j
         y3wLYrHRqZLdM87m+pbXbrPftV90tQAuBZ+IJZwaqe8twjwbjyROwSny0TEYF8HBrsnX
         yxtyBcfBKoKWH/1RflsbHyLD87h0DE2f2VV+5MWrzSMuY9wDgTSCB1iN1IgCtDysPJuC
         /GZmWBXz4SxTSXNpe46EDARWWVRwiwI0QkZdd80OIF1C/Bjr1HFz5vOJxHMabJYzXGtX
         SkqmRrtn2TfOGKanXYv0Rv6VTlylcaAAfaS1lqYUkCNalM3ZquS6S/pgF8aprDQ2Pv0M
         ufTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872660; x=1772477460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+IWzvGtNHjTUEFq4FjMxPOzC5Vi4HpDFoHCAgiC/kMA=;
        b=e+VWDfVgmUdwKWTWT5IYhUnZI5vyVJ5WMJp33zmQgI49fjsxfUB+wDrL/7Sa3+6U+T
         BStiaEPNS8KSw28MWoPLvtvTVQEWvm8oSGFtRtG40EYIEXtDyIkJZfEcWaL6PSkCTbM0
         EHHftAeMuUxtu6JlvF/+QYnKviwLuzoGe+lYb31vNdjURyJ2/sl92MgDeyzm1r3hgUR2
         BqNFhoZsnhheBqvcNso4iEEYZoue0Ycca1jbrbpznMiSHSX5lyaUw6DOJHls66C9dvrk
         c4E7enqRR7SOR+zSovv+kN/aWz8xxVMlupjKkc6UVvq3RdTzvmmK/B4T1QRcakiKt4nc
         pZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU92JzBKSCA5LUThzyzSuNryyiEqWr/Stnjk73IlZc4wbLHjmiHjRsd4gIyZ/AynEbJlb1rg84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7dll1VPJnG/3xiNyl3PwWr6dXBlRpe7yGVZu10jcDVacAV5z
	tt4di5MEl2Q/hjn8+FTgbqWGZ/egNG2PWVL3NNK/68ew8SOsYLFJNkwb1lTaZ3wtRPKI+VyMU/n
	6b2U35Sfky3C0ZibfvIQHjaLMh6slB69d0KV9BWPn
X-Gm-Gg: AZuq6aKXnC+Y7Mq704QX2YzsOWAlEmDJBVAt+x6OY76IX+oyZwtulCJ9srmfUFSjDUG
	EsKRxbaAA9PqZFrFHxPD/Yfbenhu+WrwNULK0hbYGZPaiEEsnGFobCSveMqjD2mGXpcCoGxJ18i
	+WE3/0taPSj++OZY+HTvcDKYzcWxoWACcxR42vJ8XXoVeLc9RwJ/7YqnSschPn3b8NG8tfyL2/M
	yws+MLmgXIFiGCBj3aCi8NcwwcR3rLD/QUklrNB+QKv58n1+cpEHJj6CvXmxMsMcInxMgzwwCfL
	JbUVNqszqu+caz6MctxdQHd9/TVNMytVr0Hm1oLCjjJEAo0IPFaghebvInia3W4IA8uXCPzM
X-Received: by 2002:a05:7022:40f:b0:11f:2c9e:87f8 with SMTP id
 a92af1059eb24-1276ad4317emr4260532c88.34.1771872659422; Mon, 23 Feb 2026
 10:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223100729.3761597-1-edumazet@google.com> <20260223100729.3761597-2-edumazet@google.com>
In-Reply-To: <20260223100729.3761597-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 10:50:47 -0800
X-Gm-Features: AaiRm50Oza7TxJBF7tflvFO29wplSv1_25BMYJWXXMJYTESUbTrT_qeK0vQCq7Y
Message-ID: <CAAVpQUCgr0tbVuR7amjd3uey9Qn9=kzferXLdwwgXzmQw=t_=A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/3] tcp: inline __tcp_v4_send_check()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260159-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBDC417BD6B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:07=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Inline __tcp_v4_send_check(), like __tcp_v6_send_check().
>
> Move tcp_v4_send_check() to tcp_output.c close to
> its fast path caller (__tcp_transmit_skb()).
>
> Note __tcp_v4_send_check() is still out-of-line for tcp4_gso_segment()
> because it is called in an unlikely() section.
>
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-9 (-9)
> Function                                     old     new   delta
> __tcp_v4_send_check                          130     121      -9
> Total: Before=3D25143100, After=3D25143091, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

