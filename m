Return-Path: <netdev+bounces-203015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2DDAF01E7
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9695207AA
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A911EFF8D;
	Tue,  1 Jul 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0xBeGCG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C81E502;
	Tue,  1 Jul 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391111; cv=none; b=Kpip8i9h8BhNClGt4Cf/Z01jZ5d2rjjmdM2iadR61Z4sgdwCyCaAXcOtFNI5lZ3XjUmJwWlUk+7Uyiqnu43id8E++GHTR3r6JuffdPQhyqlhATtOnBvxi5hnQ468gMzdX/fT6cZzAAHYxf3ICAXdM6OEP1iebtfgLPmtI113LVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391111; c=relaxed/simple;
	bh=mD2iDYmmtnIsW2gaXGCHxnGEC6wEZua++TrDiO/T5IU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qfp9YEDq1uSPDwYHw0r1uTp3Dw+/nHi3vaKRGYWoSMaWMNwvPDxx9eNEIJXUiIGihJMRMQXRcMqNoJhZEMeWWFaD54CQZDwdynfUy3ErgP+NeA9OZiaYKcIwiqW9FspJdlQTclxkRbVXAHn9FZTw1u/nodfzb0AWOX0pdr3sJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0xBeGCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BD0C4CEEB;
	Tue,  1 Jul 2025 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751391110;
	bh=mD2iDYmmtnIsW2gaXGCHxnGEC6wEZua++TrDiO/T5IU=;
	h=Date:From:To:Cc:Subject:From;
	b=r0xBeGCGCDxvdkGlLHuTxq2iBqUz+ZnMbV9Jo0Av2zmTJqc64HWmI842H7bS0tOsG
	 vEY8dJ72Qi3FGyEsaPxeY+a2YXA+TD2sCFsTT8FLo5RwZ2rlpaWt47Tv1fHU62HcDb
	 IVwg97SzYrZI9gft9Qh7vTketlplu3OZ+4oKLmFYlskcqgOuP6dCVBLGjjMarV1YTO
	 v7gL/E/9Hid+O4UbVklk67WUTaESyIfEjBLEzHgJH9Gyr1rf4pNf762HQRKhLAwBTc
	 CnGB40JFqqAG5coTrtjqa3KoUOFfcHg403DQ441kAVnSB1/ELbcAtnXoNTC7mIpVLP
	 6FIG2Pvmu7y9w==
Date: Tue, 1 Jul 2025 10:31:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 johannes@sipsolutions.net, kuni1840@gmail.com, willemb@google.com, Todd
 Benzies <tbenzies@linuxfoundation.org>
Subject: [ANN] netdev foundation
Message-ID: <20250701103149.4fe7aff3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

We are pleased to announce that we have formed a foundation (under
the auspices of Linux Foundation) to pay the bills for various systems
which grew around netdev. The initial motivation was to move the NIPA
testing outside of Meta, so that more people can help and contribute.
But there should be sufficient budget to sponsor more projects.

We set up a GitHub repo to track proposed projects:

  https://github.com/linux-netdev/foundation

The README page provides more information about the scope, and
the process. We don't want to repeat all that information - please
refer to the README and feel free to comment or ask any questions here.

And please feel free to suggest projects!

  - netdev foundation TSC

