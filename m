Return-Path: <netdev+bounces-275420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBCVADyn0WnDMAcAu9opvQ
	(envelope-from <netdev+bounces-275420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 02:05:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89439CE7F
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 02:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9ABB3003D2F
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95DF125A0;
	Sun,  5 Apr 2026 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="s28tVyTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098FDF59
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775347511; cv=pass; b=eAT8Xw8Rywb+z/IqSUT2Y3bgyqtbUDUFAss4IEhFlTSYMqQ+0PmpMApjvDcdse3+oBG6kdt2/Qw9iVpK1PftrEup4hafB9+uOd5nPKapcQvcU2473XgIfUZzOTEXAW3d6x+WC21dbmuV+1pKFIokx4Ck13OiWwtHgGPSwzeD6xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775347511; c=relaxed/simple;
	bh=R23rsYH+zgP21jS79cqvnw2fqeQu7QiruRCG+NqhnIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDF8ln34qY3DYHVMiWMlAzAxVTZ705XMJNbszMTnuuGjmz8N33fgOB/O1nTr9gE0LIh6+uno8mPt4zgVpevziqV73a1xG1YHxSb5JIe9NRhSly1fl6snRWi9WyJbBifJ598BKwlgZ5vavXIlnsnK5R3sDQ1lvewnR7zO639iZSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=s28tVyTJ; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2503753efso24020525ad.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 17:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775347510; cv=none;
        d=google.com; s=arc-20240605;
        b=WLmYdfSc83+UWejFHAnt3cWKrgOu7eM06o7s9imRJ1vx/og1XzzYGOPCL+bVC6BJu9
         p+cWBv2GmJPLZpmmMTHDh2Wo8TBTSMPWjgS4vD0YzNInmE/2o5jzqnBeYVXY3vFp6LAK
         DWNQQaO/aJhQottqfXqCj6JBy8RCO4bXzwy0dKlRAUWC750tCv2bAomw0xoN1M8cPoQS
         WItqSBfIXKrnecppypDuAKauLSthSuXx/SvS3AsDDN37vKRD4woBaAtgxleglWC0CItl
         cVeX4SHSJxr1DqbxnDDqrNxccUkYVr0bu7bSpRk3pJgfF+3OPKU+oPEeF0nCtWcm2Rod
         ynCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uBdFnIwU/qogTBcIt+veH+3ao5W7MrcqdsJxPS4CqGw=;
        fh=mc4xYpygOlnhFXWByWqe9LiqP9VDCa/v5Ox9bxhcwLM=;
        b=EO3CpjKBk6eQCje21VP69XPSypUh5LknjX6nWLBqNkCUddZTEncvYdKvi7zQOguKMo
         V2K1CIn5PjRXa0KyGZwrLnuHvJs7Vc6IDegbxEjYygWi+FGSkrxI7ZXfl6nuvPY5lRW2
         eO2q++C64DkKPbXScUem6mKQq4m7+sLqYXEvhWOPZPGJ9rplAm/c1vKW5B3mjaDcEZRz
         C160HzEXuPZBHWuRXf/VYft+TP67kTObQsiE3jJuLtWozqfMDjQVAAw22lEC6vs67Mlx
         TfchxT/iGQ+Weg/ACyXMcYbaCtYHo5Ah8iBrnRcaZIMMmO/PVe5N+f3SrmJjSkTyLH6t
         ItpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775347510; x=1775952310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBdFnIwU/qogTBcIt+veH+3ao5W7MrcqdsJxPS4CqGw=;
        b=s28tVyTJce9e88IeGAQneU2Oe9txmbZjY6CK7BXjVzh3yAWdrmxzwxzEidLo+/bjNB
         rA9fQ3sD1Ojmz9YzpbvzRc0+JUMATKINogyCLgCDI8CXtluvX/mrVDVbJubA72iTYy3j
         JqUKuwfZeGZsnRvpLD/VpLMPr7jaFRo8gTQSq7FSmg3S0WDwtefpAQ/q55PHBkA4SnlT
         6S0ACU8mzusAJAKDGU1UcKPvp4W5HqCI9OToiScCynLbpItYRjabOVj+IdI5d4gJ1Liz
         GRvJUjvlh8DuJ12Hdyotlo3//TwJd7YCxYEYAIN4pa9fLETdiOha8I9t8NBi1581xgaA
         z4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775347510; x=1775952310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uBdFnIwU/qogTBcIt+veH+3ao5W7MrcqdsJxPS4CqGw=;
        b=OW6MXNZbqGH4Rt6tKb5mSAC1XbnrUnVZFYiQ4Olm3JZjzFbR3yfK/bOE6c42uIRmGb
         2Vn8GRYmurOFUgw3xPEHmxinWzQbNB7PSOB/X0ImIX1yJ+HOriMwsI5gXupjVn8gdIKs
         DrDkSnO/WrXwwIeaEOGIyOcBu8rjrm3jwIoFJDv6ozb1aCkTTrrXU9fquWDQbYLBKxMD
         B/G2k6hI+9ydLFB0MsXYVAYysjHkxzkNVTLI7zAGM3IilgRmsq/bEbeTMLdgsR5wYVhH
         jBDK0yl80sRnh8u4zU4oC5Mlj+Pp7ZtpTetkCVRrIfiZri9yU0eA7wgWGayPAE6TBsxi
         0bbQ==
X-Gm-Message-State: AOJu0Yyg/xDxQXH+E+HlF0pwHovtH5dmERbW+OzkqeJqJXLCvzXJ12Vw
	X2qT34p0A3phQctYSVASTmKqf0qBc+jL0FkjuvSVXXm0+rLRtl76hcijIvHwl+Q7A2XPQl6a5Xk
	jItj20ylDp8rgbBMKn9n6+AOReht0rxuUu6ux3y/3
X-Gm-Gg: AeBDievCCFI8AFsS+7Tw9xpR2LaAcXp0ebor5r0WUlrjmY2BkonmQcbmqx7pbcur7LP
	cK89uhyoKnTtZDpHwOb17Eu+rywCB04Cq72Yqqb3ET62glbP0sRzbgKtfb+9kZUoUxceOYBbWeb
	GK3cJTjCU0UFpo1OnunQc8MEYiV/K5aiq30413uqfAVhZZdkB5Ee4QvPtfWZW0dwX2nJZk8ChsJ
	7RoVuambE9fJhzKMpXJRDgzt5+H2qwuNgLMs1JOAZnR2GH3E6Y/yBhd37JF3D0X8O3x9/XnanAE
	Wmz+qari
X-Received: by 2002:a17:902:f54d:b0:2b2:4e1a:aff9 with SMTP id
 d9443c01a7336-2b281997e1fmr78997865ad.44.1775347509777; Sat, 04 Apr 2026
 17:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031957.3299500-1-xmei5@asu.edu> <20260327112056.GC567789@horms.kernel.org>
In-Reply-To: <20260327112056.GC567789@horms.kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 4 Apr 2026 17:04:59 -0700
X-Gm-Features: AQROBzDVrru311INQMcAH2NeVIDVm62F2BspdoCZ1Sm8hSx6TOuC6jLJ0FBtOPA
Message-ID: <CAPpSM+TV89o-aj7SVsAWPcVVSSte5SENe8f4tGe+Y23CHza+iA@mail.gmail.com>
Subject: Re: [PATCH net] bridge: cfm: do not reschedule TX work when interval
 is zero
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org, 
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-275420-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C89439CE7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 4:21=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Mar 25, 2026 at 08:19:57PM -0700, Xiang Mei wrote:
> > ccm_tx_work_expired() uses interval_to_us() to convert the configured
> > exp_interval enum into a microsecond delay, then passes it to
> > queue_delayed_work() to schedule the next iteration. The ccm_tx_dwork
> > callback re-arms the same delayed_work struct at the end of each
> > invocation, forming a repeating timer.
> >
> > interval_to_us() returns 0 for BR_CFM_CCM_INTERVAL_NONE and any
> > out-of-range enum value. When this 0 is passed to queue_delayed_work()
> > as the delay, the work item fires immediately and re-arms itself with
> > zero delay again, creating an infinite tight loop. Each iteration
> > allocates an skb via ccm_frame_build() and queues it for transmission.
> > The skbs pile up faster than the network stack can free them because th=
e
> > worker never yields the CPU, rapidly exhausting all kernel memory until
> > OOM deadlock panic.
> >
> > Since CC config and CCM TX are independent netlink commands that can be
> > issued in any order, there is no single configuration entry point where
> > rejecting interval=3D0 would cover all cases.
> >
> > Fix this by checking the interval at the start of ccm_tx_work_expired()
> > and stopping transmission immediately if it is zero. Set period to 0 so
> > that br_cfm_cc_ccm_tx() correctly sees transmission as stopped and can
> > restart it later if a valid interval is configured. This also avoids
> > transmitting a CCM frame with an invalid interval value.
>
> Hi,
>
> I think that the principle should be that code that doesn't need
> to be in the datapath shouldn't be in the datapath.
>
> So, with that in mind, I think it would be better to set a lower bound on
> exp_interval when the mep is:
>
> a) Created. It looks like that happens in br_cfm_mep_create
> b) Configured. It looks like that can be done by setting a policy on the
>    minimum value of IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL
>
Thanks for the suggestion. You are right, it's better to move the
check out of the datapath. V2 has been sent, which blocks the invalid
interval in creation/configuration.
> >
> > Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. =
CCM frame TX added.")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> ...

