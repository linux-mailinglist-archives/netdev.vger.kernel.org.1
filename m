Return-Path: <netdev+bounces-252510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE8QM/V4cmlSlQAAu9opvQ
	(envelope-from <netdev+bounces-252510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 473BD6CF8A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 684563011A61
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD2F3876DD;
	Thu, 22 Jan 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UkiXEZv/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5013915BD
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109742; cv=pass; b=aInAMG/MfNT7fT4/FHaghmCog1mmCIqP8NUdAO5zCl+0LM3+JMX2DgjBF203r+KvRSgWu1sv+mzFi9iMP6On6MHrF7yQF8llJK5vy4urjVdpWR34F4zGeIjglkitz5A7h7RwZvVNKyXnzTXcndtVQwBWLpgnEAWK6UyXPBSooOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109742; c=relaxed/simple;
	bh=sE0/Q6wN9FJqYyXta+W2AETgfbo9QouBmcQs0w/b0fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQhA6jJ7xVQq946QVX6V9W7IQhWARwyM5xWLDbaenMFiMeK1SszhTARPc1Ua6/C4Q72JjCPJmRFxdxQM0+51V2vT80YMZPrOXXXzoWnDWbPmEYhLPM/2Fui4WET7ogzLnM1zHtGH88BMzo/OAXJJ8BUVcqYA9HZQ1fZ1uYybq6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UkiXEZv/; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5eeaae02888so430980137.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:22:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769109734; cv=none;
        d=google.com; s=arc-20240605;
        b=RwoWOZQqrvoFTZbT/d+4OUKhYQToS71D3wqbeDIpEE+ALqdp8CkL5V+EOZSTa1dfyM
         K939eBuNTjnIz/WNaTRg7FvS1uqAOi/BG83wFnbTKgpAugnGLzgSFvQVpsHC2F9MuE9D
         kw9xxIjYJRvk0p7iZyCp88C5NSwSB4cr8qdL2nkNub4ienhf/dcEom4UrUj8M62kVpkL
         MXmQrHu7xrBAqBg6JMUFOC0AqQl8xS5mhsUFagen8NIMrb2KKuqnqwcOySgbO6O5y/Je
         ELl7+10fTwTJok+et8jkhCqoSVZQgQSaobJYvugJ8GxFZK5Fz5iGk6wkptDJCt0XR5Ro
         5ZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ScKI2OIU0wzGLSpwSJLvAkI/+5TMx5BTWw4ytgpvGD0=;
        fh=S+f6avFf+T3+/lD7i7470lZiUwELamk31lmm9MUv4nw=;
        b=lLWDTYWZ0rBkhngM4M/FZN8JD4OYuuvexuSrZO+p3JmXNZ1VTkE+Cpr+n/s38sH2wX
         b8OuJNsyoHORCfGtk19/9wub9pGD032Xk3dPtHmhFDe3XSX78KKmV9PJbtdnEvlOHREh
         TidlJzvywKXSuiyqoXgE6HGjXiUagbbORK+M1F0lDhaBx94wQ/KFPSVbIQ0Tx5R9j1MT
         LWwnqT08RMV3YuaJndCmr8XEE5FWwWlPdeLxQ+IXDwL6gBl4sB8RDq7AKP67awrh/BT7
         +N4tOYynG4j4YRS93zGcSj4tsaxUpxcwZOaShkagT82/+RDyvT+ceaDT3PhAgtuOgC/c
         m6Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769109734; x=1769714534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ScKI2OIU0wzGLSpwSJLvAkI/+5TMx5BTWw4ytgpvGD0=;
        b=UkiXEZv/B1vLQMiHytUrJQmKm7t9Rs7owvrpfF/6d9eULpM8mBWsYjU0IFO3+gGMmU
         gK7s2pQqHWAu0hg+xeQDs5Ch0P5UJAUrBUcyRUy4Dx+hUTXX+giePiTrN0xkIMNHAP+0
         M3UJU2gkY5qflSjyQAJpxN2OT7yQxCFThWW0ROJ8tB0abdQTEH1Bwnrhufo6Vt+yUHOD
         6Ac8fbERdbiWBrA+finslnwbGpnXm046XFbW127VsmfNq1NS5npvoKij+R9D55dpc/O6
         RbBJUmLVkD6TgkWLL/BRsw95uDXLxIOcL70N8ucyc/8pQECH2UbrxWMPXy3hViaea0lP
         ncJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109734; x=1769714534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScKI2OIU0wzGLSpwSJLvAkI/+5TMx5BTWw4ytgpvGD0=;
        b=jPDdSVoGLeLt8Ep8eEA42mz/hk02l7bh004voPVnCty5sdq2wBQFyvcLZdHVhyF3Jt
         Gg2F3pnrcIVVdsuGta8w7kGjmuN+IQ0AclwZnCoic+6xIvwPGLDGnSAOufa6vRnMHPp5
         7fALdEPvycy0qdX/v889qYxMm/aEWyXV0eAXozic7FrmDkNU24z4KzOY9StfdO2FSoT1
         dmGpupfSgvM6rlF0cy8NzshCJeAC7gnUb3eIZONWzGV01XgpPAj14t8vEuWvpcDcESva
         o/WFmfK/R2bMia4NKE1e3yHLDQsIRYMYjdZOh5+Tv5R11MFc+k05JGIbqX/0cxW4zP+n
         COsQ==
X-Gm-Message-State: AOJu0YxcC51Lz85LQww8rdH9+H+ShtgIuXx69mteZuNQvFuUmcBXbZfV
	U2XkUw/R+oPxJvzs4e2Xx+chI3Zg4TJzs8CoPpNxvfc9qGQgLEDng/DVEZvhO0sxyi2CF45LEbM
	JTPSbjbIOdH9o1LBPQV2mXapOHB5NgpZF5fw4aOllmA==
X-Gm-Gg: AZuq6aJhMIfkXU/ewI2603/dxtpmj2rwoV+M7jxdTnxC3zXYOULupoDM/3KOcPjVtgR
	Rt4Ou6Y/MENGshOX3KdbdlTV2Nroq4OxNtQKrPKNNgfKsh5dvRlIOQkRfFZWsp/4l/edZ462OKH
	01tQOEUfvDffLxgdwB7HUzaiJY+Wxd5zqw9hpfvHuh3D3IFOiX93UF9BzXe9kMTLhpQfiPUkS0m
	bE2OAzaUof70OA4Oa4LKb66/S/MJzvzExsn31q0WmFpues4JXPQk7mkcdzw55+BGEVdi9s=
X-Received: by 2002:a05:6102:290a:b0:5ee:9df0:a608 with SMTP id
 ada2fe7eead31-5f54bca55f3mr252923137.30.1769109734156; Thu, 22 Jan 2026
 11:22:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121215727.3994324-1-rjethwani@purestorage.com> <58fe1908-48de-4bca-ad4e-4976d24581e6@gmail.com>
In-Reply-To: <58fe1908-48de-4bca-ad4e-4976d24581e6@gmail.com>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Thu, 22 Jan 2026 11:22:03 -0800
X-Gm-Features: AZwV_Qgpa0D5t52S78n9kdekhuu1nyyGE9GtKbEz0pFrgz2mTEfUBKQVRcowgGA
Message-ID: <CAKaoeS2Jnaekdx2dXfBV91LhbaLU6SenBRkNqmRB3-1EhSCbYg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] tls: Add TLS 1.3 hardware offload support
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 473BD6CF8A
X-Rspamd-Action: no action

> Hi Rishikesh,
>
> This version doesn't compile for us.
> A few comments that we wanted to share on V3, but I'll share here as
> this is the latest:
>
> We tested V3 and a few issues were spotted.
> We did not debug them though...
>
> We run a server/client test with nginx and wrk.
>
> a.
> When requesting 128-bit key, ss output shows "cipher: aes-gcm-256" for
> the respective connection.
> For TLS 1.2 it works fine.
>
> b.
> On the wrk side, the mlx5 rx_tls_ctx did not increase (meaning no
> offloaded connections were opened). It works fine on the nginx side
> however...
> For TLS 1.2 it works fine.
>
> We can share more info if needed.
>
> Regards,
> Tariq
>
Hi Tariq,

I have fixed the typo leading to compile errors in V5.
Could you please share more info. about the setup and test, so that I
can try to reproduce the issue?

Thanks,
Rishikesh
> >
> > v4:
> >    - Split single TLS patch into two separate patches:
> >      * Patch 1: TLS 1.3 basic HW offload support
> >      * Patch 2: HW offload key update (rekey) support with graceful degradation
> >    - Removed record_type check from tls_device_record_close()
> >    - Removed Broadcom bnxt_en out-of-tree driver mention
> >    - Link to v3: https://lore.kernel.org/netdev/20260102184708.24618-1-rjethwani@purestorage.com/
> >
> > v3:
> >    - Added note about Broadcom bnxt_en out-of-tree driver used for testing
> >    - Link to v2: https://lore.kernel.org/netdev/20251231192322.3791912-1-rjethwani@purestorage.com/
> >
> > v2:
> >    - Fixed reverse Christmas tree ordering in variable declarations
> >    - Combined 'err' and 'i' declarations (reviewer feedback)
> >    - Link to v1: https://lore.kernel.org/netdev/20251230224137.3600355-1-rjethwani@purestorage.com/
> >
> > Rishikesh Jethwani (3):
> >    tls: add TLS 1.3 hardware offload support
> >    tls: add hardware offload key update support
> >    mlx5: TLS 1.3 hardware offload support
> >
> >   .../mellanox/mlx5/core/en_accel/ktls.h        |   8 +-
> >   .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |  14 +-
> >   include/net/tls.h                             |   4 +
> >   net/tls/tls.h                                 |  14 +-
> >   net/tls/tls_device.c                          | 319 +++++++++++++-----
> >   net/tls/tls_device_fallback.c                 |  34 +-
> >   net/tls/tls_main.c                            |  31 +-
> >   net/tls/tls_sw.c                              |  77 +++--
> >   8 files changed, 379 insertions(+), 122 deletions(-)
> >
>

