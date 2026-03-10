Return-Path: <netdev+bounces-266371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHGlDKGdsGkflQIAu9opvQ
	(envelope-from <netdev+bounces-266371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:39:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C2259011
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41C533023D5C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8C3B27C0;
	Tue, 10 Mar 2026 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P7QRt8lD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CA3AEF30
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182367; cv=pass; b=ZAWvMFz2HdN/cVdSnxPF/VQ4nba4XoBxm4eGB2p2FkDNUZBwG5L+P5LaG44VJQHfsAwobZvQ0RTsWywHxA1nL8aSBv9qJsLZJMh21rUYsCSERkO/aXRZwybWsuhZlV21CY+UIjZOOnrf07w/uiYsE0K3y1ERVdXMblan3frITns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182367; c=relaxed/simple;
	bh=UK2S3nbtd7fjW6H8recpqCy0chW5jUnVIcKyUoUcVNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nD+gaRrXjqvsZKJaCyhBh55i0ykOkAh4m/yUZNvFIAnWVqb+kLJTk2mjoRauDY3ecwiujwosC6bH8WRnTZIFuSohApP8fw09g0mlR6Zk6GlCXmiPvqMpGn5b5fL5LNQoPEmvs6+P8fLtH2fvXJrrmWslU0d3pwzVfXopLjD1RUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P7QRt8lD; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae43042ea7so111171755ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773182364; cv=none;
        d=google.com; s=arc-20240605;
        b=GAxdU9I6Hrlv3dUn0w+V8JnvhwEEA9mYqdyXT5uk5yNzU7zmJfENCtkzJSwHLB60b5
         FSk7LKJK2TFLDgVdJdeO1rj4YgThcf0Ha7CLwq8iRF9uU16a/cNi+OR3I1S8PO24IcXd
         Nz3gjMeG3+h788H+TYaEXvHrzm4BEMaJw6HoX83uVZmlVeDM2QI0sGmESOk18B3iIcUu
         KAwkQpR+5/d0b8G+sovop7f8MMkn4mzg4MTtc/jjHq8Bidmbr45nxhOItcVLhpJckjT+
         2u1bgMscVVnKnekh2gfhgu3Kn01Xfi+wTj7gvQJ40arNaA5ZDXqRetl70GIJC79hH757
         pVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hgZxL4dPG1JB+pwIvOvrwjtCO4ld6uZtto/CeKqDnV4=;
        fh=f737Q/TdMAoEg+KRIZFtFspoH76iS6rVD+hWpcHl1PY=;
        b=V2kqPiMefOzGonnYJsf9CSKScMuhXIvuZHGumOdqtmer3k41YVXlhjJm6etLUibtoP
         8M12K3wr0zEyKFig4KeBQHtfcsvyuiZhh7BmQDTMMBWVY2GhtPVShG8ftoTUM6TSlOZT
         dg6VpcjL7PYQ5XZ1xBgt9jZji6NtZJgj79WoiSGIe9XyoTmI4rhXEhV4QvIOOR1j/Wvc
         Xl0oaDsH5E4Rt26TaG+tZTiCM5dSW0KbBVHVD0cYwf1Qtro8esPhKW0lMiT3cwq1Yz0o
         VXtihQLHFPtE6FdcbF1a2iRlSmZSqmPtvyEArJbbsKf90oGc9PBlc7bNnqDUVbw4wiIT
         zz8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773182364; x=1773787164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgZxL4dPG1JB+pwIvOvrwjtCO4ld6uZtto/CeKqDnV4=;
        b=P7QRt8lDpDkuntUow9gPiq+yoTDDhrwnYnfdDNWA41Z/oK+VinxYp3A0NAWm0dNcrI
         nvQjj1tLybMADgjliODhp2B6Ijhk09cF/zjIimDX0MYehIEjU8TPYbp2fq1663esbNKK
         VdVrLP8KfmGhvMtmA3gyf6gtsTs33nAezbBBmfJGlUymV8CebuBofyPlhsSK6T8Eaddf
         FVrDvG0jbi+GyLD5GT+QvVFMtdi+mEeWzeF+9ulGOFwk4ua0qhrMr+qH3NTSYmcL9k8A
         JLPrB89OdohJ8YqmrEBAtQnfg9T+MFkkgrXdGIRIybWKpfdJaxamanW5JPJAxl9NeRif
         OP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182364; x=1773787164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgZxL4dPG1JB+pwIvOvrwjtCO4ld6uZtto/CeKqDnV4=;
        b=rIuz3PWsFmdeF2Rqqc9tIxU6wdXpignoKLFggJTKBywUXjpm5WLAn/YN2fY4QfAbwE
         cjbq3XmNB4Y+H6NGlRjfPX1ZrjutOVVQJs6mdvP6wf1Hq/9DEx2v4WS7vZfgNEAB/+HI
         FRi+p/X7LAEiiCWlUoCJw00YUvG3EEImOuYIhT1oPDPPj5K0oeyyZAQLPNA+57Y6DzcX
         lrI4XNaIHqDdAP1z1yJIglh1rH08/EsakqK05jiwBEXXchihMhskAj9TXLOdu2hR50Ma
         lCXkXSB03JF3Bv3s+D1gc6TlrKhM32HZtjtpBWM4gztTCAD50qSanV+J4EHId4vJVRdO
         kHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF9K09bSg0AhJnlS+4H1ePZDvkIEfyAzSL5bgks0+9F0kWyORvayai77ZeXiXFyj9Z/UMAH3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypcdeu1NFi9hZCFikKP0iAab9sSYQllCk9+8ERDOyBKv+XsGc3
	w4Dw/k2Mp7EcNWSehggDsMgRD3jGH9q6R6GHW6Lrq2c3ctLNhI50AVwSHZ73RpBYQ4JGWUUi9er
	BOjrp2xsjbLHNA9Bayq95KMePWupNhj1hfJLCy0w/EmJTIKyi6HU=
X-Gm-Gg: ATEYQzx6ZPT8IGmwyAr2hCbt7H19TWAB68PH8HbDAqlmOU/QgbN9Oq+lfwHijoC3zyL
	GU93b2yOzFF+0sCpnR4QDdTdrS5c7je9EuK0i2eIxHbIeTZTLJir6Vb7BBQ8xVf2a7GehpVTrLz
	Ti8zutpyS80ZVeIlOimAFbKacMyRVxJAOkpMY7pyqK8khpf3nAyFTHtwuKW2VEizDXbl/WS0Lcx
	9cUlgzrUqFT5g80wb/N6MWy7Jm/D0uLBw7LWskOC66MSBw0fweXuv7c4ge+emHxZ5vQbsH8Z25Z
	6/sLm5E=
X-Received: by 2002:a17:903:240d:b0:2ae:588a:f3e5 with SMTP id
 d9443c01a7336-2aeae85b2d8mr3734425ad.30.1773182364628; Tue, 10 Mar 2026
 15:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZcPd3OKqxwCZV-5@suesslenovo> <20260219200459.1474232-1-utilityemal77@gmail.com>
 <20260219.de5dc35ec231@gnoack.org>
In-Reply-To: <20260219.de5dc35ec231@gnoack.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Mar 2026 18:39:12 -0400
X-Gm-Features: AaiRm53Bi5v2R8sq4eGVQOtisSif0YBDoTMZ_De5pzTOEuKPyyUhzh7ujbtadX0
Message-ID: <CAHC9VhSu=YtE0dMiEtUQgz0pFy5K8cuHh_EWprNtFTDAxhss_w@mail.gmail.com>
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, brauner@kernel.org, demiobenour@gmail.com, 
	fahimitahera@gmail.com, hi@alyssa.is, horms@kernel.org, 
	ivanov.mikhail1@huawei-partners.com, jannh@google.com, jmorris@namei.org, 
	john.johansen@canonical.com, konstantin.meskhidze@huawei.com, 
	linux-security-module@vger.kernel.org, m@maowtm.org, matthieu@buffet.re, 
	mic@digikod.net, netdev@vger.kernel.org, samasth.norway.ananda@oracle.com, 
	serge@hallyn.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D58C2259011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266371-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,digikod.net,oracle.com,hallyn.com,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,maowtm.org:email]
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 3:26=E2=80=AFPM G=C3=BCnther Noack <gnoack3000@gmai=
l.com> wrote:
> On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> > Add a LSM hook security_unix_find.
> >
> > This hook is called to check the path of a named unix socket before a
> > connection is initiated. The peer socket may be inspected as well.
> >
> > Why existing hooks are unsuitable:
> >
> > Existing socket hooks, security_unix_stream_connect(),
> > security_unix_may_send(), and security_socket_connect() don't provide
> > TOCTOU-free / namespace independent access to the paths of sockets.
> >
> > (1) We cannot resolve the path from the struct sockaddr in existing hoo=
ks.
> > This requires another path lookup. A change in the path between the
> > two lookups will cause a TOCTOU bug.
> >
> > (2) We cannot use the struct path from the listening socket, because it
> > may be bound to a path in a different namespace than the caller,
> > resulting in a path that cannot be referenced at policy creation time.
> >
> > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  5 +++++
> >  include/linux/security.h      | 11 +++++++++++
> >  net/unix/af_unix.c            | 13 ++++++++++---
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 46 insertions(+), 3 deletions(-)

...

> Reviewed-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
>
> Thank you, this looks good. I'll include it in the next version of the
> Unix connect patch set again.

I'm looking for this patchset to review/ACK the new hook in context,
but I'm not seeing it in my inbox or lore.  Did I simply miss the
patchset or is it still a work in progress?  No worries if it hasn't
been posted yet, I just wanted to make sure I wasn't holding this up
any more than I already may have :)

--=20
paul-moore.com

