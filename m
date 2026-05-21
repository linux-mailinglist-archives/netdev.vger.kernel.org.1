Return-Path: <netdev+bounces-290178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMCJBlZWDmry9wUAu9opvQ
	(envelope-from <netdev+bounces-290178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:48:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5E59D655
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6E723006D72
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470C21CC5C;
	Thu, 21 May 2026 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggIOY7E2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE080156661
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324424; cv=pass; b=uN/5S43h6iDpsRJxqQ2mDgxELptPJnaZWF8FIhept+PPS68qLMpNZtJTCfJ5Vlx77TVVdBW+p8xPqhgvYo44qIMyzmiYI++QBSgM0tJMCI0hxrURkrvj+YEwoAs48kj8IiyyQVk0EED5TORfgf4Mw1QtZVShSBFxR5qiw9OINa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324424; c=relaxed/simple;
	bh=oC1mwO75C6WehrOmAziu20cAXjHTOOv2g2FImazSBb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkhE14bsEK0xJhlBvk6l31g5P8rLREuymI5uI8HXxQI5G/iKEdcBYCeQ9S1Y8gwuJy0uSZh+5KxwRvvQI3Nf50B8DtIzqm9EQgUACI5ASrGQvAXo+MBfYqvIpHzDeOr99UxVC636I32cV1qugjy6rzU1Me3l96vcxUfnokwI3OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggIOY7E2; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so71587616d6.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779324422; cv=none;
        d=google.com; s=arc-20240605;
        b=WJhGrE4qZHkln3HsyJ/18lzza90+jFt6PAJBRe+1iSR879Rj2heG0h3pdkzuTX3zqt
         FntwSiEnH4fBIv+p7BcU+7OASGyLUBJ/BoRkymwHUOajX3Laflar7Nke/cQuU0+TZYhZ
         ABGADVYl8k2CJ8hW/Eade16or+3Yvd7UdMRd+soWNlmlCdFPyMOUpXxKCMrYxcfcBEVz
         KYsazeNPAY6Gbc9ENOfGHiaqVj5H1I0hJVLBIcFx62eGC1xj98RQOxglJw7ZVZdX8ssr
         6XLdfsitWd6VPYyxu74BjxF0OlzE/m9Lc1z1UI4L7KLsM8MmWtXCPKh1Xlquy3v7MByc
         KQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RPwS9/B5o0QIcQXIBrm8UBYE0p5Gz3vMqVOwSXGceTM=;
        fh=GwuQ7veYuf77ovxzW9yr2gdJyC7kih3MdI9XgSIkITU=;
        b=iYkMvx4RMzpvWZ/JubgDopEk69m5e18pcSQkdmySlF/AIK9QDpacnF1fyaUt/QW3Ev
         Pj6AVXcm9dO2+78IM9949Ju1ucaIcG6Ohq3hUf9gEAsH00BshZBa7Cx7FAlVZ3xLIQIU
         UdqM/GNcXU7eBhu4vkqV+UWRLRaY+pu8h6/cdJ/PE1YCqfLRMPUZ4nAzXY+2ADa1OwZk
         uVuy0KIfUvY+sZLyON0Cxlz9nWCw2lh60MIlb7wJfS+9Y7R/Yfg33tzxthLr7H3p1XQW
         81QzujG7+ENIwcN4ZaNoeLDmW8V1kM2vHtsYulldSLKDqLMpszlccuI7EnlOgBnKffdT
         9oJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779324422; x=1779929222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPwS9/B5o0QIcQXIBrm8UBYE0p5Gz3vMqVOwSXGceTM=;
        b=ggIOY7E2Ia67QnO5fdMsjQoSbOn24feYrp4LmzGs9dI7Itjq/I44gCjE+PgpTdFqlF
         qOEE3eK6AcTphNz9ViJAo4Fj3EepY91QBdxIwyUxVk1O5JtBw3Jt1QNAUeoAuQi2nHix
         X3xYm8+QRXsLJnwPirsY7BvFYihIt2xwrBdEAI4FUsOlVr0yAcoDlkvAVYls9ecD3Krn
         SK+4v7BDX5CdG5WQz6jGRltiCTJTx89tzYDNB9H/tCyd+4px6JqYf/U6spicKrLcrLIC
         5e1bnRcHAiztuKO1PugsasY1OcRSOoW6jjm8U5RsucFHl7aQdNqtWjarKO/GaRZ6KvzH
         ZAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779324422; x=1779929222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RPwS9/B5o0QIcQXIBrm8UBYE0p5Gz3vMqVOwSXGceTM=;
        b=o+lZhZN/0bbHwPsfTlxL3TkjXnIB6hWquDJLRtCMfVlzWjmohn9vq7AHGcjcDzmRG4
         rpz11FHiQm1YMhBH+GxiwJJto6aFtCgOPJdrdJ2XgclhwQ+/q4PvzNiCRqIQbxpjHFOH
         9rstLtRi7YcfCcV0IlKUhsM5+6m9pxYLxLibBUjrMWxCOuJlpPz4XjMP0FMafh0jRxdL
         Vt7mLIJ8BfrotK+MjRFUAEvwga9lf5ek+7iN4UHGb/G48aHYb67FnINrNxjMeCQZnboa
         ur26dIYNTi3QxUGmxE8zAz9QmWkGStpqlv6L2Tt9g6amFnYMO/7C3sFniFP3S2XT3Stl
         9Gmg==
X-Gm-Message-State: AOJu0YzcE1+PBjtqj6jpdY+/Lvc2MoqbbNc7rRDBVM7BvLf7UzmUd4rm
	5t3yPs2II0VTVNmd+uwLQ5h0SAU2zTiSOMZXZctvKdju6YgVJDczNh9Nmo9gX6TZ+K2otbeCEjg
	YBo48+KIPGZCurNduija2k3vyIHV+28Q=
X-Gm-Gg: Acq92OE0GvuG7FTWeuHBICpZ9FNimm76YVyhzjPwbi4qEzzFaKK0mIPSqhOMU1kolnl
	HgEVGDnvnmkqcbx4riK/g2UQcVEbgGaCgyD7neT+mYVrvORJabF7xwzDAZ8T3Wt7tl4R2hJH3Ex
	ygiK+Dqmu5yFB61w+EBpio5mPqhRhXQ0vz/3kPVQ4+BhO8l5mnCsu+p7lIsf19RiXQvUhpKYaen
	y5gv8SpxgLtsi5LmIDXcegRjeE24zqYgkmI1Eb7bIYBnCPRjjUKIfos9RfSzFOfbeM+Mzg4SqvP
	iq9pxiBRuFvgyq6uy9I7VryX/pb8ZSPUsGo5K3uVRPfV1D0MepVt4QOscX/er0MYbXZ57ghN59g
	IPbw=
X-Received: by 2002:a05:6214:f2d:b0:8ca:1e0f:f20c with SMTP id
 6a1803df08f44-8cc6e2d3954mr14677056d6.4.1779324421699; Wed, 20 May 2026
 17:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
 <20260518010739.80979-5-enelsonmoore@gmail.com> <20260518182220.78a9ae80@kernel.org>
 <CADkSEUhXU7f+k+yBO2Y=eonch2k7YmwbQe6o9RP9osRoo1KFBA@mail.gmail.com> <20260520152330.699e2ee7@kernel.org>
In-Reply-To: <20260520152330.699e2ee7@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 20 May 2026 17:46:51 -0700
X-Gm-Features: AVHnY4JhZCVSDMlYiNRnHftMO33oy3b0Yo7WRHYQwn5fLh_MbJnxKQOjSMziZ6c
Message-ID: <CADkSEUhBOh2XQX+yvQ28qxyKONHsSRHasBEOzvHhk0H_5YdUDA@mail.gmail.com>
Subject: Re: [PATCH 4/7] net: arcnet: expand unnecessary I/O abstraction macros
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290178-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sohard.de:url,microchip.com:url]
X-Rspamd-Queue-Id: 1ED5E59D655
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Jakub,

On Wed, May 20, 2026 at 3:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> FWIW we're expecting repost, we can't fix the ordering on our end
> to re-feed all the CIs. Build breakage prevents any deeper testing
> from kicking off.

Understandable. I just reposted the series.

> I'm writing for another reaons tho - I've been meaning to ask whether
> you know of any reason to keep arcnet in tree in the first place?
> We can start with this series, mostly asking about next steps
> 'cause some are posting fixes for arcnet and I'd rather delete it
> than spend time making sense of this ancient unsafe code :/

It seems to still be used in industrial environments.

Cards are still manufactured:
https://shop.sohard.de/en/network-cards/sh-arc-pcie
(This card has Windows 10 drivers that were updated in 2021 - see:
https://www.sohard.de/en/sh-arc-pcie/)

And so are COM20022i chips:
https://www.microchip.com/en-us/product/com20022i

Removing these ancient drivers will definitely help reduce the
maintenance workload:

$ cloc drivers/net/arcnet Documentation/networking/arcnet*
include/uapi/linux/if_arcnet.h

After my patches:
      27 text files.
      14 unique files.
      21 files ignored.

github.com/AlDanial/cloc v 1.98  T=3D0.01 s (1132.6 files/s, 393987.1 lines=
/s)
---------------------------------------------------------------------------=
----
Language                     files          blank        comment           =
code
---------------------------------------------------------------------------=
----
C                                7            528            529           =
2440
reStructuredText                 2            164             10           =
 532
C/C++ Header                     4             97            188           =
 371
make                             1              1              3           =
   7
---------------------------------------------------------------------------=
----
SUM:                            14            790            730           =
3350
---------------------------------------------------------------------------=
----

Before my patches:
      32 text files.
      19 unique files.
      21 files ignored.

github.com/AlDanial/cloc v 1.98  T=3D0.02 s (983.1 files/s, 522198.8 lines/=
s)
---------------------------------------------------------------------------=
----
Language                     files          blank        comment           =
code
---------------------------------------------------------------------------=
----
C                               12            852            858           =
3884
reStructuredText                 2            819             25           =
2956
C/C++ Header                     4            102            192           =
 388
make                             1              1              3           =
  12
---------------------------------------------------------------------------=
----
SUM:                            19           1774           1078           =
7240
---------------------------------------------------------------------------=
----

The recent com90xx patch can simply be ignored once the com90xx driver
is dropped.

I can respin this patch to apply after my changes are merged:
https://lore.kernel.org/netdev/20260410120318.253872322@kernel.org/


Ethan

