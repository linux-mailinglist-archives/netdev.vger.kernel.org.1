Return-Path: <netdev+bounces-297148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +4SDI489KGppAwMAu9opvQ
	(envelope-from <netdev+bounces-297148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:21:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D64CF6624DC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:21:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=V6nk1AnE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297148-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297148-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5C8C3037F44
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C50D48C8B9;
	Tue,  9 Jun 2026 15:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAFD48A2A1
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:49:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020165; cv=pass; b=MXiea69XHyd6fP17s5HKzwnKWYTzG41RYrV7Ppi4IGC6lMO773JGCzrEGtojkmeJtylRzkm22HGUvvOCNsDxP+buRxkb9vha2AnHgHBCx1LsmuL8If3pAZggxVYPalmhXCcfVrNz8WiafMKNNTX7o2RCUCMfQiya4MygbXaFBSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020165; c=relaxed/simple;
	bh=9noAYCg4T+znAXzyoBWVzEJoaCLEdnvWom8oFANNKiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQQthnZliZ4YCBtLCrGfYK3g3CP9plXiM0vBX2Kz+DJkawfA7DM+uwqm8s1LZySjVyYmtCpKzYMsGpGmHof5dzPrrDXyDjBFIAUCDIdyYUtJXLBpqYZizeFZFIye/X1n50ziCSZhUWjo0FoR6QaPD7fXU6lqnQ8kWp2gFXEOK2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V6nk1AnE; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-517654b8e28so43136761cf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781020163; cv=none;
        d=google.com; s=arc-20240605;
        b=Pc7O8r+n1se+iXIOqWQAsYWY6II+DrYJc5zjNqRWYmJN0OhWjHvPK1mmuosBHNFgQ3
         3N7omyzH0gc64kjK87/VZ76mdbRMcTpkC2kFd/4hEWi0INTcs8KuKMYG7vDE+KryYwri
         C0e3YsuqL3ndWvQ4sV2tOyrd8+Y13W+KOayF7q1bexsWyP/otFSEPx/kiv4AJeIeOH/9
         tlVRzmhfdi/qysOslpS5OIIauVdP2sYgMbHuy+27o8IwX0+yiwb6QimR29tbflHSE2wl
         O54AAevNZ+yVmRbZLsvpYlvErUYlyutgvAA9CqctWhZw/VLZGbY4MZ+niECDi+KvHhlk
         OeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9noAYCg4T+znAXzyoBWVzEJoaCLEdnvWom8oFANNKiY=;
        fh=+O5al3GVt9tBfRx3T3xklxzzbHrgtr+F0/gW2gHbnvE=;
        b=NG7PZvYh/9hSsCFsBDKQcEE081d14Dw4mavot+6tPXE5TeoHipK6k+sF4PB9H+Jyvs
         ejSgUzx7jUjpBv5878sk7aZuCnByxKQeVYg4P6obOS1pDHu3VSYw2ACig582QLhkHWNf
         JbPJIVXMR2KpI36t0BWeFuf1hXyEFGwj0ZJuMqrzTEDMcbYQySGFttH8w1qrFmqpMEQg
         6RzqFyH/DuCAQvC1ejSxcMSPKnbXZxsJKYgBAElOj/8Rds+WBcMa8vgV+sjPJRIjcrgd
         97E8M42e1XMytD533wH3M41cByKD43EYN+IUVO0IER5ORivPTGm7YC2OkM66nsyiF7bM
         xYKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781020163; x=1781624963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9noAYCg4T+znAXzyoBWVzEJoaCLEdnvWom8oFANNKiY=;
        b=V6nk1AnETlRuE9AeKRgzjFK50lq3ZoCJwKhys2G19pRnjpjA/cM/fNWB4oSaL8UP4v
         9Xii3Afg5oqed6j4rPQapNA/xvjjBl7UMsVl0m+4FMpsHvdB+xmq+dr6uO6KxnTY8nmm
         0Z6MgDg90fvhxb0YCEAK7+3qU/GZU4g3KavJyZjEdC8IH2FBEDMANhePXnNBMcc6Iz4O
         uEJYVvC5G5bBfkymmmfXrhGCShC70P4U8TjHyTIcF2j0KvW1AeWSvPu74FWVCZXcO+ov
         un6LBaZAoVjhJnAveRCFEMHjbE+xGKKugDZQKywmzBRbhWwXYDqqWbyDSTD0UtQs9vKa
         3G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020163; x=1781624963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9noAYCg4T+znAXzyoBWVzEJoaCLEdnvWom8oFANNKiY=;
        b=VIFZd9S5ifZVA8OaThcnriZPcAD2qnzS4QoB3mSnmQUtNUGgS0lbECfQZBVOb/GxI5
         Mz6eb0gVIxt9O5c9ijva/tO6QOiYLfh06BAJcpDZPL1qroxB29GrUt4micapWa+7aJSJ
         WK3fQF+qVvcNfQDqKS1feb5VY5m9oLG+CVIWEX72GibmdUdPb/1A2FBUsIRN6nCclBNk
         Hb7wyLwYg1vtDsqYg4tuGyNrtvIcohMbqbpEIYhtr/xZDkLtUc49SaDIHON170zj0w16
         MY7fWS+PrmbbAk+YA7FegT+bJ2Y6RrVxlXjQ4Uvyl4DlIm7bCGa24S+u/87PWDSHT9n4
         qBDg==
X-Forwarded-Encrypted: i=1; AFNElJ/k6RO64Q/E1cOFJ9Ga7mKx7bhPrVriSAEFQqNLbBjyu/tvXhSZfXLeDd9Py24yJWTjgtOv4nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ZDKq2zvJrXl8/0GaBsoigI03ayuGY2h8KwGW7xbmRDdZqBAq
	YxFj5fPHTJIvkj4NP3IwDwW0LsCcyds7271/8ts19+zCR+RGlP+q7dK+dqtCQ3ZJ3x1MxKg54aY
	jdlXh2WiYw7+l3fLmbzmVaLug69DwZUFRpH5ZVNXb
X-Gm-Gg: Acq92OEt3eSa9tIFhtS40DNhiz1pYQpFz5qHDq4EMKTKULqJgxfcg2e/x5p1LP/utiI
	RaN4X8+QoIU3HXKsME6mO68H2DITafFx0aV+OEJIVTLUsHPCFDPPV/QE8yX58yBkMDRZjQ4qVln
	4TyDUnIWZW8t27sqpWjlbQ4g1ZX7vSFLm8dF03CxXaWaK5voIVNt6p8naxkSKVUxhZ/W01pPnC3
	6UJdLewVu1t6pxbvXu9ejzcOn4z3Lz55cSJAuCq58hnp+wzSShKpZD9HxHkb5cuVYzXx3HjD2Ty
	6lC+DaSx0tMQUjWNBSN02YWM3dAKlF7/R/IirCOK029xk9oESnAfphsChO6tBnqRZkSkLGn73Kb
	XvaKZ1IA4DXUeyStYY8y7OFvPMBxeyA==
X-Received: by 2002:a05:622a:987:b0:516:e00e:6868 with SMTP id
 d75a77b69052e-517ca5fbb44mr41423061cf.46.1781020162109; Tue, 09 Jun 2026
 08:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-12-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-12-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:49:10 -0700
X-Gm-Features: AVVi8CcSvxwHNElYvvOmR5N8KEjXpDzwRHRmi68rkIJqklLcYgcFRsEiWGxJr7g
Message-ID: <CANn89iK77wqQFEREJTfbjZgYGfZ+nUOias7km-W2T2ViOAJ6kQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/12] net: ethtool: optionally skip rtnl_lock
 on IOCTL path
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com, 
	tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com, 
	jakub@cloudflare.com, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297148-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D64CF6624DC

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Convert the IOCTL path similarly to how we converted Netlink.
> The device lookup gets a little hairy. We could take rtnl_lock
> unconditionally and drop it before calling the driver (this would
> avoid the reference + liveness check). But I think being able
> to make progress even if rtnl is dead-locked is quite useful.
>
> First extra concern is handling features. List all the cmds which
> modify features and always take rtnl_lock. We could fold this list
> into ethtool_ioctl_needs_rtnl() but seems cleaner to keep
> ethtool_ioctl_needs_rtnl() driver-related. If a driver changed
> features and we were not holding rtnl_lock - warn about it.
> It can only happen on buggy ops locked drivers (buggy because
> they should have set appropriate "I need rtnl for op X" bit).
>
> Second wrinkle is the PHY ID hack which drops the locks while
> sleeping. Convert its static "busy" variable which used to
> be protected by rtnl_lock to a field in struct ethtool_netdev_state.
> This feature is about identifying an adapter or a port within
> a system, so being able to blink multiple LEDs at the same
> time is likely not very useful in practice. But it's the simplest
> fix, we can add a mutex if someone thinks a system should only
> be ID'ing one port at a time.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

