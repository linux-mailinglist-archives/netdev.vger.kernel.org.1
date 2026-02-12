Return-Path: <netdev+bounces-258463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOwFMh3rjWn78gAAu9opvQ
	(envelope-from <netdev+bounces-258463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:00:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5712EB54
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FE3B300C590
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D135B659;
	Thu, 12 Feb 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Yvwdi7HJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF562F6199
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908369; cv=pass; b=Tf8iSl9GKnBZC31lDW0Rj5Lpgml7SyrIuiIwfMr/cUWkbHCCs1Gq+l2qZB61QkJThj3LBAZQfVY2bA/wyHGqXmHKkwT570ivMCBO4X0sXe2M2wmh1ucoWHFQG+Ptv2lASNlsHjR4hLwrIUr7g8SzdkEiDdq15GS+RoF2YMygExg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908369; c=relaxed/simple;
	bh=yGn21hxAcgcmG+63AgS3v0qYovGfQ2LjythatUWGR20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAQuHfqNpLDuh3EAe42L5o9Cni1VXhMEfPSCtOhvIbxxD+9uPytC1mvDXy18aWNrUQVDLVqJwDk2qVub+m0h0suTASVRfzXHN/gYT6vADFvROKMr4sjpPHDjqH0f4mSyroaoUJPQ+kDA6TM5QoruMQUrJUE5uXF/dNhHSNOre9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Yvwdi7HJ; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ae222d978so4908196d50.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 06:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770908367; cv=none;
        d=google.com; s=arc-20240605;
        b=BdenF27dCdzG36SvqlRDx+Yc5nZIxb8hEQy/AHkA5HUR/oxvc+BcnmRcv30qDOCWFI
         PLehBdoGqhq1BLJ5ZY0fBj7hRoWVcsHUOJcqNOBhoIf7GTGNlz42+1Er5zidgX9tiNm5
         GDSPIkUM+lKXAK0tQoIaPp/WNQQ/Cg4FKvqAGR7hvxWSF/7iCRlj/U3mUtskYSGOhfVm
         pNlvjxQ7z0PWvuzATJ3QuYjWzwChhYFH2oHC0FPDyQY+cy56AOImTuMdbgOsF7TOUcT+
         tnUWgS0b3YD9GGDdvCQ/QXfYorIenT5PKZQ5hkZmVef1EpdRkOajCLKYmiMzM6vSaYCi
         FdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yGn21hxAcgcmG+63AgS3v0qYovGfQ2LjythatUWGR20=;
        fh=Ou6C4V6XYbcuAWBu+SkNk5ZJ7lHl5TO94cEy7KwMm58=;
        b=a4uJoe9F8CGjPHeQsod7RSZt4GVIjRbgc6jAKOeALxhVuT8xxXUFylvM7mHt1+I0LC
         8yL+KFUREa6MiwhISBv6//1OkuT7EtdbinDOavZ/oUKWJ4WVKNicKxl/jLpJhfD1Zosw
         qU1JRNK4YJ5XKpv9XQKvmntAPKedOYwJrSCZcJ2pMQYrsM4vMaESVjnYB/qm2GYHENjN
         Ab07wK/IjMT2eLy05Lc+DMjNilx1CCbZ06mAyFcqSa/XexKBtIPu2g74m5x6Xi8jnAey
         gYpHMl6kw2W6y12vech+Ge/dH0kg2PDMVpdQcY1Z92hXHWr4RmF3wMI0qdpwhICAYAra
         30+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770908367; x=1771513167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGn21hxAcgcmG+63AgS3v0qYovGfQ2LjythatUWGR20=;
        b=Yvwdi7HJ/E6jYa4h50wEB/QaCtgajK2q4JzXlvGgT1cfgxnb51/j72cgaSW1PrzuV5
         REn7gVIVfLVuR/r514dbSbi1FdIy1eeDZXOuky1pSH7UTeE1or3V+DYnY9dLPF+0Wd/j
         UtJ+QD19NdJL4TZBrOStakGPbL29U+jxnV5FCOpmoeWpxM2/7jR8BBOyuQ4wlSYMoGph
         /Y/gTCS9n7F3Cr9ztxAoa62H+brzrwbkBbgBNxU2TKgO9B+sihQDR+jPZllYyBRpvhgR
         3OIJsXo64TBxe2Kiz+WpuXWq3oqvcZybpTBdNkSWgud1KJ9zSfrCNmAi/5eSL9FbZ7mv
         4k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770908367; x=1771513167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yGn21hxAcgcmG+63AgS3v0qYovGfQ2LjythatUWGR20=;
        b=grlMviMyNP0gCc5NrP+1t3xVpUPaFAdZWTPTUz51OFlT5xuHBDbzbKjUGg145COPjX
         Hx7lqWoT+mLbccY9OjfJMejvUuWscfp21kf9G25ExLpgJ586T51Pt4TYUeNdq/TRUbpE
         Bq6Sw2J2D1tOKBhnmiDG+Hpo6jBycErey2OGkBde6rCj1sRNJ1HLA6mhkna2PPI9toX8
         E94UO/BSJCA7NGG6TDeGn3VjM6vK6suvLMecr0u1Nk1CjL1OfCAx1gJfFqFd5+K0Hm+T
         KxJ+geYf5YxD2fOGLRYBnMLVRKscAcGRF35smA0YObnz0fefCUw0gnTGHL7detmlUhUF
         EX6g==
X-Forwarded-Encrypted: i=1; AJvYcCU8FmQquT/x/ivQOocNjncpQEcE0Lt/BKIe8cWQAMmujZjoRcC3DKRMjJQqr8uPwnHxvIdu1+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9ZTVjI7YaXlN87ySNnhOsaOdzeoYNrWRy2XWQkA8J8nzshvR
	c9dkBvVT8hwUo3DjK4gWVRsHtbYCp/Au4GSaCmLCSkGico8kKhhDD+sv+J6KQqVir4bCgKXe7/U
	tEsLTBlEvX24dLvfjAOcEjwc2HmaFnh2PcvdQNPYmBq4/+L+nefk=
X-Gm-Gg: AZuq6aLsnJQn3Vnv1vO1hVFqB4Ukx9lJp/HwYWwp/GQ0Ceb+2iFn9PDciq8Tl34LYQ3
	jZfUvOt/aDtqi2Rgd1klIo7qAJtCjuo3D1BREbOIWgU26+cDZOYZH35nhPx7RQLFOX5cPmw77pK
	LWMW9uyR+O8dLc7/8oX+MsQGxx6cjZxSq78hKhcsAu7gRanvzLnL4xkAjrm2hrQed3Lp12s39/h
	WnAaZ5lxKkyKk2Rt9Rt52QHaSrVtgn6VvKi5PLexeL++hzlRFuCwKpOsUl7/OQ4T/zYOKoE0mOz
	FA1tGqPbvDKeVQv7LMEK8Q==
X-Received: by 2002:a53:b1a2:0:b0:63f:af33:e413 with SMTP id
 956f58d0204a3-64bbaa3b703mr2031466d50.24.1770908367555; Thu, 12 Feb 2026
 06:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205150958.412278-1-p@1g4.org> <20260205150958.412278-2-p@1g4.org>
 <CA+NMeC_v8bQo2tFUYiD1faMJ0Gd9FFbqmPHCvBUD7HW_yoCx0A@mail.gmail.com> <nmLWEyw7BWgMgTdbfbxbYI1QqIF-IPdNFFsdf_T8qY8IBncn1bNnTPDe9Bz1AWfsGVt4pgj8wLzhB1DxZ1-RzuZiW2VZLamsaBS4WpjC8lw=@1g4.org>
In-Reply-To: <nmLWEyw7BWgMgTdbfbxbYI1QqIF-IPdNFFsdf_T8qY8IBncn1bNnTPDe9Bz1AWfsGVt4pgj8wLzhB1DxZ1-RzuZiW2VZLamsaBS4WpjC8lw=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 12 Feb 2026 11:59:16 -0300
X-Gm-Features: AZwV_QgRSL8UTzEEJf1PL2FE1zP9TG_DIZ0npWBwNFXgTFImvInzr5hzqmp5_ls
Message-ID: <CA+NMeC9XPutYDqbpYDuhyOp5tVUp-knoujWOHNf1reg=eY3Kcw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-258463-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[1g4.org:query timed out,mojatatu-com.20230601.gappssmtp.com:query timed out];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 68D5712EB54
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 9:18=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> Proposed changes from v5...v6:
> [...]

I think I understand what you are saying, but I believe I'll be able to
give you better comments once I see the code.

cheers,
Victor

