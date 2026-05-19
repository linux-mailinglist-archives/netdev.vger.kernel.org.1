Return-Path: <netdev+bounces-289580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE5OIeWrDGrukgUAu9opvQ
	(envelope-from <netdev+bounces-289580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:28:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 014DF583AB2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1264F301176E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADAC368942;
	Tue, 19 May 2026 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITErD358"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1935838A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215154; cv=pass; b=ufklJFNHMXs/C6ws/R9bM8ORnnDBw2f/C+hEPYXOTnLYPPwNeRsFH1N5bEBxY4fH7ZcFVNVmaeIlyL1cPyhoH3rwER6IgjnrILyp5QUKbjXO10MgzBeaXtL23x6I7BkA3SufHK6pUCR83qU3vCixUuBdf6WjwBpvW1Z/pBd0tLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215154; c=relaxed/simple;
	bh=krRIe+SWQ9UydTxaBCAVuzteStmc8b0sHjGvDVOk5rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clIHg46eRF/w8h7K555ZFvaHAzRqoGJVGYJrWnRsV15AyNAaIozQ2rOoey4sbyENwg7LdiWNMMRhlb5mKkU/FIPKO77uYFv4SAZxa9QcegSqWPYKjuwkB6nqnki/DKBpwTZY2o27z4rnovVn7k6jiFhBPDVIUjXySJqSgkEVs1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITErD358; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651c7ddf514so3649405d50.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779215152; cv=none;
        d=google.com; s=arc-20240605;
        b=NKnkxg2A+HshwsbR7qyd80Q2Of1rLqzdQtNdusabyKZCrF0aZbvakBW99noNWuUPhU
         yGuaiZgNAGhlkJObH8pkpiAPLY14CBHxEpOujOLqZP41QIkGnsVjWPoaoTRkvaCPuX62
         I+SG182lp1YJbz1DgPFrMPCrQco+e4iQ3Sgo6l27d2wVpIGUv7nwHabd/morI/b0gCGk
         yH1wXwePkthlghLo9648ArsitHnArsAn7/dGw2fGLNmM2yf3ViZ3D64g6dq5Tpo5b+Cm
         Q/O46i7QP3yNsLaOYd0wsKV46JaSOmese6X5uqxEgURmu6UXuh6oYLGjudkPfThRnRMO
         9k8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4YqY46vlRkF4fAbfB7mhKaAw8FZ7vCsOZe9CCi7etfk=;
        fh=DwfX4EEJclFNaTAfdRZno5zMx7QrNsmvfzBGke6wyYo=;
        b=Jm0Kwu/MkayFFMbVskO6S8ZcqUdqHEWqZYEo4fm17bBMeZAMfZFZ1IC36h0bJUoPsc
         7z/GNXEEmFBFNUITZfL1gD1ZPrEWgo4ORmd+kyyD79ad5RxonZciZ25HnbgTHtQh68oD
         j7P736MgCRTMR6Fq8kHy2HKmX+U+6og2zHFrtk1kIsNYr3XC9mjV5ff6VeqeloEyEX19
         pMoR/dTOreLhO2w/xUlu/aq2ytTGH98aCNU42tnS3g2lAtB+MMpXnJW3gNA/BR/FqFnm
         rgeEV7q+CwJIUJq3o+KSgM+ditMLwrV3kBVBG1T1eoD9XP5gQgDdeChk4FQ34QJGYZzo
         /hJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779215152; x=1779819952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YqY46vlRkF4fAbfB7mhKaAw8FZ7vCsOZe9CCi7etfk=;
        b=ITErD358uh7yiF7OORzuATGt12jzMIsnMPzOIdNjO4O1dxYtcqJqWPWN9iXQxD0BQH
         dZKrpOO9ZAXEu9AiXomerItB659YABVzgRnCQyjfKa9LuoppI4ZyWyg7yltHzXUrqA4Q
         83NaUfM6eqm+kWHnggT3ecawMCEF6yJcHqp/eg/PEb/Y11+nKMXKYJ8nLkIC592Ev1Nq
         u9cwFNlX69PPPOVDuLvYLkzkQM7DmZ7XOX6lTOduk7YJArw5Eg8us8vfxSUuerutq/HK
         99L+WiqBcAaUw2pt1ajAfnnH0Erv+FB4J39dM/Mghw7I0TrmvOolkwnvPOSe83cy/eLT
         AUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779215152; x=1779819952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4YqY46vlRkF4fAbfB7mhKaAw8FZ7vCsOZe9CCi7etfk=;
        b=d+qBwb8ccLk8IXYKWHUJpAU3LejvBrNiIDQp8KDYGQxk7+7LIP2eFpNrE/d26PZnUm
         96Ae/3m3QMXaOsid00FJE0jZuNz1UTuvPeYejYpZQE03DG/quo0MjEXIUf+dWJAAcF0H
         /Rz0HfFKiszwgORmY81zh7H6qRvTvwDn2LiIUhnH6+GfFBoi1qpi0bbLlRxDipC0VHTN
         S0P1tMh9Y++Pq2wDZrrI+xM45ISnSnyKSbtLhwdXkStuR2ZGu/bHOhmLgU9ntHAgozwz
         3sFiJAoH1/PtiYO2pcANGvqsqJm7oBinGKJGEFN7N0Rp3KOuvRxhNMqULzakXGyq8r1O
         +ZCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Z/BqdPuaiCwMaW0Za2CIWrvQQ4T7Dyq8vmzaDXrwrnk5xwPjYwytCjKu+XHbXUYLFz5uVmeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkF/9y74xcBHGnrrCwW8ykjsMf6KhFU9MAhBML1ouySNr3BJvy
	lwarTzWPjih0F5aMued+ecfpogpH4Hf8ZiIsSUbZnQQ/nTIG6viOd4B076pnZgwPW3E0aMh+YJ5
	UbN8jh8lHOhh1+KXDFu3KzQGSzrSyqyo=
X-Gm-Gg: Acq92OGCxkQYB2lmUBtw7zrQerjOWCN6WUVecAJM9ji/4/qbRKeu0HnonOp1+Vw9Ger
	6dZFCCFYDMj88a1C0zcnQU3oKQq5LeoGdSZn4s7U2wSI+qKWlhBdwhwIgNBG9lQL9Dy3xlXggBq
	PnNlf7lWPWywCgkaugZeGpDrzWXd6qAmnhqnX2WOjZY9Ua8oEX1ZwwrCw1oVip75+TqXuZr+zKS
	rO5IbcK21xW99Lds6O8mCmqFPpuqHw0mJvk95gQgex8dbUp2MV5LuS8uK4+jATnCDsemZ5Qa8zs
	kH23EvutEk1c8fHITJT9VXxX8IFP58R/MzHNtiPyaoptLgJwjbQ7gG2mMxpE1Y6zYkvgjw==
X-Received: by 2002:a05:690e:1913:b0:65e:3bde:1bc4 with SMTP id
 956f58d0204a3-65e3bde3490mr14311058d50.46.1779215152099; Tue, 19 May 2026
 11:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519042017.29564-1-meatuni001@gmail.com> <20260519181749.15746-1-meatuni001@gmail.com>
In-Reply-To: <20260519181749.15746-1-meatuni001@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 14:25:41 -0400
X-Gm-Features: AVHnY4I7-gjlkVDjFs7yHIvtQGGx6X0cwJO5cT0tfa1y3yINopyHlcyV6aiZJ10
Message-ID: <CABBYNZKFZpUh-nb-8wLQ_fy1U04BAwUdjQikbuzfrzCcMe=VPw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289580-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 014DF583AB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Muhammad,

On Tue, May 19, 2026 at 2:18=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
> immediately dereferences hdr->addr and hdr->ctrl without first
> validating that skb->len is large enough to hold the header. A
> remote device can send a crafted short RFCOMM frame over L2CAP to
> trigger an out-of-bounds read before any session state is checked.
>
> The FCS trimming code that follows compounds the problem:
>
>         skb->len--; skb->tail--;
>
> If skb->len is already zero the decrement wraps to UINT_MAX, causing
> skb_tail_pointer() to return a pointer far outside the skb and
> producing a second out-of-bounds read when the FCS byte is consumed.
>
> Replace the open-coded cast with skb_pull_data() which validates
> skb->len against sizeof(*hdr) and advances skb->data atomically.
> Save the original skb->data as frame_start before the pull so that
> __check_fcs() receives the header bytes as required by the RFCOMM
> FCS specification. Guard against a missing FCS byte with an explicit
> skb->len < 1 check. Replace the unsafe skb->tail decrement and
> skb_tail_pointer() call with a direct end-of-data index and skb_trim().
>
> Note: SeungJu Cheon posted a related patch that adds equivalent
> length checks inside the individual MCC sub-handlers
> (rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
> rfcomm_recv_mcc). That fix and this one are complementary and
> independent; neither subsumes the other.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
>
> ---
> v3:
>  - Replace open-coded cast with skb_pull_data() per Luiz's review
>  - Save frame_start before skb_pull_data(); pass it to __check_fcs()
>    to preserve correct FCS validation over the header bytes
>  - Replace skb->tail decrement with skb_trim() per Luiz's review
> v2:
>  - Fix GitLint B3: replace tab with spaces in commit body
>  - Add Cc: stable@vger.kernel.org
> ---
>  net/bluetooth/rfcomm/core.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d11bd5337..66eee8a86 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1741,23 +1741,29 @@ static int rfcomm_recv_data(struct rfcomm_session=
 *s, u8 dlci, int pf, struct sk
>  static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s=
,
>                                                 struct sk_buff *skb)
>  {
> -       struct rfcomm_hdr *hdr =3D (void *) skb->data;
> +       struct rfcomm_hdr *hdr;
> +       u8 *frame_start;
>         u8 type, dlci, fcs;
>
>         if (!s) {
> -               /* no session, so free socket data */

Doesn't seem relevant to remove this comment.

>                 kfree_skb(skb);
>                 return s;
>         }
>
> +       frame_start =3D skb->data;
> +       hdr =3D skb_pull_data(skb, sizeof(*hdr));
> +       if (!hdr || skb->len < 1) {
> +               kfree_skb(skb);
> +               return s;
> +       }

Add a empty line after if blocks.

>         dlci =3D __get_dlci(hdr->addr);
>         type =3D __get_type(hdr->ctrl);
>
>         /* Trim FCS */
> -       skb->len--; skb->tail--;
> -       fcs =3D *(u8 *)skb_tail_pointer(skb);
> +       fcs =3D skb->data[skb->len - 1];
> +       skb_trim(skb, skb->len - 1);
>
> -       if (__check_fcs(skb->data, type, fcs)) {
> +       if (__check_fcs(frame_start, type, fcs)) {
>                 BT_ERR("bad checksum in packet");
>                 kfree_skb(skb);
>                 return s;
> --
> 2.54.0

Other than that looks good.


--=20
Luiz Augusto von Dentz

