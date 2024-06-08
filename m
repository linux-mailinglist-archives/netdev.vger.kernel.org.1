Return-Path: <netdev+bounces-101996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8234590109E
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 11:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF811C20F50
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DABC12BE91;
	Sat,  8 Jun 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcAGCab2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0EC8D7
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837272; cv=none; b=QKATOp6qzV1q4ALxyLZEgiz3A4RROtJd1jPn76Uy6xuIPC1W0rnprnvKLBcDtow+edr//Urqh+GeUf/j398tDcBqBdXYGvnq9XuVDe32TZzOVyp2iUAXlcM2rAfvDZjrPL4QeT2U/XEQPHFP9vDWYZhRzFB+zr06n1+F67sHWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837272; c=relaxed/simple;
	bh=GqKdDUXNz+JlUYp65Oc6H4LJAef9L1h3fz3R6N0iECI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEgO1noC7zYcsQyUag5tnmRZFD6EOH/S+DmU+M9d9PHv9drWLMJR2KDow9bCvmQFBEz7CjJtXK4XX4gsFP9yUy3yRNYS0S47+uDvRbowOfepXT77IihyUCPxzR+31Rznm4rPon6CYHOQaggLuewPCDShFqV5eLDp6kSclzF/WWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcAGCab2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBD7C2BD11;
	Sat,  8 Jun 2024 09:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837272;
	bh=GqKdDUXNz+JlUYp65Oc6H4LJAef9L1h3fz3R6N0iECI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcAGCab2z9JQdDX2fea0qYdAZqBjbmXJbM2of2QMdgptCFbF8e/e6cA/lJtaMQ4/y
	 gwaYdbFooKhAVMlvksGwpn99LrQUP+ZYBCC/e9C84kMlhZpb6lLYbd4EO/vGYnXb4C
	 y1shvFgrj3JSoXNzhdMMKwk7wmyh+gtwSTI5UebWJQwckt+pOPbsLJaAJyIO0cj3rp
	 NC13b20/Kc9N4vSJaNLWvbJ8uv7dNZTepuJH0IrRCfl+OtFzHvXXQkXRIBJ7647+YW
	 CIER+gE9vd8vm7iBl1mYQOa25O3BUs08qzn0VJE27tFWIA80gRktJVrSr6l4jD0tgC
	 ID3J9JTegHt+g==
Date: Sat, 8 Jun 2024 10:01:07 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Alexander Zubkov <green@qrator.net>, mlxsw@nvidia.com
Subject: Re: [PATCH net 3/6] mlxsw: spectrum_acl_atcam: Fix wrong comment
Message-ID: <20240608090107.GO27689@kernel.org>
References: <cover.1717684365.git.petrm@nvidia.com>
 <2df6368e0908d4e752ab9c74556bf2835762f330.1717684365.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df6368e0908d4e752ab9c74556bf2835762f330.1717684365.git.petrm@nvidia.com>

On Thu, Jun 06, 2024 at 04:49:40PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The key is encoded, not encrypted.
> 
> Fixes: c22291f7cf45 ("mlxsw: spectrum: acl: Implement delta for ERP")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


