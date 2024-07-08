Return-Path: <netdev+bounces-109889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E564992A305
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2283F1C20404
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58980BE5;
	Mon,  8 Jul 2024 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE22W8LS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3958003A;
	Mon,  8 Jul 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442482; cv=none; b=uW/L64vsGwhhQ1kytWh0knLDSjuNDJYm/DJ1V3Erl4h6GbdANbRWFU/X0NS+jeDkUbl8D7v4PJliY2k8UOQH5PJIRBFkyT7MgmjyX8ClAbh0mYhtNnF9ZGIr00KlUj+LKxR3cXk0QGppeIDaxwewS1D/6/iZO/XHPlLVZHIaDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442482; c=relaxed/simple;
	bh=impr+NxFXb/SzzQ/WN7mJ3oYYmIPSfKlOWITJE5lKD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6juXLLox+eI3SysI4d1dROHAn/9wtqDiqE+PlmxA/scUGBW+C5GxdTR9buxRtnZqGKdrKPchsam44dkodjG3+WuqhZMWKPWy3lb1/laUqsNf+z4XXyxVOcUB2XCtFUHcXNZ/QpBiFC8nfK6N0naJYzHbqXrQVt5iN2rhuooiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE22W8LS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C89C116B1;
	Mon,  8 Jul 2024 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720442481;
	bh=impr+NxFXb/SzzQ/WN7mJ3oYYmIPSfKlOWITJE5lKD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NE22W8LSNyZTHz2/F+EPz7wOa8eFUun2Ujd0aeOvGUbL47s8ldvagN4Kbe37lwz2r
	 RZIEOgSopnz52qzFafoaubvphmyD47wQSV10UKQVr1ODgqTyqo34Y1mpRkIg5+74rD
	 QINVd/cDvsqQxnJUGSuBZNHck8e2uLkFXHImbDeFtYHj81oqZTnpqJOMXW2cRpavCr
	 J2LXvKK4lTxc/qyTrCcS8vutzGAVBjXyjFRWcLHugVApNslmLJHX6RdbdF/5g7/3MP
	 0ouUhbcxCRPbaJuryDCBXuS1CCV+9Lsnb+DlAz4Mhc+LGel+OUq9OSAfCSzJj/ePo9
	 SuhhROSOWbotg==
Date: Mon, 8 Jul 2024 13:41:17 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, apw@canonical.com, joe@perches.com,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org, willemb@google.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/6] checkpatch: don't
 complain on _Generic() use
Message-ID: <20240708124117.GO1481495@kernel.org>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
 <20240703125922.5625-2-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703125922.5625-2-mateusz.polchlopek@intel.com>

On Wed, Jul 03, 2024 at 08:59:17AM -0400, Mateusz Polchlopek wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Improve CamelCase recognition logic to avoid reporting on
>  _Generic() use.
> 
> Other C keywords, such as _Bool, are intentionally omitted, as those
> should be rather avoided in new source code.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


