Return-Path: <netdev+bounces-140149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2529B561A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CE01C21D24
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE9320A5F7;
	Tue, 29 Oct 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgxM+5fz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E11EE021;
	Tue, 29 Oct 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242547; cv=none; b=IyuT5hSyXQVSpa/iVezELVtElucvo8Ft1R2+BORjmcgsBrF4eI0jAMZdUEUcAh6if+Fa5wnxov6gEoH648xeKqSHdnqtbSsjEbtnyKwefFYn+0wOYRioRScP4TE5l2N0kpqDCKZl1wK9a0uQrcBDWIJU1kc4SQfK8j8mrfDVnEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242547; c=relaxed/simple;
	bh=93E/kZZhkMzWuW9Vt3ZfUV+m8acW3lp/+MlaAWOEx50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJHtvJKHOotrx4g/FsRSgwS2zaGTWScoFtDe0XZFBfTAHDoeHx9QAQVCcpMf0LdLSQJ7iEeRKbL6BS1fGd2cwC/i7g8PDXDRCP8Xk0kt1soiL3HmikFomAOp5kdT/AcI8+l0+R5VJ84CJ49qM/om8Vb9fjzd+ou9Nqe1NJXgIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgxM+5fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F0AC4CECD;
	Tue, 29 Oct 2024 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730242547;
	bh=93E/kZZhkMzWuW9Vt3ZfUV+m8acW3lp/+MlaAWOEx50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OgxM+5fzTUnVe/BU9nDms0fgGL6oQtv/37CG+foqAmC3Y29py3OBYQ2UnTHxcTcJz
	 7d1wVHvZKERaiIRKlEop/5uwkGjK8gJ3u427SnmptaEhjJb1rHcccXECPLLFNJtAHr
	 RnUUuaCs0FoOchAoD7+3fk1iI2KHWn9jpgo6uMvi/O5H4mWzXcWZ6lKDde2J0Fg7nc
	 XX+OAeexOcC5UHHZOFe1VfJcvDoqow2TjJnzTk1d4i5+kGJcNKA0C6kRYObGKIp0UY
	 p6bJhPgITdUCvn59jFD1DLA6JDvJAmDgscpFkwebCXdtprh2ZvxZHlkuUcL3qHXMuE
	 KOr37HhUl/wFw==
Date: Tue, 29 Oct 2024 15:55:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: fjes: use ethtool string helpers
Message-ID: <20241029155545.55ae9e30@kernel.org>
In-Reply-To: <20241022205431.511859-1-rosenp@gmail.com>
References: <20241022205431.511859-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 13:54:31 -0700 Rosen Penev wrote:
> -		for (i = 0; i < ARRAY_SIZE(fjes_gstrings_stats); i++) {
> -			memcpy(p, fjes_gstrings_stats[i].stat_string,
> -			       ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> +		for (i = 0; i < ARRAY_SIZE(fjes_gstrings_stats); i++)
> +			ethtool_puts(&p, fjes_gstrings_stats[i].stat_string);
> +
>  		for (i = 0; i < hw->max_epid; i++) {
>  			if (i == hw->my_epid)
>  				continue;
> -			sprintf(p, "ep%u_com_regist_buf_exec", i);
> -			p += ETH_GSTRING_LEN;

In some of the other patches you deleted the local variable called p
and operate on data directly. I think that's better. Plus you can
remove the indentation here and exit early if stringset != ETH_SS_STATS
-- 
pw-bot: cr

