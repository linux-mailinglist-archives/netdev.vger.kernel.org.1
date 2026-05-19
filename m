Return-Path: <netdev+bounces-289415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFNBEoNMDGrjdQUAu9opvQ
	(envelope-from <netdev+bounces-289415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:41:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A3C57DD9D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5F043006D7D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62939446D;
	Tue, 19 May 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVxvaFx3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34927874F
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190017; cv=pass; b=BzuyWFlL0VGgVvxIjJnmeh6LvbbEgp8pOeWOHbXpt68R2H3iuQdPNcLYlap3+jB7egLKuciTahN79s1P0qPs4Ug0fsbTZo7gI8fwW8K3jvKSrwlCX3hRZ+N7URV5NJX/mc1LWNAPO8SP37b8NvuIWITkqvftGnVT7+/EL+WRxFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190017; c=relaxed/simple;
	bh=iPWuHMhmhl/60szA52Sw6IS2rz7sBTxXOU2GPsaIw/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfTej6SG2hW9zZ4mhyyGwVLLFrGojVa05L/YUlss7NykVOK6xyc99b39Zq3gCZnwuHBf1jsLSbSOW34U6I0rK0wi6YPMbA4vQl0sp6LKwuftOnjRUSk9UlwItXp/m6Rpx4bk6WW5MUY4LYOfdPDEjKUOwTQINnp3WDIzGOmcrEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVxvaFx3; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ad135063so26747105e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779190014; cv=none;
        d=google.com; s=arc-20240605;
        b=B2mawSskQVyD+PcPVdFbE1JZRJJnxvCu3wofC+sw7U+F07Z7+z0ZjU7kfg6cdaK4OK
         w6HbrjAN9RvOakQZqYujQqIzyJ7Bhbe+zjinpfwT/U0KznFHN2pIiX9EkMATXadRN4x2
         dUaS3+qwAjJDDID3PFnf2OoLdhN/r1nmvPa34W059FnY9nSdRnsT4jnEiXEDScnpaSCH
         Yv90GUdjz5A5GphZfs66lxSSQYDkuyKAiT80W0COkvdBvdVoY5DLuw8/b1PyeSn09ISG
         CmkgD2/iOEBv7AEWbFm8VibVko3ky29CAc3B3GPyvcxGQ95q6As5+8u2Mel+rmo+YDcH
         WFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qzOtPuy8fApeWGRCJXo7X4XDHC9LyPWRyf1vwy82fLE=;
        fh=UkeJgOYy1/KUoQaVx3FmImu7aZiTnGH1cuXtFHf3ZrI=;
        b=iIgpLECRDWr1pR3O95vc818BvZi85SqRRyZc7wPqGHqdrFaiMMlQj/lUOkpbBz+iLT
         UFzuKznVukn/KUczh/TDOrVyvQ8m7Ak69bEkbMP8m4G80vuEpP+bmPyIwOl6DdAsj1XZ
         WioYj9363QYhkZG7aXoTEBSYoQL8NP28v2DKn966Vpam5vRTlPpyqzmfy3Pa3B5NHUDl
         ZkD95w/puI9xTPxB/bZMH4tQOwtCpqVmsAXi4JY1b6WjTINZ3GZyy1d5JE22s+1qsA+p
         vGlkNKPB59njj7clUd3mZZ94MS3zbO6S4vydnQBgBFIcnypKZ1HxXi2OGe7QOtge3GwZ
         6gqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779190014; x=1779794814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzOtPuy8fApeWGRCJXo7X4XDHC9LyPWRyf1vwy82fLE=;
        b=eVxvaFx3bY4fdHT6tQ8UNmKiGhILgmv1DAzseKCUuV+6+Twn4Ht6DVfmZH18JMy7Bp
         oUbUS7YQYR89rXeDxMuTme9OYfbuRQFtJKWQPXmlta90TX+jD5MssYxrr4YpTZisR03m
         dgNGC7HaWYC1D/V2cgmWAUAj7qRDCVfQY0DB0NKRIfsc/2JO/8Qlc07wa2SH/lN7MqVd
         P0S/P2/BvfE68HDp+iFMb6C+e3Pzm/1ucH5eJlL8Qs0fV7qFhTx6yYTSUCjsJqyJEI2H
         oU7EBe2lhuZ1lC5soiL89YxygWEcyrpmzfktFWxKeLCx47fkr+truwjJpWSltuReq9GA
         lJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779190014; x=1779794814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qzOtPuy8fApeWGRCJXo7X4XDHC9LyPWRyf1vwy82fLE=;
        b=RW07HkEmdrOg1f2e+vsOz3nywQ4tW63ZblsKTKZgxFNLCPUWq6s1kYIeKt9bo8ln0b
         ZlsWjeOWE/+W4DjR4onZbnIlRe9iO0mAmRL10vkTBRnf0GiexZ9JdVVPmGqXH2XA4/5o
         osgdRnrwfwYHtQUNiDZjucwC7wvqMsKJSHz/K1Cqq2KmhO4IqtoTUC+9hNiBZxt6YXsU
         u6ugtXWqaybJYJyIKKXfvketY3cAqv4Y+Q9Q5zifRVnLkXuCcLLT4M2fIdgiQVKjoYP7
         GNMJVl+wxBi10tO6d/6BDM1hTtT1wAD4wj3yN+IHdvFFHxchP5bI7xCLnFypqf3XKeSo
         AKqw==
X-Gm-Message-State: AOJu0YzY5NQdgI+eaaY9uAilOicqxSPBzKNWW6wrJVdANVagT3Ezdq0O
	TL4eeX/X/6uVdW4eLvZ7DzLv1Gw75Udh2W0BnuSFE9M7yhRNIpV6VVPHxnd5KG6VPmDpwbkiRV/
	iSt1ialMnGKb+C/aHx4w2zB3EBUpLwQYVHNavQPc=
X-Gm-Gg: Acq92OENdgGrQYhD0hHoMp+7h0NOFpZ6p8R1IOlmsg/QDd5RWyvbSbfN3cfsp51c/rW
	K0cvAJ7l1f7vF3NkbjeRUXO6YHSydIN19aCyGAc2wn9w7duypQpC0hv12tbJ1qFvVyi+m+r3Cjx
	MjNN3ONSESvc9wiqaOI2aV6P5XbNtznka+aQrrJQNgKKLPaiqpNQd4ew3pf2etk8qODjY7ROdou
	dP4ItWGDvLFx1xCANhFVh06bZ02mNvQWTuiGJMR8FARqowo40sPIgu1PJO//KJSpbjoYLM6mPD0
	L5aGw6Ff3gmQuJdyuw==
X-Received: by 2002:a05:600c:4fc9:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48fe60e473bmr264085775e9.2.1779190013840; Tue, 19 May 2026
 04:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519103153.968549-1-houminxi@gmail.com>
In-Reply-To: <20260519103153.968549-1-houminxi@gmail.com>
From: =?UTF-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
Date: Tue, 19 May 2026 19:26:27 +0800
X-Gm-Features: AVHnY4L22Em3Yd6Mf9Vo2OJOu3uBKoP1k8QS2aRVC1rqt2nYNBaDbZcjN6syGxM
Message-ID: <CAJ0BgHd=jEKQRXyALgMxyAHz+jDY+PfQ7vSeBKLy7Ee82yoVsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] Add OVS packet family YNL spec and
 unicast notification support
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, linux-kernel@vger.kernel.org, 
	Minxi Hou <houminxi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289415-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 44A3C57DD9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sorry for the noise. I sent v3 too early. I mistakenly assumed that
overrode the 24-hour rule. I won't do it again.

B.R
Minxi

Minxi Hou <houminxi@gmail.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8819=E6=97=A5=
=E5=91=A8=E4=BA=8C 18:32=E5=86=99=E9=81=93=EF=BC=9A

>
> This series adds a YAML netlink spec for the OVS_PACKET_FAMILY genetlink
> family and a bind-only ntf_listen() helper for receiving unicast
> notifications.
>
> Changes in v3:
> - patch 1: add missing document start "---" after SPDX comment
>   (yamllint warning in v2)
>
> Changes in v2:
> - patch 1: use YAML anchor (&event-attrs / *event-attrs) to avoid
>   repeating the same attribute list for miss and action events
>   (suggested by Donald Hunter)
> - patch 1: fix enum-name from ovs-packet-attrs to ovs-packet-attr
>   to match the kernel enum name ovs_packet_attr
> - patch 2: add ntf_listen() to the YnlFamily docstring under the
>   "Notification API" heading (suggested by Donald Hunter)
>
> Minxi Hou (2):
>   netlink: specs: add OVS packet family specification
>   tools: ynl: add unicast notification receive support
>
>  Documentation/netlink/specs/ovs_packet.yaml | 130 ++++++++++++++++++++
>  tools/net/ynl/pyynl/lib/ynl.py              |   5 +
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/netlink/specs/ovs_packet.yaml
>
> --
> 2.54.0
>

