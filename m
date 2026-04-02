Return-Path: <netdev+bounces-274307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAjwHU7CzWnwggYAu9opvQ
	(envelope-from <netdev+bounces-274307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:11:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEB13822C1
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1AE300A754
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 01:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D579729B77E;
	Thu,  2 Apr 2026 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtdyU77a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490E19C54E
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775092285; cv=pass; b=X/zVlO97EbPboHtT8L6sSLgOxHzObRiHnvECgzpzK/QgCcATpng98hywdjoZFQiNAlajoCZdhD5bbuFbdQck74rFeReMovGCX9Q7wZSybUylPXfTzpVgsNs/It0DsEc6SMwdZeZLRoCuG9CyafqlmOdrfZgcsBLCJmMd7c5MS0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775092285; c=relaxed/simple;
	bh=ybRp2nQVdYwECBbqr2kBiJPOvzsiAtUAQNZTeAFmlrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QG7b3OBDlG5Ro7Y8BbKFyLoOupM/ZTde/cmA/Zuait0ZldbhurcBJLg/JWCW5CeOlvlSaVyJiQTeWjF0lrOpYFdYt5KYbWd0zQo+VMifxEc6nuMpGiIrWoTtbQ0WDhUbX3U/27gkvbsin71eibG604EXG458wDu13yfdwMb+pLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EtdyU77a; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50bc115f206so3394781cf.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 18:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775092283; cv=none;
        d=google.com; s=arc-20240605;
        b=Qww6Sloai0Y3YoeHeJYC8xz9WG92qf9VD4O6jbT2QpKDsDPMtungqMr8gTmWT0cp20
         jQAN9i2SBiJsK3+1+BjWxTiram8+PoNEsvg0efifoXFWNhUfGdyqbZP6gaEFfXUfY17R
         rv5s55k9Tj/k+ofl0/bFeE4RkWEEcCRvXPlo6lw3qdMeYp1Il26TOWQZFf/67fwLCu/J
         sF5Rseq4UrmM0EnpZD8fQ6hEwsaaUAwCU+aUBiqWLQ9HH+bYxI8Zq7RwaFYzRfyETR5K
         AjS0USAEI+6CkmBaZa3uvu3ixdWhF0uCTV3ZmYZYHy0IxGTdPpR3F1QwFa6QhAp60LV0
         e2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vgC8czkJE+oF5IOa/xG/6wzEqhHlajlnGv0tYjyGKks=;
        fh=h7HZwghl36LshsqG4cdbBSpb1bjmQguERLkRXRi5/HU=;
        b=U5N6VMparwawESF7IJKAtqhfetuAIrc46fVv5IJwz1BtLSfq4ok6bem5AAGNafU7CZ
         aKXPZTZDBGh8u08v7TWpCfp/5tEaP7d1fN0kLLg9krNx8DdGzIgqUarItBSgZSkNLkX+
         SnjG22ydzdnu3Cd/DPyk8JiskCT4G4dWFD/Iwae6mnO1H6z7BbebAb2AQhUkk8gg533r
         cA+8VD2AP0NQ/MrELmV99MK+E2uUSj4tOC3pbtPkyK0dNkAF57MQyjibJIhw6+XpgB+d
         nsAb+8oDL5SC4cpD4X/k1ulFzdjSvlY8g05ZpOWDbZTcGTYGAK6uweqkbZn6hIVaM0bw
         rc0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775092283; x=1775697083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgC8czkJE+oF5IOa/xG/6wzEqhHlajlnGv0tYjyGKks=;
        b=EtdyU77aDK0aHWyVRE1RKy5qoENZvzbrVbwA9/L5dnhzzKjHRkGdiADLbnDSvbal5W
         JwplzxC3F7GC7La0XBYPujhxbMVK9XjPly23KTP+r7eaA+rsYGIm2rmnwCMCecyhM42Y
         2dRqN6cZ7eiUfh04S/HWL4m4rMSyQikXDzJvX59e5cqqDbz6B0Ix+WTJdoywINPXCOP0
         9zt5xdDqWJuyY3vZN+cqKMb+QWN+bwjPVFmTggS7YCxUSZHXGWqmc46YCpYEtuqY/APy
         kfinCXjSDrNbHZPNaYVkMf3pGnCQg0YpwgKCGUx90C2UD5RJUv7plc/Jg4en/5P1p+iF
         XqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775092283; x=1775697083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vgC8czkJE+oF5IOa/xG/6wzEqhHlajlnGv0tYjyGKks=;
        b=hXhjR/djorOkyAziv1SbXUAoHMrmtsVNngt6J5YOpqPzcTHcmbkfWPI7TJpFPfVZQH
         qXwjIJ5Bvad+FI23U0SyUAML2nG0LKiIOgHbuZKzsGp3TlIej0u9dEDxKKECsXXsTgHI
         gVjhRM+J6EYCIEtT5GpGuUfI7Z2ss9FYvkMyqvHSUSB0GtTyutxIABmyqDDTeZ55tEUg
         2ZM/hoc6R1RqrHlkEFlgOno53CB2Zd5Q8SMZrSUpHR+pPkUkOfI6muPV7JNT+mXVRHQ9
         6ZhflrJP66SlkucWX/gTwm4iE4VwUiW87l4T9HcIwobrVQ3dUIJ5gU3isah1n164V5Uj
         T14w==
X-Forwarded-Encrypted: i=1; AJvYcCWlmO4EQI6Cho6kD3PAPspX4YZV0KhazfiPiDlf/aN50OKDFO42cHRBs+WCe+R0sDjpwbpeIEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJc6AX77Q75v0q1Y1ffiOEyn2d/HoD/Z7W9Y9+AhpBilBDIZ5A
	s+C86jIHDXcxKPAwJT6Omc5wRX+4ygA2yrCb5mz8vooV4g4G/bemFhm9ifsIEX2ZpD+Mq5LaJeP
	fgkuL5AHGnYs8bhhTZUuzQ8JdQ7ohTgRAQB/Cj8kLZR+fsNHYjnJhwLmwBwY=
X-Gm-Gg: ATEYQzwjW/j95GXvRRhCqsM23LGr5gHAedOx53zT6QaE+idEtn7GRJDrKL9Ki6SRJlP
	SapMWEXNm0MeBVt+r0j/Y/TeNgW442lsJqvm8En45e8RNjEuptcDpoN+qpFCrTu6TB0bE1+K69+
	08wcKBehj2smMtkUM0AjDSi5nfs/g3nhiRqsjvLbgVvNhEA14zGgUbshrthWuNLiobkBhHzOKYf
	HdmM2rYrEsYA1tZWHZfKHuSTzBA87Rt4tdgPzxpyYJGf6SdFriBL1IYnqt4k14Hb2eIlitni7wB
	M4sNa8ys
X-Received: by 2002:a05:622a:5e15:b0:50b:86f5:8fbb with SMTP id
 d75a77b69052e-50d3bd08bebmr83704021cf.38.1775092282741; Wed, 01 Apr 2026
 18:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401135304.3629615-1-edumazet@google.com>
In-Reply-To: <20260401135304.3629615-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 18:11:11 -0700
X-Gm-Features: AQROBzB28WgxqQ2X-jM2QQ7kRaBt3krDDe8fTw4ZxbRLAGZzylTiR5grV4Gtegk
Message-ID: <CANn89iL+W_r00r5KyaUCV=34zwt52gzvvOQHAf10CZfTFa-+og@mail.gmail.com>
Subject: Re: [PATCH net] net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-274307-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d8c285748fa7292580a9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDEB13822C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 6:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> lapbeth_data_transmit() expects the underlying device type
> to be ARPHRD_ETHER.
>
> Returning NOTIFY_BAD from lapbeth_device_event() makes sure
> bonding driver can not break this expectation.
>
> Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_E=
THER")
> Reported-by: syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69cd22a1.050a0220.70c3a.0002.GAE@g=
oogle.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/wan/lapbether.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> index f357a7ac70ac4756967730fa61c07258b4b3ac00..5c91160dd68cc1dfa4308d38f=
b111032206fae75 100644
> --- a/drivers/net/wan/lapbether.c
> +++ b/drivers/net/wan/lapbether.c
> @@ -473,6 +473,9 @@ static int lapbeth_device_event(struct notifier_block=
 *this,
>                 if (lapbeth)
>                         lapbeth_free_device(lapbeth);
>                 break;
> +       case NETDEV_PRE_TYPE_CHANGE:
> +               /* Our underlying device type must not change. */
> +               return NOTIFY_BAD;

I will send a v2, we need to guard this with lapbeth_get_x25_dev(dev)

pw-bot: changes-requested

