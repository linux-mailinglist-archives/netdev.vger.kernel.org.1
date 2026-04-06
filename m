Return-Path: <netdev+bounces-275612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKxrOkjD02mqlgcAu9opvQ
	(envelope-from <netdev+bounces-275612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:29:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46B3A40EA
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5BBF300FEE1
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10293815D2;
	Mon,  6 Apr 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdGYgMut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9723803FA
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485738; cv=pass; b=CQj+maRgmaIlGxhUyf8K+UAXpp/tatLtwhFY+N00ZRnLUjBhNtq9oOhafv3CWaj1YroekfczoH48/mcipTdiGtP4EsxLDK6WJaE/dSgUGEEqQErBDd5/LckkjXtRskRsVroB0WKTck3Nb94xW6El3sKre5aPiZIJpen/MC60kn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485738; c=relaxed/simple;
	bh=RN4e1YhDSg992awiDit4aQ/vN6UYLHpPa8oGR6pnBZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR2KuvoaDp2QdfqbMn/c6ajdEh/wHGdZj3fbOrNFqpjwVl0l81owMsveBW/yb6dmxYWQaaKmHx6ZqiNwBR+HmHQTV8rEZxtzKIASQkX6hiUfvLG3OREbObmpTp48fdCLO5cLH4zGNOUnKCklruO7DktxpU3HC4HGXnIUYXNBONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdGYgMut; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d7e9b97a73so2973322a34.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 07:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775485736; cv=none;
        d=google.com; s=arc-20240605;
        b=Qz5hWptMDPugC/Goq5CvN2ZguifcHCPhr2Dkx9D8poJhqDAzKGmzwrlHRREQom/Gep
         r2KdGyOChKXEeksjNNvLMF3AUM6OjUK9ZXPvHAxn1rXXFdnHvNUOVuBoWMsbngEiDfPC
         JQjLMBVGzAXwtuTw9pGPjunf2lNGmdtF0bCbXZww9CIZT6jzYjItQ7XOscm64kvibjcv
         lnFdelZ1XLEmKH1ZU6j/BVhWeK1r4yCCPhSyhTgEx2PJyj24R2+oMDihbI6WJS0Ozs2H
         RWsKdrWFvg44Cyto8YPf2m7lXZtd8OO2fv4OA1xT1vvgD24JqblmRNJEL5LiCjoIgu70
         hjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        fh=8ifBJYBV/anOwxQ79H5tHVtvLHL0yGZFbBOE06rHE3E=;
        b=chPCAvHd8/RyDzt98l4YgFoTtNOe3W+nxVrCFfSMnEgShpB57grX2u3venDUE0IegC
         67k4Hmeyc04IiwA4W17iLL0wQcsrh5YxsSmEZDCcUPBGzxzke0RCfg2JBVXyZc+xWc0W
         OXwS8ck+yHQbS6KKcBhLr1LSatkoy948UyH8zM/l0pnCrGlPcSwo5B3nvwqdN4tGsNy2
         lVrqULEx7qQ4aPZGWWgi9bqnRGU66J5L/2Sg1g9SA8oZ59Df+YGUFeUVYwxVRB+6KqNk
         tgc6wzdIzOyvZSHRmV24/f4kAq+XM5xGv5/6IVbLgF5p3fY02xPYlgmOXqc4HhJbwakj
         WptQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775485736; x=1776090536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=XdGYgMutbu3g/mpl/gEpiXrNbPBDV+odsxZL3o8drZUGowzubMADFDSWIXewhj8sHn
         TzV7wY9DGFtzPMZBWkSShrjaDJ/PVYjJRAgXbf/EfCPXJE9BWekaR0/4xoS752TmjwHh
         i3gIgkN3ebcqUw53Cnptdd0imdbSFVFGjZiSNPxZQinfJFxklQEYB9zAAcZwTHh5/L2k
         gzATHJysj74KzKE6lXqI5o9ljoAZaRTfhYkfR+fhohpow5uoUp5OpATFZdp5HVzFFtql
         vr9ECIupiSBNvXPvvOcp3MVtHNMgmRv3cYGFhBItr3vzSj1n5CB6kp7fi8hgmPEHW1Kp
         uTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775485736; x=1776090536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=eikqDtgiBQU0L2r6jNAYcFhe17TZlJsQHqKBhNu0JMUHSlpkyTliAA25RDD4/wFwiH
         x33g+ZDf0nUfxl2wWS+pNQ2qbNUJ2niSzqM3ajnExdb8n2kOXrsIp+9w9hOrumTMYocB
         gYcIk/L209b7wQ6fHnLd3ER0cu4/jRy3d2WHqYB71KhlnPV1b8IpqSwQL5BNp06sbqJ8
         2JVOacejEtdbzgRji1Y56/jzffXQSM7rHpwQ/u9EzxVqxm7IaQ6CETYGGTtjayskJFma
         ev1PMWkviCV/lZOOAGAD7ikQwLJ8TqgjCFBUWqUSgZ7JBbIcA5wLESHeCVKuRkH7IGlU
         y4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXCIn1n43I4xyjt5kRoyCvcCQ8X5/rIWf44/YZBrzNbCiTqN3KrAgFfYpvNgD2ezbRARKEuleM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3YX/3hq4EKeaFGU4kvKHMkjPT92P2HLPhI5uYAU+tyk+xG5sV
	HFIt1d9KIc/HgLO/l/ASIcAZ2HYpm0YIMto6rFg5MCek6I19turIOLa21zwTYQJ/cGXCK097/VV
	wCVon2NWh3RH8sRgyyY/+XaNHjElT6yA=
X-Gm-Gg: AeBDiev20e+MtM5dv9acGEilJyEdEPGGk89u2SqsMZlVFt8NlW6ci7scui2wKXxJyGU
	P7Ah0wzumG6002nUg1l2wvHEZ+YQp9bEM+5Ffw5WfoUAjF1btxGM4dfuZMkeCWWOFAAcEXpNBbP
	Yrh3vf8I+q4HwNh7WO4/o5HGthaZZCt4+q8ub3KYyPIv38eHJw2qQWoaV72lq2YALspA8hF1lBQ
	8X1jvtsuWee3W7H9xFbS/MExVkeIrfOh/V5rGjqdO/jDizRsc5bscyG3XCtdKOx/HZGFy6jeVtQ
	52lIyD+qXBxUWJ5+0XJIVaa77kWq+/JScAu2yA==
X-Received: by 2002:a05:6820:8318:b0:683:6dbf:c6d4 with SMTP id
 006d021491bc7-6836dbfcb7bmr3030718eaf.22.1775485736189; Mon, 06 Apr 2026
 07:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com> <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
In-Reply-To: <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 6 Apr 2026 15:28:42 +0100
X-Gm-Features: AQROBzCw7pv9Q_nhcb2cp7aOThL8Ubn1v1x8P2vXHbgAOxV1wipCcpu51-53q2E
Message-ID: <CA+XhMqxNzaXZRd0co=_gaJsN4zS9L_4OVqhC174EPxA-pzEUgA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, mptcp@lists.linux.dev, dev@openvswitch.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275612-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4F46B3A40EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mathieu yes this is indeed a valid point, will address is for next
time. Cheers

On Mon, 6 Apr 2026 at 15:13, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 05/04/2026 17:48, David Carlier wrote:
> > Use the typed random integer helpers instead of
> > get_random_bytes() when filling a single integer variable.
> > The helpers return the value directly, require no pointer
> > or size argument, and better express intent.
>
> Regarding the modifications in net/mptcp, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org> # net/mptcp
>
> > Skipped sites writing into __be16 fields (netdevsim) where
> > a direct assignment would trigger sparse endianness warnings.
>
> Note that the AI reviews are mentioning that auth->client_challenge from
> net/ceph/auth_x.c is declared as __le64, and it might then also cause
> sparse warnings:
>
>   https://sashiko.dev/#/patchset/20260405154816.4774-1-devnexen%40gmail.com
>
>
> It looks like they are right:
>
>   $ make C=1 net/ceph/auth_x.o
>   net/ceph/auth_x.c:574:40: warning: incorrect type in assignment (different base types)
>   net/ceph/auth_x.c:574:40:    expected restricted __le64 [usertype] client_challenge
>   net/ceph/auth_x.c:574:40:    got unsigned long long
>
>
> Note that the Netdev CI currently doesn't check sparse warnings:
>
>   https://github.com/linux-netdev/nipa/issues/76
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

