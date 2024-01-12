Return-Path: <netdev+bounces-63342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8DC82C5A0
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C58B215DD
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA1154B9;
	Fri, 12 Jan 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0rAFPzj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D615E8E
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 18:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F71CC43390;
	Fri, 12 Jan 2024 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705085617;
	bh=21qOPdLaKdN60+G+z+Lc0e12NHNHs20wxrMNpf/tOIE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=C0rAFPzjZPtwgT/VOFx62dZe6QX1IwHyWUD9pIv7mjp7G81xxpiGLhP4/G7GImgCR
	 1MN08Nfu/IEPeIXfYrWizVI1wadYPt5BVyrbAV+rO9+LVxV5mtka4Cya6shtqcqlj/
	 zIXUgmyZ190dNVre1ABi4m0+8wGX3zIw+aoVu4WDYKnlZ9jIaqS3caDM4Fy9SX8pop
	 4SstoOy71tnSt/+AD5DHsgIy1qZfpSSz0ansnHPn0pyRtLOqkAFEKc7TB5ObHLKbQ9
	 PIGoN18FY3YINerN77pmHwPiKoeCMq9IeOpYpFhNiUnf0vM/LWso6l1SkE/izGI8pB
	 FL6LNL8Dn2G/g==
Date: Fri, 12 Jan 2024 10:53:36 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
    Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, 
    netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net 0/5] mptcp: better validation of MPTCPOPT_MP_JOIN
 option
In-Reply-To: <20240111194917.4044654-1-edumazet@google.com>
Message-ID: <fd09be5b-001a-8778-eef8-b49f10209967@kernel.org>
References: <20240111194917.4044654-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Jan 2024, Eric Dumazet wrote:

> Based on a syzbot report (see 4th patch in the series).
>
> We need to be more explicit about which one of the
> following flag is set by mptcp_parse_option():
>
> - OPTION_MPTCP_MPJ_SYN
> - OPTION_MPTCP_MPJ_SYNACK
> - OPTION_MPTCP_MPJ_ACK
>
> Then select the appropriate values instead of OPTIONS_MPTCP_MPJ
>
> Paolo suggested to do the same for OPTIONS_MPTCP_MPC (5th patch)
>
> Eric Dumazet (5):
>  mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN
>  mptcp: strict validation before using mp_opt->hmac
>  mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
>  mptcp: use OPTION_MPTCP_MPJ_SYN in subflow_check_req()
>  mptcp: refine opt_mp_capable determination
>
> net/mptcp/options.c |  6 +++---
> net/mptcp/subflow.c | 16 ++++++++--------
> 2 files changed, 11 insertions(+), 11 deletions(-)

Hi Eric -

Thanks for the fixes, code looks good (one separate commit message 
comment on patch 5):

Reviewed-by: Mat Martineau <martineau@kernel.org>

