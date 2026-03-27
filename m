Return-Path: <netdev+bounces-272689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGEYGIn7xmkaRAUAu9opvQ
	(envelope-from <netdev+bounces-272689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 22:50:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAA934BCFF
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 22:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A980300F10A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091436C0B9;
	Fri, 27 Mar 2026 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyybqFk8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92380126C03
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774648135; cv=pass; b=OvDNBM19Rg2V/gQSWmI5fxQk0t6F6YSo+/RIb27/LmiSUltniuw0KfKQI/MlYgFQ4VpjNAexWfk1Sd39w6VEEUSFadUwFNkMplRHkogYeDU263xxLiqMPP6wbTxUM4/nYfEchBjR+BOXlYjarKtfhkURNPefUrFUIqROVXqkh0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774648135; c=relaxed/simple;
	bh=BVOIDWkdaoaJEhYPvEmwD+WOaMrXt46eBhdOT7T6CgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdHpjLBfQ9iXsUsfRGHWG8RfMBm8dAR2Zj3ot5zQdMvZ2XGe0TsGy+JtoxS/AnXvJju2kHXU8qjJWqJO2jyBGh8WY0MMcAHQXOVvtS9yCe5oOrzJHc4ruKPO2yCdQew0pkvee3kCfDBmnxuckR+PS7TsaCqd/WAvorHp6oTct3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DyybqFk8; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50697d6a69cso14228711cf.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774648133; cv=none;
        d=google.com; s=arc-20240605;
        b=SF46qYt1+vVxPERANCXTdhxPzfZHqob9bjRDpOoK78qQaG8lgArOZNzYSW8snMuX0J
         Lq5Wpe5OxfrYmsk2aWoOtDMmVHAdXuYssEjnC1CCOIrA5G3K1QsMSeIAejOti+1s5hSV
         E2TrmdjSe9mFj7FgS/DpwpZUWo8y1AnLNbhmcE1vwxLGqfxn4TCr7ryqvu9iHULQ192H
         cgleeRbnScibgIQk+lI65kY6P8oykX/48AcG5NZN6Za1CKWGk0rDMWjQ+F8lyG/7QA+8
         WTMVy4TqO0TrRyM28hWUauf4vKT7tFTFs1s4QuxjkcFBARGkALis8KozhWrAianwguXS
         ki2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVOIDWkdaoaJEhYPvEmwD+WOaMrXt46eBhdOT7T6CgE=;
        fh=mHJy/SJlJ5v+UtBatf15YE8EtqUdX3nGZ8afbomGoq4=;
        b=bS6Lr03yRMPIQYM/UY8arBvjsgpiZPytkD27rqXfpXY4lmh+lXYJKA+jr6saa53XWD
         7FTLVDwmOrk9FdY2TMTjhf4k67pIJGVwXbqFrAgyDIdjPyzaP9x5eec6hS9WO8JmKxz0
         Mmc3WQSG6/ssfKaDgtAfd4arUVPdzBkP7bAOEvatttbThLI4R1/qLso1TXj2yvqsgMwU
         TqIh2HmPByko0rCRVaxgaLkrO0RNYGpikIJ4q4ZWNYVHJ6BNSQr1AkB5SHvX5SoYbHmf
         Lq+mn4p3lnVl56uLrCLcbOXIPs21jIABsaYpJAyyftZ4oCn/im8k97RQhZ4WWVnrsnFC
         1NvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774648133; x=1775252933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVOIDWkdaoaJEhYPvEmwD+WOaMrXt46eBhdOT7T6CgE=;
        b=DyybqFk8o/dKzWHNPL/jDBIDx2JMGgA2VCxY/ArZB8Lrt1vH0FB6U/jnwEN3ZXJe/T
         nUn5mQORENnlIdAFNtoEj+80H+3ol2veeuLQaeF9ibXhVlIyiKbkJYt0bZPHVfrG/guM
         PPbXPzCtKb6KasgZTKK33/dKRHMbTpllGjmvUHR36LhyyF800lKMyWDkVoRXS39GlBj0
         D4/Yb29u8ZB8ainwA4ZLJoEeWnL1YrIHndk05mT3g4nH0Y7ihHRADVthjSGYozOfxibw
         syCHM4jVi5//YNbIGNhU5N6CjPmcRJQwgZ/a9ffET5OTquh6XTgk+vJ+U1bbGHwjjH3Y
         huXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774648133; x=1775252933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVOIDWkdaoaJEhYPvEmwD+WOaMrXt46eBhdOT7T6CgE=;
        b=mCj1P6zkSQzj7yOGNDkDT65+l6wW36Jdghz34KX8J7AnjuOHAJN1EkIGVmC85kx8vH
         jmokdThwUtz6b6NwbnvcmuPhedo37PPAaUGAUf7RC53/b+l6NlYqNBUVi9UiT2GH/5iP
         Q03QKvB0oiteM5Z74jm04xzz9o60ttEMy5QQkYTpOLHtiikT4C3GQQXx+qRLyTEKSBAW
         kBGolgkDnrj6/VQzskZYOme9ruQa8sYPwNmYsg7ed4Qf1n5OlevfPLt3qAD3ebRWXu19
         giZF0MLSRKU/Wktos+29IIJfhcvxlPwu3SYadqOZm5vUCzt0ZiEzxXXTU80ugPj5i5js
         wthA==
X-Forwarded-Encrypted: i=1; AJvYcCU6GAahpw0/ejANK3yekoKdz3ZWO8EVcdnIrURf+XRdQwaiqULmuJL+HdBih/O+UP9Mrt8a7hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5MKngj9MF1OUUQ1sHDXlfvocTzlJQahoi6FYDxyR5TMxaiv8
	S+5MYCkx9XpRD7aSZZS/WqypYpwb+u3D3muFhIgQJoCcEEM5KMldB3vVZNqmm8TeUyIAAvn35T7
	NuQ6c5VKXX9vn7krm5++nJZzOyKK3yA+IPkUkvUlE
X-Gm-Gg: ATEYQzxt+diguvjTCNZs12HY7swgZHS5OaRbEZPkhoXvWnV9bflLdKpFnDgEUmtmk24
	Xynx6GtE1enHuAPX0gbXDNrOqKdvfabvvB1AjToEwGPwWZrJhUG5Pra/SV4t+gDxBjTZI7Dd4iB
	1R+X0QOqK8wmHbzO6Lt1u9eRQ8FPzK3rOnLv+Ehf8HdNv0wB40wCc16teWqPu8wuGMM1VZC9sbe
	dsiDknPWOTIKrfbV7bAMKlZmxTtbVTnXX1zWkLZsCNsbYcecEcOZCrqrZaMjXk7jee1008/57oz
	ETvF0lkDoyvJAODdzOsnANsbjI5BH8jdxF4/MA==
X-Received: by 2002:a05:622a:18a8:b0:50b:4435:5dfd with SMTP id
 d75a77b69052e-50ba380813dmr56165771cf.1.1774648133025; Fri, 27 Mar 2026
 14:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327213441.3781433-1-kuniyu@google.com>
In-Reply-To: <20260327213441.3781433-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Mar 2026 14:48:42 -0700
X-Gm-Features: AQROBzA5wXbKCQCtgq5tpqEK90DQygFOMoBzdfo9_uDmLCqqSc-xIDHBY6mbDCM
Message-ID: <CANn89iLshTzN95t+GV0Tk97n_BCDzjAGDNTb=vSyF1rQNqwe_A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272689-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: ADAA934BCFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 2:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> dev->type could be any value on tun due to TUNSETLINK.
>
> Let's not warn about it in netdev_lock_pos().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Hmmm... should we instead have a list of supported types ?

And reject user space requests for unsupported ones ?

