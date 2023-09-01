Return-Path: <netdev+bounces-31741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45678FE83
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 15:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150501C20CB2
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA5BE5D;
	Fri,  1 Sep 2023 13:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D79BE5A
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 13:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE03C433C7;
	Fri,  1 Sep 2023 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693575807;
	bh=S1jwN1zV//umF6+/E1V1G1E/k9AQG21vORb5+zuWKQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGMGNeKSbgOHXlgx52/VsCggkXiwztV8/WKypoU34JQhkwRVPek3DPmIIjB7wyDfg
	 FzcgZAsViRb0RoZz1UO8AuD3gSGQvg314cdt2ZsDrh+3rEz0gNQhI0+JXKTFPfvLto
	 8rucs8tkNBJscML9h5R2OnyBF8W7YP25jby7cRtmVYtHsYd32RaPesKCvjB7SvjGwZ
	 gIwbzIWg7HH0TPRof2LvVlrJFmOIW17Lu0r7jomMZHqmmFSH/ESz8oJ09H2N7bDDN8
	 U25kN3OCRu9rzGiZ2gK9AsjFU8JKLZsG7GcSL2V0XEToNngd981IA+PX1OqRB6zwMJ
	 fD5C3lohRx0bw==
Date: Fri, 1 Sep 2023 15:43:17 +0200
From: Simon Horman <horms@kernel.org>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, jesse.brandeburg@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] igb: disable virtualization features on 82580
Message-ID: <20230901134317.GE140739@kernel.org>
References: <20230831121914.660875-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831121914.660875-1-vinschen@redhat.com>

On Thu, Aug 31, 2023 at 02:19:13PM +0200, Corinna Vinschen wrote:
> Disable virtualization features on 82580 just as on i210/i211.
> This avoids that virt functions are acidentally called on 82850.
> 
> Fixes: 55cac248caa4 ("igb: Add full support for 82580 devices")
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

