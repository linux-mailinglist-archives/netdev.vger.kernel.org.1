Return-Path: <netdev+bounces-259368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FUHHRI4lmk/cgIAu9opvQ
	(envelope-from <netdev+bounces-259368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 23:07:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E915A90A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 23:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1821C3003824
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA74259CBD;
	Wed, 18 Feb 2026 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JG7trfNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69EF21E087
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771452427; cv=pass; b=BrW/brfxkZuSVegKiYbZPOlOq59x7eSuy610pWWdJKONEQwOenxQUrTBtaXyOtAtptaLUZssOQrtdoO/ZEoWRYcRsMAWo9L9NF0vb/hTcXyPL3bKf4YMyAXkr16rD8uG1Z1rdtsv1nf5VRV3rM8rQiLIQuLtoOc6SkIKrxy8LQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771452427; c=relaxed/simple;
	bh=24oIZ6z6a8wyup1XjhyDbOy5p1Py0WW9CwjcbQd5SCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7I5teOCDNQjz3RaQnR0CLZuM4m6SYDkhZKxvWWGJOfKdBkHmhSL4rJWW1rAKlOeVp+OBhGN9PXV/M0/9S9J52hAKVSROZDu2CSS/d0zamWxc6D2qpH8pNBix+gxsDu7IN8//K51mXkT/wm/WTOMBc1lFcVo3lIQN672ZWjpii4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JG7trfNz; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-127423bea4bso593268c88.0
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 14:07:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771452426; cv=none;
        d=google.com; s=arc-20240605;
        b=cmJpnI3TeSR4kHxSswsEhLrmbEU1vJVI+joZRr2PIa5JDI4bxSJRCVuoR0vNENQ2iC
         dFaXfoQhHlW2m8iQlKBlQFS1EC9BY0B/nFgd1jVe1NhDA+uBRrrffoFCb8mZUU3cr2us
         1tH2FY+tftHUTVfHMGeTNmmelYQatQFTWFYP7oJt19o+qStDxEJAfzU755917yDKN7xP
         NsMCRT/3xaY6Z/naiQxiXCABa9tHq1YMToIjQYBtVTEhQEtiRz0PBdJKOryISQEDCFUm
         ueOxthual2ZGyCY+t8XFVQmyPujftAPAWCs/CVH6YUhUgKorj9DoKXrTBUdglpQnyzs5
         0fjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=upgIouNmO2lLGk4tTJnTzp21zosVBdGTXywqeDbkIAU=;
        fh=9Qqle8TrxcSCjMhnS+AZY2nZweO9mdgzEVQ182pkTuQ=;
        b=IDfgc38JcHGuxiuodC5WsJq9l6/BqiYUuzS8w9u3vkMrHsqKnqeLDWzRgaaX2cw6lk
         nZKF1FS3nvzhSAkDOzElbufYJUtqgI8Xb2+6EFYSqDCxXroZVvmqH9hlAG4nSclf2Z5m
         qhggmDRj7DVi0uFwx0k4+yS4hjA1KKrZnqUIW2Ji5o3pXK55LCj7Wy7xEGZgcIi+phk6
         EP06GjVvJFvADm89jV0ahOpThAjH9GM4Naqd+lCjN9FiXmTcV6keOD8E+VfVF4gJyr8/
         9sgfS/3xRmYm99jUBFvXurM7gz24xGw4OCtgI0OJZLXaGWNn5gi/sSlgOK66Utn/pTXy
         CjFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771452426; x=1772057226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upgIouNmO2lLGk4tTJnTzp21zosVBdGTXywqeDbkIAU=;
        b=JG7trfNzTsDa3zZb65hQfGojqSr5iOe7CKr39QnQkk+9/S6mnQcNsdBiK00vYZByxq
         ZfYTv8hxAiMjCJ78dx5qgRm8/Qy9ssp2UEKk3MlAe6m/peEOrbj3+AUCE1kDuJQ5qliD
         XhTcKeY7JW9MC31NIwTUfi+CFu4c+utCRe3xQ/mMBEUefn/4nInnZ8rLctjJN4560Xbd
         OIUQ/HaiAUnHHI8WMm1j3kFugnS1lUKa87556uev6eWs98J7LdqFGc7CdGJQ4/hMw4V2
         3Am+rrMBH9tD5Obcme7r58uUk+EitAsU0DkJDPgtcabc1PczZlzVkM9VmDqIHaOsCKOp
         8hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771452426; x=1772057226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=upgIouNmO2lLGk4tTJnTzp21zosVBdGTXywqeDbkIAU=;
        b=nx/UNRcsXcsewgedn9ZdG5VcXTimnxberc1uT/Q/LF/03VOb9gAEUXoTbXfMjI7zmD
         jOTduMjZWHoOvVhrxYWYONigGPvHKLjsqSYhBKfZdOfcj7PkoAVX6UD8lBAccUUszaWs
         2wLUvaPBC6dDpU3A0/xfeOrGBKCVinVCrNyxlpzDGNEZ7kbyJO/jcf3CMb1WR89M8hml
         ySxVPxyUbMX0UzC0RxgIylLtYCs4IisynxaW3PI78woF+4tl/dIaCkAxO9arug6DWsQC
         3XG2zolspsurIh3wwbBLm5io/wFXDNClYTh5DuYBTvdjDRjifr2oOlq5/XpLt1AzUAH4
         efOQ==
X-Gm-Message-State: AOJu0Yxrnjj3oxniIxmwmjxWGEEdf6RGZZFDZ9ZI0XlQzhkWnfo4X++i
	pJ59Z7kNuTK8IZjyqbJaDBaXlHH3fRrBtTjjuWpucCdqGz7X244YMUxQd5BY8I/Wa/ZVga3rRH3
	BBAaSMEEk/c3KUzc9h+fFo2PViW/vb/2hmjiVqajj
X-Gm-Gg: AZuq6aKssnKerMlPu8ZkIAT5JabgUiNgIoKmDsKn6Ph0/LSP5aQ4Ni0WF0ZGXbhPHvh
	k9s7scKOzxDoMAPZ1/At2zfXjXLI2VPkejn77/HHoesPn7JqTQnQu2782sK/smk9wH8P2H2UWZb
	utok6wF3SEltR2WhLM/bButQekUtnaQLGsRL8e2TlzqhEGfdxa5my4GY+VU2O7WxKjlkIqpRkEY
	6kIXawMFgMSsGVPoVI5OgsK+k7bMK6/h87XDOnnXnbuEYm9f0J8vaTuR3jjrPpRa6jY1A0hpFl4
	JZU26Xbb4Tdr8KVqDYC+YNkXWUYm7BJghyDoaVc966nMnX9440Hfu0ojPct2pIk9glFr2g==
X-Received: by 2002:a05:7022:4398:b0:127:33e0:ea33 with SMTP id
 a92af1059eb24-1273adefad4mr9009006c88.22.1771452425389; Wed, 18 Feb 2026
 14:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218214550.53342-1-sam@gib.games>
In-Reply-To: <20260218214550.53342-1-sam@gib.games>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 18 Feb 2026 14:06:54 -0800
X-Gm-Features: AaiRm532BbTK10fdwGI20IZDqg6vl5jsKbGOY8WA6GZZGuENfmKYU3o9edDTQEk
Message-ID: <CAAVpQUBjcsEqhzhCqEn9C+UnJenT+FS2ojKu2Z1y+5ppruJqgQ@mail.gmail.com>
Subject: Re: [PATCH] nfc: llcp: check skb tailroom before appending TLV
To: Sam Swicegood <samswicegood@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, Sam Swicegood <sam@gib.games>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259368-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7A4E915A90A
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 1:46=E2=80=AFPM Sam Swicegood <samswicegood@gmail.c=
om> wrote:
>
> llcp_add_tlv() appends TLV data to an skb using skb_put_data()
> without first verifying that sufficient tailroom is available.

This is because all callers (nfc_llcp_send_connect() and
nfc_llcp_send_cc()) calculate the necessary tailroom and
allocate skb with llcp_allocate_pdu(), no ?


>
> Add a tailroom check to avoid writing past end of the skb when
> building LLCP PDUs.
>
> Signed-off-by: Sam Swicegood <sam@gib.games>
> ---
>  net/nfc/llcp_commands.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index b652323bc2c1..10acc5da954f 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -300,9 +300,10 @@ static struct sk_buff *llcp_add_header(struct sk_buf=
f *pdu,
>  static struct sk_buff *llcp_add_tlv(struct sk_buff *pdu, const u8 *tlv,
>                                     u8 tlv_length)
>  {
> -       /* XXX Add an skb length check */
> +       if (!pdu || !tlv)
> +               return NULL;
>
> -       if (tlv =3D=3D NULL)
> +       if (skb_tailroom(pdu) < tlv_length)
>                 return NULL;
>
>         skb_put_data(pdu, tlv, tlv_length);
> --
> 2.43.0
>

