Return-Path: <netdev+bounces-255268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAQRDVYpfWlEQgIAu9opvQ
	(envelope-from <netdev+bounces-255268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:57:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3AEBEEB4
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3118330329BE
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F669344D8C;
	Fri, 30 Jan 2026 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VpnxvS7I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA65352936
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810232; cv=pass; b=k29kxnT8N9c05VokV9kykfLvDUWsUOHnhNE1S4WTMLvK+FY4EMrufTjWZCiNsK66i+SnEynicmXglgvIsKINnPcpTsW0Ujb8PJzuCkdr9RW7E48JfrJm7SHuLX/r0xS1/K4yPJ+HsnQvbAboQEKUvYt55qMEDQvNRdlWbxzqoEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810232; c=relaxed/simple;
	bh=ZAzvDCKA3yoG4zdUql5TXmg3+xq7tSh0DpwLUCCv05M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nV9hnXH8wGCZP7MhjzPhxoIyAGn9io0vUUE489YdBH4f5wDP9kpv8UwJrgDLyoHB4k8xr4/xuYmooa6XSOw9QzuppWuSpzhW+TiEFg3U/wQMWcuqbeZxhdy6tU7Jnk9/QdeARgmCMVXCLieJPx7/BVkvcA/TiWZ44cf8L44/D4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VpnxvS7I; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8230c839409so2141487b3a.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:57:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769810231; cv=none;
        d=google.com; s=arc-20240605;
        b=Vx9PdZJY+rE+YQVV+iUs6Aa12xQwPPmsRTAKtO9TbS6VeOn+I7vKjVTPAHQ23Xak6Z
         3Z9gMQnGOJTf+nVFy2E16EUWcMAYTtxAiJQACQYXSTUVs/jIjOzCQmZMQml9in2RezjK
         9oyfL0eOp3mbY6XtKHS3kVI1dDQS/J+BvgXleYtpr2QBspvqoccaczfaKPjSsMwIcyVH
         dZz5YCPf6UlV8Dy/gNXghVneED21sd/UNijZttklLYTQ3LvVygb+cR/SUyu0itFNZya8
         J7w5nhwdjW8HA41q2PER2e7ll2C7RwoBgcpdE8E1evXXl4uBwfoo9OlG6GDAcKS4CnEd
         blqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0f81vVRt9lYBgk3/zE7XZDsUfpQnZqBZcRRR2bNgTuI=;
        fh=HjHb777t8W3iDW86grBU7QuNi4RAfL3GUoZBFscD3Y4=;
        b=Mko09G3zvpIo9DFdNANB56yPAV/Qri+teoTwIJ1Ui9K4qdPaDWf3VeZ2PmCuPTGpLr
         v1AkAZPYuPIJzPyAWvi+/eHtF6xq3tfrV7GuROoFbRWJb4qCuXV+sI1ZvdgSas5NKaxq
         7pU/EFUQSUzd9O4sqxhzmFHLGRDl9focOqwcM8n//xlbmKYKXPZmE2ILjwVTTaKwLEjH
         VXu4lTj+RJkRw6TduOcrBmDXoFs5yMyawoJY8Tz+mGK3g+vM9KVp9xIrQWQgZoy8ojWs
         hY7e5XTPM12IIKLUohxj0vYiy+UW599/XrlOwBqQpYsM4MCbUjr5jDL5kydm8/JC50TE
         6hZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769810231; x=1770415031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f81vVRt9lYBgk3/zE7XZDsUfpQnZqBZcRRR2bNgTuI=;
        b=VpnxvS7IHTGPLMs2SEC80XwggxREItMuAM1sJ6KYKkMkMzcwvL+drAx8C7btlboKxi
         Uln4MB0I2BqeiGXLpBaXLA3eEI3FL1k6/XS+LtXEgHQYSh++vFCwH2r0gPTbbJuKSfEJ
         DhXk0ec+IN2sqWJR2VrqGh3wz+RDNs1dshIYqzrI57ysXyKyTtfahMnhHY6+PxgTfZvD
         6rjr+VVy9r7auQ318sPUXShHQAMkD6Bi50k2fv9ORIZkARWfrhCJwsG8XzU4ucoRoOEI
         C91VEe1//QfNPIinWW68n88bO+Ml8rdU9jJWNb+jzFujJIhG5SsTIwWA6Kf2ODunhLfO
         eoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810231; x=1770415031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0f81vVRt9lYBgk3/zE7XZDsUfpQnZqBZcRRR2bNgTuI=;
        b=eh+ojtn0v2g+8g/oSqJoEYq1yFMy81MMQOVvbrK6cNZIOG60OJ9VLTYONFMKG7d6pt
         SBcQIAld8OZJrUhHoNisbsnEV7ESgnAKNBjPAvlVN+o7a+Ot7leF1T9VKkMdfEI7vkig
         J4fNyJcNFrUiH8+zkFBAUy8rnhHKR4iu4RSPKE5oOVfByf+zmFve21tRDiMJZDS9jGlx
         vzpZ4qdSyl+2aWhIjSeih0mMAg5jyzy+tfPR/qk8/4FSqEY9lOfimFCN/PCue52rhrlJ
         +Z0Y7ZE7fdldpivUaCkbQezx9yaypZQcdczIA1hOj+QnosEK1lIN+x0LyDVYNMBlqHET
         pAog==
X-Forwarded-Encrypted: i=1; AJvYcCVA13ThsfGnubpO4GngZ1VoW9S7GPZUA+C+0n+H6tOi7EGU5qymSdG5kdxI1EdzFpvZlgJrNnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz495y4Laptt48uItmfU7VTFG1MrF2DT8X3G6YS3EMWV7jMGV5F
	G3SWf7Kcsw7WJ2lkat3b2PH16Xm6weKaQmT1g8thUvZgaoK5UO5bBPWgCQzckVLzkPtlhQBhi9U
	cxuePa9+CSYRVKgsihnYERNbI4zFMZbUej7yt/m/+
X-Gm-Gg: AZuq6aI5+xN0HSDN5H+/VsgixsMFfx3gEkKWWef267R4nr2kRxi7kdjAqoRCNY8BjYT
	kX8EnHE8KAIjURJudqzlCTZhRBVmZ1vhSyXu6/9nT2/gEr/5mTBwJYtktM8N6R4zAWdoW7CQSm7
	908eQj4u293lQGNsuYZp8RMwy+mo/4LvnDcOvDg6wEC74fNi3jS7JVA/ia1TbWBwnyDe6hRvMWL
	S6Wbo6pmt41u6trj2ZL810ALsPAMoztT8gSBSKJFkyXeZ6YUL3Ky0ftK6O2PbjM+HNei4ZgNvUQ
	7g2mTw==
X-Received: by 2002:a05:6a21:6f88:b0:38b:e398:b9fd with SMTP id
 adf61e73a8af0-392e003c0a9mr4572431637.20.1769810231121; Fri, 30 Jan 2026
 13:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com> <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
In-Reply-To: <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 Jan 2026 16:56:59 -0500
X-Gm-Features: AZwV_Qj982ND7TJxgyw6A2KozmEAmOpS-qJ0nHC9KARsT_E53n9R8n-IFelzO3k
Message-ID: <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255268-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:url,paul-moore.com:dkim,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 8C3AEBEEB4
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 5:28=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/01/28 6:59, Paul Moore wrote:
> > It sounds like we either need to confirm that
> > security_xfrm_{policy,state}_delete() is already present in all code
> > paths that result in SPD/SAD deletions (in a place that can safely
> > fail and return an error),
>
> Yes.

To clarify, do you mean "yes, I agree", or "yes, I've already checked
this and can confirm that the LSM hooks are already being called"?

> >                            or we need to place
> > xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
> > safely fail.
>
> Did you mean xfrm_{policy,state}_flush_secctx_check() ?

They both call into the security_xfrm_policy_delete() LSM hook which
is what I care about as that hook is what authorizes the operation.

> Regarding xfrm_policy_flush() as an example, we can observe that we are
> calling LSM hooks for must-not-fail callers ...

We need to make sure the LSM hooks are being called to authorize the
removal of SPD and SAD entries.  If you are going to remove LSM hooks
from the existing code, please document how that code path you are
changing is still subject to authorization by the LSM hooks or explain
in great detail how that authorization is not necessary.

--=20
paul-moore.com

