Return-Path: <netdev+bounces-259575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG3KAxJjl2mnxgIAu9opvQ
	(envelope-from <netdev+bounces-259575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:22:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D05C161EC9
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561CF302496E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30D2FFFA3;
	Thu, 19 Feb 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="NPePABpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB72FE582
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771528947; cv=none; b=roeg0gxg7M4jprPMkOAwZ/nhjA0fLKkUfmGtKrDw+RXK8/Jv8LkpAQv8zWuQHLzyeWaxsyEA/p+k8NMyiMhAUhrOMwsf7B4y+7gxyC4ezlER6H/IzajLBDVaO0NHDjGdVbpUmOoqmt1bzonzkNaJHk0o+tHz8CP6ANWmtM1gnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771528947; c=relaxed/simple;
	bh=zTbHbRlmv3uMqkzamQCDYhHdJCe6F7LjuxqgGFIwYmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Znn/p7gJy46II+a+1N9xjzfr5xvEQpnxQHKQR/Gq3/ca/5tbU3G1scZq/BccX9vui/wY7DH0NYw94qu+Y8s9i48hB8s7n/x8goe0uZwR037oCu/XH0+e1YviCWf3BW1+mYcOm+SO4zkgFKuSJ3MhLKUcBK31TGJpxIYZEIoeCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=NPePABpD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506362ac5f7so11441341cf.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 11:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771528945; x=1772133745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmvs7ltNBb7/j6fAJ8uopBy+GNGTr1X/rFmvGsUIIOQ=;
        b=NPePABpDkcOrMIC65iE/wbIrxiLQ8xgPHPpMg1yuTMxINow6Z7gqwd95wwvwmyW4fu
         TIqn6veXKrNa08gzVFdxJjvxqy7Iiio7P5hB1RiAyxJltY+PFlz6wFf9spYK9vK1dR6m
         ew2ORhvWJ/OLgkrRwcVnjRdLPahoX9EELpiFWpkvLd/gegCVf6HYvUCizjNx3cX5LF3q
         FrQYFJWkfpMfw0GS9WZRitVA49GMEHbBdTcOeT+0/6ITPIVXzJckEjvMbMrU2GrGgYSN
         ty5CcVSCpZzsZyZZ+mGq/c4RU9qJRThkFi4jfXwLF5f8LCBqDur7s5mOQQuTjO3glJVb
         Tjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771528945; x=1772133745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qmvs7ltNBb7/j6fAJ8uopBy+GNGTr1X/rFmvGsUIIOQ=;
        b=BvT+m52V/hUdI9khba9aRKzs//OryruEcruiTlgpVfIW382q8qmu9RHCtZT5xwADP6
         +PBQx0l20XMEF4jWWGL3XPqje/un9zNeIYCQEqR2PP6iMdcT0WrapFmpVPYEPHHsuVRw
         HOpxqbdNGRpGJv2Qf5RqLLUrZoqcDiRolXMRYc5zjSyALj7g/VIsBsY97PkOxfsIHLqY
         e2pheJk19lKQL0rGQhgv94rcQ6XcZDKffFpUxBXM7rSHCrtdxVoLBakGlucQhf/cqSA+
         FROpPJEBJgmlCZ9mbQ0kugIuTYrrkoh/JLDBRSU8GO5vj4fWX0/MWLJgozzGeFM51sDu
         5TIA==
X-Forwarded-Encrypted: i=1; AJvYcCWK58M5mE8WZLjtFtdTjF0h8O3meqhPUL3QqubSAVu7fpX2tfBW3rSFBSCYagzv1Y1PzzzO0m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysbOxHAsIVpt7obH3fb/OBVEmIZrJEJVTBL15CJvGNBczrlj7n
	VmUDNTuV8pA24nJuu00u3coJDFQ1vuSwirHato8NQHPZvucXT49fVhMovOUZe6Feus0=
X-Gm-Gg: AZuq6aJ0CPSJwXrAhbnSlcZJr1aDMmiP2aVs0AQFBOdirbA0xP0NSxxREbPiSQ3Exsy
	aobBS3AKCiCBXEg6mT61RTgugDL1zPFtNZNEcebptpDTF/IOUPyOGjYX41fOrVnZOt+aHRzQX1x
	A0+rAtfS0/+Xl+wJXM/ZK/zoq5NJO2RNXg3LxH3MkMWYS4oP28UybEKx8K9KPv59oH6eW7QGA53
	yPFduUBFHk2ba/KJsqNr0WnPQO+RVDpKnkBlY8H1v6TAFdQTePx5dS7wc320HR9c64cbF5va5ij
	pwSmWLm4mMwq9afT9IKuuqqnRsw8uEmi0C/h6+3b0Jb6UwskdnEaPaLWGkaidPJ4QBCZSBfVyic
	gCv2qgCbQhXLm/9Y8hmT8m2zr04ZOZytMZRZApS83xHx8tmhb3Ss3wimXtOyFq62DeKgEXZpl/X
	gbbUbtAavnKeUHHOl4KmqtUHPLNCd5wDVqVzldk3kiidIvoIiSxI9M7gbvLX2myoJi
X-Received: by 2002:a05:622a:19a0:b0:502:9f6b:a3b3 with SMTP id d75a77b69052e-506b3fc9f96mr263994961cf.37.1771528944668;
        Thu, 19 Feb 2026 11:22:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8a5ccsm223003766d6.25.2026.02.19.11.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:22:24 -0800 (PST)
Date: Thu, 19 Feb 2026 11:22:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2 1/2] mptcp: monitor: also show iface name
Message-ID: <20260219112220.6576b50d@phoenix.local>
In-Reply-To: <1f81c7c3-59ee-43ee-93f9-771015a2752c@kernel.org>
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
	<20260211-mptcp-color-v1-1-01832777611d@kernel.org>
	<20260218103155.486d20ee@phoenix.local>
	<a44c1f27-e9f0-4f33-beda-e5f611197e35@kernel.org>
	<20260219091101.551377a9@phoenix.local>
	<1f81c7c3-59ee-43ee-93f9-771015a2752c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-259575-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phoenix.local:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4D05C161EC9
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 18:38:51 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> >>> Please fix the whole function.    
> >>
> >> Doing that would likely break scripts parsing 'ip mptcp monitor' output,
> >> are you sure we should still change this output format?  
> > 
> > I doubt scripts are parsing this weird format. That is one more reason for JSON  
> 
> Not as weird as 'ss -i' format where there are even more scripts parsing
> that :)

Agreed ss is a RFM.
I did take a shot at doing JSON there (with some help from Claude), just haven't gotten back to it.

