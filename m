Return-Path: <netdev+bounces-307396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F9IxM6r7VWqExQAAu9opvQ
	(envelope-from <netdev+bounces-307396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:04:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26518752A8C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:04:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=djxYHHrk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307396-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307396-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDE57301E3D1
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE5D43B4AF;
	Tue, 14 Jul 2026 09:04:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B93E6DCF
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:04:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019880; cv=pass; b=kPQG0L8b5CkxO3njJfKnsaekn+1UeOekDEelXq4q5upjw2d+0P+5Nne+SR5mZsiWO6xc20RmN+h/OjTGg6G1cA9OTuadMdj5cJq1DoeK7ilARk3fmR/SmuEg852jz147FUEGAx6M/U55SndgEFOwOxqT4BuBhbb8aXI2ciZxi3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019880; c=relaxed/simple;
	bh=iaQmmVCiE7NdWy753PwYNnwaKukj8zYSbeXA4Z5zlkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ5/nRrqYgY8X8nwSaBYJ3YbU4ODXymEG+C7o2HAZPgoMr+mktCi7NXEJXAvtGhpTFdQXYrHE/bxAl12EHYzkTpIkg6aEdj7OPBZV4OTbBJZuIDAU8CPuDj0CiUlr0wmA9yZU+Sx8/6S48wTniArJjyCpXwiRBw6T7lT8DOnNdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=djxYHHrk; arc=pass smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c21495722so25012341cf.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 02:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784019878; cv=none;
        d=google.com; s=arc-20260327;
        b=FZtKCa3mtDqZROeyxkcc8QNCOOcZgkO7IvdWZw+e02C7YRbQPBjdQJSLfmig806bSu
         rv1LeSzGKUWDRh0xOaW6ojH8tSZJ5OX4U+lepokWvq9INuoNBSecmHY5JTzC6rzHDugK
         IZP6Wy1kNAwvVyTqlSSvSFMIxvLui7RkWuHTBRGm2Qa7ittSfnB6fEEZixIMFzcXnrKG
         qoJuKqyfaw3E5YdW5nkffY1ASRR+ARGZd4C8U7lEKs1MikFcQKMgyiDgy3QdnMmvK4qk
         B2+Y527z6G9XkhQ0rFuDGGe+ZESNDC9A5tKzJnLrGoZ6bql+onArRFxQ4ugKkPfJHVh+
         bj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZTtUNxO6z9f4mwqOUjyr9bIYNiAKbPXuXL1XYYWBu4=;
        fh=v8UFJSeLPJt29zVL7fP/E9t0f4liOBi+1Pd+31yALhA=;
        b=AUY7S3WlpeRS4CT6s/RqaUDJHFuOCk7qvMk7VfjKYBD4KAHcUWrN8fQ6X7pXLXOQt8
         lyikg7yG3++j/DeNGsZ1W/tEGn+LzRYsstHjs3qDtp6a2u0W+GRlDzSum6II4L2kOyUB
         Tz1BAWlqa5WvcV/+zufnlx9RjkroJf+dnUMeQrK9XgcWYjxNa7xzI9DwQeuUUEEvIK48
         DATmdZPIDt+LHB+Nqe4pPdIfqCK4QRTrMDU1aVYNUOD4VnaMQZTs/TUuffw9Mf3gq1hC
         JjAhPAPMZpQ+6LhNmkZ5zs8P8UVqqfNsrJcJGdX8+TfeS0ULyC+FszqLETEPXAPkCbo3
         eWlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784019878; x=1784624678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XZTtUNxO6z9f4mwqOUjyr9bIYNiAKbPXuXL1XYYWBu4=;
        b=djxYHHrkjcgPgG7FwxC2dKlRb010Re0sfYlj5GUrAxkc//RLUzPHU9O2a1MnNWxRD2
         JBixs7jPtAnau8tL1SxG2Rj/wUsl6sLyLvKpiis9jCKXstJK4m6/93+0BDzMQn2h7eaS
         4ErGB30lWwyL6TFHuB6j4NcVBBnYtGIHvch85romvZIjDeaSrnYOBnoQE5vRc1nDJcMy
         sNkVKGkGRd0aN6WWwMattICCPl3f3Z3IGiKVaAHh9nNagzvXss7RRvYszvgJMqOeO8EC
         ue6c7d5ufHW5BZdjLgWhWWlBxqfhmOvcD1uY/4E4+oGlvzWk6SUW9l2xUsCvhAgubskC
         DUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019878; x=1784624678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZTtUNxO6z9f4mwqOUjyr9bIYNiAKbPXuXL1XYYWBu4=;
        b=Kvb2rpetSCCpOKhb36dIaCCJX36KfbYltiP1bhHOAFHoM3WxM3lgBZ8seNVGAOs39D
         SIQ9fu2WNfCtgvp43xWx27JDgosbwQsHdXXWHaF6fuf/UrhbC3CxSuodxxXCtWZiEljW
         3855j5jhR42s9vm/OPNyQ3mYVvSbcAleUcydsfPtmD352mh10x5UFL3FwjkBf7HPWuDM
         J1xdF80xTJpGlvBLJmSKoURkdRJI60bqIA+zInQh7hAcTTEr89VSO0tTqP4jdXtj2VMz
         FQgqKZcQtZFPhXlqZ62cnG9gUwyNOtYfyrfTY02WMIHnfbGKFWck497aFehIn2lR1E3h
         YilA==
X-Gm-Message-State: AOJu0YxDHAAO/8djt+Re8pt474B6YYn9MrVBhlsYDYzuWvEgebtybftm
	I6/Vq+9GMrl999JAoqyTCVOE4PWnIIdK/P6UkqLsIgEziYx10lCxV/YFqhVY57/DPxerutZYjSa
	7635ssVdjftsoZdG7T5aRNulxRgKgwnSt1WlB5LlhUh69tt0bbD5EFF0OiEI=
X-Gm-Gg: AfdE7ckPAjfhkeCLX9/qPuvXYWwW2bDSrB5vemcLeCW3Ik8Qoc68qg1aGBfIT/36VyS
	AjfyfTywUv/VG2dT+sylYE9xJzFkSBnh9dsQYcjz+AY/W+g0vilQwP8pibIQOim8fkC8gu+wlpT
	0E9022VGfFNXBLSjoCmD0O3UnVzq8sziREW/MzjOfbOUMO1sfgg8eySyewY0RAKLTou2qMYG2HK
	9OrS3dQdEp2mjiIM4BKbxYfwYqFXUziEfjFrmBpAfySOQXjhKP/+chRQuQ95sKRfQD9R4FJb+du
	U6dA3IlEtwDnscCLq9p10O7V1eC/K3u12skNAKrHzWm5NoUBSTZfc2v1BHZ9iHId6IsuygLsc0j
	HicAOTgohpUc=
X-Received: by 2002:a05:622a:11d2:b0:51c:e14:87ae with SMTP id
 d75a77b69052e-51e3c1d28d6mr27490681cf.34.1784019877100; Tue, 14 Jul 2026
 02:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713105631.8616-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260713105631.8616-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jul 2026 11:04:19 +0200
X-Gm-Features: AVVi8Cdwh5_lQBrDRf_glhh8Szsib8QIaD1yn44tVc0VeL-V8w9Ji-fQmVY1sNQ
Message-ID: <CANn89iJo9U6TQbu3aVcn2YY=2CGTTf8+CAhwYh4i9EyG8cnayg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: initialize standalone TCP-AO response padding
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-307396-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26518752A8C

On Mon, Jul 13, 2026 at 12:56=E2=80=AFPM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> tcp_v4_send_ack() and tcp_v6_send_response() construct standalone TCP
> responses with TCP-AO options.  The option length carries the actual MAC
> length, but the TCP header length includes the option rounded up to a
> four-byte boundary.
>
> tcp_ao_hash_hdr() writes the MAC only.  Thus, when the MAC length is not
> four-byte aligned, the one to three bytes after the MAC are left
> uninitialized and may be transmitted.  For the normal TCP-AO hashing
> mode, those bytes also have to be initialized before computing the MAC.
>
> Initialize only the alignment padding in the TCP-AO branches, before
> hashing the header.  Use TCPOPT_NOP, as in the normal TCP-AO output path.
> This avoids adding work to non-AO TCP responses while preserving a valid
> authenticated header.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

