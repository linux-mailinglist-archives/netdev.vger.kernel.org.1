Return-Path: <netdev+bounces-173590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C27DA59B03
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E29F7A63FC
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B619D8A9;
	Mon, 10 Mar 2025 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvb6DHGY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D422F174;
	Mon, 10 Mar 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624149; cv=none; b=nkQU/QUXHSirm5vTMDjNEkUuNMmX+y3dVVSI7VAYq31LclgGEoz1n0qv1zloXgEwgHj85WrWiEjGK38OcYf9XOe5tGWFgIdyq5wmQIBV1pMkgqzzGO9vGuQ93PqOQlwjZMFfWvZ15JNksCE5lA8HeUBOX8Bs1SLve+IDbCofFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624149; c=relaxed/simple;
	bh=6X4kKS2Mc5Dm8mE+rwaQdY3R3B2gmrkVRohs8z4osZ4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=iFcJURKvKRUgDGyT2XymRUzvBPmBY2hdQbsIYs0GIPevxHMhnuqGpTbHKlMZFHQ86oMXKYslPnWbHxI6YzfzlKkA8Pljv22EEAiCEobWS5eoIpa01RIYCkPoAnhKXVuTl5xAXMZ8khhF8WP2+43rLKAAn/zNSCYvfmZB1pX0a+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vvb6DHGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D69C4CEE5;
	Mon, 10 Mar 2025 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741624149;
	bh=6X4kKS2Mc5Dm8mE+rwaQdY3R3B2gmrkVRohs8z4osZ4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Vvb6DHGYi21gTtNoB+Zb+5g+KUtVxXkvP6uz1yoGuy3lJ/YoXhmqlFMXfHSXGLZha
	 ypplpVQbUm9p3LvLeIGJbUYQOWV1bjyFwDTmg2ZAwCM1fNvlxejZiWQ8Pq2o0G8jr7
	 CDB5O82agXjMXyUqqmeX/jvLJZl0axmX6A2CakCtSq8RJ1+eSrdEBlXMzkJgWxzEJG
	 rnIknsH6FlQaDuYjSASCrmR4LoT3CkhkPdxuofzJInjQ+jOtpwFPBg7TNyOSK5Yutn
	 GVPwcSkLaqC/n08AjkaZGHDAChqK+5qInUwHtPPRS2QfLLHjF3qYA6qVZpfXBlXoCW
	 kyWwdwE5x+8+Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z8w7ezFX3T01ptjH@qasdev.system>
References: <Z8w7ezFX3T01ptjH@qasdev.system>
Subject: Re: [PATCH] net-sysfs: fix NULL pointer dereference
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jdamato@fastly.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
To: 174124876418.4824.8589202932419197412@kwain.smtp.subspace.kernel.org, Qasim Ijaz <qasdev00@gmail.com>
Date: Mon, 10 Mar 2025 17:29:05 +0100
Message-ID: <174162414566.58153.13543967750742784209@kwain>

Quoting Qasim Ijaz (2025-03-08 13:43:39)
> On Thu, Mar 06, 2025 at 09:12:44AM +0100, Antoine Tenart wrote:
> > Quoting Qasim Ijaz (2025-03-06 00:53:07)
> >=20
> > > Later on the code calls sysfs_unbreak_active_protection(kn)=20
> > > unconditionally, which could lead to a NULL pointer dereference.
> > >=20
> > > Resolve this bug by introducing a NULL check before using kn
> > > in the sysfs_unbreak_active_protection() call.
> >=20
> > Did you see this in practice? Can you describe what led to this?
>=20
> I have not seen this in practise but I think in terms of defensive
> programming it could be a good addition to add a check to see if it
> fails. If a function can return NULL then we should check for that, also
> if we look at sysfs_break_active_protection being used throughout the
> kernel there is multiple NULL checks so I think adding one here would be
> handy.=20

Not everywhere, there are at least two other examples. The only reason
sysfs_break_active_protection would return NULL is if the attribute
cannot be found in the kobject's sysfs directory; we got there because
of that exact attribute in that exact sysfs directory and refcounting
prevents them from disappearing.

We usually do not add a check if there is 0 chance to catch something.

Thanks,
Antoine

