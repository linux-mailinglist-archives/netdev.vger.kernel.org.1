Return-Path: <netdev+bounces-306387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IQKdF/QrUGpZugIAu9opvQ
	(envelope-from <netdev+bounces-306387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 01:17:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A419A736393
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 01:17:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ENDesf4T;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306387-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306387-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DF3C30277CE
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 23:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258DA37B027;
	Thu,  9 Jul 2026 23:16:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD14499AB
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 23:16:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638997; cv=pass; b=X1r0BVpLcloyGBgVn1CoOQ+RZN5f3IYfpiTL1z9GeJ92S9TvboeT/+WvYYhA2oRUHNZ0f6UG82shLvYPCESDuzyxd+8PQbXlRQiSRMODARtkxNUi00aRGyL8JUxHuVRlIkaaSKheKI5WCed1ca8zQZsdbXPaqcSkONiIKTb5u+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638997; c=relaxed/simple;
	bh=4bs2P+zoATtx76DLQEISYzQnJrNhzV0m3g4IlWokZ2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxvGny3UokUYJYJbbIgyJuKdNbfnm0eiMVTQFPXbsTs4/j+7Rbcgj3V3iTJpM054+ZXMCmEXoSTNrWXib2Mubgict2L6KlRKtZ8DaIQMU+33cKHBBaa/KAsBT6mrp/OX4vdoki+7np2KUaUcLs90pwIKG9Yac6EAnpLXE9XY9nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENDesf4T; arc=pass smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso465415a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 16:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783638993; cv=none;
        d=google.com; s=arc-20260327;
        b=eUB4rpkPg9VmlCWA190pusGI/ULP2wOlKA7MRUPdGgZN5RSoulComrMe9WvXoSCodW
         6DjK9sFAOXf8uELorkZg4kpKqvxJR9cV3jfH0la5ROVsuPWY3Lqth9xLb9krHawqLwjz
         Tq0LzKrG4QcrS3/pbJabNAzYHEwKhs457YPUMnj1bNbpHwlVp+Jj5FqSQeoJaghBClYT
         EwSgdy/XZo5YTkT29dmoshP15MJcXSoM0LOtSyxtrJ7wwbRf0FNuYeGoqWgedYubE5Yj
         fdI63gTneMf+9rKzOjEXTV232dW9HQOVw0oTz83SuUKSj/Bd3eNS1wgU16xw3pNQ6Wh9
         KDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4SiFdHkjry06BtTFqenSVBsf5DaH0RuxQ/XWFS2jU4c=;
        fh=5kS1XP3ww/0Oj0QANcFn411gcOYk2+HHGxsUlN9jRMs=;
        b=NqCMSsaTBWI5u8RBLK69tVsWBtBviP07W8UOyg0OwNIRRa8fCGBO0q92cra4WEWslH
         g/RMDKcEAVwA87p6tYY36IqABCoJjmSuR4aF+0xNJgDVoWYZA04S6XVoNGaMBH/tCO6I
         y9RkZJl6KwZ8X14etq4PTVndLPD3k30Yph2ykZR1o21GtvBcp6Kjq+ut+Nr7QNueXSPO
         67q73lwSWSGV8V/vZ5JPIyP7O5PhePyGWHBnSfda7eW3tFzJDSD1FD+xm4HYe8nul2BY
         FjJ3GsmPVdaDI5gw30kGZQESCNz0i2+kAFXTZ6dqt9+dYO4Hhp9eVH4ffcrt1JPJ3h2a
         hagQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783638993; x=1784243793; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SiFdHkjry06BtTFqenSVBsf5DaH0RuxQ/XWFS2jU4c=;
        b=ENDesf4TQ3UsKku/SX1/uI2SaG9ylW59TJFwZCs75rFij91nbPKL30JIbzmAgRluCt
         kvzBBhTd4WPRLIQbG8A1/PXybsrGkNATr7CA8YW4dqFwpdM3Oi3WIoZBQlhRWdenYk5f
         9JOAdLmZQPGLJWurXke0b4a1pXsXdB3ifTPRR8+rB/t8EjKu4+3wRxZDQwIwUo2LeFUm
         KDcZn2qU2wfiHVmWNQA/TAUMHCsktJEqeI0k4tmpFaxpfpgo2qYjaMD8GJ0jxR6iu+Fw
         2Gmlm7k2svVkUlrputsjez87bi/d9JGLJ9ANhONqeSNIM68OTpm2NPPWf9k2wm2RK5UZ
         3z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638993; x=1784243793;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4SiFdHkjry06BtTFqenSVBsf5DaH0RuxQ/XWFS2jU4c=;
        b=dZ87UOUhu8NBl+LuYxmXC2LXPqc/H1/Dw6uios3dbz801yg6HNBi6fqWaoGgipADiw
         jQ/oFY8Z2eHAdpJKiDAuVJK/Flddus1uZtJJoCgXN+Z8tyNP3io0vXCqQg5tMHbUdtZd
         SB9IGmVke1QcV9v4RB4cry60+hdQAJqkkQhDQE4DwFbDBmQBDNdIqFprx7YUOyUsGcC9
         AipaKaKvhKukG/GkrETDHXhPlpoNTWImBWcOWAzX3XntXSLu3x4wEgNnIMGcaRDrTyzu
         f6BLSzDXL171zoeLxXoRW4S3qG3p9sWeMO6nFHHgZNfUF4nuU42/mj2y/QrUhYJHLu7Z
         RAVw==
X-Forwarded-Encrypted: i=1; AHgh+RrSckYyk11+LZKX0/cMo84wmQftyD+5seLX6VFYG6rNrhtvMKIsDRRZ26vha9TLVkOIQkWV928=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3PVZujsZioJRFjphTB/mDBU/NY8rPhv0KGY7xM35gSoHpLB5
	FB98/gmwWlXtNwn9/Qqn7isQoRIdVDjshoWYJUP5SsE3v7PVZTQog/fzFXKZ+vJBe/kbmseMbhx
	p7idPer+cq1/wncj9TSbioQK+zlB312w=
X-Gm-Gg: AfdE7cmvYXapiR7Nl8d5FM0SN0HTjHJCvWm4dSpvu0PCIrTFFxz3Ei6k6txztVdyJgJ
	7hcvju9MWB8hnnh8S1dVRJMm3UEZF2a6CMuQIzXd+SUnYD2rOED7HlhXqXazytzi7TkYF+ukyL9
	aDt7GN6BkuqE8a7rHhiLJ2d9b3F8m7hLKPZnMWD85tHK/ADUKRueRFBZZI3BxmNQrayFUXEl7Ys
	YGJO5XU3Fx//PQsAGdzxsBaVE0vOvkhB6jbn9uiXa6ZLpr+vvmJFsLrPytIwI3uwGInFB9biy41
	QQIwubKW0oFdZ9VvMNfLEpGHHpT9LfzLUNL2rjzXvJi/pdw=
X-Received: by 2002:a17:907:3c84:b0:c12:5c08:279 with SMTP id
 a640c23a62f3a-c15cdec79bfmr369289166b.1.1783638993079; Thu, 09 Jul 2026
 16:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709095006.3683940-1-prashanthkumar.k.r@amd.com>
In-Reply-To: <20260709095006.3683940-1-prashanthkumar.k.r@amd.com>
From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date: Fri, 10 Jul 2026 09:16:22 +1000
X-Gm-Features: AUfX_mxUiVRzHTwRrTyEh3pN0V9WkIRo5NwoajH-PlNaUNIlsMVuVzVYktZyTzI
Message-ID: <CAEg67Gk9zaFd1KZaffy04VgrRb86TnpDfBtH4Z_jkqQG9bOPcQ@mail.gmail.com>
Subject: Re: [PATCH net] amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN
To: Prashanth Kumar KR <prashanthkumar.k.r@amd.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306387-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:prashanthkumar.k.r@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:Shyam-sundar.S-k@amd.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[patrickoppenlander@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patrickoppenlander@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A419A736393

Hi Prashanth,

thank you for addressing the bug. I will test your patch on our
hardware next week.

On Thu, 9 Jul 2026 at 19:50, Prashanth Kumar KR
<prashanthkumar.k.r@amd.com> wrote:
>
> From: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
>
> MAC_AUTO_SW (VR_MII_DIG_CTRL1 bit 9) enables automatic XPCS speed
> mode switching after CL37 auto-negotiation and is only meaningful in
> SGMII MAC mode. The original code unconditionally set this bit on
> every call to xgbe_an37_set(), including when called from
> xgbe_an37_disable() with enable=false. This left MAC_AUTO_SW=1 after
> AN was disabled, causing the XPCS to autonomously switch speed from
> stale AN state during subsequent mode changes, breaking SGMII speed
> negotiation on 1G copper SFP modules.

In my testing this was breaking negotiation for all 1G SFP modules,
not just copper modules.

Patrick

> Fixes: 42fd432fe6d3 ("amd-xgbe: align CL37 AN sequence as per databook")
> Reported-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> Link: https://lore.kernel.org/netdev/CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com
> Signed-off-by: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> index fa0df6181207..12770af031eb 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> @@ -267,9 +267,14 @@ static void xgbe_an37_set(struct xgbe_prv_data *pdata, bool enable,
>
>         XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
>
> -       reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
> -       reg |= XGBE_VEND2_MAC_AUTO_SW;
> -       XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
> +       if (pdata->an_mode == XGBE_AN_MODE_CL37_SGMII) {
> +               reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
> +               if (enable)
> +                       reg |= XGBE_VEND2_MAC_AUTO_SW;
> +               else
> +                       reg &= ~XGBE_VEND2_MAC_AUTO_SW;
> +               XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
> +       }
>  }
>
>  static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
> --
> 2.34.1
>

