Return-Path: <netdev+bounces-113113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA093CAB7
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4712827B8
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73021448D2;
	Thu, 25 Jul 2024 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR1CpaZU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC313D530;
	Thu, 25 Jul 2024 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721945629; cv=none; b=TRewFMFlFdmfMOu8/EIqJ76VFZtFmCVj+fAJlGD2bQkPbvINoNYbtUyCjpZH+IWpAweIls87bp7kMslU2AGN/CG5cSk0SZJ2h9vYebgW/zmllo3LKWCfICPsCuj52H+u0NXWiGE6h3NL2zxVsXyjqmmmuWdwEttWepFGAJ8LyXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721945629; c=relaxed/simple;
	bh=PeSLxojMgwVbLwzEmBygGPHc2dl4cpwh21ffeFFpois=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6zoCQvoqxebcePBlVwZGzu4nGqEr+aUAIV1VNmGr4heqyaEtzqlKJKcbKSgfaCF6xhEF+PhN/Rsyty8Ac5FC/aq1NLoDULocz/hTImnrExNDfWdJZlcrcgy0/mPDFn4QudVXJNl4t4EvFOsKBPHJZXyDI4MXO3DAmMzrrq+ep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR1CpaZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF8C116B1;
	Thu, 25 Jul 2024 22:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721945629;
	bh=PeSLxojMgwVbLwzEmBygGPHc2dl4cpwh21ffeFFpois=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nR1CpaZUbMChnmoC55sTUhA6W0Pbrcc7hoAjx/tKvZdGpelBaPTNYwtTnDTHA2foq
	 5eg7Uoq+aEmgn0dJbwRSAxToqRUHhTL2zEOdim/QtBR7WW1GyHfg/JGyBivqlE/ogk
	 61da5bi3bcO8IWbc0MB8nLyllV4POXIc5x1cD2QaC8H7FrrfcsB6xtQaVnecioX5YB
	 puaU/x+/UhGDA8HrkK65+o6lQMYQAgUeiEz/7nWn+M0h0jf/87MYlajdI+svN0CfCU
	 W82L/VS+bmwj+P3isu29UeKTXM5wPDvFBw7R9I/3+aH1SQ3z+2N6uCrg/jAWWLAP3L
	 jsnNT/Q1ds2wg==
Date: Thu, 25 Jul 2024 15:13:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Filter out _GNU_SOURCE when
 compiling test_cpp
Message-ID: <20240725151347.180e24ae@kernel.org>
In-Reply-To: <20240725214029.1760809-1-sdf@fomichev.me>
References: <20240725214029.1760809-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 14:40:29 -0700 Stanislav Fomichev wrote:
> Not sure which tree it should go via, targeting bpf for now, but net
> might be better?

Thanks! I can add this patch to our "local hacks" queue to avoid
netdev-triggred BPF CI runs failing, but if it's okay for us 
to apply directly that'd be cleaner.

FWIW the netdev trees have been forwarded now.

