Return-Path: <netdev+bounces-256977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJENKZAvhGk90gMAu9opvQ
	(envelope-from <netdev+bounces-256977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:50:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A178EECD7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BAC7300EF87
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B13631B108;
	Thu,  5 Feb 2026 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="Iyauq83N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D952F99B8
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770270601; cv=pass; b=AI6ojWnu40jjvBdGOsUsIPG0crBlapy1+aFvXwZB/H1LlszAKpZas+91Kfw8mLYnOGi6EaTGd9bMTNyi6XZ21ooZgwreFBFuCeKuv18MV08k9yJ6+uj/u3K2QwYIReIQOWYrLiBXTaR9a/SjoylXN+i2KQiZVW2zbCkw/+AFFb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770270601; c=relaxed/simple;
	bh=wUrUSVOAOBRw8sN2+GSWIDqv+OT6sTgR0/Ilx8HyQr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i96w/PAPOl7jbY6v/hw+A/ZwuVka/IeV25DDXE0YR0tPPwA8c9GOPYZY/3Krs8k6Xk0olQkraFCmSp8c1JMynC4bEo7vvgy5ig7w0jN3MkBJF1jca/Atqi6MAsQT0WyRylOg/OUW+iDKpef0wlxiEpISC04pvF2sAKbbuJsMUUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=Iyauq83N; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d44b2df00aso237003a34.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 21:50:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770270600; cv=none;
        d=google.com; s=arc-20240605;
        b=QMbywS4yDXYfAPe9pOdXsJCCetV6bZcLpZfjX2nc0qD7JJ/7hwMUHlI2WkB8zM/2IC
         /wefMGKtbffkVCEW76kKz1zViSXI1LbqBF5pFh3khuMY4omDPWxjZNCUUlGfF0fidb5s
         M+wJfJWNNNTNLjwSICVtWyy5myuTMBNGZsRHPUPXWAHvkmbshFMx3YfV1X9e1oVi34v8
         L5alfoJ0LYYMuFbpfNWwkGZmXvtU5oz4c7wbN52EBzp5VpqzTOPnvpZQMHWErTx4ai/Z
         RpMtQYPKLIA6Z0RqIl2QWRipgmp0DHQoQDH+SP3n0H/kJfn1RhBYPlXvZV2jxQWpDgvQ
         aS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HUEVKuQ+WKi68vf3E7dfkg+LP5Mp/3JbWtuaF2f8NtI=;
        fh=IP52XDEWB8x+LXnMTvF4LuPL+i/cwmv9Di+2BtbDeoU=;
        b=bN9jSYr0AgKQADeOa+IXBYLp+xLiTTWHqT9QJC80LWbZ1pOjQa12w2U/O4TC0OdpBa
         oIuxOzfTgsy7Ki7FVftUgj7Iqf6H1huPAwpTvbVXZ9mVxT4idQZW6z402VVtNjc4IRYG
         l6/Y6uVnx6UzbaIfpWXQAc/hi1WtRrR4RgaBM2XRDqDi+88HQKcqY96G/tJqNCRh+E3D
         LbRCUAm5qnBARnrmmdVNaHip7c0xY/9wnWkiMgaGPDKwWhJV+7d/lbhV780a1Vw0lhJB
         D/68VZpleB5X+43imNEkDM5IEAuNzRMLe6EJniJcjfsgCui2TOalozbOZ4obfD5DubhD
         WQAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770270600; x=1770875400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUEVKuQ+WKi68vf3E7dfkg+LP5Mp/3JbWtuaF2f8NtI=;
        b=Iyauq83NdCU0CLlFRBP25gF9FP2TBLxw64kbwPDwuzGp5tIomo+uxAtISEJpjSPnIL
         RRIPICQtolNaVyyAblWnuUnpkEAi1zx8H1hy9oMJvLVshA6Oya4NYlxy5b/q/oP+GRwa
         NomVEi1TnPNMgh1tdv1VmTImuwlc4hMXWex2q5GDbcw1PicuXvPLgti/6U9Q4NpB6w5d
         EU59Xzzx8AqD7/2DsnI+Z8zhollWOM8c5jB/zAUknAOV4BDbLibb4pOVaQzi+Om7pbZ0
         L9RiGRQ2DMCSHqkMYRXTCEEy3TXoe8Ym5OH7q/3I8kYV17Z7UW2SJqVoR3ssd83Q39Ug
         VcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770270600; x=1770875400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUEVKuQ+WKi68vf3E7dfkg+LP5Mp/3JbWtuaF2f8NtI=;
        b=R2Yv532Ine2l9u0wORI74GxWDxwjioKfFxp2XnOYciLQ2/s8EL+WtrQbfzs5Ss6aKA
         0IGNcxgSEa+Rmn+FqTFhUOZb/HFPNvAhiwQfMZknEMv741otoUHMSMu/kJs8TDsj0whU
         Dv1VdGMQ+vHcnLM0M+7tXxo5kHQVFU5nhXjCscebK77NWWS/1MBm1WmbWPfxxV/PKqT7
         4lFll0SeXCsUu+7nXHEPojDZodRMyt6hC+xpkK55VxsmhCMIXPTXvpJJVNIDqvkmP4WN
         wq3sO7UJ804BkSTiDylSKxsvn86NpGT20H2av9wsrgw4DVF0WWQKOBkGJkrbGxPBDIud
         E2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4BrmLhcXWVqWxMV9vOS/UjAlKp/mmVmrtn3TUoAk0K1/oZbfkvEXRTz15688SIVJ5ummvvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iZHI5mQ/EvktX4o/ThA5wM0HQs0RAIju9fDtVWBigTtdFZ8d
	bJ+m3pWMXSQD9ameJm+8MHSN476f12U2qHNpRQ1T0eh4bxKCPkvST6DXxFYPXf0uomVt1u8lPyj
	BOJK1QXogVRQSV6aqnLvIek+uNJSLj6Vzc7xWNRdYkg==
X-Gm-Gg: AZuq6aIV/2CqJqagJNyS4xk+TSffl1pIOlQ7O5GzDbB1TogfpxmWjYyEtInePXApcX+
	WNAgYeEYulHqEXgrTcoL5TlsHzn7erjwWp+rmC0cdU5ekOa9VKJQa1sNeTomrM6YGcqcHAWJiPp
	CZrdbh2u8TWSjo0onj6p0p4hQKzw4hJz71nGqlZs4zIw/c4EgWoGLhpSJBbvqChx9KMdT9M0rkp
	iT1uQ8h70kQ4WVQqdG0T2FSIbmKoc2qSDEA/fzxbyEgRXOH0Y5bfgIeLxHL5L27WeIwZxIRf0LU
	ZS3uoiukm2Kx42udOscrkQf68vN4ohM/2h68OrG2v9M1rMhO/p77r7UDIUUtFRdMez6y+ks=
X-Received: by 2002:a05:6830:3c87:b0:7c7:2d7d:5d0f with SMTP id
 46e09a7af769-7d448ab77dbmr3345174a34.20.1770270599837; Wed, 04 Feb 2026
 21:49:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131044911.2257072-1-n7l8m4@u.northwestern.edu> <cc23a37e-3b12-4dd5-89a9-ed8977601379@redhat.com>
In-Reply-To: <cc23a37e-3b12-4dd5-89a9-ed8977601379@redhat.com>
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
Date: Wed, 4 Feb 2026 23:49:49 -0600
X-Gm-Features: AZwV_QiWVFoRm0kb1zkOD00gl9Y5kfR_qRHmONDUvLacQCfpQEtpwIOH2i-50gY
Message-ID: <CAMFT1=Y=FbjyqC6vr6fV74t8AmGVcecKw+YjX6V_iA7XgZtotA@mail.gmail.com>
Subject: Re: [PATCH v2] net: mscc: ocelot: add missing lock protection in ocelot_port_xmit()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256977-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u-northwestern-edu.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0A178EECD7
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 5:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> I'm under the impression this static_branch_unlikely() usage is racy,
> i.e. on CONFIG_PREEMPT kernel execution could enter this branch but not
> the paired lock.
>
> What about moving the 'Check timestamp' block in a separate helper and
> use a single static_branch_unlikely() branch? something alike the
> following, completely untested and unfinished:
>
>         if (!static_branch_unlikely(&ocelot_fdma_enabled)) {
>                 int ret =3D NETDEV_TX_OK;
>
>                 ocelot_lock_inj_grp(ocelot, 0);
>
>                 if (!ocelot_can_inject(ocelot, 0)) {
>                         ret =3D NETDEV_TX_BUSY;
>                         goto unlock;
>                 }
>
>                 if (!ocelot_timestamp_check())
>                         goto unlock;
>
>
>                 ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
>                 consume_skb(skb);
> unlock:
>                 ocelot_unlock_inj_grp(ocelot, 0);
>                 return ret;
>         }
>
>         if (!ocelot_timestamp_check())
>                 return NETDEV_TX_OK;
>         ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
>         return NETDEV_TX_OK;
>
> Well, after scratching the above, I noted it would probably better to
> invert the two branches...


Hi Paolo,

Thank you very much for your review and comments!

How about we use a new separate helper function like this for previous
'Check timestamp' block:

```
  static bool ocelot_xmit_timestamp(struct ocelot *ocelot, int port,
                                   struct sk_buff *skb, u32 *rew_op)
  {
        if (ocelot->ptp && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
                struct sk_buff *clone =3D NULL;

                if (ocelot_port_txtstamp_request(ocelot, port, skb, &clone)=
) {
                        kfree_skb(skb);
                        return false;
                }

                if (clone)
                        OCELOT_SKB_CB(skb)->clone =3D clone;

                *rew_op =3D ocelot_ptp_rew_op(skb);
        }

        return true;
  }
```

So for the function ocelot_port_xmit()

it will be:

```
  static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct
net_device *dev)
  {
        struct ocelot_port_private *priv =3D netdev_priv(dev);
        struct ocelot_port *ocelot_port =3D &priv->port;
        struct ocelot *ocelot =3D ocelot_port->ocelot;
        int port =3D priv->port.index;
        u32 rew_op =3D 0;

        /* FDMA path: uses its own locking, handle separately */
        if (static_branch_unlikely(&ocelot_fdma_enabled)) {
                if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op))
                        return NETDEV_TX_OK;

                ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
                return NETDEV_TX_OK;
        }

        /* Register injection path: needs inj_lock held throughout */
        ocelot_lock_inj_grp(ocelot, 0);

        if (!ocelot_can_inject(ocelot, 0)) {
                ocelot_unlock_inj_grp(ocelot, 0);
                return NETDEV_TX_BUSY;
        }

        if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op)) {
                ocelot_unlock_inj_grp(ocelot, 0);
                return NETDEV_TX_OK;
        }

        ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);

        ocelot_unlock_inj_grp(ocelot, 0);

        consume_skb(skb);

        return NETDEV_TX_OK;
  }
```

Feel free to let me know your thoughts!

I can send a v3 version patch once we're aligned.

