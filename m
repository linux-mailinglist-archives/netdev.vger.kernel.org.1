Return-Path: <netdev+bounces-286476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEGbARWDAWq+bwEAu9opvQ
	(envelope-from <netdev+bounces-286476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:19:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 817FE50903E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0A5F3013A69
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366BA26E173;
	Mon, 11 May 2026 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eU92w8Mp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91930BBBF
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483819; cv=pass; b=JxdJJJtxrDVFKoiufgoxMq8rG+dKRv78R5JCLWgj4nz6j6vKn/DUxRaN97SmHTHxAjMIf+ddrtcilENSC1N1eyPI/1DTcoWuPg4T9EIBRWKmUb5Grtw6WWJ+rUxXASS90SJMvuw4J2XnFrgkZsiiqZvFeTSsaUehSzqydx+pMq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483819; c=relaxed/simple;
	bh=gB3ssWzAqZEV5huRzXsa37RW7HSN+Q8iFRQ6Qe1IT/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhEiPn56sP8VhXRvqXPod6Pb+F9v7z9w254b9Qqn6HR9sDJuoO9Z1DzAksJ5LgqHfwWwSMFtRUYy672Pz8ocOxjwMEXj6DVp4/5kaTZaaT09j6vcb2cKFkuSki9rHy+A92Ko4fjH7flnG8Sae7ktt/d9kIKFW/5ZiD1+d4ePtXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eU92w8Mp; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d75bfb259so25778071cf.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778483817; cv=none;
        d=google.com; s=arc-20240605;
        b=XfLuLAOAgmDdvljMPLrAi2IfEC4DuDM/QiRHV/+Bnfe35odbzxXbG2ZwoIGG0A5scI
         ns9HeCXdfDArEnDiYOrN3jqQaSTCcwwNaMER/NxBs+/dzA4q2Kjbi21Js1SeeTystrtH
         DLs3pXd5lYyMPW3XvpDAV7DpDi2N1EhshR9YkOhHoHoeoEoWe0L8QoLsREdk6YLkShuq
         mnTE3ipLeJWUIBTQdBVCleA48ck0yl3fmA7lJWHOZg4YREJOc0bE/QlL2y0R9V0CmOQJ
         FU4okVO1dRjUNGH2XsVwAw7yFCRKtqfpw/YpDGW+CxVtu1HUqHuROM77npFCrMtIrlo3
         4CYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8XGLE0Lb6oyAV1QhgBO72k5Frf1S0m4rmMmZM1kfrHo=;
        fh=UzbFPEjrXCgSJ+8uCUouP9Fl6UDf2dh+pK5/AKhCW1Q=;
        b=gAUqckf3V50Ssly1wUdQia3EZPLPr2EDcYJZ3lkupc2l1iBiVqfB1p9tzcoBRdRvar
         eDY7CkwJhfH5nXBo0V9lKT+LhqSOIR4hV9m/3UPSjmeIxqr5YcRgu5k8PhAVuQAbBO5y
         4gnF0wP0dAAltiu8WUa8vV45UFcBwMLLiD3RXXIe0CIUmbxN+PeeVoooEZmx6xxRuycj
         J8y7Sb+L9GHCfi6ablrcSedzHaKRxOzjpR+p3nfLmI02lLnydz2GCsgDR+3S5M0GYHBP
         vRMa/JrOtIrpA9RcmvhL3ycQZJjF8TJZgjD8fF3z6O4h4jsLRWcqB4ID/Igc/FzGW7F8
         RBEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778483817; x=1779088617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XGLE0Lb6oyAV1QhgBO72k5Frf1S0m4rmMmZM1kfrHo=;
        b=eU92w8MpVuo57aNprvGNLumbMLhIAx1QFarrkrG7gpWvbnUM6zuzXp/pFwnr5u21Ir
         3C6eX+VzFzqgRU6tsNQwx/Gzqohp6qfjBnanHP70IoQKftuWyU+Kw2oJmeUZRjvnzITW
         zLqvkfbwJF2t7bWF1bD/eE8uFByxG/8cxl9Em0j9YjNyB6FZXCX1XvbA/cGJkaWzOEab
         UGO0mfk4x1lEwilgwaU9n40Zu3Z/WtmTOEm6AKbBzxsDll1/xTGrMcF2/2phdbwmQ1JR
         6sJgsgQg6xqJn/A2PZ4RWiGLi19/MkdOk+s4KsYOyVI6WN89jlH3/ujbFhgYrvqMMBBM
         RHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483817; x=1779088617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8XGLE0Lb6oyAV1QhgBO72k5Frf1S0m4rmMmZM1kfrHo=;
        b=Nz6tKLhrnSSHTe5sieZUflw0OUPAoKxht397eA1pC67cK6ycKZOXT6UXdNaCJcGx3x
         1MbPHCWa9bqEwvteGIcmH4S+Pm8bkjRbO5saI/JdoLbfj4L9V4F2Y16pabUI0ckjUAkm
         T8oGIFSkv3DStkPZpniTJfPwbCIXkxJOBtqEixHyWbbMe+udm/aWdUfUdegPh4wAcFHj
         iL7vFjjUZ6zN2A9kH/2/nkzGl8ooWLmz0JvCf8LNxe0VvWlX13Oi0uWAGxSMUMag9wGh
         mg5c/458uuAtaJP4rxfLpRM1QiDgQYdv9ZCDDGO2wMP0Mw/RZm5ls/vWum/MPMekSXiC
         mEdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4Y0zLI13go3acgppHrOcSsaAnpg1kymy5XLoZ5Ikl00te8sPZTU2UcOmaTroub2OBmQybVqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoHkkoTnl5KRsHOszDKkH8DDnDUEIkpJxzCogANchZMDwUKky
	NJcnMAkUoSIqsEGk8bJ+IJy3kYUL3wE0Nt0Bt1avcq0hhCiORs1+M4DOnlKupVpLtq2S1xRIRzm
	7/BXwaFTYniFYhUnvha+6LD0CRUIskKC8QzAOJGAU
X-Gm-Gg: Acq92OHZsBVWd5UrcoV7sr5QCMbD7wKYFjP5/dRFiMaMs1BlDuUAVej4ZIopynWOxsG
	OeVwAVj/JCUlqh/ANWsM2px/Mr226SkC50gggQmt9pxZX0qE3IR2jEMzS4zmP2jwvl+/CdoyvEL
	jDPty68aCwdoUM1EIp0wymaHY/dxfp0Twwt8F9HQp6HJvvw19xiXP313n8uNZXs4Y35iiJ5qJBe
	RDs7lXGx8RFKxif2MbImRu29JVZ5sPx8KWHJ0Hr3l0gW+ZmLaoIX8JTDnHK+Jw5JBcIy0Lv4X4q
	/TQQrOGerisjMXVdc/SEPIQdmQi10C55c6ZN6xUt1lXArGUShFslbi3mdEgKVrXSfStVjkk1s32
	vn0I0X3U1BdnvmiuuQyeI6WVuKs+c
X-Received: by 2002:a05:622a:558b:b0:50b:34f1:6309 with SMTP id
 d75a77b69052e-514621c7dc7mr308820361cf.49.1778483816178; Mon, 11 May 2026
 00:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507084305.2506115-1-edumazet@google.com> <20260507084305.2506115-2-edumazet@google.com>
 <20260508151523.609cadaa@kernel.org>
In-Reply-To: <20260508151523.609cadaa@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 May 2026 00:16:44 -0700
X-Gm-Features: AVHnY4JRkK2VfoapsRpfMMSgwumiIvw-0AJW4CWku4xF52ZXB5Bz_8Kb0eIzyKI
Message-ID: <CANn89iL4EHdJH4Oqq0RkmtgSu=4EB6r5L9v_ig=3n-8jwCOhoQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: constify sk_skb_reason_drop() sock parameter
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 817FE50903E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286476-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 3:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  7 May 2026 08:43:03 +0000 Eric Dumazet wrote:
> >       TP_PROTO(struct sk_buff *skb, void *location,
> > -              enum skb_drop_reason reason, struct sock *rx_sk),
> > +              enum skb_drop_reason reason, const struct sock *rx_sk),
>
> build says drop_monitor registers for this tracepoint from within
> the kernel, and needs adjusting.

Thanks, I fixed this in V2.

