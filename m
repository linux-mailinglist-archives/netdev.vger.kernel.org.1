Return-Path: <netdev+bounces-279604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FMLGjAo5WkdewEAu9opvQ
	(envelope-from <netdev+bounces-279604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 21:08:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B67CB4253A9
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 21:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1108300B610
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDAE2F260F;
	Sun, 19 Apr 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsfURFUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51322E719B
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776625707; cv=pass; b=FmgvdRsdtzfo3UpROUvUeVb6IpbvdAJwNC7Y1OSMbYZuVLCh1lbwn9NNiiX+loI6Yh889DwkMBicjDPkhUWCRdyHFcW5VVm21LSUEUFthYjSe0QAFIoAXGzALOmnWQYX0F43mOol3QOLaB/YIouyxbxKuFF078IUZDJmiBbVpjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776625707; c=relaxed/simple;
	bh=E4S4CXFTTcatn4AQyzHCxO0Xkt9H+ucDTEdsoiRe6Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TG81ksYk7ZQKWdsgev6R/YnCEsC6pNAYPFoPgrVOI2XsnJR4QnH8xKNWYTnDCVvoXsj3TU8d9pv477ADb7trxx+eB9z85i5d1bLPQ2DbcJvqbRrkCpGOm9K47yDcD8nRzbeGN4ylW41ukeenrCwIwx16qsayLnx+tFhDkq2CwAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsfURFUY; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so3969526a12.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 12:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776625704; cv=none;
        d=google.com; s=arc-20240605;
        b=Ecc8pozHqMYMSlpc0L+imyLN1iRX/yHB8r9tVoOgE4376gqYwA/dBP6nRUeU1LwqmW
         y94eEAwrCuPVemlNoUP/luTevzHObVnx7PtYONfKtnba6GMOuHVz30tEeE5uuQORTuiP
         RGMoHAaCZ9PelgA7Th//nrck3EYSEwmjjN62PXXR8P5dewD+0k9yMwVI8OpcaKDAsWsF
         AotGBevVBKtrz/ufQoeYnGZR+snLuvgkqxWZJVVkMupLvzmLTCSZW5upiFLlsbeA3RHJ
         IrlkPEiA5IetkcYaHsoNMXTiENxmAfrcYXSLFJbzm2aTTG9gGdteBHasWVjf3anhxP8p
         3U5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jQkUjBuxdnOUANZ5UjsldqSwfxEKGSaidckWv/JhLQQ=;
        fh=GqhC6hsJOFePdNDQMr1I1GqVEgln3fHBUGkjXjBXrns=;
        b=XmlTqqf1JN00794lP3/RThITFiEPVbRus9zzaFUlBY6j7CBtEyMFf68Jd6juitszo/
         A/nAU3GDrImYD/ybmL3O0kkDO4X72V6JoHOTmP2mys9jXeIBo81qjavGQ21ggz6cj97o
         E0f2/Jm8RBZtZhor8DJrTNyQRbVcb8QX02yokKwKfKOtS+ToohZqmHjhnQkzx7WveWfE
         ryNgT5rPZ5zMQlh3T7mACvD0EKy222gWOcxR94Gz1CPwCaHNE2vAJ6a3tqDPkpRKsEvL
         cTaTM8XE3Z9bCSrCPY/7ESDUyHUKv++SEH1Jt/1ovacd3pJ0WvLhHbr5ow0NHjgBssEs
         fk0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776625704; x=1777230504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQkUjBuxdnOUANZ5UjsldqSwfxEKGSaidckWv/JhLQQ=;
        b=QsfURFUYorxjM4KVR5Jz+kSWX+DijmRIEZcaf1X/D1kiN4jgPnGSmD+TkeGV+AHA5w
         RJLaTmb+GhT/jsIm4g+lFBJNuMiRBE6iYEfQxXD4Uo+yIbPxCPwEdBelX7GW9yLu+a9d
         iJMuvyXPP5mk9WZzL3JHlZZpmR2/LLivUkfbZjeU9zxOymdHAB+pnzqt1mqeU+jBI+wb
         gtaewUhc2Rz/bk/rXTPbChipqY6//Qkli0t9Sp4D4Rsi8xXcySM/eE6oe3vCabZgiQGH
         qC8lU+ZTsXW6ZlAKZBpCU55DS6AeUxJ/G+XIiJsyRBUgtKCTy2WmVD44luaMSw3TzOAF
         mL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776625704; x=1777230504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQkUjBuxdnOUANZ5UjsldqSwfxEKGSaidckWv/JhLQQ=;
        b=JJ9Yp8OEtPuuLFQC7w9wEpcy0fcEKqpKQ1x9CgIMVZhI4yn0LdHQoKj+f3SuYAazvg
         y0fxEFOwhHxYgByETdarqh8lZAxkkVonz8HsJmhF//sIvprCceS38Eww3v/kGIdIVCve
         Gf5v9BrT4DAl1qdU4o4aHLyeIT6iH+zHM6RIivDorg2fB72sxKjIEk9oqnaMP4pL6AOf
         e/1XXLXJGv6M9kP6BiG+QKY7Z5x591tyByl/xw2cBrnjK6EqOjR0gJt31LS/burm6ZIs
         R2Z930ifNJAKcQtE1oLzE/Rext4JT8/NNIVSSpMr1L5FVx+flS6dmLvcJ98plj//iQG5
         YAeQ==
X-Gm-Message-State: AOJu0Ywot42wjiD5oqIp8e74zOzUWo9ngGgisX7e4nCyhbdcYRr7DTyd
	1oR/w+XSDtzSGdjLAKiHGsbSNa7RWoLNLSgEUSE8bXciNfa9RNcgkmuls00kyyLOdHNKZEFyC5a
	o2v50YMVE+JtnA42+kOJ1BqKnEEoryzM=
X-Gm-Gg: AeBDiet2dUFZLYCQrww9JpAOe9oxyjsfQ8DoEiwBccABCTgZEYTHOtxugZc3KzX/hFt
	yZf+CoOOY+UoifNO9vbzl0BNd4+LKJg20d2H2p9/ArpDX5Zy12VmMCT85K5/+YTllS0IyeKRz+p
	B6lUlKqgzQ2vURFUHrI8HTL+SJhjKI8Q8ldD6t0mrGbx4JQVwBZsMDgbo6DR9qX2JRRm27xJrfq
	GKNovVyw2XKl7XtpYrdI7N3TG+1UMv2jGpN/05sY4RMSv88Xvz4wbeI+JZe5cPUG2imUaC8IDiF
	AoQ2jDV6iOzqNTb/irz7Ol/ctZPT+078wYqygO5OHcNb0TF0lKFG
X-Received: by 2002:a05:6402:4147:b0:670:6c27:91d0 with SMTP id
 4fb4d7f45d1cf-672c128da83mr3677328a12.7.1776625703988; Sun, 19 Apr 2026
 12:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c1519cfa-5a66-48b6-a578-e0ac03a57484.ref@yahoo.com> <c1519cfa-5a66-48b6-a578-e0ac03a57484@yahoo.com>
In-Reply-To: <c1519cfa-5a66-48b6-a578-e0ac03a57484@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 19 Apr 2026 16:08:10 -0300
X-Gm-Features: AQROBzDAeuVk_2Ck1CZSUROGOIo4Urde1any00vukJTHD31Zxl_i37_bu7orL4M
Message-ID: <CAJq09z5qWy5G+tou1JLSK=gO0Kji82zRaEc9WY-LC-LTjYhgyg@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: fix mode mask calculation
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>, alrazj.abdulkader@gmail.com
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279604-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B67CB4253A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK macro was shifting
> the 4-bit mask (0xF) by only (_extint % 2) bits instead of
> (_extint % 2) * 4. This caused the mask to overlap with the adjacent
> nibble when configuring odd-numbered external interfaces, selecting
> the wrong bits entirely.
>
> Align the shift calculation with the existing ...MODE_OFFSET macro.
>
> Signed-off-by: Abdulkader Alrezej <alrazj.abdulkader@gmail.com>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> ---
>  drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> index ad7044b295ec..b85c99216648 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> @@ -216,7 +216,7 @@
>                  (_extint) == 2 ? RTL8365MB_DIGITAL_INTERFACE_SELECT_REG1 : \
>                  0x0)
>  #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(_extint) \
> -               (0xF << (((_extint) % 2)))
> +               (0xF << (((_extint) % 2) * 4))
>  #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(_extint) \
>                 (((_extint) % 2) * 4)
>

Hello Abdulkader and Mieczyslaw,

This bug has been present since the subdriver submission. I renamed
the macro (d18b59f48b318) but I didn't change the logic. Maybe we just
got luck with defaults. The patch is good. You still missed the Fixes
tag. Just add before the first Signed-off-by:

Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver
for RTL8365MB-VC")

With that addiction, you can submit v2 with my Reviewed-by:

Regards,

Luiz

