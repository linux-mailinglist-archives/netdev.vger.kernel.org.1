Return-Path: <netdev+bounces-57628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5374813A86
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E191C20CFE
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE8A692AA;
	Thu, 14 Dec 2023 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCs4dIyo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA63692A5
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850DBC433C7;
	Thu, 14 Dec 2023 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702581256;
	bh=QIXd9hUhcOaVQlkF6eF55BrvLLgJ7HtoEdF8I3frbaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCs4dIyo99VaOf1aatQ+eDYshYa4khvZCKNOyXSJXcTkLXCAu9aCKq/ce0bdfUGvN
	 xqgTTqPYiLD2mNR2UElEfJtWMK4wuFMkmB4QbXgxLrThWuxNYJ2FfEUUA7A8qrGkDA
	 xo3CTXgDHsVzx1boHj/OGnmCdYz5qeUHYlL3erOp8LWg4RhogfDrAyIkX/Lrl69ghw
	 g1CkCV2YQOxYYufmRM3UPievGq/EYMlMMM3wnsyyTIV/6vJVU+vrUDHwd17Xn3be7e
	 A0YmiQ7z9w5Pm5IsdIvLkcmKTv31dgK+97SWrQzZ+unUYSeANIpVaaaiZSTVmi3rKk
	 Yfs5ApLDs+COg==
Date: Thu, 14 Dec 2023 11:14:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 1/3] Documentation: netlink: add a YAML
 spec for team
Message-ID: <20231214111415.7ccf2990@kernel.org>
In-Reply-To: <ZXp8Elbqfxuum01g@Laptop-X1>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
	<20231213084502.4042718-2-liuhangbin@gmail.com>
	<20231213081818.4e885817@kernel.org>
	<ZXp8Elbqfxuum01g@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 11:52:50 +0800 Hangbin Liu wrote:
> > Oh my. Does it actually take team-ifindex or its an op with no input
> > and no output?  
> 
> No, it doesn't take team-ifindex. It's an option with no input
> and just reply the team_nl_family.
> 
> I added this reply attribute just to make sure the TEAM_CMD_NOOP show in the
> cmd enum to not break uAPI.

Another todo for the codegen, I guess.

