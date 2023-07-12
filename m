Return-Path: <netdev+bounces-17035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F674FDDD
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42841C20F09
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97C138A;
	Wed, 12 Jul 2023 03:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36C810E8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18088C433C9;
	Wed, 12 Jul 2023 03:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689133023;
	bh=CFhAwXGRnZn1sFbKgiF9NFH9FzDSCbiccZUpYUo1XIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zs3C8juz7ohIErM2TpO22jpL0Jv5Sw0uBZTO3HExAKM8jTB3ZU1tBefZPSs52ArF+
	 x3+7XdThAe6fInFJn4g/9VhI/halYPeLF8NnfIK54co+V0edf4V3lMO4asR8fCAfNw
	 vnkL+Q/9U7MOw2WeH67RR1vxlKDx8fIrkBXTy5O42fuikTlHd4FC988SHLjfVU36bR
	 XF+NQco3RRLxOFuTzImgavMOS5ESMzbmetPekFbT+5NvEdWAGgY1/VxTeESMHCs+Jd
	 DoKxHSyJuAg8oMs36M9/XXHEw5qn2cOYqZ8tOuGcLtXk3M3DRV0T4qcYZ1PYJp5pNo
	 WHMFNOhAuE3/A==
Date: Tue, 11 Jul 2023 20:37:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Johannes
 Berg <johannes@sipsolutions.net>, Benjamin Berg <benjamin.berg@intel.com>,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH net 09/12] wifi: mac80211: fix kernel-doc notation
 warning
Message-ID: <20230711203702.001235a4@kernel.org>
In-Reply-To: <20230710230312.31197-10-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
	<20230710230312.31197-10-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 16:03:09 -0700 Randy Dunlap wrote:
> + * @agg: station's active links data

That does not sound right. It'd be better to wait for the WiFi
maintainers to return to get the WiFi bits merged. Can we defer
WiFi patches for now?

