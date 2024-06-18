Return-Path: <netdev+bounces-104642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6899B90DB3A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB232830A2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD9E14D28A;
	Tue, 18 Jun 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFtl/2vs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076221848
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733779; cv=none; b=OJZN/XVfAhIL7zJKXJfASel3LkNLspsVaIo5qxlbBECEwGPie0qDCtApwO7KCX/jwuJIWa2zL54gf1BjN+fUJCJGK/gaxbBZyweMwtplk4c1C5v2jF3D4dM6UHECpveRZY2mDQm0o0HTGT26jdgywU6ji3W92sWigQI1gP7Oqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733779; c=relaxed/simple;
	bh=lC+LxoW/5tD7pV5HCeFcS5FczsvDLZt+VYM4dUkxEuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/3p7QE62OwN/GTaO8lv1aNxfaHhmn7DTI8fQ5tfg8Lf69cGUef56kRzmdfcNo8LTUBQstHgV1KSsohjOy03DlzAbYnxljl3crUjOcTCmT+1L+8VNFACVdonWt7g73eAHvUfi7hvNXSDOIO7VcBe/1OQ9KFC+LWcEZBXXg4Brik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFtl/2vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1992FC3277B;
	Tue, 18 Jun 2024 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718733778;
	bh=lC+LxoW/5tD7pV5HCeFcS5FczsvDLZt+VYM4dUkxEuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFtl/2vsbjvIlzG3CJwoVTPLOvgExdvmFBdGH0ikrGIUNgW1eNLyRZkd1NvlZN4WN
	 BQEVLWkKva5nbrjvxepxMsUyhYXePSUVsVLUo6TBNjToLABm7QE22GfA2NRV1eMZWT
	 5BsLZCCI0ES72F7VsgvPrLEx97dtyhCo6R5OOic7InEtveasbasYvk3pibe22VXRHT
	 CvkwRhmjmB5w5iR1amWfnrhSwNq3t2LJfQorztz9fsV8/M/LByrD3TDDaGvFwWbzd4
	 hRPHK330ArGmH2YszaX05tgixyqMZi/38l5KT2iybeb2JmTACQay+mISh8x0rM31Np
	 CG5IkLc3jc8zA==
Date: Tue, 18 Jun 2024 19:02:55 +0100
From: Simon Horman <horms@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 2/3] net/mlx4_en: Use ethtool_puts to fill
 selftest strings
Message-ID: <20240618180255.GU8447@kernel.org>
References: <20240617172329.239819-1-kheib@redhat.com>
 <20240617172329.239819-2-kheib@redhat.com>
 <20240617172329.239819-3-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617172329.239819-3-kheib@redhat.com>

On Mon, Jun 17, 2024 at 01:23:28PM -0400, Kamal Heib wrote:
> Use the ethtool_puts helper to print the selftest strings into the
> ethtool strings interface.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


