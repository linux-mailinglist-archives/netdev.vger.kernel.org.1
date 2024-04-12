Return-Path: <netdev+bounces-87229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9708A237F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182D7282759
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 01:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F04C8E;
	Fri, 12 Apr 2024 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCCK+phm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905511185;
	Fri, 12 Apr 2024 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887014; cv=none; b=GZcQW1LkCzRPdjJABsmL+VQHQ6X6e4BT57W53sxAx5/RobYnXm25SGkH8nvv4BdhLRPU5e6nwIp8j224gJbgKro1qE76r/QpTcB7hibbK/TWtFrKlzilEmGYhvEnn7ke4afXUTYFmsi/BORJu4Cb9bODWPkVy/1abkvsm5JByJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887014; c=relaxed/simple;
	bh=FCEz5esbpD6CwZExrvwyGdilh+o7c1QbNVel5r4CtB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAxoCOVLuAf7YugZv7ARLO/i3E6iL6YlyilrvYNtis68Zwhu7e6xTx5GrQLXjbkdRPK43XU76QhHTJ8wXZNC3KYm1UHg8eM81troK7dBnJH4zjyoyhALZ17YYA8SBVWHkOLdZ8VGf5BrKa+73wEVxGI+YiMORpKQgHzXFsPcoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCCK+phm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3C3C072AA;
	Fri, 12 Apr 2024 01:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712887014;
	bh=FCEz5esbpD6CwZExrvwyGdilh+o7c1QbNVel5r4CtB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PCCK+phm5907CSkC2C2A+6EYf/8TPj26UiI4HYaAiCEqXo4Ob4C/oVsZYH98IX5Mm
	 idDIAD6lhs9lTnc5ppnhg/QyeOC2mOniKbF/LPjirxe0uE/TsunvXzyI0La93nYwp1
	 tieCFme7TIrwuxJxK6+iJ/4aj+YCI8V2P9EcKvLHE6L4zWfDEQJEH54E4dRV/BV/xS
	 1WBnTI/QLffhcvFXUlghaNtxvA+oFTdJqMjK4G91bUVFLQ5ckf2Q0eqM7GG80N3opy
	 vToNIUQFEAQ7rBfQogDueubuQEVpolDWS2z0BXJn65WLOv+ySaMmntlkEEPKxjkw0/
	 K6XSx7n1PZsuA==
Date: Thu, 11 Apr 2024 18:56:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull request: bluetooth 2024-04-10
Message-ID: <20240411185652.12273d5a@kernel.org>
In-Reply-To: <20240410191610.4156653-1-luiz.dentz@gmail.com>
References: <20240410191610.4156653-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 15:16:10 -0400 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>   - L2CAP: Don't double set the HCI_CONN_MGMT_CONNECTED bit
>   - Fix memory leak in hci_req_sync_complete
>   - hci_sync: Fix using the same interval and window for Coded PHY
>   - Fix not validating setsockopt user input

Looks like the bot didn't reply.
Paolo has pulled this for today's PR, FWIW :)

