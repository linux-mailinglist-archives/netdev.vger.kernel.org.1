Return-Path: <netdev+bounces-275875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFfKAp+q1GmKwQcAu9opvQ
	(envelope-from <netdev+bounces-275875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:56:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC493AA885
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DB4300DF5E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 06:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E138C434;
	Tue,  7 Apr 2026 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUXv6ah2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6ED38C418
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544817; cv=pass; b=pKukBYIpEKpFCp6/YyUXsTBPUP8pwtYoNrt0M55pknszfaoNU3jqPrqCRjMk+RFybEQQ2gUA8XA+eTgJ49UuDh9trDIpMP5EwjgReHQw1Hx08b/8vZ4mJ2rCvYyntjY2BX/2kotIyxLIuE8aq25GkiNQ9jZLFvkWFz/V+eFjaCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544817; c=relaxed/simple;
	bh=FWpfwl5EpG+FUBdNljoQk7IzodPiLTITpijDs9wnTzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McdPivGc17fwS0Q6gMG91zrUq3WPK/fdsGb47ps7sHvoxMmsS/XwqIja4rTHYXmUiMIXMLc62S4ueDFzTOfdw4bVYRr6NgMWE6iMtWuo8dX8lmMW2E9Gui/WaeTD7jBNE9Zmcs1f5OT/qorMgu48rsEJLJTF1+1loLJW00C86L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUXv6ah2; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c01854477so767995066b.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 23:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775544814; cv=none;
        d=google.com; s=arc-20240605;
        b=jtAPhP35w18hG3mcYKg08I5L8ksWdkqhxRArubkUBgPXqkWNSIhwF1ZpogeYT8VENp
         OzteSApMNtULcDkTawxVk7QlKmv8HVsrmhYcHwe6/3T38i3ahYRP2thjokl5peGVLfHP
         vDeECNZe9ik2ca/i2W8C7AhmpVRwdnQOmHy6JSbI7x3kVL4ny1Ng4eyCXW2n4bu6aMJN
         TJsHdPTPICY7KGwEqDaZTnDNW4WJ7CJYDRp1zefFKUPQuotaoM/12NMr960UqD3SQbrp
         RqzVsK6IL58rCQJksTa8/Z7GzCy6umtyCDVeG/vcu7pYlD2/uyNRDTB4OZZDJQbxDb2D
         hmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QGGQAplBq02BHVXyopNXftOCfxeBQ27SGZLzvlb5js=;
        fh=86l38OHpPuHJrmC4aO3hIB+v4Jqcb2NQZRESnY6Rt7Y=;
        b=IElWKUrcYlK6QYwcpKjiI+jnma4UpDohS4dRw3k4xPH5V4C6X19FzUK9D/LBIuOThy
         b/XAzEvQBnajNEyhis45FhikDoqcpVwa2kyZvm7UTaXan5ZTKleG1UTN4tcmPi7VPRr1
         PutqSTXHsGfsCIeergXFrypz8jSF917tnkraE1buXVISyVv05TqtWMR8jxKxfNLTjrp0
         PFIHlY/NWdn9xrkLc/+4wsVZ7NPJC69bf/CEIcz2uLwFOZ6HpFNhtnQgQ0SCYnNWdDfI
         9UFrgitCrc5Tbz6lh3PBl6L4amAw+Rf/SbEUY2FNncrq9/ud3M5lhifTzQIUzmkPh8vG
         J8Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775544814; x=1776149614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QGGQAplBq02BHVXyopNXftOCfxeBQ27SGZLzvlb5js=;
        b=ZUXv6ah2qQBkZXMv+MA2dVfH/XDZVD0OjZckCL38OtM23za8PBlrP7Mq6fZHNi9nrl
         srItEPrpBWiOHHvOMbhB/r9GMJwG7zt2HEPnONVFD7XjZUPMz5IHaPa7L1uXkPT2+m+4
         1qxulKqdPEB1igC4Pxi0JaVDldAAtVXEAlhvZcP3KxNdpzdff+y82C/Mx2Zk1MQy8Ixs
         bDeaXKCJKrNWGw6LiHwnlwY3G4wpn67YyoGH76KzdQcO5RWoEhMz1jkeYqJfgHX5mOgq
         c/y9x54wg573WKFCCkc95+74q0VE7Y0h+jCeaXoo0Jmobn+I7CJXYvwmgG6pF6KD5Wna
         KxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775544814; x=1776149614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3QGGQAplBq02BHVXyopNXftOCfxeBQ27SGZLzvlb5js=;
        b=OfW0mGOT5T/YVqTqvPlnu/o29VplIomaJnAF91RJHpPOIkBf+CI51aD0jKX46IVkpz
         A8zDXhoLAczwse+Aipdm4Yv7os3pnAdGr33wVTnKSe1Zg8EliACulIkCst4J4xYRQkp4
         d0/K4+0Xs43Wdj6lSLRnhHLFA/OinWNjfmRqXygKYY8EROc4yZPJz2jz3PGaTW2w1oQB
         J6HEI6krXRtNa4PiELcch6fe1QkFc9Rq1nQIAajiXqvCjfvwFPBGKqoQfNhEfa4p6J2F
         VUundNdbpef8A5FpCK2kKRKEjGXVrxNAmQIcH8ntt5o6zCVWuktZTf/7H7+mEZQY9E+5
         STMA==
X-Forwarded-Encrypted: i=1; AJvYcCVzRe6wNrikTazpXB+XhTrqFMa5D1MfmoAOvQK/FVLrT9zcY8Caa3hAF0Am3kI22dB9jMGoKds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhheZI/jAf57DHyjkbDOwxiLYAL2NRHR/KgiPJDeZr5Ogdru0o
	69lZf8k8+K2EOVcrmYS+NiQ4yHdz2dps0jwDkVo8C+jMoE95bxcuxHi6c4PDZy44zyO5BGUy3iP
	XwwHTjgnzeogSxd0rEqX6LeuFvLzpmQA=
X-Gm-Gg: AeBDietZQf2ztZuXtmxfcLi6gfnp/lXjGbyYQQfNOLpiCLOxGPzpsVEXiUmllILvFUm
	fOo1SgRvE0uLeCLteLlMNQ+suL1quAe7W56s60/grZJ2Zfpyq4YrVLTmQh/ndwzYdHjxYeTTrmT
	ptBzRD8QjfXcvgEkQBwRJsDEapfsPdP8kDDD4t5MfBbQ6Hzw1/RN/bhbc8PwxF+/rv6ucmLRwGZ
	mEEQ9ca9+AMwteCdVL9CdB19ZE6z+P3I9wM3D8VRmJnX5d1sgtO0V5TKkvj66Zn7I9iIQWTl+K3
	iP/NivzLoBRA5VooXg==
X-Received: by 2002:a17:906:f581:b0:b9b:1b9e:1e99 with SMTP id
 a640c23a62f3a-b9c679580b6mr816033466b.34.1775544813579; Mon, 06 Apr 2026
 23:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403150050.1235-1-royujjal@gmail.com> <20260403150050.1235-6-royujjal@gmail.com>
 <20260406182504.52a03794@kernel.org>
In-Reply-To: <20260406182504.52a03794@kernel.org>
From: Ujjal Roy <royujjal@gmail.com>
Date: Tue, 7 Apr 2026 12:23:20 +0530
X-Gm-Features: AQROBzDobic8jv_imKaJPmW4xt1c4Ipd4HaOp8P0tUSTUyRBdcWdqg-PViFb7qc
Message-ID: <CAE2MWknnJHgdxrC8mVPsCxe91WfA4aS6JZEGvhG4u3Mmq0D3EA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] selftests: net: bridge: add tests for MRC
 and QQIC validation
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275875-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.mk:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9CC493AA885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 6:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  3 Apr 2026 15:00:50 +0000 Ujjal Roy wrote:
> > --- a/tools/testing/selftests/net/forwarding/.gitignore
> > +++ b/tools/testing/selftests/net/forwarding/.gitignore
> > @@ -1,3 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  forwarding.config
> >  ipmr
> > +mc_encode
> > +mc_decode
>
> please keep this file sorted

I will keep all the codes under a single file and keep them sorted.

>
> > diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/te=
sting/selftests/net/forwarding/Makefile
> > index bbaf4d937dd8..a26da846632d 100644
> > --- a/tools/testing/selftests/net/forwarding/Makefile
> > +++ b/tools/testing/selftests/net/forwarding/Makefile
> > @@ -1,5 +1,15 @@
> >  # SPDX-License-Identifier: GPL-2.0+ OR MIT
> >
> > +top_srcdir =3D ../../../../..
> > +
> > +CFLAGS +=3D -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/includ=
e $(KHDR_INCLUDES)
> > +CFLAGS +=3D -I$(top_srcdir)/tools/include
>
> Could you please keep the format more aligned with the ksft
> net/Makefile? Also is the -I$(top_srcdir)/tools/include
> still necessary? KHDR_INCLUDES don't include $src/usr/include ??
>
> > +TEST_GEN_FILES :=3D \
> > +     mc_encode \
> > +     mc_decode \
> > +# end of TEST_GEN_FILES
>
> Also needs to be sorted
> --
> pw-bot: cr

I need bitops.h for fls() API, so I can see KHDR_INCLUDES is not
needed but tools/include is needed. I don't see lib.mk is including
the tools/include.

@Nikolay Aleksandrov  Please review the updated test cases in this patch.

