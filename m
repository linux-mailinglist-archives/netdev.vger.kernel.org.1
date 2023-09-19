Return-Path: <netdev+bounces-34977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538197A64B7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FB228157C
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DCF30FA6;
	Tue, 19 Sep 2023 13:21:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF737C88
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 13:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DC4C433C8;
	Tue, 19 Sep 2023 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695129671;
	bh=1Z0kW/DGgDpDPeGkUwDUCSqodWYaUCAUQITt2HN5PNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ix0deOOgocKBKSIZeif/9sNAj75m9Q/04oE/DWCxUyC6ughDD9uLYgDnk/4cyD9et
	 4/DKqTZKLyNImBDPp4PxdUDJqyJeBWOLwh9krhKLn8o48VDYsil1bl1bQtkknRX9yw
	 YDbDvk4xR9qVztYIpkwQXuAqT6HxL+GmW6P5AykwRxrNIhJ+q0oBBFa8+/lXx9JZC1
	 9ZKFNCNCWARFSeyOStybxcZ6Vyvqwf1yXDU/0B8hoUOugv/Y39d8z2QHaUVS9cV2Wm
	 HyZoRpiA4757IGGKGoZum+AP3yEORdrMyM3eUvDe1gyGEZDEj+i9E10lqC8JbkVZgZ
	 m1Sh/yw/b0Y6A==
Date: Tue, 19 Sep 2023 15:21:08 +0200
From: Simon Horman <horms@kernel.org>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	andrew@lunn.ch
Subject: Re: [PATCH iwl-next v4 0/6] ice: Add basic E830 support
Message-ID: <ZQmgRH+xYSGTQP2X@kernel.org>
References: <20230915150958.592564-1-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915150958.592564-1-pawel.chmielewski@intel.com>

On Fri, Sep 15, 2023 at 05:09:52PM +0200, Pawel Chmielewski wrote:
> This is an initial patchset adding the basic support for E830. E830 is
> the 200G ethernet controller family that is a follow on to the E810 100G
> family. The series adds new devices IDs, a new MAC type, several registers
> and a support for new link speeds. As the new devices use another version
> of ice_aqc_get_link_status_data admin command, the driver should use
> different buffer length for this AQ command when loaded on E830.
> ---
> Resending the original series, but with two patches moved to another
> set [1], which the following series depends on.
> 
> [1] https://lore.kernel.org/netdev/20230915145522.586365-1-pawel.chmielewski@intel.com/


For series,

Reviewed-by: Simon Horman <horms@kernel.org>

