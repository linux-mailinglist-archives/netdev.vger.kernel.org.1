Return-Path: <netdev+bounces-226572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0950BA2317
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E692E1C2786A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569D2405E1;
	Fri, 26 Sep 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNXjr6EM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA02AE68
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758853103; cv=none; b=tTOsspn8OA8nmTrX5KX2g7RooPawy0fgkeAmbXutHqZEdBJGNU9PiJZ0XDneagVs5FoLbGSMuMskR+ZmRbjfPowAVHmE8zN9CmMhHUDj6kuxkBAzDrK5Lc4wBkw58sz1NLr5chWW/CjdjLTQvQUOroxPM6Qax4oIcsVkRw0IGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758853103; c=relaxed/simple;
	bh=8EeFGxlFMXU+1hP0J6Z2damrYSmeXO+P1S7dWkiXzKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnD9oJAsII90s6llVpTwn5Akn8+WbXOiFhsY07KSn9BbeJJ1ljJzdeqjk0x66w3GkfFFk2bk4s94nBmyKcaAINhpqi7hnv156G9/A0tPCamoq+O8XYaTmXaOyjzd/RaFXunDbuiy5lyJM1miWLQlxaID11bQBQMmQ889aiH5L6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNXjr6EM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA811C4CEF0;
	Fri, 26 Sep 2025 02:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758853103;
	bh=8EeFGxlFMXU+1hP0J6Z2damrYSmeXO+P1S7dWkiXzKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MNXjr6EMt3/cvf4DCqHG01fInEpkl0Vg3T0NkmNlBAVm4jqjw2xDTtkk+kZUZ6xlq
	 xJZ+yHrp9Y5I8j8mXTEtXq74BGvhILFGGMgszaSjQegiajHs9seuC5Nb5VWq1IZLcJ
	 E40TNHcJDFrt3o9Hxdm1S7xOmMtLtwCYgYbLPKOTTjDs4j2WlPKFmoyo1j2hYqoHM3
	 a6DmD2fkZ93fcHGQFeZNopGqEuIeZX8hzyY2vxcrkWyS1aTr416TUMEPctK1Cvnb+C
	 X5T4XdrCaNgyRfQ2csipDAw2okTdBvCMMPKHstn/vqay08IRsOOy9/5tnQYLUJkTWR
	 WABegXj30HJsA==
Date: Thu, 25 Sep 2025 19:18:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Breno Leitao <leitao@debian.org>, Yuyang Huang
 <yuyanghuang@google.com>, Xiao Liang <shaw.leon@gmail.com>, Carolina Jubran
 <cjubran@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/9] selftests: net: add skip all feature to
 ksft_run()
Message-ID: <20250925191821.7adfbdb4@kernel.org>
In-Reply-To: <87jz1mwksz.fsf@nvidia.com>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
	<20250924194959.2845473-3-daniel.zahka@gmail.com>
	<87jz1mwksz.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 18:09:33 +0200 Petr Machata wrote:
> > +            if skip_all:
> > +                raise KsftSkipEx()
> >              case(*args)
> >          except KsftSkipEx as e:
> >              comment = "SKIP " + str(e)  
> 
> Personally I'm not very fond of this. Calling a run helper just to have
> it skip all tests... eh, wouldn't it make more sense to just not call
> the function at all then? If all tests have PSP as prereq, just have the
> test say so and bail out early?

Yes, good call. To be clear this was my bad idea, I think I wrote this
before the ksft took shape upstream. My tree says:

Date:   Tue Apr 16 12:02:59 2024 -0700

on the patch from which this was factored out. So let's chalk this
lapse of reason to experimentation :)

