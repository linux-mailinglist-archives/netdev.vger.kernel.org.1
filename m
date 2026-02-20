Return-Path: <netdev+bounces-259640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI77LtnMl2mh8gIAu9opvQ
	(envelope-from <netdev+bounces-259640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 03:54:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C7164506
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 03:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB4653026C07
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 02:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BE82BF015;
	Fri, 20 Feb 2026 02:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkoB5E4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D04D1A9FA4
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771556032; cv=pass; b=nPskPEJUfDcCjjMB52UeQY1dNKyarfHkyek8WvMkPITGQO4hdoHNwI/KCuMCWwo5iL2lBnDi0qOJFTITTZMQQdHFxEDfpU13ZqjLR7pxzV3gHf91BRkpC8Hy8aCqwKhINNQ4zRTmi4lu9fzQuNLNVK0Tk7GuH8m5vDFWQUA7A2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771556032; c=relaxed/simple;
	bh=4ZweesHW/El3kcS4FuZpUAzUaUkj9fi5Jawtj2vboSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NY+14YKuxlnpk2jwlpx70QZjJgPJbDAsF7Ivr0BgSbUpRU7HlhU8zD+NI7VBOavTF1t5ehK9W9N4nFZegGkq1MrxMYAHa1euHTPEdCQF3vfns5LRElnes4C066C6qPpmDV3KdCkJB3ZFeSAVu+4Antl1nu/FbQq3C5ClmBZoOgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkoB5E4k; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4376acce52eso968734f8f.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:53:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771556029; cv=none;
        d=google.com; s=arc-20240605;
        b=f8omqlk/OMY/1I6qSUZiTemBFtf+RRId4SKaz68k+9i5AWB5a3zsGOSB9PmbzlugSM
         13+i4QTNpAXGJXSFs/0nOlqQSD15CRbazBFrXqpfaDzH4hPhhR1tKvYOR09/NPXguWNo
         tvleAInfuZzvThWkGNBivOoBK4RYMHeBAE7AKZ30g4ndm0wdFAh+/6aFpxrMTAYn3ybI
         dXK5iHAvarczLemY0YzWPS3IqTnGCILI//fLQdLpRae0L+g2UvO/M72sO59KPJSp3G8g
         xQVmmZAV7RPH7FpnSMEIfu4JdrBHGxK2n1WSVsCJ60S4YtqSE47dwO7rGA5DamoqQ7cs
         jPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XclhKGEMPuoe0CG+SPJejZcbwGMnNs0QnOy5CoQQz/I=;
        fh=OQDETJDkDL4tHqHWmirNu9ibsdGUU8edzpvjFzxJa08=;
        b=dE0AJUmDEqRW7iG/BAzHjif6HbTMOHN1O0KTKGnZX1rqfS/rSgzbg+EsIjknlLdY11
         V6YRb6bO70+dYX/eaJGVkueFRCo1WHVRUvBFZxQyvNxLPkpTi1UrAIJuClNrZar7Imn5
         0rmaJEtRs6LJn5/+FGsyibtNcWo8T19fv1pbewZZ89bPXpJ4JDaZZApR9/tfsVG6W1+B
         FqJkS4C3RYh9kFGdA3Wbaz6WQVKqgaObsky4DJcVYt5/fqxbTWGQmopViMdkuSpefRSL
         PZAQq5qlay1LVdRyQgnSbaXFAZGl2cbuy7sxEzrDY8t0EUlxOpGIhRKRD9kP3nUw9pA6
         TdHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771556029; x=1772160829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XclhKGEMPuoe0CG+SPJejZcbwGMnNs0QnOy5CoQQz/I=;
        b=EkoB5E4kxUGOjYS/Oq7bKOzqquqQJwOhgmV4qbq0vD16ZpsYQsGGUzzCSgQLEo1AL6
         FhmQYRIoO2eEE4Q5UQPGktqIYCOo7VTDgkiUFFTeNfvHA2FZlLvXcdSuaY7rQQZ7lnyr
         9ZQp5I3rcYla78ms7Wwb6zM5hid3CaQOFp2Wuf/iKacqp6pARzrlSAMaNJ9Wz23cAdAH
         K2f5A7AU+2Vd//HRdWUzd7KQIfma1J165UUvEa9qIfhCOXTBMSjeAoRZnl5WKL15kG4L
         xjg2XDoa7rxyrcVcGLaqCGxIGvmP6jYb/XQ/+owXcUuxJ4P2jtFP23pptymImKKGbw4G
         SSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771556029; x=1772160829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XclhKGEMPuoe0CG+SPJejZcbwGMnNs0QnOy5CoQQz/I=;
        b=aUG4KSAPeBZr0pP2305eUVmqppShaKXDOhY+u9Uhu69ZWj4FvT8+WBz9YDy10IjvIp
         RPJipJuDo34fwvSBFoxzfJZACJLaOtHYCpvA2uACw6dDpAsfa3lO408mctxDUlCHMtHi
         b1QWu1+BGRrA24sfW5v5QezHOEhP/SdUg+l9JAMIPv35Dm7Z+TIA6DfXzIxxmCCz/oRM
         SWvykPbLmyVVAVknFZZGc5Rb/n/gC5y+YYfyQXFqZ++ZCopyYvw/x20vjVVzSVw0+1nM
         iBlZxo8RGXryP1QeBybaQeMbmJagrLcRIe8yvWoskH/JaVcLz2XxTzYp2fJXsFisEa+T
         1cVg==
X-Forwarded-Encrypted: i=1; AJvYcCXWAnoi7UIpy7Z8aQwiPZC733FFMA36QLgHeTkfLDj7cep1du4X6LfqxvSpiN+HUHFcUm5oLw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3avXJeyq/HNv1VTk7yFgx1Qg3G7cquQU8A309ngRLrHFbsD/
	SiaMjGhYG7HZPCwGlM5E+XhGEEBUVVxvmpVZsby8m6hgGC2eIMse1AnVdi0FipwAe9Z1H2PssZT
	Oxq4dzVE7cls3Jcy1dfy+Ci0qQLL1xVw=
X-Gm-Gg: AZuq6aJwwe+NNiAWrTF9yVOSq2zuKj406sEeu8LcWqKQ/vrblZ+7IznO1LBmk1LmZ4/
	Kl82YyR3L81wuzEShNDnBYEmPtstcClBe0mYcluTrbumxJxD5S3jMOgyIGf/+fnvke3Rj8J7bfe
	bAGk4XGW/WnXRuIHpDvW2jBhWKjSTfzYYitq3yavshlIe/7vbRIU9U2stiEAdDPe3Y6vrlP9mXY
	MUODlNV4QAO7CeRfQRwDhyMDAYSw92gLLkCPWHUeNxTSDSWIYWgXOIeAH1PDt0Dj83xnV/GQgwZ
	78eTzxK0+MdI0Tr/v3iJZlUf9Vsp/aoN0k7mHiH9ZtUyfok4XaWeu6ET0ooOoUM48XU1GDrnH3Q
	m9Dg2rEOozzo1dTMPv7LGWN3PJs2CZdm60F/Q
X-Received: by 2002:a05:6000:2689:b0:432:5b81:498 with SMTP id
 ffacd0b85a97d-43958e037abmr11871132f8f.23.1771556028711; Thu, 19 Feb 2026
 18:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216145306.96108-1-anandkrshawheritage@gmail.com>
In-Reply-To: <20260216145306.96108-1-anandkrshawheritage@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 18:53:37 -0800
X-Gm-Features: AaiRm50WeqM_XdU1pVUW8HVyIvZxa-UEV7BN3MvVxZQJFRMSw_YWtv2ChsrZEp4
Message-ID: <CAADnVQJnZk+=OwUEyf+grv4wj5T+Jz9Fw=v_pAdTLOwqT3o4Bg@mail.gmail.com>
Subject: Re: [PATCH] bpf: devmap: hoist loop-invariant xdp buff pointer setup
To: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259640-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,davemloft.net,fomichev.me,linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 368C7164506
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 6:53=E2=80=AFAM Anand Kumar Shaw
<anandkrshawheritage@gmail.com> wrote:
>
> In dev_map_bpf_prog_run(), xdp.txq and xdp.rxq are assigned the same
> stack-local pointers on every iteration. xdp_convert_frame_to_buff()
> does not modify these fields, so the assignments are loop-invariant.
>
> Hoist them before the loop, matching the pattern already used by
> cpu_map_bpf_prog_run_xdp() in cpumap.c.
>
> No functional change.
>
> Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
> ---
>  kernel/bpf/devmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2625601de..568477ce7 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -341,14 +341,15 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xd=
p_prog,
>         struct xdp_buff xdp;
>         int i, nframes =3D 0;
>
> +       xdp.txq =3D &txq;
> +       xdp.rxq =3D &rxq;
> +
>         for (i =3D 0; i < n; i++) {
>                 struct xdp_frame *xdpf =3D frames[i];
>                 u32 act;
>                 int err;
>
>                 xdp_convert_frame_to_buff(xdpf, &xdp);
> -               xdp.txq =3D &txq;
> -               xdp.rxq =3D &rxq;

Compilers are smart enough to hoist on their own,
but with this change the humans would have to think harder whether
xdp_convert_frame_to_buff() doesn't touch these two fields.

pw-bot: cr

