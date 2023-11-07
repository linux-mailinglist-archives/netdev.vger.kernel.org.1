Return-Path: <netdev+bounces-46300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F857E322F
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B3AB20AFC
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E57FD;
	Tue,  7 Nov 2023 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxlAl5dL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C81384
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F015DC433C7;
	Tue,  7 Nov 2023 00:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699316621;
	bh=gTOskCbqBgHzl2YkLgGvQdQ9DbSzi4Scqf2ofj1hD0A=;
	h=Date:From:To:Subject:From;
	b=GxlAl5dLzzoXGmRIHxReFmnSOsLcXVpursLGvMGE3BUzOlAHEbqSOdc0Z2tDXG8Gn
	 LYXTevOidRF/k3PYpoEgy/0oh6yjNNki5qfOSZxuJ0+SuKELhjRMG3U/mHd6lr4xng
	 pc+A4ReLKc1uHmJ4s4Hq3nUP4z6TbIBwPjjx+gkaKSSbpvtW9iBIPbhWcacfAH99Jw
	 jsGpGxXwldQnKJj3yEPjibCZu+ddjwdV3rBnRgdgMt0ftURw5XMI4fQxyk45gXaTcX
	 Qx9Q2HOrM9DFlhymBgP9h/BdGJaCCNhnSQgGVd0tR7EMmoldm0VA3gwhAa7dLWlaxK
	 yjZTF3tJdTN3g==
Date: Mon, 6 Nov 2023 16:23:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [netdev call] Nov 7th
Message-ID: <20231106162339.371852dc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).

Nothing on the agenda at this point, please send topics.

We could discuss any follow up / comments relating to
just-concluded netdev.conf, or upcoming LPC?

