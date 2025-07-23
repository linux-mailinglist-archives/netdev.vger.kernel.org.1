Return-Path: <netdev+bounces-209336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08871B0F3F5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472D4166FD6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BEA283138;
	Wed, 23 Jul 2025 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czJswKmO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141178F3E
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277229; cv=none; b=QDzEGD6c7/+ucvl7mmypneOXl3pOEZmtN+joSG/aXVLibE7zp9CNoD+FBv9lvwIZmg9jX1UXbEJOvZAAryRUSlTTC9w9QNVojVosvRWumrb8AOBQRRqfOGA7M8efzk8Bj0Nrefn1rrZMeXDlH/P0Xq823D4iXc+Z1DcuZ2+nnkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277229; c=relaxed/simple;
	bh=FcBkW1PWRr0/rLVYJ5tzaHVVkfNmrV4Yo3Q/KaTCS7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0hEWxqhsAefzfNEGHBAmXQYn8OWBGl9UX8fu0ZIGNh9XgU3JA1HxuySWl2Hkk7YjERu20MVGTrzctNKnomnIxBqjNr33M/1GzcICRa2MfM1Xk8+KevqjZ7M2+TlSVDFMzmurDOwzJ1wRDBVsyUYLn/M7BYny903cFCZcgkWzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czJswKmO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753277228; x=1784813228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FcBkW1PWRr0/rLVYJ5tzaHVVkfNmrV4Yo3Q/KaTCS7U=;
  b=czJswKmO+PWayuiHEbfCvFn/U5uDd7+HZhw5sToHIVtWCrV98uzDJGDd
   G72AdQA2THPULHwGQs/EXaUYOHjpCTe9puXy0RAAtdabxwL8gPQPxBa1A
   dUQnk6CembDwPtUqAFDoLGUwrTtcBXk0eHI8txkM56wwwkDVmz1nAbeAp
   oVvLloe0SZXIIEl9w+EvChNUDg4Hv/ysTEH6oxRewPnt9DR6K0aPLu4JB
   XN0lwsyTcQg8eDfNRwzjyZavpVMa6LW2DwjDlI9uB2FzRQQTM1GTxt4nj
   3O96G5HnipT0oGm099Jzg0rpnK3str5rgE0Xkle2xM5ykbigLbOlJfzI8
   A==;
X-CSE-ConnectionGUID: dyVEYnmHRsmHOqg2iDjU4w==
X-CSE-MsgGUID: eZFmqVTRTGC6WwurMRFdhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="81004437"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="81004437"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:27:07 -0700
X-CSE-ConnectionGUID: H6Dk170PSSOnvO5YPh+AVg==
X-CSE-MsgGUID: HtA+gSXBSceh0c91zm75nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="158779491"
Received: from jkuryjak-mobl1.ger.corp.intel.com (HELO [10.245.115.185]) ([10.245.115.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:27:04 -0700
Message-ID: <98320a61-0589-4360-925b-448f4637e4df@linux.intel.com>
Date: Wed, 23 Jul 2025 15:26:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] i40e: remove read access to debugfs
 files
To: Jacob Keller <jacob.e.keller@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>, Kunwu Chan
 <chentao@kylinos.cn>, Wang Haoran <haoranwangsec@gmail.com>,
 Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
References: <20250722-jk-drop-debugfs-read-access-v1-1-27f13f08d406@intel.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250722-jk-drop-debugfs-read-access-v1-1-27f13f08d406@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-23 2:14 AM, Jacob Keller wrote:
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

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

