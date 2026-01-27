Return-Path: <netdev+bounces-253678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HfQMpcweGk2owEAu9opvQ
	(envelope-from <netdev+bounces-253678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:27:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 771BC8F912
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3097A3031F2A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA630AD1A;
	Tue, 27 Jan 2026 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3MdyL+HQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3AF30AD1C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484434; cv=pass; b=ERO9TEI8osB4tIoPq+LVVPbwxZDu/YTfGACZnoKbBOSUA3BalZTHl3zHhxn+GL/C/iBHcyR8JTueF74LUxrAn4c4oWfaYctdFp11bj85Tdo61ekIHcRM0Luq4/XwQqAmXL7W3fznJm3pW4OkfmC47093lJWVQtcb++FifqJaxUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484434; c=relaxed/simple;
	bh=pPmzWSGpxZ3QaHaPhkHu9zNRrfTsfY5Blv4YR9eDfEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ1wM2sexCBXJg7vPag/aPjUW7iZDbuibDDaH7ujqT89plcOF5dSo9Mx0gKTAdpBZZoIGnLZaxp6/70ayZpp60pgbhBbuO78cyUQLGxb3WJrMr7mPsuxgs9nPKazxGo1khVXo2qK//kmOa00oxLG4YB+PZtaUNjgF1gOG0t6Lag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3MdyL+HQ; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124a1b4dd40so52243c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:27:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769484432; cv=none;
        d=google.com; s=arc-20240605;
        b=P0XiLi9xPfrEFdX9Z8mOdhX2n/y9rN6JEVcLZmSeoHB/KepySnV6TqFDslZnUptLrb
         nIxvRpnPCLvX3apSANqX0iJWX+UgaeOcOIkZa3iihVgNZnfAy6YCVUWr/0WPly1ByaXr
         aOdSz3DsNySHQXlJos8iJQecVDD8s1GvXfJlfC359OSP0DNaJusTNqyMNWwZhwDdTVCE
         ofQHKHxxcHYJbim9wV93RAiq7961285+aIr+baEuqWLtUFMfIvs2hLcEB5dxbuOaIr2z
         nkrWPuajsm9hcJb6ZFa2VGt1AjIQDfx1TPKO7sKHTh/W8zknQ020KhoGo8OXMT6R214o
         a1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pPmzWSGpxZ3QaHaPhkHu9zNRrfTsfY5Blv4YR9eDfEc=;
        fh=R8xzSPvq132PoTiTe1zTSxSXAw5BeAk1s93ZO+0jp7o=;
        b=G4d62l/wr194TtafViDIoFcAk7SERmheMxRpwyYM+6m04fXUGlOvLnlwoGYPlKJl+x
         sNVpKMEyboDOFAq31NPwunS1KIl+8vJ9i1KWTR/AKu1URZTBXivTPd1msb0HBfP5mOQ1
         pcvpeyWM3QZ3wFu7vZNF6M7gVzLJSUYFATpxeroMephoCL7+WjE5+mYLskotKskgxazV
         5ybz/ytEABmB0RUBnblt1jQCnhT/7i94db91XV9VZSWb0dhQQNNg/ZhYp7uPuNHEVoqS
         9NquKTi0ByRomj8Cz09NlgEItP3vcgU+J8xxYc4H483f8j/J7BQ0Xhi52F79MN0OvJm7
         WVTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769484432; x=1770089232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPmzWSGpxZ3QaHaPhkHu9zNRrfTsfY5Blv4YR9eDfEc=;
        b=3MdyL+HQIl0M1tG4eQLrnDKQP0FwZvXGdZZqzvlo7LpReXKkRE3bi6YTiRhvs/yI6U
         fRaK5Nwv82yDiM9mWT183naMdSd2CKFEviN24Mo2eZRFyfuk+ZFAFDubO0b/iXqRz1+9
         BgYGBOITho3++Ax6M6M/VsNvSjHbHKn68EOyptlsml+Tz1PFhlWSGJQR+3dm9zjCGJis
         01zJ1CrvmCIxwgU0dyUxz/2ZaEiE/4+tRdVnumKvq3sn67fnk9hXKM6WAszlJOGFBdeb
         kdu96RePy/rHl1TeNU3qHRHDtk4eY0CTqfcyOMJldbTRDfdczgET5M1OVJaR13Q3ikTE
         2a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484432; x=1770089232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPmzWSGpxZ3QaHaPhkHu9zNRrfTsfY5Blv4YR9eDfEc=;
        b=opriblToMWXMjYNTfRTiyT5nECJlxiR/Y0DaQ6hgGNqRrrSAw0V2Gdfgujrt4jnhic
         Qc5UzrrAA9c3n11hzjefIP+eiYTpn2q6vzZFfshAQfIg3yE1c4V5bPlCglzfO/HFKngZ
         OPGxXFvGmcdFXdulMTXXmkH/+BaszE6Z6lFklRJ9/29E6yV/Q74aTTF3kV8k67bNaPhU
         0mraWMRKyZZ7qhDKHZ8ktbRCnBLWOO0ucynDCP2wDv9wbb/+ZSfhyTHEfnzQnupWRJDN
         xg43+7bYgQgurLJlOY86g1kx02LeQGvCNv//DGWZCir3OIvon+0Yn/f9TsxGDxQmNGqs
         DmkA==
X-Forwarded-Encrypted: i=1; AJvYcCVvZJucxTZp9Yav/8yPcdx3IYP3GTbx0z9LKiC56dEeAaLcc5x1zVVEg9bKZFYpcIbW6lggC34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtofrO1q+/YpdAk7agjH4PxHWRHs00kccfbCmtXQbJ5AxTrDP
	Kae7ql7CjTxea1YeREOKoOMjjJXvOpR7si67w/R/j/1WD/9yOD+lEqkRkoZ15Tx+8jTYhfM46jw
	q6E/74UkDNynyGn7DopluaichNBSM3OjqXUGxBPuE
X-Gm-Gg: AZuq6aJw3r6EsX4F+YzylDVOw3lGJ7T0/z2NiLYs2KkjWonoek8iNKHU9aw4+dZban3
	cA8H8H9G+whTRJ/33k45mcRj0+AZg+li+wuT9wrfVAHDwLiCw7jsr4aKpmL9Hqo9VcdTL10GvT+
	qtdUlVhUHgV4M/8UlgM5UZ0aukg4XVWGTtw14bJ5VKlqdYixOeV9X1gjFJM6w/uOPtOBHO5CqEe
	tpW2tW5eCXvsb2L7DI3hiQQ48pR6WVoQ0RvHaJVJoY2odZBtjxuLEwOljNod4E6DITSjcIXJi08
	VwYry4oh7JJZ19wIq7jhbvaYNBiab6dlWN0icfjuFIVPE9uoMNgIfG403bK36l/26Wvu6k4=
X-Received: by 2002:a05:7022:41a7:b0:123:2ee7:7dc8 with SMTP id
 a92af1059eb24-124a00b10e9mr200047c88.30.1769484432093; Mon, 26 Jan 2026
 19:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127032147.3498272-1-edumazet@google.com> <20260127032147.3498272-2-edumazet@google.com>
In-Reply-To: <20260127032147.3498272-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 26 Jan 2026 19:27:01 -0800
X-Gm-Features: AZwV_Qgvw4_fVdCOgPXTwv7ewxy3DH8z3RQJyOKzi6u0-HkKhCwRGtCrCvUFfAY
Message-ID: <CAAVpQUAjZzw15Hi+DQ_DqmbTyt7cXPgyQO9DuzfpSLqDPgpdCg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: mark tcp_process_tlp_ack() as unlikely
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253678-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 771BC8F912
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 7:21=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> It is unlikely we have to call tcp_process_tlp_ack().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

