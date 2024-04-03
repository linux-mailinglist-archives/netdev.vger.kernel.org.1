Return-Path: <netdev+bounces-84434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2082B896EF5
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44221F21612
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319F44C97;
	Wed,  3 Apr 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSLw0WCl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07D224D4
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147914; cv=none; b=S7E4B8BLml1gExPp3vjd9vqU64wcLIa8TQuCrTWOt4KW8liYbER1xZKDsR4YmwKGOti7MG67YDtZESG/xSl3xKqDkaMfp7Patkt5H9aq0ZaOUvK6O+W55rrfpeXkAakjmSJm/VklqLdlBcz/mNQHDytcnUZDTd56VONOaYNfQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147914; c=relaxed/simple;
	bh=+wTy18zqwP8X7l0o/bedbME9wUqjk4WTcFxm5M1bwEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ/rkXJDKnI5Am82YPT8OMbykrtcOja6l8Shiucae2vOysEUjpCeY9fi10yDPsF0WfAWvN7NEG9DYw0UhRCv0Fty424AFpf5LdZf2F+kQDdiFguqL0lnUNJSYyhxK8XQVsbVvfWoSPw4efwl08iUEwPkgunsvkcFp8CzYco+Ypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSLw0WCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4660C433F1;
	Wed,  3 Apr 2024 12:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147913;
	bh=+wTy18zqwP8X7l0o/bedbME9wUqjk4WTcFxm5M1bwEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSLw0WClljJVS66qdCZA7T+AGcKnjmGf+cWnx4qMcLbYAV92+mlfKcPyJtYI0ZuNU
	 UCafburWC3NAVixSnCql7EU5oEwCjMzOaLgSfUZ1qvFzpnAzWp93J+iUPnOpAsy/xh
	 LJXSISCZOJIO4n91M/NqWKs+WVItKw+y4hleUVsvOEeYZjG7PxuPwlTl8fwkP10B0b
	 EeLsMHo9G/uVUIFU2a6D/HCbgQY13rOHvTf6DNHn3lujtqCWxv7KaI9xkkS+2CAlH+
	 lXWuwb0gy7Sx73ey+WxuG92yi2Q4W15IJwFX7v2XD5VIyuVOZuottBzVUYf7kygEGL
	 kyP+YjCVTJb6Q==
Date: Wed, 3 Apr 2024 13:38:29 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 06/15] mlxsw: pci: Make style changes in
 mlxsw_pci_eq_tasklet()
Message-ID: <20240403123829.GB26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <2412d6c135b2a6aedb4484f5d8baab3aecd7b9ae.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2412d6c135b2a6aedb4484f5d8baab3aecd7b9ae.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:19PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> This function will be used later only for EQ1. As preparation, reorder
> variables to reverse xmas tree and return earlier when it is possible, to
> simplify the code.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


