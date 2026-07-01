Return-Path: <netdev+bounces-303886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2mWeLHeURWr+CQsAu9opvQ
	(envelope-from <netdev+bounces-303886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:28:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99A6F2185
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:28:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="I8M2/bw9";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303886-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303886-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80439301BA5F
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C9B4189CB;
	Wed,  1 Jul 2026 22:28:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772B3CC327
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:28:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944881; cv=pass; b=cvByqUTCtwfgDMZn/av6ck5NZsq6hxFh52af9e42ZoUozmQ0enZf2W7wkM2LMlE0P/a++hnzIhq7ygBplS0ZxG/zkTKKfX5Z/04aiy2rdRs2eHGRHV5gfGCjkDPurHhRBv+PyFHRj+efv5p+hwi2JNU/vrTSqJRFlYO29OiCytE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944881; c=relaxed/simple;
	bh=Sm8YNKS3FiFCcj7xBJJ/yxMqcZTUYh51cN/OPPDJEvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGP1UR+RZ3IJMRtJx5YNFC/NPRaRR5i83GZyEkONtvweWBqQr31F38GGFGcKrTYnTxSTC8k8AQWysHJnMXD7wg7aXf2Hl4CnZpTTiue8HVftY1legSiKf03FScZ7OKq5LGidJt4udeIybu3JONPxbOdz5PhAepqG7acON1NAnrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8M2/bw9; arc=pass smtp.client-ip=209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c125bce2294so136487666b.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 15:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782944879; cv=none;
        d=google.com; s=arc-20260327;
        b=ZcH9c1tvxjEZcuf+8DjHQgscg9BSDnuJ3j3dWedth6w7Vp/sgmoLE+xa5S8I9CG6D7
         Cl9zvok+3DhRM01QQcmFAJyZgRhBpcMRob2vguM7xyEDooEHbmh/+C+abduuJ28mbf//
         ZHvOIv6fPTBtu0GPJCMXFJ1AY/aW23i3OfIWZy4IYGZ61n8mV8bWnren8u9P3DfqGuG+
         Zy4eqHbI/fY8xM4S+CbhSC0R+dhmJ8158fR6DIczQADzOr1JOO5f6Opwx0/zSBQo7vJo
         Zsu1JVOk5Qi5PVQF25UPNyMhekqmaKFEUZ9bWx+UUHc/z9ibJV+OTO1w2mpgmfOXPFVX
         ZjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sm8YNKS3FiFCcj7xBJJ/yxMqcZTUYh51cN/OPPDJEvk=;
        fh=v5Zkpky2q7N6hK0/4JoL1gqflNZUi5tXXG4jhYzP5Rk=;
        b=jHdHPfabM9uX9lz0QWUetcScdyfTuH10h0SFPB7JzqQ/TZX7iTP82FB7AE83vVlWUI
         c63NGsLLkENIVA36ROhs0YwDReG7/vG4QOg9sL+DpTqdDP+XKsrmPYNVnShwEdkMHm/f
         7QolwsDzABmn3/jbJWjMX2+UrjAHORE431TfFn696LqQ5LhFaEoeesT8m+ZK7OnfNDrQ
         mQRdrHVF8wwmThq99vYpmdcePa977a1kXpfrvAFB7mdvvqbT/5tsokuZCZwd719laZn+
         FWg5xU/iJLxjgjxgWFBSRC5nlWafNl6ivDdJ3F1q5rhDzq9HXwgC+q1Zvi8y/vzz7p1c
         /zJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782944879; x=1783549679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm8YNKS3FiFCcj7xBJJ/yxMqcZTUYh51cN/OPPDJEvk=;
        b=I8M2/bw9Xvykau/HhQMRxt5ldJUKpjQzkTymikh1mh6t5ukW9cERCg6/FjbjIuamPb
         M2va9gC9nybI3DPgSlMfSrpaD2SpOHbPdGPN57vdEfA49wqAS+9naaNm2zfvq1tyjDx0
         u8dHN1v3N/XydaLiqI8gHZ8Ie+mNe7i15bomcMyxLgcJRIGh4YUtQpqlV1lWKsIcMFn6
         e2uquYI6z1tD1s1sBDqWYzQOfPBrh02vW26hCm6BUjSC6FZ7sBhmvINB+n5DnrH47Tx/
         BIFnh3VPzS7NgPUBt/fZgBfCtNP4L3/qgsYK2biPiaFl5GRtEX/drnp1Uysc0kNunqk6
         Y2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944879; x=1783549679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sm8YNKS3FiFCcj7xBJJ/yxMqcZTUYh51cN/OPPDJEvk=;
        b=mO5mAmjJiZqSfDH5dBLo7XhAZslJBRl84TS4n+JG0EF0lnRv0v6x0PF4OzWTgyWIzy
         MrS4eLWjGlPBGgMm8Cyjax9FMnKmmAp9qa00nrxd1MIp8nfdDzyZD7CXYF7R5kvJPoQE
         xFQGfG1lk8q0M9xt8fKpZJ7HPpjGSFdTqPMPbWQ0FEPzw0xODogaOHhZUi3/1BaGHuFj
         YHk/iK0CMYML5Ueen97YAiZxE+YGmzrctC6/VF4xWe73RqHdDLLI87dJHu+xOPdi/mGV
         ytvNR4ZzCxK6llMYjOMxBj5I0nXn1Eg7HMkFpCLQ1T6F1s/AusYWOnEzFkK/x1UdTlyY
         /qJg==
X-Forwarded-Encrypted: i=1; AHgh+RrSgGhD2pI4ygzLTSj0DFWiCRRFt6AEkG2X12gxlKxlPylOu5ofYbs8aDnWjVwNzqio6lWM2dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6UBzIW15qHej743hvnn8AlShtDX/hdw+euYtrSNM3xvAOZWbl
	vyGpe4uW/enU9QYWX5uBli0KqL1h8Sja4d8Ax5IZ+6UMit4zhtqizLuM7Nc/faGy2n8zp/98DiT
	azzVXdeE8c/9u+AbJAEKAhHXYZG2m7e7jXYpoZeVd
X-Gm-Gg: AfdE7cnU6jNAMmF6zxzKE3kVSdF6d4Cpi+Mud0vbsRzB77bZsWPomtr1yQYq8cRAVqY
	iIu3KhLjOXT6Hkf0bgb0bjuISebEJ+t4URLIhem0sCQ87IpjzSjl4vFxdAIqoLuL+PFhJF+25t6
	cx5Ks9udvCXvILxinE9MPYWMqFXlGR5ntXtWuW5A2lu0I4PIN1nMdySWB3RGzGuBB+giiXn50Td
	lC9q34v+JlOqJf6uL4MEhXIMSPDvGkiRwzq4yylfZBufDo+1JcPX0KowWKWFttsQPV/Ywg+0YUc
	RAET+Dh+MLuhSkYlzCn5Nhyv/EaD6PW9Pq3TkZ3SAD4l9D0c+uSlRa6y5/y7RZXtIVSiDNjF0jn
	EPfViqN89JHGtz1CnH5oS7jzsQoGufb6jkCZ1MjynIsTWCHttvr+5
X-Received: by 2002:a17:907:7805:b0:c12:a588:4113 with SMTP id
 a640c23a62f3a-c12ae4f2182mr95940966b.29.1782944878426; Wed, 01 Jul 2026
 15:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701094341.3218199-1-edumazet@google.com>
In-Reply-To: <20260701094341.3218199-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 15:27:44 -0700
X-Gm-Features: AVVi8CcDbMj1Le7OngcM0-5y7rl3ZXDkK6ahwP0ZeeriCLL_VcXrcK09fmFc2Sg
Message-ID: <CAAVpQUBrecJMKQpSq6RYaAY_E2=EbCncFHAZ6BobhByWNKLjQA@mail.gmail.com>
Subject: Re: [PATCH net-next] macsec: no longer rely on RTNL in macsec_fill_info()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Sabrina Dubroca <sd@queasysnail.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303886-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,queasysnail.net,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C99A6F2185

On Wed, Jul 1, 2026 at 2:43=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Add READ_ONCE()/WRITE_ONCE() annotations on fields that can be
> changed concurrently in macsec_changelink() and macsec_update_offload():
>
> - secy->key_len
> - secy->xpn
> - tx_sc->encoding_sa
> - tx_sc->encrypt
> - secy->protect_frames
> - tx_sc->send_sci
> - tx_sc->end_station
> - tx_sc->scb
> - secy->replay_protect
> - secy->validate_frames
> - secy->replay_window
> - macsec->offload
>
> This allows macsec_fill_info() to run locklessly without RTNL.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

