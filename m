Return-Path: <netdev+bounces-237685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5533C4EC5E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A276188E637
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCB4364EB4;
	Tue, 11 Nov 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M198SEPd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB32586E8
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874592; cv=none; b=l9SQ/rl3Jxwa6VHgqe8U0adS8CRIJz7XN+QGaabRygshZzB1kNWI7fpwpmrAnEfS7x8XA134/83WhVFNm1xdXB320BY8zgCVAoPQ2a8FfMIhDM+pBJBAZVjncyEjY1ilgxx1z4oHF0vS9Xm6dtvUc5jJV9FQhbLNA3mAdsXz2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874592; c=relaxed/simple;
	bh=XUy4hSmlzm6KI7tov+MvNF+BYxrjNy5JOMDQ4JgFQno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mM9ofBdqk4O19jMx46wY3wcDdo8fri1S5ACnunBgYqKXLniWdPBlweGunjfKNiuxxYKAZjGLLJUIK6cqR/U/Xy9PK7j53bwUpGOgrO1RDij7XZ3D18RwCP4gwxJPsQOhJfBcUU1wKBPRwMKcJAIHgykexGo4WfjWuCSpyxx3z5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M198SEPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B50C4CEF7;
	Tue, 11 Nov 2025 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762874592;
	bh=XUy4hSmlzm6KI7tov+MvNF+BYxrjNy5JOMDQ4JgFQno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M198SEPd8rZBf+lbxJGy6pXdCqEuFkrmxQgIzK6/a1sHxhJ5fP2Xu/ofJblC4zeOf
	 m0U+3w+3XsQjMLV79XVuwjtbfcIFjoL/DnP4as/TQgVCvibay40ALt83O1PbeIrluh
	 QSYA6TMDKpSThbqvjlLnXgaoZWq3ef6hIk4Mcv8WM6LpkhgUbxs7daexuD5xS0iW1+
	 i6a/pA6V6bxhTqVaV3de5o6CMOBShOVA1gBac9QDdo2rngEejxFIg7k6Rww0FJeB9J
	 qWJ7SAnBcLAgLwElLYC/IO1c599RxkiWl6F2pOJZZxa4tuq6y4gbwJVnBB/kfqxkRX
	 wMD+E6E+j8aDg==
Date: Tue, 11 Nov 2025 07:23:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, kernel-team@meta.com,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 00/10] net: phy: Add support for fbnic PHY
 w/ 25G, 50G, and 100G support
Message-ID: <20251111072310.5af24441@kernel.org>
In-Reply-To: <6037c80a-ab5b-45ca-ae5a-31ded090e262@redhat.com>
References: <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
	<6037c80a-ab5b-45ca-ae5a-31ded090e262@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 15:23:21 +0100 Paolo Abeni wrote:
> Traceback (most recent call last):
>    File
> "/home/virtme/testing/wt-25/tools/testing/selftests/drivers/net/./xdp.py",
> line 810, in <module>
>      main()
>    File
> "/home/virtme/testing/wt-25/tools/testing/selftests/drivers/net/./xdp.py",
> line 786, in main
>      with NetDrvEpEnv(__file__) as cfg:
>    File
> "/home/virtme/testing/wt-25/tools/testing/selftests/drivers/net/lib/py/env.py",
> line 59, in __enter__
>      wait_file(f"/sys/class/net/{self.dev['ifname']}/carrier",
>    File
> "/home/virtme/testing/wt-25/tools/testing/selftests/net/lib/py/utils.py",
> line 273, in wait_file
>      raise TimeoutError("Wait for file contents failed", fname)
> TimeoutError: [Errno Wait for file contents failed]
> /sys/class/net/enp1s0/carrier
> not ok 1 selftests: drivers/net: xdp.py # exit=1
> 
> even if I wild guess the root cause is the removal from the nipa tree of
> "nipa: fbnic: link up on QEMU" (which IIRC is a local patch from Jakub
> to make the tests happy with the nipa setup).

Yes, let me queue up a version of that patch which applies on top of
Alex's series. QEMU does not seem to get link up. I need to get around
to updating the build at some point..

