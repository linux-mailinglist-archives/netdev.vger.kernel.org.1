Return-Path: <netdev+bounces-269139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGbnN1Pruml0dAIAu9opvQ
	(envelope-from <netdev+bounces-269139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:13:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F772C111D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4233E30B349C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEE533EAE4;
	Wed, 18 Mar 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBogQ2Ow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56703321BF
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853568; cv=pass; b=JsLB9fQebxesu5FxuB9ArwTVD/FxXSVigQolqnydngaxTEaQ0Dsh2f05d+nqXD1gv8y2KO5SZJb3hPvlaqbf8cYZVkhsR7GmyU5QudFxRFz64oOy0hzeohdGCw5qoTdSBOGLG5d7a26x/BPd1wXv3R+nNM4SuaimaL9P1DpXW6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853568; c=relaxed/simple;
	bh=Hz8E05LdBGmu2bfAFeryryBDZivcDYI8jWINoREv7ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6tRMfd30kHBR9q+ePt2n/iffqE4Mut4s6tygGNQs/x1eTaNAVM6sqxDiMU/SAt7Wzn5F/m08DQ47Ioj+jSpD1+JgW88aoNXeb9ymGvee/+U0vry7s7jpn3HkfKqnEX+Xtw7Va+Ux5JZnXidIdY3xAcLPlHj/T+R6A1ReKlssxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBogQ2Ow; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b936331786dso3783966b.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773853565; cv=none;
        d=google.com; s=arc-20240605;
        b=HxF+wAXGRyKyi2QKt9cP7frik6HJqZlgtSNh3sH/Q1Lq3CrahsYuKjxi/c/uyoVBz3
         SZ26BOhRkAuk8l9pDmIgNTULgpuSOQzUpqCepQU3l9AvYKrrhKeMObpkoEXNHslu4jvI
         0RH7f11S1XyK7BtZUy/OSHQFwBsXDznVpvahqSi+AzNv4vbpLMXNu2877RY3RlPFGpJ6
         JwErxYUutpevWNrMbeAmtJKMG75G5hC0MTMBKOnopoZkVDtiGGtKjgWee50ppBVtoHLA
         MBL/MKeb8GeAQxIqD5NoGG8PufLjg4g+VfVdhHlwJZ4QZ1UloOOUrx5DKlNPehE6MAgH
         jHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kATEDVmGF0/O9M3x0zcBp1yfg6DAeXFmwwnXfMoTIKM=;
        fh=9zSqdaKBQSll1dK5i/GYjrNhfXzu/S7murne7xvzWA8=;
        b=Ku9VVmQFOFL4MGefc3KP+DzUA6trGhbHdSOagYG8JxsAsyFemQXnrFD5cUNUltBlBl
         X6KFN2Qx9Y5lo2Gm/Pg0W2HpOXzsYFOopAYwj7NyxFvQF4vJKjDW5hnCyHjfQToAHFOU
         kO0p3tPM1DSrG3x9QUM4VV4Hs/E9vH+9HVoqbjahqFqhaAqDoxvPMwuLSN6IRMo/sQMp
         t7h6iNYDjxAkJrBX3d4X5b7eNXj1+bMpNEiF4cO1g7LI6tQVfaNI8B4UgcZIUfyn+5Vv
         hqWuN+uB/TGhs9UQnDuIxW3MI97X27HwGGVV33TV37Rz528vDb6l1YqfyFsj5FKGbRfY
         mWeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773853565; x=1774458365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kATEDVmGF0/O9M3x0zcBp1yfg6DAeXFmwwnXfMoTIKM=;
        b=SBogQ2OwU2DRgi5gY+jzSDEtDWk+k1aN43X3WBa7UW0G8we+O1SRWXBH3FyhQT4P6I
         V7hVwvSfsjMpbYRKw2MCp9E4/18/JvQ6HHHqOobD3EMQLGE68RAL5kXpKIkwB4bXyjB6
         UnKg5HLQJgfRNS2n8kPkSqoL/4JwR+/LJIxrjCiyFm58cML43jbKdAS1JEpLstV05RMF
         XR6bUkBdwYNtj8W++Vor1dCJkKb86teC5+ESF9Lmq+SbFGR0CQ4dXcdGS4sV3XmgIKC5
         XuhEI/AF8ii7b5PtvxF5HxsSzYGr7KKfTBRYlW5NSpsMXw2P9b8oYqJj2UbI3x/hyB8/
         2RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773853565; x=1774458365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kATEDVmGF0/O9M3x0zcBp1yfg6DAeXFmwwnXfMoTIKM=;
        b=Um585Kba1nmhzTmBzjAcdqVSQSGq7biHdmU8bk0cDR3fmvEQV4OQ2PL+N0/ThvJAHf
         X6YUjcRPl+EDeRx5qDZGJLTHnC4pGqbqM8Zqwc5OzniRb9CAj3cY/pfvs45NwxdIcGAX
         XaHnlSBwSwlh0coYJhfFLwAqkGEC2FyXdmQov6EsZKo20LMwt/gkJG0Zl4Nvn3qYKIlf
         nP1C7cj6q1t51hgf0Z4BKZNFxB043Qyohp36WBHvCkktRRzJej/CYiRBjSbiWMHzDC3N
         ifbi9irY0GT1GqxRkjLUF9t7rvgUC7YEm7kDpcm5LtRH7EY6CZ8yZRZeh3khcva5fExE
         ELaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfJ0y0HC+2MJzS5R4q+H9mbmoTK32in2VU8UCdsxWJw/K4q4TtqMzxkqualTP7gtOkJDHbqSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxatPk31zG3Ch8ccMfK7FuB8UN4wlKf4TfsZAYpSegzIgllY8pK
	0AX25oW6P27kHugL1Uzi39WfocmaCl0Ok05GURKNt5TZA99HvbONJPyh2+g3k+50iSTpHZQP6Zn
	xzpoKZ+7U+5FOvwv7rsxLXFg7cAncR1QJpySJQoE=
X-Gm-Gg: ATEYQzwzR4viwXb3Ycz9a6aON09Qrtwa2Nd9CYiC9OsAJik5K4MgYf0rhL4yUqRJ0R/
	XWKH7dF2ZWCIrV7/1cnEWn16fUGr7cMn8pChOkzEckUbbjz7n/xKqEwDGhj+euihsECVmvxG7wO
	n7eqCLm2DithpqeV9ADjDR7g8gDKMR9lTfIQB1k9Pm19VDgAauAMMohbM1CKTkFPdEHBYeg06NH
	KOdgFj0vsJHwolTPN68xBjZOjS7Gfzr5CRO1jV3wXtvvmV70rjYtMpdAZJtibSea4EPJiAHg2+5
	PaqpSDyahvJMEMW7ca9zjf/oP8BJF7UBvFw=
X-Received: by 2002:a17:907:9946:b0:b73:4d06:bc8 with SMTP id
 a640c23a62f3a-b97f4b60eefmr194003266b.53.1773853564611; Wed, 18 Mar 2026
 10:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
In-Reply-To: <20260318073330.115808-1-guwen@linux.alibaba.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 18 Mar 2026 10:05:52 -0700
X-Gm-Features: AaiRm51pAIUhiIslZYeLgnI5zv3XevZ8aLuUPYbmBN9fBas0fAu2t7Z9AQkAyFw
Message-ID: <CANDhNCoFxsXdP7d6nbLTFLOrB_4GnDvhF4O6ZGyvGEVoqV4U2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] ptp: split non-NIC PHC drivers into the
 clock/timekeeping maintenance domain
To: Wen Gu <guwen@linux.alibaba.com>
Cc: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, anna-maria@linutronix.de, frederic@kernel.org, 
	daniel.lezcano@kernel.org, sboyd@kernel.org, vladimir.oltean@nxp.com, 
	wei.fang@nxp.com, xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, 
	vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com, 
	dwmw2@infradead.org, nick.shi@broadcom.com, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	linux-fpga@vger.kernel.org, imx@lists.linux.dev, linux-s390@vger.kernel.org, 
	dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mani@kernel.org, 
	imran.shaik@oss.qualcomm.com, taniya.das@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269139-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,nxp.com,linux.dev,linux.ibm.com,infradead.org,broadcom.com,lists.linux.dev,linux.alibaba.com,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstultz@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.934];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 17F772C111D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:33=E2=80=AFAM Wen Gu <guwen@linux.alibaba.com> w=
rote:
> - Following the model used by NTP related code, this series lists tip.git
>   (timers/core) as the integration tree for emulated PTP clocks in the
>   MAINTAINERS entry. Guidance from clock/timekeeping maintainers
>   (Thomas Gleixner, John Stultz, Anna-Maria Behnsen, Frederic Weisbecker,
>   Daniel Lezcano, Stephen Boyd) on whether this is the appropriate workfl=
ow
>   for this class of drivers would be appreciated.

While I'm sure it would be good to continue to CC folks, I'm not sure
if the timekeeping maintainers would be the right folks for these
driver/ptp/ changes to flow through.
Thomas has been doing the heavy lifting for a long while and I'd not
want to put more on his shoulders.

Richard is listed as the maintainer for drivers/ptp/, is there any
reason for it not to go through him?

thanks
-john

