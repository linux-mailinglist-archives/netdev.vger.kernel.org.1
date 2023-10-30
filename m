Return-Path: <netdev+bounces-45160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5397DB365
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 07:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0793E1C2091B
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 06:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA9ED2;
	Mon, 30 Oct 2023 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce6FX2Bj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C3ECB
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 06:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391A3C433C9;
	Mon, 30 Oct 2023 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698647703;
	bh=dq4l8NAXZiYvikkTAGNqkywO1nJIyjIxuuGufU4+m4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ce6FX2BjtxNvJuHsjRxz7loP51O1wFFyVQjXk3kLwSm2V3vmYxISgsgLhWR6UKDsc
	 khZzdP6BaCYVFUSkIfvBhWffApJ5xtQp7GiDnmnXStfsewy2WJRyZu3cm7HjLFLAoa
	 7vTb0LBMAb14p7DxwjwVS+UfdHNL1aVAD+5XUX6q4cIVu76MlBU+SeVJX+z9QP1jSi
	 2cYscgYacUfNbXOtAfYKP/fDieM7hovhvz/VR/q3v+MsgJMzsSJ7QYGKIyox0Vt7w+
	 GvfQxJc97WTLGspt50wkEe/qQ4p29ZVv+pzJqfLew3SQI9dqFS6BZOoPcsG9LzaSfl
	 HEzPR63ZP67Rw==
Date: Sun, 29 Oct 2023 23:35:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan
 Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu
 <wwchao@google.com>, Wei Wang <weiwan@google.com>, Pradeep Nemavat
 <pnemavat@google.com>
Subject: Re: [PATCH v6 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
Message-ID: <20231029233501.0fc5946b@kernel.org>
In-Reply-To: <20231030052550.3157719-1-lixiaoyan@google.com>
References: <20231030052550.3157719-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 05:25:45 +0000 Coco Li wrote:
> Currently, variable-heavy structs in the networking stack is organized
> chronologically, logically and sometimes by cacheline access.

Merge window has started, see below. Also please take a look at our
process doc, specifically the 24h rule..

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

