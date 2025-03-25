Return-Path: <netdev+bounces-177333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33384A6F77E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54D0188DE02
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1C2561B5;
	Tue, 25 Mar 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1exCCd1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F322561A2
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903378; cv=none; b=g2YpZc9OMlfmzqS9C+Cx5ZJtv/XlTeMpdcKPqoEkcY9AYdgYpzYvlwHx5LSMGFgALFBnJMc29s1vdCJBzPIjwoOHv9VWw0nEdKM79reDv7aQucyl5ioMr6WIhGXs1CekagpuOE2NmFElMvEpTP5xOtRnbb89XI68rEhvCXJZgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903378; c=relaxed/simple;
	bh=QivTbn7O08VehRorW0PtwACizOffBANon6134iKMcfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgMyoSTg3yUbc2tYf3bV+Z3KuukdgLSmjXtCWG7F+wcrFNqfyauBMvoY8U02lofFnS5eMtoJnqCyq9+8aho1Hp9ygmlGIWvfYRyxZl0eZVa+u7ZkWti/Ot278Jy+ccViPiENueNLmktPXMErqAlcxguM/Swag2efTpNZuwXLDVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1exCCd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047E0C4CEE9;
	Tue, 25 Mar 2025 11:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903378;
	bh=QivTbn7O08VehRorW0PtwACizOffBANon6134iKMcfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G1exCCd1tHUXzd4vtiTWHYw/xQOoyZfd8FqhTk8I0Iihkd7QHTEJg9RFWGVSqwp3j
	 SIJ6XLgua2tkakESBIp0/gne3ebtJCSUb7uXS0TyjjJsQYexIi1GMQJgaUk++a998y
	 p58gl5++7GaV7erz/WgglJ9oUyBTQuWMj8A2H0VYeTcijG73yO4QEFL/uOs/jOE0fv
	 p66ukaToUmqYzgIUWLpVUbcPTRtmP9FpshnkSXDwVd0C+tEiy9Utd97JSrTUJMKODj
	 0Bma4VQ+LsnGxPhn9aiYhtT5GfhFYHjCMeFa13sRArpvy5a5t0JcsqZX+4nK+A4Lhd
	 jcDR+wc3GtINw==
Date: Tue, 25 Mar 2025 04:49:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 parav@nvidia.com
Subject: Re: [PATCH net-next v2 3/4] devlink: add function unique identifier
 to devlink dev info
Message-ID: <20250325044929.5b3947c6@kernel.org>
In-Reply-To: <20250320085947.103419-4-jiri@resnulli.us>
References: <20250320085947.103419-1-jiri@resnulli.us>
	<20250320085947.103419-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 09:59:46 +0100 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Presently, for multi-PF NIC each PF reports the same serial_number and
> board.serial_number.
> 
> To universally identify a function, add function unique identifier (uid)
> to be obtained from the driver as a string of arbitrary length.

We need more explanation for the "why"; this:

+   * - ``function.uid``
+     - Function uniqueue identifier.
+
+       Vendor defined uniqueue identifier of a function.

is really below bar in terms of documentation.

