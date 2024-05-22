Return-Path: <netdev+bounces-97623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DEA8CC727
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC821C20D95
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6657D146D4D;
	Wed, 22 May 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lyl68rL4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A8146D4A
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406057; cv=none; b=nF3pfTKrAQaz0ZQTj2ZrimJS0veQFEcuK1J4KxPVRTDFdSiAoyoliqAJnzBh7+ZFeIGueyEzopebFfwXf8ibGYMHr5fdBJTrGG61ha3JVgrgKtBeHGPfoVcxswKfYFscPXTDiH0U6eODr8KZBPhg47uEkTLrTVbYaC4jCUn7xLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406057; c=relaxed/simple;
	bh=w/pjUF6/gKgekCCmiV+9ZYGFEm9eEzKa0uBfQc1wy6M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dyq1+iU+aCyP4VR7ZOQbMG4bLe3qhgW7G7aCCmVae6oM9oX63l0EHCfv/fOEvDN2SbtWJTIhVMMdsaYwANqMAzvLabv6ncFNMHEpirMvb85mNf0078Gin//IzcoIwfzJqL9f4WO9VVnz0QNrXBq40Vrthu/Uw5GVL7nHK37Hr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lyl68rL4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716406052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCKFui8m/ob9wQ/NF2t7IgEcg5H7ebWvaTrdWzf4r9k=;
	b=lyl68rL4cedz67hrawGX3qF00Uzd1nLncjkUj+dPTuiNI46v8dYRRpZTuUEFYXRJh4GxjD
	VExsWwzQjoDDxLrdcITz+o7Pl2lbIRrgmF3LpU7d+vz9V2U3sRvR93r0kYFGq1QmRVb3Tr
	g68FlkNtQX8ktXYmKFOGTYsT5lUBVm+5hzNvd7K/Mv5Gjq0smPaiDoVzyz4hHCc8VUUWmO
	4HQv4jZ0eiycaP0dLeUzKVbM1MGQVadJVVjACJZUfLWvMqG5IPgcwfhe1WqnNYw4wiEPcN
	oF9Dwm44zV5KlUr5vnsnh7Ntx/KwJbM8n2G9On2fGIB0A8ayZmlb4Vqm1J44cg==
Date: Wed, 22 May 2024 21:27:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
Message-ID: <2c0a1779713b5bdd443a8e8258c7dc66@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-05-22 21:21, Gedalya wrote:
> Debian is now building iproute2 with color output on by default. This
> brings attention to the fact that iproute2 defaults to a color palette
> suitable for light backgrounds.
> 
> The COLORFGBG environment variable, if present and correctly set would
> select a dark background. However COLORFGBG is neither ubiquitous nor
> standard. It wouldn't typically be present in a non-graphical vt, nor
> is it presnet in XFCE and many other desktop environments.
> 
> Dark backgrounds seem to be the more common default, and it seems many
> people stick to that in actual use.
> 
> The dark blue used by the ip command for IPv6 addresses is
> particularly hard to read on a dark background. It's really important
> for the ip command to provide basic usability e.g. when manually
> bringing up networking at the console in an emergency. I find that
> fiddling with extra details just to disable or improve the colors
> would be an unwelcome nuisance in such situations, but the Debian
> maintainer outright refuses to revert this change, without explanation
> or discussion.
> 
> Instead the maintainer suggested I submit a patch upstream, which I
> will do. I've never contributed here before, so your patience and
> guidance would be very highly appreciated.
> 
> Ref: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071582

FWIW, I'd support the change to dark background as the defult.

