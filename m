Return-Path: <netdev+bounces-227808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97693BB7CEC
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 19:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581CF19E5AE5
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F542DA76C;
	Fri,  3 Oct 2025 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="iRwvufoU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A82DA76B
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513921; cv=none; b=ccE4tkfledrPC2sXVN0QnLka3hg//0M7wwccCwMqZvrVP4QHvWXypxc6UO83Bm05OodwH9UwmQZ059JDkS/4C2JK+k1pBVeQcwcsTRfrgh0B89bSUOABBs6A0i2nmwiAZm+NJOyNThUeA5T1r+M+QgOJ1B9l32MWR6/OW7iuk+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513921; c=relaxed/simple;
	bh=/Frs0rAxw5knFcCn+UV0uvGy7G2gNRCU60sZEgCvPmU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCbKt3JvUzMdeP4ywnRcTsUolrbkR4EF9OgOHYo0FZ29MqroxWMAVcAS+S4UTSEKGlHjaqRakEbf6L34OqNdKYTmonC8reZ1yVldLl5mz5Fj3KYVBy6MtFGX3ZX21DaF9XvtYjwRdI4Lj9oGA/MsJ6Ps4JDKI3megw9YWVjEOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=iRwvufoU; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1759513917; x=1759773117;
	bh=9o54tQhfnDiNoWZUKphVzWURZgEeTJ3Ws3Vh31F86+U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iRwvufoU25rthma37vvY3tuGs8ZtqJpZ+mBnu0GPE0xC2U7bn7DocVXAwsdeECOHU
	 jQZR+o+plET2HKV/hamZauRKpD3nsxywaMLyVyCGsyn8f2eq5lmPEf9mNlUdLLZBi1
	 B7glQkds2tf+JTZTE+uUz8f2/Cp8KyEYQdZsxp5ZGHp2kpP1bLJf/q7vcpXMw111ZP
	 /sgIQFqsHJy2+9mCq6mqZG75fSDdhvASwQJbEpaWk0sq961nWeH9ELUcwQm/fVfDsc
	 S7HK9P3Bgd+If2FsxjWkco7blg9UyeH7P3GDBcT1GnGeA433tkzqxU1RPY6wYpesoV
	 TezyJUzrA0hYA==
Date: Fri, 03 Oct 2025 17:51:54 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] doc/netlink: Expand nftables specification
Message-ID: <JUuZco3v6YeIraurnU7qR-yqiNiPq8B5F6MJDG_2_tIrtMvkLEFhhPnns2BV7YCvAYkBLlhkadllZyRgQ7LmNWyWihwYr1dU9526sV63Ew4=@protonmail.com>
In-Reply-To: <20251002151133.6a8db5ea@kernel.org>
References: <20251002184950.1033210-1-one-d-wide@protonmail.com> <20251002151133.6a8db5ea@kernel.org>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: df1c9d97ca53f60bbbb6f0070f3683bf6b315a39
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, October 2nd, 2025 at 10:11 PM, Jakub Kicinski <kuba@kernel.org=
> wrote:
> Could you try running
>=20
> =09make -C tools/net/ynl/ -j
>=20
> in the kernel tree?

Oops, will do :)

> Looks like there is an issue either with this patch or the ReST
> generator we have to render the docs. I get:
>=20
>   WARNING:root:Failed to parse ../../../../Documentation/netlink/specs/nf=
tables.yaml.
>   WARNING:root:'doc'

This one was because of a missing doc comment in "getcompat" operation (fix=
ed in v2).

Also, it caught another issue. Python yaml doesn't distinguish an empty
attrset/list and a null-value:

```yaml
  dump: # attrset
    reply: # null (but attrset expected in code)
      # no attribute here =3D> dump["reply"] is None
```

I think it's useful to have a machine readable mark to signal that the
operation supports dump flag, even though there're no attributes outlined y=
et.
I fixed it by simply checking for null in ynl_gen_rst.py .

