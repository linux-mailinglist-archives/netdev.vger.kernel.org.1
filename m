Return-Path: <netdev+bounces-65490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14083ACC5
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9CE288CFD
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CCF12E56;
	Wed, 24 Jan 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdmkOIwT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E567A721;
	Wed, 24 Jan 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108878; cv=none; b=BhB17m4jxD7uP19YnGPDigjOQEonD/gvkQuMf+dE8TOV9updDqzzQ2MQ1bRcYWrMmo3WTpjfYjG10+nZrwAICotGSmlGIvqzPLX4rR3STRcINtMrSQzPLC8f3ZOwx4sTlvT6wECJFVvdnFJu+DaWQn6/t2cnBH3hv8APvTSpRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108878; c=relaxed/simple;
	bh=ffEzSyxEPiqv/apXJ1stUvLwUts2dciN8C413ERStkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCTcVvoOX2wIRWHlWeoL8NWWbNO47T2URjkQwpDLFFdBMlWdEt3dZmwr9jB9+bxIhA1zHyuTCWYBjmyYNA0/sMslJcE54rTBP6i/zQxPoV2MI678JAYRXEQzK+hRJufgZH4y1DR9WVUhp/WxtSl/DkDOyM/2hVMvdr52A7Rc1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdmkOIwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036C7C433F1;
	Wed, 24 Jan 2024 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706108877;
	bh=ffEzSyxEPiqv/apXJ1stUvLwUts2dciN8C413ERStkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gdmkOIwTr764xmdo13hSqtVD9NPi1u2n4uphkOnDa4d2YGO56vbpr6T3ILW8eeE42
	 rFRqkp6EWNbxx7FWXbODgn3OInBA3XPHJf/67KQr3R2Rj9fsdVsniUgdfM+ghUhY7f
	 u0xu8E1VZYHOWRWGZgVo8soIv0NLx8pfKzja+7UpyEhF1Xvlp2TlnQRHfYstKF+hO7
	 1qsBIWG7/Fe8UWOJ6jQtYu3grS6EY91o7XW3mm6y/0Yi2enRkQSm3PiSVn4y5RZi4u
	 twLmDeeTOOwogDZHbbyL5o7TrmmAf7G9IAArK6BSvagDbu7LTug2Y5/DYUkfCxeMtX
	 dh4o17pCZ5aMA==
Date: Wed, 24 Jan 2024 07:07:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "netdev@vger.kernel.org" 
 <netdev@vger.kernel.org>, "netdev-driver-reviewers@vger.kernel.org" 
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240124070755.1c8ef2a4@kernel.org>
In-Reply-To: <7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
References: <20240122091612.3f1a3e3d@kernel.org>
	<Za98C_rCH8iO_yaK@Laptop-X1>
	<20240123072010.7be8fb83@kernel.org>
	<d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	<20240123133925.4b8babdc@kernel.org>
	<256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
	<7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 09:22:15 +0100 Paolo Abeni wrote:
> On Tue, 2024-01-23 at 22:20 -0700, David Ahern wrote:
> > thanks for the tip to direclty run the tests.

Actually, I simplified this one a little bit. What we do now is:

make -C tools/testing/selftests TARGETS={target} TEST_PROGS={prog} TEST_GEN_PROGS="" run_tests

This let's us run tests individually. This way we can put them in 
a FIFO and have multiple workers run them in parallel.

> > the script needs lot more than 45
> > seconds. This does the trick, but not sure how to bump the timeout for a
> > specific test.  
> 
> You can set a test-group-specific timeout touching the 'settings' file
> in the relevant directory. Note that for 'net' self-tests the timeout
> is currently 3600 seconds (for each test).
> 
> AFAIK there is no way to set a single-test-specific timeout, without
> running that specific test individually:
> 
> make install TARGETS=net
> ./kselftest_install/run_kselftest.sh -o <timeout in sec> -t net:fcnal-test.sh

Yet another thing run_kselftest.sh can do that make can't :(
We should probably bite the bullet and switch to it at some point.

David, I applied your diff locally, hopefully I did it in time for the
7am Pacific run to have it included :)

