Return-Path: <netdev+bounces-256336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I0GNX8Pgmm9OwMAu9opvQ
	(envelope-from <netdev+bounces-256336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:08:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 368ABDB16D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D1A302A6AD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E98331062D;
	Tue,  3 Feb 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHzrTtCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CCE30FF3C
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131323; cv=pass; b=VShX2c9Zobfi2INTTCu4cyMCX7tAIblSijFOT7d14LHxQK0l0cQ8YfHaTBkpcD1yEOPcIlbmnhd2L2YLEeGCjfY79TPv9pHpRyFCfS9q20ugNNzXND6lPtb6IAx8QLzRdhPzk/+1tpHgOg1bwz6Tqcs9PQe4OXukLZLWw/STAew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131323; c=relaxed/simple;
	bh=dLwhPzO5ci89AJamct/0TDGWXR/7sdMpdjrHvBeisqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCkcVvM5nMybRExIBHQOLaPY18Ho7eTCtgvtdd7Lm9Da2NoPizX2Le1700AGPqKNihzQAPNTK79QOoutboMtUA7AutkNrs1+rxhTtfY+Oqv8wRppui19QNLsARBfMXP9ygU6vMB3/Wgn4BzK6K7T62fk4ZMos12Km3zJl2yn3AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHzrTtCS; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7945838691aso13416497b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 07:08:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770131321; cv=none;
        d=google.com; s=arc-20240605;
        b=UayLw+vaRZyzV3f2IGVz5xaXw8z9oCALDdKk1Wp1YdD1qaEt6sT4HafLrivgsKDV74
         AN7/sPKHxHSA3qT8HDyYEjp7J1+tWjm2Jfe8HqZXcMwxwL0EYY9VEa8RjZm218YxtJPN
         PBatGUoYHhxkt0ogNgqxeiVRgQOd/TzfnFS2V5Z2ofSKYQakbfn8REieMdlm8KFT4daL
         V+Gch8RTXci4f8vMBRuhOQNV/Ej3nUrTKlS0XQDAwaUAqcYGRt1fKcPNkiXds8YMa4P4
         Ski1cN8Q3dvfJnVkrHrFaiFHKc+kqfqdjQ+fSoOm3JLC7lzkBbjNIUr9hXr6xvklT5hk
         mU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dLwhPzO5ci89AJamct/0TDGWXR/7sdMpdjrHvBeisqU=;
        fh=MeTKWLi6nkrmImvDGYQejui2wDC4algaAkOc/F9ZwJE=;
        b=jWYLfbl15r1IUI1aicyH1ZiLpFQL8ORRsOoUvoGtfdibXzo4GKjsdc0RByMDimeuVK
         OTERUlYFDTEpk8LsROhGXNhEkZ5zx4AWKSSpssHeWfh4JGjebFpiNl3Govsb3AQQwJwV
         auF2zPT6JNwMsh7r+4SSYHOJlS6bxLj6Mtg0lEeSz9EYJ8e0T7YRHyaP8UfESTtbtcqY
         sYRjcSZM1D3/2gZOogaQf3JBUssJzpBxSD3wFWofAyS0QKXUIDcK8VPpvCYSgnFlBmNz
         B9jbXKqht9GPcJdRy4lm+gveZMf/0t+mo3MiuJyox7e+h+ZfHeTaXSUoM31wtK0jaNjd
         vk5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770131321; x=1770736121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLwhPzO5ci89AJamct/0TDGWXR/7sdMpdjrHvBeisqU=;
        b=nHzrTtCSFhLYgllkdKMFI61NqCGXsRJgJvMim/PTp/ECsr5FgEbRmAx8S5athEjP0r
         +yk/SmBUulrmdsNRNVeXo5kNbSiCZmc9jW/ykS/DoDOzvOy/ZWy60ZFFBgpulbaAPVSv
         D6eipKpUgNL3WcaaD7+V++f5rXiXxpAl8PNH9CaFE2sJHcoI+cyoygbgLhy/2LcGi3iH
         /6997Rl2ZXgC+8qDV/a2NdUM2v5FK61MT4SWkNrqmCb9uW+22UUdW3Gelis6oG2oh6bg
         wk5mO401m185nVJY8LwdrcFR5hJ1ebFvBtccHG0mzv1A6O88mR/2ViJRaq3YOg9js5Hl
         M2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770131321; x=1770736121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLwhPzO5ci89AJamct/0TDGWXR/7sdMpdjrHvBeisqU=;
        b=nnSAvMe3fr/b1TD2uHvf0I+fpNR0cplzJPaBLWYG+bt+mkBMPf2G2UlyHADKlOGF0A
         xNCy9RJTetGFCd6yLhCm90M2E4+omuIzvGRduBX51yAIl66sDuyaW79tX6l5AajTOeFt
         tCNzQPLBiiEa2Ar6C4r0Ll/AU+lky8InXmLfq5l8jHwr/erY/D71XXY1kStdVrL+SWbZ
         5P41+0+m/ixxfpd7yUh0w/yOO89pdd7HG3Ap0R/Lb30G31RvYXkyressTeJRcRJh1zlv
         XhDrp9d7v/YjzGZNQY0+4okNu/QmkDQs23PGPh5stW6mu5rzfue9R9gYY43FzjluMEZ6
         AJVA==
X-Forwarded-Encrypted: i=1; AJvYcCXspYg7tlo2l8XHQ9Kpa3eGQ21n/DQg9x1x/mP2MJLChi+EP2qy8t42068yhp0ZntdpSoZgSNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3eS2f1+Fot4RQdVtex5a3Q+j9WctU0ZIsBNMWbTh8eHkq5Zp
	quQ64PH/mkyuEZYnA7rycIYD3clXuQveQSQjUy+rSMZqrhCnnrW35ZHqTVixfQ+J+kY6O0aKXp8
	vPnfVYTBGDLa39ylqD0soACjW3cHxcNg=
X-Gm-Gg: AZuq6aKDYAflPoslpCnJ7gp/N3nZoBUEH7iCTX+REtTuY/6bvn0DmS6QkEqgeQFv1j5
	hSMmY3CmXUIlM1K44bWJ2+AEvN9xvbxAzWh7sTaKebYlOWNS3IPF2GqXLQkF/iMg6vEMOlEDcPy
	OoidHIQTO2PulLIUyZWGjhSYaKZUfCzzIEMdGZVyu16IEN9QJbtRAKuPClgT25oBkRzzE6UYnf1
	QRYzb/G1n0FAt63LNql0O1+gRI5y2x4xfoXx3Y+CZkwvVlPoA79iDVtZlu+iidZmwBmztd0n0XP
	JAfnKe6PnBkNVwxp9N2Uwc1d
X-Received: by 2002:a05:690c:87:b0:794:bbca:7f5b with SMTP id
 00721157ae682-794ece32112mr28375927b3.28.1770131320425; Tue, 03 Feb 2026
 07:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129012902.941-1-dqfext@gmail.com> <03c714f3-edd5-43fb-a0be-8c4a43bf6101@redhat.com>
In-Reply-To: <03c714f3-edd5-43fb-a0be-8c4a43bf6101@redhat.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 3 Feb 2026 23:08:29 +0800
X-Gm-Features: AZwV_QhLGv3AIxSulV2m_PV_coaTjvPCiU13Z6w_WpfRLVLO-uryb0nQYB38NdM
Message-ID: <CALW65jYYdX+NQ-6vNBdxDGHxDV1AdKQWenFZNjnqE9VQyC7fog@mail.gmail.com>
Subject: Re: [PATCH net-next v4] ppp: enable TX scatter-gather
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256336-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 368ABDB16D
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 6:55=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
> I'm sorry for missing this point before, but AFAICS channels with
> chan->direct_xmit =3D=3D 0 do not support GSO packets at all, and here su=
ch
> packets will be transmitted after linearization (but still as GSO).
>
> I think that while transmitting over !chan->direct_xmit you additionally
> need to check for GSO packet. If ppp features are recomputed depending
> on the channels configuration, you could chose to drop such packets.
> Otherwise you will need to segment them before transmission, and that
> looks error prone in case of multilink.

I don't think that's true. Using the current features set (NETIF_F_SG
| NETIF_F_FRAGLIST), the network core will only enable the generic
software GSO (NETIF_F_GSO), and a GSO skb will be segmented in
validate_xmit_skb before being passed to the PPP driver.

>
> /P

