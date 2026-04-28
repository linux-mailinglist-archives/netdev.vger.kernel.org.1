Return-Path: <netdev+bounces-281767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEeaL5CH8GnuUQEAu9opvQ
	(envelope-from <netdev+bounces-281767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:10:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5907B482497
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9AD93061DC5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61053E5EF3;
	Tue, 28 Apr 2026 10:06:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA613E4C93
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370766; cv=none; b=sjPnvvPtXYaktOXzjXHmIObylbBhAqWcdNppr3RDaG1c56tAc/o4wyPQwAWcFi5jZYE+5AqSl+1G+RgNAytRWFB0sF6rYnjUdOyELm/aVDuLzc3a9LQyn/gQ5iCqwqD/ublwXjsliyk2tlbNg5B0NlAHa7R2VvuhYyH+9x2hj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370766; c=relaxed/simple;
	bh=g+lTY6cYsTJ2QbbSfNoaUnqecZ2+4coH/dDAUkw8fGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrGq0tVhiqp1JWsUkTausVD44EBxwi2N4mpBT8331Jp/Tu8SppFsiNzL2WmBZIepBz5Z/mxaJG8rNjZ8Yjjjoj25igbTlEIFnSctOkkP+rTtYalzXxJXeWCYnK+iLUEYUm+XTAXWn3bPmQR+YgF8b/jtKFU+K8oc9wNzsKsZZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56d933b555cso3544678e0c.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777370764; x=1777975564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI4uziET6JAWo+FMAiSC3ZAIZqYosnFx+7pkmhqLPAI=;
        b=KZoB+zNeaGDg84JCx67E9niWrVTVkzSO63HJ0G/IWh41+FECz1aYnDzZeg9fNbjVSj
         lTzAKhM5igW6PNivF4x/33/85m668KIYWuM9meRrRWBypXL39FQiFJ4KFKaj+UUWbSMp
         +S053O2hivQcQHy+8vGcPoUccmxS2O+ddnMk6JGGz+bEq/aLWL/2TDhOwpwGfgbQ5MSv
         9dvWoYXEvbFmOdDQC46BnhoSsAEYbEwmRD75l3PTLLnTtlPBZ1kdFL/QHXafyK7PB0fh
         nm7120TMJBIqrjD905rpotc5jIZ/e2Ok3p0AhMdp1SLOJ1UuJ+BIQNPbQoKj9eYrMHhn
         fQOg==
X-Gm-Message-State: AOJu0Yx07BEC7bXyEhclJHAOm6DO2QnIUbi9PS7Df8wDeKKVv71iP0vJ
	SpSKUQW2F+mYXsfj/mH9vbYXYH1tJQwvI67TcR2sUKE/8BBs0kBDL7SPERr5CKr1ens=
X-Gm-Gg: AeBDieuv9Rmxk3GJNFMEVLEL4kCIvrkdPGaWA0rhQLXkCuXqlhTXyZ2/Pr4J9tb5iGA
	e+XfAun5XIrjqinCU0sBYZYURoVEHo2G72fHGBtG86NbYD6ULqSG7XrUO8mhFR3vhCVra/5ffp/
	a+wZM2Cs0vhFNgcRw3lYlYZH8OFeCjzj3W5KTE2WPq/sPvb1sYf/FxjrDS8IDHdszQ6YVOlcB1O
	MthmKKCHyPnGI4eT0NuxFJLvRYTPAFiy1DFAj8SAIuG3hYUmWdQNHNcTqEKRviKq+h86V5KeLkw
	75aCoZaLa4HQTybAfhaMo9SsBlPRYL374yaB+USPk3OlrIN2VpaewvtUvFXDj5+G+OQB+NO764P
	3cncbLzo/lV2ydc0fue1TrYr3I3iPSKc0EV+ScXKL3UX+VZjV1PNNwbURCE1z5VQYDZ2vkAlgwE
	2o39eUkWYVw5CX9keUKTNfG1zj9fmCDH3wRugAZfsPpWuH0Hb5Y7qjb5ZsKQWBx8Hftx1nbIk=
X-Received: by 2002:a05:6122:311c:b0:56c:d623:896e with SMTP id 71dfb90a1353d-573a56b6c7dmr748627e0c.14.1777370764158;
        Tue, 28 Apr 2026 03:06:04 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573a45d4b57sm1267532e0c.11.2026.04.28.03.06.02
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 03:06:03 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-95673f7b5baso2800154241.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:06:02 -0700 (PDT)
X-Received: by 2002:a05:6102:3914:b0:605:4ff8:fc21 with SMTP id
 ada2fe7eead31-6280956efa3mr686151137.8.1777370761950; Tue, 28 Apr 2026
 03:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428024400.123337-1-ebiggers@kernel.org> <20260428024400.123337-6-ebiggers@kernel.org>
In-Reply-To: <20260428024400.123337-6-ebiggers@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 12:05:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUz3f9d6Fnz5FUNp=QwxMckQdmqMUpp9pJN2OXmt_1=ag@mail.gmail.com>
X-Gm-Features: AVHnY4JehlpIYgHeh5BF_H4nn36U985ndwS087_C0M83zeCp2dtWlb4GELXGrzQ
Message-ID: <CAMuHMdUz3f9d6Fnz5FUNp=QwxMckQdmqMUpp9pJN2OXmt_1=ag@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] crypto: pcbc - Remove support for PCBC mode
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5907B482497
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281767-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, 28 Apr 2026 at 04:49, Eric Biggers <ebiggers@kernel.org> wrote:
> The only user of PCBC mode (Propagating Cipher Block Chaining mode) was
> net/rxrpc/rxkad.c, which now uses local code instead.
>
> While PCBC was an interesting cryptographic experiment, it has largely
> been relegated to the history books and academic exercises.  It is
> non-parallelizable (i.e., very slow) and doesn't actually achieve the
> integrity properties it was apparently intended to achieve.
>
> Remove support for it from the crypto API.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

>  arch/m68k/configs/amiga_defconfig             |   1 -
>  arch/m68k/configs/apollo_defconfig            |   1 -
>  arch/m68k/configs/atari_defconfig             |   1 -
>  arch/m68k/configs/bvme6000_defconfig          |   1 -
>  arch/m68k/configs/hp300_defconfig             |   1 -
>  arch/m68k/configs/mac_defconfig               |   1 -
>  arch/m68k/configs/multi_defconfig             |   1 -
>  arch/m68k/configs/mvme147_defconfig           |   1 -
>  arch/m68k/configs/mvme16x_defconfig           |   1 -
>  arch/m68k/configs/q40_defconfig               |   1 -
>  arch/m68k/configs/sun3_defconfig              |   1 -
>  arch/m68k/configs/sun3x_defconfig             |   1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

