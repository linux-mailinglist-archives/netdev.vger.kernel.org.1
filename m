Return-Path: <netdev+bounces-301475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oKaiNCjpOmpXLAgAu9opvQ
	(envelope-from <netdev+bounces-301475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:14:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 682F86B9E46
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:14:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=bVWM9myx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301475-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301475-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D681F30407D7
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30B395DAA;
	Tue, 23 Jun 2026 20:14:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5F3939B0
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:14:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245669; cv=pass; b=G/lIvrGG19Ef9UW4g6g4UpqNCEsxAUsF5dIWCWzD5/AZog8sF0atH/Euxh61dI61jLj9XVTElav+Fzl97WmG7RAI59ho7412xcxIbOPyti46DLXFcbKuqbkT812aRYzNFIBGhLFeec+KUsi5AU3j6OPEdVcMDrTLb5muK9rXRF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245669; c=relaxed/simple;
	bh=oxIRW379dEOiR4sxsQeH5UaQGg3tBVrMKYJi2SksZR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJrLjfDDucItlyn+uhNLso9FMbrU90Yuqe2rtfQRKYeFOwq/rK/nmfGQRxqneNs59h9m9hZZ32XcEzO8KJ3OJZyFrfsk/c2jeC+KAiDnSVF4l0LMUbU0vnyFev9nnfTV6v7+h+/hn6QnaMciLud8sG+YJIleDPcxZwCHng0KbMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bVWM9myx; arc=pass smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137335bc3caso476189c88.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782245667; cv=none;
        d=google.com; s=arc-20240605;
        b=aWoiCnPupEtKGTglmwR3hCx1/ScWTNl3MG4K2Qrm9YGdgZcfcYwAlTONJ0F+LYq392
         RbSX1p/BqIRCxwXezQYLG2GTPBDIMp6oHwexUS18IaGwGkHPE0JdueU/r8RaCyDktSGp
         4DhbP/4ETOmOscd+JSQOHQ1Xir9rguRVjLwpH8+9FJWvkCAA6+U0fXTshGA1cYQzymOE
         H8Pprvt8oPGQIMkCKICUNUKYhuLfLC/uiXTPIv5zrdGb4OERa7rSOXAt6cUEPerdXa81
         3eC/5P1O3U/JJymwW5h8O+osJ3yuaci65tq6mmNAuj/keajdxdNmyOthqV0CUj4QO+Fr
         FjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l2wFhTrR9bWt+SnTkWykoVxrAti5Br92yzIc8/PvEwY=;
        fh=5LBeauhACAO2Va72eNXOEQ/uMadFOLcLqXOoaBMUfpg=;
        b=KtPMtjAx8v4jn9l9V8jBZ5GY5kdCQcCsTWjnLviJsssbphk2i8w+8KslJhW1Vnk6uY
         2tIKuQ0JL4XKN/1USOmw58MJbZCTTpDRp20b5PcJUAcaJN146d0bSvXEkCsDnoqqDV5n
         VQqitRiIXf3xD0xLhrHJ36plvG4bz68cybFLJDn37dDNFDgxu3eWPxD/rrkuOpZG1nI2
         7wny4Lz6f9j7vJt8K8YEAH6CTD9w34U8dZpNaQUIi6rcazeSsoVozMZ3SuMHVETjjjQ6
         /Q8BeqCJhED26ZiTiY4T/KHvZuNK2gJ3Rdq2i/f5eMODW2mKTwaTo9dXxMsbky9orMLC
         O9ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782245667; x=1782850467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2wFhTrR9bWt+SnTkWykoVxrAti5Br92yzIc8/PvEwY=;
        b=bVWM9myxI3f/zO5/JfvPqp96aDNXykOfRWPcF6lrBZDyYiZOJztaZdKgrlVdPyTTTE
         1/VXSpKQrDnwTvyYfiSvhwxTp7i9TGzsySXVyT5KEo9bvMZbSgh037iOV8jjXx/q29j9
         tgGMzxM2Nis7Sdw+mMVTmyXqfH9pN4Py7mhV8pFevIWWCFpoROPTvsoAuKf8ezwX8HyW
         CytfdwQPlMbQT/FyLlzkWhUCAwislYAypQwrDGbxxlL3Zo7LBQAaDewfvqnPmsJhQQg2
         alersG23sb7WCjJeBZacwUmqQwLkF8M59lRax9/3i06WCRTviZ+6cwuNxsY/d8HNWEPI
         vvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245667; x=1782850467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2wFhTrR9bWt+SnTkWykoVxrAti5Br92yzIc8/PvEwY=;
        b=Zbe99BCJ1v7NhGpIWMcJE6xImiZuaUUuY9322T4WKoUuRWf0/Cccciqh5xnglv910P
         ogM8PCg0CAeh72FB3hFnowj0faxSn/99+1QorHPwV5vhj4K7CO7Fmfi4U13cXG7YjW8S
         itLNbT324kxK+90LAGU3Cphh/5Rlho5plxu8hhOcUV/DWWzXyzHa7rNzSgC7bbjWsrU6
         VCHpgaxorGmARwCC603nGDDSma2vXEirKvDEmJyEHivtAoozmEKaDi5a6Jpcusa1nL9h
         M4fnJ0jetuNe03qU4SKtLUaiNYYI+BTn+aTBHH+3NFNMFy3cywNIwNj0ag2pRQ4YTNU/
         UdCw==
X-Forwarded-Encrypted: i=1; AFNElJ/be/OhmGkeAKc6mOSXCeXcko5P2QNH6t9/+wzwh3NMOYJrBh+IOGL2VAD9F3rAzZ1Ndzrz57k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuSSA+g3/76dy0YHTGIx/JHVEZlkGQuDtC/BKzy8TdeQ4NSI+q
	Y2EZKOxe0ztP4ytDTY947uqjoHdtRmfFu8b+nJu+o5wbaiRSUT3o7P89xSAM4V3ZSg03YQbDF4v
	cTuUPwQKgb2MpUgyxlVkN/S3gt6lbsW7B9NnlPTa1
X-Gm-Gg: AfdE7ckKIrDOHDbPScwqfd9UcKsPAnaoPXrAtuWRK4+KtBjOgpaAjwMLr89PORXqDX2
	HryfJp6y3PTj5T7TO06dHM8rJCoPutoevXqfusYvQeimV9qU7VfpeDsxYL0IbGIWGO3t63k/ll1
	Gy0a3ZyDSQD4ePiA274PdaYdrd5OACZiqWSb+imLUrhD1Ont6hLNIt7PVGzPSbnYRF6VqvwgTj6
	pccdmGLrF87douTCOB/Z7UQCQ5lMdhaFZIfaeB9xBGn20lORNn8Rp/aZVLxRSaw5tzpL52EeqeO
	j1vqk4gOw9pYOwmJ3Ki0/e2nfG9g323JnBRuuppGCDV3pFOAfgZGyS+0g5Mc2IToZED8xM2qdyU
	OY3lsX3tB7G+rK+TV336n1+9U1YUoSzxIb2X2b1E=
X-Received: by 2002:a05:7022:ef12:b0:137:fad9:3a30 with SMTP id
 a92af1059eb24-139d0c89276mr178539c88.19.1782245666128; Tue, 23 Jun 2026
 13:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <87h5mtyq72.fsf@cloudflare.com>
In-Reply-To: <87h5mtyq72.fsf@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 23 Jun 2026 13:14:15 -0700
X-Gm-Features: AVVi8Cd4JbQ-SnwWjMiK8HrPCjCXPhIvsiWwDPufvBNg1_Ylt_ZyYN2I6rh6C1g
Message-ID: <CAAVpQUAs2akj4ZPMi+ofGV5fVwUr3L0hGJ7+bF_CPe-oVwOpZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301475-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cloudflare.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 682F86B9E46

On Tue, Jun 23, 2026 at 1:09=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 12:31 PM -07, Kuniyuki Iwashima wrote:
> > On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudfla=
re.com> wrote:
> >> Okay, will put the whole file behind hidden config option like so:
> >>
> >> --- a/net/unix/Kconfig
> >> +++ b/net/unix/Kconfig
> >> @@ -30,3 +30,8 @@ config UNIX_DIAG
> >>         help
> >>           Support for UNIX socket monitoring interface used by the ss =
tool.
> >>           If unsure, say Y.
> >> +
> >> +config UNIX_BPF
> >
> > Maybe UNIX_BPF_SOCKMAP or something.
> > bpf_iter is supported without this config.
>
> Not sure what you have in mind re bpf_iter. Can you share more?

I meant UNIX_BPF sounds like it covers bpf iterator for AF_UNIX too.

