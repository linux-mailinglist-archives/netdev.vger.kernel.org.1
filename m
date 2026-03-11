Return-Path: <netdev+bounces-266395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMA6I0a5sGn0mQIAu9opvQ
	(envelope-from <netdev+bounces-266395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:37:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76870259D7D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A07B302BBCA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9636605D;
	Wed, 11 Mar 2026 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz1k53Z0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B113644C1
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189440; cv=pass; b=R36PeWOsX3B5WNiGSzZDU4k2lSA0/EVTMtKA6/quwfjL2Bgj//fTLZXYWgWHgcDdQuP1o6mBZoMbJas7ZjoINMUxRVce2J6nrF4nGpvffiasavgFq8qOvcmzGiQ8FZ6eyoFWFPSDPLhwcu2B82+NEUFeqJ8889yR/miTT+U0wjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189440; c=relaxed/simple;
	bh=qB2Y9UmS3AGYwZt5ou15zHmd+DF8TtbO3BwMKq5EH/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imh1EQdGXzUBwJSekmAxrhaNSSCMhBoewIkf92dQ1j3aoM91D6QEJaYHNbljJdZBsy/X/uOSFKUWrd1EyOomDatshR11bDckE2RfzOG7yUgoIYKsPIY2A59SV2/aCzc8k0sQB5TubyK2U9r1WkliXiubQ8agvVUJlHaAVdlw82E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz1k53Z0; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so8149702e87.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773189436; cv=none;
        d=google.com; s=arc-20240605;
        b=QOKvBDwTUvtr4se5Hhq33f2oB0l72dEbYjaUwcUlQ5fassBcK9/ha2qIM27xzsJ2ot
         wHnIEalNpYNsB4BofSki+j5Dou0oP88K1i7RYzix7yJt35TSHqdhC44qSZr2g9r4OhMd
         ExGtqtGJDlWYUW/qJhF5zBDbkqeEkDo4P09GCDbbFNOYaqJieg52RHYdXTvXffP20HCV
         L+dEtBB+q5AJ8kh66rbxsj75OoyvSxAYqoNhWYlGpsEauyAkYrsjIexYRCrCv0EHRIKE
         dqyxR20ORQ7Qx92TwbMxaizyt/bWG1oMgkauw1EkX+yE0r2kackKcQ8lKb8ySgiev55S
         N8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qB2Y9UmS3AGYwZt5ou15zHmd+DF8TtbO3BwMKq5EH/s=;
        fh=o7U8UBNx2O/SNASv+IGw9Ra1fhO3i7vf01pihjE8er4=;
        b=josHsEEWA1oz2RKPkvmKWdARMJm06HuwwB8gece6rUPwb7exL2lPjeLAKB2ntgFji+
         LoZU3r8korkJSZSb1dk8vNKoaR2NFqlHtTIGTiVlV7zZFVIDFI8iOWPvQtWrbq9zhnHr
         x73YqrRyRrAxGoH0YHTIyzX5BmKbWdfjIcxLPrdN2P9VuTAFFk2Jq0TMRBK/sa29+ULb
         0cixfl5hHuzDf4ZsgHCqkpvF9++60GttsW3S0JmHEi377OVJFeAPTQJvF0XjmK1SrrkY
         NE1ApFUARt82zZdmgcB9wuaL4AQOp3qZXmKybD7F1Y7+uCqmMR2atslJjMBZeVhLG/Tm
         cuOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773189436; x=1773794236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB2Y9UmS3AGYwZt5ou15zHmd+DF8TtbO3BwMKq5EH/s=;
        b=Jz1k53Z0FHFzA49AV7XnVztSZl2QXneLkgTzK/MyPWhwiOIyr5ez/yLelhxBPE88vq
         c48T4eExpH7cZL0OEOW6Mno7DwSzWEJrEllkGGIGIF/DuCaMyd+Z5otFrMuFo8OZJR0Z
         nFIGi3RcFjEDDT0Rl4mGzZCPsVoIGGCi7639oTdt11RmHSocCnnUO8nBYXHN15fU2VN1
         2jIRYxzojHQl3pHhLoAkApl4YmqkyFFt1/yRxoHBE6+PxtXhwYO3fKBzWwzpMkPznlc/
         1O1zyJoD7AN2JhWmHiiYrD4jVon3gOckWF6P4iBEDav+mHioddVwbnLCxbfhLzt1VNqk
         ksBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189436; x=1773794236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qB2Y9UmS3AGYwZt5ou15zHmd+DF8TtbO3BwMKq5EH/s=;
        b=BTHm+qNudVkOwiyfHXVkk3v4+gJAvULJubOoO3J6U9nzBeMaf95dRp8t3FUNp5AFtO
         lfAKemefvQkwzvHbSngO9zgH0BP+Kzx2wvXyy6H094pTASuvnCr1NjvrFsxwAlKT8YdV
         h4L1BuzTsh2sx1S6HjozGyQ61nrZCuAevrnPZwpN8QLtlOz0MpYff1mG6tT9CTfahTlU
         tN8AQTPv68Y368SHSYjVTf04GxR0sd103K7DLO16cNwZwutkoii/RG0vzrSoY2LcHhud
         0XCT0726Xvy2QvTMYf3ZytWmzMrZ6hRZ7zC5lUrDcefz9IF+JYYqBzq8619dh/WbjJeo
         uVNQ==
X-Gm-Message-State: AOJu0Yyl/8v04DPDDMCfjKE1YiKth8XlsXmCUsuBqxN7MeK3gRG73bhZ
	xUEJr6CuCEOh2uWtSZPLqM38CQCOK1nxJgDXAx5Un856uBF5JsPQ3x/+ep8q9vLJM65NsyuLJep
	FuuQKfkyGXyNrfm81jwYJC0Z5BEPVHb0=
X-Gm-Gg: ATEYQzwSTTPa6q6SMhPMHOgPoC2076puvB4FOCkz1vfw+WjPXWDAVIUfAC7Lnrk4PSq
	C9NsZNsWzDHOLtmHj9sjaLY87CHvDIyEE2bXZHVPsZXBPLcElcz+keLYyycfqvSgI6KmUrEkKUf
	M2KgUSce2IdcKyUk+ujJjTAC4kDEbONaCFDVd0O7wn6LKPdSrRVuG/ZelIyQKY+nByUlhogfWZT
	Q8mOkFUWILceNxGbAnQyPRoWKl0vvwMbKKZLLmAkhcoeO+90CXGHX3rYl89bqtQKlitIQbYebeS
	EkkMeWQ0O0+Lrry9dQ==
X-Received: by 2002:ac2:5b52:0:b0:5a1:3f63:c7e2 with SMTP id
 2adb3069b0e04-5a156cd0940mr124426e87.26.1773189436194; Tue, 10 Mar 2026
 17:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 11 Mar 2026 08:36:38 +0800
X-Gm-Features: AaiRm51sHV0zYJIAPWsSjsEAUdn-xyam-DpjW4gRVLnnnDHvbN21UgXe1QQXnuM
Message-ID: <CAL+tcoBmggp7USbD_n4oq3C1rLduejPyn+OgSbV_H-7vhyndmw@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 76870259D7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266395-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 11:04=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
>
> Adjust ZC path to follow the same principle.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

