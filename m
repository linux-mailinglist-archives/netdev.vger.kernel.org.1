Return-Path: <netdev+bounces-301099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qtSHDaQsOWqznwcAu9opvQ
	(envelope-from <netdev+bounces-301099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:37:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6D6AF7B4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:37:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DywsyroH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301099-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301099-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51E933008478
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488743998B7;
	Mon, 22 Jun 2026 12:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209B379989
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:37:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131869; cv=pass; b=mFQP8+BpSuo5dr+UEbnPAXlIOvCLLGzYIozd2iG6IV4xBNmGKtZfuIIUbGOsJWJTckOIAOZpRPh5NKnYgy91sTkgdffKkygzoG3qMUYOYdsWW/nadoV9jZE2hZCK+LZFRoG8kh1Nq8RR8FSbsyVTr4qL2JLNNGx06zBX2wko9nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131869; c=relaxed/simple;
	bh=yVGkjqvmlroFVYq+lNWbLf8LxS2yQUyUIzWsBX9nwuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4eW9hzd0RZiHT4mHikjqPaSepEIhfViIOJc8/OsshdgFEYrIqPg9+lMns8VTJ7CaBOiFnCineg8k8CbH5k9muY1FvEGTM6xtyfDF4ovNoRGNsyrhXawERc31PYD+to9DuEHdwKbkx8sWUtSUXyhIFKkAidzXTsszDX71IJFgEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DywsyroH; arc=pass smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7fdb04d774aso45933117b3.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782131867; cv=none;
        d=google.com; s=arc-20240605;
        b=ghPnjQoVML7d8dsdqG5Ca2ZcVzEFAWbaYH5m59UaVTN32MumqVfZ6vBNAG3YWsuU6e
         Q6yb+baeiol+b53I2J41vBL9u/sWso9k4dBFgErEHlOAb8pMeG4INg6TcClwOxUptqXK
         hq+8CVeMlVAgDOp9ZM5470cjAOyZKAHwdGImHgyxiUkqiL+mhI/sWEq4uQ0rvCQCZDaE
         kMxBmItBKxny7L7i2SQIi///SMH0Q/076urvdneNL86rtnIPmBTqi8e9kwPRnoSNp00F
         B+VlPwCgH88Lk1uGIoXIEEjGnTst4+Aqu1I7f9WG2ahWTYHjIbBFJZ5OCHbmEAIp5joP
         Ke+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yVGkjqvmlroFVYq+lNWbLf8LxS2yQUyUIzWsBX9nwuo=;
        fh=R56qpv2Hvky4YAd1L29cQoQWtB3bwfi0h/OJ3eSPIQI=;
        b=i6oqXMNMpc9Eh3uNTdQoiqE2hlJFxYnLAoWZ4mKRLJ2I7A6WkEMZ1r+v+xJOwK5NXI
         sVpXYbplkPfU9bqQb4KZEPpfOpFmAIw3V4cNmKLz/TXRrvPOgWIRd9vWwjzhM5pFh8Mc
         EFduHh64DXiQXjP8SBbfd9J61eZTSJAPulica6AGIMPPBPPd+8YJp0u98d1L4jmzlufr
         esQ4C16U4wrSxJDx/czN8FpSKRTMxR30mEo32vzPaAO79/RigzgrpVSHCoJE7sxM8RZb
         0HE2Vr3kWGDoeLKKKqvb83jJKwgyenHt/ON9yGzjC8u2JcCpw9R9J9FQph+/EIwo2loz
         0EhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782131867; x=1782736667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVGkjqvmlroFVYq+lNWbLf8LxS2yQUyUIzWsBX9nwuo=;
        b=DywsyroHd8tlfSUX0fa8e0WEShS6L/bK+vIBXvUCI3ICue+cyoGmGb2+Jh9QmuN9Wn
         x4JES0Ngsq1KtWIpAL8uTWWk3vByXvdVAY+EteL8lrIsAOxfBZzUyiN1FTzEle6ufPpu
         Rvhq7l/+87xakSlvbu4xXMisAUBporh6w+WuWT8TRXuufoDLAMZY3NYHJFrGq1Eou6rx
         +vL4c7UtcHE145zXFyaXtfvBc54oE1D5FkqsS1pVgMPVhffCc+USy3o84D/vh2veSdr+
         6KqcuVFUFd2TY4K15yQpF/strI5A/RBsIMJLRYibtfrCysOMzD1xR02rZecLU4xCoY4W
         b4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782131867; x=1782736667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yVGkjqvmlroFVYq+lNWbLf8LxS2yQUyUIzWsBX9nwuo=;
        b=W29wHU9UcSfsEMcTjMY5+hGUQrbbYk9tlNxHGtq44LA5kfOHLGqwa9nl+hg3v9VrUr
         Nmz4z1bSFoz+aWF37kE48btRpQIWdIaenvJM3sqYu6FKHcm+f/SDq0lF5Qcy6H6yreJW
         35U5B3A5gg2ho6voKeHN/2tUlrmJ20xIu2UdBrvkBQoJ2PUMazoCR2gKmQWlhe/afNgb
         OhlH03gJkRfGlywMn64vdGCnwbTedCKtbKwcSpSOmzIOUIeac//NVLNI+W5RXBJZSVuO
         uUxtbjAE0ME0BiW4Cq/j51qQih84zm0QY5SQrSGh9nJvjuIQgxCuV9ay/fwXVkrTSttM
         sDtg==
X-Forwarded-Encrypted: i=1; AHgh+RpaUp6BEsIKTUQ0YFK79Ikrp38JBDUqSvZCWFsHkG0r7D6fr/zUFoyBJTEbRV9yh0Y8k6SZ/Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZA94hS8iPoGjCBScK7m1rtGp1xnrUDkA2MWT8BuGXLrINIfmS
	DvulfACRBDLeMrbzvArG/Q/hMCE4SAb16mlXP7liwW3qYXbnVew5QwK8jkUSbezLg6A+lRJbPtb
	kow9AG3CdK+k1KLE21ipAaOJvhsvOpkw=
X-Gm-Gg: AfdE7cn+24bQSh4B+43SaGj4Sv9s/ROVmGJQyXw4AzD8nAR9lVnSQVnawwrtHaFl980
	mAJmoZ4LOwBqgSSXC6QWwPn/SbFb0v2S3ye4Vth+pLY8vFPJG9T2gZsuzwjIcEP4w7lrQu9yosk
	wCel/AVFY/0jRC5VHA9vmmoi5iv46o2YzGWhsfH7Fd2UBHznXrfKRno8WoUoxzUqkAt/QkPFGj8
	lYxLMR5+rpnX6HtlM7HUD82blZDN5YNwkk5kE9pil/NgCoS6he1Dn/NaOF4ORZ/tHk648Hn0rMs
	G4tfldo4VBtA2+6MEKGki5xqOw==
X-Received: by 2002:a05:690c:9c11:b0:7f8:7e50:638e with SMTP id
 00721157ae682-80266e2f160mr89775467b3.48.1782131866911; Mon, 22 Jun 2026
 05:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617123443.3586930-1-michael.bommarito@gmail.com>
 <20260621150011.33c2fe80@kernel.org> <CAMArcTWH4a_O+V8aJ6QvnLT1_vWxeC8yF8LuphKt_oFH6nBkbw@mail.gmail.com>
In-Reply-To: <CAMArcTWH4a_O+V8aJ6QvnLT1_vWxeC8yF8LuphKt_oFH6nBkbw@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 22 Jun 2026 08:37:35 -0400
X-Gm-Features: AVVi8CfM0jFsyiOt4Myax0yVAXaEurK3G0bEj0eiIWDUzx-n4lN2oR56tuiGfQY
Message-ID: <CAJJ9bXzjp_Zrkb1OjWdrLyPYuQToyYq8fhwNAYtoMN4ZLoeEFw@mail.gmail.com>
Subject: Re: [PATCH net v2] amt: don't read the IP source address from a
 reallocated skb header
To: Taehee Yoo <ap420073@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301099-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ap420073@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32B6D6AF7B4

On Mon, Jun 22, 2026 at 4:58=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
> > Let's fix them all with one patch?
>
> Agreed.
> Michael, could you please fix the remaining ones Sashiko flagged?

Sure, will do

Thanks,
Mike

