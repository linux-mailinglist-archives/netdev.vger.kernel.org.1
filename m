Return-Path: <netdev+bounces-269196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG+iNmYgu2lofQIAu9opvQ
	(envelope-from <netdev+bounces-269196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:00:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 881062C3353
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D2A31A20B1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650A346795;
	Wed, 18 Mar 2026 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlhIzBTq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C240359A97
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871117; cv=pass; b=iyEJiVcd82cqouFXimHcObaYvwwo2mt1DMQAH3x9JmY9YYW5VWHqqsk6hDbVx2DyuYcg3Y8o/QelYpmbG+jnWr2EUCv1OQ3eGclhHm35EbuSj8UniyxnNHJLG/SWarw5Y1Grwk3OnT5TgprjTVluy7xdwdLE3H2AS8BcmSx9s/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871117; c=relaxed/simple;
	bh=Zenm7moC4cMHhzK5K3aV+UpapPf9fWYppd7Np9kpH2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUoRhQIhcKQEd2bQwPSSLhmEOHMjzjK1h6O+g8Xnlz6xUyQV8zxcLdM+JD1UT4XBnL6JUU02UNkpgw+hj03lX4DbfazWmKKwuI2kTDpnWgBPzwKslmkIf/0Ipxpg2ryH5vA0Yrm4z4LxlcuPd2Fd4dxlOs0jnCn6rSVh7TJpd4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlhIzBTq; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89a6ac6f389so5302456d6.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773871115; cv=none;
        d=google.com; s=arc-20240605;
        b=BQxRFLZlvURqyTVeD7PqxjvI+LlLeuOIAM5P1F1zdCo6isSw6L7Vne/dFj9aH8SRDx
         GHVce0eNmNQOwD7cAq4HocLCvceMPuzxCHbphr8C0454JAfkfZnWRC9ThQhpkhFxsxnW
         tKpUNUqFjbB6GF4riePXzzVMmZgVn7HGgrcPCPPIcgLhLC5iofdj7OafIMywupxtvmYU
         +R4hM2AE0+ftBM/xanY64gkYPAAsN6wBNbG5ZoPJTiBHhnbMPj29h8s4P6VkeabqK38l
         FKGE1iPuNqFYIxadnTez5iDWG37V7kWxmcaErD00PBX9OVf9J789A7oL25lCOxwVVY/g
         dOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zenm7moC4cMHhzK5K3aV+UpapPf9fWYppd7Np9kpH2E=;
        fh=fgZjnCH8atSN66miV84Xvu0/F0phAlVccviwFmXfFkM=;
        b=EdvYkKRarPVf/WeVLc6g4SLmwaRVae0+w/0N8u6nH6Bk4Vb0TH/j7w2KM/JoOIqBWf
         A3bMiV6foCKSg1ErtSmra17SgHRIATt0O5EKQwgSuGDBMW/V2hE7rNru4zEFWbjq389X
         /FQshFCp0ntCs+cDDl1WoxrsT5eAY/91vbanjFwa3shih7m2gqQAnOxROBV6v5I5pazP
         NkNKf/bFdIvg2brbX13kKcfh7KB9LxyzVHsflYARsdretF9T7xyTNOEIkdxnO0gpFbpO
         o23DAxNxJWvIswGfO+76lOsgOLKXJSYnU0//HWbLgGGW85r0XQ0XDobbiMO6psBFxmyJ
         lkAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773871115; x=1774475915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zenm7moC4cMHhzK5K3aV+UpapPf9fWYppd7Np9kpH2E=;
        b=AlhIzBTqGIHKMA9/cGiGfD5SUIVaAbhr31rOWrbElH1VVkT4oLRscnxvnihlfaIeBi
         vNmkBKovJhjnau5bidMAyhmONp6/EPFfVsrJZ2E/ipRwjXpxOK124uhRb+TUDg8+7KtK
         GKBFNuB2Z8mXhSQvbpLY7tAb31NBKSep19tT8b8HLdBWTwtK+ZUQ1D4ef3SQN2dk6RuG
         AMlpTo7hPkOuhhlpel1Nu3goyxfymGSspVqBsl5fdNxEYFgKb7YzH3k/uRfirV5i3Q7T
         n1A7Fqtj1IB5SVUm9fYunKnotbO55syREOEGV8HwRcrQadj77olPr4mZTFWqHytJaQQo
         Onyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871115; x=1774475915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zenm7moC4cMHhzK5K3aV+UpapPf9fWYppd7Np9kpH2E=;
        b=r+OtlXfDVQAUbVFPdleN/8DMppXH9mLZXKZPqA22OFLycvmuvaDZQFQxCTgAZIjfKA
         ZAUOYywMI4zkSzEP24uRx3OxQdc6w2da7MXxs5mnx8nOpd2XSpRofLNr9gWQSYSvCYz1
         NWqtSHAFO6ltdWSQgAjf1yiF32DSRw8Af+bhuCuvf4FQ5Pm6jDnYulnpbwnwDZC5SiOa
         MZEqDCfT2AKeMCO9zUHi4eDVF7czGS3wE9nZKU8S4GCLAd5KtTV69aQjNr8QoFkCfcir
         43tpUdbKwoF70iCsNFjIUvUBwtVA3HeTndxHR228EsBrJoMDxYPrO2FL8Enu00eBPCQ+
         sXKg==
X-Forwarded-Encrypted: i=1; AJvYcCU5/jUV9Xr8sR+g1Ao0FJ45ftLMdy9hJaMl2NxyJnnComfEdAf/zZYLsd4sm6q9EP2SMmU297c=@vger.kernel.org
X-Gm-Message-State: AOJu0YziixQH/f/mmUapDSMWVg2h9YfLuiUxqEUOsA2irxClGr4dCtTx
	YIVxgI8Y3wjc/F+Sbq6GZivbgAM24fLgqeED8wa2PMRla5joZ6TwaCgeV+Xk6gcR6WWN/hF9ZBl
	Vz/GOyGW76wzVfCeHHTzfYmQHxUmOCZU=
X-Gm-Gg: ATEYQzyLjdVu6p1j3h7hq8m+lt3SD+10XT4V4GZmOLOgfTgjrhYFfK0ZRJzbe1Fd0DL
	YPhKjvv2wp2PmwICiudx6AX4EanzW7uAKQa91+vscv/WZ1pNbF0A8MTpNTHWqhXuxJYN12OQKOR
	bzmFSML5AKGpU6grpN7Y8ecmg/93SPJPgsA4KvC7QuZMErWFbkyxBWkIQQyEH6EQyuga+fs6kQl
	RPWe3NuxLUxMjO23teOsUEspvtH2aDFuRN0xPmmPXO6WYnxY/6BZV5hALBKBDU2Ew3axuoqCl+J
	CGcSBAEKRqPv4sZfBmzuZsdrY4OcFWoC4J0LycVM
X-Received: by 2002:ad4:5c66:0:b0:899:f6bb:331f with SMTP id
 6a1803df08f44-89c6b58f785mr72497716d6.41.1773871114997; Wed, 18 Mar 2026
 14:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315204454.124544-3-dam.dejean@gmail.com> <20260318021222.1391487-1-kuba@kernel.org>
In-Reply-To: <20260318021222.1391487-1-kuba@kernel.org>
From: Damien Dejean <dam.dejean@gmail.com>
Date: Wed, 18 Mar 2026 22:58:19 +0100
X-Gm-Features: AaiRm51rFbEo2c7d7K3rasLej0EttyagoaVbWOHShXODh8J4kcprNNhbzTO3yDo
Message-ID: <CAErgN1CyV2XuujdrasxZ4anMkuVs_BFab1oAxYxw0MNJhS+jaw@mail.gmail.com>
Subject: Re: [net-next,v8,2/4] net: phy: realtek: add RTL8224 pair order support
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, davem@davemloft.net, 
	devicetree@vger.kernel.org, robh@kernel.org, hkallweit1@gmail.com, 
	andrew@lunn.ch, edumazet@google.com, maxime.chevallier@bootlin.com, 
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269196-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,davemloft.net,kernel.org,gmail.com,lunn.ch,google.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.553];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 881062C3353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le mer. 18 mars 2026 =C3=A0 03:12, Jakub Kicinski <kuba@kernel.org> a =C3=
=A9crit :
>
> This causes rtl8224_config_init() to return -ENOSYS, which then propagate=
s
> through phy_init_hw(), failing RTL8224 PHY initialization on non-OF kerne=
l
> configurations.
>
> REALTEK_PHY has no 'depends on OF' in its Kconfig, so CONFIG_OF=3Dn is a =
valid
> build configuration. Before this patch, RTL8224 had no config_init callba=
ck,
> so this is a new failure path.
>
> Could the code handle -ENOSYS in addition to -EINVAL, or use
> device_property_read_u32() which is firmware-agnostic?

Thanks for the feedback, I handled ENOSYS next to EINVAL in the v9 series.

Regards,
Damien

