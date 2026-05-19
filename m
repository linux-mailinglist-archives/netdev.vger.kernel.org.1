Return-Path: <netdev+bounces-289472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI8VCfVqDGo8hQUAu9opvQ
	(envelope-from <netdev+bounces-289472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB5580080
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95915300D1CD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE293369D74;
	Tue, 19 May 2026 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLy5ilMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CA409618
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198702; cv=pass; b=AmrgefH6DcTVoFYa5ToIaVxbppkTnixAEgDrweAivI2W9cFzJ4ImC+8xtDMHhJaBES7JFC1G6WRlieljNgVzUU5zimPR9L5ckGo5aZwx4LSlqUg/VDyzN+q84v1JbLd8MuK2jMdhnmXgX7eBCdH4bT7PTETSZrMlw/y4f6v14aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198702; c=relaxed/simple;
	bh=UiRZFFSxfNaur1h+hBHhc1qozTGbc/kYlWrCOxKchwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFr+rUL30XeWiORoy3aYGRmT1ekdSEv7NxequfoOiFK3A3mAe++AeIKaEncElkKILuLt+U5yK4c6wK5m3U+0P7CuzjFwyApos8HKUsMJmIFDMg13X4mSQCHH53pALHsC40aOs88aFTG7AA4koixr8jbPhG2Il9bikEFXI7U4M+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLy5ilMv; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651c7ddf514so3270578d50.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198700; cv=none;
        d=google.com; s=arc-20240605;
        b=L9+32GT7B/Ov6EPdL5q4CqKpnDKBa1GOVd8nPubfllFXeWoaCF0pdIwjyhnR52F/ch
         WzCNnhkPxsy/osmD6u4s4D0Wo8xs1yqh7bSlUji7ehlZSpvg07cX2m2tlO60Qwn9WSc2
         K4Lfu7Mad/2aZaZCS6bt7/w1S+qSbvpwdaars64tBF7jrHR0HFgv0g3DLt3BPbActByC
         0dfj4dUriByGoCAOHJEkxSKnw5E5qIzTS2/byAjOxToArFc3NF6ezxCG38cnB6JkYtd4
         YzljOpCHzTHoMMHJ6mJ+WxhER2QpBAUfpfsFrKQdUom9N4F3P664KQdKowqfy2o7SdFC
         g7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVwge8U30I+3Do88tXXDA6OptpDzAX2Akk5fAL8cugo=;
        fh=g9I5ngS3ygWJfkRpRbMdfdPm1HqNxk9PpJHReQTW5/w=;
        b=IT4U9OkAVk3JAxuwO/x5Ok1YMnlDWyVX7vgBh9k9ozly0Xl3UfnDlv7njXqW5l+For
         B1+sND+hK54oNXSiV94asQYv8Ftv+c3ctRxUDL7gKopSHi7m9tn7BewfBWNM/ahHRg7H
         9zkwjVy+6rkkYyoZcgrAimfXqmJ86pV8pzwQc3/WfhLl+MhfzHuPOEQ/zrdYzxL8irAn
         sZSgdrK2POA3LnTnixdhTmyJHTlZ3NavAtNOF4q4PSSvb133h0W2V7h09eLn4I5IpWaA
         CO+zqIjPPagSD8vPBcas0R81YcjOZjWXmEuUh6maYpw3eaO1w0j1GL6PtDwV6VbHtnjQ
         j0Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198700; x=1779803500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVwge8U30I+3Do88tXXDA6OptpDzAX2Akk5fAL8cugo=;
        b=JLy5ilMvbUziUXyPAMbiS4OmKRiUDaJWiElbMaEgM95sucr2AhzgRcWDUefjzzwdZM
         fV5CX40YmxCzdzS8MSSZ3DEqMaUeFAHVgEsIwDBLrb2q96ewybO8O7GXwFWVkpeOd8ON
         KJhRYRdctBvZV2R1knhoW7HmKWVbGCxQDNdo4kdtkL49ktR0092+g6Y4zgaZLVW0K4/X
         Hu9QFvid9DBhiRD5iiGoJ35rEQTncpU1mViN3blcZ6rWNvAglVZHSiod7SiJSjcvtDBq
         2oF8B1bdcnxvYIx3bMVbJl8iUAjuVPEaR+ejKGqwhvdzjvP9HK0PlzTWJHHARQNdAI22
         XNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198700; x=1779803500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVwge8U30I+3Do88tXXDA6OptpDzAX2Akk5fAL8cugo=;
        b=pOA8V6Q95bcYC0xwXQIARASJG/ebF0LdsGLymjlO31AUSKpnA6tEPAbi/hwicBONKt
         U3ELu1WngnKHl/FkUxXVDi9PpHYwhKibkriPBv9JE9YLpnm8qWDj8Pcbbom2Bz2D943E
         eGRKcl106Vo3EZTLDgfNlH/v4ICOIrRztSasFuS6fm1T9QDbttsXyITOQOiZEV5jbbvG
         BAg3bj0jUuPbzfAPu9zYviKXYeUHhLvCG+jWhLuTcofznBd9ystfZGPKBOEOBWkdSZUi
         Wa10MhZl05JY5GLuLeDEZtHvgLIHs1lKGNfkrdEmoZhq86d0ynEdm3qDejDaKjE8XmJQ
         PU5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8UVeYETES4W6a6pJrjbCZ6xfTXyzYN5Rz0VvPCg1ISImJRZcwnKaX2HAlvnoTCEw2y4+GPr+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JRNS8Hdzr7tk+FOC/WTdcyeTqDSqjYQu+RaDMWfVDF0C45Yi
	178JIMml2HzvP9ikLgEqKIQACNRKWEYp5ll/6+yZcrFRxzdm3rOaJOdmjM5pbTkz4LoPQ3MBtWl
	+sruR/B9E7cwfSvJ3qlhdtd3SWzI8Hp4=
X-Gm-Gg: Acq92OH94viww1kFVT7/7fCdPRwHDBpcJ5g1d7SvhsxNZ31aP+OI7rW1+iriadpxePv
	JAGisaYubfFs0JemxkVGZBzq/3kRXySTlWyY8h9mT0W6HVl7MfV0TanWDmHegs2pKplV1dOMnIz
	dtb1oLij0SooK55gGXXGinchSXdb/D+MXIeulggHfKV9P5fgy98ppTkQypdoZZLgSBv7qB5h5qp
	XKNL6id575yzL7LLffITcRwipzb+PlXH4WWPiF4i/udKL9UENjAvhCiAMwT9e9Xr7/GsHzha/eP
	2N1dnY2OQpOxuGIWo4NIaAXzLbyYLtoogD/lXUAluXNYVgdNqwH3UhDtYL/GXCAC8fGgGK0TP4F
	QOYPi
X-Received: by 2002:a05:690e:4007:b0:658:1e1d:b8c6 with SMTP id
 956f58d0204a3-65e22813734mr18649450d50.44.1779198700259; Tue, 19 May 2026
 06:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519042017.29564-1-meatuni001@gmail.com>
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 09:51:29 -0400
X-Gm-Features: AVHnY4K8F5R_BLPl_8aQWJk9ha54hIO3-GwHyckk614v30mRPpXpGNIIWjZC0HQ
Message-ID: <CABBYNZJ+m7xLo4BBGZzDXV=U7uNWSc7fbHU4QL+jUsN8zAVfkg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289472-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E0EB5580080
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Muhammad,

On Tue, May 19, 2026 at 12:20=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
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
> Add a minimum length check before the header pointer is assigned. A
> well-formed RFCOMM frame requires at least addr(1) + ctrl(1) +
> len(1) + fcs(1) =3D sizeof(struct rfcomm_hdr) + 1 bytes. This single
> guard prevents both the header out-of-bounds read and the skb->len
> integer underflow.
>
> Note: SeungJu Cheon posted a related patch that adds equivalent
> length checks inside the individual MCC sub-handlers
> (rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
> rfcomm_recv_mcc). That fix and this one are complementary and
> independent; neither subsumes the other.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/bluetooth/rfcomm/core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d11bd5337..6b300237c 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1741,7 +1741,7 @@ static int rfcomm_recv_data(struct rfcomm_session *=
s, u8 dlci, int pf, struct sk
>  static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s=
,
>                                                 struct sk_buff *skb)
>  {
> -       struct rfcomm_hdr *hdr =3D (void *) skb->data;
> +       struct rfcomm_hdr *hdr;
>         u8 type, dlci, fcs;
>
>         if (!s) {
> @@ -1750,10 +1750,17 @@ static struct rfcomm_session *rfcomm_recv_frame(s=
truct rfcomm_session *s,
>                 return s;
>         }
>
> +       /* Minimum valid frame: addr(1) + ctrl(1) + len(1) + fcs(1) */
> +       if (skb->len < sizeof(*hdr) + 1) {
> +               kfree_skb(skb);
> +               return s;
> +       }
> +
> +       hdr =3D (void *) skb->data;

Let's replace this with skb_pull_data.

>         dlci =3D __get_dlci(hdr->addr);
>         type =3D __get_type(hdr->ctrl);
>
> -       /* Trim FCS */
> +       /* Trim FCS - safe: skb->len >=3D sizeof(*hdr) + 1 >=3D 1 */
>         skb->len--; skb->tail--;

It might be a good idea to check if we can use skb_pull_data here as
well, instead of changing the tail to then use skb_tail_pointer.

>         fcs =3D *(u8 *)skb_tail_pointer(skb);
>
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz

