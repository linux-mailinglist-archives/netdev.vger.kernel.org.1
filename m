Return-Path: <netdev+bounces-43563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7CC7D3E63
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D0B2813B5
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BDE2134B;
	Mon, 23 Oct 2023 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0HQ/GnT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481821349
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 17:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83763C433C8;
	Mon, 23 Oct 2023 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698083838;
	bh=UUi8FGYM1u906+BcFG3tQm7bxihFaUHKGcInp0ipF4A=;
	h=Date:From:To:Cc:Subject:From;
	b=h0HQ/GnTR2wHRTeKm5WybElWxfmSGs0GnOiE9bfurcRGE/vG6kAlIf0C+NyA3h7+3
	 zaPywf50+zAPqRSSaFeH7REh2Dq9pz+hTfGSdX95tVyICZuDMAepEEFMgmoIOPWAM3
	 xBjELb2VdQc2rae7nJUb354dmcWjbFZ/ugERcNocOkx09dUAruwz59s0Rh++2qe/Lq
	 Z9jlGCqUz3fhQbKOtMjDoqKT6zH/0OmyxyIjHLXyAvv+v11ZBG3JfThaya733jQRsC
	 YgPXnyu/FK/cTJ8AZazQu0VLqFw8YMUMorp5gU2KeGot3rMoBnRMwJZKVSBXkc9E5T
	 +lcF1UT0ZfSTw==
Date: Mon, 23 Oct 2023 10:57:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [netdev call] Oct 24th
Message-ID: <20231023105717.43518861@kernel.org>
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
is scheduled tomorrow at 8:30 am (PT) / 5:30 (~EU).

Nothing on the agenda at this point, please send topics.

As for the vendor review rotation, this week's reviewers
are the Intel team.

