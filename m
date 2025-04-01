Return-Path: <netdev+bounces-178563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC929A77913
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C13188D595
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746191EE008;
	Tue,  1 Apr 2025 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjzePalp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504CBEACE
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504434; cv=none; b=uH6HGu3ziTL00LKZQzWd+rZW4gNyUm4wnK3vtOz+QtgIVl/GAVCS974dfxIXBU0HvDpg26bUPPmaRDSmwvMG2FXb7eswmeHWbQvvaN4ndtaFEcu7W4c1OXgaviLrkz+wZ57I+Hni9S8sdJIef3KkLMY2GHaknVwHaKHQ5tE1uu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504434; c=relaxed/simple;
	bh=cuIzmr6W3k84Rh6GZ3sEBt6aImYhFNsePsYqFzvYchA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXM3h191A4Wi2l5XB2cbkQgqx0iMiaU7QVgNR5qGfSXiDuW8PZ6N3cTWZBWezXliaraUhjSgKxYQik5yp9DJtkEKaQB2kNebUonCMF7K/96i2JdXuEsDYem9jn0JK/tJTpIEWd45DCvXP0uNQyghyz11TVvbhXmt7YBITrXCMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjzePalp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF74C4CEE4;
	Tue,  1 Apr 2025 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743504433;
	bh=cuIzmr6W3k84Rh6GZ3sEBt6aImYhFNsePsYqFzvYchA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjzePalpqd18JPkSEAmfi+DM1tIj9X0/ZhIpSPNyf2jBFffD8eC5EMxMCwRPOTEM/
	 F2XZGRguYYwnyTC9qWtshSvwyboouqBci4FcdAQfRSxS5LnJT3qyyOFc6J2CJrkC6+
	 MVnzCv4sUJRMixlbDJ8OeSxplUt+Ea9a8/w14nc8nAmB9LF+NU7ERNUoyGsQUUx6wA
	 l5dXqnHzLKTGxRnNVVTzzytec759avMceNNPN+LpeGywdgJZcjaWm9yjMe5CvXpVRa
	 EbvfdGmPIMz7P8GqEux3E4AsVUHMpRegW8FsJ3B0oOVilW9WR5BCM8NTkVn1mhUYB1
	 Ys7IyktFn2cYw==
Date: Tue, 1 Apr 2025 11:47:09 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>, pshelar@ovn.org
Subject: Re: [PATCH net] MAINTAINERS: update Open vSwitch maintainers
Message-ID: <20250401104709.GE214849@horms.kernel.org>
References: <20250401001520.2080231-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401001520.2080231-1-kuba@kernel.org>

On Mon, Mar 31, 2025 at 05:15:20PM -0700, Jakub Kicinski wrote:
> Pravin has not been active for a while, missingmaints reports:
> 
> Subsystem OPENVSWITCH
>   Changes 138 / 253 (54%)
>   (No activity)
>   Top reviewers:
>     [41]: aconole@redhat.com
>     [31]: horms@kernel.org
>     [23]: echaudro@redhat.com
>     [8]: fw@strlen.de
>     [6]: i.maximets@ovn.org
>   INACTIVE MAINTAINER Pravin B Shelar <pshelar@ovn.org>
> 
> Let's elevate Aaron, Eelco and Ilya to the status of maintainers.
> 
> Acked-by: Aaron Conole <aconole@redhat.com>
> Acked-by: Ilya Maximets <i.maximets@ovn.org>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Simon Horman <horms@kernel.org>


