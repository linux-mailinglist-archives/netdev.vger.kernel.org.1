Return-Path: <netdev+bounces-63356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7B082C5EF
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B302B239A1
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A20316426;
	Fri, 12 Jan 2024 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHBbFyd0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4F16406
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 19:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B28C433F1;
	Fri, 12 Jan 2024 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705088192;
	bh=FeF9XQKBBBRqxqLfB/gHdwU6QMenfHR4AoGN18hj/e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHBbFyd0ev33K9yJVnnKZym0/aayqLf8ceekLLmyJZRNSQ/hkqbnkBKioXk0cBvJ8
	 q7NXm+eU/BJrQjIqGvatXhvOCMkxWjU5TuhWGZQw1CzW+nAkj0GuPU3M8XPQky02PD
	 fnpva8qbYx4ex/F9pveGAAFbZhZvdEP7ucxWhSogBn9t+77kpY1nfHL3KeNeM+AsXt
	 MlH7liUrV4kLFY2XK75WCD1xoF5nCu6b3FNCUu1RkkYG54HNXq1IXidvk7y09G7YVL
	 g4U5oyz1ifRnmFzOIPAHGcXEI/G70m6SuZjfwCJkv0/8M4bk3Xog/z1Tq4ySVdngH7
	 dWb5W4IwIc4QQ==
Date: Fri, 12 Jan 2024 19:36:28 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang.tang@linux.dev>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	Peter Krystad <peter.krystad@linux.intel.com>
Subject: Re: [PATCH net 2/5] mptcp: strict validation before using
 mp_opt->hmac
Message-ID: <20240112193628.GD392144@kernel.org>
References: <20240111194917.4044654-1-edumazet@google.com>
 <20240111194917.4044654-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111194917.4044654-3-edumazet@google.com>

On Thu, Jan 11, 2024 at 07:49:14PM +0000, Eric Dumazet wrote:
> mp_opt->hmac contains uninitialized data unless OPTION_MPTCP_MPJ_ACK
> was set in mptcp_parse_option().
> 
> We must refine the condition before we call subflow_hmac_valid().
> 
> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


