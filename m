Return-Path: <netdev+bounces-51486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D597FADAB
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 23:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885821C209E3
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 22:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6529C4652A;
	Mon, 27 Nov 2023 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARaL7WEe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48095374CE
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 22:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF29C433C7;
	Mon, 27 Nov 2023 22:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701125187;
	bh=8Bb8ROMKoO/5URW/h0GeuG8/4JBlEDL8LweLQ0JKFNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARaL7WEeG7jniC1uoKrIl0EU86q+Tow4JxYdNklRJwC6x0bAyZbZLwETbiy6ka+bt
	 BGGFrtPTK152GaVRJ9mt1PsKMPv5UeVRovgoKaWY3pO3Am/vitBmuy1a1DlJf8HipE
	 vudl59WrlOBo8VJ7Hz4KMLSdHrR6KyZoxBCnlKY9RolbvgXn3nSi1W/6mGlXSo0XMp
	 E7H20hcMBbPTBCOc6qSJ2Y/N2crKkxkWPEbPGqP+VKWGemSIdLQllLYu7p6/jkhz1z
	 //m2TPaA0E34BLYJOEp8WEzxSqnauwlPK4QNOI5GYFckMhhi32VFZdMoNt/1lQqhVG
	 zBb8BzjK5eHOQ==
Date: Mon, 27 Nov 2023 14:46:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <20231127144626.0abb7260@kernel.org>
In-Reply-To: <20231123181546.521488-6-jiri@resnulli.us>
References: <20231123181546.521488-1-jiri@resnulli.us>
	<20231123181546.521488-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 19:15:42 +0100 Jiri Pirko wrote:
> +	void __rcu		*priv;

How many times did I say "typed struct" in the feedback to the broken
v3 of this series? You complain so much about people not addressing
feedback you've given them, it's really hypocritical.

Put the xarray pointer here directly. Plus a lock to protect the init.

The size of the per-family struct should be in family definition,
allocation should happen on first get automatically. Family definition
should also hold a callback to how the data is going to be freed.
-- 
pw-bot: cr

