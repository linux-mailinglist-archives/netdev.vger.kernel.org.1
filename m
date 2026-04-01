Return-Path: <netdev+bounces-273824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJKSGBV4zGmxTAYAu9opvQ
	(envelope-from <netdev+bounces-273824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:42:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7D237388A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBDC13013B61
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA227A10F;
	Wed,  1 Apr 2026 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2arFblw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0665F347C6
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007761; cv=pass; b=Abn3LiGAL0upvbuzccaMhWt/Ugx9oAjPyZwYUTo3bmrbsjTIWYQMlD4uZumdQAWZBMSioTh/J9U9G8Ne8OlH7S9Uzf8USAkxuOmI2J4RlcpY4BUhwtJQB65NnoczSu17TJ6/lmKNkItRpZ4wALRZAcpWgM1QlDL2W1XEzl8tyzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007761; c=relaxed/simple;
	bh=+CueuBEFQLyDaLLPGAviVcZIfDrvhLK7Jnm9pbO3sAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9/s4NZtbVP3kn5wZ4RTXZZ/6UHc2PJ4dAZp+/E+QGIV8P+tIvX4fqQDoYM2agxs4AR3CFy5AG6MSoFHRSZjLTA9NLis3Nshve51NKTLMbSb08hfUeuAZxLChhs24kS5iRNqLpMcdXz3v+05mZ0GPRLlm7zuXpgH+GT0jxY94TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2arFblw; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so21960a12.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775007758; cv=none;
        d=google.com; s=arc-20240605;
        b=RibyT34A7dgdyu50N38ulHOkEvoB8FfnAqlDMA/0tKnmFZGCstIQs+PLY5NROGSNx9
         uhQNjY8nAdA+uqngi2Frekd3EkLuS54ChkYty9STtyOqqzswh5XEeStT7leVS42GQhh4
         ap66GDarmqSXrnDk1ivMurJ2TzJXAwLgxICzMp1Aoai2RQE9myxoIuw24FEjh+DOo3Fi
         N6dCQPUgil5vgt4ueSGvAW73RkMAHikWd37+fkbZmLuNKqiHIOE3E0dYHe9ymps4CFbQ
         dbeo42mlnt13NgCj3t2Ob0CTbZ36RbXVtsskK8m7eEy+Es0IRISPBfejTItJRnQ0cOvR
         ClHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+cip8P5+Sbm1YzuMFMquH8b9zAj3snIJVnb2qZXOIJI=;
        fh=Ty29K3c0/e1JHf9AhhSNhbhaB9gukdHlKKOqyaSLwWk=;
        b=W2ae9hEZU2b8uJIf1yBhmlG6nLKol5rHH+OogUjmm0Q/8BlJtu9xMwqXlL7eRqUUhO
         CXSWhZqsmhN3Q2NGp0vQ+1JlPADXGzYb8097vHFPKnNflxz+A46FzI7BTZdcl9W20Db5
         27RLrJ+sBNbbkG88cvu84p+DYJ1fzyhBQkSnoTq48Gagvhsu309RCXSlDArbF2WIKMza
         OuVie/VOnftQHeI+szzjbLzmMEHO46Z+DaGn1SDr7JjW7Fn5/9W2BG17Fx0N4RH2BI6I
         1qMBxE0jk05jnwW4B2rOv3u+OPChJgZ3oscpuyTXc70fLIYUpehjmAFSjQMI4Ojt793H
         L98w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775007758; x=1775612558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cip8P5+Sbm1YzuMFMquH8b9zAj3snIJVnb2qZXOIJI=;
        b=v2arFblwfVBTdgn+APy/BHGtfliTQiQBgnR3Rv+ueC9EuqlsLNYyFFDwEWliv1Fjhy
         1202JcaDRj3WxzgDHiO2PbvZfH2KWZZIu4fZPamN94VzocawQtyi/qskWVFuiNzTVVWi
         +QOMCvZKTLS2HARlF4HWIrCyRNkuH/30o4vZKOi8eCH++Tyqu+uZ/NoY9ZFrPqA/vnHJ
         sTggl4dJ7OsBP8OdSl6zghuGhfH56/jPwT5Dh0bBzyahkVD/z1amzs7OGE4qewsV0SRN
         1CImugBXqPcQHdTfKQN1wwN7Lw4ei54kJT/NjcHbZ8PQ+5h+3OSAGwBlbmxyX6hrnT2i
         i1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775007758; x=1775612558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cip8P5+Sbm1YzuMFMquH8b9zAj3snIJVnb2qZXOIJI=;
        b=rRU9Dg5fr2KxnLmcopeEPgLY8vhxqjvUf//HYrm3VgeXA+XBGCb1eGzxzj+jf2JYQ3
         Gp4CxOURKlMKD8eqHZry62MsCeOzt7LEYXmeAKAaHfompMivKRfeVw5OABy/u3+cvPKz
         fVCMqrKh94JgEiYBzEIDluRSJ1wsatrkt+VpPPOtYHl8IO0k5wUjHRTFlkC/nCx00mC2
         3yee/buvn3u0KXhfox/YmQeXu+yJsEb12wbFqusPjjsqVounFMp2iL9BbjwUmWDp5tHu
         /JpmoJWyL3Cv2H+/OJomXY4dUIkrQD1boNJMY7KDoSvjiYJf2YtJxLyH7INePhl5mWTV
         K6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWXS+4sZ41clXYatLcCzIyiHIYb2rH8fZ0ZxesgMc8le8EFYkQ0pPCliZIrfnlBfVbkIcerbkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfkktHej8fNKgq36RFnpYBBd99kE05XwwEXkde53YdOzAH4ic
	n1xF9L2a5TllS3okGaXmhE/GF7c0wRagWMJAFudL5i0hDfC8s4xUYo3oBQV/uveZSD+aZ2m+yhU
	e2ZwV9zjoId+7u3V41WGCWR47BLRCwv3oSsdBtqmM
X-Gm-Gg: ATEYQzz4K85ecwP6SuAxhrTaNoTVpzpVKi5nQf+UA+CX9pOqLyKyHuMtHm54Cw3c1/+
	K+DW+eEafTSVRPVKxVqOT3XNyO1D4ilER1S7TF5RpA9we6eHT37qHUcWZUvBXZkIs4UC0nh1/rE
	v3OkorDbv4P1p2/vNse0Bbl5KnLKlTRkIWHzd2Y44xf4JrI1t81ilOSoSiattDCt91GyOpfQez3
	XpjNh9nJe3LMQp2ZxWFZd53Igy+GTlTw7KDVHgtfUk8AFHUPcTIreAEi5N4K8vvNKIaRE2ASAgr
	KkhLaNmQNL18YhL5UhC/S/JPG4XUMhVp48IBX5Zi7GrJ9b3A8W/B54ApUseVFEI6okzv
X-Received: by 2002:aa7:c441:0:b0:66b:ed69:a85d with SMTP id
 4fb4d7f45d1cf-66dd127fe4cmr17744a12.5.1775007758009; Tue, 31 Mar 2026
 18:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331053353.2504254-1-marcharvey@google.com> <20260331103308.421aac59@kernel.org>
In-Reply-To: <20260331103308.421aac59@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Tue, 31 Mar 2026 18:42:26 -0700
X-Gm-Features: AQROBzD6g583ppKPRqiZioo7JPIgeyQ8u27KsUKejSiYP9XMnx5dnhkXN2kL5U8
Message-ID: <CANkEMgkMRmyi3y-PdVTN66FHSrEO=neCp1N8PWbBrSA0yfDAzQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] Decouple receive and transmit enablement in
 team driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, willemb@google.com, 
	maheshb@google.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273824-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CD7D237388A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 31 Mar 2026 05:33:46 +0000 Marc Harvey wrote:
> > Allow independent control over receive and transmit enablement states
> > for aggregated ports in the team driver.
> >
> > The motivation is that IEE 802.3ad LACP "independent control" can't
> > be implemented for the team driver currently. This was added to the
> > bonding driver in commit 240fd405528b ("bonding: Add independent
> > control state machine").
> >
> > This series also has a few patches that add tests to show that the old
> > coupled enablement still works and that the new decoupled enalbment
> > works as intended (4, 5, and 7).
> >
> > There are three patches with small fixes as well, with the goal of
> > making the final decouplement patch clearer (1, 2, and 3).
>
> The tests don't pass for us, any dependencies we should be aware of?

Ah, I added a check for this using the `require_command` function, but
it seems I used it incorrectly. I will fix this in v2, and probably
remove the pv dependency altogether.



>
> # selftests: drivers/net/team: teamd_activebackup.sh
> # Setting up two-link aggregation for runner activebackup
> # Conf files are /tmp/tmp.zYDeygAAcf and /tmp/tmp.y5dfmFapAj
> # This program is not intended to be run as root.
> # This program is not intended to be run as root.
> # Created team devices
> # PING fd00::2 (fd00::2) 56 data bytes
> # 64 bytes from fd00::2: icmp_seq=3D1 ttl=3D64 time=3D233 ms
> #
> # --- fd00::2 ping statistics ---
> # 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> # rtt min/avg/max/mdev =3D 233.163/233.163/233.163/0.000 ms/bin/bash: lin=
e 1: pv: command not found
> # Packet count for test_team2 was 0
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # TEST: teamd active backup runner test                               [FA=
IL]
> # Traffic did not reach team interface in NS2.
> # ./team_lib.sh: line 87: kill: (597) - No such process
> # Tearing down two-link aggregation
> # Failed to kill daemon: Timer expired
> --
> pw-bot: defer

