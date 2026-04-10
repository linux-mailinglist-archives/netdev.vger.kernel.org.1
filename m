Return-Path: <netdev+bounces-277563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGNRIfdY2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:09:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB4F3DC604
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DC4E3010B6B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DEA3815F3;
	Fri, 10 Apr 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXjXO0BZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C34364939
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851763; cv=none; b=anbYwiN87C5QUD3RqDLBfcBNfnhTLodrkLqT5cuNUgt0wpj6YkZkMf82FVgW6+tBm3cp7UOqNDvJYzrHFZ62x8UNlaip4MWeYocXI6JoKu7T0WdyiRqVhgGBAG5Jh7y96EYOQrRp1u2CouwkU3P71fLfR8CYTgyaueIwyj7gO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851763; c=relaxed/simple;
	bh=LVlD3b86qwl5g+iHGUhpeJOn62fosWY6EVaPLpo+zxg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4z1/3HBU2dE2Ip1XQZENtXOsoqFOqmYh6UvlHdxdorxboBAdUiY2eItx3dC0rZyatKj6EKc5sJqKTW5zprb+BnTHE8WQ/WWlkw16PeY0xR/pVDO7jOu/2Ft6oLrR//bl+xvPFAScmLo7YKp5gWeJcalwPhvCNLk3jvZWrskRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXjXO0BZ; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7dbec19732eso2260410a34.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775851761; x=1776456561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjBRPmZGDZpbbomlvvL1dRHGhoOJrbVGYWkJHZ809SM=;
        b=IXjXO0BZb9rkQfGZlKzNWJAdMbJHoy3fL6ZquTvdyTK+SPhVDfJ5lIZWNM+sqF5Gjg
         6Azj0TrpjW21IZQPSx79tuCImuw5qPTImlfiQ00OvO3Fa4RbaD8T95cYBpSCxtCTnMmU
         MIY4WvUBgx4lsqXiWQtq9Q5GELZlDF6OZ0cZIT2TSdd0PoprQrNxK92cDPcIbDxk8+SA
         gjDQMP3EYTt+51AsjM+e1WgNO5JYkdmVhuw/Oj+znI0yHkxv/d5t6EGxYjrETQVDXVgE
         jvcWtZ3QI6M9OyrYM3jKzRtpQOIU1VXUkCH3SI+W6gyZxuPKu+MJ8Hew+IibsnGAQow2
         /KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775851761; x=1776456561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjBRPmZGDZpbbomlvvL1dRHGhoOJrbVGYWkJHZ809SM=;
        b=awtqVSMNlFvUhPF2ef5ooC0IQqjm3SpIDKmkHzKf0333WqR9Unl1BQK4PU4ry7NWhP
         GaHRMT0x8UMuxCHUhh1kfJ4tyEjekYTuaqLLP4ePxoctxzeGKOiIeMHLvKJ1oh5kWq/i
         yPRxtCHYKu374j8kMRdiOrueV/R3xjqJ00ShpLe0K7nmRKSZoG1tV31dJl0A7XJsWxd4
         268vnnhBWGWHAcx6cLZamV9vgvJsezO/9WHsx/RqfbYT4iMmIkpfq34Fr3o92CZa3FGV
         9Rsf2jIE5t2Xpa0WXfrUv/iFtPWTeEzN1lX+TjZ08vivKUNSbQbCWIa4FF2eHbPdARqf
         0a9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWayJhyFi/VfGoxZhJt2cyKucZ3czPBIbvhmR1tR+GV6p6bMbBMPG+USg665spQKJ9G0RhBti8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaCEZtpSzPoaHI81DpZX9GEXWpXj3z6FhX7gzb1xGKvtmro3d
	BpkBkwZyE9WOaKJPhpwctS3QLuhLoaPHao/Kr5zT+d/2ylVjF1pNxLq/
X-Gm-Gg: AeBDieuKpJ1x6IEtZ3T8fAbgtI0cNCC70blSdTolSlnx52YuLq1UUT1gbCDsq0x692m
	EeAxdoPz9CkSX1P2TlE91mtxL3kIJ5d/z92ZSyniLbZerfDkM442ZlPWqc4SvLUcARz4saLPbKO
	/03czYnhZrLOUCR1f6dg/8mcYrP7ZgIZrdfVhK/baHLFbLNyDUNNapq8l+mRBCTj6CPgIxKiX7S
	Bwhh4YJVmUZaxPI64COVz8nxhpu9K0rqlY07hQWSJjmoZP+TDPSZplXxk/4evLCBotU8/P1DOXx
	Fm7ebD9V6OJ6YxZwK2ozXT+lIkTXMqVpeCNUai75HvTNFYctnBmevDDFKr2ZwtQhFjVUD7QFiuQ
	/0TNRsFWs++f9TtuDT5rNnLEyuFbDyB/HtlSDONMK+viS4EoJabp8WynNuLlnHrXVUltb8AqKot
	Vm9YSsnRAiPMAoNd+i
X-Received: by 2002:a05:6830:67f4:b0:7d7:d2e4:630a with SMTP id 46e09a7af769-7dc27ecd2cfmr2955547a34.14.1775851761231;
        Fri, 10 Apr 2026 13:09:21 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26914667sm2660844a34.13.2026.04.10.13.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:09:20 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Fri, 10 Apr 2026 13:09:19 -0700
To: Breno Leitao <leitao@debian.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v6 13/14] selftests: net: add
 team_bridge_macvlan rx_mode test
Message-ID: <adlY3Pplpr-wFvTu@devvm17672.vll0.facebook.com>
References: <20260407153101.3694714-1-sdf@fomichev.me>
 <20260407153101.3694714-14-sdf@fomichev.me>
 <adkmmM6cCKWqogIx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adkmmM6cCKWqogIx@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-277563-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AB4F3DC604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/10, Breno Leitao wrote:
> On Tue, Apr 07, 2026 at 08:31:00AM -0700, Stanislav Fomichev wrote:
> > Add a test that exercises the ndo_change_rx_flags path through a
> > macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
> > under addr_list_lock which flips promiscuity on the lower device.
> > With the new work queue approach, this must not deadlock.
> > 
> > Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>
> >
> > ---
> >  tools/testing/selftests/net/config       |  3 ++
> >  tools/testing/selftests/net/rtnetlink.sh | 44 ++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> > index 2a390cae41bf..38611ea11c6b 100644
> > --- a/tools/testing/selftests/net/config
> > +++ b/tools/testing/selftests/net/config
> > @@ -101,6 +101,9 @@ CONFIG_NET_SCH_HTB=m
> >  CONFIG_NET_SCH_INGRESS=m
> >  CONFIG_NET_SCH_NETEM=y
> >  CONFIG_NET_SCH_PRIO=m
> > +CONFIG_NET_TEAM=y
> > +CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
> > +CONFIG_NET_TEAM_MODE_LOADBALANCE=y
> 
> Why do you need LOADBALANCE enabled for the test?

Not sure, I copy-pasted from team/config :-[ let me double check if it's
really needed.

