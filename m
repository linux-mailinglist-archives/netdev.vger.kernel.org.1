Return-Path: <netdev+bounces-97641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87038CC7E6
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B20E282321
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6497CF30;
	Wed, 22 May 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KzsXp7iv"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A641CAA6
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411762; cv=none; b=NIRHjQj3gdcoeQvRJPmVGAGWa1rbZRqC3yDb/tIoN1MHDeY7kqA/gNbjaMaVlup4lePfxuB2pvQ8v6E6GdV1wmAOWD6Qynio0Uy7tLELPfuZmErWXIjrGFLeEH5vK/n56TVYzymVmgJmtv8/SAWJlg/SxmwTSxQmGs/kXyUQE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411762; c=relaxed/simple;
	bh=8gbtapOUc9511zHLH5O8zRh/jj8rlEQ0JX4TflBXexI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=P+jrWKNB6o3OcqhOIkDs3rJmqY/NPwdspJwTunC/m/jnZTczjwJ7UJZ5bU5Nsw7eH+0Nw2OGGGMRxnp2I1uYVVb+hZyuS+nGi99zs/fRD6Q9OLvuM0Jpx29goY8PcGCkf1YO6P+nAR8Z4PQAjUoc8t4cIw793d7dhHLaYlYCVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KzsXp7iv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716411758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12CHrVGAfMcHmr01WjYqpMQ+xVbWCvpMCxJ5RpVX3ZQ=;
	b=KzsXp7ivGSYfYXnuIByiGQ33AZJZ48LxRHLD08up6c+pnlruOQ/NDJT9M1hg/ucpqZfPbj
	AwFv3RokD/SbhG6DjUePzz0yg70Jwfn4H3D7RTMSVpz/PkfAkvSLRqlH82o+yTIwE9fbwb
	O6X0b2v0bVu1LNkWVPTC0zmM7Q5kS8TqJBNcx7ZXykm40uEafqjfK2C3tKF5hMhvWLV/R0
	nUVfNj33t/FYXkh8cp76T1yRqhO96UAzYZfnTI1VOHcQmeZJcHRrVwcCAD+6nMYuIVExbv
	bc2FMgXc8Nb4tr1HddmDuda+O5z3pSNnh7v/Zhuy4nrtgtiJ9OmM0zFz9I/JEg==
Date: Wed, 22 May 2024 23:02:37 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] [resend] color: default to dark background
In-Reply-To: <67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
 <20240522135721.7da9b30c@hermes.local>
 <67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
Message-ID: <2866a9935b3fa3eafe51625b5bdfaa30@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-22 23:01, Gedalya wrote:
> On 5/23/24 4:57 AM, Stephen Hemminger wrote:
>> Why? What other utilities do the same thin?
> 
> I'm truly sorry, I don't understand the question

Basically, you need to provide the patch description.

