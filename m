Return-Path: <netdev+bounces-260165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePFgCOWjnGnqJgQAu9opvQ
	(envelope-from <netdev+bounces-260165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:00:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E06E17BF52
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94DAF3004621
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D254C3346A0;
	Mon, 23 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gehsgpEW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC172C027E
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873246; cv=pass; b=MQV8tYLXZ3/Vz5bOx0l5N6weN+zCW2G8hWEyazja4/Q1AHwFpTosJK84dWFYU/A3hFnVcLSJ/Sd1QxNykQ77y3s2g7TLwqvOCiEp2ighEjNAFNXkP9ob6iVQHMsrKtr2NIxxknAtoK4Tf1izP9FS64tiooTznq/MksKVb5YtLs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873246; c=relaxed/simple;
	bh=V3tNctnj6G0DQS2muG5URrzSa9iN3g5MOEbNLtnS9eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oj4AZrFIDdkEl+tSjm7zqC2gS8V+Gx9nWQ69rOPfLNSQPOLlpW8em3kJD+DLR7PFPKSkb0+zDmnhwKmjuiVB5d9w1hBzrSMcgdE7ornOG9MnaJffnRZs1DSSmzyVb/KEyPrtrQbAUIWTy5uMfoLMVPtObMFCpnHyI2fa81+F+Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gehsgpEW; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1273349c56bso5559984c88.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771873245; cv=none;
        d=google.com; s=arc-20240605;
        b=a1ULLkqeSYH3o2U5qSQH1PbbRLTmBlpttoXgSuqvL+mTesF514Xx29zPvKSsiCTsCL
         QLJ8JURWdR6UbY6zq1t4SlC/hS2n/HF6DKCUCyed/3A/TM7soqaIlPprPdabYYJnrm6w
         +/ll2OsvrpBDA0x6Ghm77cT+/fo4R+bX61N6aY5soTaDTFL/VQfJCUo1QDhOeeXoYTGD
         u2VVLtBlzb8h4NUi4v0KNTWZKo+/d3rSmOBUqlCQpXD3Gk6975IXru3+eK1fufRt5bBS
         GGHucRiK2bX2E9N3xIX761YwFcbwPlWNE6a08C0T4QBd/FaQM95QLfhJojLHjnRbx7xw
         QrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V3tNctnj6G0DQS2muG5URrzSa9iN3g5MOEbNLtnS9eU=;
        fh=3HfmrDmNZR4rmiiCxkRVvTMjcnPlJ+RGq/Vb8tec1Cs=;
        b=Wnr2RhjaPXn6PkahoWtF5i5qLgWRYsS6jqfEARVEno8K7saiwKNwHp7MrJkeEmCcjD
         a6y3W1q5kh8j8qvaPAdlbMllYLIktlwu6h7UGrD6lnOhgoP/Sf7uSbAXAusFTwrCGblZ
         sIY1nzPb536LgcblK7jLWxGGMkfFIBu7czqEW27eCE0rLyAHezHOyMfbdghTiRng114B
         K+NzERs6GoQWrcI/NetFAO75klJQwkv5DBhW/Fg5/dlmY9FWsRb/kBOKxTWMejym4pgt
         yUObvXKlm5G1h2DnUa0xUtzuFgzj9aPjzNgvyo6HYm4y1EVXESqd/J9U3Ha0VETMGiU5
         AJlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771873245; x=1772478045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3tNctnj6G0DQS2muG5URrzSa9iN3g5MOEbNLtnS9eU=;
        b=gehsgpEWMTLxZKa328OMD50wYZersF9NyKqDYo39YSxkiSol5y2hTfTG1Ty1IWzwn9
         TNG7WTGQoUMcz8dZ04AdtWLTUUANxiaFBjv2w+U5/MK7UyYCLVryzOTHsnko9ajPTVtm
         SzhSikgbKz0yqdDrx6twdG4AHrAWzNd/LXn77psun9VVGV7SwnuD3Ru2RAE0mBf6itDt
         S0T4SFHBMC24LJCBIiprcDMNkBb2w/fHSFgTIHdsQT3B2pHBbwf0/2t0XJhRQoEYSraL
         wT6D/WnQwvMH803cRbMB+IXXf+gYazwXOtbdye1x8dDUoy029cDCq0kAyUSqhk2P7XBz
         u8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873245; x=1772478045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3tNctnj6G0DQS2muG5URrzSa9iN3g5MOEbNLtnS9eU=;
        b=gnvDH5o+Ugovi2wKWSZSqSuf6OYI/9+02/uMdD9qTRikLgvH5GnhG4R8G0oWMslI3/
         7BcqPHN8KpUzOOSf7+aD6mIDa8vDOUfugkmouKNTIuEuwUDmgwsmIAeN3kuFntxzIdeM
         wSF4Wid9ru+HOlRlFvJfGWQC4kxLjrZNT4htm/ko4b48X97XD369fCyERZWvHrR8Oyvh
         mj7kCjXXdmncTAY57T4eQLJed32PsvaWnduvLH447azhZirrwGMvzeNQXXaB65SwDIYl
         2EtGgLWVDnL9BgMxiCSbFcqB8xqa0GO0JOrBHjsnHdHyhMGjsB/K5AJsiOua9Fgnz3M2
         e2sg==
X-Forwarded-Encrypted: i=1; AJvYcCUU02ZjH4uSExxyEh4MQbH72sfRsTWRZQvZzot68DqHAVwGldMLiR3+b3ayFvLva58ub17RTYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp2YoRnWzZ+yQy4UFOacH4Fr8SlA8K5DJRx6+Bjn1nLTOnwaUm
	b9deCSHtC1Cdx98mHYw0j6VdcJGNI8B7lJ0tMPxzDzx0kri+ZgZ12HoJjjzcNQaBtVK19sdX+7F
	7PEHRHkjSdBlAzYaKWZrnBPH1569uUcM4yBWyIr08
X-Gm-Gg: AZuq6aLwHaplSP3zwmiP64Mzb0Qp4OfCZtzXKasEYrNz2l+xvnArP8xeNUvSn5aw+i5
	BoQB9+1SARKlUNk+V3dBOVIxPwWGr//uDuW/nfqeMc3hjw0C0zaXRIog38DwfDZHZnXX5tYD4sw
	wJpYqTc8U2ExR2XQ5hoMc7O5G8cQOLGDp9eX00Qi0e5ya9XQPYgFQxOGnsUmm61WYqps2Jsv+Oy
	E/R1RTE6ifbSwGA17MA7zsHWB15Fd98BIvZhnZ6A0UQaKAwD8m0SDAlctSBDImh6zPoLzlTtCYy
	Nn/qPHAW+wYHWr5rMQUsFXjk75tPEIjk2jVMAXZpVBTNrTlAOF9+WDsmb8SOV2Py5jb5aNwt
X-Received: by 2002:a05:7022:120:b0:11a:2f10:fa46 with SMTP id
 a92af1059eb24-1276ac5be45mr4037648c88.0.1771873244037; Mon, 23 Feb 2026
 11:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223113501.4070245-1-edumazet@google.com>
In-Reply-To: <20260223113501.4070245-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 11:00:32 -0800
X-Gm-Features: AaiRm51HuhPqThaaFlVXxi2IwUSd3tobK3mwoomAdID8nNWCLMShbrtjCx6mtJw
Message-ID: <CAAVpQUCJ-ki_hf6YkRgnyZo3owG8JYCQACxgQ5u1NMy+o9EHbA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: reduce calls to tcp_schedule_loss_probe()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260165-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E06E17BF52
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 3:35=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> For RPC workloads, we alternate tcp_schedule_loss_probe() calls from
> output path and from input path, with tp->packets_out value
> oscillating between !zero and zero, leading to poor branch prediction.
>
> Move tp->packets_out check from tcp_schedule_loss_probe() to
> tcp_set_xmit_timer().
>
> We avoid one call to tcp_schedule_loss_probe() from tcp_ack()
> path for typical RPC workloads, while improving branch prediction.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

