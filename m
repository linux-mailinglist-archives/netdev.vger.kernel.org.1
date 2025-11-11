Return-Path: <netdev+bounces-237722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F222FC4F8B0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 20:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD0AD4E92CE
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 19:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7612E6CB8;
	Tue, 11 Nov 2025 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=zaharido@web.de header.b="Qybr6SiP"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8EB2E6CC2
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888261; cv=none; b=I1TnJ298SHVI0V4bmbsjw5skIzGUHO1cvFpDY4T1s80EL2GWhRgeLEihuH0HlQsXh4tDqpA9jdruIntOnAnCixs+iH5PP/xp6G4Yot+wV9xVeNQdU9fEGmLN21RR7HY9uokuvM7bcQlc4wlMuS439hpxx90pPimh1RQCXTpgyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888261; c=relaxed/simple;
	bh=mlJmxguQhAwWmmsR1O1PoDxKA30/u+majqvzYWcVMQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxG+IAtuXnMrW6JFkYmk+JKUnR6qMBeUNeEAf8aYkf8+rqm4NzxgtI7/KBIzVEre01fGgdxonropRaSUc6ZigTa/2ZAhfUI2TSVkVctpLFfWOTAdh8A2Rwo9ehtF2dKnps9ZpkLs+rPT2xGPQyMqTpzhHlC8irgZ/ld81Emls5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=zaharido@web.de header.b=Qybr6SiP; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762888219; x=1763493019; i=zaharido@web.de;
	bh=82/MLSWmS+koYQk9BRRzvj9nMbpx3oGz7GCf8LmGtyI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qybr6SiPBwSN8tuAL1cTiOcg/snZ/Og3bN+jgCFIHakla+oJz7EJAK6Od6YIX0ZK
	 EblXJjxio842rPYF1reU8e9LI9o1KvxcrqRWcoSJSLuTUO+p3wQT2LVZqEaQmTsLK
	 MM8WzwZGcDH8pBwFQFrfGEadYJXS2xmxY5VifZ00vU5j1uvNavuJO6bmqOTLq5wjK
	 KshIrbDFHQpNU7cWcTFuvVKuXtfMSAQZif/hcWs/JcKPTr5trP+4gHGW2C7fqBtWk
	 EJYqFebThtOl++OWGqgaUDMMg9SvVHOyRSyZKplz1ikwUtBReJESYQW3Z0TBDYkaw
	 HIi3CurkFpEAazYUgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from hp-kozhuh ([79.100.14.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0qqv-1w64h418Nh-00uydQ; Tue, 11
 Nov 2025 20:10:19 +0100
Date: Tue, 11 Nov 2025 21:09:11 +0200
From: Zahari Doychev <zaharido@web.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zahari Doychev <zahari.doychev@linux.com>, donald.hunter@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	jacob.e.keller@intel.com, ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH v2 1/3] ynl: samples: add tc filter example
Message-ID: <cgsea6u5h26klyzcqcbbhhfs2a5zee54b2ixedbrlh6utjgsbn@wnrqu3pnapu5>
References: <20251106151529.453026-1-zahari.doychev@linux.com>
 <20251106151529.453026-2-zahari.doychev@linux.com>
 <20251110171739.6c6cf31d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110171739.6c6cf31d@kernel.org>
X-Provags-ID: V03:K1:bcuY2LE0emfao82xbUuq3NkU7keahnsV/BbsfNX4oLFLErfwhOJ
 weIFfxmJkbKLbgy4PENVIzVD53P9wpfTgb2vJB5bSx+7lbnIwpXAzEVcnVhG/6NQ5oKrdl0
 dkuPd5f5Wf2WHEW4nxjhowOlhiXMEwsmx94FQbrz1h+bNfilupNW1/13KERSGZeJTYksQW6
 a/XqMq1aZpIwxl+ia8Ovw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8zy3n7DfFVE=;e1/xF+gtq8A3TvtvwVdTiC/0f1U
 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
 XScmRgu4VwbmczGIZIHkKP5qtKDJtA+mTMo=
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 05:17:39PM -0800, Jakub Kicinski wrote:
> On Thu,  6 Nov 2025 16:15:27 +0100 Zahari Doychev wrote:
> > diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> > index 865fd2e8519e..96c390af060e 100644
> > --- a/tools/net/ynl/Makefile.deps
> > +++ b/tools/net/ynl/Makefile.deps
> > @@ -47,4 +47,5 @@ CFLAGS_tc:=3D $(call get_hdr_inc,__LINUX_RTNETLINK_H=
,rtnetlink.h) \
> >  	$(call get_hdr_inc,_TC_MIRRED_H,tc_act/tc_mirred.h) \
> >  	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
> >  	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
> > +CFLAGS_tc-filter-add:=3D$(CFLAGS_tc)
>=20
> Why do we need this? This file is intended for families themselves,
> if sample needs flags it should be specified in samples/Makefile ?

I am getting compile errors as without the CFLAGS my system
headers files are used and not the ones in the kernel tree.
As samples/Makfile is passing the CFLAGS_tc-filter-add when
compiling I thought this was the way to do this similiar to the
other examples.

Actually the following flags are fixing my problem:
 -D__LINUX_PKT_SCHED_H -include ../../../../include/uapi//linux/pkt_sched.=
h
 -D__LINUX_PKT_CLS_H -include ../../../../include/uapi//linux/pkt_cls.h

If I need to fix this in samples/Makefile then I probably need to create
a new target. Is this really the expectation?

>=20
> >  CFLAGS_tcp_metrics:=3D$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_met=
rics.h)
>=20

