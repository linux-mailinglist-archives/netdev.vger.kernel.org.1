Return-Path: <netdev+bounces-293888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IyMN77SHWpMfAkAu9opvQ
	(envelope-from <netdev+bounces-293888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:43:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3D6242CD
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB26302BE81
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762053D7D74;
	Mon,  1 Jun 2026 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1yMLhS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A9368D43
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339030; cv=pass; b=g6/F97h6a9HIrfkYc+mGTF25RkOSnKul0eJdRMASIU9sinOmp6fWH+nHl1MIfkUs/ieixhQWreMNTSnNKlkUYUvq2Bmjz5IsCmbC6HKoQP5/kqaiFw7k8poe9r4OrFp7pzSz//m1hDp+aM7e99Najn4JRGAnlutubRhldohUaH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339030; c=relaxed/simple;
	bh=BcYRpq671NSY068+BbMd+Lz28HJcQwg2rs1w9g7BNTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt9BlBpCFOEfe5ulxhrvcJS0plESi7X/kOJIT+MeXBAseQCxGF/SLe9l2Y1hQQcUIcLitapUj/eVSoDBmrAnq2q0n5Hw8xV04GORqm+riOt3lKge5zNLWcyujGt8Fkp2rs+ZGmvlwUmhzV6+eTAopViqHukUv0sUNRwL7GRTTt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1yMLhS0; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dca5a81be2so44127367b3.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780339028; cv=none;
        d=google.com; s=arc-20240605;
        b=GXMJ6g7l4SEMleQC7JGATrTR9ZBxdQTNx5BPJEMs7BfV+XSjwkoGQOVbmNFjVsR/fm
         uSlNHC/SUks55rC1kGw2C1bO44dmaJ9YjM7RiZOJ7bvrv6Mns/kIxkfD4NwzaJa8aQ0T
         CL2DU+Nw3ElFNmPc8FzZikYodfo9x2ZxxDMKYOCDiawmKG0vZjZPVqgPhKqpWmcKAn6u
         hfb3c20Ar4eA15uM5ny/yp778pDyK4n31GLIxlvdpk9vmRhIRS1EPDG+/p7e7Slvd2BQ
         GQErN+yTE0h9k4x7GXkkZUlgqnQnr3nDvoQ8dV1JQLsEKlimqRsgivCLOFr3GCpg7Ahn
         jY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GotfCq9kR7UkZKVQl6oMniUEgKCNQcaIoodJS7a89mg=;
        fh=j63qCuojwqvQQzlgE+MKEEKQYHXryeqTTKli/RR7oUk=;
        b=J2f2aZndde13UGqB6oSYMrjwJIEEtswnFZDacF2sipWdL7LQhdo7wTBZfNppGhB5y2
         gNbum5eMEEI8iHLy/wwsIJMSTqiqm5SwJQ3G4vr/pRfk5eSViGZNAs9S9QM5cLQQeRFh
         661yP9P1A6CA4cgtttv2ABREOPYtCSXM4Xz6Lu0ymj5cJL8W5GOdWOr4r2RAnT8QQ4Pd
         S+fbyAomgeqniF/DPfgHp4wqE2L++9a2/dbfVuTq2ufNlbSNYUn/fZscoXlhGe+RP+bD
         XOPyI80rX4xyrQkZ7vnfFDktjs/9msIwRMuQ4kMTyFcGGX+DPhZAxigMJ+Ml+uQp81yo
         Fn4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339028; x=1780943828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GotfCq9kR7UkZKVQl6oMniUEgKCNQcaIoodJS7a89mg=;
        b=K1yMLhS0fO/LbH2RA62jv63658f7Fr/NgpGcdq3kFJbP+BswnjR9E9FHBOZ4pdlUQX
         Mox9//4US7PF0oxNr8BoJ3eFzzMcu8LdemAZ63PeHyMMOGkSbWNLBawofn3a9tYPrQtZ
         dQfkMBKysB2MkZMvoSbSXjWnBTUKk6mfiH3ga11k3Kd9bHvj7bg/sl+x0dXcYeX2U0TE
         WndcKXwsOZ0G0Y/m6VvpZ5les0lY6AImFDk9MB+2pCoQn7y19Bp5RURExnItBExdAvQL
         6OUzYRjKVOGIV62CNwjfKECB9rHvLKREDiSuSlLPCpsNSSKC4M/YefhsvEpfiBTkogvR
         qjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339028; x=1780943828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GotfCq9kR7UkZKVQl6oMniUEgKCNQcaIoodJS7a89mg=;
        b=C1q6VPQ1P/DJe9t1vrDQjlbAVGHZJRYeR4bPf3c1fs+DjBv7fCpqNYfHAE8Z8fSxOi
         mGfcShWO1tCRgWqiPyCmqXvfQJ03cBlyJKVHDUTjG8Evf6zr5PdXIde95mf88i9GKBAW
         lBz3j2zAzgXlqbFDexhSlg4AUDgVf7RgVsEvpJczqtcHX06fbQX+KpSeGxQY273Do1BK
         ZVezSICJDW6hIqeSgpX1+zpQ6VWGTOdrlQuE6LS85+TAonYCjr+7KGAqt2bbXnpgZfWG
         wmSxUbaZDEEFZIjczRhfKyKgvSDst+GBpXLARwIDSkjULyIBibMu5OVFu/7lA0trr5tE
         Y5JQ==
X-Forwarded-Encrypted: i=1; AFNElJ9v0kciPjzTYxjeWkCr38sqpeEMEwAEESh08Ygkg8d+3+52b1eLNXfGrrb6wgrSzCKn9NRX44o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtXEc3U5ljIKqIadr0dZmUvELUj2ygT1GBZE/FyrS0t2kG2Wa
	oXuz3j32e8VdqUnHjIrusw0t+Bfqctg7Yr85GS2DyZLy2x1LeoV0m+3IqOAtaN/4aRJb2bLT8wb
	+3LVNBAi6Vj/wIRnuyqSl01e45vdW1HE=
X-Gm-Gg: Acq92OFyM0a6MAlZN/R57jUxY1rdWioJgTHP2ux6YzM8vwj8Q/vih46dSU5YKPA6cZU
	sk8bl4Lp6a8RGUAnvZ5Xm98rOQCAApz6otrAVKuHkrs+LK63OHY+FgqiebyoE53i4pn4hL3H9Ll
	+8Pa70uRgIQAG2xkPqN4dXDXV/bkkxBOkr5KLIYY5F4UqBUxx9frMdm/rVmRnUs+iapHK3KejVt
	/vdzNYD9/I9AXhjCrAOXB6NWB7a7bpUc6DL+lEJ3k1/wiOK4A7jK+Jcgt1iLzUF3onlfGiKCmKd
	yJZyjKygcG28gotGZkJWqSy2NR1x3W0+gQ==
X-Received: by 2002:a05:690c:b92:b0:7de:795e:e9d7 with SMTP id
 00721157ae682-7e05d8d6a32mr116071367b3.39.1780339028165; Mon, 01 Jun 2026
 11:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529014936.2811085-1-ameryhung@gmail.com> <20260529014936.2811085-6-ameryhung@gmail.com>
 <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
In-Reply-To: <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 1 Jun 2026 11:36:55 -0700
X-Gm-Features: AVHnY4I9CBzKtblKLCUQevdJLh4pes8gAkfu0ieQIjxc5qQnQ3RAujzPIsyPi-s
Message-ID: <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293888-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 44F3D6242CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 11:00=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:
>
> I think refsafe() needs an update.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > index 877338136009..5945956a7573 100644
> > --- a/kernel/bpf/states.c
> > +++ b/kernel/bpf/states.c
>
> I think refsafe() needs an update as well.
> Something like:
>
>     --- a/kernel/bpf/states.c
>     +++ b/kernel/bpf/states.c
>     @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_state *ol=
d, struct bpf_verifier_state *c
>
>             for (i =3D 0; i < old->acquired_refs; i++) {
>                     if (!check_ids(old->refs[i].id, cur->refs[i].id, idma=
p) ||
>     +                   !check_ids(old->refs[i].parent_id, cur->refs[i].p=
arent_id, idmap) ||
>                         old->refs[i].type !=3D cur->refs[i].type)
>                             return false;
>                     switch (old->refs[i].type) {
>
> Wdyt?

You are right. It needs to compare parent_id, but maybe only for
REF_TYPE_PTR like below.

        for (i =3D 0; i < old->acquired_refs; i++) {
                if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
                    old->refs[i].type !=3D cur->refs[i].type)
                        return false;
                switch (old->refs[i].type) {
-               case REF_TYPE_PTR:
                case REF_TYPE_IRQ:
                        break;
+               case REF_TYPE_PTR:
+                       if (old->refs[i].parent_id !=3D cur->refs[i].parent=
_id)
+                               return false;
+                       break;


>
> [...]

