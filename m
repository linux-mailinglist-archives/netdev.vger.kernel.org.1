Return-Path: <netdev+bounces-49505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875FF7F23A2
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0171F2659A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162D513AC9;
	Tue, 21 Nov 2023 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJszn1pV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9036107B3
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08838C433C8;
	Tue, 21 Nov 2023 02:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700532473;
	bh=40pG9ocVC3F8GnuvVwssfEc0AVnJiaWz7+C+w2rqdSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJszn1pVL8/9DH7wvnyXD3vPm4QrOBnT+aNj3uNsQmARgY37DaDQyznMnczrBMPAr
	 VDHxA5vNcI1DqowIXkZKsaZONp+dP26oGBozoPrfgn2geYRsVZOm//q/W1fjxq3B0E
	 r53UuaFKiziDuBpH3WPiNNkrcgczEQ5uzQmx/Qe3IWLEBUAh0QRpkGBzP7HKYONKD0
	 +g6Mh3V4aqmJx2V3gwrXMA6U/6JhwzgOn/tGQeTiE+YGWcxIXGV3/e8pBIyjMA3TnV
	 6++ReHewJpqFg/k8W9J5ffhZV0f9pNwxVY0uVHsmpN2NhhwvN54qDtYds661hH6ZO1
	 vUn7y7GC4EPaw==
Date: Mon, 20 Nov 2023 18:07:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, victor@mojatatu.com
Subject: Re: [PATCH net-next 0/6] selftests: tc-testing: more updates to tdc
Message-ID: <20231120180751.2e28c253@kernel.org>
In-Reply-To: <20231117171208.2066136-1-pctammela@mojatatu.com>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 14:12:02 -0300 Pedro Tammela wrote:
> Address the issues making tdc timeout on downstream CIs like lkp and
> tuxsuite.

Please do CC linux-kselftest@vger.kernel.org in the future.
Perhaps someone wants to read all selftests coming into the kernel.

