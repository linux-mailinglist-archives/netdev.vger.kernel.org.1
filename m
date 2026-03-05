Return-Path: <netdev+bounces-264250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHYgNS9OqWlp4QAAu9opvQ
	(envelope-from <netdev+bounces-264250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:34:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71120E846
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94FC630351E5
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F29377EAF;
	Thu,  5 Mar 2026 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIbbReyH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27E378D9B
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703138; cv=pass; b=XN5ltThF1NwjrthyRWCDjENHAlLOsP1fyzq5+P2lLIcSPue8lxkOt5XxfkQ1NaVchCkexl+8b2Hg+vAy0qZSTlGZDFb/Zga2NeQ0UHN7vW4IfenoqS4n/1Ehl6dy0VlWf/GtZMe98+5ScZOF9YQmmRWol0m2R51lYPtJhggTR6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703138; c=relaxed/simple;
	bh=RENmnJM1StFeVcBlQEiftazQO5J3oL+VTPbg5x9EsMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttNURfCnk2Q2giGpPtGcqAFxUyjto1QmetaVuLYFdKz4j7yPtfNf9MLWqX/54nFdYcHYeeMv/bAU26dUDAv2HXdWJ7adI+NDMi1Re2TduN/5HVh0+yVbgbAiNWUA3QuP32xhpDLwecC1azU9axsnVGd8b3EISPX4gG2JQN4JzzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIbbReyH; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506cb1b63d0so92672711cf.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:32:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772703136; cv=none;
        d=google.com; s=arc-20240605;
        b=AO/5ZfwdvWo6922nlH0IOedt8zac4i77heB9c/ftAD5FtzXYgEqrmGkKjxfTT4tMx4
         VAqgfGyobOtyhM26W7yXHs9nzXnaquJRprdG+K3RxK0sUBW6VxH0/R19Rhw0E2Iiv/th
         0RwwXtmg7u5nuxnbwnWyM1m9u1xOw6c0vSiFc5Ii2t+J4kcC97O17px6583ogkCuziky
         +WlupzO+HNsoByE9v9lNmpqSw56seKP0cSErsXFdC3IX2jL1L6ysBrH2cOGybUUqnrpg
         nrgf6gAw5XOemDnpHv7BgoE7av9ylKcduvTZT4tIn/0EERPHByzSd07k6uutlh+8AoZ0
         xz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RENmnJM1StFeVcBlQEiftazQO5J3oL+VTPbg5x9EsMo=;
        fh=wqrg6giIczbfaT9oNaFkQWVPzER64Mky8ZpVAYZi7oA=;
        b=YFNzq326QJkp7/ZYfs1Zhj+kZyy802W4yJOSkHVXH9YJB90yBXjaZLYCbX2MAhg9NZ
         nzV8iAcVqim6YkMnQ82XIX8iKggXN7LIcZXTA2zFA+0RYkegNECd0dAM564z8wct5t9D
         VZheHFsXei8m6cymVD4/qzuuvHKtWIJzHDhtx9GQNqLRlVOq0Imz+Z91c4MzWjEJDs3J
         T8PUHmh39iyAkZKwjUeVg9aRNf+ew1X8DPfTk7lAtibWGZl366ceVTf+C97kTaiuT2BI
         maKuVRdoObobtL4+252M3QSTY2ph3l+oDZ7efjlkeDO8em2Xtfek1yBnPcQQpximgM7h
         xwdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772703136; x=1773307936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RENmnJM1StFeVcBlQEiftazQO5J3oL+VTPbg5x9EsMo=;
        b=PIbbReyHnFs5LQyjsWBImSzyB5LyKdYwPuTNghDzKpHTHI6afhGldzSoTOJz9bvXUC
         +AnS0ConZ3NAhiVc5DSmzEz+olRBgMwY4Bra8mO1mS8RyZFwigY9yWIDcyZPTxoN5+yl
         vN5h00AS+3dErYSFydodZxx7hX5KNIhfqzQS0OoTaH/nLLidmdkOe8tBcFTWFDbG8rsj
         enHknUt73zMGmoa1r/jF3UViBXtZah/S60pxxqy8hZd1cIw/MDm91NQTeQSt0WqXRghO
         ePrmZ5fmI7qly5XLmLcswl4Q6SpCQmPfpuCHa/YNn1xPt00dA0x5lvuO8jsd9+2yK/0L
         Ghnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772703136; x=1773307936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RENmnJM1StFeVcBlQEiftazQO5J3oL+VTPbg5x9EsMo=;
        b=hS6cvS99YwpBjbpLDOQrBTpOym7sPz9zY1e4QgcFxQhujexamd1N0HMxDbPUZIx0DO
         MzSRBZra1PCAf6gZxqnFXipNeWRbyR3z0429n3zKzKs0GafaA9zvmekjmbEnH/CIL+Uw
         /4va0/isfuNSGgHfeVKCz0mrNikftekULLEumJs1Yflurf7UBBhJSRFqQoBanqelmQJs
         jZ4UGpyfEOEM+ECzvFbgn8HktITZ0EM7cSJwogfWVjklyOKFak4bDyySmABrqtQn38rP
         pywURiPsoLzfYuvLWo5iMh6TkWqGPZxY4cEmvUeciLVAadsi7vvs75UUEe/SNopOe4aQ
         lSWA==
X-Forwarded-Encrypted: i=1; AJvYcCXlOo2TXUwvkjFaxSd4IQMeXLHLHwj1AS+Ip0RYb7FcJ0OGuyTpIOjB42ua8+LpfG/lChqYhbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3FDbO4/7tRXdrvIBkc+HyhxkneTaITmjV88qT7PP0GbE7Ufy
	yiGLOoYBjx6go7jOyofRTHMGfGQU7Ug/5+R9IuY7BlevaXsyWo2j1gPEHyvUahPjJZj1i85Ff6U
	p1GvVXYkU1HJCIFhRrzpRT1N2TF2VoaMoLYPvgSeE
X-Gm-Gg: ATEYQzxBVgPSvaPBi93yC7BylWtBugwyay5kONqVW/rSaTgQMQByhHk0ZAJ1F82XPyW
	CM2jm+u4/cYtWpMacHpTW/pu3SBKYQsvM7o4ns6yIHWUA3luP6RUsRgn4IeUMsIVPJu1AbJziaC
	1wNTHFkja1CZfJ/Ekg6c3WxkvOJiQTefr8pb7ZhVQI5sJTe6HjaIwYGHIlJmovjLN99LPfBIoXX
	PnviYM24NzQLXcjiDda46a4s3barLB65/29hqUb82y5VExdyh4n8Hi31zPC9Hz0sETtI/1D5wvl
	tXpTW8Y=
X-Received: by 2002:ac8:5d8a:0:b0:502:9b1f:ca3f with SMTP id
 d75a77b69052e-508db391c51mr64064341cf.56.1772703135817; Thu, 05 Mar 2026
 01:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305092706.145085-1-kota.toda@gmo-cybersecurity.com> <20260305092706.145085-2-kota.toda@gmo-cybersecurity.com>
In-Reply-To: <20260305092706.145085-2-kota.toda@gmo-cybersecurity.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Mar 2026 10:32:04 +0100
X-Gm-Features: AaiRm51hMAh932PzghSpv3LqrFjvhdQNyVEVu4x_YV8hRnYFAdJINXNtp3IvDMY
Message-ID: <CANn89iJ_NGSQkSZHNh_vuk9ftex4YCXJ0TMEooHMk4c7ejsjtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: bonding: fix type-confusion in bonding header_ops
To: Kota Toda <kota.toda@gmo-cybersecurity.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7C71120E846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264250-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmo-cybersecurity.com:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 10:27=E2=80=AFAM Kota Toda
<kota.toda@gmo-cybersecurity.com> wrote:
>
> Add two members to struct bonding, bond_header_ops and
> header_slave_dev, to avoid type-confusion while keeping track of the
> slave's header_ops.

I suggest you write a detailed changelog.
Perhaps get help from various LLM.
Do not assume we have the context now.
We receive hundreds of patches per week, do not assume we have
infinite time for each of them.
Help us.
Please ?
Thank you.

