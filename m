Return-Path: <netdev+bounces-299446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hcg8NDr0L2pgJwUAu9opvQ
	(envelope-from <netdev+bounces-299446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:46:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8CD6865F5
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:46:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ciLXu8Hh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299446-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299446-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D485C3001331
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C53EEADD;
	Mon, 15 Jun 2026 12:46:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A1035E944
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:46:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527607; cv=pass; b=VCXjM+Gw+TY6AL4shh9z/yYBl+82XF5hvuphuAZ44L+NWDx2zEUjg1/x+6iDLve8zAnk/2pnuQ7jbZcLp5kTQspFfFgWwqRqxF6OUpU75XKjyZ8ZY++AH6gTbt9zmqXIp+SNIFhOxf+1lQiXosTCOtaRw4zEMYmaUw9dAOEAhCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527607; c=relaxed/simple;
	bh=3Lps+/swdv5B8oIsI18ubpJDmQHHuoqy0iDCzZgTRZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADTZVUbNVLWRWGHH0+IO8kRkOM/VxoTZzCKMSnIm8m8unQOSI+3JVZ00AVhsuhO0BTFjnOtghxaqZGt/ZMy1W4Nf9sAye/yBrUUs8tkJNao2QOiMdyS8uxy8OzpV3Gbb9gAwq5tU5upBv38E8vrhqSWsT0BzG3qPFcHaaSZkRSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciLXu8Hh; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5176096116fso39961841cf.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781527605; cv=none;
        d=google.com; s=arc-20240605;
        b=SxHwRc0e2Gy1Cx6ZsZ1lzd85NmmqPAQeJcDFvsLwq+cYbp1jqeehzCTfqMfA+1/SYZ
         CXD1hE0xbuSwtvdjh33pVCHB5VNlL1WKsoVi1XbELgDR9Pox4DQSb4HZSFwTE6zDNvfF
         DlDxmmqqsTU9QvCIXqNp+t484gE2G6N4SITVB236RJCryxd+lh8wY3CM+Z+yLXE2nK4x
         JUgj/owtu4if3hY17H5wzCY0F6rZOhw3ba5w4+xtNVcWsxIRwr/SDBIO15MqtP+9PTS1
         AMfFUjFFwig71adQ0TW94kSfdTdu9MhWUAV3xjqlp302FgQ7l9LvXfdC/Cnv8ErCICor
         a7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+2rdbNXT+xv+zAckUng2k8s4ceQe0y7aEehPHBtDm0=;
        fh=d3OMof494wCNzojszvke9dc3OcKW1aF/aFzRBMjIc00=;
        b=jBwcjy2fWUfoN9CCGUppv9CzkGM+RzPMAX0uUsIrYPDK0bLd6uE7RUnLBx/zKEoKXK
         ePojVm7F/0Rg46+eztLRZPOp4n77IWikvbUXNemBuo++09lfqO+3qqiaSjwdn34gZpXl
         iIPhPWQBXnExB1zLN+fysu70F4st0gMdWv8/J6zC5cE8U7ijK8/5vFaXMrvKLeFL63Yh
         IOYXqen6tGDzXd9K4DJmUcjN8jufdKg8lNY9SQ9SC8EEuKiVvYvrfE/dG6dez7jqAnpH
         BPk+PTR9Fm0+VIyy0f/5/UVth0VqoNIu6CCW1kwvNH1fM1bvkKPeBHQRz1QTNW8Mu0bU
         s/rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781527605; x=1782132405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+2rdbNXT+xv+zAckUng2k8s4ceQe0y7aEehPHBtDm0=;
        b=ciLXu8Hhwb5u9DJ0Ga1IDYZf3dRX3+VEg6LOFsTqqm/Y67UuBWR11cnZbnCbp//217
         5Tq2g5ItUHOyAfDvhZEmuzdeQbL+NRep8RuqaqOQ3edqSfski9wzenjszfhKXMXJP45a
         +a/lD5RPrRwBCX9MeITuTzeElC55jvO0ylRBtvsh3C9c9Liyv7eF8DjHpDJvs6lkyAwn
         lkMSxZPfSdp9V1exFElilOSuPKzOMByk0pZclrz+jQ8/v+3a1h3QwejxuTF3iQwd6ut4
         sACbtiFArRXFLpvqZr5fzpc+YFnrXJFn1rZWpfi4+sznS3dyvflY/g9atBBajgfC3Vdz
         WSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527605; x=1782132405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+2rdbNXT+xv+zAckUng2k8s4ceQe0y7aEehPHBtDm0=;
        b=RPttlpeqwbUGis9ARJgiwoLhQ38IccJmShEExky5+75JQZisjHczhyPYWhcX3ekz3k
         evtZ4nSG0qw4KzpWvp5PAPtbNrrDCLm5lo8mw6WQqMhD8qJlDKoEvkYd8fmJDoTfpsJF
         kKn60Rn1bKbK4Y1ML08AaJfuhVHrYgBqFgsIFlkR34dRTA8mT42fVEAk9ENH0UvYREdc
         8HKj4Q2RItHBkgorHf9fiTD+ktiqAU+JiEq0DHaVZr/sV+KNreMg4VahHVzzy/f+qXTT
         whZBRt0FWGK0UQFYH2uiREuTHUrDP6BkxxTWxPvlm35uUlP11IhxlKuwiLmMv0TCmkFl
         KN6w==
X-Forwarded-Encrypted: i=1; AFNElJ8ZlThDEKQKcW1eWcefKwep8D28UPSXcTHJuifMnTbT/XHoRoIXFb1/PXgFTlPHTh4jqT4W02M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfVTi3TnFmGsIc7CAbRXeeHVA1M9wY2Fm6G3D7kD+1p8JWcQM
	nTAMcKuJJFAhtoedfZT3lIfrm3tTDC2ezCOcKHXav97lfpOW29gURqqo8MVStaQaIvXgQYwk/Fj
	7+6dhxNn3Y+rqlm+iNjyOoITCJp1blHAQVfuICn0g
X-Gm-Gg: Acq92OHWHUBHBPdGhn2DqJhoW0+v+CnLphxU30GlomR0jgBCtRiV1cIlt6g2zAURK95
	2HcEFu+nHsnWGf25IQgCJlkQTz6TCI7VziHBSB0MQk1JDcoOUpiwXkHweIaKjQuA0rPF6vDCya+
	h3rU1Daw5c9f2E91QWMGg8JY8IXI//34pgbjbssU2KvyXG7XLeQXvIQyWRnPEi93n8IBQG21dC2
	Pu8r5AijziJXa/JsAbstjcGav+P8esOiyHgtecMigYjyYzgG0OV8FWYMiHFtp/zXVXt2frfBf6j
	KNXK1QIj3ztmQY5so+pyXRssImfrZpibTpw6GLtp+GD9dIDDxPaJhSOziRXtKRKYPntS/Ge9XC4
	64E91MmuUcM4AkXeTXnZT
X-Received: by 2002:a05:622a:1456:b0:517:5beb:9b17 with SMTP id
 d75a77b69052e-519533573cemr169991001cf.1.1781527604826; Mon, 15 Jun 2026
 05:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612063225.455191-1-kuniyu@google.com>
In-Reply-To: <20260612063225.455191-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 05:46:33 -0700
X-Gm-Features: AVVi8Ccrp1fzeltd33Mo8sghX9R7UMQTOb6sob0ZZQLiGynRMVitOFeK7ETtcY0
Message-ID: <CANn89iLmWnmFRYoRHXAE+Rjnjn0DLZohrYqyu12Vev6f987YDQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 0/5] ipv4: fib: Remove RTNL in fib_net_exit_batch().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299446-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,redhat.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A8CD6865F5

On Thu, Jun 11, 2026 at 11:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> Currently, we flush all IPv4 routes at ->exit_batch() during
> netns dismantle, which requires an extra RTNL.
>
> IPv4 routes are not added from the fast path unlike IPv6, so
> we can flush routes before default_device_exit_batch().
>
> However, there is implicit ordering between ip_fib_net_exit()
> and default_device_exit_batch().
>
> This series detangles it and moves ip_fib_net_exit() to
>  ->exit_rtnl() to save the RTNL dance.
>
> The same change for IPv6 will need more work.
>

For the series:

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

