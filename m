Return-Path: <netdev+bounces-266544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACnWMpsusWkVrwIAu9opvQ
	(envelope-from <netdev+bounces-266544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:58:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C912025FD72
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AB6630095ED
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D912E92B3;
	Wed, 11 Mar 2026 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmZOrcsh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB53B8949
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219476; cv=pass; b=U06Hf5sIiasdgm/x6vJWmbYgx4/5jEjvmXK1evVxAVcixWso5VyN1BXRXBpZ58kdcKI0InYjqS6/exBP/5Crp/IJES50Wecv5j+j/1JpdsAu38R/57wA8LopoHQdPpGecoQXRHYzNacgccb52Xd740P7nSp2hB9cxLjRh43Buhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219476; c=relaxed/simple;
	bh=SzB/aA/TD/So63XD7gTkEVh7jqesG3jqxlGG0jXes+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpMzfRl0W4UoE6r4CS3wKbwq5oRDxfaU+V/VWjI2aAHTJBdIu1nN6fpqX/aJx6zE3ChU8/WuNtiCQR0YIWG9uLIZW4VtKgF/KLT0zG1CQuuIDhPUn5iCgDcikpZ0+0CD8orAZktIaJuU1GmSZ4ceLcklEOBkzV7nBQBkf87EMiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jmZOrcsh; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd7ecedf2cso346203485a.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 01:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773219472; cv=none;
        d=google.com; s=arc-20240605;
        b=cYRz3hI8VxYfPYccpDfrHIG/xpC/yPq7OlzAUKZjolRTcZmxzfHaeZqHdBVPG79FXb
         iD3+r0BUNttpKbp8gJ2nqX3F5gI06YysprktDhH8PuSKQNQENpReJ+W0YU7qSSbOeleL
         qAYVG8zq0iK/2JUM/hs+sRWnklCLekrfH5gAfWTutyFQptDAcGb7s8KCUP5/xqABBor9
         nZtj7qje/zL0l7N7KlymbqegC4ypDViwbsSWUKL27keyP5TpAFxZ2yYWd321o0lIuUXx
         1hLWlDiDBjyR7ktpkcxa2fiTdNShhMeRgbALfb1vKtGtjHl7CRNnvnv3JeL+0080g/0H
         UAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8JHjqm5FfWew/5hPCXxrRtDXNu5TVPSGZVgHwRYGjd4=;
        fh=dSvFYbRMWSnQPC/51Ntp3jlkFeHZyl93PPtn+4T/S10=;
        b=csvmilEaixj073IsdRRI0CX0eYculPyz51XkPGQNg70lbZ5EGsThLgw22EOLq4OB4Q
         thSDBB3YQQieZtMrLtCR4MDWPW97lyOU+i5pgdHSVDi+LB9c7WSAD/uNwczcvnTYFdwe
         jIDh5WotW96eXHTd8qtcsYrTWq31k1Co77a0L0TkduYdwA7gw9o4dLs65xKZP0ilzVVn
         3BCFFrlAKcNH51hEwzIvxqtQ6fUAwJYoR0CsD7Uzrf2xT7m2k4jxSRJGgG/3eJ3Zr0tq
         8RFfnMtjtQx627sRPzOeAZtg8WTy3WbZN4jl2JeJiFg+zee5bMHOo1Gd+IGu+8bne/T+
         /S1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773219472; x=1773824272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JHjqm5FfWew/5hPCXxrRtDXNu5TVPSGZVgHwRYGjd4=;
        b=jmZOrcsh+aCQCfjKb4uOlsfDi3eu+8zY7EWxfuZhV4hvDF+IQKPkrn7HWMjIZ1jb8e
         wpo5tFCiSsdzfEU54tSFDu16SB+woJpyiCv3Nh+6zcyfuT5Y16EwN1SlL/5VZOBOGDD8
         htZbih3VAIaNjLBgvtQBZrMtCQo3F0omVTlkvdG0TNjlXCRrsaN+kMM47BGY85xRzYp6
         z3/6FkeyECu0eQo8yqG/6B/1z8NrLmizZBu0QVb3qAQaWci0Rk5m/8HWh6DUobnrD+Tt
         CL0lQPV5S62+VpUf4hyW4dN8ts135jJb03P6mpROvKm68qJJhWBn0xZXZXsAwKp2xhS5
         cj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219472; x=1773824272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8JHjqm5FfWew/5hPCXxrRtDXNu5TVPSGZVgHwRYGjd4=;
        b=m8simATu8lhixDv+LsRi/hkmMFW24hem4a1/L6Mx2z8dJXfHqMdO3WiKCwWhgoFS3B
         49AThmpHSnoo3+COgto9HYGfT5AcXOjORyUjECf2hbPeYL29fNQmGiCInyMLWoPffnjI
         geYS/bVgBvsTmQPFSbJqNK/5FdJp7c5JgVyIo2gWHXKt5Ii4WVmtFECCR2ihhgctZNoi
         jd2N2zHkQMgVVzXVAgNk+byUim/F1qjQh1dD3iLv2XIU59pEyAy7A8SN+QOXwIH3EIq0
         cOtv3ECJv/I8YgTQzx+Nu2xXDS5bHSTKoQRGYCEqak3rX4oAlLBiXfaPWNi39FL6hvGS
         A9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUegle5b3+Tip/+fq0fcgsoYxLmYKQVN2VnhbdekEQjdc0qAz57gnIwwoT9Mbjc7lA0Fg2Fkf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1fRYwMbt0ZQw8zKg1vKWKcOBJaBDGiPFs11erK7e7D2JYNd7
	NY9371zjDF1d02jiJIhITQTthKAx8WbqKqqyus0F9c/yhy/sOLXa7jGuWDcw4HkAqvhYkRRrmC9
	vx5lVhIKJAqflMk/BcQdSyAeVVrrjw0jRb7AAl35e
X-Gm-Gg: ATEYQzwmNGodklGK5gWszpMWNncvQ3kHGkFlDNY/ahngP2hbgmC4yKWdc0UmVoEyaxU
	5YpLx6hyHn1+Z8OK34PqH7DVTD6jd7uFTWqMFQz1TUvLQEJ/xkYmxPm81sNiO/zNsQSvmJU0FSA
	eLrcxvJ588axa7PeXmrZ+6D5hBX7MA7Vmt14JYzoWirr0eKYli+sq/TDZIv6eqZW0Pj/QPANBPA
	33gy+GfQUqLkAN2wWq0vldelkqJRuwjU4765hhDqvEaFES8uuOa0ArkYRrbpxZ9bQX62XoTRfq+
	zQSaOTEf
X-Received: by 2002:a05:620a:198a:b0:883:c768:200a with SMTP id
 af79cd13be357-8cda1974334mr204022785a.32.1773219472102; Wed, 11 Mar 2026
 01:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311072330.96491-1-heminhong@kylinos.cn>
In-Reply-To: <20260311072330.96491-1-heminhong@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Mar 2026 09:57:41 +0100
X-Gm-Features: AaiRm51xEv_4lBrbcchqqSZFTplmhH41N5NFvFrDLscbC9QlkWptXQab3miNahI
Message-ID: <CANn89iLBN-fxUQ11Txtn73XQ6M9mrpaWEfjK=EfMU8UO1yOdBw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: sr: Add unlikely hint to idev NULL check in seg6_hmac_validate_skb
To: Minhong He <heminhong@kylinos.cn>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	david.lebrun@uclouvain.be, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C912025FD72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266544-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 8:23=E2=80=AFAM Minhong He <heminhong@kylinos.cn> w=
rote:
>
> In seg6_hmac_validate_skb(), the pointer returned by __in6_dev_get()
> can theoretically be NULL if the network device lacks proper IPv6
> initialization or is being torn down. However, this is an exceptional
> error path; in normal operation, the device will always have a valid
> inet6_dev structure.
>
> Marking this NULL check with unlikely() helps the compiler optimize
> branch prediction and code layout. It ensures that the common case
> (valid idev) remains in the hot path, while the error handling code
> is placed out of line, improving CPU pipeline efficiency for high-speed
> SRv6 packet processing.

This section is unnecessary and dubious ?
Note that both clang and gcc already generate the correct code without
the unlikely()
So your claim about "CPU pipeline efficiency" is quite strange to me.

Let's keep the changelogs concise and focused on the real issue at hand.

Thanks.

> Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  net/ipv6/seg6_hmac.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index ee6bac0160ac..a8f279ffb678 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -184,6 +184,8 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
>         int require_hmac;
>
>         idev =3D __in6_dev_get(skb->dev);
> +       if (unlikely(!idev))
> +               return false;
>
>         srh =3D (struct ipv6_sr_hdr *)skb_transport_header(skb);
>
> --
> 2.25.1
>

