Return-Path: <netdev+bounces-292442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFKfGktOF2r7AAgAu9opvQ
	(envelope-from <netdev+bounces-292442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:04:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C15E9DF2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B0163024A82
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EB13B47D2;
	Wed, 27 May 2026 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvZebe+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633431AAAA
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912264; cv=pass; b=hlfYjCKmomopbaCEe5NgD2bLOvFo6GJEFexbp/77LTiAKVeTlkWcPq/I/w2bzZDNtZpj7FEEvAUUIHk12Hp4RQ2Givy5g0OsySru98n65uIme5OK7Dyi+yQksszytA+KrHC7Ac1Rme5BFANIgLXXKj6Oueq/DjdyYqZvOGuAOXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912264; c=relaxed/simple;
	bh=RQ4RgB4VVlvUd46byZaBb6Mw80rm9AAL/WIMQQz4nTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILqR+7x/4H9GVlYd0EmkTh49sGFYRUEuTj8D/Ruov+k6HC85wSeeAp8A8bMl5kcN3XTbyidl+vfdHlrT/eBS3LLx2gwKU3hoTLRxgRbQoktuoVwXrJKuTnfzvEQ06PyggWF19910cb20SIUsTjXFqd3dPS4ICAmNvljl3CjML24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvZebe+s; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69de16f5e80so638619eaf.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 13:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779912262; cv=none;
        d=google.com; s=arc-20240605;
        b=PgJ4UO5ioNAX6m7k93y9sPssNTfgK9sXjVzTTlvKghji8W3Eqg4pm5lfYUv6Z6/o7F
         gImGVr6ZRB6STlTqsK51qkN+U6WRuXEZrGj1SkDnAn1Q4OxcGDS60yuh/ZhCR4BxxOcI
         Ts2TP4o86LZjIOXkTBRdJLJ1O4jYEfie4RuFMF8HeRE52B41IfzrLxSs/RQqfQ80f5AY
         c5ydDfNxEHjYgW1HEegAyiJzoru3nWsg6zPeVmqf4XcnmX2XJni8yx3BrB1XHa1KCqFN
         n4aWImqTrqa/z8x1hF8zEnVXhTHUUVg6xrDDHt1600uAdm0jxmYEXP5UEdGYNJey44jW
         JJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bacRAlmRc80tLDTfCa3dxIMFTmoiU4dtjlJEx/fRlT8=;
        fh=E2e9fSkLh/C5V7HhU6fGxlSpyMo4JIMpHbPMGd5aMwY=;
        b=Ueow0BIbp2wQIeTv7079vvzLw1oUiFu7uyqWetqBkGvrpTYJKGAZwN68lIwgT0dBse
         fyW3BsfAUxk6BWhS5aUuhqXVLXqnksPZ76CITdBjWISl3R3vO61c6aNE5vPkgSMtLKoJ
         qOZu00j20Uwi67uSCR3YcqmKAb2U+ekG/Up+Ga7iRKhOU2IbKqDvQLsP9fJbp9pcGshi
         R/OGsJ1dO01LzzL7EarJVOg1fSNKsWqL8eToJCLruoyKxzUCmImJUlGMt/TPY7MiIjgp
         OBEPd1bputvZl4krqEe3pdHkPGG0r2Foe3StldDXbn3GVozP968ZKjDEBSpvE2/7/tXL
         KgvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779912262; x=1780517062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bacRAlmRc80tLDTfCa3dxIMFTmoiU4dtjlJEx/fRlT8=;
        b=KvZebe+s+aa3+IjweZwsyTGoOlZOSlUkTnuuQj+uovL/dHg0nebCYDZxC6OvnURJ0L
         KADmkYHLKeVEokSYPGd1x8CE4lgWATASdiiJApfLv318IO6DPhJ97A+rJQvMpHshh4cO
         Uv+sgmjvExoq7WEfR3zmFJdGKTJGexBKvll3KxcsPLUJQfpvp6+g3Cx6EFU1Om1DVN8r
         Zt/OEV2RA7z79PEW5Q508FzWpaN6peApGffbtqK+GXzuW6hhod4898VQK4AQuxrE+24a
         qlcG4mzA4RVuhDOCL+WQn2UYmzTVXD2nQOQ/njSDJvFX7mWw7qKbKO6E/TAgHjLucQbY
         wtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779912262; x=1780517062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bacRAlmRc80tLDTfCa3dxIMFTmoiU4dtjlJEx/fRlT8=;
        b=PnJ6F7OfBPgnGOv4HG+X3fin/wuTKtwOiGoGb/KyoAPdWzSB/jvNuQDRDZMigITbBo
         BrKrN2I6b7VoMPnV9NrRr7OSAsqlrTl/JWT9JwMHUSlixYyi1K6IgtHkwm/euImF9XK0
         sKE7reqfGUaXUdNKwhVhoCRLEUKkPFQdRTDD86YK+QERfaMx8HxGTbl3Uq40k+UPcff2
         Uv+ty5Ao1ELVkvQCMHD4Tz4K7dkC8i8lFJd98OiULPQyKXVLD/ZTG/w7twPO3YHpxtYV
         ToLKqPaktDYymn7GTaBSahz2cxpIRtNV+NEEbyIQ9bg/qwVhLkNg2Dy8nQCov/oSh7/A
         G+/Q==
X-Gm-Message-State: AOJu0YyRa376CVWdYzjDKBGxZKdsulyrf3GNIkmYbb12pHmTtsDWeCwM
	DWuexJhIc7Ru49nEDh+okJZt8zVDobEN/bbYKI7ldUY4kYAAjd9ET2vJYnNJ1AMnnw2c7esq1R3
	ytYDDUb9KUoYy/rzkG2Sp+7+ofcRUJ0Y=
X-Gm-Gg: Acq92OG6Ogo+iRvQ5ABZePJJTzYxC/O+/Jtckzs7gPuhSStJ/27xWGHI6lp4gxzxcWc
	xdUegR17KLq7g5Er2SMTHhf2UW8L7+0JYgKW6f25AF3JUU9+gavrBorKrpahhCCH7Xdnq6b9yJm
	dV0vVexJb+MxGSy2Cj1Tt4FYfqWqQXUb0s5ygepUN9xM2O3loJOJ5/+dwRscXPnKdZiDD0AmRRe
	94cA/eyXuWlIVkZFirtOndY/N/k38O5LGrDAJDluVmblSBR0FpLgfgSnGwP+A2T1u9vmibqU8l4
	vZIrJjQgdvMiitXRXBwXYH1mWfG9PhWaL/7XQtosEfwOm/iWjCJWX8e07w27
X-Received: by 2002:a05:6820:4d08:b0:69d:b7db:2c52 with SMTP id
 006d021491bc7-69db7db3639mr7514731eaf.59.1779912262234; Wed, 27 May 2026
 13:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523020704.503966-1-mmyangfl@gmail.com> <20260527015527.3178315-1-kuba@kernel.org>
In-Reply-To: <20260527015527.3178315-1-kuba@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 28 May 2026 04:03:46 +0800
X-Gm-Features: AVHnY4JKMW5y22wOtTdaPwfV-wFDEAuSsvqgULWKKaQXUhrUQAhR4CFxc8eQxWM
Message-ID: <CAAXyoMMt5b5tSWYejKGosKTDcewfVSOZEYTRGYyfPZmEyb1TKg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dsa: yt921x: Add ACL support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hongson.hn@gmail.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292442-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 047C15E9DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here are the reasons why I believe some of the changes should not be
made (to suppress further AI comments on the same line)

On Wed, May 27, 2026 at 9:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> [Low]
> Could the L4 entry slot be allocated only when at least one mask is
> non-zero?
>
> The IPV4_ADDRS, IPV6_ADDRS and ETH_ADDRS branches above all compute
> want_dst/want_src first and only call yt921x_acl_entries_find() when a
> mask is set, but here the L4 entry is reserved as soon as the dissector
> key is present.
>
> A rule that exposes the PORTS key with both masks zero will consume one
> of the eight per-block entry slots with an all-zero key/mask, and force
> an L4 type match the user did not request.

Unreachable path. TC ensures that both masks cannot be zero.

> [Medium]
> If any of the register writes between the "Open the block" and
> "Close the block" sequence fails, the function returns immediately
> with the block still latched in MODIFY mode and no compensating close
> is performed.
>
>     res =3D yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
>     if (res)
>         return res;
>     ...
>     res =3D yt921x_reg64_write(priv, YT921X_ACLn_KEYm(blkid, o), ...);
>     if (res)
>         return res;       /* block still in MODIFY */
>     ...
>
> Would a goto-style unwind that always issues the close-block command
> and then returns the original error be safer here?

Leaving a block open does no harm, no ACL or other functionalities are
blocked from processing. Any subsequent ACL commit request will
overwrite BLK_CMD without any error.

> [Medium]
> What happens to a meter that has been programmed in hardware when one
> of these later steps fails?
>
> yt921x_meter_config() writes YT921X_METERn_CTRL with METER_EN set
> before any of the kernel-side bookkeeping has succeeded. If the
> following devm_kzalloc(aclblk), devm_kmemdup(aclrule), or
> yt921x_acl_commit() call fails, the function returns or jumps to err:
> without:
>
>   - reverting the meter hardware programming, and
>   - reserving the meter id in priv->meters_map.
>
> The slot stays active in hardware with the user's policer config, and
> only set_bit(meterid, priv->meters_map) on the success path tracks it.
> A subsequent successful add will pick the same id from
> find_first_zero_bit() and reprogram it, but in the meantime the device
> polices traffic through that meter.

In that case, no traffic will be policed by that meter since the ACL
rule referring to it is not activated (and then rejected). Any
subsequent ACL rule that picks the meter will reset it before
activating itself.

> [Low]
> Is there a reason cls_flower_stats is not implemented?
>
> The action register definitions YT921X_ACL_ACTa_FLOWSTAT_EN and
> YT921X_ACL_ACTa_FLOWSTAT_ID_M suggest the hardware can report per-rule
> match counters, but the bits are never set and no stats callback is
> hooked up, so tc -s filter show will not show match counts for
> offloaded rules.

FLOWSTAT has its own quirk that deserves justification on a separate commit=
.

