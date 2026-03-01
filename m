Return-Path: <netdev+bounces-262452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBlHJ4yVpGmxkwUAu9opvQ
	(envelope-from <netdev+bounces-262452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:37:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 041701D1603
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA713300C595
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF27F261B71;
	Sun,  1 Mar 2026 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3aTSbDP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800B430BB4
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393865; cv=pass; b=Pkr9g/vmguDXfOmngu34hmDjxQ0+YNr4OIFYZSahJ3XwSXPAvrFvD/Hm+yLm4UYK1xLciwvpt1JbN9WkgRmVnU3cgkj3EoC3ndLmUVu43AZ0ZW0C2EcX9ZiSKgPR1R2filxfuxGNTsbhUt3f0Fq5sUHG6bDErXg/bIAl79tpNCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393865; c=relaxed/simple;
	bh=Ss/HfluIeuel1vSwhR1AU1p2Q5Wgz6Rmpc7DlKGJdyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cndh1wrFf537KO+MMbXQ7/LzG/eU2u8fgRofFVrJRxYBTZvvH8wTYRYjRqmqT3zlLzNNIRh7OVKqKMkYZTmQDT/p1EUEGdYlv6DSr3DEZSb0peaorhoKVP7kkY7IRyAExo2M4EJVz/05D+jwtNCoZ6uYqCM3byjdTBTeCk5M1i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3aTSbDP8; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a1b23c05so46810181cf.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 11:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772393863; cv=none;
        d=google.com; s=arc-20240605;
        b=La0kiHVku+ZDrHiHgRq8NY8AovRX+1ow+5Ur85XW2BczCQFMH52e4rEobCFomqp4JS
         hxZXIXE4hOJnbKvAjoU9ztlAX7FECmo86OKh1xyDS/NSjPj4Nko7glx35RWceEub84/S
         a8LuaCLlNibUvKria+5M/e3jgMnTDvQuwVJ7OlqfISaIXv+dHUS8NWdxoYAeT7oCe2Tg
         p/m8Kn6PKc/LI3t7pDtCGJ5sBtiTZll7CpvDTqI8/O7iUk4wOaNKEzMR2xpUj0bW05gN
         GVI8lFomujzKQbprLRIbKKrsjMUwRNPshR15+4SgvfM/2kWBVHutqPsu3qXHKpSp701T
         VLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HY647OohaW/p7FBdbOuF/0uIhLghVAc80GOGvxkibCM=;
        fh=lxABWB2GNzx0fB0ZETf6sZm7OSjRltMJ1MNTFo2z4Qc=;
        b=UUi7UtBpe5MyQEbnF7Y+shQZHAYUrxFy4baQIrz+CuzW/TaNzmIRJgIJQcI0jJtrl8
         /2PDUXnI6gNb03n78RdaRHwZuylYcG6N4qFNi50lRjbv5AViF3jtYR31ANU/4NrQ0u7y
         NH06LVYAixxClrmELcNu/DC630MUHDT4slY4SsSgkn/a6jgR6mHKMYUvwhqghzpH5x8O
         ew9xkSOIkN2acA1jvG7CWAdFJ9tF2SemiP5aDvLQaxyWEOhvLPrRjf23hzD+XFwPPDXb
         M22G99wPsSyH8v3/nX+WzSIlrOsMoW+9pA/lSFWep1p2QhjSjQx5538jb+Evwo3d0J/c
         CbEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772393863; x=1772998663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY647OohaW/p7FBdbOuF/0uIhLghVAc80GOGvxkibCM=;
        b=3aTSbDP8M6tFRHTCx1IgpVQWtR8ORkd5p9RGkMrrRb8TPM9kBUY6fBJqLdIrRDQ4aL
         27IuZLGc1ow1j7cxIwP0fDydG1s7R7e8yzHZfL2rP2Mkx+ZWkSx6FrnA17IlKu99FcYv
         +LSh5q7UMkhOnkxdIh4a4Vf9ra0WJOsCsFF8OduD18/Ts3W51hZR4UibnBTEKVujXBwe
         ltvi7OKR5gp+dow4U3DNnpl1yUY+J1PBwihxxSDKxEbECicbGvAi4CfzAboc5N8bK845
         MEWxE3ju8jhG6YhbIdhRgfCKZHUs1tefltn3qMFIVQYoX9N++dEt/BwEaUoGFGwmBnhj
         Sxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772393863; x=1772998663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HY647OohaW/p7FBdbOuF/0uIhLghVAc80GOGvxkibCM=;
        b=k6thBAVvF/b70y2WS56BfCclhfd5zeW8D+ksFlp256/TkYrO4NIjkb2NlK0B1ae3vN
         YBRfIKxZDlWe+KO+1IB6hOEImLM67Vw/vNSHrBZiza97Jbmcipb5FS3I+X2BLFQO5S62
         bK9l2JKngpFoMbbd2LXXIlXozlvg5EFoEtlcB8wLfclRKZfWNnL2nt28qi8h9cEWI1Dq
         rPaoinZwDUgmH6OBZ3t48vcl2n4ydF6YFJwJoeNrmGX1WR7W26VClsPV9b1mDSR0VoQv
         sSBV13UWy3Xxya70KKZHSX3MLBuAi0lBsAMQx58OUgJEOhSnSemqp8I98/UV3RHkoAZS
         ZtyA==
X-Forwarded-Encrypted: i=1; AJvYcCX85SatRlS4zkvqSk+Ne+H6ZibfIYleguieJPLDmDAV8pC/QFVfXNT+o0qIL7OqiEijV31DK+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZybpNQV0yEHpQvCz4hn7idoZBHgji5s8YoJGCOSGguYppID7Q
	ivapjxkB5xBnY0x9TkdxMCn3zuJ8+uFw2qxDOSj3ujnQT7BT8yGUIDGuncN46N6oqCnVv84S05g
	WuQclkObXbQBVG98MZE6CmgOg69DJrndeBzw39+2k
X-Gm-Gg: ATEYQzzawKFFjL3l/fSRW9B0LR8LYgUjcwDSg9jpyaffZzZ1/04Hyz5Fvu+5XnhnUSi
	quZJEn17v0otfXfjsU2Qu05Bwt5iB8xy3UxsSMNxHOwG6e7NrtV2Ddbor6CyG7Rz1YzVM8FV8v4
	ivivzAxufBF134vuvH6RR/Vfq2VqRB/awSeSmTBYM/qqV2QwDWN3UgIcAadMYAhkPLw4y6Sa1MM
	GJXITxZ4/mCo4W7R4c//fo9MqQJwdNnhPMJljR9tPHUp6ZeXBLI5gbq8OeH5CAGl+uyO2ab8wtO
	u5XQYiLd
X-Received: by 2002:a05:622a:1921:b0:501:4b96:466d with SMTP id
 d75a77b69052e-507528ba223mr107424131cf.50.1772393863145; Sun, 01 Mar 2026
 11:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301162514.3347319-1-edumazet@google.com> <20260301112413.1b6c785e@kernel.org>
 <20260301113643.65e4e90c@kernel.org>
In-Reply-To: <20260301113643.65e4e90c@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Mar 2026 20:37:32 +0100
X-Gm-Features: AaiRm505PdEGIuzsGE3P1p0sJigVwi0G_0aYEaJ2M5nyLfBx24cexYaYV_k9W5c
Message-ID: <CANn89iLh_TaQE_5j=6nO-vOiCtqnrVrFPiBDGE7-ha1wMQTY7A@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,nvidia.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262452-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 041701D1603
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 8:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sun, 1 Mar 2026 11:24:13 -0800 Jakub Kicinski wrote:
> > On Sun,  1 Mar 2026 16:25:14 +0000 Eric Dumazet wrote:
> > > ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
> > > even if this pointer can only change once.
> > >
> > > Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> > > direct calls when CONFIG_IPV6=3Dy.
> >
> > Some crashiness detected here, I think
>
> Took me a minute to grok it but its obvious in hindsight so to possibly
> save you time: fib6_update_sernum_stub() vs fib6_update_sernum()
> We now call the wrong function due to the funny naming.

Thanks, I will take a look

