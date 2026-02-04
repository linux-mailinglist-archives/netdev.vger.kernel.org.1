Return-Path: <netdev+bounces-256793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DABF1CTg2lrpgMAu9opvQ
	(envelope-from <netdev+bounces-256793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 19:43:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF59EBBBD
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 19:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FD80300D15E
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29C423A89;
	Wed,  4 Feb 2026 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0UG0sbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414013793D7
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770230605; cv=pass; b=IRgQWuVOIhRxm2JfBJMr8IcCdir8owlCtjriFWnRYheXWTVA8jZQwKU/cGmQReCG7d+mLl6cIAzS1FBj9TfdeKILnkNNYFSbu0OySN0YB0fvh5ZcGPAywQ+lLcMs8vkkaMWU0KyZWe5B5K5lLfUKjO/7zHasJCksoYgp55VdWAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770230605; c=relaxed/simple;
	bh=9UnRB4C/Dya92+7m2jVFMMuxHkvUciDAiOD3/kX577o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVAySS0WU9NFLLmzkea0WhEv5ILU0wx3IkBtehcAK/61+cYrqXhEHmQAIj14N8qaHfawfyVDRUxhwIE/TOwV4ICbNEllNX9a60lDTSMFn8lI3CTxJjdpYmGQtAwdEL/nvZir1ceV4STlJPm9kQv0itt8zY/bJTruyS3zelwF23M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0UG0sbZ; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5014f383df6so1195071cf.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 10:43:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770230604; cv=none;
        d=google.com; s=arc-20240605;
        b=AKv6SGA9zHrNuOsPVUwrusjUG42AW2Ss6O+UMw7MUSWiCxujqykBj9iNV5CuJDBrBB
         M/xVMGvQv9MWdVz9oSVNOv7vBblyQWFlQTsmcZ3CILujuVvW6HIfUwqPgBvZpxgnPbvf
         SP2FWxDWg79g6eMV/fYz39Q+RoBEVIDvqWGIfKMc0b+VEobHspzJHzPJIIB+3DHdT1KK
         8LXNyhDtOsbNQ8QRaSxKGeV4dZgSsNDMwAsGh0NOV+xaCyXDbY7S4eFFrQn2I/PUSrle
         KzesAZ4qO2o/a9zEzWdmc2xJ2KXh8ghkgkGoMCAutkRgWldkv6/0DKUds3ITwPJ1oS+7
         vI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9UnRB4C/Dya92+7m2jVFMMuxHkvUciDAiOD3/kX577o=;
        fh=CTSEuSQvbROcUugPp1qQguONvXxniQOnccVK0DzlLss=;
        b=OUHRqN3M9HZydiB0JBoSwbqyE1avLGZV/d/Ijr/B2BWXelmBZLjmhYrUvr+0/UGWPa
         qipNvEo7qOQpaSENp0yes6uogk/EpIhJsVemH0Lfbzjq/hrntnw+QQu4sobxJSTDnsmV
         EHBEzS67W7IQbhqIz/Vx1utLGrEa1rXIBmsKS5lIBl2V538opxHknburL7tiKYiMwD+Y
         N3PWpfJ0pewWTeTRBsWoeoULTolwjjqMuUtIATuReYoViSL+KxlT13ajParpAdHJAKA3
         mUU0IqZFffVS1iwRWXzkmxYnHAwgyb1nfUcBgill95BFfklrT/80kL7QpCxs1FzcBmoj
         jJlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770230604; x=1770835404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UnRB4C/Dya92+7m2jVFMMuxHkvUciDAiOD3/kX577o=;
        b=Z0UG0sbZV9ILIAeGDtZNh0FM/6ALkVEwDA29W4ZBFyCITF60nTpkZqd27DaqSXGuQ/
         xrnAu7d/XAB/Ao8QaEQhGyiK+kuV/ngZzbpRs7MOEh84GCbKlCwvDWH6zTf+U4/VR3eH
         SfLsaDaB9/i6jG7q8+8XgSXBK5w5tQSD261zd61W39+DIMIK45EAiakvza+XL/FBSceZ
         vIxQc3kYgmIuzZhS3lRzMYcHanT5gIIocn9iQupAqIs/29FE4bpHtb1quQlAQTT1WJ4j
         3hiPXsdalEsXWvP0b+f0VRWY8ejt7MUK7zodm50w6eh98fVZ/lQD65IHs0lAO0tzDHgO
         /9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770230604; x=1770835404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9UnRB4C/Dya92+7m2jVFMMuxHkvUciDAiOD3/kX577o=;
        b=AI6hEhBjiJrM2p6scNdnWnSlDCTjKffhDcktUcfHdF2NesPeFi3e8nbr+GgFm7Gamo
         b90KRoDnugX2en9s7S86FnBIWYJpoyY/xtmv6QRO6uee5VXDai1t5e2viu7lJSkryi9H
         V7WXz+8aNraaPruPzlgGTwM9cPEsh5GXHQo/BpX3cAcmPlEXcv+XUEtuG1mLjpiwYFmO
         ylqHAgzuD+xs2xRy31Rgk9mpxszxB6+yBUYpfwHDhAD0uNJyxI8PNzxS610GfQnNIdLH
         m+s4a1D+jYMRGKh0ATHMqGfz6Pxmf4PR0ykUysw/R5735ptF2flM9rDAlmf71uVGj9os
         0SGg==
X-Forwarded-Encrypted: i=1; AJvYcCUI9Wb1Y3lZzQKMf7sp51Uauu3RhtYcFK26Ob0X9/l41sQjWZOSzga6VfA4UfyhiLgwAPR6ryo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX96KOXCriBon+o8qn32YoIz3FEt6lLsCV/AHWNlCcNFiI5ekH
	5r74FXbXDU95k2pv3EZeUUvu4HL2b/g9aVmpGrErfwdg4fcLUQI6SKQfh1vXCgrdJnlKhbK5RQw
	LQUKsELsHJAt2MXtoLtWDNr+BL9eD1+oeJ8j7i3dB
X-Gm-Gg: AZuq6aIDh5cd7IkbO7KB8QodmL02TBjSR80RA9pibQZdqsmkNPiFEqmkxFePlrT4MDB
	rNJdjKGhxSmrTIVxukGMr+AzZdCvyKeXlXS1zgo8+w0YoCG85VzCP0MgbzdBjxDi1reW4ew119/
	BgbiRckYNJ5bzjmRQJWLJFhhoph2dL/aZFPkg5VACkikuTbScSo8rrNZ8sVrp6ns4H0Q8VwGcjc
	xZzTq2flzV4FgzWSXBw/iBotLmUuiSNnhxXTxX/e+Xoxm/uhVqKEJ6ZnId+ngoKDotsR9tA
X-Received: by 2002:ac8:7dd0:0:b0:4ee:4a3a:bd07 with SMTP id
 d75a77b69052e-5061c1e957fmr47095941cf.75.1770230603573; Wed, 04 Feb 2026
 10:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203214716.880853-1-edumazet@google.com> <CAM0EoM=aJdS5D1eHUJHHA4outzzriZEKbByfmOTOoPxNih4Wmw@mail.gmail.com>
In-Reply-To: <CAM0EoM=aJdS5D1eHUJHHA4outzzriZEKbByfmOTOoPxNih4Wmw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Feb 2026 19:43:12 +0100
X-Gm-Features: AZwV_QgYEQkaxvOMfaQrQyN3AyeTyX2hSTwg847BEsLYDBJCZrTk8xZBDyA7Kuo
Message-ID: <CANn89iLi8Z0+910hBn1JK6M+AFtbr=HW2p0yRTPZNjG8XcZLgg@mail.gmail.com>
Subject: Re: [PATCH net-next] net_sched: sch_fq: tweak unlikely() hints in fq_dequeue()
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256793-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: ACF59EBBBD
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 7:25=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
>
> While it looks rational you didnt mention any numbers.

It is a very long process, one spot at a time.
Some cpus have a limited amount of return addresses in their RAS
branch predictor.
I am seeing high costs for functions needing a stack canary, for which
clang can not use tail calls.
When cpu returns back to these functions, we see a stall when
1) checking the stack canary
2) return from the function

I am not repeating the rationale on each patch, because we will have
maybe one hundred of them :/

This is also one of the reasons I am working on IPv6 stack to remove
stack canaries by all means.

> Iam curious, is it always _guaranteed_ that inlining improves performance=
?

Not always, but here the clang compiler was not inlining it because of
the wrong unlikely().

>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Note : A stack canary is enforced in fq_enqueue() (because of the
tofree[] array in fq_gc()),
I will send a patch to remove it soon.

Thanks !

