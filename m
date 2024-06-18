Return-Path: <netdev+bounces-104646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F690DB74
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F531C21A26
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBF115DBC0;
	Tue, 18 Jun 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPzlY2l8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8D13F426
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734635; cv=none; b=WNcri6uWzyegxaOl8EJzm2eUb7/B4CFBIv6qgk5BL89ej50XTuJF9gbd5XCpH7yAbTUOo1uEaG21CRR5bcnUgwIoDGJOPBlwwU0MAlFvzgibJqdr1YKmXVMYtG3kWon4+qWzMu+1IMYgCAxqwCt2IZEVz//CBd4uVGCgoezW0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734635; c=relaxed/simple;
	bh=oXZ1eZOsIbOZdsU9kJD6xYEB+sMGXbiAsCiEj0kMdCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlCIpKLd8md1EbIOMw7hvMf9BqCuWho+YttzDHUqXvCaZZMqce+oK5XIVKuvswH3UYjffNR/GgleLFwgjSyb70MRzd0twuveZIJL6ZYBjhwaYM67uVCRK56qKJOXJ9ZFDXXss4P4ZggweNx9hwDOEqMYo+uMdHfx5hX9zjrjJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPzlY2l8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B6CC3277B;
	Tue, 18 Jun 2024 18:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734634;
	bh=oXZ1eZOsIbOZdsU9kJD6xYEB+sMGXbiAsCiEj0kMdCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPzlY2l8dNaYuxVwBaItfk/MUTjMQ0QSNQb6KAw/513XRbWHZ027yLjoU/Yz/EzTA
	 dqhfOQvJgUTTJujNnWFPR5gH+3NYTgGzxsV80VmCtWuyms4Zi8TnNTdpqoub0u/bhy
	 O3UEVMWDIxW3Bitpy7iI1WajdBxlfRUd6nVemqKvr1bnq1KrkRoFstT16ZldJ6qhVb
	 zp/XMcvnRxOohj8mWCUTR3W3ymKcm/ubENHoe8/GA2M1F/SERf4T9iiq0LlWQIuT9/
	 EQZ/i/6Ac4sX4mI2MjJ6LBaBRHk748gwoZPZvkEQxy3mRnqBnyCWsYNHRwWPcUrT3a
	 3Ib03t6u26o6Q==
Date: Tue, 18 Jun 2024 19:17:11 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v4 00/18] Add IP-TFS mode to xfrm
Message-ID: <20240618181711.GW8447@kernel.org>
References: <20240617205316.939774-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617205316.939774-1-chopps@chopps.org>

On Mon, Jun 17, 2024 at 04:52:58PM -0400, Christian Hopps wrote:
> * Summary of Changes:
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> This feature supports demand driven (i.e., non-constant send rate)
> IP-TFS to take advantage of the AGGFRAG ESP payload encapsulation. This
> payload type supports aggregation and fragmentation of the inner IP
> packet stream which in turn yields higher small-packet bandwidth as well
> as reducing MTU/PMTU issues. Congestion control is unimplementated as
> the send rate is demand driven rather than constant.
> 
> In order to allow loading this fucntionality as a module a set of
> callbacks xfrm_mode_cbs has been added to xfrm as well.

Hi Christian,

This does not appear to apply to ipsec-next.
Would it be possible for you to rebase?

