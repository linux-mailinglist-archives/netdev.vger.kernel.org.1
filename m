Return-Path: <netdev+bounces-305860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /jBnFIJqTmoWMQIAu9opvQ
	(envelope-from <netdev+bounces-305860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:19:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE809727E5E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:19:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NLKZ+p4j;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305860-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305860-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60E763100D4A
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63706439346;
	Wed,  8 Jul 2026 15:10:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBD43933A
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 15:10:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523444; cv=pass; b=HhXqslPOKlbhB5YVRqPuXv+rzgvhQFMcVwV9+mT4UqlHZidnZXZdcaoXFZQzIgX26eEM9+tK2TCOHJOcktkPfNl85sL6Ps3DERgqqpeyjuk4uykBX2tZ6n7y4ARP7R2fy+zm/8m75Gr3ZVtB+sepVjD/wHi5FA5Z8XJRxkdsfMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523444; c=relaxed/simple;
	bh=DKA/jc8TJnNKFhGaT1WcKh6dc6W1wcKepNEU0ujgJbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R60UjGBAJo/kz3/kLjUeED4fcWb/wCgDr5bL6bL0pdXPgLCX28g5TyOxUhWqVSFCjjKm22KjU7GAj6P7P4dT5ktizK3bMuO44s2OSwCjwvOZdkP7fqLvoH9pIdZpgBMnRmhsfwOh4m9u6P6qdb3j5OZidurT3/J7vFebSo998fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLKZ+p4j; arc=pass smtp.client-ip=209.85.167.41
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so453320e87.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 08:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783523440; cv=none;
        d=google.com; s=arc-20260327;
        b=cOi04y8Cp2DRSgrO+97i3TvmkyVVIap8c9rrWZgeiVJNXVmW/hVnrclrkNwiZMWJZK
         nYFPCr8RIkW2JyF2G9N48OAJkyyrAm9eJ+UfbJSP8NubrwTh+AvWfWR42naO2BOPvYgU
         tMMp+UC/kgaIypREiJ2SfP3St+tRVTJ06fMgJ0bGaEx8MRMLSGRLPGXyJhrminQsTY8d
         9fBC0QbXqdiPq9zS/DOVClOIGkDikTgg6zdF/3zQZedemqyknSMODKSP68W/1NAlaRMt
         dTbUSbRpyI3XGq4y1lzY66dqHClg9GeRRsjhsgxIxQd7/p/iMR97UldhyZPEui8hMh4k
         58dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A2hykAy9k8TdWvhrQ5IqAWizxEj+ACK7cu0kIr7bqOo=;
        fh=cHjLshAetDZG6wP29HSFCFgWI0I2mVUvltK8w3j/UGo=;
        b=ryyFMlbbfsVTyfy40tiK0mu+1pIiguSIcDHgrSprwK7G4dIR15t0VD5/gR87ebYlkb
         pf6Triwe48s4uA/FdFqxDvhVmqkG4vSh1z8DulKvm6XvkpC6bKZ2qg7RwFZF0UupTgRD
         Zp8TY2MKAUOgeZpSRezrA54GlAkXkR+AhjPl+frJMe3d46t7b1s38odGu9/tq4hbBm+E
         4KJ/yeI8ssq1O4x0pxj6YFtywNYHv5eTE88VRXVuJybm1XqaynqHf4kWVKEa3ADSoIxN
         uRh3gP2uywBs6RGt4vU9AMd+MH9qTSvpwq0Zk1Jph78QPxIH6n6coFLKi8b3gAkCydCu
         BmCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783523440; x=1784128240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A2hykAy9k8TdWvhrQ5IqAWizxEj+ACK7cu0kIr7bqOo=;
        b=NLKZ+p4jMpEJL71B4ThUYLWEtlGK2jOjskWMddkv/otVwm/7tBgcQQucwx79e1dyvZ
         BmIu8bJ7URQPBpmkaKmVc/8p6TBRgnA+BqauTHWT3TLWd+dWbm3IbgWj94FNZNAy3YFV
         2c/rXPu2Qim5jqOkwbMegg7aqSmuHtzhEAFR/NCrDBEs7g/9GOw0D7u8OYKCQvGMxQet
         CvspKIsuDwayP9prWWy4mXAx1RJu/+ly/L5ciYVN+3ox95OYKi3viTBrEAt6kpNzQsbo
         5SXQGC2Y4jJxraworcCE7y3wgDZ4Re8w6PfKK4/Fial7BA6eoZKnmVfi47vNOqRebDwL
         veKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783523440; x=1784128240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A2hykAy9k8TdWvhrQ5IqAWizxEj+ACK7cu0kIr7bqOo=;
        b=aTQYd2Dcrq4kOv4e3W3aK6YloIXKmf9x2s8MSf3SEDPbIs8LcRmGbzbvkhKE7arvTn
         yQl79eXz6o1SksOqGCcawFDkXTn7KzHIA5RzvjrIRBfvR0wCKKfvWNqsgpOV97NVXx8E
         ooOO7cWXmNBr45S8HUQy9ENMbtX6mG/Kg3VJeD98B4GLz+Z9AcCinhEbKUzaq9H7WENL
         krzJOIGR6NiTQYyOgckPnX4vOy6PX2mZ6oM49GcXv3PIbZXFB76juMAptM9DthR83W2u
         LGOytQyN4vA+k/4Ei5NWCvQykIaL7QmwM8OY7fasCt+5TMIaAEECfXhc9XIjCuiC+VJw
         fQSg==
X-Forwarded-Encrypted: i=1; AHgh+RpzPEZ/taiCVnQMfKnE9cTnHnF4wsHjtnYY83qVzA4S8uFwvvoq+kxSGg+nTqJwF3O73ppc76o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9kgbANPJtruulxK8hxp+g+PVQkqlUU30yJfyddfUrYC/fCCm
	XEB7kD1rQL2ufMh3CSK8ONoHK4bqTycJH/K39YOWKf+xrCKYW+kOHtUAMzyCS3pkbi9IEDxag7g
	RFn9VUh/mOtEoMlYRNcngsQkG2Sa590I=
X-Gm-Gg: AfdE7clXSeX8Pfkpl2rpmAMSsLkwZI8c5WIswbXUUz/mEMcm6S4WNwG2u9DGcIySUgY
	P/7NEDLsj6suzhNy/Wb+2ekRlrA59ef822x8FGDf24PaYzMbNqKz9wG+CFNxmNn87pwkOj5x2gS
	EvyV/ucbnGIs76ZADN0SDvi6khI0m27hADvPK2CFIsXBjYfx3GfMjt5zy6EBFXgkXfWOMrSVi5K
	ljXgR2CqOUFJvV9ORjieUw7xkStLVdWTAU3VIT9QnoHDYJNtxPsptCQ2RZal0kyqxeggVwGgkEx
	DbMIeom0fPxoHdzLdxKH+POsA4eq9uN3oKlmQCFJCQdI7h7SmbwbZk/p
X-Received: by 2002:a05:6512:a81:b0:5ae:b5d7:4b99 with SMTP id
 2adb3069b0e04-5b00ac2fd7cmr1762971e87.0.1783523439797; Wed, 08 Jul 2026
 08:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628210026.129941-1-meatuni001@gmail.com> <20260708130534.GA1481798@horms.kernel.org>
In-Reply-To: <20260708130534.GA1481798@horms.kernel.org>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 8 Jul 2026 20:10:28 +0500
X-Gm-Features: AVVi8CeK_I9fS8d5VbnhtSRSfLVJmMl2Kt_hq3MN2NnmVxurt42eg_sUf8N-xeY
Message-ID: <CADqcGBkXtDGMsQ6XWYeUyuS6qL8DCHeTNxzbH3s=22vuvBfZaw@mail.gmail.com>
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds read in activation
 parameter parsing
To: Simon Horman <horms@kernel.org>
Cc: David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, oe-linux-nfc@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305860-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:david@ixit.cz,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE809727E5E

Hi Simon,

Thanks for the review and the Reviewed-by.

One of the issues raised by the AI review (the NFC-DEP general bytes
handling in nci_store_general_bytes_nfc_dep()) is already addressed by
a separate follow-up patch:

Link: https://lore.kernel.org/all/20260628214929.135152-1-meatuni001@gmail.=
com/

The remaining AI-raised points are independent of this fix and can be
investigated separately if they prove to be valid.

On Wed, Jul 8, 2026 at 6:07=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Jun 29, 2026 at 02:00:26AM +0500, Muhammad Bilal wrote:
> > nci_extract_activation_params_iso_dep() and
> > nci_extract_activation_params_nfc_dep() receive a pointer into the
> > RF_INTF_ACTIVATED_NTF notification but are not told how many bytes
> > remain.  Each reads a one-byte length field (rats_res_len,
> > attrib_res_len, atr_res_len or atr_req_len) and then memcpy()s that man=
y
> > bytes from the packet.  The length is clamped to the destination size,
> > but it is never checked against the remaining activation-parameter data=
,
> > so a notification whose length field is larger than the data present
> > reads past the end of the buffer.
> >
> > The sibling nci_extract_rf_params_*() helpers were recently given a
> > data_len argument and matching remaining-length checks, but the
> > activation-parameter helpers were not updated.
> >
> > Pass the remaining length down and validate each field against it befor=
e
> > copying, as the rf_params helpers do.
> >
> > Fixes: ac2068384034 ("NFC: Parse NCI NFC-DEP activation params")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> FTR, there is an AI-=3Dgenerated review of this patch on sashiko.dev.
> However, I think that the issues raised there can be treated
> as possible follow-up rather than impeding the progress of this patch.

