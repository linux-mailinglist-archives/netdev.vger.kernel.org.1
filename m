Return-Path: <netdev+bounces-260721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGnAIVZcnmlrUwQAu9opvQ
	(envelope-from <netdev+bounces-260721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:20:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D7A190D4C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C41030D6D21
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7026B26CE39;
	Wed, 25 Feb 2026 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg9duFII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4655526560A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771985446; cv=pass; b=add8XsnfdPXv1cupNHO/uf7NLn+O2Qcgnov0Stswdv7+L0eX8XdNPWbCYv8rpsAh6+Z2PLXDQoFiZ0gSh2NrGWESnWevwUTv4nuIdEFXL9MDTOfbUy//y9siZZO7wu4Qwv99AN9nRuxzPjm16pwbjeW4K1KDMbuChac0382jREg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771985446; c=relaxed/simple;
	bh=2Ia4JQRYF0+vu5ltlafPtPyaUjJd82F6ErOYljpmSaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqlYT9fqgBAkgGJA7ImbFKEGPGwsJgAprEEWwYXIQCWT+7bXRGdySh5JloiNg+dVsA7WDD8KxQAlpsdtfETMdq/CG2EALzYzFNX7E4AxJqk0V4iMLSspKknCePI5BkQHGsPmjyMzle9WeW6u+xUvV2KUmcaA93bQuKorbcdq33o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg9duFII; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-793fdbb8d3aso53555047b3.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 18:10:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771985444; cv=none;
        d=google.com; s=arc-20240605;
        b=PeVr99EXoX6IbF8WN7yVMAoz62MlPIg+qiEJ/vvi08jEuJBMwV5tGWPyPn476KQYYp
         17vmNs0bTp5Hj9iSaox69k3SBgnRAwxYRyJFlpKIl0i89khcqj2gOV8mjY3Rn8dlJLw+
         9Bze6pFQVpE/vIXBaACa44dMv23kzKYPZuSwMQvCEWOpnK8VnD1wyUeH+lcDumUId5Cd
         zyeE7R0ofnBkV05w2JRomMjD5D7Hd+DlNYJRhwW/Pn8s+5FRSbUWN5jozva3ARgH1A0x
         xhT/1KKJQ3xroMsDfpA/zXPShvfzBcEESOj+3zMlgFkTsclCp1u+pZEvPJZq7Tj/hsRP
         RlJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RewW6RsQuKBcy+FVC2qZgDOi7JEc3XkGCwTSJ1lCkm8=;
        fh=kjiZ8TKPCP4P3EDxs0ooDxMl4koc12JheTmFsr22b+A=;
        b=UTKwbG0B+4IT75Oz/ZJRcruO36ScnnVo4LLXlBhnbSg5aPqKtRMLY9tAGHL/DgDLyU
         KrA7qwothfbdKBXNfXiQXtaOFNr9b6ijV9TZ9R8DlCucxSGcykux+/t+F1Fu7jvDuHJR
         hWynNt+0jTiZ9d2Zm3b36jkG7uLNvThwcCElhpcjNhucimQfZbJwG285/EquIPzyoULk
         zfNMYjYNr4tgvK5tqD1K+dZVyUhXOvhuqOpfVauXt1BdtrBg2R/6vPr4/kfyVSfRtQ34
         GXRBqlfB/lUlWSlaMwelgQfwHsrMWKbETsAfnm99Yebo3/tVvSqYw/9Wx1V2vROitift
         IgHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771985444; x=1772590244; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RewW6RsQuKBcy+FVC2qZgDOi7JEc3XkGCwTSJ1lCkm8=;
        b=Sg9duFIIBzNagLlrMQ/BKm0QzaAlTtKU1nuhkjG19YHOYFhDSvh5jKrZIc6JJPZNj1
         kGlq2pr00+a3Top2Vp86O1ehWkxCuoHLdcOye4Rb1I6Jtb/OIAZIeXsavqLZp7XtQhfW
         lkpTb5LRqZc4NZ8xTCm1VfA4W7Z2wolTpGR5QiljmJ1c4ho2nQUWg0FhpNz7Tn5uBeVu
         nsZJmYOVZO3CUeynXG14ZPIf+7OBuUDg87D+i8mRlEIypuhLH6ab6g6B+hWwil+plSkC
         av0CtBdpG+Y35pkIr/mK7eiZAGPnATZYGUtvHgAQp/Zy8iPb4gvRunKk92erjR2Vgi0E
         kuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771985444; x=1772590244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RewW6RsQuKBcy+FVC2qZgDOi7JEc3XkGCwTSJ1lCkm8=;
        b=bN5iog5nWHY5ChiL3r+nSSvEI25lz4Z5fOYUiylH/DqqYVfALGxJg5BS1u5kaeG2me
         Ne4yn0bWjfk9RSvsQ3YDnWGEJahFbxE1GfX+qO4tNCHtPdlZxziBLcgQsw1u10mbTW1+
         qrZA0gBWSCWd9qISaFhP+b0Ck03A4xoXlmAqr8YTxJPcFacbTXnhSAOlVJA6Ncuv0o4V
         NR+j7r9oRP/HnJH/013os/wiZpB4u+XZI4IvipcqwDysH/fgwrF+KPo6aE/qeYTC4lZ6
         qs1MjJVu8E75b8nMu/53YUdpzZx+pbwLtWQp1uaJ2KX7RPvJIPe9Qd1UbMMNRAaK/E6M
         mBsA==
X-Gm-Message-State: AOJu0YwwiUB+RxtasehHwm3r1vuFW8whGf5DfS+z++sHzGGeMVmIgTo/
	jH245TB6+NaiACHL2dF8lJipqAg1TVUL2hUvTXqGg6f3PmE+VAB8WHhIjh/ZaImIWcUmSIRtknv
	FfAFTXLQCInU1soCZRwXD6Ys65Z2f3Hk=
X-Gm-Gg: ATEYQzyuzVVrT6MZo9l1sEKxDHoPoMm5Oq0KPUVVMnCt5x1NAOrKZuUF3tYC4+avY9i
	P6ysDt5lb5HNMFG6II9Cd2xWqXtPnDi2tp/XDsnpuYGyW3MAs41acDplVP2gSdVA8WulAHmHAUF
	AJUqpBOVw/U2HDBytJgf++J4sw4vDuuwKkuxJomQsMZVPJviTgePzEAsA5saUJDkfmyB0UBzNus
	jmKwMqXnriqV45R2IihsB3KNmCku2n1JpvtLZYjyyUWMglyxcukcQzMzIZADjbb/p6bi4C4pKGf
	f3io9jFki5LLiBZaykcQoZjE8w==
X-Received: by 2002:a05:690c:a92:b0:797:df7c:3e1b with SMTP id
 00721157ae682-79828ef29afmr127790467b3.4.1771985444319; Tue, 24 Feb 2026
 18:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
 <20260224113900.3331-1-sun.jian.kdev@gmail.com> <20260224154447.61be24de@kernel.org>
In-Reply-To: <20260224154447.61be24de@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 25 Feb 2026 10:10:32 +0800
X-Gm-Features: AaiRm50L-4FmoPTjMiSIpbVZQBpkITknQo3RkybcQdVthWClKqiATz6dSZ5LrwA
Message-ID: <CABFUUZFK6jr7Bf9W009vo1LhAnAgvrB1RhmGtYw4viku0+L+nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selftests/harness: order TEST_F and XFAIL_ADD constructors
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	davem@davemloft.net, horms@kernel.org, shuah@kernel.org, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260721-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 04D7A190D4C
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 07:38:59PM +0800, Sun Jian wrote:
> You inserted these defines between the kdoc for TEST_SIGNAL() and its
> definition.

Ack. I'll move the KSELFTEST_PRIO_* defines out of the TEST_SIGNAL() KDoc
block so the comment stays adjacent to the macro it documents.

> When you respin, two notes:
>  - please wait 24h after the previous version before sending a new one,
>    to allow people in all timezones to comment and avoid splintering
>    the discussion
>  - please start a new thread for each submission, and refer to the
>    previous one with a link in the changelog:

Ack as well. I'll wait at least 24h before respinning, and I'll send v3
as a new thread with lore links to v1/v2 in the changelog.

Thanks,
Sun Jian

