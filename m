Return-Path: <netdev+bounces-155218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4559CA01789
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB00E1883E7E
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE22C9A;
	Sun,  5 Jan 2025 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svPSzJwk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF763184F;
	Sun,  5 Jan 2025 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038482; cv=none; b=Ga+3kHD+7ENe3uySndj0dDSvrhDpQq1aZ1Yi5lgYN6QIwDvUeARgvV+oeVrFEzHv+WU3hIdl9EMo2zJjB3DmVa89pRiYgMulC/CA04cN0EQcLOKT5tjjCcgmYL0zFFs/3JoqYevFG+GYRLXRZTf8IgjxpI1CWM4DLIscxrc1/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038482; c=relaxed/simple;
	bh=veIroVZ6s7mitoVTEozq0rmdy+aNoxJCwz2i5kV2nJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tH0XQb15n0eucYbSR3AiFkyV7kgaIMR+26fgsn3Ye5aQlop077RfBA69WFiC/frmUUWyyTtw+rgr8ZjbYGOvP7agG8twhncXC/g8lsLdoGmvL2FI5rMExqEWMpCtHdHnoKZDYWWnQLa0mQHVq6UoGc0VcFYdUYdBa7jmNi3LaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svPSzJwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1726C4CED1;
	Sun,  5 Jan 2025 00:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736038482;
	bh=veIroVZ6s7mitoVTEozq0rmdy+aNoxJCwz2i5kV2nJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=svPSzJwk0s0RTmGcLanFNqQQyQ2v6PHTSUDo3EUIaV4p2UY/+VzQ0Xa330ZKigx9C
	 ibjwV+lTM1lmt0noJfwr5jDWXM2Kyj72QH0QwKWynuN7DiVJth39E53DoGuI9L8T6B
	 DqZ7wAfh7hhJj86CookGXgoI1i0IggISU+VXZ/O3aSaxtZlwThSHe8K7am8dwZkPVL
	 DoVbrxmWld+kG9tDcMNmkth0W13k+XxbF+kzHXO00gojEeEW8ERw7y1vRKgg5EXRrh
	 MdSQtG8Ww8kmdqpct0kavOBjs3A/Zv4nAB0wFV051Aes2aGuW8G5ezBA1KM4PKRA//
	 716BKCEwWUsfg==
Date: Sat, 4 Jan 2025 16:54:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Message-ID: <20250104165440.080a9c7b@kernel.org>
In-Reply-To: <Z3muiBPv30Dsp8m5@gallifrey>
References: <20250102174002.200538-1-linux@treblig.org>
	<20250104081532.3af26fa1@kernel.org>
	<Z3muiBPv30Dsp8m5@gallifrey>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jan 2025 21:56:24 +0000 Dr. David Alan Gilbert wrote:
> > This one doesn't apply, reportedly.  
> 
> Hmm, do you have a link to that report, or to which tree I should try
> applying it to.

net-next, the tree in the subject prefix:

$ git checkout net-next/main
$ wget 'https://lore.kernel.org/all/20250102174002.200538-1-linux@treblig.org/raw'
Saving 'raw'
$ git am raw
Applying: ixgbevf: Remove unused ixgbevf_hv_mbx_ops
error: patch failed: drivers/net/ethernet/intel/ixgbevf/ixgbevf.h:439
error: drivers/net/ethernet/intel/ixgbevf/ixgbevf.h: patch does not apply
Patch failed at 0001 ixgbevf: Remove unused ixgbevf_hv_mbx_ops

