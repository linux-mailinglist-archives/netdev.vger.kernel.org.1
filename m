Return-Path: <netdev+bounces-46865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38C7E6D1E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C22B20C12
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5251E518;
	Thu,  9 Nov 2023 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl1rfojy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A81DA35;
	Thu,  9 Nov 2023 15:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E958C433C7;
	Thu,  9 Nov 2023 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699543013;
	bh=5IasqAP9J9MJqem+sA6sakHekSQMOSVadMRqHurNblg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tl1rfojyxGpE3Ko3BWg3V8/sst4Ri6/AlbO18QeGb7dHw4AdWgGEY1OrwRE8XSzFB
	 QdSj/r/OYzvoQyV+2am1SHq2/L5XI9nicfJvHRBypDmL874sxBGyX+a8z3nBuhccf/
	 Ad/g25FsnrhIuI993nBUxMeafhmMrt1n1RUnxvG9bXGrtfPI+OphitON0O6SGda4b0
	 HqBW5hipF5HQsRrvwDU05q43K4oO6LC86owRHH9h34PnHauQIw0RaMsu+8NMrGMAy+
	 9JpBscm0BGFO7lEH9U5WRxwMLykaFD7xXucH5FLpgscvncuNqusLEwY/lNkavIqMM1
	 cpoNYvmLuu4Ow==
Date: Thu, 9 Nov 2023 07:16:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
Message-ID: <20231109071652.7fa206a2@kernel.org>
In-Reply-To: <87r0kzuiax.fsf@meer.lwn.net>
References: <20231103135622.250314-1-leitao@debian.org>
	<875y2cxa6n.fsf@meer.lwn.net>
	<m2h6lvmasi.fsf@gmail.com>
	<87r0kzuiax.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Nov 2023 07:12:38 -0700 Jonathan Corbet wrote:
>   netlink_specs:
>   	.../scripts/gen-netlink-rst

FWIW if we go down that route we probably want to put the script
under tools/net/ynl/ and reuse tools/net/ynl/lib/nlspec.py ?
It "abstracts away" some basic parsing of the spec, fills in implied
attributes etc.

