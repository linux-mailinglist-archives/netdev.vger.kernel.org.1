Return-Path: <netdev+bounces-297136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZNi3MIM0KGqBAAMAu9opvQ
	(envelope-from <netdev+bounces-297136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:42:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 280B2661E90
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:42:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=SZtOCh15;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297136-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297136-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8524632023EF
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7F5480DDD;
	Tue,  9 Jun 2026 15:32:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75516480DE1
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:32:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019165; cv=pass; b=D9iqbK8HoHwcbf3T8dtU2YrQKHNq9XTkH4sziFp9ncLIoZLFT9VwNURATnQhOnKhKYCG/M6ZnBSkZKcClkCMqgW/4hag/S7njXX0cMeK0ap+GQIRhFfhMn3/WEvahebv7cbpH1x+K19K0a3X3qooJH8mmEudfhFk1DNEqDYqc+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019165; c=relaxed/simple;
	bh=LlTubY2ijf/JHklTj6fiPshrUbLVncWjXvW/degCVd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTv81vYAJ8bv82EjQc4cwwHAvw4woKG+RGGxV+HQLq4DMPe6HmzltqeDutvTPMJb9XzyiFZth818mk0or+dhyyWIzBD9rSaxKiXlW1SxdQ7GG1QFXxrUHIn4MlZxhrB1+bC4mMleKoFFYrV8cbte+zBaWmz9Zr5tFk61EifjPEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZtOCh15; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5175cb5946dso37174771cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019163; cv=none;
        d=google.com; s=arc-20240605;
        b=XhtOFFCvUPaQh30Bwh1ZImCLF58/6xLq9Vh9HHmbPlevnu5NuLQ6VMrttN5G+q4HTK
         cUz0KGcS8syOrWNhymHxKMIofDirTfmDw0hQrIWg5OoP8Usz0XCaNBsRCJBsNLZ8cf2h
         MnBfvkdYhs8zGB023X+GMj2gxVQWsBBKWdWYcbHzbxd/clmNlPtfEaS0dfLC664ymtxg
         dhxg8Jz8h4MyoswzJoL2u7Fjj0z45vmBYyJPV+AtYgEl4Pr9eqtcNft1T7TrklcYGjBt
         g7RrHXWNpURH9okQhrL+374Hz8C503mFkgIkwgaNnd9kpDedvebGyC5iM0QpQ4Erd0c2
         ljvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NVdbuwWF6uhGW4b87pkkwrAIsiY+szN4s2Icl5Tv1SE=;
        fh=4JLOvqMBKizVeAfuqv+VXggYY9pgQy8rxzflRmz8Dms=;
        b=WB/2XAbbm5JdNpywqaxhGtLfQfSCfFpm8tD3v1B+uvwZS4c7MmYBQLnGOvXAItokmH
         lFWfuQltUnEJwvgf05FdJyNUt80QGFDZ2eGMQqbIa/pVupNSFxXMKeZhRZU2b9FUSDMB
         cvW5LXGYpmFrNYxOmkOLssDyG0y3ZDJPFMmX/w3ZZbw+RnxOXADQ2SZJvx3PBPr7iDQ+
         YGuw9BIERIRSfhx6W43enOgDj54T0GhMOdkU/SOexDKZtqb0QjtckBCeGCbXFn83Fzld
         wjS2EwRzprkpuaR+Tw7YNIAXSEne+iLc0gZkl9hd2e7pdlZjiQom1ekhtRJW1Fu/h1uE
         2wgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019163; x=1781623963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVdbuwWF6uhGW4b87pkkwrAIsiY+szN4s2Icl5Tv1SE=;
        b=SZtOCh15/21rlUqqyIy+o8c5xktHyy9AKVOpNgj0Zaj4MA5EMrEUYmLhe0uk4IeNth
         WEA/ur8H/b0wFoSbXvxzHaB1XIsvKMcciAOg1hZsubvuab/6jRLAMy+dJHAjGXbDm2rO
         RhPmaQ6/ATZpLOo2gw3Uorr41UgqLCLiqjlUdK6RnmKw6OQbdGFQ/GfxJNiyJ3mj7Kbb
         O6XN6jahoJjk5wkdoJHdP951rwzKiS8FEAe86H57kDf141STLgdV7zlN8cyvCV2fivEJ
         caBtMqZL1kqpvxIcco+2L6u9dJCRHwzUZNHO8ifCMo6yS260dXXARfNIWObbHUI83ldG
         gmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019163; x=1781623963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVdbuwWF6uhGW4b87pkkwrAIsiY+szN4s2Icl5Tv1SE=;
        b=adfdjFtqa4flkjmiOjIO2fmyQc5dhXzc9GAuP77e8ge646Nxo36qQMvuorf+rD2heP
         XDKe3C756KyynTiogHj3qdQx0EJUq+7g5cP2kEzQ335q1LR4EhjuWBMgX4c9vkgF7Vnt
         o9ppFThSTICIlpTiT1ZN3an8EvvBLFJdsp4/jxdpB3ksto/gmcUD9ledjlbX6zS5GYcc
         iC7HJX1JhLZxRANGP7ef+YIxp3ip9nJxn0ivFITCrWtwZtM6t/3pjKbIlt+19RwjxmRs
         l7PtmlwRk+Z+H+kE49oz/S308sN5dZGpqOuG/DlhrQqr2dl2gVIYy9cEv6wRhrXiCM5e
         uNfg==
X-Forwarded-Encrypted: i=1; AFNElJ/XuazzmqBwNe693L2wusoO2XiIr+j1qRriF/KcV38HWyMzfe/GlK+d7WJFYXzlAjzmt4Dp0mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAo7v3kc4ioQz2hHGTINDkRawaf+s02NOFwbH5yooXH5gxWCd8
	yaMaqhdY/AjOZpDNLDT1Q59DZOyvTBbwbLOdvn5R1wRABcvsQoxx02fXmwk2BrPm1S3noaXFm8h
	pP3jLC2P7xCSK8WNIHsuyeak5qFqaUsDFiVxRV3Km
X-Gm-Gg: Acq92OEbte+lX1Q+De/GW1mvH2K1/QsBQypMdYiYUW4HqtsLznIsnYEK++D7N7dycLk
	MvN5/GIkKtNMFwUze1MIanLU/DesSPYwgsNYCLlhWaXvosnIiefQ6FDh8ilRjGA/56bnBIBQ7w1
	aO0HuA8To0WCjzQZQI722bpXTGj2c5isbffRaaflFnXlB09u2DlNzQj10j/0Rb8hF6gyxqom1Ej
	Et8Qrs6lB/X0ZfeQ/RrUD7kCjvMQWFO1fJppDzbMQv+aOkUzr5XscvAqWB3nT4vdztdaXiF2P6T
	ntulI8Y3Gc8h212/Vl26mvpmPP1LoqNH0iKfimp37duq53PoqONHFylgLiQr+IROM3RLb8Yg0jM
	M6lNhrOrLRDv5ndb6mfJhluyxE5n7XA==
X-Received: by 2002:a05:622a:47cd:b0:516:e031:932e with SMTP id
 d75a77b69052e-51795a8d9famr284785271cf.4.1781019162564; Tue, 09 Jun 2026
 08:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-2-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:32:30 -0700
X-Gm-Features: AVVi8CeFbDoMGuL8IbcgJO3uL7HsCk3nC5Glsao4zmxzYm9m9lLMcFbKamIo5lM
Message-ID: <CANn89i+440xmCQAT6=c2_=mkh3W3oiJzhX4eQYffep6=xaU9ZA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/12] net: ethtool: serialize broadcast
 notification sequence allocation
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297136-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 280B2661E90

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> ethnl_bcast_seq is a global counter stamped into the nlmsg_seq field
> of every multicast notification, allowing userspace to detect dropped
> messages. Today the ordering is achieved by using rtnl_lock().
>
> Moving forward we will want ethtool ops to run under just the netdev
> instance lock so to establish ordering we need a separate lock
> for notifications. With the netdev instance locks operations on
> different devices may bypass each other but the expectation is
> that it should not matter. What we need to prevent is:
>  - notification IDs getting out of order
>  - operations on one device getting out of order
>
> For simplicity defer allocating the ID of the notification right
> before the notification is delivered. This removes the need for
> special handling in ethnl_rss_create_send_ntf().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

