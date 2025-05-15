Return-Path: <netdev+bounces-190833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D88CAAB907D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFAA189BA97
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B4263F5E;
	Thu, 15 May 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOqp8xDx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD720E332
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339355; cv=none; b=ku8lSD2W16A8ID9cHiVL5Rbi3WHNsShz2jHMSSBZbyBMOiXr6jfhLf6FXxx7nKv+TlCPVDKfpilucemF8YUDdUE7e765yxTFytmWRXr5lRZJ97n3uidIcN46joaTKlOfb0ww71eHhKvwGaYnyiBlTtcmuAqR3TqQjbNLDdLnkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339355; c=relaxed/simple;
	bh=faEObyMxYfkwccsx+LjjZfjnpOCaiPTiz0+oED1ZxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPKdSKFF64BNJZE4WpOcSAUDe58ZDgC6zREqUgwyT7K4W9uvTexPImK7Zm1F5f/S+ajUmM8gWbzCt/7llslVG7z4vrQJw6xi4srOlJvdkSJr3YFz7I086VSZVzx94A8Pdo9mpvRnJAN1y4XYjyVsi9keiIzA6MjF/mHCGF8EuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOqp8xDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC5DC4CEED;
	Thu, 15 May 2025 20:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747339355;
	bh=faEObyMxYfkwccsx+LjjZfjnpOCaiPTiz0+oED1ZxpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOqp8xDxr5zGRaVYQT2t7J4h6IcX4Plu+uTFCf6NIhzyBHnflcIr/tFa/VP7ouiUK
	 rDPDsZM3fvUg/LP/uvHLUWQSqzdnmMGjAvqAr+p6skJEb3aZQvWvTNQkdiAVb9YwVn
	 dtVPt+vScCEmu6haXCTojEABsOXMqr8mxl63hw6p/7jlG1GXHmJX8kselSErjfx9zy
	 GvkVxWUM1IEi9fM6w7rdYs6aXy02PstQIwESwpokoQm6i5YWoDaiCv+hNxd9ln5M5W
	 7shv8pTbB8+LCt6FQpZwHSW91abn7adhI7+0El/QVZ+4Up1byXfYH9NpIihsb/I0ZE
	 UuUEkxsxIZxrg==
Date: Thu, 15 May 2025 21:02:32 +0100
From: Simon Horman <horms@kernel.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>
Subject: Re: [PATCH iwl-next] ice: add E835 device IDs
Message-ID: <20250515200232.GY3339421@horms.kernel.org>
References: <20250514104632.331559-1-dawid.osuchowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514104632.331559-1-dawid.osuchowski@linux.intel.com>

On Wed, May 14, 2025 at 12:46:32PM +0200, Dawid Osuchowski wrote:
> E835 is an enhanced version of the E830.
> It continues to use the same set of commands, registers and interfaces
> as other devices in the 800 Series.
> 
> Following device IDs are added:
> - 0x1248: Intel(R) Ethernet Controller E835-CC for backplane
> - 0x1249: Intel(R) Ethernet Controller E835-CC for QSFP
> - 0x124A: Intel(R) Ethernet Controller E835-CC for SFP
> - 0x1261: Intel(R) Ethernet Controller E835-C for backplane
> - 0x1262: Intel(R) Ethernet Controller E835-C for QSFP
> - 0x1263: Intel(R) Ethernet Controller E835-C for SFP
> - 0x1265: Intel(R) Ethernet Controller E835-L for backplane
> - 0x1266: Intel(R) Ethernet Controller E835-L for QSFP
> - 0x1267: Intel(R) Ethernet Controller E835-L for SFP
> 
> Reviewed-by: Konrad Knitter <konrad.knitter@intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


