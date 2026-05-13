Return-Path: <netdev+bounces-287679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILqHJUWmBGogMQIAu9opvQ
	(envelope-from <netdev+bounces-287679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:26:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BCD537052
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 880593001D42
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285F3839A5;
	Wed, 13 May 2026 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdzCc806"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822D18E025
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689593; cv=pass; b=fVOGhuAEmnqsoiaah/7YmtRrv1WLtIV6x+Rm8muptgFDLSJvN/b9/L6jVaHbcoqkNyRV/m//OmuyQSwGXiU/zHyVldzd0zIpfxfVr/bv+XrCYMr+RIk59/2F/ElYXEmnIAZP21QAGSZiClN2HoZDY+4ToC7xQzhshfCRgZTkG3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689593; c=relaxed/simple;
	bh=zUcKltuIZvJbg6AoY6lPM0pZW8IjWNn2hKx1cUL80Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cX1b28gpxrThJ4Hi/loR2qFdfoHcNIBz/U9E5+Is4ABTjsarwSd6U0dViPXUXHcfYHb0a+GBcGfg+5q/l+icdXvkf/k2YOtew3PjylqK+PWOORPRyXO+rSVgD0Guy7gLWvj19jAFDD898x3EbF7YKlCVU92X/gIqVH/caG5cnsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdzCc806; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso187a12.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689590; cv=none;
        d=google.com; s=arc-20240605;
        b=dAaibwpmKnueQxQqlSdtDucw0thWnYtxWmPo0Y1w1HCRUh/MjupG7LBDrD8GS98aHk
         uZ5A4OAL25I3e0L3rByWEtpg9AvMv7iOVOpQE15jSlDk1zxLMP/5qMQO338/QAkFsIoy
         VHIfPKvfWG5zIUekZndvaM9ZWrwMuwMfMQyxOVri1lTrPkLKHz9SKXzk1tyEcuJl6Hmg
         wyC2JiLh5TZQYLl7JNig34aBjfr5qA19K4bZ04GoaQLPJdijiXFlQ5+CX27FlLwvAjJo
         kBUyAIAPROvR+hAKyH0b6botpIrlr/jVUYs54dJL3Mklf5X9nouCaztmCYhSXlqETuHZ
         r3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bw6dekHWHsCssuMHfwBK4tQBzr48F14pe9kW7GX9Wqk=;
        fh=E5XWOebbCnBVl/l1ZKUpnSY7HQoOndejvhw0jHH4Rxo=;
        b=jw3SFhTCkcnfepbapbJbHLPCtdGEwWlSY0erk+Ijgs75NzaC4jQw+hczM0wxDz1GRA
         uM0FqIgM8Ezi5QeGjWHrQbENVBRRrBxGlN/m18wf/bJyzVPzzKcBsO9ZLI2+2bWlnl6+
         XkxRjHIBgOuD53nCszw+sTGfkyUYRijBSp0P664s63VQlONwB9IBN/Ua4D3kWbiQPuhu
         oauA/kPxRt8aTURRDFFOAqXI8Eo5izfeFeU1dSYj8hER5VbKU5M52mmaPxIoeLwBIkdk
         4gqfuNJXzjDEFj7Pphnu6YN9Lc7YdcHqIUkM22XDjo21+Bz0XPhQ3M4ADsTeilTcKMm4
         No5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778689590; x=1779294390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw6dekHWHsCssuMHfwBK4tQBzr48F14pe9kW7GX9Wqk=;
        b=bdzCc806NAPf0En4NJCNqkO+fHnvmwyhilFAqMsMTR1vf7K0tohWA6tCHoMloHr53b
         Wrsg4VNtyW3xhab2H/z5UTyrtnPisvMf2Qrw1tAKtlGQvkZizroMSvnt2GcoGE3sosv5
         Z7Y1NLLw4JOqKrQwLytgcLtaAoIZ0JxtN4/29p3BNRk60Z4dSlWQTpMEWkuCWw0eqMq9
         sCJ0pFhgCNxPA/9Fei1r/NfwqlF9SbUM+fZsVVxXAqKeF4wIu+bTsCTkEd64StXt8JcD
         PllOw0nbm0J/5PutGYYco4IkukNj76QIY/JNBMz7CeqsLuDVSfpL5x857i/GsWr7bOG4
         AjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689590; x=1779294390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bw6dekHWHsCssuMHfwBK4tQBzr48F14pe9kW7GX9Wqk=;
        b=iGwNs12Pxn8sP+C+8bn35SR/7X6rnjKzhCK1A974qH3BM7NgjmG/W3UvsDieyVI+II
         w2pbV2ENyBdf+1gBfA/bQzMGs+gtMqSrCsKgYPg5dIpx4Ajpia89j4ZY0r/CPNEGVg0T
         HlYIYya9xZs7pT++mIrmENqvTrvNZUN/DFzFAOWBK40IuTcUmNgUBaHvSlK5oRqyKXZ3
         CDSUvXpJaxMq4SmOBbE1ODc1FE0OxHHU6cVG8m427jM/yost1dIXqvspN6Cg6w9NcO2Q
         vZqUu97bIp2p+ZerATFxi8LQlnF1epy0ddnqIZmbN3xvv1yLNBlIaUWWHA+7HmZlashU
         ha6A==
X-Gm-Message-State: AOJu0Yw9FO3AugAGURh1hXF22JDAuR/oe0LZDLIpTJRwrWAH01ZG+/f4
	42ixKI/UYfiUUwyrlxNkhLaVOQPnA1pzYZRZ+RilppGL1BNf3Ks74/v8X3VMBMXRJxKwRkt8Ebz
	GZKQCpkI0oyau6sHNJUjHFpfv5BMBu2RmP9UVaamn
X-Gm-Gg: Acq92OESPVwXxMxyx/W5xMvmND93H2kqu9s2yhbny1Q6/Dit4jCXqUuMlMYjQ3jgSMU
	hTUcJKC3PKJjd81isW6hSmDj4z9KoL23vuI6tNdOUTY+4y4igrDNNe2i4TtYa1vg8qsdlhJxAUR
	Ap0MT+Bg/j/fEXS2EZgA1RIjxUfDe/5mdHVWtanwRaHBh6ThSm1NFkx9Pw4k1FSIkF7XbLYUHG8
	8zbaNgq9XPVi4RmIoNQtLeSz/ePt26sp1r2WENfJLlRcWhl1bO/Q+QAHRzPao3YCsBCX7ISu7kX
	r3ZxLzcy+NqydVQfqnw=
X-Received: by 2002:a05:6402:a554:10b0:682:a2f:a15c with SMTP id
 4fb4d7f45d1cf-6827c43e148mr52793a12.11.1778689589336; Wed, 13 May 2026
 09:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511231812.1801984-1-hramamurthy@google.com> <20260511231812.1801984-2-hramamurthy@google.com>
In-Reply-To: <20260511231812.1801984-2-hramamurthy@google.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Wed, 13 May 2026 09:26:17 -0700
X-Gm-Features: AVHnY4ILKVO5z_UCU1eyhJvdtQ81WFX0FfjqI0OfO3SuvAK_iaAh6fuus0mY9Kk
Message-ID: <CA+mzVtsbEFuYROdps95dJNCR8-cbnsBRYUDfyMp+5adEXr5Pzw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] gve: skip error logging for retryable
 AdminQ commands
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, thostet@google.com, 
	alok.a.tiwari@oracle.com, pkaligineedi@google.com, horms@kernel.org, 
	dwmw2@infradead.org, jacob.e.keller@intel.com, yyd@google.com, 
	jefrogers@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 37BCD537052
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287679-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid,sashiko.dev:url]
X-Rspamd-Action: no action

Responding to Sashiko review at
https://sashiko.dev/#/patchset/20260511231812.1801984-1-hramamurthy%40googl=
e.com

On Mon, May 11, 2026 at 4:18=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Jordan Rhee <jordanrhee@google.com>
>
> AdminQ commands may return -EAGAIN under certain transient conditions.
> These commands are intended to be retried by the driver, so logging
> a formal error to the system log is misleading and creates
> unnecessary noise.
>
> Modify the logging logic to skip the error message when the result
> is -EAGAIN, and move logging to dev_err_ratelimited() to avoid
> spamming the log.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v7:
> - fixed type of err to be int instead of u32 (Sashiko)
> - Picked up Jake Keller's review tag
>
> Changes in v4:
> - call out change to dev_err_ratelimited() in the commit message (Jacob K=
eller)
> - remove extra print when adminQ status is GVE_ADMINQ_COMMAND_UNSET (Jaco=
b Keller)
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 30 ++++++++++++++------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 08587bf40ed4..c7544cd1d857 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -416,16 +416,10 @@ static bool gve_adminq_wait_for_cmd(struct gve_priv=
 *priv, u32 prod_cnt)
>
>  static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
>  {
> -       if (status !=3D GVE_ADMINQ_COMMAND_PASSED &&
> -           status !=3D GVE_ADMINQ_COMMAND_UNSET) {
> -               dev_err(&priv->pdev->dev, "AQ command failed with status =
%d\n", status);
> -               priv->adminq_cmd_fail++;
> -       }
>         switch (status) {
>         case GVE_ADMINQ_COMMAND_PASSED:
>                 return 0;
>         case GVE_ADMINQ_COMMAND_UNSET:
> -               dev_err(&priv->pdev->dev, "parse_aq_err: err and status b=
oth unset, this should not be possible.\n");
>                 return -EINVAL;
>         case GVE_ADMINQ_COMMAND_ERROR_ABORTED:
>         case GVE_ADMINQ_COMMAND_ERROR_CANCELLED:
> @@ -455,6 +449,16 @@ static int gve_adminq_parse_err(struct gve_priv *pri=
v, u32 status)
>         }
>  }
>
> +static bool gve_adminq_is_retryable(enum gve_adminq_opcodes opcode)
> +{
> +       switch (opcode) {
> +       case GVE_ADMINQ_REPORT_NIC_TIMESTAMP:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  /* Flushes all AQ commands currently queued and waits for them to comple=
te.
>   * If there are failures, it will return the first error.
>   */
> @@ -477,14 +481,24 @@ static int gve_adminq_kick_and_wait(struct gve_priv=
 *priv)
>
>         for (i =3D tail; i < head; i++) {

Sashiko says:
---
This problem wasn't introduced by this patch, but does the loop condition
break when the free-running command counter wraps?

The variables tail and head are declared as signed int, while adminq_prod_c=
nt
is a u32. When the total command count reaches 0x80000000, head becomes
negative (-2147483648), while tail typically remains positive (2147483647).
The loop condition i < head evaluates to false immediately, meaning the dri=
ver
completely skips checking the hardware status of that AdminQ command.

Silently ignoring hardware command errors can lead to logic errors and
system instability, such as assuming a queue was configured successfully
when it actually failed.
---

Yes, we will send a separate fix.

>                 union gve_adminq_command *cmd;
> -               u32 status, err;
> +               u32 status;
> +               int err;
>
>                 cmd =3D &priv->adminq[i & priv->adminq_mask];
>                 status =3D be32_to_cpu(READ_ONCE(cmd->status));
>                 err =3D gve_adminq_parse_err(priv, status);
> -               if (err)
> +               if (err) {
> +                       enum gve_adminq_opcodes opcode =3D
> +                               be32_to_cpu(READ_ONCE(cmd->opcode));

Sashiko says:
---
Does this code correctly extract the opcode for extended AdminQ commands?
For extended commands, this field contains the wrapper opcode
GVE_ADMINQ_EXTENDED_COMMAND (0xFF). The code must explicitly check for 0xFF
and extract cmd->extended_command.inner_opcode instead.
If an extended command fails, the driver might incorrectly log "AQ command =
255
failed" instead of the actual inner command type. Additionally, checking
gve_adminq_is_retryable() against 255 will break retry logic if extended
commands become retryable in the future.
---

It does not handle extended opcodes correctly, will fix in v8.

> +                       priv->adminq_cmd_fail++;
> +                       if (!gve_adminq_is_retryable(opcode) || err !=3D =
-EAGAIN)
> +                               dev_err_ratelimited(&priv->pdev->dev,
> +                                                   "AQ command %d failed=
 with status %d\n",
> +                                                   opcode, status);
> +
>                         // Return the first error if we failed.
>                         return err;
> +               }
>         }
>
>         return 0;
> --
> 2.54.0.563.g4f69b47b94-goog
>

