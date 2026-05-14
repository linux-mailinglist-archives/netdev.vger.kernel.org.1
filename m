Return-Path: <netdev+bounces-288068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Gbb7LdsMBmrSeQIAu9opvQ
	(envelope-from <netdev+bounces-288068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:56:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76CF545919
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82ABF30120C9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309C3890E0;
	Thu, 14 May 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBLoSkOk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514FE26FA7A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781397; cv=pass; b=m3ErMocs3RwyyhW3gmJVHfQ2SMHpEeHrc0CHy1BusKvPjQNrfrgogjVjtksEpqGxbiPiPAxwxTHUNM9x6VlzkPTwSYj/CqZXRheBGkM9sC+DzUIHrz/anYrwD5VgdX5E0PMmDuZ/gT685RtX2vokR9423oKbsmRYBAr1PFL7Sdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781397; c=relaxed/simple;
	bh=BnFR1MVna3CRaufQdcHPZCVj4voktoge6R45rDyddfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCBdKtFKpGeaxFzwS7TxQS0kqkaKxEdTzLwxzyO9Pxv1UJCkhxQbREwZOcC4TeU75mt8Yd+hGC4n48p0iC1oe0Bd8rSROGEZ5OeAa+Eo5JKpcz9xGQvra/ksH42H5W/XDhTGSgI+vkuQXbVIndw94kIQYpa0qmbcsw+Yc1dA5n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBLoSkOk; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcd17e19b6so4726162a34.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778781395; cv=none;
        d=google.com; s=arc-20240605;
        b=RZNFIUlzsXUYOH2cU+52qGoaAv2lz4U5gJAKPbQv8/NtrkOepaB3mX7XOsa3qKiToe
         TBbssp8+Hk7rpEDVPi75I1304D8S/nc1OieYpAAS+Fsz1idKfRbDYET2WLudHlgzit7y
         0PL9rAH4goErUQSqeWeSU7qCsf1HVb+bcVCYdKt7n3dvWH95lsHlsSbD6hxMPuxyFwW0
         ZrNh3wiBr6hy2qm7i08m3Ykm8jWroWfeGI9xbIPm5IIADS0DwNTQ1B/y+CKk+D/L+SM7
         egK8KeLegfU84W0TGLpQP5TRIciUUat4ECNFUZI1qwQcIp416Ws4q7ZisIx3sorr0/xi
         AYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WO7Vxg/KpE7haeje+D+H7hmJS41MpZOD31fBzc5qkJw=;
        fh=BFDWOzYJ/zSIVa7Rp3D6pM8EqjQznk8pd1TLH7QTuck=;
        b=Fo9F/UTNVgFrxsUPggol5syCzcUQPcogcEEtai3Br0obhctGmclM00xTqJGfVeAApq
         Sqi5kcDK/h5GBMM0qTKn8qwA02CZ+ocsxse7iqmV1Q/4FQeoRqQrqnW0lzknzcxz7XjB
         V2YvuC7NiBOcqE6kvoKxC+uVrwrQpPQRxvKELt6/KNlpo27DDsdTCy6RZkQAVxSBA/2s
         ZFRIjSpFRDLGAak7sRafNWO/W7MX8+qg061lRZQihYJWxkw+KkPJcAjeW19LOym0Qmxr
         ALvlD9tYIKmYAn4GVTnhMz8R9UVvxa0h1jHQhJrWxl+xTuQWa7DazidvU0rh8lnyyeMF
         dMSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778781395; x=1779386195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO7Vxg/KpE7haeje+D+H7hmJS41MpZOD31fBzc5qkJw=;
        b=eBLoSkOk5irDbYdUwj0i+BMLFoI7lC5dXnLRwOBQCpsOYXFIHwftR/qBzEgIU/pzMm
         uPKLviCyMxCyw00PwcUC0/Knn+3hTtcYWLHniXy3oT9UWWYAHLOcSCSXF2oqm6FuIRxa
         Sr1jCX1sq4AAjnWQIA82MedCIRjBayf5QgFMbmldqWxdl0beu40DQ5Kd7kbfC072G3Dd
         gJPLEsRfMvS/rh/CawDba6rwAhtykcvv+ljbTvTEJaAASgIzBTSe4LnLWt+djzMpui8K
         SVcaE2cqLAM2n5SGr4PT0YmUjmJbSNL1FtOmZJEkiTftP6dH0kRrK6Pf0bCnWuIuRrxT
         ndiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778781395; x=1779386195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WO7Vxg/KpE7haeje+D+H7hmJS41MpZOD31fBzc5qkJw=;
        b=YPmZzdOKO5fFxRghJjWYxrgXkCz3KuEEdKgypQLwXePauSt2IEt8/gBnDfkdxJ6wgv
         aktq4YCYkkxKPMqbILk80n+JbGcOyObih94QyFt/ASDuOFQcrj5qTFI88TePQHomshT3
         89oqUVTe5GFeEnGm3HbEnf/Z+YlXwYHU7xn3/mdXTHZc8Kenz/Gn1RDNzjM0vEFMP+P2
         wI/wmOPBaZjzsFVgNfTknbNmFxI+m8HEdey4WQLvikidNHseSA4369F7oez2ZC91Upwr
         xzLQIflij5m98gCz2/Odcy4TCOCvNbzDuRYnrRr+vzrPbdkwY5rvAv5KSUk7YfHj2QJ6
         8P/Q==
X-Gm-Message-State: AOJu0Yymi4n4D2lHJiyOCtL5/kPK04wrVVdGHMvz/j5CfObMsroTJDEZ
	+b1aXdbpwzMJKWpaZXjENoOcM47I+7JjjwovkEJhyll9/jMElOzBomCD9kAP+nAHixEBJnL7HL4
	2Qx4DRjHz3nLj+xjMkjwOfQUUzAqNfl0=
X-Gm-Gg: Acq92OHbCVRkajkDqcVPxDhdBEut6MVyJGRo+p7YAzkMHGUG9H40ygRaIDr7CK8c2nF
	9EstYaBDTmfcauO5vFdUmq3i2HSXO2/3iIN8oNzCeS0+g58a/91rQJTD9h9EGnQnbcKeHGBmeSb
	ruFOtuvY7esdOOUw4clxP2H/z5kGUvDtLVVwCBl8jn/C2drvetD0t4t8koT887glaejY38IuRtT
	D9Lp8kUQJSooCmQiTVko1L5lFZkolbt5gV4BPLLBUtrL6ZKIwkvRqHnOYIsyPwypnR4VEmv2scM
	ObqDvBnGUDxe/N5pwKIMEC1z2JpiDP35k7+Lij0=
X-Received: by 2002:a05:6820:1b0a:b0:696:1450:ff14 with SMTP id
 006d021491bc7-69c94372453mr288909eaf.37.1778781395329; Thu, 14 May 2026
 10:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508065757.2566258-3-mmyangfl@gmail.com> <20260512091026.279150-2-horms@kernel.org>
In-Reply-To: <20260512091026.279150-2-horms@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 15 May 2026 01:55:58 +0800
X-Gm-Features: AVHnY4IE3iX5QUa1wA2Epkhmh0cUWUkPBtz0iIjuZm0x6B5rdJzJzP-_ce25xyE
Message-ID: <CAAXyoMOiokO-yh7AVs6qXDZzfM3PVYUDRKHY7FdXivjpcH=5mg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: dsa: yt921x: Add port TBF support
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jhs@mojatatu.com, jiri@resnulli.us, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B76CF545919
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288068-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us];
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
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 5:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
> Is it intended to return 0 here without populating the hardware statistic=
s?
>
> When the driver handles this command by returning 0 without modifying
> qopt->stats, it incorrectly signals to the TC core that hardware statisti=
cs
> were successfully fetched. As a result, the subsystem will report
> unmodified (typically zeroed) statistics, which hides any packets shaped
> or dropped by the hardware.

https://lore.kernel.org/all/20260507012311.2187979-1-kuba@kernel.org/

Would a stub TC_TBF_STATS case that returns 0 (leaving bstats/qstats
untouched) preserve the flag here?  mlxsw does this in its
spectrum_qdisc.c.

(also trying to address that in
https://lore.kernel.org/r/20260509122238.2792915-1-mmyangfl@gmail.com)

> Should this read the hardware statistic registers (like the newly defined
> YT921X_PORTn_SHAPE_STAT) to update qopt->stats, or alternatively return
> -EOPNOTSUPP to indicate a lack of support?

YT921X_PORTn_SHAPE_STAT gives the token bucket statistic, not flow meter.

(Not a real problem, but trying to suppress further AI gossip)

