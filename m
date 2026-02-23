Return-Path: <netdev+bounces-260232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMy2GGnTnGkJLAQAu9opvQ
	(envelope-from <netdev+bounces-260232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:23:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7211517E43F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 134F3305F561
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215C378D74;
	Mon, 23 Feb 2026 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MWFzFegj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB431CA6A
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885058; cv=pass; b=m2+vByap7yi2Er2Var9tTwQzuIM4kX/X2hzrIVXOaBnVjMqot1mSj441KlqdSteLTnJ2iOXqnYidCPwmcLo9I55MqZ/TC2eMm3A+epIOxyh2hAw2HM+A8Il4MUSTeIxkMHJsA3Kss+u1XZk1cXPBcBG6/hBWTjgHlkF/6SAPJF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885058; c=relaxed/simple;
	bh=ljMrIGCQUupDMXCGdoHZPzYWeyhoz0b0/enDyGkxeok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftGdKnODEbmxm4Av8FH4dP1/TKMVVcVlCFJ0g5R3wztnl9EE5ErxZgiMFJbrj68mWOKiDhPRvzkcL6oyGvquyBVDQJQpGlljBd8h+6XOWmlzMMPFcmLnSmOfputtaLafiUnVA5Ppm0EU4xkKBfFW2E0NaFaNqdpgHU/hTmRas9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MWFzFegj; arc=pass smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-896f44dc48dso44462216d6.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885056; x=1772489856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jX6gKyOs9Y6nnTjehf4llMrXB0eEzMcOeiMlAuJfUnk=;
        b=pz2Up9lMPSp3K4JaOhtPXgYcUzxO5TUB61FdGWtRO9z2LKys7Ya6JBEyHq8iKSB2SX
         d8Ho/T5rY5rwgFw32ls4juP3S2t6YC7Whont/pW6FZdXovkG63y+njhhV4S1kYi/FOLj
         J+tCvmjdJwlji+xMEWm9dZ4DOkEt8geIU4YSRDT2PxC7V8wE1amqz2Cp2jeqSSlvjojb
         MnHUYNyekcst+eEhFfbswfF/r3c0cXmHINDFXU2G9Y7gET3/mcSBOZRMNZ1OghjgihPL
         eeevo5zcoZS73BeoAkyxWZbKBIfqsKdbhRXVrffYRKK7N2gNFrN4akNmzLm0wSr6nh7x
         zmbg==
X-Forwarded-Encrypted: i=2; AJvYcCUBOnsnlUhL76NRkYsGX7OqcpKIFdITaGU27MoFxeHCpZNXCM6FmR5kAWTbY7s6jZ99k1ZDSpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXqzUrFxgqw8p88G4a330ChwI/c81X/EQgN36+LiXI5UMabya
	yYy/uj5G9FnkOnYpDHG6h2ZNNT3j/ar+vkUu5pnQK38UV8y/oaGGvBs+Fc/vbJrKJqhhoC+vhPZ
	yeECJlh6iBnCREcZJzuxVQoH9qCddWcR43NJ2c/qYEsVHKx2DDE/4PaW+Ra26yn+zw45zrWQyXG
	j8kDpLDoiyRZyeYWNwb4AcyjAH0c9RtLqV8iv9culR208dunwm7HGm4SBU2h4qF7734FYrmrlYK
	NULfHmYERc=
X-Gm-Gg: ATEYQzzJhmvBCZhxLLIY9S+Tw/gMVwv1bHBGAT5dcVLI0X6B+7RSbLY8CxmjPwLyTjK
	PIZgTRnc1W0XgHeQGRGMQbHBbYWa3efwN4wyCkSJs2pekzJQ3AOD28RHnUjM7NrycHDLRYaVRGn
	8k1zoTFPb6FDAndbMDnYGeSnxL/oYq+ZUFrnUkbQydeTkISOeXREp6TsIALR/l7Fmt23Mu5l7XM
	jpdd/pgIDCJxy49+znXBVXJwXoaiU71jxSgmuVptS77bgFOEg5SxQwiinWXRciEJfEbPUQFrCzz
	BDRCwIEO0HYnhMoaZCDepcXRTibNkla2ov3MhWyuNto0+EndlLrpoOAerRrT3XCkVbwQIL8Z6Hh
	beb3LVCfKBUo0t0I09OuyqubofwPgyCBDevSuSsqGt/WlBvBmTf6X6OJN2pRTk2ICalCufMSvbt
	YgObDQkBvD+eYzHnEXoOQkq/n0j+ouJuj3PXwuZkuLCJn/kI6o8iPNowNXGoc=
X-Received: by 2002:a0c:fe81:0:b0:899:a584:a6fc with SMTP id 6a1803df08f44-899a584a952mr2108016d6.15.1771885056049;
        Mon, 23 Feb 2026 14:17:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8997e752e62sm10236556d6.30.2026.02.23.14.17.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 14:17:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8fbaa0787cso488069966b.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:17:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771885054; cv=none;
        d=google.com; s=arc-20240605;
        b=EIYvCbCUNnBLWRKac6aLfBhgCcIusNx2Bqau1eUL3sYPqNT5kjsyKXgO7334r/JcFL
         OOxhiHU8iB+R6dPUY/GD2rhlLoptZuyeQkAS07SIJn5f32oe7P3vd7srZr0pRWp8b/0+
         YLxdXuwD4CzOhFJWW7cJyEDbEyI0gPOle5HOwRlg2nF+O178cTYNCoZu/TN5JWcEk2WI
         ziV8fZvDX945aoLu38NEm9b1eyvJTziMKNydEFl2FM6uLKa3otSeJx0Cdenoys1HQYZ/
         neSc+0HGOYuBlkKPPhplb4IRqnTHe6l23nOLGfD2uv2CltR9er+Lpu6FiqMdZ1FyBcLV
         zSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jX6gKyOs9Y6nnTjehf4llMrXB0eEzMcOeiMlAuJfUnk=;
        fh=/bO0x65+XST+C6OVWjP7cVzlGVC7PJUidTwXA44Qi18=;
        b=i1DJp+s59REpcwsNGRrboDChCrDlSed9SY2KZYyNDISTCgPWRZo7AgYqvXrgG8QsX1
         a9pD+j9TU8tUu6YoSyssQk9H1Oqs4TH02ks6XjcOC4+A/lIsRM9T6Xkd3Uijede4qovr
         pG5Lb38ULZVNg7WWEhYbiSX8HpCuffqi3i6/xd3TCTo3pb+g1yvM8WFwKFR98yapjLo1
         RgW61vkyqtFuP1GLRLyyM755rF1NGPi2HuBGnpxF5kizyPaWOYpufhpmbWioujT/kGhW
         WTfaHIacjT2zl1as/83UqDoBKyFuEkSBWwMunwghhe5wv9YOR5n8F2IYPNIs5flWdMHA
         HpCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771885054; x=1772489854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jX6gKyOs9Y6nnTjehf4llMrXB0eEzMcOeiMlAuJfUnk=;
        b=MWFzFegjP5tJ3feAdDgKNmgp+xszNQYmIdLbW4RKW3u//0KrA14wtOGqerV3tJy+jB
         qGieAAd86crRUqYNAC5+JGfpz5/A3Matta8t+2dum6nwZXD8fJ/V40LkfMdpFZfKvGE7
         yl93DLTeL60SVx2mhB3JLyM+mzgUrL+J3UwGk=
X-Forwarded-Encrypted: i=1; AJvYcCUTEEYizOT+w3uMAEUDSC2/WEwURbrKqfDbQvsrveq8NbZWYo7VQqMzp2pjd1iM1D6aaECAVi4=@vger.kernel.org
X-Received: by 2002:a17:907:e105:b0:b8f:c51c:6ae3 with SMTP id a640c23a62f3a-b9081c1713bmr323722866b.60.1771885054319;
        Mon, 23 Feb 2026 14:17:34 -0800 (PST)
X-Received: by 2002:a17:907:e105:b0:b8f:c51c:6ae3 with SMTP id
 a640c23a62f3a-b9081c1713bmr323721666b.60.1771885053858; Mon, 23 Feb 2026
 14:17:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223214950.2153735-1-bvanassche@acm.org> <20260223214950.2153735-19-bvanassche@acm.org>
In-Reply-To: <20260223214950.2153735-19-bvanassche@acm.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 23 Feb 2026 14:17:19 -0800
X-Gm-Features: AaiRm51hpSrjZIUpkojmKX_yfwIcRCxC1rv2cDNhxmCPQVjrbKz_hYHNbXb6T1Q
Message-ID: <CACKFLimX0PPJGeJMG-nycNMufbFsJ4YUTnGbLHC_20xF2n9OQQ@mail.gmail.com>
Subject: Re: [PATCH 18/62] bnxt_en: Fix bnxt_dl_reload_up()
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>, 
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260232-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,acm.org:email,fomichev.me:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7211517E43F
X-Rspamd-Action: no action

.
On Mon, Feb 23, 2026 at 1:52=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> bnxt_dl_reload_down() calls rtnl_lock() and netdev_lock() if it returns
> 0. Hence, bnxt_dl_reload_up() should invoke the corresponding unlock
> calls. This issue has been detected by the clang thread-sanitizer.
> Compile-tested only.
>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: netdev@vger.kernel.org
> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_devlink.c
> index 15de802bbac4..1e9a3454bb29 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> @@ -562,6 +562,8 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum=
 devlink_reload_action acti
>                 break;
>         }
>         default:
> +               netdev_unlock(bp->dev);
> +               rtnl_unlock();

This doesn't look correct.  The 2 locks are taken in
bnxt_dl_reload_down() only for the 2 actions
DEVLINK_RELOAD_ACTION_DRIVER_REINIT and
DEVLINK_RELOAD_ACTION_FW_ACTIVATE.  For the default action, no locks
are taken so I don't think we should unlock here.

