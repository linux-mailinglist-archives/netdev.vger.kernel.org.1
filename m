Return-Path: <netdev+bounces-209485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1129BB0FB20
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 21:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B721CC07A3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F689222564;
	Wed, 23 Jul 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXEklpbb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACD1E9906
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300235; cv=none; b=RVc0b0IL5KuGUQwBZLuRbxCxsnLc0o2A9d2jl3If4qx7RAG1tU2KE25svbOUvDIZQhyPxijBsMm3qXsYz8mBWSGTHvHdETJRoxlq0UxqQ7bE6blcDJ+qC9A/01PsdVuz0Hr3R7yQnMNHAULq0Yi5wLiPPHmLgzMKm0VofGu5UMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300235; c=relaxed/simple;
	bh=LGcjkGATmLPxpS7ECi/3/0+JXTkhYN+AR1f9tzDK3sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AafbQ68KXbJ3qLFM5ElQuXm4CMm9jDxc263F+Uq3XeVr2Vh65opoJ/mIV+UEbgBe14fIwZD/h73RLiAujgxRtAJvyq5O05F6NcU/0zxb+LrMamTsyD2DAIwsNjgJt809zbgE7TkoGbWyzrv1/ajhKxaEnO0Q+l+Wzh8NYURplUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXEklpbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE5FC4CEE7;
	Wed, 23 Jul 2025 19:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753300234;
	bh=LGcjkGATmLPxpS7ECi/3/0+JXTkhYN+AR1f9tzDK3sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXEklpbbz1tX/sWH4sr5sIuFdPCdKy5ivOc5P4MdWN1vntWPag9nEgzjxkfQ2aMJV
	 yz2qW+J5Q0+sAen9aEY2P9dehdzOYmcirGronbeXeVv3IrD/xeDTqUL1wLffAjsyiT
	 O1iDFQnnFGyzdJTwt+I8TuL1C9hB/XfRkT1JbfZ5napwqGwAxcndkY+xs2A5bgc9Lj
	 pyPUO+BGPyhDLiQP0qQyrrFICIwECbU5DbwGfnb9AGWEAPiPfOTKhCpMl7a0piWa7z
	 3jfrLFDrZD8mrqofgVSI5hOosDyliRQhCxFeg2lpZU2fcT35mV+bVS2hMcCC8UXDol
	 zxsTABQkcKt/w==
Date: Wed, 23 Jul 2025 20:50:31 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev@vger.kernel.org, Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Wang Haoran <haoranwangsec@gmail.com>,
	Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Subject: Re: [PATCH] i40e: remove read access to debugfs files
Message-ID: <20250723195031.GN1036606@horms.kernel.org>
References: <20250722-jk-drop-debugfs-read-access-v1-1-27f13f08d406@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-jk-drop-debugfs-read-access-v1-1-27f13f08d406@intel.com>

On Tue, Jul 22, 2025 at 05:14:37PM -0700, Jacob Keller wrote:
> The 'command' and 'netdev_ops' debugfs files are a legacy debugging
> interface supported by the i40e driver since its early days by commit
> 02e9c290814c ("i40e: debugfs interface").
> 
> Both of these debugfs files provide a read handler which is mostly useless,
> and which is implemented with questionable logic. They both use a static
> 256 byte buffer which is initialized to the empty string. In the case of
> the 'command' file this buffer is literally never used and simply wastes
> space. In the case of the 'netdev_ops' file, the last command written is
> saved here.
> 
> On read, the files contents are presented as the name of the device
> followed by a colon and then the contents of their respective static
> buffer. For 'command' this will always be "<device>: ". For 'netdev_ops',
> this will be "<device>: <last command written>". But note the buffer is
> shared between all devices operated by this module. At best, it is mostly
> meaningless information, and at worse it could be accessed simultaneously
> as there doesn't appear to be any locking mechanism.
> 
> We have also recently received multiple reports for both read functions
> about their use of snprintf and potential overflow that could result in
> reading arbitrary kernel memory. For the 'command' file, this is definitely
> impossible, since the static buffer is always zero and never written to.
> For the 'netdev_ops' file, it does appear to be possible, if the user
> carefully crafts the command input, it will be copied into the buffer,
> which could be large enough to cause snprintf to truncate, which then
> causes the copy_to_user to read beyond the length of the buffer allocated
> by kzalloc.
> 
> A minimal fix would be to replace snprintf() with scnprintf() which would
> cap the return to the number of bytes written, preventing an overflow. A
> more involved fix would be to drop the mostly useless static buffers,
> saving 512 bytes and modifying the read functions to stop needing those as
> input.
> 
> Instead, lets just completely drop the read access to these files. These
> are debug interfaces exposed as part of debugfs, and I don't believe that
> dropping read access will break any script, as the provided output is
> pretty useless. You can find the netdev name through other more standard
> interfaces, and the 'netdev_ops' interface can easily result in garbage if
> you issue simultaneous writes to multiple devices at once.
> 
> In order to properly remove the i40e_dbg_netdev_ops_buf, we need to
> refactor its write function to avoid using the static buffer. Instead, use
> the same logic as the i40e_dbg_command_write, with an allocated buffer.
> Update the code to use this instead of the static buffer, and ensure we
> free the buffer on exit. This fixes simultaneous writes to 'netdev_ops' on
> multiple devices, and allows us to remove the now unused static buffer
> along with removing the read access.
> 
> Reported-by: Kunwu Chan <chentao@kylinos.cn>
> Closes: https://lore.kernel.org/intel-wired-lan/20231208031950.47410-1-chentao@kylinos.cn/
> Reported-by: Wang Haoran <haoranwangsec@gmail.com>
> Closes: https://lore.kernel.org/all/CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com/
> Reported-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
> Closes: https://lore.kernel.org/all/20250722115017.206969-1-a.jahangirzad@gmail.com/
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> I found several reports of the issues with these read functions going at
> least as far back  as 2023, with suggestions to remove the read access even
> back then. None of the fixes got accepted or applied, but neither did Intel
> follow up with removing the interfaces. Its time to just drop the read
> access altogether.

Thanks for the excellent patch description.

Reviewed-by: Simon Horman <horms@kernel.org>

