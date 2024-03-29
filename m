Return-Path: <netdev+bounces-83472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BA789269C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 23:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130D21C2115D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED3213CC77;
	Fri, 29 Mar 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7k6wgpO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37C79DF
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750086; cv=none; b=oV+q68HQeTF748KBPLD+dQjQdQpb5iJwQh/clFRJnPotjznqr0YLXyt7QSE+T6FgLWGuZRORpSZJrROJfDX8f97NCFff8e/YChchGqZFHLuRmHJBL/QM+5pc4teb6Jwkr130D1Fz+vv8dspH+OqTmcLuBaLOf/zP5w0hiFTWr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750086; c=relaxed/simple;
	bh=kWMETMXKh9pRUAzvZSWq7Bz15B/8zNSH35OZ7BKefWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0x6I1P/VLoP8CEBqZPizhsHJAFAxf5EuycvfYcERObgS0DnMShjS06JWH7y6nJ0asvwOgYM/vEoI2pOXKmsGpm29Zsaicn+5kmZq6LbhCJ5/PsnTfTfIjM4H+nPwK5lDNxVpcmDehQrpjXB7PwogkrcOVupvblyNA1PnqIgPMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7k6wgpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A4CC433C7;
	Fri, 29 Mar 2024 22:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711750085;
	bh=kWMETMXKh9pRUAzvZSWq7Bz15B/8zNSH35OZ7BKefWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B7k6wgpOpYCMZtcHeZgurRFEn9jwJGxtaPhDeWWiz57ABGohoPp8cFuvxp3seywVT
	 i41cH1D3ebkuoAu6ufLjBgDQYfeitlzDYOUzXDZ3kBiORHqgtYjRP0uJVkR10UB5Ob
	 Lq7Fids2QxfuGxkMzqTUX4/a4sknbiCphzl/eRhmVuUBmF+tlk4qFf5BDiAA/nYn4c
	 5hAcpDR2aXLfShBWguJq/QpgsDd5X28Fd3ALXRVmAb865rwQALLZSqJ/K+PefRhJdO
	 8mTdDVfx1gqowAa5QH0Xx2rfwHeqBnB2HBEaTvME6QONh698m8tTEmNLy4eY9csIG0
	 ZcIa7WOCHRlQQ==
Date: Fri, 29 Mar 2024 15:08:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/4] net: team: rename team to team_core for
 linking
Message-ID: <20240329150804.7189ced3@kernel.org>
In-Reply-To: <20240329082847.1902685-3-liuhangbin@gmail.com>
References: <20240329082847.1902685-1-liuhangbin@gmail.com>
	<20240329082847.1902685-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 16:28:45 +0800 Hangbin Liu wrote:
> diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
> index 907f54c1f2e3..c13529e011c9 100644
> --- a/Documentation/netlink/specs/team.yaml
> +++ b/Documentation/netlink/specs/team.yaml
> @@ -202,5 +202,3 @@ operations:
>            attributes:
>              - team-ifindex
>              - list-port
> -            - item-port
> -            - attr-port

I think you squashed this into the wrong patch :S
-- 
pw-bot: cr

