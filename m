Return-Path: <netdev+bounces-39191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D717BE499
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5956F1C20949
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481D37148;
	Mon,  9 Oct 2023 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0HeAhKF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D018E35
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B787CC433C7;
	Mon,  9 Oct 2023 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696864965;
	bh=90Nw7C1r5590JsH2IC90ojg36mM9j5xrkmofzz7IoGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p0HeAhKFk41isBvY6kT5E6FaB/5ZFJwCpTABsYgt5p2hJQAxqk/1ECkcIDeJv2MjP
	 yTM7tsO8Lj5+ho0w1xdD9s4jM6tS/SJA58YnPQ1cum7HoF8H70UExVNbPAWyjA0t8y
	 8h7mqzElVTIazDk57OYNNT4DgWRtKG9hAQ7sxm8iVQIUDILyPx76M9nlPcoNUL4kft
	 TyIKYqfIWWG1v1U+gjN8oMAp1+h8W6aLXxFnyDlBa2AoDMiYeIuIxQmm9mkNSG1RAX
	 xQtynLCfBZKHljxCOrMwwl0XDwjNJs10rgbfQtwkNRbGQMy+s6Tv5VGYaWINzHEa/B
	 gLbPTC9MQimvA==
Date: Mon, 9 Oct 2023 08:22:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
 davem@davemloft.net, pabeni@redhat.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 2/5] dpll: spec: add support for pin-dpll
 signal phase offset/adjust
Message-ID: <20231009082243.6a195cc1@kernel.org>
In-Reply-To: <ZSEzG0TpTI6W9+tL@nanopsycho>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
	<20231006114101.1608796-3-arkadiusz.kubalewski@intel.com>
	<ZR/9yCVakCrDbBww@nanopsycho>
	<20231006075536.3b21582e@kernel.org>
	<ZSA7cEEc5nKl07/z@nanopsycho>
	<20231006124457.26417f37@kernel.org>
	<ZSEzG0TpTI6W9+tL@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Oct 2023 12:29:47 +0200 Jiri Pirko wrote:
> But since by the policy we cannot break uapi compat, version should be
> never bumped. I wonder howcome it is legit in the examples you listed
> above...

Yes, even it's the 0.0001% of the time when "breaking' uAPI is fine,
the change in the family spec can these days be much more precisely
detected using policy dump.

> Let's forbid that in genetlink.yaml. I have a patch ready, please ack
> this approach.

Ack, please remember to move version into the # Start genetlink-legacy
section in the genetlink-legacy schema.

