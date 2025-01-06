Return-Path: <netdev+bounces-155468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CCAA02667
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99C11646DE
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFC91DCB09;
	Mon,  6 Jan 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWEGa8ZM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C473451;
	Mon,  6 Jan 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169800; cv=none; b=WlFEt7Imbq7yOkNQfwqQ4aIc7DirJsY4WEQD0A7eagG4y6BkIeKLvbLj3+w0XyeGHP3xXDJJfF6DKdbEVI+Pbd3hV/CUwdnBb+W0gCIbCsX/zjORn5XmOyhaixR+Zpt9dxEyWeeMiDggcM0A2A4EJ2ZCh7NqjHTZmWv2MPIg99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169800; c=relaxed/simple;
	bh=S69efE5Z81qFKNYp8ibuLNFNkGNJBH86IsF5Hy4J4HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2D57RIC+9WpQjVhj1g5+19XK9totLE7jmH6lNDiyKFHeK6pSZEGp/vgYdM0wr4Dvbek/T4rT64UwFOk53AzqocctFgA863qVOpZcQIcGKM/g19ChVVTMHQjN4jQTS4iN1H1FVbe3vhVG9dzaUBpaYQUYOkmJ+GmDRjpb/6/B7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWEGa8ZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E805C4CED2;
	Mon,  6 Jan 2025 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736169800;
	bh=S69efE5Z81qFKNYp8ibuLNFNkGNJBH86IsF5Hy4J4HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWEGa8ZMbz0UOCwn8yR59V2ebRmD7hqdSdZYfAq3RJ6B5/6Qqa2aS/2H42IWvF0hb
	 E2umXalgS1cRU1xX9/pXIer5+5mmDFaCQAm+Iq63AqSzaXMoUjrVUxAPyM7Arx09xf
	 T6+Fy+ulMvr4JjOXLps47c1WcX6GRbo83TW8ultIe7CoCQWbXeNT2WGNE2kifkLavC
	 u6epOQXk+iX1a5tJc3xF79e54JNuJB1XcwfDc+o1cees24jhh2B82+SoIajQAWLFMO
	 B5uK1yXlwV8mxtdSJypu8+eGuFGQOm+eB65ULPIPTv10lQXRJHdFd7RxVQr9K38z2Y
	 Ns4xte5UyT4RQ==
Date: Mon, 6 Jan 2025 13:23:16 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 2/3] igc: Remove unused igc_read/write_pci_cfg
 wrappers
Message-ID: <20250106132316.GL4068@kernel.org>
References: <20241226165215.105092-1-linux@treblig.org>
 <20241226165215.105092-3-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226165215.105092-3-linux@treblig.org>

On Thu, Dec 26, 2024 at 04:52:14PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> igc_read_pci_cfg() and igc_write_pci_cfg were added in 2018 as part of
> commit 146740f9abc4 ("igc: Add support for PF")
> but have remained unused.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


