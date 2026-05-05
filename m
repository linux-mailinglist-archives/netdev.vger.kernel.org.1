Return-Path: <netdev+bounces-284245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GyFKRWg+WmQ+QIAu9opvQ
	(envelope-from <netdev+bounces-284245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:45:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 231DB4C82C8
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ECAD303EE87
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 07:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425FD3DDDA3;
	Tue,  5 May 2026 07:43:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68603DDDD1
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967039; cv=none; b=GVDdb/+Yq6MCX4l+tIErrxV23USDgxgHqP9d5HucrtN79E38PnbVJ62Gm3KVRVIdFVibwRPrjGMJDdRwJknvt2D5bgDJuiWv0gQGej+/1aebXaLJChDQu+MuDE9VLbGAuX1+ldISqnm0ECcZk2FhL0qRBpsrsVAn4wmzU69CZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967039; c=relaxed/simple;
	bh=Q3aLbLV9y/ki6JG9scyklXU4QHub6I9VOt7nf73uR2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lET0oNIpj/mt7RhmEc7lMVQ/228+EHgNnZTrnxRZEyz6loeNyCM3DTKmsj4ZBqIctckson0jBL8Ada2BRHcduWv2rbopJZaIMaclRqW/jogxGSUTrVwjKU8zoAz/r/Y8q5ppAAHt2Iwdf1PuG/yZ7d6Rb1VZe/l9pI+en6oMJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-95ce0cf2d4bso2255546241.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 00:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967036; x=1778571836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoHams0THP6xHqBQZRrSzuHD9mE8YcqxXe3rwyOjojQ=;
        b=nyFc14EKWd1YOaJWenTPom58NZWYgscX5tv4oorRGbj3ZtuFEhT3dAVvBAE2ttAZF1
         uA6brFK2l1U/T/3tNbnRc/qjZIUIHD/d95r8U8crvqA+xdPxyR1drYEy917VNoZRBJEF
         mb7YYPWDt6CQzUhDkwf3aaLIOHPZukr+OyHFN6dj7+wN4cbRHbKn0x2zrYvh3YJTFtWC
         luQFrtt8yGwQ/KfSpDLEGK+S0WfvjSt3evXRVdORt6l8RI5nXJT+o8df2LKoZlRwT3R8
         /T7p04wWIELBKVJCCVgvc3H/2vkhnyFiTEEUB3pCZa5EPEah9Ed5UZFoBfNU6FU9xvXE
         UMXA==
X-Forwarded-Encrypted: i=1; AFNElJ+LK3QJmptxtD0o0DBPMaiBhUpanilZAt4AREPy5s7XewuUo8uuLk9hwPz2rDk7cSHXG8YEliY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiyfBXJthqEHVO8HEDWDkVy2pH/4J4qxDeXmaBStx1PafooLlM
	XC14GgdKHVkrJYU61C+pMc3yPWDeyOPNlKS+AMiH6qPdt509bNYQ8uzwUaE03gT6
X-Gm-Gg: AeBDiesp1xHZnO3fKiHisa/QMG1aeGBDzSqxUfZvrRw7IlZHAFvlVsPY4i70LwyYW8E
	ZZr3Z3CWF16B9QVr7XPW5Py9gvIR3AO+6vmUnGVERffVI4hMBPpj6KHOThL9KWYaSpqtXQC7/3y
	noGfLUNb+eqqe9z56/miBgtTeaIY97JpvxKy8UmUSdp6n0cthw8SteLMBdsP1HeC3WJ3M+H6TG+
	fIjeXzaqBI6EJD36hDrKLzom4oVU3RHxHAy6sLrZTCyJ5WsDmAMcXU/xXJkaMv14QOpH7PWYQcD
	RWRwoZlmochudrglINFLjhf7+42RFkoF2O+nzH1mxyq9SgBTqdQlghjx9FgPR5pQmdVWYSTA3L9
	lvkIGuSN08/MuQQM/iOnNp6Kgu7uDS07BWb6vFlPF3xC4r73yPJuiER7QD016hM8+SPamtrxL8e
	wW50dbnWgqYiD+kzLqD/L4cnR5w9Vx8zck4A4fHDld9xBGu4t8vZ9fs8r7hBch6WUezv1ziWKDW
	A98M0XLOVIkpg==
X-Received: by 2002:a05:6102:5112:b0:613:3fff:febc with SMTP id ada2fe7eead31-62f557cdc08mr1081938137.2.1777967036542;
        Tue, 05 May 2026 00:43:56 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62f49c49cdbsm1930716137.12.2026.05.05.00.43.55
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:43:55 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56f72d27e7eso5393676e0c.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 00:43:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9pRH1wWFO/I+hb+DMmUwOc5awutWprxLryTBfJsnsLXImpPJgHMYkJLEZFFiMYP1jcROl+pNI=@vger.kernel.org
X-Received: by 2002:a05:6122:8106:b0:56f:b831:909c with SMTP id
 71dfb90a1353d-57544474e1emr1023308e0c.1.1777967035606; Tue, 05 May 2026
 00:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504200356.3529873-1-shitalkumar.gandhi@cambiumnetworks.com>
In-Reply-To: <20260504200356.3529873-1-shitalkumar.gandhi@cambiumnetworks.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 May 2026 09:43:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVzkRqdRBr1z9Gi2MXUZZBpVnVSkG0Jh6uG+VCdKbN=ZA@mail.gmail.com>
X-Gm-Features: AVHnY4JoVV9GX0gOfo6gHy4jhoN4HUM1LvIjejFvK9-P6xXjmnQOxuy5FcVEKn0
Message-ID: <CAMuHMdVzkRqdRBr1z9Gi2MXUZZBpVnVSkG0Jh6uG+VCdKbN=ZA@mail.gmail.com>
Subject: Re: [PATCH net] net: rtsn: fix mdio_node leak in rtsn_mdio_alloc()
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 231DB4C82C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284245-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,glider.be:email,cambiumnetworks.com:email,mail.gmail.com:mid]

Hi Shitalkumar,

On Mon, 4 May 2026 at 22:05, Shitalkumar Gandhi
<shital.gandhi45@gmail.com> wrote:
> of_get_child_by_name() takes a reference. The rtsn_reset() and
> rtsn_change_mode() failure paths jump to out_free_bus and leak
> mdio_node.
>
> Add out_put_node to drop it before falling through.
>
> Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethernet-TSN")
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>

Thanks for your patch!

> --- a/drivers/net/ethernet/renesas/rtsn.c
> +++ b/drivers/net/ethernet/renesas/rtsn.c
> @@ -797,11 +797,11 @@ static int rtsn_mdio_alloc(struct rtsn_private *priv)
>         /* Enter config mode before registering the MDIO bus */
>         ret = rtsn_reset(priv);
>         if (ret)
> -               goto out_free_bus;
> +               goto out_put_node;
>
>         ret = rtsn_change_mode(priv, OCR_OPC_CONFIG);
>         if (ret)
> -               goto out_free_bus;
> +               goto out_put_node;
>
>         rtsn_modify(priv, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
>                     MPIC_PSMCS_DEFAULT | MPIC_PSMHT_DEFAULT);
> @@ -823,7 +823,8 @@ static int rtsn_mdio_alloc(struct rtsn_private *priv)
>         priv->mii = mii;
>
>         return 0;
> -

Please keep this blank line, as it serves as a clear separation between
success and failure paths.

> +out_put_node:
> +       of_node_put(mdio_node);
>  out_free_bus:
>         mdiobus_free(mii);
>         return ret;

For the logical change:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

