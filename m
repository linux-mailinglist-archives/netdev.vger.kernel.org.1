Return-Path: <netdev+bounces-275647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHK9OQnh02lxngcAu9opvQ
	(envelope-from <netdev+bounces-275647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:36:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBC3A5595
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CECC730087EA
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D858A38759D;
	Mon,  6 Apr 2026 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="GpUOx00f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA8E3128DF
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493381; cv=none; b=tliaot2WmxgCVfDtvSgQzi5KzMIyvaxL+KmGje05u/vc33z3dOdtKzgG1DqhIvYTlenSbWSBi2GmXc14wecr84lg82wHUVjPBamFt/KzpRv9bKwj/l/egji6FouWnAH62fcRomm9CnWdAKWbTDOnvmnZc/GBlQrp+EXdlv/Douc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493381; c=relaxed/simple;
	bh=rajS4uc0L0+t10VW0XFFtH22sRejpovKT5Dfo/1dm9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek+vCXFelni7VPCO2i7Dql0srGPbe7ovTA1hGZfi49LyJim8skhmQWhlVg33F3EYPn0uZoZDccbF1T76cmGtg8ZfsV9Al2TiIYiDsupkTDRXs6t/X6Qa5LNZd/q6kqtBsnzHw+Jad6UFSyYIPrpJKdjfhYUrNMwg6NLrTUEHylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=GpUOx00f; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1978738a91.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775493379; x=1776098179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiCiCfseGuUt36OVkBJsO+mSwQagEkjvZ4GHrhi5KdU=;
        b=GpUOx00fx1p7AGHO45fVjJK205Xl1LYFrUt8QOMEhCZAvJSQOQ0E90UqzCj3VtmOir
         gce5XjKrKNLtHqwwFU+dKNE287nf40VUmmpcWHBYodh1vL4l55oeK8HSgIWuKTpNdErI
         5C0+972tiUybAP308J1Yv3E4P6JSSg+qcYadz+aiks7tKMswnhG9doF9JhVI2dA+RVmK
         Ll5RTqFEfZOITkm7disUBxoK/5O9C8DqDiBPYKG+XEUiONEreXsJf5rbRHRw3dp2GhCk
         H+vdvvaxFHauFG3safGc0cV+ctXVuml6+9a6hawBdTQ5YehTMqWZlHX9+tJ0XdS40Frn
         b8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775493379; x=1776098179;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiCiCfseGuUt36OVkBJsO+mSwQagEkjvZ4GHrhi5KdU=;
        b=KuUDUxjezHixHm0RMXA/DLPbtaOZU+jMgFRKBoW8nCbyEgXnyz1MeVMqq7klkLlYdY
         B1rsQ2qtpzC+imUU95fSuBsjkkcxDW5VTCPuw5JgOV5wYTatef6BtRcVOso/97wWDUGz
         xD6bIo1AWEX3a8jiZ86uvnyytDBLpSyDbi8OU5pVA+rLbHmCrbqZEoA8qgTT23XOgxdU
         5uZgtnm11OijK6x42qk8mOxdR9Zp0CLdHE2i/i2NdGzuO74qTGQvH1ryGNFGzC9Fz6uf
         A2m+130HgJZaRxcYxYDYeTDpxYYBH1HIp6YxbFlG3Twb5wQit2sOay23FnENw/V5udJ/
         cddQ==
X-Gm-Message-State: AOJu0YxeyhDwRgizy6I0qo5hG2F8Ss3IkFfIq/Gyqt0DJvcAuSS2mkSc
	smlf/YxXaFs2Xww8rCQrH5aDQ9OcmafAB5DXkhUoizI/lpr3cWb6epofzAQRQou3Aco=
X-Gm-Gg: AeBDievPbnrK9WdFGxTKsskzBMH3uJpObR0SE5nfsKGlP8DdtlChIAPPUkIJFodms/I
	nXYHFdSTHqlPw54C79x2n5TOQjLM8Tn3SuZkGQgszV8LhBAzDnFRUOw4vrw2xvfHTHiZi/36AfM
	DqaVCls+XHjdNgWz/wp8PkxY5NtcLRRHzFEcA/Ih7EweZ7QzU+hWHvjzxgKuuYAGqZiESxmQNWi
	cw4eM2oTXmJJ5SkXxJ6pQRvn8J7eFn/el0IwGL5JK/5EuIZW6YGdLzR/mVH/gJ/3Wzj2SvG8QU0
	HJiA3XTWIAZ2moJPEg3BrYMlGkt0yn+JzcDXcO/2xlrB2ZZSafFWO9LuaxxDTWGOeBhhuLQA4Vz
	01rwQOg1BukhnYj+yGI1upAhsinU6CNFz3FdW6CU5t4TdYzmSZzsPai1kePFDWuHTsKddB3ESf4
	+wPu6l
X-Received: by 2002:a17:90b:1d08:b0:35d:a84d:e27e with SMTP id 98e67ed59e1d1-35de681380dmr12576218a91.6.1775493379463;
        Mon, 06 Apr 2026 09:36:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de6a5e62dsm3935913a91.13.2026.04.06.09.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:36:19 -0700 (PDT)
Date: Mon, 6 Apr 2026 09:36:18 -0700
From: Joe Damato <joe@dama.to>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [net-next v2 3/3] selftests/net: Test PACKET_AUXDATA
Message-ID: <adPhAj5gZKzHTtyE@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	willemb@google.com, linux-kselftest@vger.kernel.org
References: <20260403233240.178948-1-joe@dama.to>
 <20260403233240.178948-4-joe@dama.to>
 <willemdebruijn.kernel.3ad8f36da2a1f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.3ad8f36da2a1f@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-275647-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 91CBC3A5595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 11:10:13AM -0400, Willem de Bruijn wrote:
> Joe Damato wrote:
> > Extend the packet socket selftest, adding a recvmsg path, to test
> > PACKET_AUXDATA. Check basic attributes of tpacket_auxdata.
> > 
> > Signed-off-by: Joe Damato <joe@dama.to>
> 
> > @@ -322,8 +376,11 @@ static void parse_opts(int argc, char **argv)
> >  {
> >  	int c;
> >  
> > -	while ((c = getopt(argc, argv, "bcCdDgl:qt:vV")) != -1) {
> > +	while ((c = getopt(argc, argv, "abcCdDgl:qt:vV")) != -1) {
> >  		switch (c) {
> > +		case 'a':
> > +			cfg_aux_data = true;
> > +			break;
> 
> These are intended as independent test cases: test_auxdata,
> test_drops. By using flags the flags can be combined. Are all
> combinations of flags expected to work? Else maybe we should instead
> have a -T "test_name", or so, to keep them mutually exclusive and
> easy to reason about.
> 
> Or just a test that two flags are not set at the same time.

Sure, I can add a two line at the bottom with the existing flags checks. I
don't think adding a -T "test_name" is worth the effort, though.

