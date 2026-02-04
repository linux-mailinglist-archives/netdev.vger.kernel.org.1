Return-Path: <netdev+bounces-256671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOdxISoog2kxigMAu9opvQ
	(envelope-from <netdev+bounces-256671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:06:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFD7E4E5C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93BD43006835
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667C37F11F;
	Wed,  4 Feb 2026 11:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com [209.85.217.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2978389459
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203174; cv=none; b=Z1RP5Ak/wAn7O1dkyuqjG0DdOu4VoZUFOVGaWogW38mL2jFamhiG6E5yLLpOw6HseDWHszdTovLV5nwhZImaJKU3ZOyGwUrPjU0zWvlgtAjuej+eRIXZGT0mXjsQhGei2ZUp/WLuRJGc9CUTU0LVdpA0RqjgUuHzV0LPriJBvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203174; c=relaxed/simple;
	bh=5NjCdT2nrZpZ57tNCtFV9pqandhyrZegGdE4QFBLja0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpnHWN1uvDk3tcH96n9loFehC14gMpJR9RTbXLQtcnLUS6+SV8cB1jTmfE8sYvJtfOoLspC6EZLzZO28LJfHyFTa3N6jiiW9tunUnwX5hVdMb2lObgx7T4tRfvVTGIllkJU1w3wiN1vd2DGXGE6o/9I6+8Jx3Uk7lqSERSqLTcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f65.google.com with SMTP id ada2fe7eead31-5f54d6b4047so4000415137.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 03:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203174; x=1770807974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzWstbsnnDl4kKhiGYvS2ziV+JALL5t+yio0ugwGnmc=;
        b=mYzPUktm6e1TozSxA2IPvpfUP8GIFqq6w4WGV8PAfyeKiilDfB2XH//ELNY4IusqFd
         SssxSPLDt/J31yQBk2e4RBkEHTClhgqIXJc9zy6G+gxLZY0iFYU3JsQAZUw/OzsLJYUI
         1uEmLqtb8MPDJB6BQUUKzUFfhQMFXYpTatqIy6m4mTRaUWf6xAlTnBV8qifKksU9PO7j
         u3PAX+niNg8elx0QL8NkbaeEOiW4NCB4AjZdoh+JGXiJYeJqvwQ/iBZx2g0rY52EZQGO
         oemWxQJj7keee94duYZdc+yo0lSz+ReI+kDdgxww9TQMW85msvYWMnTKLtDHE0uGTR3m
         xxRw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Hm1A8X4sRPrbzVfJ8QJa6vB1r/4MV25OzJ32hKDd+QajrVY9Uil3ZYdSo669ueU/n1ddkjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgf/eUFbrBOQHDmsOPAKlyRArBg7UZNOXj5Sa8yU7SMp4IoXbN
	fgdyx114yIs+warBetiVtT5b+IGsm6Im0T/biPCGFQiloKohBtFNWmmAqrKMAP22QZhlpA==
X-Gm-Gg: AZuq6aLKdSgmv7NvwA010NmPu3ThZEnhPsOzyc3YrsCY8R0oQenaglWVeXcWEFvushK
	xIlrK5ygzE6k2Pd3E/aHsIy21P2GTSS1VLRQJF8wr8KjKMzbwXC9YfAhx6Inv1zdVB/xHGPyS7/
	Sz+M6tuJxJmxImHs3yTTkUVIMQx8yFu4Djci0SawEVX9CweB4POXOwF8dUGXAwn/d+T60obIFDr
	X4/AGN347sjeBuMObe1P0Qd9Ty1pnJxE/iLSYByfXw5aXGu8/YUydf+vW0iy3PMjjtcWh44Ciwy
	7xvTeov7QLBLpoZAUBRp4bNvZ/AgbqlgmMVN5+sYmvi8ZVq/sOd/RzkfE/nZYgawBHlfLv21c4D
	uMlAOxZhdhtkDqTzLsEBBfX4QeDjJL+HZFd90vE/iLp7ovjJZhf3QEzsp/OFSznSStOcBqv/iy3
	iCkOdKkZkrdfUYY7XwX990KIjLDZks5QpfYDV+hfLtzywgn15w8E9E
X-Received: by 2002:a05:6102:3586:b0:5f5:4e0e:c826 with SMTP id ada2fe7eead31-5f93946fa31mr866875137.5.1770203173696;
        Wed, 04 Feb 2026 03:06:13 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948dffefa97sm696977241.15.2026.02.04.03.06.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 03:06:13 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5663724e4daso4585176e0c.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 03:06:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNp/65qzqDa6eKdI1UCnxu8SGBTPEa/hRG5iGH8NpSSGE7lkIx2QqwAfNnzHikWw34yu/bmZc=@vger.kernel.org
X-Received: by 2002:a05:6122:e46b:b0:566:3954:f74e with SMTP id
 71dfb90a1353d-566e8019cb5mr725526e0c.5.1770203173020; Wed, 04 Feb 2026
 03:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203104541.264759-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260203104541.264759-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Feb 2026 12:06:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVpgzDAChz1M=hbVZTeHVKwiprPwLbe14nLKc85hX=ZTw@mail.gmail.com>
X-Gm-Features: AZwV_Qh6HkVNb4BuqrGcVeKvsm8YThaQh31Q99liNk3PJicgrK2iH6IUSxwO7xo
Message-ID: <CAMuHMdVpgzDAChz1M=hbVZTeHVKwiprPwLbe14nLKc85hX=ZTw@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: renesas,rzv2h-gbeth: Document
 Renesas RZ/G3L RMII{tx,rx} clocks
To: Biju <biju.das.au@gmail.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[bp.renesas.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,glider.be,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-m68k.org:email,renesas.com:email]
X-Rspamd-Queue-Id: 2FFD7E4E5C
X-Rspamd-Action: no action

Hi Biju,

On Tue, 3 Feb 2026 at 11:45, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> As per the RZ/G3L Hardware manual, CPG_CLKON_ETH register bits{12,13} are
> to control the RMII{tx, rx} clocks. Document the rmii{tx.rx} clocks for
> RZ/G3L SoC.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Doesn't this need a Fixes-tag?

Fixes: 3ac2aa31b489eb4e ("dt-bindings: net: renesas,rzv2h-gbeth:
Document Renesas RZ/G3L SoC")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

