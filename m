Return-Path: <netdev+bounces-285536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM74K6cV/Wn+XQAAu9opvQ
	(envelope-from <netdev+bounces-285536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158284EFE28
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DB2B301CF88
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF6438F232;
	Thu,  7 May 2026 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWOjnEZD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C13537C0
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778193828; cv=pass; b=qRAoKoOQ3XLYCWejDi2vPeImqStlyOFsac10Ub4OxkAQWNgoVKkTlTeUrHFUEpNI6eMZKmvLG4h4d+2uWZYbjk7p0B/MVME82tHaOUa+PR0UzzLwfrHOJ2o088KI5ph6bL19OMaq+2ZmBEZcBIg0sRSelGfds5OHAhpvKX/H9JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778193828; c=relaxed/simple;
	bh=w51oDYJjUofMBSFSgifaMQ9ikyNon1GnEnPJh+5y9fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M27338a8QR1gkIEDRHF6z+rE9Tlo2Goin60OadabHDjXkV7szpmzg8betpOBElw9HPF0jI66obsC5zxu95O5wurYWb0MTcj4GZkHdnmVjThgymFt8fUzGV3zBxEAOQLYtH7TYESHE35JXrSgHbYz+vUaWN7yZG9n+7PdJLIwvvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWOjnEZD; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso1213243eec.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778193826; cv=none;
        d=google.com; s=arc-20240605;
        b=GOj0W/3nHtS7sVdM2c1ZhCMNmSbG1uOXuu9aXYs/AQpC0Etsp9hxbhkreTwZ7i47Ao
         jcvUepxXYIofNKSbSYT3tX6sduNUn8qowrFfgka5/jsIlG/ApRGNEcGUw790hCdrOP4K
         be62isuxKGe1Tamc0QPRMWbbFyU5vGYhSTXb8Z80E2GWZmvxtafiNVSmjmc5E0XfZ+lb
         nNhv5FWrRn8Wig5NUk9Had5yvW04QYOUzxJkkcgYt4U/k0wQCoYKsp3ohW6JKPV4Pzj6
         jWLf3Ak4iXLwxjdzaQfv1/RGrOryGLVTZ2p+F3E44z5RRdnC02iQpcNfgXgQSD+17aeY
         fomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w51oDYJjUofMBSFSgifaMQ9ikyNon1GnEnPJh+5y9fE=;
        fh=pnd7MFSprkKeTwAUFQhEUPOBUwvKnX8g9CksdyDrPgI=;
        b=U24xsf3z6pMsUDnMbfTbQ2F6zE9a2zkfI0Td6Mvi7RmRcEzzKLEtKFztWXCA53gydQ
         XrC1tFdZ1uX3YvVXcXbhQRo9D5of5djewi2sbC1GDXMUxt7GMt2ILw2sqtpAVWW0OjBw
         wl6eBj+T9cD2EwfdC17HCi/mGYvPVcBXfVd05mcvi+HUbqnvpclecK7sdZiOJeld3Tty
         JoPuf7deG6hejd9B+u3udSIZTw5uoLYaoMniHnPD3d5CbKBVufJr1bg2RDEZXPuoGXX1
         XT1wkssHowq5rlF/azikjJtwquRr17f98sJknfWPu1inPCL+7+kOBGmw7ozxMnopL/QS
         jVpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778193826; x=1778798626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w51oDYJjUofMBSFSgifaMQ9ikyNon1GnEnPJh+5y9fE=;
        b=eWOjnEZD5GBUC0fu2PwiLaNZqKh9zHtmTuehweLV9i+w5uTkL7NB2i1vF6npN+S5Xy
         EEi+Z44fhiYc+yyZ7xVDm78WcSuzZNH9IIigX2pSDOPLbFzsbOrJwXbQaMiZdJumbbNO
         5qw0tUV+xYSBs/rrpdpkRXYdnrDmasG7Bn4+hSfiBVfHknsumUC/6gp1cE6KN1vjv2tX
         dTsan+uK24yKdNlZOz8p5lT8+OaNjI9CAt4oXxixnk8SNN6ixfZurTBDcGKgbuJwbC4T
         iHmiGeGJSo40U48iD0gt1dFA2aOnM5XBWAq2qLV21LmmQ/I2jwZ+VNr1ryMhBxEfhdY5
         6l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778193826; x=1778798626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w51oDYJjUofMBSFSgifaMQ9ikyNon1GnEnPJh+5y9fE=;
        b=pyNMBDUepFvVkMdvfmvdgL9RkB7yFQipj7Nfv/cU23HdYAB/1UaJir4MsSQ0AtMQGQ
         b0/I/9wqTViKfL9NRjFI6wPdMjawAYzHLcnRhrfeNLYvImvHKLRVowcqLp1bCYIx2jus
         AfdG/vTcQ2YTxEj+2+Qd17HP4GzIt6h354rcy/jX9fCA/FCL7ps/5hu2672wQydVCqIG
         +r9e6G8UmWfY73gnV1kXckuyyI/5yh6e1cHdcsZzUNAh/yPNq1JVZ7payz4BkBWFzlRc
         tEpR3Gqgt4+iXV1+Zyu+MSvNe+WjV0W48T0pXlcNrPlviHPSfsD4lLi+I5RMsuLyY/oa
         qRRA==
X-Forwarded-Encrypted: i=1; AFNElJ8MyngUWnhOU6K3+57F1CBYoG0i21zODtU0kJ67wcaVCmUoJIFbxMhmOuy1QAo5iido3cPNvos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cM4OcN4X83+yp4R0Im0hig3yeg89yGqbouJHcw1W0jNMSCzh
	bSeJnSo5jwdw4olx+JALfvCR4/ZD6f+PHXBBZIu4vVyEycao3d5GjQ2NgVcdH56fr4F/jNTmkZz
	RcZAjO+WTknk34SYgY4NWHrKAD2lNH/371UaFuSVd
X-Gm-Gg: AeBDies2WLOlE/en3s+qpW7APfXzSG4B+6LlLj/V1HpPNY4kAkSB3s0RKTwFyBg9b/V
	RBsWSFU4VYYfN5Yi+birv8V5dOCqVu6PSkaVCfPqDEY+J+w5GMgdz8oHbF8UdMQ8WPLQWhrjA9K
	2CAOMCwjsqp3LkDB2EkKjKqzfZL0URjTwENy9WE11BH/Hw8I8WL+bBTzyOsQU8O6QFWZLoPQzIH
	tPfHK8WFaN6KlqIfPV7M9Ql1zKRN6udKwnpk4GGZcEqHHPanRFLHcI9UkHRvIXP2YpzaCWqHirh
	hjuymahGSAxuCoZq87m+ShJow+ugflqpQBsNP3eaDWs7wMNMSZ6xIuqeMQkPpRFuGAc6xOVu0RG
	JYvYxOH7d93nWV/q8L8xydUE9ts+ypBE=
X-Received: by 2002:a05:7022:1e10:b0:12d:c9b6:bbba with SMTP id
 a92af1059eb24-1317d896de3mr5880072c88.8.1778193825836; Thu, 07 May 2026
 15:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507084305.2506115-1-edumazet@google.com> <20260507084305.2506115-2-edumazet@google.com>
In-Reply-To: <20260507084305.2506115-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 7 May 2026 15:43:34 -0700
X-Gm-Features: AVHnY4J82QLttE15Mzfx0Gvny9_aDiFnToGLbJgx3_HgzFYPoKpG0KcVtVuMvWk
Message-ID: <CAAVpQUCxZVzU5WOs8Ck9_OB+fjPZfSU63-ra2hvUiee25OUE_w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: constify sk_skb_reason_drop() sock parameter
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 158284EFE28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285536-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 1:43=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> sk_skb_reason_drop() does not change sock parameter, make it
> const so that we can call it from TCP stack without a cast
> on a (const) listener socket.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

