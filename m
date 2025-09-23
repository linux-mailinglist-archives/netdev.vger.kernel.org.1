Return-Path: <netdev+bounces-225652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B534EB9677A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A8C18882A1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2867223707;
	Tue, 23 Sep 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hizHxt0Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3321FF30;
	Tue, 23 Sep 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639448; cv=none; b=EG4WoSEsx03C0bB49eHbJ/gRRBbLMJy+newTdKJVH9XcffhLVb+p49vUKXE6YdWDRcP8XOz26mAL4bBV66UiQHgrcDXk3E8fjBJsiKY0WMYcNsoeBHzZdLt5ZMUHNcMicDUQnXcmRwWQEWM5a7gIMpCnMw/HEQVseD9+jjIvVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639448; c=relaxed/simple;
	bh=TPA67cmguQKr0ItI5iaMlBmUJG37zNqxtvgxCiM/IW0=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GujJjkCqzcPUImPNgrK0tKq5x492bMyrNYX4lQYVRBgmaNcH1icNyRt0J7wQGN5Q8dzn8Fwmj8Ov9SD4pBJFkDhEWSi0eQFw/svjhYM+PCHxi1NpL1prZmtwgUEhkZgkIuHbTVbkQWxU3DynaatDCAvb2Z7GnT172ARWG7yRMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hizHxt0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2929C4CEF5;
	Tue, 23 Sep 2025 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758639448;
	bh=TPA67cmguQKr0ItI5iaMlBmUJG37zNqxtvgxCiM/IW0=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=hizHxt0ZT0P/OYcXi40mdUgrre1WySJR5b8SfyJhItNNJ9y7kksKkdjc3Gl1O2CdE
	 m6iVrCE6lUbm79ZWftDEcPtjmRvyxuJBSrAq4vUCPCSGPS0tqxDkyqBDJS47+lQ3s3
	 T6xkrK7b6MGaCXNw13dFnL++JbSOmmi5yJafEoKuCC91xVo7NO3Il7bBekmWt6MmpY
	 L1zARCnA4aw7uX9UanI//GAB+HY9LNMXIlsYOFgKZGgH9yVYaiIrJlZPAOVsmhPBVU
	 vIzvdng4OXSNp2fDnqZmYOYubvO5hgMdLoRAkwqdXILCsTHPSjhntcRyKDJpdzyPkY
	 2exTG/GTHT3PA==
Date: Tue, 23 Sep 2025 07:57:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Sep 23rd
Message-ID: <20250923075727.49140bdf@kernel.org>
In-Reply-To: <20250922105431.0389a849@kernel.org>
References: <20250922105431.0389a849@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 10:54:31 -0700 Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> No agenda at this stage. Please reply with suggestions, if no topics
> are proposed 2h before the meeting we'll cancel.

No topics, so canceling.

