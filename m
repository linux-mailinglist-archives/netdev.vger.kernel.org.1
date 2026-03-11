Return-Path: <netdev+bounces-266609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOyMLNxDsWm4tAIAu9opvQ
	(envelope-from <netdev+bounces-266609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:28:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CFF2622AF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2286303CB34
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E8B3CBE8D;
	Wed, 11 Mar 2026 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xk1/SHJZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7972D3739
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224812; cv=pass; b=Bpiul2VZrWLylhhU2Pv5z8XFiUaC+NwIKCKWP83t+t09Pd/3n1gpk4qclKNdOPi6stvqJ9MQ3b84dAMhLy4MaGCcP0oLbuUGumBQTmpUbZcbuNe8VAXc9yC8A0WN9ninRvyeOrIQSDWrmW+u937045YEQymDY2aRgm9Bw4k2a1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224812; c=relaxed/simple;
	bh=eKf0LarMl2Wj8kangLrl8qGd7vnQ56basY47H72P2gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1XAPobJChsjACEhoBpqzGR6/cCd6Z3UKxl6JFKqfNEEamXXRWMpACxTRq/yMJhQAu40Dt/Zz4GUwGvqnkmnCnONlOWsks/CKUWNaRMYc3QPIbiHyzwfq1sP+LAZ36rrOPXS5iLYeD1lmKkB+vfrMk9daI5hLiTWgPPXCL/NAMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xk1/SHJZ; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5090c48de85so37483021cf.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 03:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773224810; cv=none;
        d=google.com; s=arc-20240605;
        b=i2mTMlysOmmTd8JoJj32KK1nA9R+L4G7iEhz16lvQwZWO5pdsmyhg8ILOvgWLBJTK0
         9oOeBQ5+FwBXAamID3/rdfU60RF3PMue3ZX6gqkHVvaAwGGrp8VmxDAROJGxEGIfajql
         0nh3gdM4USYnMvs3ob4lOr1efEDCfSNNPKLR4juvBx8yRtSURdnGV1pLorZQXyJD7rpe
         AfsmXM2Wu0UQh1h4Tzjljw7mKLRTjxkb3uPrWv47YUi05a/ptrpgHZNgYCWiyOB0rl5X
         jssI3F5iycUcxGUErGpoXQwiURdUBzWeQRzr8IXlBk8hmIeDWlQkptHzt7KHjSRCavLx
         YRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eKf0LarMl2Wj8kangLrl8qGd7vnQ56basY47H72P2gk=;
        fh=BPyBPwxh6PHBPfDgfRydhKKE88Ej1tUcft2vn0UgVPA=;
        b=KdSIpO5AupXQw+ka0NrTeNsfvKKeJtNqsIavbg7KpYPNanNW42YkuhT9Iadf4DSTZr
         DADvB4EZFXp9R1vvN5MYCwldwWsAwUIaHpctsLX5yMn+Xv3Yxlvs0OAI2Ih+otYmgApo
         tyYJjlCpZGoCnp8PS7u+ESbQvpfPqnAYumhJdQjuRY/3E8vukxY2nL4PAeaVF6dQgYXF
         qgtLhkmPhpmqQpnoupC9Q55bSDn+hIyIUqfbABu1VQzbC4BHuBEbWQcSslDhvWWA85VO
         cLN8fy4HKUH9S4k2LwRwoaY6E1XNe1ku6qjFbh1KbmkTwKk9TW8p1AkYNSWGTpH4C7yt
         /I8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773224810; x=1773829610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKf0LarMl2Wj8kangLrl8qGd7vnQ56basY47H72P2gk=;
        b=Xk1/SHJZ4lS07Ose926XBvRWQvwZEQoEGaKGfcKC7r8crwaxPf9jhXjYBwcUx8tQxh
         ykuZeH0BcMdKMihlMoGpK57Wei+izZLT5VhbGT/ECv2KjQHaY5vsMoJZf/BPlIz3ManH
         wvflFcn5SwUAlChMhYYBuasDZnh4PF6I6JNXwGPy8xUPGrXWzcDWIgAoUf9ohmYs3a4r
         miujbZKg25tb9vla7bfrwQAffAG/uiQyQXqpc1ldsQzQp+NL5iTQxzGX6EAvnnsryZ+F
         0dMbHQwvFEATqVZcGYoLNt3oh9VduC9arV+l0En2a8a/PZgpe8bom80faT7OcQbiz6FU
         oaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224810; x=1773829610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKf0LarMl2Wj8kangLrl8qGd7vnQ56basY47H72P2gk=;
        b=u/bBFDDDVLKslxot73blwl9uWUNxGkcBxh2jGx6U10VpjIQEiwlRCgy46/SKBvd4ob
         gDDiI8F3QlIj7JJ0jLTIex6L5abtzYkLkkZLebX82lYmupqmtXPtvbFMjNcC1wwKdaWF
         kE5x9rKsRf7ofRORy8h5Ovkgeij9Y5wpiOtensO11bULxV0ZCUFDJyDKh/eqBlAUU4lM
         OzL2ne6qNe5fvRpIPzNvMT6FTqUDAwWAb0tN4YU1/H9D+zITs+w2lPtS3rtb6kCCGYkj
         FMLHT8CW1cbfo0X0HVkmX1o7O2fgutteIBBxehFiu/RkEs5VZWfbQr3auakXSo+TY4eM
         X+Og==
X-Forwarded-Encrypted: i=1; AJvYcCVgOBOBKnj5u5m/NH94iDFAtI5FbHOhrkPnSgtl5adR0zxVrsKjMCSMdEUMhsvyvtHyAPQMGo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4C5vFq8wrprMqYzMssPeqOF9Sbi9/ja1e63PpWs1F27hIUJcX
	rAINQj27LaxtaSUCjdgcnBdR1I5F8cSDnMtBobsiPPFmFYinucLfLKSaABVJcmCjvVShZ3MwyuN
	jsaLfy0cX2xNUcOYdcbcXRDbHn8+l1jNsb7a4foio
X-Gm-Gg: ATEYQzyFHco05eZf5gLf9TiUOHL5bKeUc8XvKvhM1IX5xqgRjN2ZnFjWV2UWdXKvW18
	6xN6Scq37hCb1/XkAl/W7S77PyUHncSy6U4qdpUgT4IP3svaaMmmHPubsgLEj1RR7doj/VWpSzQ
	Uo3EmzYOQGEzxC2Qcc54xC9LDR48xPeNZyQoJOC/i1E6ZwENK+gO+lLuwC/ZuyhE/z7n+OHYdiV
	+kL3SMAfFG62taxFE8LwLk+zvb5mKoazJcD7OeLJKE5HvBsc0+CO4p0vP09i92Fifm6x7abvgcF
	HE8jA82l
X-Received: by 2002:a05:622a:178b:b0:509:2d50:9788 with SMTP id
 d75a77b69052e-5093a0e7234mr24295631cf.32.1773224809745; Wed, 11 Mar 2026
 03:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36d7f2e7f504d620c1b88526b25ebc89e3cb61d9.1773142315.git.chleroy@kernel.org>
In-Reply-To: <36d7f2e7f504d620c1b88526b25ebc89e3cb61d9.1773142315.git.chleroy@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Mar 2026 11:26:38 +0100
X-Gm-Features: AaiRm53B50GTY8UnzKaLcgodqwhUvO9jIfRzrYAFDN15-xaW5BZME-8koYe_8EA
Message-ID: <CANn89iJWkZTpM-5ymgDBztx-Be_maV_Ugv2xHdSHZVybfcHueQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Convert move_addr_to_user() to scoped user access
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 40CFF2622AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266609-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:33=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> move_addr_to_user() is a critical functions that was converted to
> masked user access by commit 1fb0e471611d ("net: remove one stac/clac
> pair from move_addr_to_user()")
>
> Convert it to scoped user access to simplify the code.
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

